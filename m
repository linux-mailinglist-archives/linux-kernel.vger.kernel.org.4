Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA84701667
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjEML3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbjEML3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:29:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406D3C0F
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:29:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so97014655a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683977376; x=1686569376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dw8wPKVLlAIKAMysuZNl/3ACPQu4RWpxUdT8LT4hWo0=;
        b=BANXOOpT30CoBj7RkcqtZKO5BBKhLQ++YG+7Cuo/9l72d+cZP/5oTwPU9flVqa8Iiv
         vbS2gilvw8hHA2m5ll9pB3x1SMMW0aYzOD68TO1LkbxpGmtAYq58u/fVGvKu2HjpIuMW
         2zT/mWfNVgPPledpOMI0zncFj7b80KN0rwroBGUM/zMZcSS2fz/zSA4H4wIfq6XS6dJs
         /aadrDje9R/AGlgAThuQUL9+j6/fS1DmL9ommyb3n6pmPxv2jkZ1O4p3Pc3lJ1xkHCjX
         xr4sprhofemVkyWzpulyAJNE3jPCKqZiduiClUs1A1kIItcJUeH3Qj27D+GO0ikxK0LD
         GzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683977376; x=1686569376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dw8wPKVLlAIKAMysuZNl/3ACPQu4RWpxUdT8LT4hWo0=;
        b=CWZ1N5qz8y9kZ4/OTsx2GLCmtAm6o1X3g7IP4BHqkfeI0QeWBtNEH1NQxxgvvnqqDL
         YNDQZYrbSAVBAtmjgm/kjwFuOg+eXt4CO69lV4QBW7q/BK+AXN3n2oFn5AGbmc1NuX1x
         OOWVAvU+A65GsM7WC/ASBXlccQRYva/zn53OwP4YrTE55dmuZSZRmTUJL2Bc6aPHNs3y
         Q52k9QMH4Z1oBm65G3Me4PXPhym3bHyoC/ChZU9Ur4S3v1MS9Vv0sXq9f1NWaO9SExa0
         cVANj873QAc86dcdRjh4TyF4BCHe4Hb8kqsspxXs7VRQdycIWyE9N8opJVfuaRsBjOrM
         AZ8Q==
X-Gm-Message-State: AC+VfDzX+rMFnDXgK6G0yoeDUrJDAoFKqYvF1E1XiKd4lFE/YAOqqc7M
        Zs94r4U5wHw2mxjsTtuoGCIn363zoGaTB+W9byW8iA==
X-Google-Smtp-Source: ACHHUZ7RsnAcXLRAUe1ZwlxGBMjTDSgbQ4INisOCyvhoD2O+W2et0AUEoIcxkZ1VVcGrLgqcozDTlw==
X-Received: by 2002:a05:6402:2711:b0:50d:8bc9:41c8 with SMTP id y17-20020a056402271100b0050d8bc941c8mr23187153edd.13.1683977375908;
        Sat, 13 May 2023 04:29:35 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3aa:fd4:f432:676b])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7c149000000b00509d1c6dcefsm4806493edp.13.2023.05.13.04.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 04:29:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: brcmstb_dpfe: fix testing array offset after use
Date:   Sat, 13 May 2023 13:29:31 +0200
Message-Id: <20230513112931.176066-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code should first check for valid value of array offset, then use it as
the index.  Fixes smatch warning:

  drivers/memory/brcmstb_dpfe.c:443 __send_command() error: testing array offset 'cmd' after use.

Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/brcmstb_dpfe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 76c82e9c8fce..9339f80b21c5 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -434,15 +434,17 @@ static void __finalize_command(struct brcmstb_dpfe_priv *priv)
 static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
 			  u32 result[])
 {
-	const u32 *msg = priv->dpfe_api->command[cmd];
 	void __iomem *regs = priv->regs;
 	unsigned int i, chksum, chksum_idx;
+	const u32 *msg;
 	int ret = 0;
 	u32 resp;
 
 	if (cmd >= DPFE_CMD_MAX)
 		return -1;
 
+	msg = priv->dpfe_api->command[cmd];
+
 	mutex_lock(&priv->lock);
 
 	/* Wait for DCPU to become ready */
-- 
2.34.1

