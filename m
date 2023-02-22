Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C969F326
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjBVLHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBVLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:07:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7988838E8E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:06:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y2so4158399pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTFmQMiqtUc7pwcWMY+qhhF7WdtAyTRbIisqm76H6qE=;
        b=r4ALaOW2f7Akg1Mdcn3iw8u74rUnAqIkuefrRsyXjT1f3JQ1f8o9Cf+sRlMGMndhue
         yt94gDP2i6As0UHAEILftMnAljUNFXdm7bhl4O0LRdzjOyw3EN3aT2hhhGJi6k0PTpYM
         onDUTZzr/QJufxfzro5YS4CdKgNn/rou3baC6xS4Vkpj5NOU8VOjfLU8QS+jvsmAhD+V
         o3WCZSipVs0jl+kVlVvq955378NoTUxuE/ycQvW0JxYpCYbn+xUFZDJvqZVKRmYF5QgD
         9TK8vuwABItOoVsnMuxaSzHx5HPUrLxSALbFAXdeVOl8usZ06aMaSJHtbZ2YMX+9bXO8
         Z8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTFmQMiqtUc7pwcWMY+qhhF7WdtAyTRbIisqm76H6qE=;
        b=piHLIlyQvBvMKTiYIqxLatpNssZbWUIRZCMFopo+99vwJZLDTkOI1/0t7uFDH1YgxN
         rExiQzNEU0Xv7hEPACUpSJ7MsawSGJotU4bUXXtky2FWVniu45Ultd02Oeqd9+qzuhys
         mllif27rYLNLYfnn6ODqxiMXfRO5sKqSBT+DlLJ880kogFxQCyOF95EwKj/EPa4IHF2F
         5KDQKznCoAtPCXeXrxr3xGbaaveZXbK/ppv4YAv24h531PyIcBHZx4Jy6/zF8y0/QIim
         NnsNCXHf4VisYbH2UUk/GxunzoddUNS9T2R8AFvUzzjeRpVH+HHXIkFYUBLwAFKTAp1N
         zMFw==
X-Gm-Message-State: AO0yUKWpz7MoKCMkwyaqJrJO+BW4kkxYdsF23Aky/Q0pV5KvDzgpXSTn
        xUlY8qx+NszQndQNIfq6GayhMQ==
X-Google-Smtp-Source: AK7set8vGQfRcj16iAJunqMzpMJfxjoKAEB8ouCAx9vXeuU/NmWFp1+Rm93QxCZvsdR4kMTrGS+fJw==
X-Received: by 2002:a17:902:f908:b0:19a:a2e7:64cf with SMTP id kw8-20020a170902f90800b0019aa2e764cfmr6332392plb.69.1677064018883;
        Wed, 22 Feb 2023 03:06:58 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902d64700b0019926c7757asm4956737plh.289.2023.02.22.03.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:06:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] OPP: Move required opps configuration to specialized callback
Date:   Wed, 22 Feb 2023 16:36:38 +0530
Message-Id: <56b9926836652e9dbf56ca6b7628e836cddca351.1677063656.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1677063656.git.viresh.kumar@linaro.org>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
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

The required-opps configuration is closely tied to genpd and performance
states at the moment and it is not very obvious that required-opps can
live without genpds. Though we don't support configuring required-opps
for non-genpd cases currently.

This commit aims at separating these parts, where configuring genpds
would be a special case of configuring the required-opps.

Add a specialized callback, set_required_opps(), to the opp table and
set it to different callbacks accordingly.

This shouldn't result in any functional changes for now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 69 ++++++++++++++++++++++++++++------------------
 drivers/opp/of.c   |  3 ++
 drivers/opp/opp.h  |  4 +++
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6d7016ce8c53..954c94865cf5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -935,8 +935,8 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_required_opp(struct device *dev, struct device *pd_dev,
-			     struct dev_pm_opp *opp, int i)
+static int _set_performance_state(struct device *dev, struct device *pd_dev,
+				  struct dev_pm_opp *opp, int i)
 {
 	unsigned int pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
 	int ret;
@@ -953,33 +953,20 @@ static int _set_required_opp(struct device *dev, struct device *pd_dev,
 	return ret;
 }
 
-/* This is only called for PM domain for now */
-static int _set_required_opps(struct device *dev,
-			      struct opp_table *opp_table,
-			      struct dev_pm_opp *opp, bool up)
+static int _opp_set_required_opps_generic(struct device *dev,
+	struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
+{
+	dev_err(dev, "setting required-opps isn't supported for non-genpd devices\n");
+	return -ENOENT;
+}
+
+static int _opp_set_required_opps_genpd(struct device *dev,
+	struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
 {
-	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
 	struct device **genpd_virt_devs =
 		opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
 	int i, ret = 0;
 
-	if (!required_opp_tables)
-		return 0;
-
-	/* required-opps not fully initialized yet */
-	if (lazy_linking_pending(opp_table))
-		return -EBUSY;
-
-	/*
-	 * We only support genpd's OPPs in the "required-opps" for now, as we
-	 * don't know much about other use cases. Error out if the required OPP
-	 * doesn't belong to a genpd.
-	 */
-	if (unlikely(!required_opp_tables[0]->is_genpd)) {
-		dev_err(dev, "required-opps don't belong to a genpd\n");
-		return -ENOENT;
-	}
-
 	/*
 	 * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
 	 * after it is freed from another thread.
@@ -987,15 +974,15 @@ static int _set_required_opps(struct device *dev,
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
 	/* Scaling up? Set required OPPs in normal order, else reverse */
-	if (up) {
+	if (!scaling_down) {
 		for (i = 0; i < opp_table->required_opp_count; i++) {
-			ret = _set_required_opp(dev, genpd_virt_devs[i], opp, i);
+			ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
 			if (ret)
 				break;
 		}
 	} else {
 		for (i = opp_table->required_opp_count - 1; i >= 0; i--) {
-			ret = _set_required_opp(dev, genpd_virt_devs[i], opp, i);
+			ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
 			if (ret)
 				break;
 		}
@@ -1006,6 +993,34 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
+/* This is only called for PM domain for now */
+static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
+			      struct dev_pm_opp *opp, bool up)
+{
+	/* required-opps not fully initialized yet */
+	if (lazy_linking_pending(opp_table))
+		return -EBUSY;
+
+	if (opp_table->set_required_opps)
+		return opp_table->set_required_opps(dev, opp_table, opp, up);
+
+	return 0;
+}
+
+/* Update set_required_opps handler */
+void _update_set_required_opps(struct opp_table *opp_table)
+{
+	/* Already set */
+	if (opp_table->set_required_opps)
+		return;
+
+	/* All required OPPs will belong to genpd or none */
+	if (opp_table->required_opp_tables[0]->is_genpd)
+		opp_table->set_required_opps = _opp_set_required_opps_genpd;
+	else
+		opp_table->set_required_opps = _opp_set_required_opps_generic;
+}
+
 static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e55c6095adf0..93da3c797afc 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -196,6 +196,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	/* Let's do the linking later on */
 	if (lazy)
 		list_add(&opp_table->lazy, &lazy_opp_tables);
+	else
+		_update_set_required_opps(opp_table);
 
 	goto put_np;
 
@@ -411,6 +413,7 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 
 		/* All required opp-tables found, remove from lazy list */
 		if (!lazy) {
+			_update_set_required_opps(opp_table);
 			list_del_init(&opp_table->lazy);
 
 			list_for_each_entry(opp, &opp_table->opp_list, node)
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 3a6e077df386..2a057c42ddf4 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -184,6 +184,7 @@ enum opp_table_access {
  * @enabled: Set to true if the device's resources are enabled/configured.
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
+ * @set_required_opps: Helper responsible to set required OPPs.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -234,6 +235,8 @@ struct opp_table {
 	bool enabled;
 	bool genpd_performance_state;
 	bool is_genpd;
+	int (*set_required_opps)(struct device *dev,
+		struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down);
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
@@ -257,6 +260,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cp
 struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
 void _put_opp_list_kref(struct opp_table *opp_table);
 void _required_opps_available(struct dev_pm_opp *opp, int count);
+void _update_set_required_opps(struct opp_table *opp_table);
 
 static inline bool lazy_linking_pending(struct opp_table *opp_table)
 {
-- 
2.31.1.272.g89b43f80a514

