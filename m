Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B08725FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbjFGMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjFGMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D71BD4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f624daccd1so4703421e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142025; x=1688734025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlN3puumXl98HZqEEgwOfFzKMHFxb3yG/jJp+Fhyp4M=;
        b=tihrD1ZPx4XtIuP6jos1gyNcy2O0ErgPJVg/oRr6QlGzYhr1sZvo3Krr8HWxufoB/E
         bu7nG1I0VZvuCE+eR24HJzgCQ8hJZtgDAbKYUi22oGBxxCgAfu6MDHgvC0IzcNc113JD
         qj8We12FvXAT/7HGoEJDnySZYh6Iz9IwnULfOtkaSQGXdeQhBa23Tu9M87g9yqB+rENU
         i9uQ2pmFqnHO5Fzpc+Z+X4EEUCtNPGxLfM62w4dYrPIPFsCw4vEmxdUmT8lKMuNwzj/9
         aDEBU6zFJdzpRQIgzsAbgtK0Joj4Y1jqc/sUuOGi71H+F9XJuu9mBIVz24Cu0iO7xVkZ
         FxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142025; x=1688734025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlN3puumXl98HZqEEgwOfFzKMHFxb3yG/jJp+Fhyp4M=;
        b=HlWwHHxO6EvILnoOx7lYi5o8vsh/ZNK+wN29OFbBgVuhNwZB+DqILOkt9N2zsaQPkD
         SapyIvM7zzgJtgRs7RDUH24+a3vS5f3NCBFFkRHTnsdtq3PuZvGPMgtVkVDF5XI9ZwTc
         gSy0D2UrpDEDlpNI//rV2hf0fpUl7T2OIv4BTRsuG/Bdy9ylUW0hfRAqHyhr62pVMw74
         JUBqLiZC8QPNfMVSANgnQStGNmaBY5UmN0ku9c04lrfe6W1NCByi6Wv/L0Q6Yvir0ukw
         eaPFjCXx/2Nv1j9/xmKfDOcLpJ2nrIFnWfV8fFEWrlC8ZhyxLk1P7a7uoLqb3+XTaKSk
         rpmQ==
X-Gm-Message-State: AC+VfDwkPWTJzM/sTp+kDy0WF0MidSQ9/gLmat25CPBpiGpa981dQha1
        F5wdqF3FWKgW4LHENJAaAEymzQ==
X-Google-Smtp-Source: ACHHUZ6v8QXNHYkt2lFcE9klDUW8Xlnt5LZgbqYnNRFBjulymMuINKZ/K7uEZW1MgCAieIjxBaO4NA==
X-Received: by 2002:a19:7402:0:b0:4f6:3677:552 with SMTP id v2-20020a197402000000b004f636770552mr1747794lfe.38.1686142025090;
        Wed, 07 Jun 2023 05:47:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] PM: domains: Allow genpd providers to manage OPP tables directly by its FW
Date:   Wed,  7 Jun 2023 14:46:20 +0200
Message-Id: <20230607124628.157465-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
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

In some cases the OPP tables aren't specified in device tree, but rather
encoded in the FW. To allow a genpd provider to specify them dynamically
instead, let's add a new genpd flag, GENPD_FLAG_OPP_TABLE_FW.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 11 ++++++-----
 include/linux/pm_domain.h   |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 32084e38b73d..cb35c040216a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
+#define genpd_is_opp_table_fw(genpd)	(genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2328,7 +2329,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	genpd->dev.of_node = np;
 
 	/* Parse genpd OPP table */
-	if (genpd->set_performance_state) {
+	if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 		ret = dev_pm_opp_of_add_table(&genpd->dev);
 		if (ret)
 			return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
@@ -2343,7 +2344,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
 	if (ret) {
-		if (genpd->set_performance_state) {
+		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
 		}
@@ -2387,7 +2388,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		genpd->dev.of_node = np;
 
 		/* Parse genpd OPP table */
-		if (genpd->set_performance_state) {
+		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
 			if (ret) {
 				dev_err_probe(&genpd->dev, ret,
@@ -2423,7 +2424,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		genpd->provider = NULL;
 		genpd->has_provider = false;
 
-		if (genpd->set_performance_state) {
+		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
 		}
@@ -2455,7 +2456,7 @@ void of_genpd_del_provider(struct device_node *np)
 				if (gpd->provider == &np->fwnode) {
 					gpd->has_provider = false;
 
-					if (!gpd->set_performance_state)
+					if (genpd_is_opp_table_fw(gpd) || !gpd->set_performance_state)
 						continue;
 
 					dev_pm_opp_put_opp_table(gpd->opp_table);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..05ad8cefdff1 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -61,6 +61,10 @@
  * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
  *				components' next wakeup when determining the
  *				optimal idle state.
+ *
+ * GENPD_FLAG_OPP_TABLE_FW:	The genpd provider supports performance states,
+ *				but its corresponding OPP tables are not
+ *				described in DT, but are given directly by FW.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -69,6 +73,7 @@
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
+#define GENPD_FLAG_OPP_TABLE_FW	 (1U << 7)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.34.1

