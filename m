Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0E60F042
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiJ0GbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiJ0GbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:31:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E333016023C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:30:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g62so548017pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLlikXIYYm3ImN3tz25/0YKQDQ+xQSa7BQvWQidZ6yE=;
        b=zhCQ3aZpq6ZDf34hPWRoiv1hj3cTOrrBHagCKsbf70JUKDDHrBzN9bOAcU7Et5tbob
         36ozbR9bnGjRhwyrsorrRr2Bx5Gd6maL6fhaIqei0V520tY2qEn+LYqAqt5bvxTHXjjd
         P0WzHumXGEb6fmIqLOgcUfRQOcDJcLWC3EJM+orvb6WFEWEFAwthA9mB5rypq3N205Qa
         JFd0jP+FjsFfEybz+hdtdCJ2ML8iUDzqyM/NbM3272H7/GBFTJ49s439UgbE6iOTHk5z
         dOH53TPi4HXfOtLflYkv1aF2uHgFW/gXkVCXYh4L2K8kKTA9uj+IcQ+blBW7fOu1dNIJ
         /Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLlikXIYYm3ImN3tz25/0YKQDQ+xQSa7BQvWQidZ6yE=;
        b=d/rHM/Fuog/ZDqod+x1zY9oojtEizzmj+cS7Fz7/MGlOhQ3i8aZK6lVMyGoQsyGn6l
         bRHGRQkuw64kszMVNaSD5eQEvIJy6nsXta7nQ/+gLKtIww1LnUSqtIBT8i7rqtjFJJhe
         PWkVHWoo3wnT4WBZVOe/OgjV7DBE8FsmBtNRxc4YNgje/QQF9Dpbj6qtQBVq2obY9aL4
         FS1eiAHjUrOpuxSF6ZHpvaZaW/+WUQDH3a5zB0czdVNQ1u3YXHfq6aKyb9KBmo1LSQaa
         X6sJR/t2kSg4CkZTBjCVimPIJJCRd22YIbCwi2ppk3IPOjBmiy8V1DpzUxAm1z40iJBy
         Y4gg==
X-Gm-Message-State: ACrzQf32GOsr4tzU9bgA6bJVVmGw1gSIF+fZWiBdhhZ4SqxKA6k7+gXd
        1QPxfn9/rnEa3AqE+ZcoNBjzvtCg1q4sSAE=
X-Google-Smtp-Source: AMsMyM44L3tewK/pBojjqbDY1Oo7JCMlsbKePhcZJWnVWoxpLSI+7Lyzergju3NjwvwP6pskCLrN+g==
X-Received: by 2002:a05:6a00:2485:b0:561:c0a5:88aa with SMTP id c5-20020a056a00248500b00561c0a588aamr47694155pfv.51.1666852249715;
        Wed, 26 Oct 2022 23:30:49 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.123])
        by smtp.gmail.com with ESMTPSA id i126-20020a626d84000000b00561d79f1064sm446041pfc.57.2022.10.26.23.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:30:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/11] arm64: dts: qcom: sc8280xp-x13s: Enable PMK8280 RESIN input
Date:   Thu, 27 Oct 2022 12:00:02 +0530
Message-Id: <20221027063006.9056-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
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

Enable resetting the PMK8280 through RESIN block in SC8280XP X13s.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index b2b744bb8a53..6aa8cf6d9776 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -169,6 +169,10 @@ &pmk8280_pon_pwrkey {
 	status = "okay";
 };
 
+&pmk8280_pon_resin {
+	status = "okay";
+};
+
 &qup0 {
 	status = "okay";
 };
-- 
2.25.1

