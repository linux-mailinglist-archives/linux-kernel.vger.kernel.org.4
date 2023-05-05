Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92A26F8534
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjEEPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjEEPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:02:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E782317DE3
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:02:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so13224905e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683298973; x=1685890973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPNq8x+5scNFhOFrThr9eIX+i+ZsMqOnHs2M2WuTbwo=;
        b=HXFrxhMereJ9btfSr9LxY3tv7rLs1IZj2Y5p6GppNwkQL0rTuRjQ1aGa1QtIHlDQym
         NY5t1Zd7kQ1gQLP3VNwDy9Ao+KRFl7fF8HYGiL35hod2478geb2zgUGfKv1gzgJep6Fk
         tujA4+981qIlsSMRnf23zTeTr5zYZzluG2l2nRK8kAVBpW6kHOoMDrG4tPeUpvFkOMRR
         t7ItPb6OHykWBQv4naa9H606Ek3Jui0zlv0GmsIi2/esY3kznHKlKsbuQfb7FmbVxtGv
         v+HErHrwMniE74ui+UyeFpmesevJKE8oO9gm4x0h4k1pAK7yXaH1TKPnXdK+ErJFdyR3
         ag+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683298973; x=1685890973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPNq8x+5scNFhOFrThr9eIX+i+ZsMqOnHs2M2WuTbwo=;
        b=PYtdjlwdWTFAwDHNzCEaDiGJEtlLXG8ZSluH01947apWZC27mOLfYG/+/hvLV3N7v1
         WYkFFBYHkBLhG4OInLkH7UOVMyx3LvzT/UNRHFN5IiQqS9jfQDrvmTL7L2WpkKguyB7n
         70nZFfXolbLeMDyLtXTYZilCMQN2HOa5Lw//5ovi1bb6wZV0a91nkHXa0t1a6RvB+fK/
         7cdHTSoLid7D6l3Ajl8J1i0oQSifTG5Lai7HP6XDwMC3/S5ahMe+KUOnncGip8G/r19H
         sq52tAsCsYuWQb2Blh/uKZZtvMhKDnNGk+gaoukpIA+enGCgfNCBVnmTSFfOYjFvA5fa
         qpmA==
X-Gm-Message-State: AC+VfDxuob/L5Y3CUNjnmrsC6Wf0SM05Q2z9fXV5IW/ACcBxYTqZvWFv
        MD2JF7ewM9G3tmh/zOVREkcBHg==
X-Google-Smtp-Source: ACHHUZ552E1HSInQA+Wp1DS9m2O1OdUxQcw0FYXMFthsx50dEaV8iStUKJeF34SrXnWHI3zE6ZawpA==
X-Received: by 2002:a1c:ed03:0:b0:3f1:e5f2:5e86 with SMTP id l3-20020a1ced03000000b003f1e5f25e86mr1300889wmh.23.1683298973330;
        Fri, 05 May 2023 08:02:53 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id a6-20020a1cf006000000b003f0aefcc457sm8262189wmb.45.2023.05.05.08.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:02:52 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: [RFC PATCH v4 0/2] PM: domain: Support skiping disabling unused domains until sync state
Date:   Fri,  5 May 2023 18:02:39 +0300
Message-Id: <20230505150241.3469424-1-abel.vesa@linaro.org>
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

This is another try at making the unused domain remain enabled until
sync state of the provider. There have been already few attempts.
Last one is [1]. This new approach comes after a discussion on the
mentioned mail thread with Saravana and Ulf. The suggestion there was to
move this to the genpd core. This new approach, first is adding the
support for 'unknown' initial state of a domain, then uses 'boot status'
to make decisions whether to power off a unused domain on late initcall
or assume it will be powered off on the provider's sync state callback,
if it has one registered. In order to make use of the newly added
'unknown' state, we need to update all the calls to pm_genpd_init to
pass one of the 'on', 'off' or 'unknown' states.

[1] https://lore.kernel.org/r/20230327193829.3756640-1-abel.vesa@linaro.org

Abel Vesa (2):
  PM: domains: Expand initial state of domain to support unknown state
  PM: domains: Skip disabling unused until sync state

 arch/arm/mach-s3c/pm-s3c64xx.c             |  4 +-
 arch/arm/mach-ux500/pm_domains.c           |  2 +-
 drivers/base/power/domain.c                | 62 +++++++++++++++++++---
 drivers/clk/davinci/psc.c                  |  3 +-
 drivers/clk/mmp/pwr-island.c               |  2 +-
 drivers/clk/qcom/gdsc.c                    |  2 +-
 drivers/clk/renesas/clk-mstp.c             |  2 +-
 drivers/clk/renesas/r9a06g032-clocks.c     |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c     |  2 +-
 drivers/clk/renesas/rzg2l-cpg.c            |  2 +-
 drivers/cpuidle/cpuidle-psci-domain.c      |  2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c        |  2 +-
 drivers/firmware/arm_scmi/scmi_pm_domain.c |  2 +-
 drivers/firmware/imx/scu-pd.c              |  3 +-
 drivers/firmware/scpi_pm_domain.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    |  2 +-
 drivers/irqchip/irq-qcom-mpm.c             |  2 +-
 drivers/soc/actions/owl-sps.c              |  2 +-
 drivers/soc/amlogic/meson-ee-pwrc.c        |  7 +--
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c    |  3 +-
 drivers/soc/amlogic/meson-secure-pwrc.c    |  5 +-
 drivers/soc/apple/apple-pmgr-pwrstate.c    |  2 +-
 drivers/soc/bcm/bcm2835-power.c            |  2 +-
 drivers/soc/bcm/bcm63xx/bcm-pmb.c          |  2 +-
 drivers/soc/bcm/bcm63xx/bcm63xx-power.c    |  3 +-
 drivers/soc/bcm/raspberrypi-power.c        |  2 +-
 drivers/soc/dove/pmu.c                     |  4 +-
 drivers/soc/imx/gpc.c                      |  4 +-
 drivers/soc/imx/gpcv2.c                    |  2 +-
 drivers/soc/imx/imx8m-blk-ctrl.c           |  2 +-
 drivers/soc/imx/imx8mp-blk-ctrl.c          |  2 +-
 drivers/soc/imx/imx93-blk-ctrl.c           |  2 +-
 drivers/soc/imx/imx93-pd.c                 |  3 +-
 drivers/soc/mediatek/mtk-pm-domains.c      |  4 +-
 drivers/soc/mediatek/mtk-scpsys.c          |  2 +-
 drivers/soc/qcom/cpr.c                     |  2 +-
 drivers/soc/qcom/rpmhpd.c                  |  2 +-
 drivers/soc/qcom/rpmpd.c                   |  2 +-
 drivers/soc/renesas/rcar-gen4-sysc.c       |  2 +-
 drivers/soc/renesas/rcar-sysc.c            |  2 +-
 drivers/soc/renesas/rmobile-sysc.c         |  2 +-
 drivers/soc/rockchip/pm_domains.c          |  3 +-
 drivers/soc/samsung/pm_domains.c           |  2 +-
 drivers/soc/starfive/jh71xx_pmu.c          |  3 +-
 drivers/soc/sunxi/sun20i-ppu.c             |  6 ++-
 drivers/soc/tegra/pmc.c                    |  5 +-
 drivers/soc/tegra/powergate-bpmp.c         |  3 +-
 drivers/soc/ti/omap_prm.c                  |  2 +-
 drivers/soc/ti/ti_sci_pm_domains.c         |  2 +-
 drivers/soc/xilinx/zynqmp_pm_domains.c     |  2 +-
 include/linux/pm_domain.h                  | 12 ++++-
 51 files changed, 140 insertions(+), 63 deletions(-)

-- 
2.34.1

