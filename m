Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79126E0E54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDMNRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjDMNRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:17:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE16194
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:17:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so15947164wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681391837; x=1683983837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aESHnUR1O/61n5/lfPsi3I+Fy8BChJQIQxTnoiWBoZM=;
        b=NPDKRqRhXu9gB7ad0+HipO+LO7EdyiPdFBX+cbn+ldIWVtVPPCcFpHknPNruo3Ieh8
         8jDqsJFjadsfs1LNgvOtQGADuxSTFi75F70ITZ1dh3zd6WvL1bCQIAH88bqfvzsCG5CW
         N/7uV3cxhXayOT7o225y4swYx/6OnLovSNig3tRePA9Bry8EVc59XaKjpeWQQgrWUWAC
         JREEs84Lh0H8EYlccci+RqxNyDumE/veGS6XuRwDAgT7mlf55btS9Jhw+l8TnnYjK0xb
         w2VUds0UzqLNlmWJwEmUzDLhNicsRolmmeKucRXMF+uONI/6xJwi/nf5EZWA5UdQSimO
         1lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391837; x=1683983837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aESHnUR1O/61n5/lfPsi3I+Fy8BChJQIQxTnoiWBoZM=;
        b=Y1cj6FrF/hNrBROjVevdcBRz0mEOrXR//msYRiehAxGoj6U1EYdsuopfoksRF5AcHJ
         HZp+ewqqwhJ/SD+Ux1iffmY+5PfLFB74Cx9e4risil1NIb7FgOLoITMp7RTAE7I3g2G+
         bRP0YIg9pNEO/CfaVUM11aN6z/+wddWOYsmt0vOZUApaLV84TbwIsWUUSqQz0LI9YlxR
         V57szVTPSZkvtj9x4TTrtkho3DATD6nyJTjOdkWLRWCRO9i+xwszQRoVCnbXRzCagDjl
         a3e6ELwU9SMwvW/7ti5McmJMKDN6Gs/ZQbDTw6lKKjDao1EC+g+kZaxNg0BKQf9d6kUZ
         Ebww==
X-Gm-Message-State: AAQBX9doez0JFQ8XqF/qvtie5gdQCZa0YBzNwfpVCuG/8GXoks3zNLcJ
        DPXkcK66vsxyFb2Jwn9P3LNMKw==
X-Google-Smtp-Source: AKy350bvrROxb1ZoO3jmn2mMCqa7Z7IQXD6ThE4Um58m/oLTMv+a7KPxPlbwn775JAYUjIu/cBs62g==
X-Received: by 2002:a7b:c7cd:0:b0:3ed:a82d:dffb with SMTP id z13-20020a7bc7cd000000b003eda82ddffbmr1778585wmk.40.1681391837607;
        Thu, 13 Apr 2023 06:17:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:814c:fc8a:da02:39ad])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003f04646838esm1796400wmh.39.2023.04.13.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:17:17 -0700 (PDT)
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
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/4] arm64: dts: qcom: sa8775p: pmic: remove the PON modes
Date:   Thu, 13 Apr 2023 15:17:02 +0200
Message-Id: <20230413131705.3073911-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413131705.3073911-1-brgl@bgdev.pl>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parikshit Pareek <quic_ppareek@quicinc.com>

Remove the power on reasons with reboot from the pmm8654au_0_pon.
Instead, the PoN reaons should be part of different sdam_0 mode, to
be interoduced.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 7602cca47bae..5abdc239d3a6 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -108,8 +108,6 @@ pmm8654au_0_pon: pon@1200 {
 			compatible = "qcom,pmk8350-pon";
 			reg = <0x1200>, <0x800>;
 			reg-names = "hlos", "pbs";
-			mode-recovery = <0x1>;
-			mode-bootloader = <0x2>;
 
 			pmm8654au_0_pon_pwrkey: pwrkey {
 				compatible = "qcom,pmk8350-pwrkey";
-- 
2.37.2

