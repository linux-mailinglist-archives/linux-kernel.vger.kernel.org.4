Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763B56F0D42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbjD0UfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344251AbjD0Uez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:34:55 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726873C15;
        Thu, 27 Apr 2023 13:34:54 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D6709C769B;
        Thu, 27 Apr 2023 20:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682627692; bh=T3OvB1tzubQbC9YOdAcpkzeqQ7Zla1a71M5m+zynx9g=;
        h=From:Subject:Date:To:Cc;
        b=SmCEhIddbU8qo9r30nyrvNuNCY9jpW+4x0ANHuM2HAsUOWW/5DaAqC7L7E7KWpjQ8
         0K+h/6kd/MWNl3icbIN+enHvkA4z1Ecb0Waw8WzmiudgEpfqE4xPV2Ma5b4NwGoxwq
         BdjLNxrbEPyF4GDfdcJ+ComH5h2nB2GVZUxT+oFI=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/4] Add haptics support to Nexus 5 using pwm-vibra driver
Date:   Thu, 27 Apr 2023 22:34:25 +0200
Message-Id: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHcSmQC/x2Nyw6CMBBFf4XM2iF9EKr+CnExLYOdRYu2CdEQ/
 t3i8uTck7tD5SJc4d7tUHiTKmtuoC8dhEj5yShzYzDKWDUYh5FS4hKZZtzEF0I1+ln7xTlNFlr
 mqTI2kUM8w3dYE6aarjc34Njb/nuOXoUX+fx/p8dx/ADWae+YhwAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=T3OvB1tzubQbC9YOdAcpkzeqQ7Zla1a71M5m+zynx9g=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkStxaNlx3juoDp2zKO6rUIrCvUpVVXgTtRJKKC
 MT2tO8vuXKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZErcWgAKCRBy2EO4nU3X
 VtLeEACleWKN3OlEkHXu9CpxXdHpZ9Nl3D5rf0yZw2OLXqyCmxF3LxlSRkDr4W1BXJmlUGD8RH8
 JrTRzBdJe6cIBoU46dCLzleteX5cxy5d1g8mHugPL1jjTWQw3hnJeTNS3rtBvrx3hKx2sHxP9JH
 r2R7z+asg6AfnjaP0yL5PFYCHwWxupdgARNkU5LTVYDw7NkRd/lZP1SyYeBB2PWI8zR5eOXWiX2
 bp3uitpcQHjdR5yiGMf2P909ro+yIFSdiTDKw/7uaPVlXWjYwRFxHW917ad31gx9+yBIqyoOX2d
 FngPSgA4MKSgf7BKwdrvAhZn4wN39+Np9d4MJdj4U1g3YDWecnRDWmHQ/s4/WU2Uhmehe0tg+L0
 5v/nlfTbCCAFMbSk5KGFZbQ0wz8hd8rAZP5IuXRy/hY+O0Iu+PpXSrZdwxUSKmXokkG1J1c7Alw
 3Lvm2AcT3Uv39J+CGVOSbzdKHSeQHvDoKOPHnZva9KomyiO+Js9ucBmJ2vMnWVTKTMsD3zgV/7w
 xL3Tns2AHHgBVhKV0Ykkxt2YRhk+0U61mjJa0O+TFWVLRpicTleTX7hhFzBaTmRxnjsRCSVNI2v
 ZfySYdlHVfvLeJFGVkXEGFQB1WtUYvKvTlqFI4paosddiHqqYF+m5iRnRyJOuPk9UGgpJDepT/J
 6wIlaqqTD+4NT5A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago Brian Masney sent some patches for a clk-vibrator which was
then succeeded by the idea of a clk-pwm driver that "converts" a clock
into a PWM and to use the existing pwm-vibra driver.

Since clk-pwm has landed last year we can finally add haptics support
upstream.

We just need to add support for an enable GPIO to the pwm-vibra driver
since that also needs to be high for the haptics to work on this device.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (4):
      dt-bindings: input: pwm-vibrator: Add enable-gpio
      Input: pwm-vibra - add newline to dev_err prints
      Input: pwm-vibra - add support for enable GPIO
      ARM: dts: qcom: msm8974-hammerhead: Add vibrator

 .../devicetree/bindings/input/pwm-vibrator.yaml    |  2 ++
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 35 +++++++++++++++++++++
 drivers/input/misc/pwm-vibra.c                     | 36 ++++++++++++++++------
 3 files changed, 63 insertions(+), 10 deletions(-)
---
base-commit: dec7f67a13c3270f9a38eba227a4fc15993f01b3
change-id: 20230427-hammerhead-vibra-06bd1bf771a3

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

