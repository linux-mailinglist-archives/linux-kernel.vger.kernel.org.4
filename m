Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A05D675B85
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjATRbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjATRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:31:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297DECE211
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4246287wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkLt6xZBpWumMmqzLzKAMNGNbT1hqjEyGCt1cE++XRU=;
        b=PWNttmsjNUVGI9U/cMBrzpAwTfezOdl8WjPVbS9se2BvuNhkLNscZAq6QpORp3KzEi
         Noa6nRNL/p1XDlztrFL+BI8La2/yQfJ8t+upDFeAoe6rQnCzzMgEfCcUkr9nno3AkQjW
         m+wCCSrHDc6tYM+IjeBCeMwc/myYTF6U+s0tnqgNdz6WfgmoKbFQBN/OjPE+i39BZ6v/
         ZYF84KddJgiDK9p5AhoysWt+Pw6lMRek6gvzgnd8Gb2XnXmv9S6Aj4o84hjWYnL/3VQA
         oDNsG9+vQdyY8hN1Kmr6NpXyjXVxE/nAug832ZmlVxU/fMUxQWjBA9xv/kVtmYXbEV5r
         YjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkLt6xZBpWumMmqzLzKAMNGNbT1hqjEyGCt1cE++XRU=;
        b=2wxqpH9ECnoy6RdNlmRX1gdR2LTUhA+hFQLA1k+tCfoOENlk71qeMe5xl6zJwBQjV2
         CYtkZpmdugEbLgPzZBGwecDKDdPs12Q/NlxpQyUdNoZttun7wYvG0AHmATIrznZVWq4w
         D2owPbfsUl3bbHalK8I9i7mtU0kPbTrynDF0Eo/soLwO4EUtxEIgqLLxLN5XpYZwuL7h
         v/esAlsqKmi8l2dAupTxTA6v20+LJzFi9w8vZ6ABjFnNxbScEzQ1o8JtYzVhba/r1GAN
         tct1SKcIUfVt18ESwMR2JlWzpcLeQF6LZumQtRtrXSJEHvYXnGYB07PB6YBT7UIysPKy
         HIFg==
X-Gm-Message-State: AFqh2kpw6YlXr4wtejA6vwnGGE+5OkZ2n8Z5ACJr0xF9EVP/XbjfNxk4
        ZKlamaKvAk4Lsc5TtTyZzN7Ihg==
X-Google-Smtp-Source: AMrXdXtYEbx+ZfDH1uBQQ4+kkKgbTFFddHq3xALZmifs0lrkLmie0YdVNHLwZ/PyaJa1qwKV1iu+DQ==
X-Received: by 2002:a05:600c:3b1e:b0:3cf:497c:c4f5 with SMTP id m30-20020a05600c3b1e00b003cf497cc4f5mr15337599wms.13.1674235881768;
        Fri, 20 Jan 2023 09:31:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003db0dbbea53sm2819179wmb.30.2023.01.20.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:31:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] arm64: dts: exynos: add ADC supply on Exynos7 Espresso
Date:   Fri, 20 Jan 2023 18:31:12 +0100
Message-Id: <20230120173116.341270-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
References: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADC requires supply and it seems LDO3 (same as on Exynos5433 TM2 boards)
fits in voltage range of 1.8 V.  Use it to silence warning:

  exynos7-espresso.dtb: adc@13620000: 'vdd-supply' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 829657c9c7ca..abb3bd700d6f 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -78,6 +78,7 @@ &watchdog {
 };
 
 &adc {
+	vdd-supply = <&ldo3_reg>;
 	status = "okay";
 };
 
-- 
2.34.1

