Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3250689F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjBCQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjBCQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:49:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7E721F3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:49:06 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so2848205wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWkuOMDUDuOgvvtDY78kfL6B7zEVTcX+KXFC3I95akE=;
        b=Z5cavXfXZVOkUEqSofJL1fpNGiqYmg9ZsTvbAJy4MaoLWX9zNCFkSs0Aa4Qq5i1UGC
         jNKpupj+28EnIv530/Quq+7Jv+UY7J+aJarca2krR+qhJsPusEp2UzIzwC2uidgM2FDk
         Cl3rjSAjT+sNDuoZbz+cWZIJQVxlIRlvgS4nNzwk7oVFLBxFQ4qaF6L9+ktLTu9WV/tC
         7WDZ1Hd3Zclh5IjiDXaA/EGBZQrqmX2AKxL6sBtwUbc8BhcleL6bxm+yry62NlK8DdLs
         A0babIip34DfAE/Bxd3Ni1pxlR6QLnZlJEE5JXyNXHk9h3HZ4hTDJeQ0P6SZwiBoJXgq
         2PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWkuOMDUDuOgvvtDY78kfL6B7zEVTcX+KXFC3I95akE=;
        b=oPee33ExQVIJBJJLzses8aODUbCR+rXQn+5Lwq/Gx+gTspQHx7D5VVrULG1D6RsV4Q
         /z0VJI6Auzj8FkRyFdegChr+vbogP52Z6yL75FNA37fzW8U6MVD3RhUHYwWgqWNkLUJP
         thlKC1mbrXdgEcBOVy7RmqlvLuknZzkOX8DouObKGM6vzbIrO2A/Vht7DYy0zqs67Hed
         C4/sxw477S7X9v2aQ09jGjWvcS+unyyYVfI5kGhoy1MmNqMZnJRBmc4rYXQ4xK3fwRcC
         KlSYz9XY2+tOoStRzZTCRa3Dan0qcUwe5foA6udYHFOKnMv0EbVd8pZ9/sVUNzSZJs4G
         UlmQ==
X-Gm-Message-State: AO0yUKWMZX7r8Jtp3nUetqIFCmWY/1TJ41GAMl9UU/O5aKaPflW/97ss
        yNSeUkj9hHuTzzF+VoXKjwS9MhdjmEGOzAVL
X-Google-Smtp-Source: AK7set89ru4hCvtbqJGNreUW4FL/GSy9LNx2YC30ZaWYA6NPzlm2BQgk0OmjrQ55/wBMc8m2JApJAw==
X-Received: by 2002:a05:600c:4f96:b0:3cf:9844:7b11 with SMTP id n22-20020a05600c4f9600b003cf98447b11mr11330029wmq.23.1675442946241;
        Fri, 03 Feb 2023 08:49:06 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003dc4b4dea31sm3503247wmq.27.2023.02.03.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:49:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] arm64: dts: qcom: sc8280xp: correct LPASS GPIO gpio-ranges
Date:   Fri,  3 Feb 2023 17:48:54 +0100
Message-Id: <20230203164854.390080-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
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

The SC8280XP LPASS pin controller has GPIOs 0-18, so correct the number
of GPIOs in gpio-ranges.

Fixes: c18773d162a6 ("arm64: dts: qcom: sc8280xp: add SoundWire and LPASS")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c8509b1b040f..59545372595f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2645,7 +2645,7 @@ lpass_tlmm: pinctrl@33c0000 {
 			      <0 0x3550000 0x0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			gpio-ranges = <&lpass_tlmm 0 0 18>;
+			gpio-ranges = <&lpass_tlmm 0 0 19>;
 
 			clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-- 
2.34.1

