Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1DE639C1B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK0Rql convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Nov 2022 12:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0Rqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:46:40 -0500
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBCF2AFD;
        Sun, 27 Nov 2022 09:46:39 -0800 (PST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7DEC8462DF8;
        Sun, 27 Nov 2022 18:46:37 +0100 (CET)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 65A12462CB0;
        Sun, 27 Nov 2022 18:46:37 +0100 (CET)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Sun, 27 Nov 2022 18:46:37 +0100 (CET)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Sun, 27 Nov
 2022 18:46:34 +0100
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Sun, 27 Nov 2022 18:46:31 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: [PATCHv2] mmc: block: remove non-data R1B ioctl workaround
Thread-Topic: [PATCHv2] mmc: block: remove non-data R1B ioctl workaround
Thread-Index: AdkCh3a7sIwrh5hoQz+Zy+s4Y1pY7g==
Date:   Sun, 27 Nov 2022 17:46:31 +0000
Message-ID: <57d4aceb25254e448bd3e575bd99b0c2@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.27]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27290.001
X-TMASE-Result: 10-3.063300-10.000000
X-TMASE-MatchedRID: ge9e+QLSeayzwwnlAhUjjJAk4Vz6rKorI64EUz6lBagHMdltgqikB9AY
        WUo4HSIkhw5E/ZidsH8ep5R/z/M+R+ztpCSqSkXKSHCU59h5KrFN8rmPQRlvK8Oo7r/xHr1AI5W
        zPQsv3Ab0YXQzpNvE/PIJkbMX4M4J4FG4Cyz4VuYReM8i8p3vgEyQ5fRSh265Br7dUnIrjPa1jg
        3WdTw5hP+vfH78Rkg8fyYDewMOrQD1mZy4fIajlN0H8LFZNFG7bkV4e2xSge6XEvaNMPu9HE2mS
        xF9S6Y3qlCCc6FqnAnn0KIoDyQXF+ulxyHOcPoH
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 0f04465c-3f33-471b-8334-5574cfacee4b-0-0-200-0
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
Since the workaround is now inside of the idata->buf_bytes clause
and intended to fix R1B non-data transfers that do not have buf_bytes
set we can also remove the workaround altogether.
Since there are no data transfer invoking R1B commands this was dead
code.

Fixes: cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl")
Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
-v2: clarified commit message, no code change
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

