Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E05B3B79
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiIIPJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiIIPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:08:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251913E4D4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:08:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y29so2189230ljq.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yG6n1mI/niFEcjcQjVJpd13snjc11+9Ua1ZcNArK/PA=;
        b=oEfXggTUejCD3bsEk5Eo+2JMTPU7wYewMF59Trg8eC3tcKDXXy9WPcQ/CmG4RUaDFB
         v0BbuQMpgpflqYAmI6w+ZDVN5FoE35/jmCH/VwnBtWCpZzbAELh1uQy3A95xe7uAci5y
         OrOwtu2CS7oHyXL4es6VMZhIHNyPJtLtxL8PuUd7qy/Cw2TVW70mKTKVtw95DqWc73SA
         ZaagKx6++krFfGPGbooUVF5xZihXWtqKe6v2QMCTcy7CQF8RegFYUt2P6IBtpLg3lmvU
         qPnJ09Io0tVuDU+XOSCas5VUCXCv64AADXRNempF/rlMHimS+KgZRV/GqWQJrmym6IDa
         tnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yG6n1mI/niFEcjcQjVJpd13snjc11+9Ua1ZcNArK/PA=;
        b=bnO28AxW+ufvmuN0HSp/3kw7Ujf9xyIicy/tXrfGkYWifH2fcWKj1iEakvhjX6+FuD
         B+mpHuyACwU/dVkh+E7/sXetQStPOCmCn7LpVnZVhKzSOUTpBbjcy6HOCiZD6cZ8mION
         ixGklwG16lA4nhfMzBNyPlLtuW3iTOFJPWRZiNn+I3Kt3syIkiql5mlqhuXHTCjpsPaB
         c7XPHhu3zMWQum6g37sP0I55vGCB7oep1D5A5fxTtgvoysejfeT0FFet5pIHB3qUBj7S
         IXnS1GfwqwDUaPr+EYmADwVLsfzbppZVSC/kMPtCAz9cDi3LBX9w2r29+JYGU/CJYv0u
         WloQ==
X-Gm-Message-State: ACgBeo3sHc35po03H98OD1dS80dy+G+9bK8Ck3hdgpUpa9b3/VSNfNMx
        CijjDOqyPYIKvI41tOA906FSHQ==
X-Google-Smtp-Source: AA6agR7iqqrJBwh91qdHkanhjVdu547jO82W1aU6cr1V6QbocxJYKksLDOPQALu7g/UDT1is1JsJDA==
X-Received: by 2002:a2e:b712:0:b0:26a:d1d9:f8d1 with SMTP id j18-20020a2eb712000000b0026ad1d9f8d1mr3644878ljo.271.1662736136106;
        Fri, 09 Sep 2022 08:08:56 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d26-20020a2e361a000000b0026ab83298d6sm110605lja.77.2022.09.09.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:08:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] arm64: dts: samsung: for v6.1
Date:   Fri,  9 Sep 2022 17:08:49 +0200
Message-Id: <20220909150849.820523-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909150849.820523-1-krzysztof.kozlowski@linaro.org>
References: <20220909150849.820523-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The clock binding headers are also shared with clk tree (via earlier pull
request).

Best regards,
Krzysztof


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.1

for you to fetch changes up to dfce69c8520592f1a20619050e6ded6275e9f25f:

  dt-bindings: serial: samsung: add exynosautov9-uart compatible (2022-08-25 09:47:56 +0300)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.0

1. Add binding headers for several Exynos850 and ExynosAutov9 clocks.
2. ExynosAutov9: Add FSYS clock controller nodes.
3. ExynosAutov9: Document serial compatible (used in DTS).
4. Exynos850: Add Audio, IS, MFC clock controllers. Add IOMMU nodes.

----------------------------------------------------------------
Chanho Park (6):
      dt-bindings: clock: exynosautov9: correct clock numbering of peric0/c1
      dt-bindings: clock: exynosautov9: add fys0 clock definitions
      dt-bindings: clock: exynosautov9: add fsys1 clock definitions
      dt-bindings: clock: exynosautov9: add schema for cmu_fsys0/1
      arm64: dts: exynosautov9: add fsys0/1 clock DT nodes
      dt-bindings: serial: samsung: add exynosautov9-uart compatible

Sam Protsenko (5):
      dt-bindings: clock: exynos850: Add Exynos850 CMU_AUD
      dt-bindings: clock: exynos850: Add Exynos850 CMU_IS
      dt-bindings: clock: exynos850: Add Exynos850 CMU_MFCMSCL
      arm64: dts: exynos: Add CMU_AUD, CMU_IS and CMU_MFCMSCL for Exynos850
      arm64: dts: exynos: Add SysMMU nodes for Exynos850

 .../bindings/clock/samsung,exynos850-clock.yaml    |  69 +++++++++++
 .../bindings/clock/samsung,exynosautov9-clock.yaml |  44 +++++++
 .../devicetree/bindings/serial/samsung_uart.yaml   |   5 +-
 arch/arm64/boot/dts/exynos/exynos850.dtsi          |  83 +++++++++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       |  28 +++++
 include/dt-bindings/clock/exynos850.h              | 136 ++++++++++++++++++++-
 include/dt-bindings/clock/samsung,exynosautov9.h   | 128 ++++++++++++++-----
 7 files changed, 461 insertions(+), 32 deletions(-)
