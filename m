Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9872CD61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFLSBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjFLSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:01:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21E6E51
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:01:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so6452416a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686592869; x=1689184869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCGwbCad1AH2eGvAnap/WQX11/HOeuflBKO2IBu5SxQ=;
        b=pjkD0h+jj27yUXdF8AZb5enQZd3P3E7REc8v6jmRE4qJSFoiHmpHe0G4fR4tRRA4qW
         tasS4zx8SgBmk4eW3zZPNT6JckKTlFzaCjvD3syajY6TtEn/FqQuyeVUOXfD+WuIbKXy
         xwGs011tIC89i7WjrfeBaDH4/kIbcPqKeOSmzNC/F/4xYQ5kzquOP6ulbPS2w9R4Z7qI
         JU2mUTM+xf2/u4wsgBQ8TKy5OkEEn7k6TzLO1kb/85l2OWj9BpA9veK/3h/X4CGXu0Xp
         KLuVvqamPPNpfwsZ6XvcYJqC8cngIa1GBEQ3IceexyD7xsxgNwA3UsvfVz/ZWo+fulkn
         rfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592869; x=1689184869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCGwbCad1AH2eGvAnap/WQX11/HOeuflBKO2IBu5SxQ=;
        b=i3Be/cjQKkSr9SUwxYnD7m+J0VYYUMEtGFSPp2hJcUi9xLK6rqu+6ntYy1dicra/vR
         HoY3zY+0vPE7np6SnGx5rAz3CyhGds6o4zessNAu7m9aWYBpIfp+CVVdG9UCOtjkKPlN
         lbop02ZLTSBWvd3DOI+FXJBiNF2ofmJUBxjd9w5tOn9PE6ZnrNhi0PZCFwLy7Iz20Qcu
         aoIAgCaAZRr7KMcL9cCP/0D2wlS8mIFgR6RIaEeNKhaAOLTujOqFc3GcpgxkaEqqWvsl
         IXypCIHgyuV/tPLlCQTbRU9nbfR7QTA1/xBeTcNpYiigLax0RMsrvmZLIl4zMm2D6WmF
         IfHQ==
X-Gm-Message-State: AC+VfDxyWIU8MTdLEaxGRnt2YIvUN/DuaC7btGy+SeQXiBmcBYE4KjE6
        7OL3fqjBkDufwyb8rxJQ/4OIzg==
X-Google-Smtp-Source: ACHHUZ4/mCSxbJC+qLaVY77hKvoJbuJ/qDPXf6Y1hMusTYTf4XRvLJuYdGgg41+7NeQ6B+KnVz53vA==
X-Received: by 2002:a17:907:31c6:b0:974:62d1:e942 with SMTP id xf6-20020a17090731c600b0097462d1e942mr10381519ejb.21.1686592869286;
        Mon, 12 Jun 2023 11:01:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906411600b00965cfc209d5sm5556907ejk.8.2023.06.12.11.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:01:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH PULL] arm64: dts: exynos: Remove clock from Exynos850 pmu_system_controller
Date:   Mon, 12 Jun 2023 20:01:02 +0200
Message-Id: <20230612180102.289745-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Protsenko <semen.protsenko@linaro.org>

As described in the corresponding binding documentation for
"samsung,exynos850-pmu", the "clocks" property should be used for
specifying CLKOUT mux inputs. Therefore, the clock provided to exynos850
pmu_system_controller is incorrect and should be removed. Instead of
making syscon regmap keep that clock running for PMU accesses, it should
be made always running in the clock driver, because the kernel is not
the only software accessing PMU registers on Exynos850 platform.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Link: https://lore.kernel.org/r/20230308233822.31180-8-semen.protsenko@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index d67e98120313..aa077008b3be 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -200,7 +200,6 @@ gic: interrupt-controller@12a01000 {
 		pmu_system_controller: system-controller@11860000 {
 			compatible = "samsung,exynos850-pmu", "syscon";
 			reg = <0x11860000 0x10000>;
-			clocks = <&cmu_apm CLK_GOUT_PMU_ALIVE_PCLK>;
 
 			reboot: syscon-reboot {
 				compatible = "syscon-reboot";
-- 
2.34.1

