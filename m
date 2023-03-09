Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0AA6B2561
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjCIN2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjCIN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:28:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5D3756C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:28:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h11so1865527wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678368487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtWbseXe44RglGnP3KkkWaYT0dETHkwgZdTGBceqS0Q=;
        b=u5ooiJGBQ002hKpbJDzALR17vuCNcAit0NUuarpyHoDF0Esd1wjQb8Y/crdhPHvJc9
         ui5E5RcpyopqJoZqZK4dkIeV1qHcvpWNYVsQRHkFYOu/NkQVPeEHRGyClCielLMl4ZVr
         2LUQDVZNNqxQcG4FwHBC9Og8u5EY/vMAdAwIURU+RSMiSEEwnwWwkqDXHLC7kyiC7BZs
         CM4BrcnXAKiY1j/2PZae4QXnTtuCxhI+FezHPbE3ogQmFtAQb35nFyz26wuaS+4aojnq
         YFoXedQjPM4G9zhdQUfV0Zj/FJgqKUhZDR0q5U8cSDBcSGGSB8RRChu+oaWuMojSP4Q+
         j46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtWbseXe44RglGnP3KkkWaYT0dETHkwgZdTGBceqS0Q=;
        b=S8PpJYXemxeNHx6Fpw8DbLkE/fNUgd4P2zncAF6A1rmagD8U5/IZDXqPqFFpTYbGk0
         4yeHA6L5sC+5mrAlzjQWyBaCa2s7wFZghr5m44khaRazee0hQMe7JVwiXm62ExRbY09w
         QmovnIgtaUX8kHP6sqUIcwUGOLamNljceK2D+t01v9hJyftIUWQsEMqJE5K5xjx1bFQW
         8jnMs74rOlhpFOxkBkwirjk7TsnQNToO62I2jAfXe9KorywyLI3586kLjhF5rJJuf0GG
         TR4cdY2LAtAYYhEu3WUtgMLS8EYS4Z5YX+FcfIRPCnkKlyZI9ghvcQu/DIRf7AYyl13A
         oH3Q==
X-Gm-Message-State: AO0yUKWijujVLDt+96rHBCpiPdoWVkLyEeBW8B7KQYRGrTgharmQVakH
        4hTzs/jpjFQFtKs1Pa/ZnmgLug==
X-Google-Smtp-Source: AK7set8vlbf36N39axD8nTcEi6Ddpds4Kt160IpewgvE2BhkyctnxL1QuB11kFfnUy2ozawTG3/UDA==
X-Received: by 2002:adf:ff92:0:b0:2c9:6562:232b with SMTP id j18-20020adfff92000000b002c96562232bmr13268587wrr.2.1678368486979;
        Thu, 09 Mar 2023 05:28:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003eb966d39desm2926714wmo.2.2023.03.09.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:28:06 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Mar 2023 14:27:57 +0100
Subject: [PATCH v3 06/12] arm64: dts: qcom: sm8350: add port subnodes in
 dwc3 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v3-6-4c860d265d28@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ports subnodes in dwc3 node to avoid repeating the
same description in each board DT.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1c97e28da6ad..c88ece324641 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2260,6 +2260,25 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis_enblslpm_quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_dwc3_ss: endpoint {
+						};
+					};
+				};
 			};
 		};
 

-- 
2.34.1

