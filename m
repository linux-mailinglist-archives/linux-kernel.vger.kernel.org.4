Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86906EA7B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjDUJ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDUJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:57:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73C3A5F4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:57:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so10700233a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682071059; x=1684663059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js5v1t4KKnCssImdfdgDTmPMhwTRtlT+yhAUL5IKccM=;
        b=gcv0aLa2GGY9gGt5yZH+k1fb+BL8NDxwHwPBapEkU9AqJsWo56kLftbQt7YVSrIkOq
         wBK+IJTFCF6l2Bb60apK+xD8BCvTYfAPZkcRfW/S3rRYAW0EaYo73irxPnQkmtyDuXJD
         XNUKQULVdtoXQlNfvlC/JaDjnMTZmhG9Vi5plGmcqRSgB2R2xk3h2ITPCceSqObkCmaH
         RtQhoFOPDWphrmVGF87NykoyyOAKCjndvrLGA0obYmve8wjU3NTMKDt4AOI+JExCLAQa
         wBwrjVO+8NzZ6CBu6+yLj25nZ5iDCslBD4qeM7Gvwy9jqr/yGauBPc4XhJNFstlgLNqs
         XG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682071059; x=1684663059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js5v1t4KKnCssImdfdgDTmPMhwTRtlT+yhAUL5IKccM=;
        b=PftQ/tAI4OsEpER+HoBqu51m4Y3UTut+AyceLEUouH5vCq0Gr6QKEn4Wr0h6EKyZJI
         Ww1+rnTMWM3gyWPmpbI0uZS7AyRcbUl1xn8QksCCopILUa2tP/wEUO1HSghSeKP1QoQY
         B/Xhy3L48y+Qko4rHXy6MxATQiMX2wcjogF9KgTfcJz1oJAsbP4cbxGL3SNWaibwtCL8
         PAb3YEx5vQUPgnY7dRlgRkpaV6uICtwubcea2sDLnQHanWs4aJ45IDyXwY6ouKA/kZ7G
         6osa6DHcBhT7VaKEEVhvCwoguYCUn9E86a191OdfRcc+hdi2964hFH0d0NWCiuJTtCUW
         j7GQ==
X-Gm-Message-State: AAQBX9fK3BvTts2zz1Uc/GYWJEfYgQj35gjM5tl1f6rvEzBUFOGsCCu8
        6N1RyS9lMqogN93Bs8ryWJrVXw==
X-Google-Smtp-Source: AKy350ZixIK8ktBnRps+cQbP6PThFK5nahFtaZy5IB68hFKhBMjU0XhVYLDuYrLXtxvJteJt+QntTA==
X-Received: by 2002:a05:6402:1353:b0:504:9e79:e86f with SMTP id y19-20020a056402135300b005049e79e86fmr4041444edw.18.1682071059033;
        Fri, 21 Apr 2023 02:57:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id f7-20020a05640214c700b004fa380a14e7sm1686062edx.77.2023.04.21.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:57:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Pawel Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ARM: dts: s5pv210: re-order MFC clock names to match Exynos and bindings
Date:   Fri, 21 Apr 2023 11:57:20 +0200
Message-Id: <20230421095721.31857-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421095721.31857-1-krzysztof.kozlowski@linaro.org>
References: <20230421095721.31857-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the order of two MFC clocks with Exynos4 DTS and MFC bindings

Link: https://lore.kernel.org/r/20230328114729.61436-1-aakarsh.jain@samsung.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index fbe7f3d17f41..d9436bbf77c8 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -452,8 +452,8 @@ mfc: codec@f1700000 {
 			reg = <0xf1700000 0x10000>;
 			interrupt-parent = <&vic2>;
 			interrupts = <14>;
-			clocks = <&clocks DOUT_MFC>, <&clocks CLK_MFC>;
-			clock-names = "sclk_mfc", "mfc";
+			clocks = <&clocks CLK_MFC>, <&clocks DOUT_MFC>;
+			clock-names = "mfc", "sclk_mfc";
 		};
 
 		vic0: interrupt-controller@f2000000 {
-- 
2.34.1

