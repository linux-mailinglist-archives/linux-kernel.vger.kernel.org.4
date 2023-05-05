Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A378F6F853C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjEEPDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjEEPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:03:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB53317DF8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:02:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f3331f928cso13497835e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683298975; x=1685890975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpQjxTYQPH4LPGysS0F47etV7eYm62TgySUYg0SRM7U=;
        b=W0jz2Hbp/EDCJtfpD7z+GgNmtFajBIaP4/vXYeOmoMXtwh3nSS/1uL/5ILEfDIbFvf
         8UOo8jAMwut2YbAeOUS7ikiDCeWJEmmT24UtOZzndrdkiPwYdYsLFeGK1VXBA7geeD+b
         TP+7Ititu2q0jUNDX6C78tudSyvzT+zU07165LVN61B39sdyHEgFLIXJOFf5Rr7YYxAj
         3ROro2U8alxKu+PcdlkIlL5XyZu433EUsHyegYJPRsSpsBmzFPJtTYuYgh6MPJcmckwX
         AS895l3zRBvIoZQj3x8AhDvqGEDf6L30FBNPR75JuYcjBtUeETOqCsZhSjiPxelr9hI0
         /tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683298975; x=1685890975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpQjxTYQPH4LPGysS0F47etV7eYm62TgySUYg0SRM7U=;
        b=HLtJzkXfUwG3/4Bi8IDDSmgWfW/7/QNEMQ7cFMK3sINZRc0YouYGJ92fDB4z8nvFvA
         aa5zMxwiENQX/tpX4OEVmIU5qrh9nR7GO+i7M7HShVT4nWDxFpGXt/qgaqvlyJ2yq6to
         O+Dph6Yqo2qHPNxp7N59kwBnOdClZqm79w1npIWmjHJ+xqHtv5HghlngHJHSEFmKRsp/
         SIyvlcRbmowNXl0l0W66Pdfa0tY/OYb5q8rjMJxSuJwzVPNMcU6RKAtHurWvruvW8UAf
         wgwzUS1uZY7OfDj8l651Cyg6iRzL9SCUzZ5bhMJjaQIQ457IaLm67qIeLEMxkNepb3lz
         ZxIA==
X-Gm-Message-State: AC+VfDwkNwh6wpzHN0LIIz+lKKnngZq1CWnqPkP0Ap2gbXUmKkVuaXed
        LW+tAsuZLbKXJ9ycJ/kD+TJN9g==
X-Google-Smtp-Source: ACHHUZ5zSVTDsHAVOSy94uoOVmPX+rZKDz9PiFd5f7YMb04OklFEW4avzzUrtzxcI7cpH4TXzuszDw==
X-Received: by 2002:a1c:6a15:0:b0:3f2:5999:4f3d with SMTP id f21-20020a1c6a15000000b003f259994f3dmr1322774wmc.29.1683298975099;
        Fri, 05 May 2023 08:02:55 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id a6-20020a1cf006000000b003f0aefcc457sm8262189wmb.45.2023.05.05.08.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:02:54 -0700 (PDT)
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
Subject: [RFC PATCH v4 1/2] PM: domains: Expand initial state of domain to support unknown state
Date:   Fri,  5 May 2023 18:02:40 +0300
Message-Id: <20230505150241.3469424-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505150241.3469424-1-abel.vesa@linaro.org>
References: <20230505150241.3469424-1-abel.vesa@linaro.org>
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

Sometimes, a genpd provider has no way of reading the state from HW.
Best it can do is make assumptions of the state the domain was left
in by the bootloader. Let the genpd core know of such situations by
allowing the providers to specify the state as 'unknown' when the
domain gets initialized. Make use of the already exposed enum by
adding the 'unknown' option. Then, make all the calls to pm_genpd_init
use one of those values. This represents the HW state more accurately
and will be helpful for figuring out which unused domain needs to stay
powered on until later on.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm/mach-s3c/pm-s3c64xx.c             |  4 ++--
 arch/arm/mach-ux500/pm_domains.c           |  2 +-
 drivers/base/power/domain.c                | 13 ++++++++-----
 drivers/clk/davinci/psc.c                  |  3 ++-
 drivers/clk/mmp/pwr-island.c               |  2 +-
 drivers/clk/qcom/gdsc.c                    |  2 +-
 drivers/clk/renesas/clk-mstp.c             |  2 +-
 drivers/clk/renesas/r9a06g032-clocks.c     |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c     |  2 +-
 drivers/clk/renesas/rzg2l-cpg.c            |  2 +-
 drivers/cpuidle/cpuidle-psci-domain.c      |  2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c        |  2 +-
 drivers/firmware/arm_scmi/scmi_pm_domain.c |  2 +-
 drivers/firmware/imx/scu-pd.c              |  3 ++-
 drivers/firmware/scpi_pm_domain.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    |  2 +-
 drivers/irqchip/irq-qcom-mpm.c             |  2 +-
 drivers/soc/actions/owl-sps.c              |  2 +-
 drivers/soc/amlogic/meson-ee-pwrc.c        |  7 ++++---
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c    |  3 ++-
 drivers/soc/amlogic/meson-secure-pwrc.c    |  5 ++++-
 drivers/soc/apple/apple-pmgr-pwrstate.c    |  2 +-
 drivers/soc/bcm/bcm2835-power.c            |  2 +-
 drivers/soc/bcm/bcm63xx/bcm-pmb.c          |  2 +-
 drivers/soc/bcm/bcm63xx/bcm63xx-power.c    |  3 ++-
 drivers/soc/bcm/raspberrypi-power.c        |  2 +-
 drivers/soc/dove/pmu.c                     |  4 +++-
 drivers/soc/imx/gpc.c                      |  4 ++--
 drivers/soc/imx/gpcv2.c                    |  2 +-
 drivers/soc/imx/imx8m-blk-ctrl.c           |  2 +-
 drivers/soc/imx/imx8mp-blk-ctrl.c          |  2 +-
 drivers/soc/imx/imx93-blk-ctrl.c           |  2 +-
 drivers/soc/imx/imx93-pd.c                 |  3 ++-
 drivers/soc/mediatek/mtk-pm-domains.c      |  4 ++--
 drivers/soc/mediatek/mtk-scpsys.c          |  2 +-
 drivers/soc/qcom/cpr.c                     |  2 +-
 drivers/soc/qcom/rpmhpd.c                  |  2 +-
 drivers/soc/qcom/rpmpd.c                   |  2 +-
 drivers/soc/renesas/rcar-gen4-sysc.c       |  2 +-
 drivers/soc/renesas/rcar-sysc.c            |  2 +-
 drivers/soc/renesas/rmobile-sysc.c         |  2 +-
 drivers/soc/rockchip/pm_domains.c          |  3 ++-
 drivers/soc/samsung/pm_domains.c           |  2 +-
 drivers/soc/starfive/jh71xx_pmu.c          |  3 ++-
 drivers/soc/sunxi/sun20i-ppu.c             |  6 +++++-
 drivers/soc/tegra/pmc.c                    |  5 +++--
 drivers/soc/tegra/powergate-bpmp.c         |  3 ++-
 drivers/soc/ti/omap_prm.c                  |  2 +-
 drivers/soc/ti/ti_sci_pm_domains.c         |  2 +-
 drivers/soc/xilinx/zynqmp_pm_domains.c     |  2 +-
 include/linux/pm_domain.h                  |  7 +++++--
 51 files changed, 87 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-s3c/pm-s3c64xx.c b/arch/arm/mach-s3c/pm-s3c64xx.c
index 284d5f462513..89671d1439f0 100644
--- a/arch/arm/mach-s3c/pm-s3c64xx.c
+++ b/arch/arm/mach-s3c/pm-s3c64xx.c
@@ -291,10 +291,10 @@ int __init s3c64xx_pm_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(s3c64xx_always_on_pm_domains); i++)
 		pm_genpd_init(&s3c64xx_always_on_pm_domains[i]->pd,
-			      &pm_domain_always_on_gov, false);
+			      &pm_domain_always_on_gov, GENPD_STATE_ON);
 
 	for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++)
-		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false);
+		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, GENPD_STATE_ON);
 
 #ifdef CONFIG_S3C_DEV_FB
 	if (dev_get_platdata(&s3c_device_fb.dev))
diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 427b9ac4af6c..bf81f4354288 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -72,7 +72,7 @@ int __init ux500_pm_domains_init(void)
 	genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
 
 	for (i = 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
-		pm_genpd_init(ux500_pm_domains[i], NULL, false);
+		pm_genpd_init(ux500_pm_domains[i], NULL, GENPD_STATE_ON);
 
 	of_genpd_add_provider_onecell(np, genpd_data);
 	return 0;
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 32084e38b73d..33a3945c023e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2043,12 +2043,13 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
  * @gov: PM domain governor to associate with the domain (may be NULL).
- * @is_off: Initial value of the domain's power_is_off field.
+ * @boot_status: Initial (boot) state of the domain.
  *
  * Returns 0 on successful initialization, else a negative error code.
  */
 int pm_genpd_init(struct generic_pm_domain *genpd,
-		  struct dev_power_governor *gov, bool is_off)
+		  struct dev_power_governor *gov,
+		  enum gpd_status boot_status)
 {
 	int ret;
 
@@ -2063,7 +2064,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
-	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
+	genpd->status = boot_status;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
@@ -3112,7 +3113,8 @@ static int genpd_summary_one(struct seq_file *s,
 {
 	static const char * const status_lookup[] = {
 		[GENPD_STATE_ON] = "on",
-		[GENPD_STATE_OFF] = "off"
+		[GENPD_STATE_OFF] = "off",
+		[GENPD_STATE_UNKNOWN] = "unknown"
 	};
 	struct pm_domain_data *pm_data;
 	const char *kobj_path;
@@ -3194,7 +3196,8 @@ static int status_show(struct seq_file *s, void *data)
 {
 	static const char * const status_lookup[] = {
 		[GENPD_STATE_ON] = "on",
-		[GENPD_STATE_OFF] = "off"
+		[GENPD_STATE_OFF] = "off",
+		[GENPD_STATE_UNKNOWN] = "unknown"
 	};
 
 	struct generic_pm_domain *genpd = s->private;
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index cd85d9f158b0..c1deacf7eb94 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -283,7 +283,8 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
 	lpsc->pm_domain.flags = GENPD_FLAG_PM_CLK;
 
 	is_on = davinci_lpsc_clk_is_enabled(&lpsc->hw);
-	pm_genpd_init(&lpsc->pm_domain, NULL, is_on);
+	pm_genpd_init(&lpsc->pm_domain, NULL,
+		      is_on ? GENPD_STATE_OFF : GENPD_STATE_ON);
 
 	return lpsc;
 }
diff --git a/drivers/clk/mmp/pwr-island.c b/drivers/clk/mmp/pwr-island.c
index edaa2433a472..d3d88a4124cd 100644
--- a/drivers/clk/mmp/pwr-island.c
+++ b/drivers/clk/mmp/pwr-island.c
@@ -106,7 +106,7 @@ struct generic_pm_domain *mmp_pm_domain_register(const char *name,
 	pm_domain->flags = flags;
 	pm_domain->lock = lock;
 
-	pm_genpd_init(&pm_domain->genpd, NULL, true);
+	pm_genpd_init(&pm_domain->genpd, NULL, GENPD_STATE_OFF);
 	pm_domain->genpd.name = name;
 	pm_domain->genpd.power_on = mmp_pm_domain_power_on;
 	pm_domain->genpd.power_off = mmp_pm_domain_power_off;
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..1acf208cdc8e 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -452,7 +452,7 @@ static int gdsc_init(struct gdsc *sc)
 	if (!sc->pd.power_on)
 		sc->pd.power_on = gdsc_enable;
 
-	ret = pm_genpd_init(&sc->pd, NULL, !on);
+	ret = pm_genpd_init(&sc->pd, NULL, on ? GENPD_STATE_ON : GENPD_STATE_OFF);
 	if (ret)
 		goto err_disable_supply;
 
diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 90804ac06fa5..cb1a3f4f65fa 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -336,7 +336,7 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
 		    GENPD_FLAG_ACTIVE_WAKEUP;
 	pd->attach_dev = cpg_mstp_attach_dev;
 	pd->detach_dev = cpg_mstp_detach_dev;
-	pm_genpd_init(pd, &pm_domain_always_on_gov, false);
+	pm_genpd_init(pd, &pm_domain_always_on_gov, GENPD_STATE_ON);
 
 	of_genpd_add_provider_simple(np, pd);
 }
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 40828616f723..34a3bc4d2c2b 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -802,7 +802,7 @@ static int r9a06g032_add_clk_domain(struct device *dev)
 		    GENPD_FLAG_ACTIVE_WAKEUP;
 	pd->attach_dev = r9a06g032_attach_dev;
 	pd->detach_dev = r9a06g032_detach_dev;
-	pm_genpd_init(pd, &pm_domain_always_on_gov, false);
+	pm_genpd_init(pd, &pm_domain_always_on_gov, GENPD_STATE_ON);
 
 	of_genpd_add_provider_simple(np, pd);
 	return 0;
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index e9c0e341380e..14f39db296e1 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -588,7 +588,7 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 		       GENPD_FLAG_ACTIVE_WAKEUP;
 	genpd->attach_dev = cpg_mssr_attach_dev;
 	genpd->detach_dev = cpg_mssr_detach_dev;
-	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
+	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, GENPD_STATE_ON);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 93b02cdc98c2..10620998d79b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1322,7 +1322,7 @@ static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 		       GENPD_FLAG_ACTIVE_WAKEUP;
 	genpd->attach_dev = rzg2l_cpg_attach_dev;
 	genpd->detach_dev = rzg2l_cpg_detach_dev;
-	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
+	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, GENPD_STATE_ON);
 	if (ret)
 		return ret;
 
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index c2d6d9c3c930..5f600ab981c1 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -76,7 +76,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
 
-	ret = pm_genpd_init(pd, pd_gov, false);
+	ret = pm_genpd_init(pd, pd_gov, GENPD_STATE_ON);
 	if (ret)
 		goto free_pd_prov;
 
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index f2ccda2c3871..ef1301a739d1 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -441,7 +441,7 @@ static int sbi_pd_init(struct device_node *np)
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
 
-	ret = pm_genpd_init(pd, pd_gov, false);
+	ret = pm_genpd_init(pd, pd_gov, GENPD_STATE_ON);
 	if (ret)
 		goto free_pd_prov;
 
diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
index 0e05a79de82d..fde44900fa18 100644
--- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -104,7 +104,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
 
 		pm_genpd_init(&scmi_pd->genpd, NULL,
-			      state == SCMI_POWER_STATE_GENERIC_OFF);
+			      state == SCMI_POWER_STATE_GENERIC_OFF ? GENPD_STATE_OFF : GENPD_STATE_ON);
 
 		domains[i] = &scmi_pd->genpd;
 	}
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 84b673427073..45fa546bc0a0 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -337,7 +337,8 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 		return NULL;
 	}
 
-	ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
+	ret = pm_genpd_init(&sc_pd->pd, NULL,
+			    is_off ? GENPD_STATE_OFF : GENPD_STATE_ON);
 	if (ret) {
 		dev_warn(dev, "failed to init pd %s rsrc id %d",
 			 sc_pd->name, sc_pd->rsrc);
diff --git a/drivers/firmware/scpi_pm_domain.c b/drivers/firmware/scpi_pm_domain.c
index 800673910b51..7d05d11e8dc3 100644
--- a/drivers/firmware/scpi_pm_domain.c
+++ b/drivers/firmware/scpi_pm_domain.c
@@ -125,7 +125,7 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
 		 * The SCP firmware itself may have switched on some domains,
 		 * but for reference counting purpose, keep it this way.
 		 */
-		pm_genpd_init(&scpi_pd->genpd, NULL, true);
+		pm_genpd_init(&scpi_pd->genpd, NULL, GENPD_STATE_OFF);
 	}
 
 	scpi_pd_data->domains = domains;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 6d72355ac492..0f802e5dcd54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -261,7 +261,7 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_genpd->gpd.power_on = acp_poweron;
 	adev->acp.acp_genpd->adev = adev;
 
-	pm_genpd_init(&adev->acp.acp_genpd->gpd, NULL, false);
+	pm_genpd_init(&adev->acp.acp_genpd->gpd, NULL, GENPD_STATE_ON);
 	dmi_check_system(acp_quirk_table);
 	switch (acp_machine_id) {
 	case ST_JADEITE:
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index d30614661eea..1fbe52fdb315 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -398,7 +398,7 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	if (!genpd->name)
 		return -ENOMEM;
 
-	ret = pm_genpd_init(genpd, NULL, false);
+	ret = pm_genpd_init(genpd, NULL, GENPD_STATE_ON);
 	if (ret) {
 		dev_err(dev, "failed to init genpd: %d\n", ret);
 		return ret;
diff --git a/drivers/soc/actions/owl-sps.c b/drivers/soc/actions/owl-sps.c
index 73a9e0bb7e8e..86a483d0afcc 100644
--- a/drivers/soc/actions/owl-sps.c
+++ b/drivers/soc/actions/owl-sps.c
@@ -87,7 +87,7 @@ static int owl_sps_init_domain(struct owl_sps *sps, int index)
 	pd->genpd.power_on = owl_sps_power_on;
 	pd->genpd.power_off = owl_sps_power_off;
 	pd->genpd.flags = pd->info->genpd_flags;
-	pm_genpd_init(&pd->genpd, NULL, false);
+	pm_genpd_init(&pd->genpd, NULL, GENPD_STATE_ON);
 
 	sps->genpd_data.domains[index] = &pd->genpd;
 
diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index f54acffc83f9..9deaa5952015 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -468,13 +468,14 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 			return ret;
 
 		dom->base.flags = GENPD_FLAG_ALWAYS_ON;
-		ret = pm_genpd_init(&dom->base, NULL, false);
+		ret = pm_genpd_init(&dom->base, NULL, GENPD_STATE_ON);
 		if (ret)
 			return ret;
 	} else {
+		bool is_off = dom->desc.is_powered_off ?
+				     dom->desc.is_powered_off(dom) : true;
 		ret = pm_genpd_init(&dom->base, NULL,
-				    (dom->desc.is_powered_off ?
-				     dom->desc.is_powered_off(dom) : true));
+				    is_off ? GENPD_STATE_OFF : GENPD_STATE_ON);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
index 5d4f12800d93..291dbfdb938e 100644
--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -342,7 +342,8 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
 	}
 
 	vpu_pd->genpd.flags = GENPD_FLAG_ALWAYS_ON;
-	pm_genpd_init(&vpu_pd->genpd, NULL, powered_off);
+	pm_genpd_init(&vpu_pd->genpd, NULL,
+		      powered_off ? GENPD_STATE_OFF : GENPD_STATE_ON);
 
 	return of_genpd_add_provider_simple(pdev->dev.of_node,
 					    &vpu_pd->genpd);
diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index e93518763526..6ca46e23a6cd 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -178,6 +178,7 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
 
 	for (i = 0 ; i < match->count ; ++i) {
 		struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
+		bool is_off;
 
 		if (!match->domains[i].index)
 			continue;
@@ -189,7 +190,9 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
 		dom->base.power_on = meson_secure_pwrc_on;
 		dom->base.power_off = meson_secure_pwrc_off;
 
-		pm_genpd_init(&dom->base, NULL, match->domains[i].is_off(dom));
+		is_off = match->domains[i].is_off(dom);
+		pm_genpd_init(&dom->base, NULL,
+			      is_off ? GENPD_STATE_OFF : GENPD_STATE_ON);
 
 		pwrc->xlate.domains[i] = &dom->base;
 	}
diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
index d62a776c89a1..81170be4bfc2 100644
--- a/drivers/soc/apple/apple-pmgr-pwrstate.c
+++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
@@ -249,7 +249,7 @@ static int apple_pmgr_ps_probe(struct platform_device *pdev)
 		regmap_update_bits(regmap, ps->offset, APPLE_PMGR_FLAGS | APPLE_PMGR_AUTO_ENABLE,
 				   APPLE_PMGR_AUTO_ENABLE);
 
-	ret = pm_genpd_init(&ps->genpd, NULL, !active);
+	ret = pm_genpd_init(&ps->genpd, NULL, active ? GENPD_STATE_ON : GENPD_STATE_OFF);
 	if (ret < 0) {
 		dev_err(dev, "pm_genpd_init failed\n");
 		return ret;
diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 1a179d4e011c..90202b3f6dcc 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -527,7 +527,7 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
 	dom->power = power;
 
 	/* XXX: on/off at boot? */
-	pm_genpd_init(&dom->base, NULL, true);
+	pm_genpd_init(&dom->base, NULL, GENPD_STATE_OFF);
 
 	power->pd_xlate.domains[pd_xlate_index] = &dom->base;
 
diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index 9407cac47fdb..62a6d6330d8a 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -321,7 +321,7 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 		pd->genpd.power_on = bcm_pmb_power_on;
 		pd->genpd.power_off = bcm_pmb_power_off;
 
-		pm_genpd_init(&pd->genpd, NULL, true);
+		pm_genpd_init(&pd->genpd, NULL, GENPD_STATE_OFF);
 		pmb->genpd_onecell_data.domains[e->id] = &pd->genpd;
 	}
 
diff --git a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c b/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
index aa72e13d5d0e..dcb7b9336828 100644
--- a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
+++ b/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
@@ -153,7 +153,8 @@ static int bcm63xx_power_probe(struct platform_device *pdev)
 		pmd->genpd.power_on = bcm63xx_power_on;
 		pmd->genpd.power_off = bcm63xx_power_off;
 
-		pm_genpd_init(&pmd->genpd, NULL, !is_on);
+		pm_genpd_init(&pmd->genpd, NULL,
+			      is_on ? GENPD_STATE_ON : GENPD_STATE_OFF);
 		power->genpd[entry->bit] = &pmd->genpd;
 
 		ndom++;
diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspberrypi-power.c
index 58175af982a0..af218e798c88 100644
--- a/drivers/soc/bcm/raspberrypi-power.c
+++ b/drivers/soc/bcm/raspberrypi-power.c
@@ -96,7 +96,7 @@ static void rpi_common_init_power_domain(struct rpi_power_domains *rpi_domains,
 	 * that we give to the firmware, and we can't ask the firmware
 	 * to turn off something that we haven't ourselves turned on.
 	 */
-	pm_genpd_init(&dom->base, NULL, true);
+	pm_genpd_init(&dom->base, NULL, GENPD_STATE_OFF);
 
 	rpi_domains->xlate.domains[xlate_index] = &dom->base;
 }
diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index ffc5311c0ed8..6be2331bd65e 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -212,11 +212,13 @@ static void __pmu_domain_register(struct pmu_domain *domain,
 	struct device_node *np)
 {
 	unsigned int val = readl_relaxed(domain->pmu->pmu_base + PMU_PWR);
+	bool is_on = val & domain->pwr_mask;
 
 	domain->base.power_off = pmu_domain_power_off;
 	domain->base.power_on = pmu_domain_power_on;
 
-	pm_genpd_init(&domain->base, NULL, !(val & domain->pwr_mask));
+	pm_genpd_init(&domain->base, NULL,
+		      is_on ? GENPD_STATE_ON : GENPD_STATE_OFF);
 
 	if (np)
 		of_genpd_add_provider_simple(np, &domain->base);
diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 90a8b2c0676f..b452e23a2725 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -194,7 +194,7 @@ static int imx_pgc_power_domain_probe(struct platform_device *pdev)
 		domain->base.power_on(&domain->base);
 
 	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
-		pm_genpd_init(&domain->base, NULL, false);
+		pm_genpd_init(&domain->base, NULL, GENPD_STATE_ON);
 		ret = of_genpd_add_provider_simple(dev->of_node, &domain->base);
 		if (ret)
 			goto genpd_err;
@@ -382,7 +382,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 	}
 
 	for (i = 0; i < num_domains; i++)
-		pm_genpd_init(&imx_gpc_domains[i].base, NULL, false);
+		pm_genpd_init(&imx_gpc_domains[i].base, NULL, GENPD_STATE_ON);
 
 	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
 		ret = of_genpd_add_provider_onecell(dev->of_node,
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 4b3300b090a8..64c1b1b8ba90 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1343,7 +1343,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		regmap_update_bits(domain->regmap, domain->regs->map,
 				   domain->bits.map, domain->bits.map);
 
-	ret = pm_genpd_init(&domain->genpd, NULL, true);
+	ret = pm_genpd_init(&domain->genpd, NULL, GENPD_STATE_OFF);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
 		goto out_domain_unmap;
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index afbca0d48c14..bcf89895df66 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -270,7 +270,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
 		domain->bc = bc;
 
-		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		ret = pm_genpd_init(&domain->genpd, NULL, GENPD_STATE_OFF);
 		if (ret) {
 			dev_err_probe(dev, ret,
 				      "failed to init power domain \"%s\"\n",
diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 870aecc0202a..d7137e09a263 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -701,7 +701,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		domain->bc = bc;
 		domain->id = i;
 
-		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		ret = pm_genpd_init(&domain->genpd, NULL, GENPD_STATE_OFF);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to init power domain\n");
 			dev_pm_domain_detach(domain->power_dev, true);
diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/soc/imx/imx93-blk-ctrl.c
index 2c600329436c..ec61f2b9d6f5 100644
--- a/drivers/soc/imx/imx93-blk-ctrl.c
+++ b/drivers/soc/imx/imx93-blk-ctrl.c
@@ -263,7 +263,7 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		domain->genpd.power_off = imx93_blk_ctrl_power_off;
 		domain->bc = bc;
 
-		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		ret = pm_genpd_init(&domain->genpd, NULL, GENPD_STATE_OFF);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to init power domain\n");
 			goto cleanup_pds;
diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
index 832deeed8fd6..b748d8cd286a 100644
--- a/drivers/soc/imx/imx93-pd.c
+++ b/drivers/soc/imx/imx93-pd.c
@@ -133,7 +133,8 @@ static int imx93_pd_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
+	ret = pm_genpd_init(&domain->genpd, NULL,
+			    domain->init_off ? GENPD_STATE_OFF : GENPD_STATE_ON);
 	if (ret)
 		goto err_clk_unprepare;
 
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 354249cc1b12..b7f01a0b2e5d 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -462,9 +462,9 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
-		pm_genpd_init(&pd->genpd, NULL, true);
+		pm_genpd_init(&pd->genpd, NULL, GENPD_STATE_OFF);
 	else
-		pm_genpd_init(&pd->genpd, NULL, false);
+		pm_genpd_init(&pd->genpd, NULL, GENPD_STATE_ON);
 
 	scpsys->domains[id] = &pd->genpd;
 
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 7a668888111c..f6704fc274fb 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -534,7 +534,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 		 */
 		on = !WARN_ON(genpd->power_on(genpd) < 0);
 
-		pm_genpd_init(genpd, NULL, !on);
+		pm_genpd_init(genpd, NULL, on ? GENPD_STATE_ON : GENPD_STATE_OFF);
 	}
 
 	/*
diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index 144ea68e0920..17e35090bfbc 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -1702,7 +1702,7 @@ static int cpr_probe(struct platform_device *pdev)
 	drv->pd.opp_to_performance_state = cpr_get_performance_state;
 	drv->pd.attach_dev = cpr_pd_attach_dev;
 
-	ret = pm_genpd_init(&drv->pd, NULL, true);
+	ret = pm_genpd_init(&drv->pd, NULL, GENPD_STATE_OFF);
 	if (ret)
 		return ret;
 
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index f20e2a49a669..f729f3a47781 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -789,7 +789,7 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
 		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
 		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
-		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
+		pm_genpd_init(&rpmhpds[i]->pd, NULL, GENPD_STATE_OFF);
 
 		data->domains[i] = &rpmhpds[i]->pd;
 	}
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index f8397dcb146c..c6d9dd7db376 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -956,7 +956,7 @@ static int rpmpd_probe(struct platform_device *pdev)
 		rpmpds[i]->pd.power_on = rpmpd_power_on;
 		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
 		rpmpds[i]->pd.opp_to_performance_state = rpmpd_get_performance;
-		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
+		pm_genpd_init(&rpmpds[i]->pd, NULL, GENPD_STATE_OFF);
 
 		data->domains[i] = &rpmpds[i]->pd;
 	}
diff --git a/drivers/soc/renesas/rcar-gen4-sysc.c b/drivers/soc/renesas/rcar-gen4-sysc.c
index 9e5e6e077abc..4ecb1048db22 100644
--- a/drivers/soc/renesas/rcar-gen4-sysc.c
+++ b/drivers/soc/renesas/rcar-gen4-sysc.c
@@ -268,7 +268,7 @@ static int __init rcar_gen4_sysc_pd_setup(struct rcar_gen4_sysc_pd *pd)
 	rcar_gen4_sysc_power(pd->pdr, true);
 
 finalize:
-	error = pm_genpd_init(genpd, &simple_qos_governor, false);
+	error = pm_genpd_init(genpd, &simple_qos_governor, GENPD_STATE_ON);
 	if (error)
 		pr_err("Failed to init PM domain %s: %d\n", name, error);
 
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index eed47696e825..4b204b61d2ae 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -260,7 +260,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 	rcar_sysc_power(&pd->ch, true);
 
 finalize:
-	error = pm_genpd_init(genpd, &simple_qos_governor, false);
+	error = pm_genpd_init(genpd, &simple_qos_governor, GENPD_STATE_ON);
 	if (error)
 		pr_err("Failed to init PM domain %s: %d\n", name, error);
 
diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
index 728ebac98e14..bd27e5498b59 100644
--- a/drivers/soc/renesas/rmobile-sysc.c
+++ b/drivers/soc/renesas/rmobile-sysc.c
@@ -121,7 +121,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 		__rmobile_pd_power_up(rmobile_pd);
 	}
 
-	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
+	pm_genpd_init(genpd, gov ? : &simple_qos_governor, GENPD_STATE_ON);
 }
 
 static int rmobile_pd_suspend_console(void)
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 84bc022f9e5b..67adbfb29795 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -645,7 +645,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->genpd.flags = GENPD_FLAG_PM_CLK;
 	if (pd_info->active_wakeup)
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
-	pm_genpd_init(&pd->genpd, NULL, !rockchip_pmu_domain_is_on(pd));
+	pm_genpd_init(&pd->genpd, NULL,
+		      rockchip_pmu_domain_is_on(pd) ? GENPD_STATE_ON : GENPD_STATE_OFF);
 
 	pmu->genpd_data.domains[id] = &pd->genpd;
 	return 0;
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index d07f3c9d6903..35c36b84b16b 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -130,7 +130,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
 
 	on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
 
-	pm_genpd_init(&pd->pd, NULL, !on);
+	pm_genpd_init(&pd->pd, NULL, on ? GENPD_STATE_ON : GENPD_STATE_OFF);
 	ret = of_genpd_add_provider_simple(np, &pd->pd);
 
 	if (ret == 0 && of_parse_phandle_with_args(np, "power-domains",
diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
index 7d5f50d71c0d..5fd707f3cbef 100644
--- a/drivers/soc/starfive/jh71xx_pmu.c
+++ b/drivers/soc/starfive/jh71xx_pmu.c
@@ -251,7 +251,8 @@ static int jh71xx_pmu_init_domain(struct jh71xx_pmu *pmu, int index)
 
 	pmd->genpd.power_on = jh71xx_pmu_on;
 	pmd->genpd.power_off = jh71xx_pmu_off;
-	pm_genpd_init(&pmd->genpd, NULL, !is_on);
+	pm_genpd_init(&pmd->genpd, NULL,
+		      is_on ? GENPD_STATE_ON : GENPD_STATE_OFF);
 
 	pmu->genpd_data.domains[index] = &pmd->genpd;
 
diff --git a/drivers/soc/sunxi/sun20i-ppu.c b/drivers/soc/sunxi/sun20i-ppu.c
index 98cb41d36560..e78f23b222f5 100644
--- a/drivers/soc/sunxi/sun20i-ppu.c
+++ b/drivers/soc/sunxi/sun20i-ppu.c
@@ -148,13 +148,17 @@ static int sun20i_ppu_probe(struct platform_device *pdev)
 
 	for (unsigned int i = 0; i < ppu->num_domains; ++i) {
 		struct sun20i_ppu_pd *pd = &pds[i];
+		bool is_on;
 
 		pd->genpd.name		= desc->names[i];
 		pd->genpd.power_off	= sun20i_ppu_pd_power_off;
 		pd->genpd.power_on	= sun20i_ppu_pd_power_on;
 		pd->base		= base + PD_REGS_SIZE * i;
 
-		ret = pm_genpd_init(&pd->genpd, NULL, sun20i_ppu_pd_is_on(pd));
+		is_on = sun21i_ppu_pd_is_on(pd);
+
+		ret = pm_genpd_init(&pd->genpd, NULL,
+				    is_on ? GENPD_STATE_ON : GENPD_STATE_OFF);
 		if (ret) {
 			dev_warn(dev, "Failed to add '%s' domain: %d\n",
 				 pd->genpd.name, ret);
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5d17799524c9..159f612851e4 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1332,7 +1332,8 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 		goto remove_resets;
 	}
 
-	err = pm_genpd_init(&pg->genpd, NULL, off);
+	err = pm_genpd_init(&pg->genpd, NULL,
+			    off ? GENPD_STATE_OFF : GENPD_STATE_ON);
 	if (err < 0) {
 		dev_err(dev, "failed to initialise PM domain %pOFn: %d\n", np,
 		       err);
@@ -1431,7 +1432,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 		return dev_err_probe(pmc->dev, err,
 				     "failed to set core OPP regulator\n");
 
-	err = pm_genpd_init(genpd, NULL, false);
+	err = pm_genpd_init(genpd, NULL, GENPD_STATE_ON);
 	if (err) {
 		dev_err(pmc->dev, "failed to init core genpd: %d\n", err);
 		return err;
diff --git a/drivers/soc/tegra/powergate-bpmp.c b/drivers/soc/tegra/powergate-bpmp.c
index 179ed895c279..9cbb5ceabd20 100644
--- a/drivers/soc/tegra/powergate-bpmp.c
+++ b/drivers/soc/tegra/powergate-bpmp.c
@@ -185,7 +185,8 @@ tegra_powergate_add(struct tegra_bpmp *bpmp,
 	powergate->genpd.power_on = tegra_powergate_power_on;
 	powergate->genpd.power_off = tegra_powergate_power_off;
 
-	err = pm_genpd_init(&powergate->genpd, NULL, off);
+	err = pm_genpd_init(&powergate->genpd, NULL,
+			    off ? GENPD_STATE_OFF : GENPD_STATE_ON);
 	if (err < 0) {
 		kfree(powergate->genpd.name);
 		return ERR_PTR(err);
diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index ecd9a8bdd7c0..371076b85580 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -710,7 +710,7 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
 	prmd->pd.detach_dev = omap_prm_domain_detach_dev;
 	prmd->pd.flags = GENPD_FLAG_PM_CLK;
 
-	pm_genpd_init(&prmd->pd, NULL, true);
+	pm_genpd_init(&prmd->pd, NULL, GENPD_STATE_OFF);
 	error = of_genpd_add_provider_simple(np, &prmd->pd);
 	if (error)
 		pm_genpd_remove(&prmd->pd);
diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index a33ec7eaf23d..037ed4ea87b0 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -171,7 +171,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
 
-				pm_genpd_init(&pd->pd, NULL, true);
+				pm_genpd_init(&pd->pd, NULL, GENPD_STATE_OFF);
 
 				list_add(&pd->node, &pd_provider->pd_list);
 			}
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
index 69d03ad4cf1e..bcf33b9ec697 100644
--- a/drivers/soc/xilinx/zynqmp_pm_domains.c
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -283,7 +283,7 @@ static int zynqmp_gpd_probe(struct platform_device *pdev)
 		domains[i] = &pd->gpd;
 
 		/* Mark all PM domains as initially powered off */
-		pm_genpd_init(&pd->gpd, NULL, true);
+		pm_genpd_init(&pd->gpd, NULL, GENPD_STATE_OFF);
 	}
 
 	zynqmp_pd_data->domains = domains;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..c545e44ee52b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -73,6 +73,7 @@
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
 	GENPD_STATE_OFF,	/* PM domain is off */
+	GENPD_STATE_UNKNOWN,	/* PM domain boot state is unknown */
 };
 
 enum genpd_notication {
@@ -229,7 +230,8 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 			      struct generic_pm_domain *subdomain);
 int pm_genpd_init(struct generic_pm_domain *genpd,
-		  struct dev_power_governor *gov, bool is_off);
+		  struct dev_power_governor *gov,
+		  enum gpd_status boot_status);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
@@ -269,7 +271,8 @@ static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	return -ENOSYS;
 }
 static inline int pm_genpd_init(struct generic_pm_domain *genpd,
-				struct dev_power_governor *gov, bool is_off)
+				struct dev_power_governor *gov,
+				enum gpd_status boot_status)
 {
 	return -ENOSYS;
 }
-- 
2.34.1

