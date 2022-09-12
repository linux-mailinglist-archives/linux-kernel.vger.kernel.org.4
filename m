Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D85B547A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiILGWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiILGVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:21:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B128709
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:19:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k10so13155694lfm.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VVRMe5K9zQktuETEV7D34ZSBEU0mHzUqiBeP7TQimRg=;
        b=E9zZ3Djr07TS3fJj6umSRVrlBqZsmRosVs7UWiwoZ84qNN/a0cVp/MbBsxbDvNCRK4
         C5PzUhuDTHzNoejdenm32fJ2OweRU0Ba1IodWlj6HzopWoL+AJtWDhtPW8BCMPIiBu+c
         l2YkgWv05vztqViwf+jj/DW/l0cVvqcEV3OEmjMYARPhi/aX+/uTK3bTtrxBJngTXC4z
         HlFxq0wupVH7fGCSL3l+sS8gAkYtfIEbVZpzdORYN/obVqWkMqM44XUykiTw1/g9wYw7
         VuVfp5t4SncEfaeUCbiZ0KkYaI/Kn/dEDiajc7EHNyX0bGlUKKNH/42dhQApHtcct4jL
         sSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VVRMe5K9zQktuETEV7D34ZSBEU0mHzUqiBeP7TQimRg=;
        b=Sk12h8XeMTSTldWwIiJo+klnkq8SBpwRUuO4Qa3q6MXNfJw06oKhQlVDT7fl33SlJD
         gNWiLpUGBnkL9oQyh/lqzrvVKMvXIjJPXziROUhnifzJDHBWUOBld5JZunKRMj9w4tNl
         bNyT5mkUOxkquzqYuI5pa4oVl4Ze05LujOFmZB6oYRdlcu2EV4TH8WBbxHD8havQ2zNQ
         oKCsOM08mCCWzCdHIpDk/iPOfbTA77YxkR5PS1443tUgktR5AVeXc8P1oY93ghYHzKAI
         84dJpISeod9ixzX8EKMMXpAsYGsWhPt/dH+SCzoCXYlAIuI6OEApmMlFUiXD9nh/qVwD
         KkaA==
X-Gm-Message-State: ACgBeo1u9VmIn7maAK/KGSnEuvCRxfc5I2QAwREWxNCRO0Ncs6gwi44D
        T+lewoZCYmL3/Yp7LrCuAVmz8w==
X-Google-Smtp-Source: AA6agR5Ef8VuKaloSkqcwAVTmW4EDULh+UlSiGV/k2vvbAxBjr8D2hI70ANVmlLY8cttjljJtvwDYw==
X-Received: by 2002:ac2:5a46:0:b0:498:f53b:d19a with SMTP id r6-20020ac25a46000000b00498f53bd19amr5922678lfn.674.1662963529575;
        Sun, 11 Sep 2022 23:18:49 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 40/40] arm64: dts: qcom: sc7280-herobrine: correct TLMM gpio-line-names
Date:   Mon, 12 Sep 2022 08:17:46 +0200
Message-Id: <20220912061746.6311-41-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
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

There are 174 GPIOs in SC7280.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index bc795c480352..3448e9ed8b03 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -371,7 +371,5 @@ &tlmm {
 			  "",				/* 170 */
 			  "MOS_BLE_UART_TX",
 			  "MOS_BLE_UART_RX",
-			  "",
-			  "",
 			  "";
 };
-- 
2.34.1

