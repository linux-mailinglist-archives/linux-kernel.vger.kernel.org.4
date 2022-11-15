Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF526296A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiKOLCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiKOLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:01:13 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD23925289
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:00:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id z24so17029638ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nuNzdS+vCYaduI1SBbjEqb/s1w7i0M+zCZWOQnEf8tI=;
        b=nNRJszARFmgEoackfkwIGS0cVY7Hm0jcB2+w7hPYOLVREWwfSkWTMrERxVyqR3h/6o
         9KWbVo8+NDsNgcik8KDo3zz5JvmmzKxT3+gyTM4n7mIve+kMFR3c0aHPqd/Cn9s1OI2S
         s2nGBKsf/xjI/Js9/jWHQYUsJmdFJqURbcWTCQsgzetKWWJdeyrb1YUMxr89r6ciko8a
         wOdP26i3tJVDaxsRMN6UbGUV5EvH9GTNAMmrSY0Ii7MnwilDcKpljXq+auchGsQAvEZE
         XVnP8Mn7B19hqoYti5gPgV2sG40SGb8aYQAC3QoDADs2nd9f6+dXe1Ppr3sIrrJtdyTB
         qh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuNzdS+vCYaduI1SBbjEqb/s1w7i0M+zCZWOQnEf8tI=;
        b=iTNPLESlmItB/yN8WLjKfeCMqBccwW2YlWi4JMlyfbh4BKZSbvkmRFxNcKOZQVv/8R
         TJZdpT7hd4k7YcRjU7/F8zA4ZCnckhin6hLqt8kcb+5EIkTcwh7192rodVGlNem1Aahi
         2AzbAiEpzTRl4ScJJFd+43e0ueLMG4B1qbMJOn25/jDsMHkRcie1/8QQ0ILm0Mh1qxG7
         yFdeg27rgPe+ZOeUcBuOWzUSW8Je+QXytA9yyFz8gynYQhyUgllP/NxYVUvWYFB2fbW7
         2Cfv0Kc20O1LPydrOffl+JB35HGuNihk95+hnYZJmwvlU7gd1/skFg8MeiaITTuYzCCk
         HU4A==
X-Gm-Message-State: ANoB5pnkGlHt3hU27Yx7Q7HJUQ3OONuAHaxFdBmfh6XMmO9NIUZhog0S
        tJwKSgPHfmo1Cp2GqFvCIBB3tw==
X-Google-Smtp-Source: AA0mqf4htYlIeDyoF1dZTOfwMhHeKq8VvcouSZYlYBg4zaZVhl9C8pd0v3CgnuP1DpXkj9Wqz2Hi6g==
X-Received: by 2002:a05:651c:3dc:b0:277:4278:5a0b with SMTP id f28-20020a05651c03dc00b0027742785a0bmr5621498ljp.397.1668510056026;
        Tue, 15 Nov 2022 03:00:56 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf16-20020a056512259000b004b1b0f12cb4sm2152786lfb.201.2022.11.15.03.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:00:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: sm8450-hdk: add sound support
Date:   Tue, 15 Nov 2022 12:00:50 +0100
Message-Id: <20221115110053.110319-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1
================
1. Patch 2:
   - Whitespace cleanups.
   - Correct include - do not use deprecated one.
2. Patch 3:
   - Sort.
   - Add Rb tag.
   - Correct include - do not use deprecated one and drop q6asm.h (not used).

Description
===========
Initial work (still partially in progress) adding audio to HDK8450 board.

Working/tested:
 - speakers
 - one channel of headset

The DTS patches do not have particular dependencies, however they:
1. Use updated ASoC bindings:
   https://lore.kernel.org/linux-arm-msm/20221111113547.100442-1-krzysztof.kozlowski@linaro.org/T/#t

2. For full operation need changes in Soundwire and Qualcomm ASoC drivers, not
   yet upstreamed:
   https://github.com/krzk/linux/commits/wip/sm8450
   Booting remoteproc without these changes will report errors, but these are
   expected at this stage.

Best regards,
Krzysztof

Srinivas Kandagatla (3):
  arm64: dts: qcom: sm8450: add GPR node
  arm64: dts: qcom: sm8450: add Soundwire and LPASS
  arm64: dts: qcom: sm8450-hdk: add sound support

 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 160 +++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 335 ++++++++++++++++++++++++
 2 files changed, 495 insertions(+)

-- 
2.34.1

