Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCBC66C2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjAPOxb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Jan 2023 09:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjAPOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:52:28 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754172BF32;
        Mon, 16 Jan 2023 06:38:56 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 49B563A1757;
        Mon, 16 Jan 2023 15:38:55 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 323C63A16BB;
        Mon, 16 Jan 2023 15:38:55 +0100 (CET)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Mon, 16 Jan 2023 15:38:55 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: block: workaround long ioctl busy timeout
Thread-Topic: [PATCH] mmc: block: workaround long ioctl busy timeout
Thread-Index: Adkpq3tb+gXfT/KXQXawlvtJeLUDVw==
Date:   Mon, 16 Jan 2023 14:38:53 +0000
Message-ID: <68590206e8b044a2a71457cbbeda0794@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27390.000
X-TMASE-Result: 10--8.216100-10.000000
X-TMASE-MatchedRID: h20DFeLkM893uQV78MmZxh1kSRHxj+Z5FlIP4ZuPPcgvfU/riSJXkdko
        t/+2LaVUIvrftAIhWmLy9zcRSkKatfIBX+jDfXGr9k0tWBWiOf9vk3JiXDj4ddgJ+YNQuvvyWRC
        IX/LXQb6N93YyrucDM39T5imd/2HNDXVj0zMhpTY+EW3T0xru/EsY9G/RZ3FCmyiLZetSf8kTGR
        upINaDDx9GgLAHOBFiIAcCikR3vq/205AQ33Ah3CSWTvfMopWv4Ut13rPkKW5t8v8Cp/gu40/Ft
        YU9NC8y
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: a700dd83-0a62-415b-abe4-eb352c300a78-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioctl interface allowed to set cmd_timeout_ms when polling for
busy on R1B commands. This was often limited by the max hw timeout
so work around it like for the sanitize command.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 20da7ed43e6d..ba3bc9014179 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -472,6 +472,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct scatterlist sg;
 	int err;
 	unsigned int target_part;
+	unsigned int busy_timeout = MMC_BLK_TIMEOUT_MS;
+	int poll_prog = false;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
@@ -493,6 +495,12 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	cmd.opcode = idata->ic.opcode;
 	cmd.arg = idata->ic.arg;
 	cmd.flags = idata->ic.flags;
+	/* R1B flag might be removed here to work around hw, so save it */
+	poll_prog = (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B);
+	busy_timeout = idata->ic.cmd_timeout_ms ? :
+		MMC_BLK_TIMEOUT_MS;
+	if (poll_prog)
+		mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout);
 
 	if (idata->buf_bytes) {
 		data.sg = &sg;
@@ -596,7 +604,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+	if (poll_prog) {
 		/*
 		 * Ensure RPMB/R1B command has completed by polling CMD13 "Send Status". Here we
 		 * allow to override the default timeout value if a custom timeout is specified.
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

