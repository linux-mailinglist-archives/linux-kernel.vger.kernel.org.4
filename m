Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2052A71FD69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjFBJPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjFBJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:15:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C775CB3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:15:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-974638ed5c5so57829866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685697310; x=1688289310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqmb5ohElR5kx8b+8s1OBfcs+RHdJ5Q9TNUD2+nJ9HQ=;
        b=wg4RgZKculmKl9CscCK78hxkLWHSxRguYZTW0DFpJBhqz0jWjLPvTn36zbHfXg+fjX
         fRG/p9pGJ+Hvh6p6abnfOe00JN97yvdm17xL4vvpIq7M3rwB6/wZ64wKNTywYR08qlS6
         oAc0pPXhZai4sWrkr8qd0NbPDLXCbp6X/450c/5IhJMi5wbyq2IciejqoBvFSOcm3Pbs
         XqnQdPu7uzOK0OkuqwyUosse1zPwF+3s/ygD9WVYY1nwWr2eosJeFELEJwrViSI2rgqO
         PdF5Xu6TDg1WEm2t6CxqhrvzA0KaqymKYSy9OIGa2WTtBSvWOy6d7O+BHLcN0T2Uip1N
         Ze/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697310; x=1688289310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqmb5ohElR5kx8b+8s1OBfcs+RHdJ5Q9TNUD2+nJ9HQ=;
        b=lqIsQspAWIKdfBL+xtKYX7GuW+vUb9WSSKa4QP3OXxYlHc9Z7zpDzORBikgYrQLfMB
         tG2qVbsxN5R4whfA7ZMLpoxA0/jSoylF5JITvQc4WGaREueXqMEubaQhgzuLKUfwQpUt
         EWPEL+7+2b1+zUo9hmnZDMMUxHGvC9wOuUN0zB89ub40CwCctvpAsEekZIN7N7AVoN3i
         pwv50piNju5+a3NdXDcy/O/6Nb/dR0E+b/jnczoEh+mIYxajMB3caLrhuTvuQDirAYHY
         fARwOJG4HWBac6H7sb4G7Rv3MbVEqc9JgIjmnvRs4SBXDiigSgFkqsHYhspnhuUGcK5B
         QtVw==
X-Gm-Message-State: AC+VfDxOOrU21K4EEtZRWh6jfVRWnAUGsR5I84Gp9jtYyJvYtkUQVMDo
        /lryht54TCNDzELWO2zoTu7Gzw==
X-Google-Smtp-Source: ACHHUZ5QG5jHghA/mHewy4xAe5I4UwhmB5dosiLaSNhN+T9LsDLIzIEDoZbP/56ZPjwJJBqETycDZw==
X-Received: by 2002:a17:907:94c9:b0:973:93c3:16a1 with SMTP id dn9-20020a17090794c900b0097393c316a1mr3858259ejc.19.1685697310347;
        Fri, 02 Jun 2023 02:15:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906240d00b0094e597f0e4dsm514255eja.121.2023.06.02.02.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:15:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, replicant@osuosl.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Artur Weber <aweber.kernel@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL 2/3] ARM: dts: samsung: for v6.5
Date:   Fri,  2 Jun 2023 11:15:00 +0200
Message-Id: <20230602091501.15178-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602091501.15178-1-krzysztof.kozlowski@linaro.org>
References: <20230602091501.15178-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

`make dtbs_check` for bindings in Linux kernel produces no warnings for Exynos
ARM and ARM64 platforms. See for yourself:
https://krzk.eu/#/builders/75/builds/403/steps/7/logs/stdio
https://krzk.eu/#/builders/79/builds/401/steps/9/logs/stdio

"No new warnings in dtbs_check" is now a requirement for any new changes to be
accepted for Exynos ARM and ARM64.  S5PV210 and S3C6410 don't have such
requirement.

The dtbs_check against all the bindings - including ones with dtschema and
missing ones - points to few missing conversions to DT schema:

arch/arm/boot/dts/exynos5250-snow-rev5.dtb: /soc/i2c@12c70000/trackpad@67: failed to match any schema with compatible: ['cypress,cyapa']
arch/arm/boot/dts/exynos4210-universal_c210.dtb: /soc/i2c@138b0000/pmic@66: failed to match any schema with compatible: ['national,lp3974']
arch/arm/boot/dts/exynos5250-snow.dtb: /i2c-arbitrator: failed to match any schema with compatible: ['i2c-arb-gpio-challenge']
arch/arm/boot/dts/exynos5422-samsung-k3g.dtb: /soc/i2c@12c60000/touchscreen@20: failed to match any schema with compatible: ['syna,rmi4-i2c']

In progress:
arch/arm/boot/dts/exynos4412-p4note-n8010.dtb: /i2c-gpio-3/adc@41: failed to match any schema with compatible: ['st,stmpe811']
https://lore.kernel.org/all/20230426-stmpe-dt-bindings-v4-2-36fdd53d9919@linaro.org/

arch/arm/boot/dts/exynos5420-peach-pit.dtb: /soc/spi@12d40000/cros-ec@0/i2c-tunnel/power-regulator@48: failed to match any schema with compatible: ['ti,tps65090']
https://lore.kernel.org/all/20211217170507.2843568-6-thierry.reding@gmail.com/

I would appreciate some help in converting these.  Before starting any
conversion just be sure that no one posted same patch (lore.kernel.org and
"dfn:" for TXT filename).

Best regards,
Krzysztof


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-6.5

for you to fetch changes up to 6a988251c4e53da33107c1975f578904c0635b43:

  ARM: dts: s5pv210: Fix typo in comments, fix pinctrl header (2023-05-30 10:21:42 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v6.5

1. Final cleanups and improvements as a result of dtbs_checks which rely
   on previously merged driver changes thus affecting older or
   out-of-tree kernels.  The changes are necessary to achieve full
   dtbs_check compliance, which justifies affecting out-of-tree users.
   Changes affecting them are:
    - Drop simple-bus compatible from FIMC: Exynos4 and S5PV210,
    - Remove empty camera pinctrl configuration: Exynos4 and S5PV210,
    - Re-order MFC clock names to match Exynos and bindings: S5PV210.

2. Except above few more non-intrusive cleanups for dtbs_check for
   S5PV210.  Fix also some typos.

3. Re-introduce Exynos4212 which was removed because of lack of upstream
   users.  Artur Weber adds now Samsung Galaxy Tab3 with Exynos4212.

----------------------------------------------------------------
Artur Weber (6):
      ARM: dts: exynos: Move common Exynos4x12 definitions to exynos4x12.dtsi
      ARM: dts: exynos: Re-introduce Exynos4212 DTSI
      dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
      ARM: dts: exynos: Fix some typos in comments
      ARM: dts: s3c64xx: Fix some typos in comments
      ARM: dts: s5pv210: Fix typo in comments, fix pinctrl header

Krzysztof Kozlowski (10):
      ARM: dts: exynos: drop simple-bus from FIMC in Exynos4
      ARM: dts: s5pv210: drop simple-bus from FIMC
      ARM: dts: exynos: Remove empty camera pinctrl configuration in Trats
      ARM: dts: exynos: Remove empty camera pinctrl configuration in Universal C210
      ARM: dts: exynos: Remove empty camera pinctrl configuration in Odroid X/U3
      ARM: dts: s5pv210: align pin configuration nodes with bindings
      ARM: dts: s5pv210: align USB node name with bindings
      ARM: dts: s5pv210: re-order MFC clock names to match Exynos and bindings
      ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210
      ARM: dts: s5pv210: remove empty camera pinctrl configuration

 .../bindings/arm/samsung/samsung-boards.yaml       |  10 +
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          |   4 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   6 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |   4 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   2 -
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   3 -
 arch/arm/boot/dts/exynos4212.dtsi                  | 157 +++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   2 -
 arch/arm/boot/dts/exynos4412.dtsi                  | 646 +-------------------
 ...os4412-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} |   6 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  | 664 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |   4 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          |   2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   2 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5800.dtsi                  |   2 +-
 arch/arm/boot/dts/s3c6400.dtsi                     |   2 +-
 arch/arm/boot/dts/s3c6410.dtsi                     |   2 +-
 arch/arm/boot/dts/s3c64xx.dtsi                     |   2 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |  14 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |   8 +
 arch/arm/boot/dts/s5pv210.dtsi                     |  14 +-
 26 files changed, 878 insertions(+), 688 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4212.dtsi
 rename arch/arm/boot/dts/{exynos4412-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} (99%)
 create mode 100644 arch/arm/boot/dts/exynos4x12.dtsi
