Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A165D6DA239
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbjDFUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjDFUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:07:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F89033
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:07:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r29so40630229wra.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680811669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SImv1Rdk/+kE5EteKBqsurf3m5xVNf7BO/4yX5HUIM=;
        b=WjeHYe0vmiAkeua0VT7ZVcJlF+Tnlz4iYE2OEXOy+OvmP4Ud89Kz7xAz4rtag4h26a
         I23SMRAiz7875kUZ5VCa8FysC35Ny5SWMXJKEQSfiXc6Am4pHX6PwpZor8IFq/Ipinu1
         wfOUcEhsShJfMew+6uQyu5WY1RKRBgdWNjJYy8kS8jWboL05splsbv/yjipH0X23f0wC
         sBmZ3lb5ye8WmgEx1l6gS8DyA1OI/imHst38pOe5px8cA5BqNsCOKyIzEJo+XyCc/HBk
         hhVB7hV4hGxRxTR/YweB1sXuSlYvzdnS9TeWrVDbbyDzKcc06/cWX6y5wgXjaZyJ3TML
         OEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SImv1Rdk/+kE5EteKBqsurf3m5xVNf7BO/4yX5HUIM=;
        b=h+QGTud9MeU5Yo5c9uZz7C8AIEf+XI4qylLqgowFfuM9NHZRRTb5cWXw/uUAArAYI6
         zVLpmtZEnOZG9NtlHyv979U4A36TWQb4xDSt1yWifHMT1mPXulLkkSJRran3uR6Ys/o0
         4zevI/KvwzToVwKHKuSGu2nDVpybDygkg+PQ3y2iHvS3bokvpnboHTEsdLsUZHbS2Zdi
         CqbOx4LlIaZeY4zbkH+n14qNGAKcjIHdFqKVzsKk5vNEThv7ZJaIy732BgrmWh2AjRxt
         e1sNnxqXKht+rDR9Jizc+a2AGlAG+R+FJ0QufchqJfkWKXX46yuCqmShsY4vzxGlH6GM
         FGOQ==
X-Gm-Message-State: AAQBX9dWiKfULaiHEd+9rJTPKsVqVDpOGQglxab+D3T35v76yb7XxfG4
        RYRi0xMasOi/jBVRiUS4/6dlog==
X-Google-Smtp-Source: AKy350aqh8Akw7hp7e53sm6ji/MH7B41I+AjfxnjeOwFkxczT7A+0E2LkoY06UBce0pl07AQwayx1Q==
X-Received: by 2002:a05:6000:508:b0:2d7:89ce:8319 with SMTP id a8-20020a056000050800b002d789ce8319mr6475533wrf.27.1680811668794;
        Thu, 06 Apr 2023 13:07:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2560506wrn.52.2023.04.06.13.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:07:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/7] arm64: dts: qcom: sa8775p: add more IOMMUs
Date:   Thu,  6 Apr 2023 22:07:16 +0200
Message-Id: <20230406200723.552644-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the GPU and PCIe IOMMUs for sa8775p platforms as well as the required
GPU clock controller driver.

v1 -> v2:
- remove unused include in the GPUCC driver
- remove unused clock from the GPUCC driver and make it compatible
  with the generic QCom GPUCC bindings
- put the new defconfig option in the right place (as per savedefconfig)
  and make the GPUCC driver a module rather than built-in
- describe the smmu clocks for sa8775p in dt-bindings

Bartosz Golaszewski (6):
  dt-bindings: clock: qcom: describe the GPUCC clock for SA8775P
  arm64: defconfig: enable the SA8775P GPUCC driver
  dt-bindings: iommu: arm,smmu: enable clocks for sa8775p
  arm64: dts: qcom: sa8775p: add the pcie smmu node
  arm64: dts: qcom: sa8775p: add the GPU clock controller node
  arm64: dts: qcom: sa8775p: add the GPU IOMMU node

Shazad Hussain (1):
  clk: qcom: add the GPUCC driver for sa8775p

 .../devicetree/bindings/clock/qcom,gpucc.yaml |   2 +
 .../devicetree/bindings/iommu/arm,smmu.yaml   |   5 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 124 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/gpucc-sa8775p.c              | 625 ++++++++++++++++++
 .../dt-bindings/clock/qcom,sa8775p-gpucc.h    |  50 ++
 8 files changed, 814 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/gpucc-sa8775p.c
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-gpucc.h

-- 
2.37.2

