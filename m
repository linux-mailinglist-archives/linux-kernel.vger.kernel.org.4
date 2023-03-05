Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEB36AB142
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCEPnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCEPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:43:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101D7A9F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 07:43:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k10so5045047edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678030990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZhAqHuci1RWlTDGwl+KlPP4K312EVV0utv3oT4mocY=;
        b=JQfeDmGb773XlYyqRJ5fgnVZyeFhj4mIWuOMhoL6YUcUX3pjyNc59ngOXcltluOk9i
         CuDHNI+7+rvZPNFWWMEoGUT8EzxrgqqJouxuWUVyaFNCY2SBnWa6tlbritBWe8fj8iPT
         vcPqA+bbaFaDM0xEohIgumaqQuCXFWoce10FN0XAFdFIZ64b5NDv6N/UqPS/WtoXuRuo
         lZ8TpAGFNU1fyuOC0C7nITa/YHmk5bSiyGAT0PzmK7epeYcqpIJvrCFqIwy4Q4/1VSj1
         aoK8W3T+wwj+3LLiD1Ua/rOyM4HbebCHwoC3L4wYlFGLXDCysXQx7sUC8ikyfuMZn8IO
         yQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678030990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZhAqHuci1RWlTDGwl+KlPP4K312EVV0utv3oT4mocY=;
        b=T/Fyp9xHdF9WkKRPx6KwEkY5v0DRckWOcYXjGstFSPRgmYiDX3vOiOIHDmzIfO+dbO
         OivDJ/dYUFQLQphEN+MvtSr8PAktKIl5NRJbhgF+5gFXS5aV03R7DpbkmCqqjap+OYu/
         LO7edhUtqc0E9LJLXsBy6H7mkMnEnHOQx5qBKFqTkQx5uDLI2YtwvROm5VNurACX21wf
         yZ4FaI6MMhZzlMlfWqFMpGi2OK0gHAVzWm7bGi0+bqg56ueg9cGz41pemlnaoVsRLbSA
         HahANB7jaG4+thuvBFfc29pw1prEufVnax5lWLoJEK7Qlq5i6YnvJj5mfE9p3eE66ngf
         O0Og==
X-Gm-Message-State: AO0yUKUE4MRHcDjPLFqy7jrhehWXKPZtHipD38/x9o+Rv4n2w/rD79sJ
        DWXt+P2K42tGsv5TdKHoLSqEGg9IRnN8dmlPCAk=
X-Google-Smtp-Source: AK7set/MC7pPlD8NAif2wx5Lr45vnw0rPQoRyS7fTN9jgj2Rw5lvM7MOEW5UEOJQmL1L31B2UgHDpg==
X-Received: by 2002:a17:906:16cd:b0:883:3c6e:23eb with SMTP id t13-20020a17090616cd00b008833c6e23ebmr7409295ejd.42.1678030990655;
        Sun, 05 Mar 2023 07:43:10 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id v5-20020a1709063bc500b008c327bef167sm3346550ejf.7.2023.03.05.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 07:43:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: pm660: align thermal node names with bindings
Date:   Sun,  5 Mar 2023 16:43:08 +0100
Message-Id: <20230305154308.241651-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bindings expect thermal node names to end with '-thermal', so fix pm660
and pm660l:

  sda660-inforce-ifc6560.dtb: thermal-zones: 'pm660', 'pm660l' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm660.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index fc0eccaccdf6..4bc717917f44 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -11,7 +11,7 @@
 
 / {
 	thermal-zones {
-		pm660 {
+		pm660-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index f9b3864bd3b9..87b71b7205b8 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -11,7 +11,7 @@
 
 / {
 	thermal-zones {
-		pm660l {
+		pm660l-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-- 
2.34.1

