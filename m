Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD08710C11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbjEYM3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbjEYM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:29:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A76A135
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:29:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3093a6311dcso2014986f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685017782; x=1687609782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbjF4qIKtaMQTYJ+wlxvW8+DnMXh9O9l4H+hCicLL3g=;
        b=WhWXnEZ2q8RXW6A/hQwITkthrXBDl4NRDYPZoetBFLivPwZFyDuDZ3vqEEPtomUCq0
         6RcN8Amy90LcgKN2jruJrysXD5V1EESMrbJmIGh26LHp83hyUZxkqBWL6hA88kXOx0lJ
         ab1agDtK04+8MvjsaeyjnwuHMGXN8gph62LaGHNK365H0PsPxx87wxLZBy6brAjzxfMa
         MskIXA8vH4UYfAuhclqLpVx1NDrwFEB3sXFkeizVzUjNI9YWgyegyjdekRF3vOstetD4
         sxi+BCRBQdjQ1Svu2Kbbt8T2XcO86WYCW5RC65zwO1zdLM2LWhQk1kR5sAtONgxziebl
         wzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685017782; x=1687609782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbjF4qIKtaMQTYJ+wlxvW8+DnMXh9O9l4H+hCicLL3g=;
        b=Xpnrvpo/518JQgzyWdLh25hJz1Hm3eG96sdxC3SQV5nfWONvYBkQ85i9dZoDskApRS
         Drf/w3hIu9YdpqCCVh1wroHabD5GaLG8n0nxV3Gon5VYPi90DVVX5gJz3L5kS0Hyhhhj
         9iQugccC70xNe6zkktkxQa3vUMwSa83qh4Xmy2phfrDGZNi2X67TkSnTbqHfKmstI/gw
         Lrkr5QbZOiERHjauW7JdByQZoftZaTTQmjGZm/qKrJd2JRVPTRJpGZ825rn/GBc+h6GG
         Ju1X7kUcdlUs+F8LiyyjXqagFGlM42tAwN8DMPEGKcfzfnKNvtbAv8jYgYM5XTZsAQ00
         vHKw==
X-Gm-Message-State: AC+VfDzjAaChVMOCUEg4aSuOU5cIKV4kXyZ6PiPQHL5Nho3GLaR2GURw
        TAJ8PdJ1ckh6ZNYsVRVx1VVQ0Q==
X-Google-Smtp-Source: ACHHUZ6XaRtDhw79YdAx0/lPJBVfzOSxgMjj4wnynLjJpXTf31y0b6w/Rhm/mRIe+JywkadDjlHL9g==
X-Received: by 2002:adf:f348:0:b0:306:3381:67fe with SMTP id e8-20020adff348000000b00306338167femr2517041wrp.27.1685017782357;
        Thu, 25 May 2023 05:29:42 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b003062b2c5255sm1700227wrm.40.2023.05.25.05.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 05:29:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/6] clk: qcom: sc8280xp: add lpasscc reset control
Date:   Thu, 25 May 2023 13:29:24 +0100
Message-Id: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SC8280XP, LPASS IP is controlled by q6dsp, however the reset lines
required by some of the IPs like Soundwire still need to be programmed from
Apps processor. This patchset adds support to reset controller on LPASS
CC and LPASS AudioCC.

Tested on X13s.

Thanks,
Srini

Changes since v1:
	- updated dt binding to be in a accending order and fixed spaces in example
	- updated kconfig and make file to fix the order.
	- updated driver with various minor comments Johan.
	- added defconfig changes patch
	- fixed missing reset entry for swr0

Srinivas Kandagatla (6):
  dt-bindings: clock: Add YAML schemas for LPASSCC and reset on SC8280XP
  dt-bindings: clock: Add YAML schemas for LPASS AUDIOCC and reset on
    SC8280XP
  clk: qcom: Add lpass clock controller driver for SC8280XP
  clk: qcom: Add lpass audio clock controller driver for SC8280XP
  arm64: dts: qcom: sc8280xp: add resets for soundwire controllers
  arm64: defconfig: Enable sc828x0xp lpasscc clock controller

 .../bindings/clock/qcom,sc8280xp-lpasscc.yaml | 68 +++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 23 +++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/clk/qcom/Kconfig                      |  8 ++
 drivers/clk/qcom/Makefile                     |  1 +
 drivers/clk/qcom/lpasscc-sc8280xp.c           | 86 +++++++++++++++++++
 .../dt-bindings/clock/qcom,lpasscc-sc8280xp.h | 17 ++++
 7 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
 create mode 100644 drivers/clk/qcom/lpasscc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h

-- 
2.21.0

