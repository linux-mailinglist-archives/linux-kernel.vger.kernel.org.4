Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36916EB1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDUTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjDUTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:02:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84E2D56
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:02:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f3df30043so296871966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682103725; x=1684695725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UBS6qwpsvEyxP32TXwMi8fHBLYovTzCgL1PEPMBQuA=;
        b=DOB3Ioeq/rZx6nkgZaBN9mIZE/veSl/HxbvsKaSyApSgF2V9oBicjtQGTAItyB8aeM
         c+Z5z1lMrvqZ4HFN1sTPky+Hiqs1p+x6O7KSwj3oC1dMtbobpgQq/UkJRpWr7G4MI8VB
         HPESqVa/DTBbtyAyqJ8bPRosZY8w9rWgoKpEZRzmLQ77Xlo1qkntNhC2PoOIVTWpoEKQ
         JwnJ621i04/JTTM6BTzty16Q/zkcjJvcgW+ewYUGcuar5b8ZKe9+tnCBuz1tbANmUK5L
         ZRBE3HMOHoZDtPov+p7ovMRTJVhUthEggoClFDkCOUZDJDvXd1Ua56B5x6FgF3xY448V
         bFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682103725; x=1684695725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UBS6qwpsvEyxP32TXwMi8fHBLYovTzCgL1PEPMBQuA=;
        b=Ty57A3gx/lWxFRiViY+hzMT7pg/a/7XNczJxD/3WLICgvdfKz8TuXLSosBnxwyPbAS
         IPISQy8CDhIe3XvSh6VRKj3UTJ4ddXgfeqTO6aK6BCzVdEsf7RWVfF8HhHLQgtpKRg+h
         Gl17p3Mq/3bFI4FR/2YKC/XGto31dtuEyunveXpc8GVnBDJRBUpULx17DQ2uo9EBBhtG
         UFHgObD9tgeOUukyi46xQbErMPXYNXfZVvcaujjrVMuVpaSJra3VI9VUUR8A7+wFPTI6
         9byDAM6qaAz4I4aIQ48cyxUrBfPI4nRC1ggBE3DEr5+yjNYGeQOSLKPl8mBv25S8sJoo
         Qj0Q==
X-Gm-Message-State: AAQBX9e058UtyUTJncKt31Qc9gz19+N52+qwGomtvmThLpSZwhROPn8b
        nIJAFTqG5eNp9+dvvRsFLjEAYA==
X-Google-Smtp-Source: AKy350YsW2AxsPNc39fiucZ92EWX/p6AW1NDZ8Y2qO4dJNRiW3qIVSW2Q8N1evqIXOQheLneJbDZQA==
X-Received: by 2002:a17:906:71c2:b0:94e:e35f:6fed with SMTP id i2-20020a17090671c200b0094ee35f6fedmr3622193ejk.75.1682103725011;
        Fri, 21 Apr 2023 12:02:05 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906805000b00953285b937asm2376231ejw.189.2023.04.21.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:02:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: s5pv210: remove empty camera pinctrl configuration
Date:   Fri, 21 Apr 2023 21:02:02 +0200
Message-Id: <20230421190202.15471-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The camera's pinctrl configuration is simply empty and not effective.
Remove it to fix dtbs_check warnings like:

  s5pv210-torbreck.dtb: camera@fa600000: pinctrl-0: True is not of type 'array'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index d9436bbf77c8..faa3682ab5dd 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -549,8 +549,6 @@ i2c1: i2c@fab00000 {
 
 		camera: camera@fa600000 {
 			compatible = "samsung,fimc";
-			pinctrl-names = "default";
-			pinctrl-0 = <>;
 			clocks = <&clocks SCLK_CAM0>, <&clocks SCLK_CAM1>;
 			clock-names = "sclk_cam0", "sclk_cam1";
 			#address-cells = <1>;
-- 
2.34.1

