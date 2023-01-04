Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1365CFA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbjADJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbjADJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:35:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2E01ADA9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:35:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ja17so25111341wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bn35MCymS4jefAOtB8LpHRl6V3chqeTKM4An0AeJQ8Q=;
        b=rug8cHT3SMg1Zi5j+BhP5N7pPAd1Fv0zoxcy5+Wfd/4hoI7jy7PmTwcj7pw20vVwoI
         F48LcmbtOqhmVa2sjulZ0qTEBd/YpTf8HW83k8vLCN1R3fqTGUpZayZreN38HoL7BaTO
         ducmaxN7/sTgk3S06c6yYxCm5tidP7VEhh+Nr3FkEKyalZpw2v6Vr5q1v1oq4f4iUZ2I
         RRWeJIyBs1j1DOT61dbtNngDUIGXUXLV+MRDErM8imtZlxZJANQkhM/B4MNMOiXEPmE7
         1ss8IPG0EGGENxMgN8ejSIr0TYpZRTkafYTXKliRlraAIscw4zpD85U1bcsCVBKwe8Vu
         BVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bn35MCymS4jefAOtB8LpHRl6V3chqeTKM4An0AeJQ8Q=;
        b=X4WCzmVwT0dLOITxZheUmldHVbwvkkArcoD3rTa/664+uIIZaN4mJIJrky2k1WsvXf
         6LjjBHwwu4Dpx1EkPC+Hy3lpu8ooDPLieIKzOZylKjP0NehF6z1I3mHDL4bO5OkM+4z/
         AHmMMRefKWyXLlbQoNbB0SfprSAEi9hGkw/rMQXtFxIbf8+bUmzy+9NqyRBYHcla3NdY
         8Un43aKqYAHpDX/HTGiCIPXLDGc14yFMdGq0X7omSpmyT78rYUEZC5smsJAY6ygm4jOq
         4DQ4JEFYcoGqmThMKzGDAjYEl45I7VW9gcW6b8QzUszgnnpdRdyMcBgmKc3X/m0cQfI7
         Sq8A==
X-Gm-Message-State: AFqh2kpT/bD4MeYJNseE45f2KPNScluIlJGHM9jslbGaRaKqI4CBitPK
        vEe+bx5ZjgO94hZDKd8mNL1Oqw==
X-Google-Smtp-Source: AMrXdXuqzkSn3rR1xjuy80hePampeT5Cf59w1yG+YqfnwcxBFFloj6msrL55FaBTqOxpmsZizCsspg==
X-Received: by 2002:a05:600c:2e54:b0:3cf:ceac:94d3 with SMTP id q20-20020a05600c2e5400b003cfceac94d3mr32396174wmf.13.1672824902914;
        Wed, 04 Jan 2023 01:35:02 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b22-20020a05600c4e1600b003c6d21a19a0sm45561452wmq.29.2023.01.04.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 01:35:02 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v8 0/4] clk: qcom: Add support for SM8550
Date:   Wed,  4 Jan 2023 11:34:46 +0200
Message-Id: <20230104093450.3150578-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds more clocks support for the Qualcomm SM8550 SoC,
It adds the TCSR clock controller driver and the rpmh clocks.

Changes since v7:
 * Replaced RPMH_CXO_PAD_CLK with RPMH_CXO_CLK in the TCSR CC binding
   schema example

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Abel Vesa (4):
  dt-bindings: clock: Add SM8550 TCSR CC clocks
  dt-bindings: clock: Add RPMHCC for SM8550
  clk: qcom: rpmh: Add support for SM8550 rpmh clocks
  clk: qcom: Add TCSR clock driver for SM8550

 .../bindings/clock/qcom,rpmhcc.yaml           |   1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml      |  55 +++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clk-rpmh.c                   |  36 ++++
 drivers/clk/qcom/tcsrcc-sm8550.c              | 192 ++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8550-tcsr.h  |  18 ++
 7 files changed, 310 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsr.h

-- 
2.34.1

