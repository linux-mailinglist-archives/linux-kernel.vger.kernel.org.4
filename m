Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624EC6283E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiKNP3e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Nov 2022 10:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbiKNP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:29:08 -0500
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082FC24962;
        Mon, 14 Nov 2022 07:29:02 -0800 (PST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 3217A1230E8;
        Mon, 14 Nov 2022 16:29:01 +0100 (CET)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 21F79120790;
        Mon, 14 Nov 2022 16:29:01 +0100 (CET)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Mon, 14 Nov 2022 16:29:01 +0100 (CET)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 14 Nov
 2022 16:29:00 +0100
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Mon, 14 Nov 2022 16:29:00 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
Subject: [PATCHv2 1/3] block: Requeue req as head if driver touched it
Thread-Topic: [PATCHv2 1/3] block: Requeue req as head if driver touched it
Thread-Index: Adj4PXuDZfY1WtSKRa+v2dLTyrmYTw==
Date:   Mon, 14 Nov 2022 15:29:00 +0000
Message-ID: <2c8d249c6bb74d688a625654559bacbb@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27264.000
X-TMASE-Result: 10--6.185200-10.000000
X-TMASE-MatchedRID: dwNgap4H9hget1TxvngNg/ZNLVgVojn/9v33UW8WNYDIgofMgahPrccI
        2NN8y25x99RfPuwPDMiWnP12ew6mUUD5iYRASGy630kDaWZBE1QbVzFi+tzvL/Jdr/uA7ez9InV
        hPozbL+l1UTTFSIyEQhLzQdapWbf8S8HyT+bcVCpO5y1KmK5bJRSLgSFq3TnjoxCLfriDzzh56/
        J0VoTFPbvefB/iWELMdZWyEkHMiANJI5ZUl647UBM0JxSxHjFJ3QfwsVk0UbtuRXh7bFKB7vts2
        wqf9xJ4aWfS/64JbSctl/noW5MuQKYt2j5uobqalExlQIQeRG0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: eefad72f-5701-42d5-9167-65d0d841a444-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the driver set RQF_DONTPREP flag, requeue the request as head as
it is likely that the backing storage already had a request to an
adjacent region, so getting the requeued request out as soon as possible
may give us some performance benefit.

The are various reasons a driver may requeue a request
(and therefore RQF_DONTPREP being set).
One reason may be that the driver or the hardware cannot satisfy
the block layer alignment/sizes.

This for example is the case with mmcblk with a host driver that
cannot deal with multiple block transfers.
Consider a request for lba 42 for one page so 4K or 8 blocks.
mmcblk will do a single block request for lba 42 and requeue for
the rest if the host can only perform single block transfers.
In this case the device only delivered 512 bytes of data at lba 42,
but may have performed a readahead itself for the following lbas,
or do an 'implicit' readahead as it only deals with larger block
size mappings itself.
In that case it would be beneificial if the request for lba 43 and
the rest of the remaining blocks follow immediately after the initial
lba 42 request.
Requeueing already partially processed requests as head preserves the
intended request order (unless the driver has a queue of its own)
and therefore mitigates this problem .

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
-v2: Extended commit message with example use case, no code change

 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33292c01875d..d863c826fb23 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1429,7 +1429,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		 * merge.
 		 */
 		if (rq->rq_flags & RQF_DONTPREP)
-			blk_mq_request_bypass_insert(rq, false, false);
+			blk_mq_request_bypass_insert(rq, true, false);
 		else
 			blk_mq_sched_insert_request(rq, true, false, false);
 	}
-- 
2.37.3
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

