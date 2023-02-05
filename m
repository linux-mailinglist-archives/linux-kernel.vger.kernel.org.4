Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2831868B05A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBEOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBEOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:47:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3524C272E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 06:47:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y1so8326307wru.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 06:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HR0gJobSHL9vE+BsCSIkgEZdXYIv6WLpvlg39qHg3YM=;
        b=ue25OXS3a4CzuB1vxQMLp9XWz3vHa0DLAQwEfEaPMjMEx4GVzObfh3kmR1W5nmzz4/
         G5vn82FlMVMJ04KGY3UmaZJmsqfQpAQGu/JR1++eJGvbLmsNaTC3/NfbgUnEmB7o7Xkc
         bTdBYzqBvMyPJCltpbgCDPQaqxcNuNwvdPSTt+emWYuZOI3hUia4aWEdw6SpvNIllN4j
         SikVCtmFO4fb2+8zaa8fgn5O+VX/EPJbHkQdnnF6GgT8F4bqSXHMwYZDseV1MnC4gwTI
         coZl3AgLT4qLxFW5DoWYUDJ1hJaDeOhtMuFQeOm6xeO+xObw6F2uUh3ZRHWSpAhCtsb9
         Otxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR0gJobSHL9vE+BsCSIkgEZdXYIv6WLpvlg39qHg3YM=;
        b=D8QtGz9Ybit7VPBEsMXzBRqvaA4a/5N3eotEXEPkveCNYw8tliStx10B6OSmmSHKzr
         FWAdaEQOrmTORTes7EAUp2kwUwj508vuEiUaFzAPXHkuylq/CzssdBadKLbNQ6l5+UZZ
         MV+Yu3AFTWvBWLOZb0FDkcFzEZVD2rHoy/gnZ8wJNrxGK8PrOn/B9NAXWpkPY4yPKjyd
         UgC2MLIDGJR/kBgc9Ay3SC4ugVshrOPqtyU7L9njDVtG/li90V5Z/qmhCndxUXO/rn9R
         RNHKipLe82+Ns0eb1gKqdESfhjl3Qhi/QICyb3IWNKjSmhNozdO584xysX1eZXFlxURb
         lHmg==
X-Gm-Message-State: AO0yUKXzAnpc/vbudVmD1y/7nfzzcnz/vPEEb0NwFuKIzXJqrZ52NMl+
        1E6V3iO9MwWvCb5D7EmqFpUtkDb5VXfcm3nr
X-Google-Smtp-Source: AK7set+F72M3wUCPpeFvd7+ejV4iEMUfZ+8nDmcg4bm7tKjZoJBQtCmQ2ecj/huPz2vyjS6ubTPI+g==
X-Received: by 2002:a05:6000:988:b0:2bf:d88b:7b45 with SMTP id by8-20020a056000098800b002bfd88b7b45mr17833434wrb.67.1675608420767;
        Sun, 05 Feb 2023 06:47:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q8-20020adfea08000000b002c3ddcf4f3asm4072354wrm.0.2023.02.05.06.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 06:47:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] samsung: drivers: secoond pull for v6.3
Date:   Sun,  5 Feb 2023 15:46:57 +0100
Message-Id: <20230205144657.951749-1-krzysztof.kozlowski@linaro.org>
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

Hi,

On top of previous pull request.

The phy patches were acked by phy maintainer and are necessary to fix warning
in my next/soc branch (already pulled).  That was an ordering issue.

Best regards,
Krzysztof


The following changes since commit 5e487164afbcd917225fb701e8956f388f43b601:

  MAINTAINERS: arm64: tesla: correct pattern for directory (2023-01-15 12:17:44 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.3-2

for you to fetch changes up to 7ecd4e5f5de23022d1a1c92058949ddf1a2113ff:

  phy: samsung,mipi-video-phy: deprecate syscon phandle (2023-02-03 20:21:26 +0100)

----------------------------------------------------------------
Samsung SoC driver changes for v6.3

Deprecate syscon phandle to the PMU node in MIPI and DP video phy
drivers in favor of putting the device nodes directly under the PMU
nodes.  This better reflects device hierarchy and allows later to solve
dtc W=1 and dtbs_check warnings.

----------------------------------------------------------------
Krzysztof Kozlowski (4):
      dt-bindings: phy: samsung,dp-video-phy: deprecate syscon phandle
      dt-bindings: phy: samsung,mipi-video-phy: deprecate syscon phandle
      phy: samsung,dp-video-phy: deprecate syscon phandle
      phy: samsung,mipi-video-phy: deprecate syscon phandle

 .../devicetree/bindings/phy/samsung,dp-video-phy.yaml         |  5 ++---
 .../devicetree/bindings/phy/samsung,mipi-video-phy.yaml       | 11 +++++------
 drivers/phy/samsung/phy-exynos-dp-video.c                     |  7 +++++--
 drivers/phy/samsung/phy-exynos-mipi-video.c                   |  7 +++++--
 4 files changed, 17 insertions(+), 13 deletions(-)
