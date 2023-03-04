Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0856AA982
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCDMeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCDMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:34:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F261912BD3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:34:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a25so20766379edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677933245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96ZP1+oyQdaUDT+oMwePihIvFGyDM6mwA3PXNfLtI3k=;
        b=qRvDwm/avojgYVvpCCeeoX4Vl/1yTfGCOGNSf9/8tf0h2Y3ITBbaXxuv6Q1wrqWEpG
         PefYfTRjDevBsd/yh17av+nLQJ5WrmO2mEgSdFnL2MS9XKTiiCMXBk4dwUHby5iNJK4G
         GL63VA/d8dnDxsPAUkXQl/Fev8HQMXOuinopHhAhOEMGc7pDqCu5SkPGLOoyzogdLPV9
         DVy8nnFo9KDE+fI59v70Qy44pcFIBfed2piq9vCp6N1Lrqc57IaNoBvOZj+YqFJZ+NDG
         CO6EGkBpiZ21zn83LBnrqJCUgrqxdhsC482PF2eMKOQTaKIUnXJl1EpI/qJJf7DlbG/z
         wyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677933245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96ZP1+oyQdaUDT+oMwePihIvFGyDM6mwA3PXNfLtI3k=;
        b=l8lB9Q8jyNf37ZTgUUIgYbfrM6BBGS2CsHqzmr56QiUHsm32Q/ofrCA6i82L3Lc5lt
         qo/wVm3x+am7qFA0YJIXvYhSFacMODkjoft4GHzaINgtCsKtNUQhwLnN2PftWk/7rMqT
         Ij7UNC3Y949/+Itv7RS5CPQkRIrhd1BO4zHnSTzly3sWPohNmC8Y51RD1PY9ua5TuzsC
         9WImvzwfLns2SMPbielWiQtxhmwO5nvlQLgHIQUvcdudF6fdahQXr+xE12cAGWkuoq6o
         4ZmGfrCpncSqkBDLTcR8FbRk0szZQGvf3XvyB5Se8m9QqoXbdwxib3eyo8psFVNSMGnf
         JfXA==
X-Gm-Message-State: AO0yUKU0nizSK51mCj/0pVCDHHaj0Joon+PX8eIOPbm94PjduplLfbds
        pxowOTssFzx8h3BHr5jwLxsqqw==
X-Google-Smtp-Source: AK7set/mZJuBjStXZzhQbTe0qH2NPF8vK7M19egDYFRrRn2ctKSALj8tN7XSNNPnKUuCeS/FqFEhsA==
X-Received: by 2002:a17:907:a04:b0:878:6477:d7 with SMTP id bb4-20020a1709070a0400b00878647700d7mr5941220ejc.72.1677933245486;
        Sat, 04 Mar 2023 04:34:05 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id q27-20020a17090622db00b008b1787ce722sm2017087eja.152.2023.03.04.04.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 04:34:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/8] arm64: dts: qcom: sc7280-idp: correct GPIO keys wakeup
Date:   Sat,  4 Mar 2023 13:33:54 +0100
Message-Id: <20230304123358.34274-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
References: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
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

gpio-keys,wakeup is a deprecated property:

  sc7280-idp.dtb: gpio-keys: key-volume-up: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index cff0e0d31c15..b4b9d5e5cbd6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -70,7 +70,7 @@ key-volume-up {
 			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_VOLUMEUP>;
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <15>;
 			linux,can-disable;
 		};
-- 
2.34.1

