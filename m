Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9142774D89B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGJOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjGJOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:09:10 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E4E123
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=iNzNDD5W5pPBSK
        U0n/acKnkO5UiphrUtev01tlu21FI=; b=EB60NbhgFX5/WtalbJ117dKcJh9FD/
        qsrqRyy8aYo9csnEPNEYC4sWdea87vQIsp40wytcHA9RKxzwsAByrHooD/ulh6lN
        H6tI3Ph99KyuvranQAKskZKNffsP0gF8zwQV4U/UPdEFcfNX8DCjYmtMt7OoFBKt
        pMOe0+qaZrB0+uyGsbHDEuJ8XDK60M+3N050NkHepBHvsxCuigVQFkeOQdaWjXkB
        ABb2LtLAR1FuY7RAQJ5X6upL3kSfVDbH1O28DdGP4nXSz0AYu+rxYFgz2vGqcRDI
        tARUXKF8wdx0o8fYPpvzJJ51mEUJj9dEn6Y1TMqr3CPf+h3+e9rsr2yA==
Received: (qmail 936683 invoked from network); 10 Jul 2023 16:08:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jul 2023 16:08:42 +0200
X-UD-Smtp-Session: l3s3148p1@QC2ahCIA/IMqAjAyAhFxdwAj+2Ptlp2z
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT] mmc: renesas_sdhi: register irqs before registering controller
Date:   Mon, 10 Jul 2023 16:08:25 +0200
Message-Id: <20230710140825.47793-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQs should be ready to serve when we call mmc_add_host() via
tmio_mmc_host_probe(). To achieve that, ensure that all irqs are masked
before registering the handlers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Based on 6.5-rc1 with bf54dec9e953 ("Revert "mmc: Revert "mmc: core:
Allow mmc_start_host() synchronously detect a card") reverted. That base
alone shows the regression. This patch works fine on a Salvator-X with a
M3-W. I'll test more boards. Yet, I send it out so people can tests with
boards I don't have.

 drivers/mmc/host/renesas_sdhi_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 345934e4f59e..499d043f034f 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1004,10 +1004,11 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.start_signal_voltage_switch =
 			renesas_sdhi_start_signal_voltage_switch;
 		host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
-		host->sdcard_irq_mask_all = TMIO_MASK_ALL_RCAR2;
 		host->reset = renesas_sdhi_reset;
 	}
 
+	host->sdcard_irq_mask_all = TMIO_MMC_MIN_RCAR2 ? TMIO_MASK_ALL_RCAR2 : TMIO_MASK_ALL;
+
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
 	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
 		host->bus_shift = 1;
@@ -1100,9 +1101,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
 	}
 
-	ret = tmio_mmc_host_probe(host);
-	if (ret < 0)
-		goto edisclk;
+	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
 
 	num_irqs = platform_irq_count(pdev);
 	if (num_irqs < 0) {
@@ -1129,6 +1128,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			goto eirq;
 	}
 
+	ret = tmio_mmc_host_probe(host);
+	if (ret < 0)
+		goto edisclk;
+
 	dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), &res->start, host->mmc->f_max / 1000000);
 
-- 
2.35.1

