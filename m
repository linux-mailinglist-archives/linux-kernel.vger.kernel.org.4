Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF470623E78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKJJVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:21:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067286A683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:21:16 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f37so2017247lfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEVHYkNLaKaVRtKWsEFztX3vRYcFwb5P6qHusc9rNXA=;
        b=KKS49WTtT6lta72rnCAUh3ESikVI5Y3HIqrgfHLaR6EgHNzRi6kWmkWd0xpN2+xtwG
         JqYhwOi9VC+J6UTA872LagXNkLUI3IR7fGMgAjsirHl7M/Z8AVS0yNglzllEJCLh2Gdy
         k66k0GYtOCEbPCebeN1HpbjWZpGypiqvO/F7xRPwFNBglEPe3oaIrUjrJaBNUPTAY/tF
         c7BsAL9PdmIXeDLtRnx+aTLXHbg4JhM8T1jA0RmsM2TJKe15uufVDi8JCn3uKT5Vb2MJ
         LeGPFSsxDR2RceH6pMPLs7rpf8OC35hQdC73x28CrYCBueHXhbmB785cnvCne1ZPR3ZL
         btWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEVHYkNLaKaVRtKWsEFztX3vRYcFwb5P6qHusc9rNXA=;
        b=24gx6ufUF0VTJs0s+poqHAFchz3wsHPLA/jVdIOFraGf5G45hQjijqNU2cs6s/guKb
         ft1SSaaxgRWglOve1xvDhdFjR0G9rJVDpvpi5VacODiEq1RZ3FBpYMHRfuGjtsbs33tu
         JSiC6OdzlDH2olpmw5WMyDlJng0kYQqbWcrihLTolWO617hZmLwTkmIe0ZGbpOQWFIc7
         siKkLG80fnx1QxX8bNoD4XGA8L7Zjd+UQAtoVAF9hftTRP+J5ByW0WzFECGvKkdMyrVS
         L0B6LKtkUmreXnZyxzpsaFf8moStUQ25m/hbsMnSzlnMXjtLcGE+8Fp36roGowq5cR1f
         EfgA==
X-Gm-Message-State: ACrzQf21guVmDmdl/QiPOE9c17thLgjRUW8onka7CQ5A2JGCG5Xkmd6y
        I65D8rv1M12zrZ0A+lMWMvbktA==
X-Google-Smtp-Source: AMsMyM5vi7JtYPxbKQOwE53mcnrQPH9NtIclvr731Cak0G2jNM4Icnn66SdEBCOP8civ5KxBNGKKyA==
X-Received: by 2002:a05:6512:532:b0:4af:e7d3:9478 with SMTP id o18-20020a056512053200b004afe7d39478mr20269727lfc.102.1668072074365;
        Thu, 10 Nov 2022 01:21:14 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id u8-20020a2e2e08000000b0026dcf81d804sm2592082lju.31.2022.11.10.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 01:21:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] ARM: dts: Cleanups for v6.2
Date:   Thu, 10 Nov 2022 10:21:11 +0100
Message-Id: <20221110092111.18581-1-krzysztof.kozlowski@linaro.org>
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

Various cleanups missed or acked by maintainers.

Best regards,
Krzysztof


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.2

for you to fetch changes up to 001b38cea30961e0f4e562a1872f2409a8024ff0:

  dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc compatible after rename (2022-11-10 10:18:49 +0100)

----------------------------------------------------------------
Minor improvements in ARM DTS for v6.2

1. Aspeed: fix qcom,dc-scm-v1-bmc compatible in the bindings.
2. Marvell: include bindings in maintainers entry.
3. Cleanup DTS according to bindings (panel endpoint unit address,
   incorrect spi-max-frequency, generic node names).
4. Few indentation fixes.

----------------------------------------------------------------
Krzysztof Kozlowski (10):
      ARM: dts: am335x: drop panel endpoint unit address
      ARM: dts: sunplus: sp7021: drop incorrect spi-max-frequency
      MAINTAINERS: ARM: marvell: include bindings
      ARM: dts: aspeed: align SPI node name with dtschema
      ARM: dts: ti: correct indentation
      ARM: dts: armada: correct indentation
      ARM: dts: kirkwood: correct indentation
      ARM: dts: omap: correct indentation
      ARM: dts: sunxi: correct indentation
      dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc compatible after rename

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |  2 +-
 MAINTAINERS                                        |  3 +
 arch/arm/boot/dts/am335x-evm.dts                   |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |  2 +-
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi  | 10 ++--
 arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi  | 10 ++--
 arch/arm/boot/dts/am335x-pepper.dts                |  4 +-
 arch/arm/boot/dts/am3517-evm.dts                   | 16 +++---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 10 ++--
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 10 ++--
 arch/arm/boot/dts/armada-370-rd.dts                | 16 +++---
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |  6 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     | 10 ++--
 .../boot/dts/aspeed-bmc-facebook-cloudripper.dts   |  2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts   |  2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts     |  2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts |  2 +-
 .../boot/dts/ast2600-facebook-netbmc-common.dtsi   |  2 +-
 arch/arm/boot/dts/kirkwood-b3.dts                  |  2 +-
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |  2 +-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |  2 +-
 arch/arm/boot/dts/kirkwood-dir665.dts              | 14 ++---
 arch/arm/boot/dts/kirkwood-ds112.dts               |  2 +-
 arch/arm/boot/dts/kirkwood-ds411.dts               |  2 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  2 +-
 arch/arm/boot/dts/kirkwood-km_common.dtsi          |  2 +-
 arch/arm/boot/dts/kirkwood-l-50.dts                | 24 ++++----
 arch/arm/boot/dts/kirkwood-laplug.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        |  2 +-
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 16 +++---
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  2 +-
 arch/arm/boot/dts/kirkwood-nas2big.dts             |  2 +-
 arch/arm/boot/dts/kirkwood-net2big.dts             | 10 ++--
 arch/arm/boot/dts/kirkwood-net5big.dts             | 10 ++--
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  | 12 ++--
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-nsa320.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-nsa325.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi      |  2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts           | 60 ++++++++++----------
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |  2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |  4 +-
 arch/arm/boot/dts/kirkwood-rs212.dts               |  2 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |  2 +-
 arch/arm/boot/dts/kirkwood-t5325.dts               |  2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |  4 +-
 arch/arm/boot/dts/kirkwood.dtsi                    | 34 ++++++------
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi          |  6 +-
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi          |  6 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts               | 12 ++--
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  6 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |  2 +-
 arch/arm/boot/dts/omap3-n900.dts                   | 38 ++++++-------
 arch/arm/boot/dts/omap3-zoom3.dts                  | 44 +++++++--------
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi           | 24 ++++----
 arch/arm/boot/dts/omap5-cm-t54.dts                 | 64 +++++++++++-----------
 arch/arm/boot/dts/sunplus-sp7021.dtsi              |  3 -
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi      | 14 ++---
 58 files changed, 278 insertions(+), 278 deletions(-)
