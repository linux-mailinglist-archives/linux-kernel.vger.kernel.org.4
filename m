Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1E68FD1C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjBIC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBIC21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:28:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96246184;
        Wed,  8 Feb 2023 18:28:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ki19-20020a17090ae91300b00232cba666bbso1155785pjb.2;
        Wed, 08 Feb 2023 18:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP1oeZnFYAqo6OKyA/b+ZVJvzM2i3K7jg0+1yWRBc1g=;
        b=HUmmBge72hoqvTRYsHNY/+t+bZskey6seLM+zu/lU46hxQ047PYnZY2t17sIOciCI6
         HzROywm4uATkmAiJFzfWUHDF1gqM/0hQB9GEiB2rumkNWELxfc3F22/PZY9DbG1CrOSd
         o40+GxwCqSnBfaZ1IvOZpVFH6oKAu3YMy8+F4FVnpWRr9doKwotEClnRX0yJY0xJPihP
         eUfFxIZ+OWq/rn+5mL1ZoT2ETA2sehO3y84ek9+zdZtM9c/mufNaR0Z/a7zkYdmmR6jU
         HqXLgUtzuva0d0kLQvpa2lbPpHaI/zepxZtQiRvli2E4XMZCzpqPYbcq+Ll+61WQ2/bB
         +QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BP1oeZnFYAqo6OKyA/b+ZVJvzM2i3K7jg0+1yWRBc1g=;
        b=58iyEPbi5ZxeUsa7DR1ZOuZ0hYIvk+3GX5sRl8GOU+y6mht/uS/jMyTXn5jbslTsmQ
         aB1epUEFUaQ1BvBMr4c42fmqB28FKvNIg9QMtN5NCzPD2Tq8qMhElR+d8HuSNAlY4jD1
         rDFIqlWwvErGUv5khrypqsgyqPQ2oXRtA8N2c+A02dTB2KQcF1ilrcWknU2rofrM+GJA
         Kn8YJ/n0uPHaTGjDLgFaLJu8/uZgeZxfSCuZEkrDhgY4wERoMkmL9JAkh1wjVlgPKmgL
         V1Z0keClIAOrD/RdaZtbilSFG9rQgXUDqETjB/nEzglFvTUGyDaWmx1BLKpoWdQbcFUD
         oABQ==
X-Gm-Message-State: AO0yUKV0ozXt31keSYi2BT1fLR2FC/tZhSRgn0oxHrKGGJC5GRY4J4Ri
        4ts8MLMpnyTy6zbFAiCOZgI6ikkdVxo=
X-Google-Smtp-Source: AK7set/y4rEkOLWVWBqz2g9CMIgzOYsc9RUpwCQG6Id5BAehzOegFxWYuAcs3FSZAhpNQSSavbU3Nw==
X-Received: by 2002:a05:6a21:6d82:b0:bc:8bd6:d460 with SMTP id wl2-20020a056a216d8200b000bc8bd6d460mr12497833pzb.3.1675909705403;
        Wed, 08 Feb 2023 18:28:25 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e27c-1c35-0ce2-b4ea-bbbd-f504.emome-ip6.hinet.net. [2001:b400:e27c:1c35:ce2:b4ea:bbbd:f504])
        by smtp.gmail.com with ESMTPSA id j11-20020a637a4b000000b004e6adc2a8desm198833pgn.30.2023.02.08.18.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:28:24 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Harvey <hunge@google.com>, Abner Yen <abner.yen@ecs.com.tw>,
        Stephen Boyd <swboyd@chromium.org>,
        Bob Moragues <moragues@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7280: Adjust zombie PWM frequency
Date:   Thu,  9 Feb 2023 10:28:16 +0800
Message-Id: <20230209102807.1.I3e1463cd0fb66311a269f2698d0767a2acfaac3f@changeid>
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

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
index 64deaaabac0f..000f64d27ab9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
@@ -61,8 +61,8 @@ ap_tp_i2c: &i2c0 {
 };
 
 &pm8350c_pwm_backlight {
-	/* Set the PWM period to 200 microseconds (5kHz duty cycle) */
-	pwms = <&pm8350c_pwm 3 200000>;
+	/* Set the PWM period to 320 microseconds (8kHz duty cycle) */
+	pwms = <&pm8350c_pwm 3 320000>;
 };
 
 &pwmleds {
-- 
2.17.1

