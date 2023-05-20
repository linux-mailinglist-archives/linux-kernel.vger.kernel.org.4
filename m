Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6255F70A7B0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjETMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:19:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA63114;
        Sat, 20 May 2023 05:19:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af2c35fb85so7754941fa.3;
        Sat, 20 May 2023 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684585183; x=1687177183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILLhjigqsA3yiwYXuL0DC8PXe0piY++zMYPrg96OeNg=;
        b=qwkLzQ4YRZhk3RZ3BE+JIupUhQ7cbgzhs7jMmfZVu9XxbcSiWRvTiHk5+7U2SigKyY
         HZDu3kREXMUlKrKLw+dCRTqhxrx1QG7ZP6W6XVzdEmIsWz1U0LM3lbbTd6SDNyNXgGcq
         agaHNR1uNVVa4NMaz3e0Vj3ouDl9gtun/nVMfLFQ9Mt7uhWIctWTh8rBBxk276BvXu7c
         X1TliX7tjnmVi+camRnd3ixYnbp4Kq0P4lOmZiyJyWJFnwzBEw/ULoowW0zVb5Pt1AG8
         hjmD67QwlDq9zmnlZIrFnqYBwk5J6Mz3jCiiWeDomQedOgSvIZQYL5QSMVLChIcL3XkS
         /uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585183; x=1687177183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILLhjigqsA3yiwYXuL0DC8PXe0piY++zMYPrg96OeNg=;
        b=mGy1IyTcUds9Rfcixtnc37jc3hih69RnN/cxxk29X+lHJs1RyW2Wl7H1CSBXXiGAEz
         YqjPlXdk57b7dYgSaGCw5W36lPTJAnS1MoKJfMuSDTcsrQCOE2kribf1YwhQMLOAppsu
         Uw9Hi9IguRgDmvymmYAtRQv1LHOVpXR39K9BItvp01ZKirhmfgncDiOIfN085qfq74yA
         BI+5WFWlc8Z+e6C6yzTaifFcZGGj4TK+pnBSiCmvlbP9nGeE6f/y5LD3x4TD4shpZOvG
         WAev8EvX2vT5JJ/IREy2JOP94wnL6nRcckB13acF8S4/SxHL6TELrpE5I9OWqNz5ZIJ+
         OmwQ==
X-Gm-Message-State: AC+VfDyxlKI6VZZDHeJ8ZTE1eNhvF16kRI3StfpBcwHdJ7XyuKudzmCi
        0bRhJJkx0upv0evHHOPjr/AfBBvihEpJKg==
X-Google-Smtp-Source: ACHHUZ78w1zsmlXELXaaj9eQ72xXXUDt4ZQztkvyVbwHUU934HtIeGV4VklGfl4+gijuMPGdz3jt+A==
X-Received: by 2002:a05:6512:984:b0:4f3:7ba4:939a with SMTP id w4-20020a056512098400b004f37ba4939amr1452967lft.67.1684585182927;
        Sat, 20 May 2023 05:19:42 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id r11-20020a19ac4b000000b004edafe3f8dbsm260303lfc.11.2023.05.20.05.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:19:42 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] PMU, rpm-stats and IMEM for MSM8226
Date:   Sat, 20 May 2023 15:19:29 +0300
Message-Id: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds PMU, rpm-stats and IMEM nodes for MSM8226.
It also defines reboot modes for MSM8226.

Changes in v2:
  - Use constants instead of magic number in PMU node
  - Always enable IMEM node
  - Move reboot-mode magic numbers to platform,
    those should be always the same, drop patch for matisse-wifi

Matti Lehtimäki (4):
  dt-bindings: sram: qcom,imem: Document MSM8226
  ARM: dts: qcom: msm8226: Add PMU node
  ARM: dts: qcom: msm8226: Add rpm-stats device node
  ARM: dts: qcom: msm8226: Add IMEM node

 .../devicetree/bindings/sram/qcom,imem.yaml   |  1 +
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

-- 
2.34.1

