Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABAB6E69E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjDRQnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjDRQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:43:45 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C94640EE;
        Tue, 18 Apr 2023 09:43:43 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E7F4ACA652;
        Tue, 18 Apr 2023 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681836222; bh=2UwFEQR9YUGIfjE/n8onj7mJvDxDUG5Ek3v7bTXp0no=;
        h=From:Subject:Date:To:Cc;
        b=r0bHpRD+q1PFthuWhiscU1JL73yULzMpG4zI1sS7R4oAM/hZFNPvLBkNm08b8rX5e
         XM9mHutCt9kGBwC1kUqFHhBegJsoNjFP5n1stmoe+3XqLnR+5/Hoa0HdRxqJZ/B+m8
         fX1Cf/RfWP8aGcdNp/y/q0cyRYgXaFtXYG5V8q5Y=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/8] Add PMI632 PMIC and RGB LED on sdm632-fairphone-fp3
Date:   Tue, 18 Apr 2023 18:43:16 +0200
Message-Id: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXIPmQC/2WNOQ6DMBAAv4K2jonxGnJU+UdEYWAJW2AsmyAO8
 fcY2pQzGmk2COSZAjyTDTxNHHiwEdQlgboz9kOCm8igpEKpMy1czwUqoQ1JVCo3dMshxpUJJCp
 vbN0deZFiKq+9YStah0fgPLU8n6d3GbnjMA5+OcdTdti/x5QJKVp66KaO9o7qtaIdv+m8rFDu+
 /4Dt1Wxr70AAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=2UwFEQR9YUGIfjE/n8onj7mJvDxDUG5Ek3v7bTXp0no=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkPsimcD5fs/hvGjjmsbAyffi51L2P6kJdx59kd
 yevesSNnpeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZD7IpgAKCRBy2EO4nU3X
 VovRD/4yR9KpjV1+UxRWtdx7eQiGHpx/+XxXskQpFSV7f1S9ozY9mJV+quZccnWrPtdkbZw1yby
 isVjoHMDspHf/l2y717u+00aRZFaGzyQWbR17NRqENPGPKyG75jlqxROALWZaqWPOdOHre9o1a/
 CzkREbJaaG9zqqCSq8vLkK4sm/7NwHO2fBdWxZmi7I7yEJk+mECljp0AQqh6qyaTf3LBh143C8e
 s1kAYoHebugZYVp1P/mFy/kzAxDG/AzrYX6LwFsq1dU0N9W/pWHzPNuK5tnxIy5sFSqfOyY65zG
 witwS0Y8AZZq9KDQsv5Gf4g5ByCJQc0C6x6ZjVxmpR2z4klur0JXpLLM77Ds9aeHzKJQT4TF4C4
 1hBvu1Phj5m6kPH3jFTZLdDUKymxMGLp6HhKpgNVhOIkRktZ4bC8t6uFfJYApFkUXG97ggwQWsA
 9T0iO7+A2ApgPMD3vEaFQv6+ENqM4ZD9+b/KkcGoPZRcvihGEGL7UGbQmJlZD4zFyIVRKP4Xfbz
 13xMGT26Ymc1vI5+kta5iB5hbXjuRrRlW0Q+m3ADcCUvhTac8DshWBP8+uxT38dugFt4+kxSOfX
 g8Q0x4F3KSHbWXVcPj7Lhf8hD9Mvo6vTQC+CKvHZGp5y0V++8S4B8DcUlo2n7pCAVvwh7uaW5Of
 TKjULKs09fXh2hg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the PMI632 PMIC in the spmi-gpio & qcom-lpg driver, add
the dtsi for the PMIC and enable the notification LED on fairphone-fp3.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Add qcom,pmi632-gpio to all the needed places in yaml
- Add patch documenting led path
- Pick up tags
- Drop vadc pre-scaling patch since it was applied
- Link to v1: https://lore.kernel.org/r/20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz

---
Luca Weiss (8):
      dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
      pinctrl: qcom: spmi-gpio: Add PMI632 support
      dt-bindings: leds: qcom-lpg: Add compatible for PMI632 LPG block
      leds: qcom-lpg: Add support for PMI632 LPG
      dt-bindings: mfd: qcom-spmi-pmic: Add PMI632 compatible
      arm64: dts: qcom: Add PMI632 PMIC
      arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED
      Documentation: leds: Add "rgb:status" path

 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |   1 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   1 +
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |   3 +
 Documentation/leds/well-known-leds.txt             |   1 +
 arch/arm64/boot/dts/qcom/pmi632.dtsi               | 165 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts  |  29 ++++
 drivers/leds/rgb/leds-qcom-lpg.c                   |  15 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |   1 +
 8 files changed, 216 insertions(+)
---
base-commit: 3f49aa65798675341eb9d4f947c40558564b2e6d
change-id: 20230414-pmi632-4ae03225ae75

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

