Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C181970E6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbjEWUmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjEWUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:42:35 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191A7E5;
        Tue, 23 May 2023 13:42:20 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B7109CFB3C;
        Tue, 23 May 2023 20:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684874499; bh=mv+iwmwhLjIePzSdjIrh7FapElK7S6I9sslfFya7rPA=;
        h=From:Subject:Date:To:Cc;
        b=guLb+49LRg595ahi9wPkfQwjTKAPv/6jUbY7bK/ahfUs+61hP2sR7Sc/JEuRNyZuG
         gyOKBz67u98HpmCpM7T/oUrjcYkad3KVi5u003y28m4A8EaZJyUTpkEtjR0EqFFNSm
         tvOyjexiAMHdWHb+olssYR6AJMe9c0MM7WYbQTfc=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v3 0/3] Add PMI632 PMIC and RGB LED on sdm632-fairphone-fp3
Date:   Tue, 23 May 2023 22:41:27 +0200
Message-Id: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPckbWQC/22Nyw6DIBREf6VhXSxy1UpX/Y+mC8RLZSEasMRH/
 PeCqybt8kzOzGzEozPoye20EYfBeDPYCHA+EdVJ+0Jq2siEMw6syAs69qYCTguJDDgvJV5LEuV
 GeqSNk1Z1Sa8yyNill8ZSPUISRofazMfT4xm5M34a3HIchzylPx8hp4xqFEWrYloDv69gp3c2L
 ytJE4H/r/FYE3UjtRRMKKi+a/u+fwAjwDIg9AAAAA==
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
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=mv+iwmwhLjIePzSdjIrh7FapElK7S6I9sslfFya7rPA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbST/8EEnBOczZaRquJxzq56eFt4sgSVrn0Q9M
 nxPXkR832iJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0k/wAKCRBy2EO4nU3X
 VqLqEADRlHJcmJq4lV7S9X9LW3BlpDJQaUXGq48xmRZzhaHQOKSYjUxW65aL74sBppfQyWyCwbH
 QYwuvmZE5LvpOLmXRnq+5z64If/osgGHHtxwZLymrzvn9npEjWODMzFASFpFiZEb0VVyd+/sBXQ
 m9ryi9K8GeHv+3yWjvhgX+WLEr1jD+2gIqaHhrNwDMrWwQ3alWA8K3hoP7F2YHM1WmqDHWGm8zm
 6qaFoEaE8Jt3r5NOrTQUF7fLoiTdSGrVWUqGdkSrJjtuQ+GtEJxQeLoF/iP4ECSpb6CGz853kYC
 /Ams41ZPx54veCqqW6PedplyAIeZ6ixSN+9EIpknye6/m2muBRka+faGVPu2LXeOzCOYiusx6aT
 8GSqFD5S/cwR09zDA1P47o4uvQQ0TXg/OVeK/KBAPh5QKPwpw69PqaqCY+3JVNm0xtJkECjhgol
 bsRs0CK7RoEb5LyEQG7uidF6fFNOH3oRd2ADGFR8WfNH5Sjq45GH7BMBfcfExfdPmhImYq9BSdn
 UsRYgooVi6GV1yLyss7EYi6HViusad9/oR5ppcAplmhBIskyxMTT4m0PQ2+/y6qtjBqZOrTge1x
 RYiGfijjZZfPsC8WQX8Q5UKWfPAhfDrnwJsngxGhGBQ3BzcrcCLT0eJfi+e/LMdcegV+LWs33JK
 8N8/0U8yDYfEsPg==
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
Changes in v3:
- Pick up tags
- Drop patches that have been applied
- Link to v2: https://lore.kernel.org/r/20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz

Changes in v2:
- Add qcom,pmi632-gpio to all the needed places in yaml
- Add patch documenting led path
- Pick up tags
- Drop vadc pre-scaling patch since it was applied
- Link to v1: https://lore.kernel.org/r/20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz

---
Luca Weiss (3):
      arm64: dts: qcom: Add PMI632 PMIC
      arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED
      Documentation: leds: Add "rgb:status" path

 Documentation/leds/well-known-leds.txt            |   1 +
 arch/arm64/boot/dts/qcom/pmi632.dtsi              | 165 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts |  29 ++++
 3 files changed, 195 insertions(+)
---
base-commit: 5a3b858944b3a5a297df90353614abfb7c7ef592
change-id: 20230414-pmi632-4ae03225ae75

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

