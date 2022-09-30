Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748C5F1258
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiI3TUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiI3TUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:20:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920C818C039
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:20:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d42so8355527lfv.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GY7Hsx1ipZGKpNWuYzGc1DU3a5zj/xsfWCrKNswDv9Q=;
        b=Fs7SY430gwqczh0i8JbOPJlFRodFt5PGc6gjJnelr9DFohGllXNIDA3LGqWAdgk5Ng
         zmcMg4wWFVuWRRGD3PgtVfXVR7VDgP2OnGY4vNK2+ufADQU107cycuqvZZh7spxomcW/
         2epN40BuN14YTihahW2DD1ZdkueROTSpMyrap2+f4NH5mKyppQXtyLTCe11k2oBpzeAG
         NR3mzqbuiVFlAh55zJhMiEwfji9Kn05a41Jk9ukNPbS5dsi+jyudLR7J8tVWu+SpH9tL
         jIG154jYDMe1mDRLgXPL1UJB1opcORMqjnlhTMYa+CRaJgxchS2ylXmwiOfiBK/m2UPs
         PhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GY7Hsx1ipZGKpNWuYzGc1DU3a5zj/xsfWCrKNswDv9Q=;
        b=l7aXP1O63flr65m1QRIzZLqZLn2TwsF3HTzo8ShsfNrQLJH5/YWqMg+ei7fw0Nk6re
         6v7aEfdPY2NAFNyGnN4TsRsXH3iTBAXz9heQ+UIytP8uJqbkj9VEQR5EkwTQpAt/2fHU
         eREAyN8WIAwyzl31Xwb1/b9pLZE118daXcY+lJ6AcdDVuFvLIPkcpcvV75j2HscuKkyM
         dSZUykhSOjrE2DTadpeVtHJ/9d8nNlIjdOhaJD6dbqYKlK/N+TE1Hrsv5Q1jQgl2nua+
         HJq9IR9Zutqk1nd3qaNrdnZQe350TbcQ1s6r5itJXazRsyxsSkmmw1FNoSi+mOt0eAMY
         ckcw==
X-Gm-Message-State: ACrzQf2pwR3Fbd9daeWOq0G12wRO+s5N8JXSyzbwWSnZ+ujNCJ+xw99u
        3Pb5vE9PbnawuUiBRSI+J07f0Q==
X-Google-Smtp-Source: AMsMyM6OkTHeHw6daX1EP3Z4RRKCc+lf4llf2NFJYpAx3YKMTOfWl59ocTEXrDPjyq+ulMoeFmcg4g==
X-Received: by 2002:a05:6512:1151:b0:4a0:50f2:9509 with SMTP id m17-20020a056512115100b004a050f29509mr4216903lfg.297.1664565644881;
        Fri, 30 Sep 2022 12:20:44 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c17-20020a056512105100b0049fff3f645esm390115lfb.70.2022.09.30.12.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:20:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Xilin Wu <wuxilin123@gmail.com>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sdm845-xiaomi-polaris: fix codec pin conf name
Date:   Fri, 30 Sep 2022 21:20:39 +0200
Message-Id: <20220930192039.240486-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930192039.240486-1-krzysztof.kozlowski@linaro.org>
References: <20220930192039.240486-1-krzysztof.kozlowski@linaro.org>
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

Fix typo in the codec's pin name to be configured.  Mismatched name
caused the pin configuration to be ignored.

Fixes: be497abe19bf ("arm64: dts: qcom: Add support for Xiaomi Mi Mix2s")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index afc17e4d403f..f98259489679 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -628,7 +628,7 @@ sde_dsi_suspend: sde-dsi-suspend {
 	};
 
 	wcd_intr_default: wcd-intr-default {
-		pins = "goui54";
+		pins = "gpio54";
 		function = "gpio";
 		input-enable;
 		bias-pull-down;
-- 
2.34.1

