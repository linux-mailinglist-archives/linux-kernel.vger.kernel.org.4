Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE9264731D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiLHPcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiLHPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:30:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED64484B76
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:30:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h10so2040631wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YM8esfRUJI66AUcHAfU4GRcLBt7unfApTHLgo4eQjI=;
        b=pie0o9goXLxTxFDA4wcDy1QkVwL1bOKcv7mDRQAf3WeuYm3BAAAlDpu+FU0MBZcybk
         k8avyESThu3slr+rgSsV6dR1RvPy7V06I8Vm49srfp6xJvvo1CeRz8+RqyjgFVkq8fGv
         Lt8X3emhtDcbXvkbErRRYlG4gW4rF0WUKg992gH677fkHXcsCAiGWjNyd4Sa0N1pSAfb
         J1K/Ul2U+sU1MLlcXBjkDWdzoYHC6AQitcuixVlM2fhkfLJ1fOC0pl9gM9mZOmeFVW2z
         KwEk9Wm1bPMZNqLGSK5Uthq9wxcSRzsp4kRWXWUA02ehd0GpA49xJn+TY2jhJ0txBh7N
         /teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YM8esfRUJI66AUcHAfU4GRcLBt7unfApTHLgo4eQjI=;
        b=uRzxNXQUHmKwGapY5M8PTP1qHIUNsFy3ngHoObCq+cQSnJf7DADWfZcFUiK2XePSOe
         tlaJg2K2XBkiBkJ/tgpXte3oNJS5vtAx6H9UmRs5fXFcdwmQHbXyO7H3h+15ySvMl8ac
         J0e5/hUzfdIMMBnejunIQxa1BUejtKSXho7One38Y2/pNE7bNPFq5CEA6ZiQphLsNmQM
         mR1tOKyvx5QLLtbAbDA32wOt6pFa4fELxSuhIqbh1HwN0VxqN2rWlg+8DeXUnp/pZC8w
         wAVxUipm/VDcdw+v4x7M/EC7GNB2FUh4UPglGfdi07fM/zNyMUZrJQ0koAEcioGM9wEU
         hAAQ==
X-Gm-Message-State: ANoB5pmsAjMKfoAQGndzvDeswyaTa/pBdCSv9m03cVE+DRILQTNeoD1a
        LvfNpdCPvK0gvAT24iGHNViVbQ==
X-Google-Smtp-Source: AA0mqf6GZP9OH5wdGjbihY7E5o2kNENG7XJO2LlCOF0ySSKsJ5o9aJAkw7mGbagi4uWcljWa5J/rOw==
X-Received: by 2002:a05:6000:1d84:b0:236:3686:797 with SMTP id bk4-20020a0560001d8400b0023636860797mr1652958wrb.65.1670513444313;
        Thu, 08 Dec 2022 07:30:44 -0800 (PST)
Received: from predatorhelios.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b002366553eca7sm10673239wrt.83.2022.12.08.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:30:43 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v4 2/7] dt-bindings: irq: mtk, sysirq: add support for mt8365
Date:   Thu,  8 Dec 2022 16:30:35 +0100
Message-Id: <20221208153041.3965378-3-bero@baylibre.com>
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

Add binding documentation of mediatek,sysirq for mt8365 SoC.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.38.1

