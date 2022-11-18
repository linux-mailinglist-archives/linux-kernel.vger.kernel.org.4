Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503BB62EDF0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiKRGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiKRGxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC6F82BCB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a14so7839814wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPzrJRHCDt3P+3RkbJsC0jXYdQ1uocNV+USVwUW4eak=;
        b=HvETn9xzbLQonv/zzcW931tCvCJdlKMj1FCn5FQBR816UmZ7gjZ0girMyWGBlnaFIs
         IvtwyhSwn1k7COCEr10lCbRJijmWz0QIy0sqp5H7QJdsnV3b0MO4ww3v2/y+VxF39ai+
         9Sik2KLmXMSBI6n5NiFX2wH1/NiSySmIziAPVCZrHOJOyfFXKO6rX8qK4MWYOEUVDZUm
         GX4Y1IiKY5MJhxQgmFPV0QXH+V7SYaygM9ZLZ6fle/AC+a5TFvfxVeXzXKUNIh6oBb8n
         Cua63gT8fbAtjl/9oC3Xuk489HRefSy7qDGH1VgaQt4w0rDfXAvbPtoD/AbzZ0+5MaoB
         +LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPzrJRHCDt3P+3RkbJsC0jXYdQ1uocNV+USVwUW4eak=;
        b=Kq6UBsUm2HdBdaiaCAj+iEA8v6RyhqGauicO2/FHl1HNkVcrkM5XkmRmNL2Ddv14Rx
         Uu2GT2gakWCZi3oCb0onjOrOdYoJss4oqywqUndQBQU2GpHAccY0h7dG7qVSrzslDesf
         W1K9ptAFTmtXyVHK32UyzwMBNMBKlHZUt7uPWlBbm+sHm39SUKZH07oXSk9lYHc4kk9T
         8Zj85GleuZcX7ow6JYPOXTKAmO6skY26B/iZ4dY0OROYoo4nMzNZVv+yN6LeecOrIdyj
         JlR9fLknLO0CPq97qPhtIeeEA9q/XPRUklau2Wo+XehUCc6DiHVb7l6XFSUTvDmH46mo
         uurg==
X-Gm-Message-State: ANoB5pm54hhlGqRiVHISnZ7PQHPKfpurnNFXPCNJRbA8jiiZUNAYkMQ7
        d2/1Q3/F1ApG4WZjSmCWHVocXg==
X-Google-Smtp-Source: AA0mqf71b6ERwyGagKSL41BuoQKKdeXOnbwZ++0E/Qi3qbxI/YHyitAL6KpHlMIBzW+W/zT3BDz9mA==
X-Received: by 2002:a5d:4d0b:0:b0:236:c206:fd6b with SMTP id z11-20020a5d4d0b000000b00236c206fd6bmr3447814wrt.56.1668754375634;
        Thu, 17 Nov 2022 22:52:55 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/12] slimbus: qcom-ngd-ctrl: check for device runtime PM status during ISR
Date:   Fri, 18 Nov 2022 06:52:35 +0000
Message-Id: <20221118065246.6835-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
References: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Slimbus core interrupt is getting fired after suspend. At this point
ADSP slimbus hardware is off with gated clocks which is leading to an
unclocked access when HLOS slimbus tried to read the interrupt
status register in the ISR.

Co-developed-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 76c5e446d243..964adf77b51b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -763,7 +763,14 @@ static irqreturn_t qcom_slim_ngd_interrupt(int irq, void *d)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = d;
 	void __iomem *base = ctrl->ngd->base;
-	u32 stat = readl(base + NGD_INT_STAT);
+	u32 stat;
+
+	if (pm_runtime_suspended(ctrl->ctrl.dev)) {
+		dev_warn_once(ctrl->dev, "Interrupt received while suspended\n");
+		return IRQ_NONE;
+	}
+
+	stat = readl(base + NGD_INT_STAT);
 
 	if ((stat & NGD_INT_MSG_BUF_CONTE) ||
 		(stat & NGD_INT_MSG_TX_INVAL) || (stat & NGD_INT_DEV_ERR) ||
-- 
2.25.1

