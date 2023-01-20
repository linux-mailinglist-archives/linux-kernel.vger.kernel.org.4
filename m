Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFF675B95
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjATRcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjATRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:31:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68422DF97B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:29 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4246490wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnJsl+tKHBAuLUhbXOInszro3NqsIemlyvle96ntb4I=;
        b=PgcV440RcWEhqyIj3zPrNb8+YnrO24qe2W+1lWKDgXlsby5MzIineuz6lPc7F2dPu9
         eMiYBPRBxeEtpXkV0Gtnbp1TN/HB06vuu8IS0llMGLYeHtlo4RstthsyfOC1mF0/5yn7
         rpBWgRIoIaICRxeFpZm2/kunisTENcMVn4SHMIWXvquoRjEAXPexYnci/nd19N5dI9h4
         WVMmvKGU7Qj0HAOgrdcGtv5H5ZNdqAPdOZhvaQkTHcR7f5Oo8MokOXDj6IQv4q5ITVqI
         2GqpOKv3/H+ivB/yjOhr6WKJ8iqgTWMTBR6wcxzdOJBhyPJqh880BukYRFsXgd7uGkwk
         G3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnJsl+tKHBAuLUhbXOInszro3NqsIemlyvle96ntb4I=;
        b=BbP0BqoCNurwXKKfTtR543YpoYZ+KbSMzyjPCF/5gCPIMpqGOCED5Nbw3JxcOwuPPV
         VkYHkVqQiCibKumrAtXp8qFz2paeI7Rd4fUzVobPrZTHSaro9+f9fEKuvwr6Itn72wVE
         u8Vim656NQZc4XeBnuNxuq3EqzFFKkFQnT92QCVT8N3O0thc8Qj9EVNqhi/4tPEUvrxB
         YfcszVgYtxnXreMjfXI3jlgvEz8vyuBzaAr5IvNaxlu7Bdavyd+HyeEZfAaXdsON8bOg
         +4qhtK8+Wkl8avxPnnDUrSwvSWsHqfnu6tb11LLYJHry9mTd6Rv0osw5KVO1V7/adJ5z
         uzKA==
X-Gm-Message-State: AFqh2kpPMd7TWY2MNG8bQ44P/HwUYdK2KrgsynunkUglRjO0qejAieDO
        hc7jcHtYk0TOV6iEQCWOoVABuQ==
X-Google-Smtp-Source: AMrXdXuxn+Rgj/bSyedEi7mHhJzfjwZD1lT14YpwdvDBJqgJQI6G0zsLISH0IBj7DModcu6AaxOu2g==
X-Received: by 2002:a05:600c:54d0:b0:3da:f9c9:cec9 with SMTP id iw16-20020a05600c54d000b003daf9c9cec9mr15077027wmb.1.1674235887758;
        Fri, 20 Jan 2023 09:31:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003db0dbbea53sm2819179wmb.30.2023.01.20.09.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:31:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] arm64: dts: exynos: correct wlf,micd-dbtime on TM2
Date:   Fri, 20 Jan 2023 18:31:16 +0100
Message-Id: <20230120173116.341270-6-krzysztof.kozlowski@linaro.org>
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

The wlf,micd-dbtime property of WM5110 codec can be either 2 or 4
(driver ignores other values, so assume author wanted something here):

  exynos5433-tm2e.dtb: audio-codec@0: wlf,micd-dbtime:0:0: 1 is not one of [2, 4]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 5124027d7541..f54f30633417 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1291,7 +1291,7 @@ wm5110: audio-codec@0 {
 		wlf,micd-detect-debounce = <300>;
 		wlf,micd-bias-start-time = <0x1>;
 		wlf,micd-rate = <0x7>;
-		wlf,micd-dbtime = <0x1>;
+		wlf,micd-dbtime = <0x2>;
 		wlf,micd-force-micbias;
 		wlf,micd-configs = <0x0 1 0>;
 		wlf,hpdet-channel = <1>;
-- 
2.34.1

