Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2A6B26FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCIOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjCIOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:35:11 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C55E7CB1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:35:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x3so7749762edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678372509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XGnTW8d5154ClkyTBOCffDzRAqbcCupwBDkGcyCWzM=;
        b=VWPDh6dtM1UkmUdD7p5LKK8/I9+WNmFbF+ajDTXODZ3BAiuXnUEvgLz40BtjcvPYRZ
         T/FpT9sG2LUdjcjm3BXeWIPvnqgqWZyrJCESFGxPJ/xizYSGzfwomH7IkORp0woQr4LV
         7EC6cWtPzN8QhwV9duy3AoX7PpW+T62soDi4eE1WhnElgDoIfmfONRcS6uw1NwhjYUo+
         J1QHsW611tFkrVCbFwA535WwMR8D8XWr/zaBP+l7NuVEzlrA50Z9CR0xzO4Hx0Ia1O6g
         a2AsWYRc9LvX0z9kSz0/n3T2dBk4IANbIxcNxbdgmP2N0sPCziJx7HE0+JOhe1IXKdET
         +Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XGnTW8d5154ClkyTBOCffDzRAqbcCupwBDkGcyCWzM=;
        b=UET2rJH/tMNuXu/HxiVW8IuT/iHLDZVuleLGFZDd1FXJmEEWnpJI31pDEmnzzG/lnH
         COudTOFglJtdPSy7Vb9m1FH6hn3SSFMIJF14iypqBrv8N1FQZekWgRyOD1itjq7IrWx7
         L5ek5sGu7ZyGSeLXL8YVFxB1k2K5iXK5T2rHElaRy87ONBA2uDQUrMuN4X1S7omaUAz/
         3EG7I8MAOr0HCwqWfz24kfnSJUumq2euOwpXoWretTjEz6x+Kv4v/Vqnpz/pNPWZ+W9+
         uUq+BxFS0Loar7E9fItFKeFQWT4WS8s76kmqRn1j172ldOFbPdutmvhTtkvuRI8qeayb
         qKBQ==
X-Gm-Message-State: AO0yUKUAo0TkEbHmagX3wO6G7KWRJQhpNFqvbHbbkUMhP32lZM9HCmmY
        vpJCbXnNlU+v1C8AzmlEvLRAqA==
X-Google-Smtp-Source: AK7set9O4rl8P3uzhwE/hnhV/DPn1W87oDD35gpX7Y95gY0+bM2ivwGXgJy3SWXHzNLsycSnau36pw==
X-Received: by 2002:a17:907:72c9:b0:889:b38b:4bb2 with SMTP id du9-20020a17090772c900b00889b38b4bb2mr25849740ejc.49.1678372509238;
        Thu, 09 Mar 2023 06:35:09 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906184400b008cb7473e488sm9046239eje.12.2023.03.09.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:35:08 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v10 2/3] dt-bindings: serial: mediatek,uart: add MT8365
Date:   Thu,  9 Mar 2023 15:34:58 +0100
Message-Id: <20230309143459.401783-3-bero@baylibre.com>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <20230309143459.401783-1-bero@baylibre.com>
References: <20230309143459.401783-1-bero@baylibre.com>
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

Add binding description for mediatek,mt8365-uart

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index fe098d98af6ee..303d02ca4e1ba 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -45,6 +45,7 @@ properties:
               - mediatek,mt8188-uart
               - mediatek,mt8192-uart
               - mediatek,mt8195-uart
+              - mediatek,mt8365-uart
               - mediatek,mt8516-uart
           - const: mediatek,mt6577-uart
 
-- 
2.40.0.rc2

