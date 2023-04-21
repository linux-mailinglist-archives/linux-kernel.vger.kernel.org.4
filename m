Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B974F6EB403
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjDUV5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDUV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:57:03 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFCE10E6;
        Fri, 21 Apr 2023 14:57:00 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2207ACCBD3;
        Fri, 21 Apr 2023 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682114189; bh=E5+af9y0IDMMqoRD5fAdSt1t/WbYFI3JGXbdgrIPnBI=;
        h=From:Subject:Date:To:Cc;
        b=J3U2NyrhqJim+Vt0gALA7AAKpwa+g/PeV8bP6XhhtSs+aS9EoD7UBZmQy+T5RM8UP
         ciDp3gfysE9RSKGGGD015IYAIKP+kaKZtPumklNS2fS9amBOpwQYgOREgaqR7tUHEC
         BtlX0Mp8VhZUos35KXq/Vvd7hYFZiOmpwCSzTrhA=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Add GPIO support to PM8953 PMIC
Date:   Fri, 21 Apr 2023 23:56:19 +0200
Message-Id: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIMGQ2QC/x2NQQqDMBAAvyJ7diGbWKz9ivQQ46oLNoYEiyD+3
 cXjDAxzQuEsXOBTnZD5L0W2qEB1BWHxcWaUURmssc40ljD93t3L4ZxkQzd1hloeQ0sEWgy+MA7
 Zx7BoE/d1VZkyT3I8i/57XTeoaANgcgAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=717; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=E5+af9y0IDMMqoRD5fAdSt1t/WbYFI3JGXbdgrIPnBI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkQwaHk8YA8kvtVmDIO6hRCpf1Dfi+1mt6IBrm0
 EuVguPLxXKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZEMGhwAKCRBy2EO4nU3X
 VnXJD/4s1iPYvOU/Z0haMwONz3fNjExrGa9OTsfiPmHRIL70IIj/PmfMNkU83HFp/9KJEirThPs
 zml8ZrC6nOStQAU6E/e10OiVUp4k04pnr5oPqvnMB/WQrQKpff3IYxEY7muV1vHPhwEm4EwOVc+
 cAD8s588zTkBQ6RvsHR/Lj0wVzs5k594+9dbcRGQWAwrKhmPPh4/ydWSgQk7Vrpjz4NdpTiGys3
 mOlR7ro1AzvygSoU6AdfMQj/LvvG+ROMdrBmS2nRiDCQmg1UTT4Kgrx29XXFVNtEvh97fFmtf1j
 3v676u6TnjjdX7AqyMCp4O/eTMWDr/IRL+9SjcUrsHfEm9TVP8Whj/cdu8aTjyv45B6/Ni08N+x
 0CZ8HFy3GBZN3TJHmFKoA9BE+wZCa3qMIoay052Kj4+nNzqxaqUYurAYmUUG1nsXvvNDz+ASZgf
 n99j/cXhzqGblvN+N5ivgiQuLhRM4Jgj9Knxz1TGHu5XHNOkB+OlfAIcbbUCSZdLgkIIIijID6K
 66/V6d0jE5U1A/Xu1KSsOqF+N/Dp6q4ZIaW731khtzv34byMcLi3Oe1Wx4AbZ0gKmpbCgWDLp6J
 yBuaz4wWpp/A1IDRtqooRH/o8gGlYv57cBaYiApQ1nkXmJOBoDyMetNK4ubgf7J/uNp0ChCOxQE
 yGTyxP+SJzH+aAA==
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

Add support for the 8 GPIOs found on the PM8953 PMIC used with msm8953
SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (3):
      dt-bindings: pinctrl: qcom,pmic-gpio: add PM8953
      pinctrl: qcom: spmi-gpio: Add PM8953 support
      arm64: dts: qcom: pm8953: add GPIOs

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml |  3 +++
 arch/arm64/boot/dts/qcom/pm8953.dtsi                          | 10 ++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                      |  2 ++
 3 files changed, 15 insertions(+)
---
base-commit: 347e9b4e41bfff51993807962eb1082f6d8ab439
change-id: 20230421-pm8953-gpio-3f9017edc711

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

