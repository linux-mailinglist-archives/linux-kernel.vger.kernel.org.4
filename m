Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2975F65A462
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiLaM7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiLaM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:26 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF34DF22
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:25 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j17so25675791lfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC4KquS4PXG80qs7tBamab98eZOLfMD9893rTZBGhoc=;
        b=ujtBjonN+V4sK0d9LXde2VLPsJ/lxgC4GTHzfRi75LVt0jn2v5+oONruazU3gYTSXm
         V9ZVNEbwFWDvMdbjhDsP75i3Fd8gyJ7gJwqIejuDfdFtrfFXgOfkLxNriTlSegGaJsI5
         n6i4ippt73uFhZmOUxiAv4H42XaaVQ1UckSaeRMqMRm5eBq/S0HeqJbNwpBCeIGPRj3d
         QJoZMEcivR8WH7kiBw0BRsIMJOXqyeN9mUrFEeaOhn9CqDGbGUd+fItJL232uKttPmxo
         PsQf2bU6VJMXOmsjhH5mn5IA8IXyc6Wk1GeNmFHlnBElsdFEdQjmdXoxhfcyIDFLTt41
         DWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC4KquS4PXG80qs7tBamab98eZOLfMD9893rTZBGhoc=;
        b=gE698i0UWjAaTMejQFXNlVI8KG+4GZ9Ii7gz6o8m5RwvDvuIfzEGLmBR/ihWIvcOBk
         FaaG7UOST5L6+yCF7qRxQzIeqE0sqpH93Lib5tAtMdmshR2W+31YB8MJfUXcXCPzVCoQ
         AaFd3VocvnLCSUySMfMDSpvSKJm5ZxkvnLQjJ9erdzdw4l59VTHFiVOyOQEEP5v/h74/
         xbdAnaW/1KzBidPJjYKIUD6LNueiA29tu2JL80T8rPc7ODW6NyxR3nVa6knX61jMYFhk
         2ogQHkr63mIbMv9LUfHiFU3MA/LXAuQLdmlRRjDuzS2rkvs9evXy1Umd90qHiRKCXH3m
         Dr0w==
X-Gm-Message-State: AFqh2krtFve9QdZGmWl9jstJ8Lq4V0XiVkcI4E7HLIRX1oazb3CZOxUX
        gZXuwXVnQn4dbBrCgYJFCDFV3w==
X-Google-Smtp-Source: AMrXdXuL7ZkaKDvAn6GjIh+9RLrAHnrLwF9DCYQiq4t+yGsFqtEnfeu5PJuIm6A6RruUhd+4Ia5S3Q==
X-Received: by 2002:a05:6512:2527:b0:4b5:8504:7072 with SMTP id be39-20020a056512252700b004b585047072mr10108840lfb.14.1672491564818;
        Sat, 31 Dec 2022 04:59:24 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/18] arm64: dts: qcom: ipq6018: Use lowercase hex
Date:   Sat, 31 Dec 2022 13:58:59 +0100
Message-Id: <20221231125911.437599-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
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

One value escaped my previous lowercase hexification. Take care of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 6b4f653239ab..8e95ed633071 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -381,7 +381,7 @@ tcsr: syscon@1937000 {
 
 		usb2: usb@70f8800 {
 			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
-			reg = <0x0 0x070F8800 0x0 0x400>;
+			reg = <0x0 0x070f8800 0x0 0x400>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
2.39.0

