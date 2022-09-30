Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8649A5F12A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiI3TbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiI3TaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:30:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0152EF15
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q17so5801755lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QXCX/bvx+GMITxwd1sJyJkSs746MTV1B+EirXA61vBw=;
        b=kRF5S9r9tn9jPgt4Fxvlqu66cm9Fx8vkdJ/R8/JfXwvhrp9QiV7ym7Rogf0hsycQYS
         wR02glAPABCRilB8yXF2nPXM34iKfVDr6VzGGiw+94X9aIsmxDLS81Gc/dY7Jjks8jT/
         fiFtonH/yr+pDiZxPZcJdNVOiPcQHDfF9QRBDHyrFbO6LRC6MVM+aApPoBt6VCx7lJxV
         6wka2Bq285FRUPA/OSmb0TN2uaeqNalAVAUfHlVorZxdoJUaiWflsuGOYzXRgwsXX5o2
         OvsxHr2XCJ3y4pdb2zK9s6r4BQlbnddE0hrl0kpxLvNQOYSYglkblpjK6oMGW+JnjweO
         Fs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QXCX/bvx+GMITxwd1sJyJkSs746MTV1B+EirXA61vBw=;
        b=iQxkzebQr2SvkLnxvHNSZHFoRENKPBreDZWze7CpLikpjdm9MmdT0eO5zSPGx60Ixv
         bG4OkAIDxPEX1lWAIjBB33PKOdx2iz/dxld8Et9Sl9r4/UpMPeexXSmB81oCo4e68K+g
         y956h99LqQYYysoOM4lgxGUg7qntswl7faIvu3LHFWCBJM9nbxBtg7M/RQs7yDEW4CdO
         /2uX+dUSswJkNWkGFDAX37IkGt6EO+/zksdJPb22+LLuAxSBxjb3rUAwA/tCycvYMeZd
         w7wfsPRX3JE+Lh39LhbNS8HEm8Y2N0jSZY+p1W2ftLBe8qz35/+XC7qxWea560Pfq6Zk
         tTCg==
X-Gm-Message-State: ACrzQf2WgwYniASPSS82ZuXSlp3qSGVkCR5xPatXFcKJpeD/5/Qn2cLO
        DKVmRwNF3ITrhF6weUJPeCk9QQ==
X-Google-Smtp-Source: AMsMyM7MlpgCLTGnNr8o5iJXWBowZ/BlEn1prfau5KLOMBOmzLQlzOf8s3TQ8JadSU+Fky1mmQaYFg==
X-Received: by 2002:a2e:a0cc:0:b0:26b:e763:27d2 with SMTP id f12-20020a2ea0cc000000b0026be76327d2mr3164724ljm.62.1664566205749;
        Fri, 30 Sep 2022 12:30:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049f9799d349sm393603lfb.187.2022.09.30.12.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:30:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 08/16] arm64: dts: qcom: sdm845: align TLMM pin configuration with DT schema
Date:   Fri, 30 Sep 2022 21:29:46 +0200
Message-Id: <20220930192954.242546-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

  qcom/sdm845-lg-judyln.dtb: gpios@c000: 'vol-up-active-pins' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 20f275f8694d..1eb423e4be24 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -604,7 +604,7 @@ pinconf {
 };
 
 &pm8998_gpio {
-	vol_up_pin_a: vol-up-active-pins {
+	vol_up_pin_a: vol-up-active-state {
 		pins = "gpio6";
 		function = "normal";
 		input-enable;
-- 
2.34.1

