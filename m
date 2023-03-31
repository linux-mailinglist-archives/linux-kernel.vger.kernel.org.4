Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0496D14CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCaBPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCaBPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:15:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F1CDC1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:15:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bx10so3159227ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680225300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blSlteeDXapXNIOhzXC0rq6pPvL6cTVyW1O/lnNGmF0=;
        b=VC6VR4H4P2QtQTCqLLC4/MwOy0wHaM5qNA8k8sWIHp52m8jZ3puSBQxY35FlCNKRN9
         h/DDCnw3q8/QmtFLdONh3eRfNJ3MHwlQepC9ulr73d78X7vfiamM/Phln2RRc9+CSEyd
         eczSC3hxuNsyYFU7TVRTqrOzDxom/eIbxtLDnWuqA1amNr6IP9iDKkkzOUP3NmrTSOLx
         Tp48D9QSaoPowZXXMN5lvTyYAdQmBamgBGUz5zh0/E8FCbobitRkauSjl4Ip61NBywDl
         NN7jqFx9CSYEwmVk0ypX2LshW4tR2+frPq52XQr+2Cc7TgYyZ2TBag8Rae/x8AwgM6DL
         Qx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680225300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blSlteeDXapXNIOhzXC0rq6pPvL6cTVyW1O/lnNGmF0=;
        b=Dr94nAMRu7JpoWBSXobjUJIyG7y39bWmYnYPtHc7AktfFRMmfS0ZR+n8rT57EyftOb
         H+wEumo/i2tRKPInzjqgsEKh4RBR+n+TYSrY6RrfLUyyPYJ4QL3sba/BJpydSbVmwArw
         H78es52UIvr9jQu5WDtkfOVHkQujr6q20Mci/v2uq9peEh1zp99fCyfg5byvOUYVqoRM
         iGNGC/JIXmhaayFOIU+4QnhgvWoo07fwvv73DxOd5J/wLy3mMf7Ivb14U4NB+NBs5zp+
         9h3ik6CN4FlxPRiQfzF6pBvr3cZCqAQJFttqzsuRP+7jOqwEMNG4FX/lQnLw2wYCkSs3
         2sqA==
X-Gm-Message-State: AAQBX9cnjG06IsAnhL3NYuRVV8nh02z6Ts09bDQou2EZIkV8dLw6VTE8
        qMAUoQRGmkGXXP8v0zW3YWIArg==
X-Google-Smtp-Source: AKy350ZpdL2xRJDO3dcjEIxVtBd1inbA8qhKM8cNhv10xX3sjGvkxPLXSkYKejUQinZdqL56MPjhHQ==
X-Received: by 2002:a2e:9b81:0:b0:295:a8e6:6b15 with SMTP id z1-20020a2e9b81000000b00295a8e66b15mr2359539lji.4.1680225299834;
        Thu, 30 Mar 2023 18:14:59 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id n7-20020a2e7207000000b002986854f27dsm134573ljc.23.2023.03.30.18.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 18:14:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 31 Mar 2023 03:14:51 +0200
Subject: [PATCH v3 3/5] arm64: dts: qcom: sm8150: Don't start Adreno in
 headless mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-konahana_speedbin-v3-3-2dede22dd7f7@linaro.org>
References: <20230331-topic-konahana_speedbin-v3-0-2dede22dd7f7@linaro.org>
In-Reply-To: <20230331-topic-konahana_speedbin-v3-0-2dede22dd7f7@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680225294; l=2441;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0bRNNECqfQgn0pE7kzclN0Aj6mArWM+WKgBFrwJE5/c=;
 b=rY3AlxaGIds0zRkZc6EUU8QyjZ2q/ehkONWRm0jX7zPOtPLrGM+GM/crsgiPjJVlzNqZTedPu68T
 dRs/eZDgB18cMnsKLK17usLH/teBLab307MB3WtKpMfneulMWUq4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there's display support, there is no reason to assume the default
mode for Adreno should be headless. Keep it like that for boards that
previously enabled it, so as not to create regressions though.

Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Sony Xperia 5
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts |  5 +++++
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts |  5 +++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi    | 10 +---------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 8f014a232526..c0200e7f3f74 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -359,6 +359,11 @@ &gmu {
 };
 
 &gpu {
+	/*
+	 * NOTE: "amd,imageon" makes Adreno start in headless mode, remove it
+	 * after display support is added on this board.
+	 */
+	compatible = "qcom,adreno-640.1", "qcom,adreno", "amd,imageon";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index eff995a07ab7..34ec84916bdd 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -354,6 +354,11 @@ &gmu {
 };
 
 &gpu {
+	/*
+	 * NOTE: "amd,imageon" makes Adreno start in headless mode, remove it
+	 * after display support is added on this board.
+	 */
+	compatible = "qcom,adreno-640.1", "qcom,adreno", "amd,imageon";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 9491be4a6bf0..880483922f22 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2157,15 +2157,7 @@ compute-cb@3 {
 		};
 
 		gpu: gpu@2c00000 {
-			/*
-			 * note: the amd,imageon compatible makes it possible
-			 * to use the drm/msm driver without the display node,
-			 * make sure to remove it when display node is added
-			 */
-			compatible = "qcom,adreno-640.1",
-				     "qcom,adreno",
-				     "amd,imageon";
-
+			compatible = "qcom,adreno-640.1", "qcom,adreno";
 			reg = <0 0x02c00000 0 0x40000>;
 			reg-names = "kgsl_3d0_reg_memory";
 

-- 
2.40.0

