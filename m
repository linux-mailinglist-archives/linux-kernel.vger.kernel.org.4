Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B61268DC89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBGPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjBGPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC181A4A6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:08:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg26so11274261wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QanlvCxRAxNh0Aitpwd4RYe4ua1rl5xSvSA8lFNTtWw=;
        b=y7FNB7/R4II5pcYBayBqRSarruWI7pyoaSbUCapJ0nML1/iHBjcspYzalKk9cJL9Wd
         DiZTazGtlrHrztWq8Aq2gwt7M+41PlZxd8WtoU3y8NqdVmS9OgXAv4l392WnHWrn1DnM
         cpPGV+yNfMMbK2sK66RZD2UJPQ/JL2TM9ZaCBALGO0SfWFp2oF9HcyQuMXM4rVASPSQs
         XmMJavgYceC4sPoF2KXgttz6Av6SQquuDWMIuXtRJhWKuR93Dbl4uRUokad63L/WeucA
         SniS0P/bGI45FAmvsRkIzRIHjqdhNz0Ngnb0G+lIeRQ1vE1xoPh+csPvat6P7LHjx7OY
         3azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QanlvCxRAxNh0Aitpwd4RYe4ua1rl5xSvSA8lFNTtWw=;
        b=WJGx2N5vpF9etUkZbYNswwarnyohCYO11oWs0Hk4V2HH/DGR4Ea1wXCaPDEEghYIvn
         mKVl//38qkymb5MuYMyI/b0xoxJOIC/rmfBNKwFnvp5PBcdXEBjqny0X21qevgVcNzPc
         PtasgYAnE8EPh3PKe01jqrEW4rppjlKeTMuXjc5IbbW/NcfNY86aHXuTN1I3Qw6qjQM4
         UdeBRXfCbcxdg+w/HrFLC5SoTqA2g6MYrFdVM+YAee1sALA/qxxbtFhCU9iTDrsrQaR2
         0qcKzKXrQ4e4JCoua4XdEb5v3e6NCTLZMfI7u/ayP85r4gj+JFM+jKZGd46NmFOByYYl
         9l1g==
X-Gm-Message-State: AO0yUKUATPyy1nQTkZ1TJhngZSCO/anc3S9Cz97rBFMba9YPPvWq0njK
        nXrEQqFS24yDYMJ/4PmLu2PVbg==
X-Google-Smtp-Source: AK7set/ApDuZBr+dcZIgvzCXDf8imlD5bcnHGLhZATLXygZx8ZLHKqYTjIk5AUcpqAVmKSdW74QrDA==
X-Received: by 2002:a05:600c:16c4:b0:3da:270b:ba6b with SMTP id l4-20020a05600c16c400b003da270bba6bmr3446241wmn.41.1675782500704;
        Tue, 07 Feb 2023 07:08:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22092173wms.28.2023.02.07.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:08:20 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:07:59 +0100
Subject: [PATCH 6/8] arm64: dts: amlogic: meson-s4: fix apb4 bus node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-bindings-fixups-v2-v1-6-93b7e50286e7@linaro.org>
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following bindings check error:
apb4@fe000000: $nodename:0: 'apb4@fe000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index ad50cba42d19..f24460186d3d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -85,7 +85,7 @@ gic: interrupt-controller@fff01000 {
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		apb4: apb4@fe000000 {
+		apb4: bus@fe000000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xfe000000 0x0 0x480000>;
 			#address-cells = <2>;

-- 
2.34.1

