Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F97C5F646F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiJFKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiJFKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:41:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FA90806
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:41:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m19so711531lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mcKg3p6Pohn8Vn1d4FhSQPj1T9loM/91/c1jvNGcD+E=;
        b=jcbxaGf0H3aeaB4RrfODbQ2HOqpNviuB2COVcI4mwUz4vWaqxMFzYfotIV7Mo6Qtjb
         BELvh/6sJKSTZFBe78VpmloInHgSBPg5wql/ZZlcrobHFSs2NeJxPq4LdkbtRYBSBx8S
         yTgVnmAZ/bedRR38TJutIboDtvRUKnPGhQYK/4JRhCx8ElD/c2fQRwyYnfJfXAVpQ6Sa
         6XPKq1t9nddJZW5W757G0y1H1y21AQ+3UauqmP0VO7ZKbEsqoVf5XxV/jz4Mq3S6zKs8
         Vjt01qvuARYQ4zH+eKrsQJNmRuhc0K9oVsbXKlvhdUnwtaFdwwH7cv+fuuMh80fBwvIB
         zVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mcKg3p6Pohn8Vn1d4FhSQPj1T9loM/91/c1jvNGcD+E=;
        b=i2rDB76N0FyXuqSGnPqLOhkiFsXeD45z5GjcFuRN7yC+PIEmnAAFzJwH6v8ZZL4u+8
         hvmZh23d5+DrxOuv+dTApV6OOv3GZDyYh969EDLXv+gZgb1r65ky20uagQGqSd3ro0Al
         2X1X+MIv3bLQ/wXjuLGPwKfASeVBR7sALzpJfB1VX+qgILu+0EIOR3otOthRtFjXydZ+
         1THi4Jp7/iiaNe66AOLVpt0RK9po7BgqsXTUDJb7RxgMaXL9NQWs+x7x/Ji158NIRoi2
         lnefSxc4OYhBB7NKBsAQK1UVDaqu2HZieQeMaCrbtugEtklWH1rMLrLe9z7xT9foi7o8
         Xa2A==
X-Gm-Message-State: ACrzQf1sfBaG1mk0vUAwQezolaR/DX6Ya9LLaiVoYayEPaqtAnYf94g1
        weFI/WebU3mXHPoyf8+CTq2Xy742Z8OwoA==
X-Google-Smtp-Source: AMsMyM6LoaZV1DlOqMzWwWuGpl3blRAj2Plv7EZdULpyk5TFEz0DR5hca2axTU2Q0gU8zYVK/mjrEQ==
X-Received: by 2002:a05:6512:1392:b0:4a1:e5b8:f9b with SMTP id p18-20020a056512139200b004a1e5b80f9bmr1619605lfa.474.1665052869189;
        Thu, 06 Oct 2022 03:41:09 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b00492aefd73a5sm2648293lfu.132.2022.10.06.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:41:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] arm64: dts: qcom: sdm630: correct I2C8 pin functions
Date:   Thu,  6 Oct 2022 12:41:02 +0200
Message-Id: <20221006104104.171368-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006104104.171368-1-krzysztof.kozlowski@linaro.org>
References: <20221006104104.171368-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C8 pins are split into i2c8_a (GPIO30 and GPIO31) and i2c8_b
(GPIO44 and GPIO52).  Correct the name of function for I2C8 pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index bc7c341e793c..796c19b9b2eb 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -885,14 +885,14 @@ i2c7_sleep: i2c7-sleep {
 
 			i2c8_default: i2c8-default {
 				pins = "gpio30", "gpio31";
-				function = "blsp_i2c8";
+				function = "blsp_i2c8_a";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c8_sleep: i2c8-sleep {
 				pins = "gpio30", "gpio31";
-				function = "blsp_i2c8";
+				function = "blsp_i2c8_a";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
-- 
2.34.1

