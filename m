Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FFC686ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjBAPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjBAPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:51:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C975781
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:51:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so17723707wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1couVN3p8ubraJIp/jDblxlgPB1MCelSkZqH7vVvn4=;
        b=rzUk5Imu2/SiX3cXxAwT8GSrTL98wIzvyxc+kQYdwBod54HzHuu6qucUqYUmHyQAsp
         JFWcmIigSZ5P4L2BW/N0dpjpQPZmdI6Ju5o5T0gn8/jDbJfqIVeAGLZnQ8oFYqhSTI0h
         jnhvKK6uNxcsvRWX9KatS1NWCWOCxp7mmSVNt8BXj14faftTZHlunobjL+vp29hY1UY9
         OcHnsvp1VYuf9Z9PeshmOeaLHKvWoeHO7pto1UA2LKkjlkjp5esCHKiq+ows8Cz3+ozd
         p+ghg1fdeTNQ8mNTWtd63mcDzuu0QZk8TyuJ5hG/FhwjfXVN8QDwMsEzDGQN72qMiQ8T
         zOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1couVN3p8ubraJIp/jDblxlgPB1MCelSkZqH7vVvn4=;
        b=opt5RJgMPbZvT9DnuXQLW0E6fWYsf4Gko7ywrE9L748CnDMkm5UAxRHPwOrIRh24sX
         GveeCxrDRkH8Gf+GyRJvtOET5YSiCeRF27pLfENQXyJRr0RK+X4UqezXhbVXim3tOP+b
         SolpQHfCCyxzXbQTMr5KnXs/WvIqMb9pNu2npT1/s/ljy+r9eJNQX+XUdB1KW51xfaul
         sZYS/m/MVdWEwt9sn1BLrjDEIFaSQ0uv8QCIYziYd8vqzrfHc9O2wiKqZD6v59iFKh/U
         fs2E4E9UXGiDO41UDSkKaGhyEfYGIogI5eaSfdDU+x6pMtNkhZXt9bxt20Q0/8673Kal
         AN2w==
X-Gm-Message-State: AO0yUKXTUqKFo7dIzv2ZhaWFFu6ikOt2Knl1gOdD7oK0DM3pRyAY5ZwJ
        csH7CJK2eDXn9NsKDev34DWmUQ==
X-Google-Smtp-Source: AK7set+NP+jJB23yndKLIBaxGiHM4JC1DqhzoPei3xboi9B3udiMjZ/Z7L2kAvpnIcB8d/ysfO2xAA==
X-Received: by 2002:adf:ee07:0:b0:2bf:d541:5084 with SMTP id y7-20020adfee07000000b002bfd5415084mr2153360wrn.32.1675266686107;
        Wed, 01 Feb 2023 07:51:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b002bfd524255esm14816189wrm.43.2023.02.01.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:51:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 13/14] arm64: dts: qcom: sm8450: correct TLMM gpio-ranges
Date:   Wed,  1 Feb 2023 16:51:04 +0100
Message-Id: <20230201155105.282708-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
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

Correct the number of GPIOs in TLMM pin controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d66dcd8fe61f..7014bdfd0035 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3073,7 +3073,7 @@ tlmm: pinctrl@f100000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			gpio-ranges = <&tlmm 0 0 211>;
+			gpio-ranges = <&tlmm 0 0 210>;
 			wakeup-parent = <&pdc>;
 
 			sdc2_default_state: sdc2-default-state {
-- 
2.34.1

