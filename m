Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755BF647322
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiLHPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiLHPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:30:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15198E86
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:30:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so2020173wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDJr0JNgTCOMxRZclskMbEi5U/4ZKMcH67crmF1PMpE=;
        b=Mt3jE+le0MGXv1iAIXnoBBkc8fokd+3aEZfOC8Y5+nYh4svi/5AdVqugjdtnDHx/Ji
         kOFhOEUJZpWyWlDMjzMNKuBXk9tFLiGhJXuToi277b2mLN0wbceaZag4n8+WGDOR0TFd
         bTNIhnQsyP59x0v9Dt7Pvgf1U+hUNg+CgO7ystvtFnZJSGn2MgKYOZy9qLt8Zr/gPzut
         Aw85CksnFGjOYp+imRxuPsXUEH7T5CMiAlf3bzsuR2GVdow0V9V9WzCZIATGL8BFNs6U
         wxOzwpFBY4gwrY2cFdshm6gByS91YY/iEO8QOITzzmWd0lNs/vxeuWtC24fPrT9SptFQ
         Ms9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDJr0JNgTCOMxRZclskMbEi5U/4ZKMcH67crmF1PMpE=;
        b=MMVjEmmHKc5jvEu03JTpDQZiqsv463JLXeQdEMDtpfGiFFbyTcXmPXpCv4i4uBSJvu
         i7bU0Sh45bNd00jgSVhqIwRzsmMSy0/tppLgtjaUimzMv7CVArmeTzKr35KeKuCWyjZu
         v5ATr4o1BpQxgYgT5redPecDh9NRh2FtATY9wKoK896npk7JznLZFe8D8mu/QelaaBZJ
         mJoUS6vYqEfMbYUoXL9sfbDDMaXkcKXDhy6OLcNzf7yeaMKmX5YuS50EQymi3sfkSZGC
         NYfkjvM8KHPRlLNEUqfQLd0IoF4A8THQNuBiWsYcH5el5ZWWKz4QUw0+PQeRxeYWoHYI
         eSAw==
X-Gm-Message-State: ANoB5pmhd4BEuKPzhHN9mJkxTCZvhqFwyA0TwQOmMeDQBNeVf367akgj
        Ohntyefx0RAaLA/RR5P0L7xCaw==
X-Google-Smtp-Source: AA0mqf67lfHIJwHfsORr5HkhkFVrVxVhlkCojfRkbwd4ml08Xz+iO8ncJ9VcfWf+AbAx+sSMtIcRRA==
X-Received: by 2002:adf:efc8:0:b0:242:f3f:28df with SMTP id i8-20020adfefc8000000b002420f3f28dfmr1434570wrp.58.1670513446920;
        Thu, 08 Dec 2022 07:30:46 -0800 (PST)
Received: from predatorhelios.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b002366553eca7sm10673239wrt.83.2022.12.08.07.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:30:46 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v4 5/7] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
Date:   Thu,  8 Dec 2022 16:30:38 +0100
Message-Id: <20221208153041.3965378-6-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208153041.3965378-1-bero@baylibre.com>
References: <20221208153041.3965378-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index 7168110e2f9de..d2655173e108c 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -28,6 +28,7 @@ properties:
           - mediatek,mt8188-mtu3
           - mediatek,mt8192-mtu3
           - mediatek,mt8195-mtu3
+          - mediatek,mt8365-mtu3
       - const: mediatek,mtu3
 
   reg:
-- 
2.38.1

