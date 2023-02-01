Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89154686A8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBAPnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBAPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:43:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE67264F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:43:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bk16so17700238wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3/+DGTzaMhuWDoFuxtV+F624fb5f16Gnc+LmgQza2w=;
        b=eTinXDgcSYCi97JGp8uBPtqXmT0IhqXl6d0FGqTKMIHYBl1MHa544hUoOsoSlhVP9h
         S7NbumBzTgzeKlHu97LG3WRJsPBJvsDVMKHAO+ir9HWyuy5uDbbPaJl1+b9KMUB3GMx/
         ad0Lm8ZNNQFxjXUcq9VKDDDSZZR5b04UIr7Gj2Mg+xMzVijMJAyOIy6xtauG4Hntun4t
         zLDVNdfvJl+6oR1f9yaudR/rCy5y0vdrxGBG9ORIWun3VA1z6CxURXyMVw6h7UPKOi/9
         5J4CeUqrz3c62Pu5olAV77yvOU6kFpjJF1T1fydip7UjWma3kvlH7KUGy7t4cdF+ExfZ
         9Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3/+DGTzaMhuWDoFuxtV+F624fb5f16Gnc+LmgQza2w=;
        b=SxpEOBO6tiHBIwUdsi8myEAZkzHviHXY7cwczLcwWtbtbhjaR/J7ULTAkOcu7TFMg6
         vAiH2qzIV2CE8tCcLdy0Uwl9voFfLnttlCWwmyTX0NiehEIJi193CQmG6QGf84/1GiUB
         u6GVsQeE//U6FogNiIIASPXSq4W4CaYc3FZGNQwZub6m1iVgbovd1zJYrT96Accroqrr
         StvpMvAOYrxUD09nKMevFJqZDyXCblW5z1WysDL+mvZAC5sXzfAL+g0j1J8knzJ0buro
         xy+tnFCaoCAkeaG8qfVmMHmT76rh1EHrpStSjqNGl9P0e0oJxNkz+gN0Drs1jNtfU30F
         1l0Q==
X-Gm-Message-State: AO0yUKU73HJJPXSx/RbKND/k8p8jS8O7rb8i2RXaSvn8tKtyU80nSiDS
        8jvkZaxAkRmRBhFHQCqPyT84Bw==
X-Google-Smtp-Source: AK7set8j/RkB7/JnR48HcK7frKqnm40tPU9lEx2UVWT7zWWDUuyw+W/Jo3VSgqlGedGvqojeUTpHXA==
X-Received: by 2002:a5d:6d05:0:b0:2bd:e13f:48b8 with SMTP id e5-20020a5d6d05000000b002bde13f48b8mr3812743wrq.3.1675266207447;
        Wed, 01 Feb 2023 07:43:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19374487wri.34.2023.02.01.07.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:43:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8350-hdk: correct LT9611 pin function
Date:   Wed,  1 Feb 2023 16:43:20 +0100
Message-Id: <20230201154321.276419-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
References: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
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

SM8350 pin controller does not have "normal" pin function, so use
"gpio".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index ece1a7cb8b3b..8b7cc45b0919 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -725,7 +725,7 @@ usb_hub_enabled_state: usb-hub-enabled-state {
 	lt9611_state: lt9611-state {
 		rst-pins {
 			pins = "gpio48";
-			function = "normal";
+			function = "gpio";
 
 			output-high;
 			input-disable;
-- 
2.34.1

