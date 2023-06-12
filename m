Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6391272CD4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbjFLRz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbjFLRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:55:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9E10E6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:55:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9786fc23505so680230266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686592512; x=1689184512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Squ91Z4L8pOO8FBU1p7ZrCFyIyZdcQMOn+fzsX1h9Zg=;
        b=ez3iFojasVfZlCjJF3b+iCqKNMSw2Z6Xg7mDv4qemtPc8JGFBm3fWYFet2OKupt1kh
         yUPCP3VpVyETA/Ik65Tbyf46UdsESUpcw2BvBtyXMc0nuEctmPMGD4yxSzgFkQUgLzd1
         xzAiR0gq0Vm8jz24cO/zdTpBWDEca2qGRyzHWfQ9cm2QRqGaX5UeIZSWOJGNWHJUX/5h
         0klIoTx88JSrDC3VpuJimz4/pdNGbCbuqfCAh/CiqxOiJ86S9BpdDxcY5Yik7sGl2fS/
         XmyiIBZDU60LiidmpxkdT3QtO5LF+tMFrlnvxrL50S0L+EoORJyn64E7CBUSH7NXsxXG
         TuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592512; x=1689184512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Squ91Z4L8pOO8FBU1p7ZrCFyIyZdcQMOn+fzsX1h9Zg=;
        b=Ln0gLn9KulLxgosrs66nULByEIHp6cDncL9wY/ggXZUWlqCT3XWpEcD7+acENzIGPl
         gvwDLRP5yj4gzfvpi6/v5/uh5PaVHdmYrDf+TZX15z9hsya8GAae0hx0Lc40u/AiedpO
         zOcPOqp05Reg3zqw+/uQCaJSV18/qWYs39yxiPShpOaksWpghV/S13Nlbmk3k2SGNhcS
         jdkCIkkovxaozPB4UC86A3AlHbu4LfxPLkMmiKc9Navm1iJJbUwSDx1yxFKpKsgZQx5G
         +hfwKLzgcscR7mM2xTxsu28xMKR7flU2BtTgCc5jmZsNT5Ya54qaW2zAj0JwOFhH1Dsi
         hohw==
X-Gm-Message-State: AC+VfDyuisP5fQxuLRlLRp6wz5ugv3hK/mwGo2w6L6Yllj1DIehgvxNy
        kyucpjWPvw9l8Glcg0D4nlML3w==
X-Google-Smtp-Source: ACHHUZ7CckBJeuU9n3DZ+TVIpEDUbZdOoyPuxOcH4CnMt6cbKzBbmPiZKCHn0IGUgcuf97t4FmPMdA==
X-Received: by 2002:a17:907:7ea5:b0:96f:8ea4:a72c with SMTP id qb37-20020a1709077ea500b0096f8ea4a72cmr10259940ejc.62.1686592511772;
        Mon, 12 Jun 2023 10:55:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709060ac600b009745ecf5438sm5470032ejf.193.2023.06.12.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:55:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.5
Date:   Mon, 12 Jun 2023 19:55:08 +0200
Message-Id: <20230612175508.288775-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.5

for you to fetch changes up to 6a66fb9ffe7b4558c04f73593c01ee484a5c9ddf:

  dt-bindings: memory-controllers: drop unneeded quotes (2023-06-12 19:50:48 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.5

1. Renesas RPC IF: correct the Strobe Timing Adjustment.
2. Broadcom DPFE: fix smatch warning for testing array offset after use.
3. Atmel SDRAMC: drop driver because it was just a wrapper over enabling
   clock which is not handled by its clock controller.
4. Minor bindings cleanup.

----------------------------------------------------------------
Claudiu Beznea (1):
      memory: atmel-sdramc: remove the driver

Krzysztof Kozlowski (2):
      memory: brcmstb_dpfe: fix testing array offset after use
      dt-bindings: memory-controllers: drop unneeded quotes

Wolfram Sang (1):
      memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting

 .../memory-controllers/nvidia,tegra20-emc.yaml     |  2 +-
 .../bindings/memory-controllers/ti,gpmc.yaml       |  2 +-
 arch/arm/mach-at91/Kconfig                         |  4 --
 drivers/memory/Kconfig                             | 11 ----
 drivers/memory/Makefile                            |  1 -
 drivers/memory/atmel-sdramc.c                      | 74 ----------------------
 drivers/memory/brcmstb_dpfe.c                      |  4 +-
 drivers/memory/renesas-rpc-if.c                    | 53 ++++++++++++----
 8 files changed, 44 insertions(+), 107 deletions(-)
 delete mode 100644 drivers/memory/atmel-sdramc.c
