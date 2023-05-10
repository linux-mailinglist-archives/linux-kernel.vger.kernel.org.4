Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5336B6FDEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjEJNrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjEJNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:46:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE67CAD39
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:46:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643846c006fso7692414b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683726371; x=1686318371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RM5yV3fF5gKE56bxc1cOV79hli7f8DGGaV04Y7Q5Cb8=;
        b=QfVoNHjWXMTP4GR1BsI1CRB6+mtvIe2OlpcUNSt239/K+wgCQzVGXSXWl7/euDulMg
         2gB1dUuX2Xcae3Bqf4bU7j3PWIOCK/wGPLV5K0WIkQ7EOzeGtL0ZlwBNYLwHEyqFcwlO
         rN7JOUKCM/Hqg2SdHLJJcPDluwN94UGc5T0fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726371; x=1686318371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RM5yV3fF5gKE56bxc1cOV79hli7f8DGGaV04Y7Q5Cb8=;
        b=NSpSN6aFQgM2pBja9RLRqgNvqnu4PDBT2w0++ZP7VVWWn3agPLC2Yceek5hHzHUesc
         JLDsDnxMORcG/trzpps+Eg9hHtD49IqnRIyKjVN+myQukXUto6prbCsMh1zy388WftSw
         8YKqdwTbJH4J1eFLofoJPsdyQqDath2+WROTtpp0SFHSeNI8JTrmnNy1S8C0lORM+cV5
         K7sThFbH6coX5vq0VwW7yexUPNcNQRLpHdZLEoJb4c9w5u9YfAMIBlLPCpt520BTqKyL
         3XodAKPL5pRrGCr5XsBONt+Pv5bedICfON4ufaBJLDyAu2zSgLq+oIX525XvN8tpMh2k
         biyg==
X-Gm-Message-State: AC+VfDzFe2ka7lh3E4kqq1knXW8u4QbXa9CnlFtD2mDCIaKzi7hjxxqN
        WK9BMXNkMyGemQnqzds3sqHa4A==
X-Google-Smtp-Source: ACHHUZ7pR7D7PmBS45weghaimrr9QW7i0Q9nBwX5lYK5EAyr/YfSAnFEMC9PG2+2idXRHobnZd/E1Q==
X-Received: by 2002:a05:6a00:14ce:b0:640:f313:efba with SMTP id w14-20020a056a0014ce00b00640f313efbamr24169070pfu.19.1683726371653;
        Wed, 10 May 2023 06:46:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2ae3:7297:fad0:1ee3])
        by smtp.gmail.com with ESMTPSA id t23-20020a62ea17000000b0063d2dae6243sm3545251pfh.115.2023.05.10.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 06:46:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Mao <yong.mao@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: mediatek: Avoid ugly error message when SDIO wakeup IRQ isn't used
Date:   Wed, 10 May 2023 06:44:54 -0700
Message-ID: <20230510064434.1.I935404c5396e6bf952e99bb7ffb744c6f7fd430b@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I boot a kukui-kodama board, I see an ugly warning in my kernel
log:
  mtk-msdc 11240000.mmc: error -ENXIO: IRQ sdio_wakeup not found

It's pretty normal not to have an "sdio_wakeup" IRQ defined. In fact,
no device trees in mainline seem to have it. Let's use the
platform_get_irq_byname_optional() to avoid the error message.

Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index edade0e54a0c..8ce864169986 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2707,7 +2707,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	/* Support for SDIO eint irq ? */
 	if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps & MMC_PM_KEEP_POWER)) {
-		host->eint_irq = platform_get_irq_byname(pdev, "sdio_wakeup");
+		host->eint_irq = platform_get_irq_byname_optional(pdev, "sdio_wakeup");
 		if (host->eint_irq > 0) {
 			host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
 			if (IS_ERR(host->pins_eint)) {
-- 
2.40.1.521.gf1e218fcd8-goog

