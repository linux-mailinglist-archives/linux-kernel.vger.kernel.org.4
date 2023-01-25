Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6A167AEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjAYJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjAYJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:46:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC25BA8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j17so13311765wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sf93u9qLAl/kW4zKoFQL4lEPy9GA4IuPMNBdksDHS4=;
        b=v+fFGjaVu6HopZHsKR1i+WrrGZgLZssRidqBnouaBBYmluIu4HuuQpS0bGmEWNuoOD
         afpoL/k0HjMpjaZJ4qBud9g3vMgpuRsnLQbjUd/osCnoNous9OWI+5VY2KqByddEhcQa
         iaknKRn/FHyGh0Res25N5dveRZRa0qNkpLAJv5e669mYpg0lXwYj0y+8K8P1wp2AoX8s
         a4VA3dvH1rgCxZ1863rj6I2PFH3ua11kPIoFWylPR/+Q2Il8Ugzhg26W1J8gl7uXtb+S
         6B5D8w3fs7d9RMPMBmKzYgF7t5MO9N5DQUd1j6c4Hv/7gTH9jfwrm52glcL+frS2V/fR
         gJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sf93u9qLAl/kW4zKoFQL4lEPy9GA4IuPMNBdksDHS4=;
        b=Ax6jgNeqANoneCmNvN4NDEDWcnGp7lfDYUU6OYeoR5zKI1sA1njZ8cbPFYTNW6di41
         Axn0Fjwk+VhppFGZ/0U/7P4n/l850I228QJNQMaHg9E79+vKPplHxVEPMCoJF4Y5CC+o
         UAzJBe6ydtALrrJfRrujgOoxc5lsNqB4bEJI2cnPAmyivsMtFVRiaGxXp9huE5miz00B
         K+a6n62EECtF2Tve3SriQzCC6ComG0GKGjh0TWDbx9hUYyhhU3z9YPwkDpzWnDTAT69J
         8qJdm50KCL6ZGr0paA6REqlgGJMWNuku3lWubpnF7tWaGiNZjc3E9INjUkJM8F+xMCh7
         iAvA==
X-Gm-Message-State: AFqh2krJWyla1tw0k6Shl0ad63T6RousHsqGcEzrwFNtAn3AiAjx0SB/
        VmRInveNh71YdhWCXL1Rr6d25A==
X-Google-Smtp-Source: AMrXdXvljaUY7zFk1FMrwWw7waw2nNZzQ2VmmZk/Xs+/90HApHOPzGWCAz2+tIKn+1boYL9dwf0hGA==
X-Received: by 2002:a05:600c:4f82:b0:3db:25a0:ca5b with SMTP id n2-20020a05600c4f8200b003db25a0ca5bmr22484430wmq.37.1674639933314;
        Wed, 25 Jan 2023 01:45:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b003d1e3b1624dsm1419238wmb.2.2023.01.25.01.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:45:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 8/9] arm64: dts: exynos: move exynos-bus nodes out of soc in Exynos5433
Date:   Wed, 25 Jan 2023 10:45:12 +0100
Message-Id: <20230125094513.155063-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
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

The soc node is supposed to have only device nodes with MMIO addresses,
as reported by dtc W=1:

  exynos5433-bus.dtsi:10.20-16.4:
    Warning (simple_bus_reg): /soc@0/bus0: missing or empty reg/ranges property

and dtbs_check:

  exynos5433-tm2.dtb: soc@0: bus1:
    {'compatible': ['samsung,exynos-bus'], 'clocks': [[21, 220]], 'clock-names': ['bus'], 'operating-points-v2': [[165]], 'status': ['okay'], 'devfreq': [[166]]} should not be valid under {'type': 'object'}

Move the bus nodes and their OPP tables out of SoC to fix this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
index 72ccf18eb9d1..540b4d6c9067 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
@@ -6,7 +6,7 @@
  * Chanwoo Choi <cw00.choi@samsung.com>
  */
 
-&soc {
+/ {
 	bus_g2d_400: bus0 {
 		compatible = "samsung,exynos-bus";
 		clocks = <&cmu_top CLK_ACLK_G2D_400>;
-- 
2.34.1

