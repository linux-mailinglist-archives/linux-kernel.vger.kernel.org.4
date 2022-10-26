Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6460DC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiJZHbI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Oct 2022 03:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiJZHa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:30:56 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A73645E7;
        Wed, 26 Oct 2022 00:30:45 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 81D5746300B;
        Wed, 26 Oct 2022 09:30:43 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 6FF30462F57;
        Wed, 26 Oct 2022 09:30:43 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Wed, 26 Oct 2022 09:30:43 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 26 Oct
 2022 09:30:43 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Wed, 26 Oct 2022 09:30:43 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCH 2/3] mmc: block: Limit queue size for consecutive requeues
Thread-Topic: [PATCH 2/3] mmc: block: Limit queue size for consecutive
 requeues
Thread-Index: AdjpDFCUhEcLNslaTyCpqjy/WRFg1Q==
Date:   Wed, 26 Oct 2022 07:30:42 +0000
Message-ID: <3dd3f33e5cc44657bcc2ebedc6d9dd2f@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27224.006
X-TMASE-Result: 10--5.836500-10.000000
X-TMASE-MatchedRID: mIinBA9F1pwet1TxvngNgwzi9ePw0R3QajzNTFMlQCO+qOvnr0wlxY16
        Nb+wd14Qbl983Sq5pJeLZQCmElUWARFCTluKaxHxTuctSpiuWyUUi4Ehat05499RlPzeVuQQghU
        rQpNGkuDi8zVgXoAltnS4vQrt84k3IAcCikR3vq/6y90BhXIDKmClRxG2GXwUzMjDTijVc9B9M7
        imkCdZsOPwTp3D3CU0
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 0c6dfd2d-d8dd-4e82-a8ba-67a22aba986d-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case mmcblk relies on requeueing to fulfill block layer requests due to
hardware or driver restricting the max_blk_count to 1 also limit the
hardware queue size to 1 to get consecutive accesses instead of a
round-robin on all queued reads.

See SDHCI_QUIRK_NO_MULTIBLOCK for such a restriction.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index fefaa901b50f..3a20f3933502 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -425,6 +425,8 @@ struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	if (host->cqe_enabled && !host->hsq_enabled)
 		mq->tag_set.queue_depth =
 			min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
+	else if (host->max_blk_count == 1)
+		mq->tag_set.queue_depth = 1;
 	else
 		mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
 	mq->tag_set.numa_node = NUMA_NO_NODE;
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

