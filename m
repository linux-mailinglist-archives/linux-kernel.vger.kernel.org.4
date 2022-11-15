Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4091162902D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiKOCzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiKOCyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:46 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3916597
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bj12so32827242ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dC+/yReVVtnmp1EFnfhA5gyiPu04TshQ+QR3r1EqXE=;
        b=fdYDr7YwhQf3T6yIFyQ7MGYT6DsEuJKYYY0VfusCG77DrHgentotQmgPxKQbH4jQms
         CaU0woUtv6FB4PfzuXMGao7sXiPPqdJ3ezRLhdwaprQvGPuFCbEBHJZNLhEPjMnuAbND
         ix5l04a/f6f21SoFK4kPx0epmC1RNnJE6Gff5E8xKr670sElcztjY+CQugFF8y4igQNs
         N8HfwVsZU6YULzaCkQ9g/ApCqfcH9MNdOFezY7ukElKD+OCYZL2stFlBbhc/bTUZdjnJ
         X4TK6XXD9Sr5FvZPGs+HhON3ZV9L2cUUO+sGP3l2BRcttDoS2tgOe9oRJLNS4ShnOLkV
         Vnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dC+/yReVVtnmp1EFnfhA5gyiPu04TshQ+QR3r1EqXE=;
        b=uTn7Ums3GcsbzjenNF68tRG1jhtmNn0JVzZdS8/Tv9u3wTz6BTEh8T29jNCqwsMg1V
         2ykYEjr5GC3GAENP4FPuuJJUCBrj9nQ0zF2Zeg5mEe2g4+dXHMGg+gTreeo4KwdhcDLl
         HKdiOe/om1CJZfxE1frrkDGCd9yQg86fjq5xKDqrcoC2gLfRCDtS/hBqYae7jajcVRYo
         Mmw37H+cLaO39kptuj9PXdNmdvqEzcfFguMHQHyPdhg0RGnszT67Wzc/Q3t6aXUxhsnz
         iGsHcJMqjeI8AzOyGKzBMoIw4MQaVkoUf8jOmz5fWuDq2oZen8GUjIZ8svaxkQfE/hfs
         wg7g==
X-Gm-Message-State: ANoB5pm3/fYgIk6+iQwCXfcXBZIDnRAAd3AuuiLFKJeVKNRYd9CbLgg1
        Gi305jZ03hwc0LGNcZ4552g4ug==
X-Google-Smtp-Source: AA0mqf43vKDWJvP387IvF/pav4o4KaaCLekdMIqywSmlrG137P42oFTN9+LzjZmETi7gFi7yY3TiwA==
X-Received: by 2002:a17:906:a1c6:b0:7ad:d250:b907 with SMTP id bx6-20020a170906a1c600b007add250b907mr11763109ejb.737.1668480875586;
        Mon, 14 Nov 2022 18:54:35 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm4861177ejf.72.2022.11.14.18.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:54:35 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Subject: [PATCH v2 08/15] dt-bindings: nvmem: mediatek,efuse: add MT8365 bindings
Date:   Tue, 15 Nov 2022 03:54:14 +0100
Message-Id: <20221115025421.59847-9-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115025421.59847-1-bero@baylibre.com>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
MIME-Version: 1.0
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

Add bindings documentation for the efuse driver on MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 75e0a516e59a2..6893f2a6ea225 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -34,6 +34,7 @@ properties:
               - mediatek,mt8192-efuse
               - mediatek,mt8195-efuse
               - mediatek,mt8516-efuse
+              - mediatek,mt8365-efuse
           - const: mediatek,efuse
       - const: mediatek,mt8173-efuse
         deprecated: true
-- 
2.38.1

