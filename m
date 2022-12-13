Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC564C0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiLMXoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbiLMXn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:43:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353FB63AF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:43:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id f7so20205747edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyLi6iA5QFbrZuLEeQFr7qfmVlBeS8MD2efPde1AiOw=;
        b=xCguJJPaZEjMzGujNfSpsGHOF24EbRn3Blw4RFAU6A1N96sJQxF9GOtFOS7pLu97Pt
         yaVSQlU3rrKnjqEN3y/OlqKWGPUFlkrNmQnJCbtUdZ2WmMDeP8Oqv/Ej6Zin5oz5CdTh
         0cj3DsTDBuj3TcfBJfwFTKnq32HFP25sPusoxE9S4hjEpHRTeEHNhzr6hAp4j8tWhuI/
         h7HrJClZcRnR5gK36OCk6rSkzuOYSlRodgxXepUHNgam72gDdO/UQvEk8glHhIXBYRgd
         W++69kt6vnhtQ2EHDA9OSHbfSsuzmxjqtRFAYShCnhFiZd5nbRwJY8A3f+4Y3hCknzSv
         76FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyLi6iA5QFbrZuLEeQFr7qfmVlBeS8MD2efPde1AiOw=;
        b=3eBlGrK+BBviqZhCe/33Odj22PvnqSsRQCyzk88mkLe8rgIp2ZfZEzRJEasHR2XN1z
         GrsOpaJtEJ010ICChq1bqDxT8pX85aMNJWSq9r6N6kthiCq5zkQXFzYE7nIXIX2Cml4/
         p7H8dcU5Snu1tdb6fi+MEuZ0x0NLN8D0EdzhTOOIekmlGRWlWz3W2FnFPjls8UgB40Bf
         Banc/PrmD78ehoGMmvtOvbecBXJyhrrtZjw7jDc7A1brmAHYraIOlF6NRBnCGcD+Uf0A
         UulzebirUz47SAMm0mawzLzIVUHuGa5Qryj9uC3coFPprWIU58QCT2+hPezH/5VVLoMG
         DZHg==
X-Gm-Message-State: ANoB5plb1hzQrvr2cbfYk+HbNGbTVbjIRPSigVb++uAcqJVeobraMM1r
        u7qrbQTdgFChwuaRiVMBdF5UDA==
X-Google-Smtp-Source: AA0mqf6Z1k1vCSwJWdeOCOWRZIb7unYzNGZhFgwCvPgtqpxtk3N+bmmDBUibzZdHGGxxWSSHS1dSrg==
X-Received: by 2002:a05:6402:12c9:b0:46c:55ef:8d50 with SMTP id k9-20020a05640212c900b0046c55ef8d50mr19150778edx.24.1670975033781;
        Tue, 13 Dec 2022 15:43:53 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-093-129-109-038.93.129.pool.telefonica.de. [93.129.109.38])
        by smtp.gmail.com with ESMTPSA id f5-20020a05640214c500b00458b41d9460sm5407498edx.92.2022.12.13.15.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:43:53 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v5 5/7] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
Date:   Wed, 14 Dec 2022 00:43:44 +0100
Message-Id: <20221213234346.2868828-6-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213234346.2868828-1-bero@baylibre.com>
References: <20221213234346.2868828-1-bero@baylibre.com>
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
2.39.0

