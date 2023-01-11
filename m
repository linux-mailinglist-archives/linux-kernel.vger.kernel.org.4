Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD1666356
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjAKTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjAKTO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:14:57 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D623D9F2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:14:56 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id s22so17040267ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaIBd0CC37lKBZFOz5cdwnKW8YSH6Qh1+49VQVi/i9Q=;
        b=jXqdERILJY3x0nbobfIpiJucQ5W277/Dw+XLPtmc1n+5F7TkDXMPcbYhf2/vHzIFQc
         XwoCA6E4rwRKdOvuSl1OuTNPxkNFlGdBBrTGTQnhMG7xAcPIPLJSXvzfMSUvWznNOpkV
         B0TOcSgyda0LEUqyu24gsWr0tCESzUL+h5GPr+LFwNdX8Or4FXrFPyN8HjuoA5AIwP7y
         rwtQ10+2gm+tSbi0AP9c8YGYuvkNJ3S5fQ4sbrQCG1+QhcFz5YJFFd5A+sCSUmbbt4cF
         3DiWlpPgha1P4ZUzof2HFTdpkfDYOEMlQJp8irD5ZQEzFpN4yZ/Y+qmnUkxNjLD1WAmI
         lKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaIBd0CC37lKBZFOz5cdwnKW8YSH6Qh1+49VQVi/i9Q=;
        b=qlcMlOTgiUI9b6VVl97h7zgmR9fmhOM8nX0rs8iRMtl78i6DQMykdGufyad10PN5Ve
         nnOqZ8UmudQnAR9bJiXWWpkH8pxKSkpFfG+D3Bx02yQPnuqQDRgQRmAQUlS2uQktYePO
         sQmpXOuGL9X6+wDspYa6tkb2RgU7pc5WIhULszZ3Y6huW2QcD5HhnYYEzkVKEYVf/yBb
         mSTUbuYfrpzZ8/fmTc/dmnXVier4v6pytSVjb40l+g37s/hQwhWTwb6nuPtVkVdqzKX+
         VTMJ9USnsw+GobQCJQseMWrXrpwvJBFZFxpoboxSRYf1pu84k4PKM51CWlzpTmZx6O9Z
         /RRw==
X-Gm-Message-State: AFqh2kr7VYZC5Y3QO5yBwIhRSecv28tKryEntXkn6OU+ZHl3mGIRboMN
        ZsCD+v3ACgl9r2WIzC90hR+3ow==
X-Google-Smtp-Source: AMrXdXtZnSmEZtVm9mYx87dyPnUp2PfAWqlQwp0jFiOqupK1w1Pz/eKWHCE0RogYRnCpreYOn77zmg==
X-Received: by 2002:a2e:b056:0:b0:27f:cacd:e7ec with SMTP id d22-20020a2eb056000000b0027fcacde7ecmr13735043ljl.28.1673464494889;
        Wed, 11 Jan 2023 11:14:54 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r7-20020a2e8e27000000b00289873cce0bsm76343ljk.14.2023.01.11.11.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 11:14:54 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] clk: qcom: msm8996: add APCS clock driver
Date:   Wed, 11 Jan 2023 22:14:49 +0300
Message-Id: <20230111191453.2509468-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
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

The sys_apcs_aux clock can be used by CPU and CBF clock drivers to drive
those clocks from GPLL0 while doing initial setup. Add simple driver to
setup and export this clock.

Dmitry Baryshkov (4):
  dt-bindings: mailbox: qcom: correct the list of platforms using clocks
  dt-bindings: mailbox: qcom: add #clock-cells to msm8996 example
  mailbox: qcom-apcs-ipc: enable APCS clock device for MSM8996
  clk: qcom: add the driver for the MSM8996 APCS clocks

 .../mailbox/qcom,apcs-kpss-global.yaml        | 10 +--
 drivers/clk/qcom/Makefile                     |  2 +-
 drivers/clk/qcom/apcs-msm8996.c               | 77 +++++++++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       |  2 +-
 4 files changed, 81 insertions(+), 10 deletions(-)
 create mode 100644 drivers/clk/qcom/apcs-msm8996.c

-- 
2.30.2

