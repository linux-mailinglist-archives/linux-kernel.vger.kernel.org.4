Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036126B26F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjCIOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCIOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:35:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A7E7CAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:35:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cy23so7717025edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678372508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvjNBXeeYphBWgNkcT8wLT8gdWY2M0B9Tjp0nJ/il2U=;
        b=4KYfaUs16ATIQmgfHGIiO1XlwvR2SggVkcJBEfiVouxApDCubSiGgFbPnSShsETRYy
         osLsCoGwTaEk3ybDE64pvRN0q1CuG2E65nOYWfbGZ+C5SPT8YhTZCuNcLUQw2WY4XPP1
         NBz4RVlVi04CxccL1W3fnHHIIL09pwbpWKy9XAXSymeDX+btDdLk7yRgpY8uCZKrM0Nt
         W1Kx9TIHNdGQWDaXihZegh+OE3MrbWbii/J5URuEDCG9wjr5ziAtXL4E48LjIZNozQSu
         Ukh7NzPBPnVSHj+qW6Z63i8H/D9UBpDwqKXvQuiAetFI56QFgXbv2l57bJj0p/huvmdl
         NOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvjNBXeeYphBWgNkcT8wLT8gdWY2M0B9Tjp0nJ/il2U=;
        b=BEhSzoy/QJUnAZtSMOObo0ChZ4JnHk+9orej/kBno94BkwUhYEAS2S8ydnjappAeJD
         f68j+wOpEfWXxvrOzgFvbAKBgrCF71o0shDdjBOwLVtQmyLruibpc5c7srX3uoHkBMOs
         Mc3bGhIppi89G1g3qouGIusWpmZgX113IDUDS1FwARp2YBUAfe/H71IK46bi1ZZLiQj2
         0FxtKX7qlkvpdzjgQuNMf9bA29fkTVuOq2AAxlXBn525q9Ee6lk/Hj1iBRDSZdX1+t/l
         hXp828P4I3jZzhHVdJ44uNBvK1xl816aKCkzaGHNGcJaqbJjNvsfsF8oPmExXOufpNCU
         0LvQ==
X-Gm-Message-State: AO0yUKX+pnyklbq5nMdnZ7y+tcBqIWVXvsgBhE4C2/FBry2Jlcp46f7v
        elv+0EPn8tSQICw2xSHxjoogpw==
X-Google-Smtp-Source: AK7set8Qe8U6tp7US8u9NFqeRC9Aiio3kqtK7ujJVoqRZi/jAyoPIflQmwQykEFZpkPXbalGWg36QA==
X-Received: by 2002:a17:907:7da6:b0:888:b764:54e5 with SMTP id oz38-20020a1709077da600b00888b76454e5mr26631536ejc.71.1678372508260;
        Thu, 09 Mar 2023 06:35:08 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906184400b008cb7473e488sm9046239eje.12.2023.03.09.06.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:35:07 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v10 1/3] dt-bindings: irq: mtk, sysirq: add support for mt8365
Date:   Thu,  9 Mar 2023 15:34:57 +0100
Message-Id: <20230309143459.401783-2-bero@baylibre.com>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <20230309143459.401783-1-bero@baylibre.com>
References: <20230309143459.401783-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of mediatek,sysirq for mt8365 SoC.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 84ced3f4179b9..3ffc60184e445 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -25,6 +25,7 @@ Required properties:
 	"mediatek,mt6577-sysirq": for MT6577
 	"mediatek,mt2712-sysirq", "mediatek,mt6577-sysirq": for MT2712
 	"mediatek,mt2701-sysirq", "mediatek,mt6577-sysirq": for MT2701
+	"mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq": for MT8365
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
 - reg: Physical base address of the intpol registers and length of memory
-- 
2.40.0.rc2

