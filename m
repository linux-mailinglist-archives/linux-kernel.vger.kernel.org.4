Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52841750A43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjGLOA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjGLOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:00:23 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A01724
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=tWAvwc/1HXdaph
        CXYElAo38lWuIUp7aM0bJk2JX8zLg=; b=FYndmBHcDwoFQ+0nmBSCs+awo184Yo
        jELUZkJrLaK88ralN3vNp/3Zl8TOXlOEaEdTB2fa0UeGzp/gy7rv9hDIqSJikZZ0
        Fw4+TzJ/Y9pGK9SOyZfuX8xn44stQ4lJvB4M6S4Bae96kcZDs9LnTnuhEiS4oYfw
        V2qwS8FjJ5ewU1L/Ms3O0eBelhkHjqZzsxwslWiDmX7ix0vj/19fuW7Bj5VOk0Y1
        us0+6LPC+XeobJc7xYsGLRIsh21DCebjXrMqx6IZT79pt/iqeE5Oiz+3tTvnccEc
        tMHFZkioPLg4LZFDcVVCx6/sJj6S/74/TVOL8kYHFWiTl2vRh4LMS5hw==
Received: (qmail 1635945 invoked from network); 12 Jul 2023 16:00:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 16:00:18 +0200
X-UD-Smtp-Session: l3s3148p1@Uc++okoA+poujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: renesas_sdhi: register irqs before registering controller
Date:   Wed, 12 Jul 2023 16:00:11 +0200
Message-Id: <20230712140011.18602-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQs should be ready to serve when we call mmc_add_host() via
tmio_mmc_host_probe(). To achieve that, ensure that all irqs are masked
before registering the handlers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
---

Additionally tested on a Renesas Ebisu board (R-Car E3).

Changes since v1:
* refactored setting sdcard_irq_mask_all (Thanks Geert!)
* added tag

 drivers/mmc/host/renesas_sdhi_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 345934e4f59e..2d5ef9c37d76 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1006,6 +1006,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
 		host->sdcard_irq_mask_all = TMIO_MASK_ALL_RCAR2;
 		host->reset = renesas_sdhi_reset;
+	} else {
+		host->sdcard_irq_mask_all = TMIO_MASK_ALL;
 	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -1100,9 +1102,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
 	}
 
-	ret = tmio_mmc_host_probe(host);
-	if (ret < 0)
-		goto edisclk;
+	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
 
 	num_irqs = platform_irq_count(pdev);
 	if (num_irqs < 0) {
@@ -1129,6 +1129,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			goto eirq;
 	}
 
+	ret = tmio_mmc_host_probe(host);
+	if (ret < 0)
+		goto edisclk;
+
 	dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), &res->start, host->mmc->f_max / 1000000);
 
-- 
2.30.2

