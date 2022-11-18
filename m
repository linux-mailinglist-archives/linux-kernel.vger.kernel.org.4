Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BBC62EDF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiKRGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiKRGxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96083781AB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a14so7840263wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvK1CKtw7MwQ4Y9/FEnTL05j5til5XvswsA9Bqzc+bI=;
        b=wb1Um3NaG3cnMicDFFzoHcVHM7Jr/19k2ZYEEFqR9GnrTiZt8Lz9c0GtOhnn10p/wn
         1Hg5IPg5iYIxbuswH7HOpA8ljdKiYY48XEMPmhluXcYYXXxNL9krR9LSrWuLACcQmWZN
         d/gC1mkuoZCn0m/yzTRWhTIcD7UaCMLu7rRK416cPYcfUrmcygbjxjcRcEHU1N/UFwMu
         e82MbD6kn3d/QkGGH2EphNf0iGKRXjPSa+ItIqCC/AbB/T1RfCOR0W6GDMx/bFzqsHyu
         cMZaQDLGQVGmM/eknkdqhoOg7ugFKPZr87XXoR3JkbihRINLZIA6cLZI8dWBBTYvRE0W
         kiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvK1CKtw7MwQ4Y9/FEnTL05j5til5XvswsA9Bqzc+bI=;
        b=mJUEwdpSiBfw9OcBrqaLiRUx8c2tZf4/QlaNU7sMp0duwWmL/gIp8EEkPhJ8pnMy/g
         YEyyFbNazFPzSy6Tk0seXdraVcfCpKpMmnALbdcBEv0ikw1evWyWn3BCrgvGisveZXmF
         7SQj4m/gaqXvptk7q9kECCyz/CeOkU51akQ9GMK+oHbGLC/KJFC+lCvgLH4Z9vP/2SaH
         LUTMZHkMB0PS6QuSJ5/Qjj+JCsf4NvT2au0FuJTltlpsXh/7lZIaetFwHasovIku6rb4
         fGEloqXB4BHURKty6wJAg7xl+ARRvQW0pkz2+FLGVM90NZ5rUajCPpvof9ZOhim16fn+
         N7Ag==
X-Gm-Message-State: ANoB5pmWiB3lW3TnOg8f2YeOH+aF4RKT0ZjXkVIakE7j4yym1o9+b/S1
        rpbHihdApbJBJMsXDclodSbhrw==
X-Google-Smtp-Source: AA0mqf61bApEP6f6JqWRuJ+muUq8v3m/t5qcSSiceFibhqhQDeAEcAMMjt5vWUHfy8ZvL3pyNp3pWQ==
X-Received: by 2002:a05:6000:104c:b0:23a:5a31:29eb with SMTP id c12-20020a056000104c00b0023a5a3129ebmr3319402wrx.679.1668754383938;
        Thu, 17 Nov 2022 22:53:03 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:53:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/12] slimbus: qcom-ctrl: use devm_platform_ioremap_resource_byname()
Date:   Fri, 18 Nov 2022 06:52:41 +0000
Message-Id: <20221118065246.6835-8-srinivas.kandagatla@linaro.org>
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

Simplify the code with devm_platform_ioremap_resource_byname().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index bb106eab8ae2..400b7b385a44 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -488,7 +488,6 @@ static int qcom_slim_probe(struct platform_device *pdev)
 {
 	struct qcom_slim_ctrl *ctrl;
 	struct slim_controller *sctrl;
-	struct resource *slim_mem;
 	int ret, ver;
 
 	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
@@ -519,8 +518,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctrl);
 	dev_set_drvdata(ctrl->dev, ctrl);
 
-	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
-	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
+	ctrl->base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
 	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
 
-- 
2.25.1

