Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338836F5873
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjECNBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjECNBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:01:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166271A5;
        Wed,  3 May 2023 06:01:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-95369921f8eso832037066b.0;
        Wed, 03 May 2023 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683118877; x=1685710877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MwC+BnPU6BKqxfDtGr6AFGwZArDyvQQ/gezoS0Ber4M=;
        b=X3oBKjudACwmC75Y4wdJDr/J+xLu8cqCfJ7s6xOe71aUPDGQ1Q6bGm3sZA416t1+Sr
         iXcevJSgMY4H67knvJTWrlnLkjFaoirfoBQSM4cNPugqgp+lutVkqjyGTXGjskpXh6I+
         OH9auC7rUdmKJN31C3C/e+HZP6tLmfOXY7Whi538m9aBoGQ7A0bnGPspxTfsD1ziKnOm
         VrtcF3vl4yhmkE1SORUM76taFPbaXigFI4rK959Z0xvlqypRgcKHV643jqYoEclL3y14
         S75aEIN3xUKpKayqonu7OaGzFnUsWSOYnVG1Zirjzaa7ElSP+Y+LG/8YQz0lVUsYYZ5e
         8Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118877; x=1685710877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwC+BnPU6BKqxfDtGr6AFGwZArDyvQQ/gezoS0Ber4M=;
        b=GKnJ8ZgwdQOMLEiZqtzgeNHFHjAy3rkFXqtL152E2zCkTjZy1CKR6totn/kgjwW+Ol
         KHjQ/OCcFmPk+XPUjGo1QNJpmTHuSnq/0cMloDb9HGKRym2KrrNerboU1MVdzvnmCxcE
         lfLRirotPlNKD2ieI8aEbRcENed/eL35KDFA1qzaBu/lMFDFmOi8ijwEplS/OTvg3ua4
         O6/Bu44bIiLvloN098aCy11hhbfAsh543rLhmUxjaiPP+XdR4F9Cs4RpxGWoegfxmef1
         IMc2E8CVTDuc/CnXXZHuno/tL+XGlq7vvTkOa7o6F+0qe9bjzhhsfPuAgp8SxbqxvVPl
         dZGA==
X-Gm-Message-State: AC+VfDwyNDZ1S22tJAe+qrX9Eeg9+vo274HowL+1o4DMiRXsW6ADRkLc
        ibS8nym1dcwcomQkr0GVBfQ=
X-Google-Smtp-Source: ACHHUZ47sxAcuWe0Hv30Dop6iLckSfStKoHwrI2n8/fQBLmJMSxeAD8FhXDAXTZyMlEzKeQReVI4+w==
X-Received: by 2002:a17:907:608f:b0:94a:71b6:c007 with SMTP id ht15-20020a170907608f00b0094a71b6c007mr3327638ejc.8.1683118876191;
        Wed, 03 May 2023 06:01:16 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id my17-20020a1709065a5100b0095728081944sm16105578ejc.146.2023.05.03.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:01:15 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/3] MSM8996 Pro CBF scaling support
Date:   Wed,  3 May 2023 16:00:48 +0300
Message-Id: <20230503130051.144708-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

MSM8996 Pro has a /4 post divisor on its CBF PLL instead of /2, allowing
it to reach 192000000Hz on the lowest CPU OPPs (compared to 307200000Hz
on MSM8996). Add a compatible string to differentiate between the two and
handle the different divisor in the driver. Finally, add peak bandwidths
to CPU OPPs in msm8996pro.dtsi.

This series depends on the following patch series:
  clk: qcom: msm8996: add support for the CBF clock
  https://lore.kernel.org/linux-arm-msm/20230410200014.432418-1-dmitry.baryshkov@linaro.org/

Yassine Oudjana (3):
  dt-bindings: clock: qcom,msm8996-cbf: Add compatible for MSM8996 Pro
  arm64: dts: qcom: msm8996pro: Add CBF scaling support
  clk: qcom: cbf-msm8996: Add support for MSM8996 Pro

 .../bindings/clock/qcom,msm8996-cbf.yaml      |   4 +-
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi      |  51 ++++++++
 drivers/clk/qcom/clk-cbf-8996.c               | 121 +++++++++++++++---
 3 files changed, 160 insertions(+), 16 deletions(-)

-- 
2.40.0

