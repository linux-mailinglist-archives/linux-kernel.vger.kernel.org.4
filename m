Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB856B2FB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCIVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCIVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:35:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71A1DBB73
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 13:35:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i34so12644009eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 13:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678397704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvjNBXeeYphBWgNkcT8wLT8gdWY2M0B9Tjp0nJ/il2U=;
        b=3KewT/q6ngZIc0ufTpR/r0Xx953GgwMCDFM248OUypVlz5UD6D7zajvtZVD1vO3Eyu
         fgLJk55a/qL5nQpZr5NP9g0VorvdSwZzqh382Iqb6a8UupxsxPjDDlxRkJVRHVg/7XOx
         sQqiSD+NoibdaGACFjHP0qWTB4YAluyDVuNstzT0kQC9vux6vRIqv98V6pzZzaLbSnDN
         XT4o2MjBbig3EQKpsEbcs/8OXbjCgzWW/YCRkWUabevY4QdpA/L6cNSH65pkG1J14Ttl
         O1nNXyMIe5yMnejmQEUDqCZwC5TUkAuq1v7NR5KnqnPsIZZt8FHqws/y/yMLRdtQle8H
         BA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678397704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvjNBXeeYphBWgNkcT8wLT8gdWY2M0B9Tjp0nJ/il2U=;
        b=cVz5/7RJ0HCoRdTUmKIhrtoA2pVVU4Vxvjr8z83tgKZ2AcCV7H71Vk3T7PRtVe7HSS
         /xyLu391XTFdAaG7lOb8J7WMFOSRxWWWmPrXco7jAooris+QGB/VgqunmjMfdRVZTIuT
         guDNH2Ft9nKJjCz5ffzpfsWnEdcXqsp1ANuuiTh+yX0xdtPIuGtNqyu2A2xl6s6tIk/0
         VkSgyfOLtpX0g4Qaq7AeSy4Nde5WQjxiEhjuSdzbF5fjtn5xFBN9097wFxR8ofXfEktp
         pgEMUG3M3+nLzb4LF2rRnFefqEWfCS8G5H/8GBRTAeNIe+aCqZIzv3tgWqABilImG+yT
         kVSw==
X-Gm-Message-State: AO0yUKUsd2jSOg7jh0Xmvz16ZQ2fWYV1GNXtyU4XerJdOJVs/cWN9AzU
        1Kqz8u3WsYv0zqMiK3QtfvdqcQ==
X-Google-Smtp-Source: AK7set8/H9jiyeApQuJY4jmDkQHw3OFChM+1m+frQ+5xrQC0cZQ5kxnS7LOQNNshtSNIzKG08bG4dA==
X-Received: by 2002:a17:907:9721:b0:8b1:9e47:9101 with SMTP id jg33-20020a170907972100b008b19e479101mr27369379ejc.12.1678397704239;
        Thu, 09 Mar 2023 13:35:04 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id 8-20020a508748000000b004af7191fe35sm211486edv.22.2023.03.09.13.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:35:03 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v11 1/3] dt-bindings: irq: mtk, sysirq: add support for mt8365
Date:   Thu,  9 Mar 2023 22:34:59 +0100
Message-Id: <20230309213501.794764-2-bero@baylibre.com>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <20230309213501.794764-1-bero@baylibre.com>
References: <20230309213501.794764-1-bero@baylibre.com>
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

