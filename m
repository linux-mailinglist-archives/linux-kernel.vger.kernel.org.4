Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5E6ED251
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjDXQWM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:22:10 -0400
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C62F7682;
        Mon, 24 Apr 2023 09:22:08 -0700 (PDT)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 87AF7222951;
        Mon, 24 Apr 2023 18:22:06 +0200 (CEST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7355C2225AC;
        Mon, 24 Apr 2023 18:22:06 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail6.swissbit.com (Postfix) with ESMTPS;
        Mon, 24 Apr 2023 18:22:06 +0200 (CEST)
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     ulf hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] mmc: queue: ensure error propagation for non-blk
Thread-Topic: [PATCH] mmc: queue: ensure error propagation for non-blk
Thread-Index: Adl2xsdYtFja5ytvTvyF17/lcuh7dQ==
Date:   Mon, 24 Apr 2023 16:22:05 +0000
Message-ID: <1d8ce997934c4395bb5dd235525bf7a2@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27586.000
X-TMASE-Result: 10--1.863700-10.000000
X-TMASE-MatchedRID: GegCmeQgyY5A+YmEQEhsujz6L+U/pejx1QQ6Jx/ffla4n9bqPhfH20mo
        bOLhIyMmZX2hfwUP7YpvtPtMpliQxdAy2LXTI7g3EXjPIvKd74BMkOX0UoduuSxMw0FMkBlZnvu
        lBJY7sZvi8zVgXoAltu339GNyKR8aC24oEZ6SpSkj80Za3RRg8KiVP4VLL8ChQv8bOiTBfk31he
        RrqmEGW4uV9Sql14RLrP2oEAEBXfg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 188d4078-3282-414d-923f-36a7f32a4dfa-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requests to the mmc layer usually come through a block device.
The exceptions are the RPMB chardev and debugfs, which issue their
own blk_mq requests through blk_execute_rq and do not query
the BLK_STS error but the mmc-internal drv_op_result.
This patch ensures that drv_op_result is set as error whenever
a BLK_STS error is set.

The behavior leads to a bug where the request never sees the error,
e.g. by directly erroring out at mmc_blk_mq_issue_rq if
mmc_blk_part_switch fails. The ioctl caller of the rpmb chardev then
can never see the error and thus may assume that their call executed
successfully when it did not.

While always checking the blk_execute_rq return value would be
advised, let's eliminate the error completely by always setting
drv_op_result in case of a BLK_STS error.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index b396e3900717..8240962e28f3 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -334,6 +334,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		WRITE_ONCE(mq->busy, false);
 	}
 
+	/* Ensure request error propagates to non-blk callers, too. */
+	if (!req_to_mmc_queue_req(req)->drv_op_result && ret)
+		req_to_mmc_queue_req(req)->drv_op_result = ret;
 	return ret;
 }
 
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

