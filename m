Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1016AA9C0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCDNDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCDND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:03:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FB31166D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:03:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g3so20802989eda.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677934998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJR6oU4xKUs4lYSyYP5+zTHR16nQ+SugySt6CqU73PU=;
        b=meLUljN1kRQFfQyXZaILv5wTYVAz93IaTM/ZaiGNZm1gYEIgmVg8bCm26nhhUzfX+g
         ZQ6eDrcuq+lSFIuQGs4OGz7ySh516Lg985orujn9fUsbiCMPxbf+L938EGXNuMsJY4Cb
         yP0lXx3UJeg3m0yFK66iYrOSSIjk4ZHsU6d2r4PALFcSyu7lGA7lg1vu5khfK9mG0O0Y
         0hMuKC1pHnimNE6rPYb7z4cRxrO9Sc3gCLuTBkoD4B17Ct6+t8bi7hEVY+fFKQFkPegB
         F5GsUWyt7vpuxlaljTqjei8tiZg6+WjeQghJlVH5g3qF68dMt7PdMbb5GAS76R4TckQF
         oloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677934999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJR6oU4xKUs4lYSyYP5+zTHR16nQ+SugySt6CqU73PU=;
        b=rZacBasGOJLOi9jWVvb5Bwgfcf3wfx7eSIYDG9uAjTjUgfDMcK5yFYDKy2qvJZn1Tc
         B+hbaWSm8kebHcHwEXyd09HVDLLSzBHBGAFsay7B8I0/nbyB/NluLmqvdo9ArjqZLJ9j
         /+623+wYN7+FDqTkxSLEjg2ivx1ibHvOYjYRjkNw/oysDLo2p1ea94TTtC8bBsMap9Wq
         z/M7rZJKklhdmCmfq+HTncGsinQCc97g/O38tiZMAL75ulds1GsmXr3pHHOyDYr1huim
         lGQCnGjdE+t+8cjqv56JoShOW/1a9e8gdsC+X1dhrqAybdra+RTRSLBrF5NHARXMio2j
         ouGg==
X-Gm-Message-State: AO0yUKUVSt5QwxHZsFmmiGtviUKZqvBKMALnNA50ZqfJR93EL+z2i2Uq
        3pvq7rVKicMkd7O9mJdryKPf3Zp7WJqvB77j0Hg=
X-Google-Smtp-Source: AK7set8B4W332A4II2SW8JiGYyWXFAhUHBnJ7z2y1vWrZX0ySzWjJIySJg8Gp0Za9rstQgX6XJ+wOw==
X-Received: by 2002:a05:6402:2052:b0:4b6:5d88:3fc4 with SMTP id bc18-20020a056402205200b004b65d883fc4mr5213394edb.1.1677934998736;
        Sat, 04 Mar 2023 05:03:18 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id u23-20020a50c057000000b004c19f1891fasm2423220edd.59.2023.03.04.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:03:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Katherine Perez <kaperez@linux.microsoft.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sm8250-xiaomi-elish: fix USB maximum speed property
Date:   Sat,  4 Mar 2023 14:03:14 +0100
Message-Id: <20230304130315.51595-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Fix typo in USB DWC3 node maximum speed property.

Fixes: a41b617530bf ("arm64: dts: qcom: sm8250: Add device tree for Xiaomi Mi Pad 5 Pro")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
index 24fc29f0ee5e..6bd0dda8b6e9 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
@@ -595,7 +595,7 @@ &usb_1 {
 
 &usb_1_dwc3 {
 	dr_mode = "peripheral";
-	maximum-spped = "high-speed";
+	maximum-speed = "high-speed";
 	/* Remove USB3 phy */
 	phys = <&usb_1_hsphy>;
 	phy-names = "usb2-phy";
-- 
2.34.1

