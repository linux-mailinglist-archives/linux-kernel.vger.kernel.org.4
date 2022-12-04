Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D055641EE3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiLDSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiLDSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:33:57 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D913CD0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:33:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so15362274lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1IqieCfoZFtLnZIE+fSIvs4dAY2BrMYRR2MWeAYWb0=;
        b=vxPQaPg29C5WZnAt0fSPPLc6lbzgdY/12GwuWZ36xyk6Ter1svBXtHrzIKwuAyXBcT
         RMmuch884F13AlkpeEeSXOB+y4cOJS+IAy7NJC28TgX7/9xH/uyr1aBOJPQ6Zd5djzGQ
         Q9YSAQOo8EfbkY0sYv5e10f+fdPbnc2d9VYWo8et73ZVOlw4eH0hBMoG8c33sTuEkRa0
         3uz8nlQI7lzSinp/Id9DWOpFdX5MogpaxlZ20z5FbOE/PkQksZMo8OcGu57BqmBfufvC
         Lz2lVbov/BC81WVfXzfAyD3kTcryFZbIOaFpVBbOUbnK3foW3t4NScTmyhXFkQ9zDZws
         Kuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1IqieCfoZFtLnZIE+fSIvs4dAY2BrMYRR2MWeAYWb0=;
        b=SsECUYKYS3W091KoBJ94bDxmRa5Oj7rKcRYPupXHoLNK2vH28wvUTN5z7Czr/jd8vw
         IY2FoB7s8NCxNm3RbdL6j1Ao6uudhK3KJfvQWQbJO8zb5tieuybY94AB1Oj5K7BBH9Yq
         BHidVA9d+dFbwTlrlMN778z/O2axfmBhWbocYCGP5jkxGhjP7ZLTOY0OqEqRM1HqAspV
         3ltnQuZ+bGAZ85m+bOUm8NG3TaEGc1on8lCmR2MnHWUeCY0yNP3qA7d0OKiZFfDcvalw
         AY7mrm2lrce1aHTFbYA+8+aRd12V4tzkw6WIptJdVRRDiKit2vsFIWyWiaAQZeq5b1dC
         1eQA==
X-Gm-Message-State: ANoB5plLSf7xKZhPuM6eefKmm6EC6oM6eWlxySLjXbaK19CiNk3ArDkJ
        AFy4+RCMsxFTs3nC+usbSOYREQ==
X-Google-Smtp-Source: AA0mqf7bq4IIbfvV9+m1DTU6OcDFesCdO46eiX+FioaAz8tyARr+0wTLyUjogLOWy01du9woT9whXQ==
X-Received: by 2002:a05:6512:104c:b0:4b5:5916:a343 with SMTP id c12-20020a056512104c00b004b55916a343mr2659489lfb.123.1670178835010;
        Sun, 04 Dec 2022 10:33:55 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b26-20020ac2563a000000b0049f54c5f2a4sm1840241lff.229.2022.12.04.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 10:33:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: stih410: align HDMI CEC node names with dtschema
Date:   Sun,  4 Dec 2022 19:33:53 +0100
Message-Id: <20221204183353.140002-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The bindings expect "cec" for HDMI CEC node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See also:
https://lore.kernel.org/all/20221204182908.138910-3-krzysztof.kozlowski@linaro.org/
---
 arch/arm/boot/dts/stih410.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index a39dd5f7bcae..29e95e9d3229 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -272,7 +272,7 @@ thermal@91a0000 {
 			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		sti-cec@94a087c {
+		cec@94a087c {
 			compatible = "st,stih-cec";
 			reg = <0x94a087c 0x64>;
 			clocks = <&clk_sysin>;
-- 
2.34.1

