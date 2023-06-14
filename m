Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001AC72FB34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjFNKhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjFNKhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:37:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E18B196
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:37:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4580615a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686739051; x=1689331051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0UJGMihjTj1hAjbmHZ6/JGiIPUmZ9LnZE7xgM/0VXOU=;
        b=mvOOi2pysANY+XAjid4/FlGD4AKXH5Ah/zFubhD1VbJI2jUrrbWcZ59q2tD8Ppibpo
         nPDCLEVGB+HMycGAfGsvRTPP6+Nxf2NinPMiL56X1sdqy6LXvtC03+nrltA6gRfMkYdP
         L/6ZiL0Rdb+Qdtd5cJm2Qc0VEFuXu2n8RkZctsQOIJX8VrK2m4DCoxBksfKZxeJfbeqH
         ViFmR2iPUUFufXbDpmw2raqGvoDKEu226XMRtVIe2yP7QLlqlxyKs25fVGHvLUMNpuVa
         m9rfT0/l3EVH6a9InjY0rBimeUJJRXTkFnRf2KwN3DlcAwnsyV5OmKYBjjgICm30Mnxv
         D81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739051; x=1689331051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UJGMihjTj1hAjbmHZ6/JGiIPUmZ9LnZE7xgM/0VXOU=;
        b=fnKHndaI6gTtvs4qmw7sRe2wnDoy9jfhgG5gWJJ9YAepIBHKB3cvukjeOz4lNAI4EG
         JyAHNGOIT/OtUxmCaQvuaAq6a8v5P6OZJjrKBFqbgHt6u4YxkBDkhZyRnIQAstZ55Vqc
         +08/peAYBQ4wqVABzJ8MYq4uQoK9WzEYMKlWUp9LvSsM8GP4ffnoTm/S6O9Brc/qYt80
         4oDmm8ucaKkaJEoafN/xhi1R6QXP1DVsRL6RaOC+zTOFCdfR3IB564n4G7Vhh/Yt0fUa
         cMs0pvd78xkD3KVaNeCJZx6oCcVgBrT8D+Ph+cCFUnT5zq5Ls8gc8MfLOmR112iKXI8P
         +BHA==
X-Gm-Message-State: AC+VfDxXrp7/FBBECRZB704HF36RtV8Wkqm8jpO7s1RTFKaEJ+x+yzuB
        VB3JV9kjiMKt4TE1e9KkrdBn2Q==
X-Google-Smtp-Source: ACHHUZ7G6M362gZBo1XpHgAsxT45uBPwO0hp3bfI6761xauQ3K+uJ6CQ/i4/fw5QNPGONrZ2VKS58w==
X-Received: by 2002:a17:902:6ac7:b0:1af:d724:63ed with SMTP id i7-20020a1709026ac700b001afd72463edmr11808868plt.42.1686739051243;
        Wed, 14 Jun 2023 03:37:31 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001b1c3542f57sm11854863plb.103.2023.06.14.03.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:37:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] OPP: pstate is only valid for genpd OPP tables
Date:   Wed, 14 Jun 2023 16:07:25 +0530
Message-Id: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
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

It is not very clear right now that the `pstate` field is only valid for
genpd OPP tables and not consumer tables. And there is no checking for
the same at various places.

Add checks in place to verify that and make it clear to the reader.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c    | 18 ++++++++++++++++--
 drivers/opp/debugfs.c |  4 +++-
 drivers/opp/of.c      |  6 ++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7290168ec806..bfb012f5383c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -227,16 +227,24 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
 unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
 					    unsigned int index)
 {
+	struct opp_table *opp_table = opp->opp_table;
+
 	if (IS_ERR_OR_NULL(opp) || !opp->available ||
-	    index >= opp->opp_table->required_opp_count) {
+	    index >= opp_table->required_opp_count) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return 0;
 	}
 
 	/* required-opps not fully initialized yet */
-	if (lazy_linking_pending(opp->opp_table))
+	if (lazy_linking_pending(opp_table))
 		return 0;
 
+	/* The required OPP table must belong to a genpd */
+	if (unlikely(!opp_table->required_opp_tables[index]->is_genpd)) {
+		pr_err("%s: Performance state is only valid for genpds.\n", __func__);
+		return 0;
+	}
+
 	return opp->required_opps[index]->pstate;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_required_pstate);
@@ -2686,6 +2694,12 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 	int dest_pstate = -EINVAL;
 	int i;
 
+	/* Both OPP tables must belong to genpds */
+	if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {
+		pr_err("%s: Performance state is only valid for genpds.\n", __func__);
+		return -EINVAL;
+	}
+
 	/*
 	 * Normally the src_table will have the "required_opps" property set to
 	 * point to one of the OPPs in the dst_table, but in some cases the
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 2c7fb683441e..0cc21e2b42ff 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -152,11 +152,13 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic);
 	debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo);
 	debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
-	debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
 	debugfs_create_u32("level", S_IRUGO, d, &opp->level);
 	debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
 			     &opp->clock_latency_ns);
 
+	if (opp_table->is_genpd)
+		debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
+
 	opp->of_name = of_node_full_name(opp->np);
 	debugfs_create_str("of_name", S_IRUGO, d, (char **)&opp->of_name);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 943c7fb7402b..e23ce6e78eb6 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1392,6 +1392,12 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 		goto put_required_np;
 	}
 
+	/* The OPP tables must belong to a genpd */
+	if (unlikely(!opp_table->is_genpd)) {
+		pr_err("%s: Performance state is only valid for genpds.\n", __func__);
+		goto put_required_np;
+	}
+
 	opp = _find_opp_of_np(opp_table, required_np);
 	if (opp) {
 		pstate = opp->pstate;
-- 
2.31.1.272.g89b43f80a514

