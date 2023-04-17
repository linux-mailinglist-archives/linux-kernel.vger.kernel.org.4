Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0366E4935
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDQNDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjDQNDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:03:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A26710257
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:00:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f169350f05so13550745e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681736331; x=1684328331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RxXk1daPTunKtbomjZDgpJNAfBR2cR6YhtK/lfK/SI=;
        b=MeOycZq3LbAiiK3Hm2X8W/COut++E+vIWCEtvBYWqenlv06pENIoUEQ6eZ6XufizqW
         c/IUnFjRoZx5Kh82hO7Xb381qBmCtD21juS/Cn6w9ecwglVp7oxZxnrxZgrAsHXfY5mq
         LsbgdBUI6g4cT8tuQ4BuoGShKwzaZHdQAN572xT4bEYp3Zv/NWTBfcPQt3eskP1WndI5
         CEtCP+Rbp5ZtWjKRW0C4RuUH4MzyDkUCOz7gR2lkgp8wcTU3qmjGf2PtjYRYrM92zFh3
         BOv7X6WX4W6YYSyUtOXlnJHuFSZHzniNJLbwbpw8imneTfm1K28gj68ULqVXsmNC0nRA
         qRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736331; x=1684328331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RxXk1daPTunKtbomjZDgpJNAfBR2cR6YhtK/lfK/SI=;
        b=R2jP6R86JOr/cqSYLFQVAa/hdzp7gnz1hykH5SOyoPTBFpt/zp5OA1pQ6wYfHVy8W5
         Yf1/cfRs0Cbw4YnH4dS+Yj0V9QJn8ZWz7WLeoBXkRFVvuHqiJIUwUUFX5xT/e1B/1ZK7
         PV2AdqlYOhSQ8ZO7b4XVT7udL1nWzuJwfkben53/udQApzPpaOSH3iU8eDjvO32BKu3B
         Js5vYgEZDDJZPUybrg5w13NRYLRSYbRGDX/l3+pVvtyK4WC2lq1ANHbaORCQsOQWpFb0
         0cPrQq1f6406lrUW9HJgIExjkLEU4nfk3+nKZNs9QjDrLdNuCjbQWd48LXhcaVGx9GJu
         lsIw==
X-Gm-Message-State: AAQBX9dUpHf8dB8xvI4vpUg5q0RNZat9BzqbszGnm4sPQddyksZcLpKm
        4lOZNVZ4NDpaJVebUZ/1hMrR8Q==
X-Google-Smtp-Source: AKy350aIVyNEBXkF1ad22KkjaB+EJlqbxjIr7CC8RxeYXKgwbn0e9AW2osiEulawxfmdhVqRDcIOWw==
X-Received: by 2002:a5d:5152:0:b0:2db:11f3:f7ee with SMTP id u18-20020a5d5152000000b002db11f3f7eemr4584684wrt.63.1681736331398;
        Mon, 17 Apr 2023 05:58:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm15557546wmo.10.2023.04.17.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:58:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 3/5] arm64: dts: qcom: sa8775p: add the GPU clock controller node
Date:   Mon, 17 Apr 2023 14:58:42 +0200
Message-Id: <20230417125844.400782-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230417125844.400782-1-brgl@bgdev.pl>
References: <20230417125844.400782-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the GPUCC node for sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index a23175352a20..191b510b5a1a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -591,6 +591,20 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		gpucc: clock-controller@3d90000 {
+			compatible = "qcom,sa8775p-gpucc";
+			reg = <0x0 0x03d90000 0x0 0xa000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,
-- 
2.37.2

