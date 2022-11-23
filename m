Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6663675F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiKWRjF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 12:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbiKWRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:39:03 -0500
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52D55657A;
        Wed, 23 Nov 2022 09:38:59 -0800 (PST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 78D211234CB;
        Wed, 23 Nov 2022 18:38:57 +0100 (CET)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 623A8121C79;
        Wed, 23 Nov 2022 18:38:57 +0100 (CET)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Wed, 23 Nov 2022 18:38:57 +0100 (CET)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 23 Nov
 2022 18:38:56 +0100
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Wed, 23 Nov 2022 18:38:56 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>
Subject: [PATCH] mmc: block: remove non-data R1B ioctl workaround
Thread-Topic: [PATCH] mmc: block: remove non-data R1B ioctl workaround
Thread-Index: Adj/YjUrXkzlUmHATlmcTHF+6XwQXw==
Date:   Wed, 23 Nov 2022 17:38:56 +0000
Message-ID: <dd632a86fb924b019d1a009b17eb3cbc@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.4.23]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27282.001
X-TMASE-Result: 10-4.657200-10.000000
X-TMASE-MatchedRID: ge9e+QLSeayzwwnlAhUjjJAk4Vz6rKorI64EUz6lBagHMdltgqikB9AY
        WUo4HSIkhw5E/ZidsH8ep5R/z/M+R+ztpCSqSkXKSHCU59h5KrHVBDonH99+Vtm24hViZXUPKJp
        KpGmR8G37pkcZlMac521ZdkOX+yj7BXY0oXpqJ14ReM8i8p3vgEyQ5fRSh265855M88ee2L/ovF
        l9K5XN2X69Y7ea2kurrCdjRFVGO+toMCLywE0ygQtuKBGekqUpI/NGWt0UYPDKS2C7UIL4TmvpM
        +0rLfKmp6aDqxA3fahFehRbIllwo+0DVTpPbBPr
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 4509e344-abd3-486d-bfc7-c1c6ea2d3b2a-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workaround of pretending R1B non-data transfers are
data transfers in order for the busy timeout to be respected
by the host controller driver is removed. It wasn't useful
in a long time.

Initially the workaround ensured that R1B commands did not
time out by setting the data timeout to be the command timeout
in commit cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl").
This was moved inside of an if clause with idata->buf_bytes being set
in commit 4d6144de8ba2 ("mmc: core: check for zero length ioctl data").
This patch intends to fix the issuing of R1B data command CMD24.
Its data timeout was being overwritten with 0 because cmd_timeout
wasn't set at the point the workaround applied, but data_timeout was.
But since the workaround was now inside of the idata->buf_bytes clause
and intended to fix R1B non-data transfers that do not have buf_bytes
set we can also remove the workaround altogether.

Fixes: cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl")
Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index db6d8a099910..20da7ed43e6d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -514,19 +514,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		if (idata->ic.data_timeout_ns)
 			data.timeout_ns = idata->ic.data_timeout_ns;
 
-		if ((cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
-			/*
-			 * Pretend this is a data transfer and rely on the
-			 * host driver to compute timeout.  When all host
-			 * drivers support cmd.cmd_timeout for R1B, this
-			 * can be changed to:
-			 *
-			 *     mrq.data = NULL;
-			 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
-			 */
-			data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
-		}
-
 		mrq.data = &data;
 	}
 
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

