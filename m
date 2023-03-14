Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE56B9E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCNSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCNSbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D39E96C24
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v16so15291499wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxBrX1NWYp+3HnLvrlf897r1N1zZpdXR7rlRu5hhqDg=;
        b=pICVgj8elx2mFW3eUMi9S092QcWclrWATXpZPnmhUSJXvumj1j249yRmgMGD+cpDDN
         asU27Etja6slJ5LIWSdErxIUN+Uz5RorT4OW+fUBYXxqOUxKKRP3fCTuUDKJaX20wyBz
         E6Ym0mhXRSM0arKOtrPRkPct8YnRo3G0IFzKqSW7ngeuyxkmHXuAvrJeDL/9kge1SqTN
         i3DE+RWkBdxQSqZQPPIv/sjpmxL7vfksw0k8lyOaw7bp0YoZP1GFo4+mwQNLNeebmUsR
         w+acJ8h2v6w1O/1Sb4SHNjKY0xh7ij/hyivaUtsv2r/PKkmH+CMCZi3cRxTt5e/6KEEK
         eHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxBrX1NWYp+3HnLvrlf897r1N1zZpdXR7rlRu5hhqDg=;
        b=aXVJnOiCLk06Sr+TaABqVapfgQru5chAcSntn+Ug+0o/hlJJHxaF4/Fxm2lI4YagJ2
         fyPRScRU9C2juY9YSQlfa+141wkwD/gbkVuwXKn3/u19TinZrl7AXC0FI+BGEuBsgmdn
         yyVt3uwSBNVfeHvF8aN28OhhIRt/im3POPgzmGeoQo/uB3nNdHTu7/xN9onXprcR02gp
         5LMeycz4TmyvJrvDbz8h4nzYX4D4Kc030zdc9Bel2ggpPssiucnUGWN2VQ5Nq/gjn+lp
         4FeZVwFeOCUv341t4psjfUJ+vk5Aw9q8s+CpScDgKa+e9BJeJrluDflu5xNOk0QjBeeT
         nKOg==
X-Gm-Message-State: AO0yUKUrCJK4emWSQLzjPn+2+TCsYvuH8XVLN18komZlfpW/gAM9l0lA
        p7LjAETLrnwionqTlhs/NiKLPA==
X-Google-Smtp-Source: AK7set+uozuvRtJKYJjlfce49HT6JQqRs8enc2PSqQ6DGStvmUNvbqPQpPsIUkTvTsP8DhpXH85hLg==
X-Received: by 2002:adf:e848:0:b0:2ce:ab8b:c29e with SMTP id d8-20020adfe848000000b002ceab8bc29emr7324530wrn.15.1678818663083;
        Tue, 14 Mar 2023 11:31:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:31:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 10/14] arm64: dts: qcom: sa8775p: pmic: add support for the pmm8654 RESIN input
Date:   Tue, 14 Mar 2023 19:30:39 +0100
Message-Id: <20230314183043.619997-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
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

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the RESIN input for sa8775p platforms' PMIC.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 874460d087db..d55fa5165864 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -25,6 +25,12 @@ pmk8775_0_pon_pwrkey: pwrkey {
 				linux,code = <KEY_POWER>;
 				status = "disabled";
 			};
+
+			pmk8775_0_pon_resin: resin {
+				compatible = "qcom,pmk8350-resin";
+				interrupts-extended = <&spmi_bus 0x0 0x12 0x6 IRQ_TYPE_EDGE_BOTH>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.37.2

