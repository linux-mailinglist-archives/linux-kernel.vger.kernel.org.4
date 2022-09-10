Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240425B457F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiIJJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIJJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:14:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D791F2FD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o2so4547302lfc.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/UI25rqJUxEZV+KxQUPmeT2zHV2+PmX8LADJ48o6xoo=;
        b=kbEYjCacCwwdYF1VmovswFKBZiUu3Qwmhu50PiF5y0ch3buakY2D6pcV2dHcW7Sa6X
         HdglS8dDaZDG6fuEndyKp2FTHKj0dC6J2a3f/dpxR9lgtcLoEMh7jEhqzOtE90OeAvw3
         KTEcCQieDu3ZZBryzVcxsahmLujx84jfjvxPqDXVmuJpDtjoImEIdw5q7CxYvXDqJKR+
         I4Ekl+BLl2jAo3jMctdNjAKATx7DbMuaYxhVndtSbrHdqun9D74cnlqnH9DwYKwh1sf9
         NJmByo+qZKZdBpxq7Cvj73iVLkZwfAUE9D/oZd6Y7IFat8Mt4vxR3KRHN6Wdez6T0wQH
         b7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/UI25rqJUxEZV+KxQUPmeT2zHV2+PmX8LADJ48o6xoo=;
        b=R7Qute58HQvmQzTXxsfH4ZRt9MDdVBZEV1mccs3h0sk11eoxiSh9etP31TJmvlWkA3
         oJ+ZT8XnlP3OQKe4DTrTsPWNTciLnwOnqs7zI8tF8Y5v6spNkpTNyTw4JMUv0sfA60p7
         /514BKvBz7TMvnAkDUBve3Dtyad3D+m19Niyoap6+1oHg3mByOjRgLoPIv4THfNUweBL
         eBKFU1ZdxKdT0HgF3bCzqBlOHBq1cQT+8tBZHndEWXAQucuYdZvQDXJQveK/7VxGSiAf
         OQqdvDic5CDXlJDK/dJkt2hiKVxn5nwjzeX/PSFp2WtuyLNWJrVrPaJ9qC0VJJYjoCjY
         3xNg==
X-Gm-Message-State: ACgBeo0Rzkez7VhDEBjmvM47Kp4U04DejA1MuaViYxwc08UhWrOsWGkD
        WFjeOnAgB+KYoeqDDHbyx1SiYA==
X-Google-Smtp-Source: AA6agR5JSebTMqV9gwQ2S1KjheukgqYP3EiXpHmNCLHtumpvk7Vclk5W+5qNtkxF1tD6wcHKjq7i7A==
X-Received: by 2002:a05:6512:92a:b0:497:ac14:6d0f with SMTP id f10-20020a056512092a00b00497ac146d0fmr5015791lft.615.1662801284057;
        Sat, 10 Sep 2022 02:14:44 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 06/15] arm64: dts: qcom: msm8996: align dai node names with dtschema
Date:   Sat, 10 Sep 2022 11:14:19 +0200
Message-Id: <20220910091428.50418-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects DAI node names to be "dai":

  qcom/msm8996-mtp.dtb: dais: 'hdmi@1' does not match any of the regexes: '^dai@[0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index abc17c905bfe..b346ecccb94d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3402,7 +3402,7 @@ q6afedai: dais {
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#sound-dai-cells = <1>;
-							hdmi@1 {
+							dai@1 {
 								reg = <1>;
 							};
 						};
-- 
2.34.1

