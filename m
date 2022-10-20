Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36E606B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJTWvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJTWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:51:41 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4998A22D596
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:51:40 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i12so719654qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArlJ/v0OoUZQ/Kd5LoDRNejf0AwgsLsMBPFeV0K0yT8=;
        b=s2muhp2jpEdajgL8hbdN5bSwuOkDtcTnc7UcjWCdWmQsZ1QXZcYKYhGAnFyrtl0ZGT
         Ytucu2QvomjartNXcMa+7X+GwSKNhxcTpHyN/Rmzg5YgBWYsNk6OrYOFbQEVAoxN/WPv
         B5OHfLErjEmGzBEsKmNba4FRyflq6nOYtUaVRAAZBIQ2JHw8p0JFSYGttQ4qo7SNOIY7
         pwgmuDy7qsgEERgpcht3gyjZzOL0ALgw9DQkfEPSHVUZ4zfrYUab8tbgAA+2pNdTI1mL
         bLQrOtqdXzzZqlf5T+ekk9Wc1YX99KFm5DIgEqRg2B7CJkj1q7xiGdPmvLxAPwSju6pb
         DgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArlJ/v0OoUZQ/Kd5LoDRNejf0AwgsLsMBPFeV0K0yT8=;
        b=JM6yh23nxCsXsmb4n92ySk6FewD5iHEySEs0tqfXTHolvAmCHq6/tDeAtVz7zSStBy
         3r2Y1XuTCiADL4y9wDD6Ea8zePXdlsLIrBlxpI6qw4F2PtHciA8Gx+6sqskVXwis4LVH
         A3tlJysIKUrMjF9+m3Vw4YcLsTBZ5FuJwurdR/YQSfM9dJmkRpUnzDwke/RV/ltR9oBT
         rEkBzDHaHYBb1FFzRGRUUUXrdNHpy0tLq8E3xoxw2akbJCIeNyqlB/8YZYwTdRd2rJ0o
         oJDRlvJTP/JTD+HSMFml5Mi4172ZUnV2njxC5Q64vqGFV2G6A68SarrT948AKM0ZXaZj
         JHNg==
X-Gm-Message-State: ACrzQf20BMbrl2c+VHLbhcapouR5C7/py+HufqfGla5F4UJ9oicD/+i/
        HVxIDckOhRqv+n0zlSf5cSQ9zg==
X-Google-Smtp-Source: AMsMyM6r0WgMrzmuORUynOrL21SYXuqhkpq5t0qpOW6nEbsnb+C4TSEB8TJCCG90Hv1D9SRiqBOu/Q==
X-Received: by 2002:ad4:5fc8:0:b0:4b7:6ca0:adb7 with SMTP id jq8-20020ad45fc8000000b004b76ca0adb7mr6592615qvb.111.1666306299444;
        Thu, 20 Oct 2022 15:51:39 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id ew5-20020a05622a514500b0039cc9d24843sm6903479qtb.66.2022.10.20.15.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:51:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] arm64: dts: qcom: sc7180-trogdor-homestar: fully configure secondary I2S pins
Date:   Thu, 20 Oct 2022 18:51:33 -0400
Message-Id: <20221020225135.31750-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
References: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Trogdor Homestar DTSI adds additional GPIO52 pin to secondary I2S pins
("sec_mi2s_active") and configures it to "mi2s_1" function.

The Trogdor DTSI (which is included by Homestar) configures drive
strength and bias for all "sec_mi2s_active" pins, thus the intention was
to apply this configuration also to GPIO52 on Homestar.

Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Fixes: be0416a3f917 ("arm64: dts: qcom: Add sc7180-trogdor-homestar")
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes since v3:
1. None

Changes since v2:
1. Add tags.

Changes since v1:
1. New patch

Not tested on hardware.

Cc: Doug Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 7fcff4eddd3a..8264b8d5e778 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -194,6 +194,12 @@ pinmux {
 		pins = "gpio49", "gpio50", "gpio51", "gpio52";
 		function = "mi2s_1";
 	};
+
+	pinconf {
+		pins = "gpio49", "gpio50", "gpio51", "gpio52";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
 };
 
 &ts_reset_l {
-- 
2.34.1

