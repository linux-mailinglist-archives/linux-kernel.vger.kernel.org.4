Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7273A693CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBMDAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMDAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:00:44 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D851E1726;
        Sun, 12 Feb 2023 19:00:43 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id x31so7255186pgl.6;
        Sun, 12 Feb 2023 19:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZSnWC0uJdlBiSLLAHhgUe7rf4dqkdvbgl/BZlGtmEc=;
        b=ozkUKNNAbVNKMKeYlZDf5+qj/R+p2TzeR1ULFsjzQL1T3wOAZ8NvMrehM9/fMZOMoX
         GCbyBsz0kH2ovTVI9aqI20Ui1NFN+iTrfq2yuFlV7IvCi4B8whSAD3EcPJR9dwFFQUdD
         A1r31X4Ux9Ac5KgzwqBfQvurBRngq7dKZ2FL+YXtARMccmRh3fuWnMLssO2boDhasBRC
         xiwR117n3J6MF79i/O5z+9TiWQvxuBHy7is+beNfC5MK7ZUVHCJK+esDdM2BoQjZmI+r
         YYncjS7iWKJ0lnZs+yRNOpar/L/5I808jUinY/gCer85QAk79whZgs3WSsczUK3wm6Ji
         lv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZSnWC0uJdlBiSLLAHhgUe7rf4dqkdvbgl/BZlGtmEc=;
        b=DLKNlWRqlmpy641XTom+75qe9Izh2BlEMN8DHp/peYfy38AsIVHW9IUxAes7N2Tbzc
         VcBWMm6zcw7vhGM3lAs9v70mcFKXZKFeHUBpM0ZXdnNwTKaIxCOaG/gN4hpqSlnKl1+S
         JhoP/i7pc8vqo/A8LZczaKXT/WfZidt4ZwAFJuTE5jUrW8B0TNym9iNmCGwHNAuH9GW4
         CDzwnBGH4bl3tmgC0hCS8x3UdDEpvuCtgFdwrH5sKky3tqn+Srrn5Zq29TVLLTwWy3JL
         /2ZR14Db6T+vImN7rLJM1H4ZdOAxf0ac0LJlyZ2B/TbKRsIgVV8R9ya5h+AwgVB4bqTa
         MmnA==
X-Gm-Message-State: AO0yUKU6w0cV5ybTSSs1nwT0Zngj6PbDXoEehyUGQ89Tro0iYT7smU4f
        Xx/Ovlz//A9e25XY/i2OTOiL1kEyGwk=
X-Google-Smtp-Source: AK7set+IjqrsfUXysoQAsc4WoJue6Mfrq48KGLSgBG3d8+aOqGWTV9312xw187j2/KFlTwQ0gtcZgg==
X-Received: by 2002:aa7:9e1b:0:b0:5a8:ab78:639f with SMTP id y27-20020aa79e1b000000b005a8ab78639fmr3411184pfq.7.1676257242913;
        Sun, 12 Feb 2023 19:00:42 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-bf16-9d1f-462f-83db-04dc.emome-ip6.hinet.net. [2001:b400:e2dc:bf16:9d1f:462f:83db:4dc])
        by smtp.gmail.com with ESMTPSA id j7-20020aa783c7000000b005938bd2bfd3sm6776981pfn.120.2023.02.12.19.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 19:00:42 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>, Harvey <hunge@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sc7280: Adjust zombie PWM frequency
Date:   Mon, 13 Feb 2023 10:59:05 +0800
Message-Id: <20230213105803.v2.1.I610cef0ead2d5df1f7bd18bc0e0ae040b03725d0@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tune the PWM to solve screen flashing issue and high frequency noise.
While at it, the comment for the PWM settings incorrectly said we were using a 5kHz duty cycle. It should have said "period", not "duty cycle".
Correct this while updating the values.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

Changes in v2:
-Correct unit and update values in comment.

 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
index 64deaaabac0f..a4fde22e3355 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
@@ -61,8 +61,8 @@ ap_tp_i2c: &i2c0 {
 };
 
 &pm8350c_pwm_backlight {
-	/* Set the PWM period to 200 microseconds (5kHz duty cycle) */
-	pwms = <&pm8350c_pwm 3 200000>;
+	/* Set the PWM period to 320 microseconds (3.125kHz frequency) */
+	pwms = <&pm8350c_pwm 3 320000>;
 };
 
 &pwmleds {
-- 
2.17.1

