Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14616B1116
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCHSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCHSd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:33:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D614E5EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:33:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ec29so38627921edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678300401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yBJw33XTi1NX0b/Xl1aRwxWtOkpJwd6CVMp3NR69ng=;
        b=ZoPOH6gY3hXX5Au1ZhMX6YjmuYIMSfU8pvJO31iIa7AHjEz1NKfieUSbM7my/rNpAe
         C+Y9E0YhD3sBz7GBZ2kpVKDIi32Honhoag33i2zJInkwGBuwYBHes7NmaSe6O1YArt0q
         GXYCO6TnLX83nhtte/Ktr7NbA24RxVWfci2gRhUrU5iPh6L/oRPlRarod8zPeAGlucMa
         unTg/oTFZ4Wtq2antq1qekrL34Uw/JrRYUB4wW1M2WP4/z5SLxd8PL4zuJ3nLB0ZUKkE
         jHOLM1c7LVXcXdtK6NlTy7RDE7sYBJGMT/uFCOAlPL7io1nY29z6REwVWiYR0t7+n3aQ
         3ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678300401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yBJw33XTi1NX0b/Xl1aRwxWtOkpJwd6CVMp3NR69ng=;
        b=Y8bxzYOHEiguN9ZsPTY8NZ8c24eAChF12gQIxgfNhPIuG03cRRQrKEScrMvSb7b46n
         FFy2uGPJQdRgo9Lljzrg8dF0ZLXrR6maZU0Uc4ExbfCoIV753uFA7cGZl46prckv1zEy
         dyyGO5Lbc2isTauMQ8JGvOTFk9vkqctUgVbslZaG+HFO4BcZq8LMxBE2y7h1r9PTJHnY
         lZyIT8WiIwCs9STZF0WGz5Jj6gUTzTY+bG+F5D2d34jxH/ivwNygIus8OUJ8zJCVex9j
         tqjts5pg9qFxG3ktGMHCjvsghAg6QpdaMF20MeTJrjZBafO9wwXrNAotWnQNXwCx4K+4
         Vzng==
X-Gm-Message-State: AO0yUKWqwnq1sw43ed9DKARJJAPVb3IVfFF7IJczJkmDu5HpxMXesmvx
        GSyWRwbhqjjRMA+b3eoBnWhaJg==
X-Google-Smtp-Source: AK7set/OmTKUifRWezVugTSts48SafOihe6bfq/R1iYKjb3vebzctk9hLKAjJ6384zPGbSMQuRG1ng==
X-Received: by 2002:aa7:c589:0:b0:4af:6e08:319 with SMTP id g9-20020aa7c589000000b004af6e080319mr23411028edq.15.1678300401256;
        Wed, 08 Mar 2023 10:33:21 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id r25-20020a1709067fd900b008e125ee7be4sm7852709ejs.176.2023.03.08.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:33:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8450-hdk: align WCD9385 reset pin with downstream config
Date:   Wed,  8 Mar 2023 19:33:17 +0100
Message-Id: <20230308183317.559253-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308183317.559253-1-krzysztof.kozlowski@linaro.org>
References: <20230308183317.559253-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream DTS uses 16 mA drive strength for the WCD9385 audio codec
RESET_N reset pin.  It also pulls the pin down in shutdown mode, thus it
is more like a shutdown pin, not a reset.  Use the same settings here
for HDK8450 and keep the WCD9385 by default in powered off (so pin as
low).  Align the name of pin configuration node with other pins in the
DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 9cd1d1bd86cb..4020e54e16f5 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -767,9 +767,11 @@ spkr_2_sd_n_active: spkr-2-sd-n-active-state {
 		output-low;
 	};
 
-	wcd_default: wcd-default-state {
+	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio43";
 		function = "gpio";
+		drive-strength = <16>;
 		bias-disable;
+		output-low;
 	};
 };
-- 
2.34.1

