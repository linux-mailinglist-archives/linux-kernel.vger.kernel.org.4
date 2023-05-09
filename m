Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB86FD0AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjEIVRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjEIVRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:17:34 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E0655A2;
        Tue,  9 May 2023 14:17:20 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6C415CED2A;
        Tue,  9 May 2023 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683667008; bh=Dd2WH20nE9Cn1fgXE2cnZpLj6u3pya7fQbeUQoj+SfI=;
        h=From:Subject:Date:To:Cc;
        b=lOpNq6XYafpR/MdOnyEJb70lm7LnbUPGaI/PiAOiVwrkHkIlpIuZjIW+OPRj9LYRQ
         KJDe+Q6r2hZ6mqiBiC67YK40hAbcrBw6PNkKudgmagKo1UhpMKiwZV19oZLfMBmoch
         mAkCRfaBOKqI8fbKKimROdZGUSibRdBaIqJgietQ=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Provide parent clocks to msm8226 mmcc
Date:   Tue, 09 May 2023 23:16:34 +0200
Message-Id: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADK4WmQC/z3Oyw6CMBCF4Vchs3ZIrYUUX4W4KGWEWbTUjtcQ3
 t3iwuWfnC85KwhlJoFztUKmJwsvscTxUIGfXZwIeSwNWumTalSHQYLVusUQvMfkMsW7oDbGdqa
 z1IwOCh2cEA7ZRT/v+OaX8IdtbeoPvjjhlB77OGW68vv3ob9s2xdJa9wokwAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Dd2WH20nE9Cn1fgXE2cnZpLj6u3pya7fQbeUQoj+SfI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkWrg6XuAMsP/aBDMGI64O47DqT3NboGZkfPi9r
 oQoEIZeBPKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFq4OgAKCRBy2EO4nU3X
 Vnm5D/0RqlJmfmZNPpXLXRauQUuEJHxSu3Kg6Uxc3AGbIdHG39ZhBLEWqO90wHdmDRNKDso29Xh
 rA3PaDwg3H8siDm1VZmm8jnJQkaxSGtqCHpQ30HcOpFE4fJfv6nxPO/kZSh1sZNOTue8AxqW2NR
 xDkKIbGbs6PjQH47GJYSH+b8h4x3NnsG1OOoICKSEVHRxSbbmAYjj5shtjlhZZ801p17b8f40+e
 iQjTQkSDYBNJrbXzJBjw9XyroZkxpehx5b6qoSVewzwiF5aHq+KeRfX8Gb0YN9Hz5JdU8xNljcN
 DKsTom5o9gxTq0POG30rmuk2928zJ5EfPA8wI3CESEAE9Y4BYfEbubvKG6NfYAl9vzXJpN5xNQU
 9zSFJrI2fugkC2/ExpVJ5PtGf4UXQtiYTYTjipjzX+cmA3tIsDs9OLECw5sdrbW4yPcV2r15oFt
 Jlxffq+oxZ+dp8Nkqj+Fkxm2UF3dgIV+taO2f29Tpn4VLitEsnQrd500zqEo/Om2S+BcOHdg9zk
 RcpB/+NBmQI9aSZLyTRbFyCkr3CP6w0G38IjOIkk5lN130tTxpsXehwH2q6eev9dOuu/wOzDkcn
 uWt0LDNYO3R+GCvmtGUWJi+T4stncCTRPjhQn9/RtqnNMUnhZnG0DqEOrb+J9xBcJR+9wc/QiEA
 jP936NZoYc/dU4w==
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

Replace most usages of &xo_board with the &rpmcc variant, and also
provide the necessary parent clocks to the mmcc driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (3):
      ARM: dts: qcom: msm8226: Use XO from rpmcc where possible
      dt-bindings: clock: qcom,mmcc: define clocks/clock-names for MSM8226
      ARM: dts: qcom: msm8226: Provide clocks to mmcc node

 .../devicetree/bindings/clock/qcom,mmcc.yaml       | 32 ++++++++++++++++++++--
 arch/arm/boot/dts/qcom-msm8226.dtsi                | 26 ++++++++++++++----
 2 files changed, 51 insertions(+), 7 deletions(-)
---
base-commit: f46950f720460ef8b8c5ca68e14a529dd1705832
change-id: 20230509-msm8226-mmcc-parents-24489498e5da

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

