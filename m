Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4802C72FB35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjFNKhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbjFNKhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:37:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8819A7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:37:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-652328c18d5so4898642b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686739054; x=1689331054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYcdmfInIY4iLHsu2ifmhCLSrZeHago4AwSaJYKqWeU=;
        b=GmPyR06c8WP0576PRGOpYS8J4G8kICYSimUk0m0JJI7EUlZlfjoEIwW3E1ot0fXUoD
         LAjgEI03sw+vCF83/PXxLTOyMsN4HK2oEUm6BRyqGFIIsj65lKARGTW/pAyT6bC+udgL
         iyCC5IWAaS1L/PfyAxsbetS8XjRC4U2jxq3Ui33zSg2BQAN3fc0SnV4LIIrMXkhCC2a5
         Bc5YMgD1xXRSc4p8JrXujhmYNAHLJT4ZMAZSWCMo5Y9+i+UlKSW0uLL24OfwG+23zu/v
         a2BC5mKxeRVUrECK93DBlYyJ2OR1PLCA8WH5Fubfzzs5ECdn1xA7LSNh5kLuNs+XojeF
         i4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739054; x=1689331054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYcdmfInIY4iLHsu2ifmhCLSrZeHago4AwSaJYKqWeU=;
        b=Txu8VgJbZ2ex89RUUyIkwKmCAyBkE77z3hskI4CVWdPzvmzNsrG5iS9hvX4XMSnzTj
         FbMFXW3WCYbJ6W3er50czRUBq5Q1ixBZTIn1TJawSOnAHGj9jMneBp5JDUGhUBsEgCGH
         MTW8T4qR1jg7LFNlvq0nAvxPdF+GVw5EMsv6k0kWsmGqo+zdjaA9iqX+8Kwd2gtTXX9S
         5Qa3fho0weu3epMHcB3J7zpBCrzkiyVytBUf5fqzCDS7cxoVph3H62kT0nolCE7YzBST
         02JXogLMfC26CiUrT91GJXS8qdMDuyPY/c0xm5Onv7SrfH+i1g1EVEnUa52VG5rXNved
         u35w==
X-Gm-Message-State: AC+VfDw63i02s61VQANCWpZp86ntxonzAranYtTg4WlfMIk8b7cO5gbK
        s8LWUxU+tNyIN6lkiUGLV+kn7g==
X-Google-Smtp-Source: ACHHUZ589iilNr7Jek4O5EuZFXNy9wIqySycd47hoKvnzu2cB+DDblm4K/08MehqjtdZv4i9oNxdIg==
X-Received: by 2002:a05:6a20:12c8:b0:10c:9773:5e6 with SMTP id v8-20020a056a2012c800b0010c977305e6mr1025269pzg.47.1686739054531;
        Wed, 14 Jun 2023 03:37:34 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902a5c400b001ab0159b9edsm11827247plq.250.2023.06.14.03.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:37:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] OPP: Simplify the over-designed pstate <-> level dance
Date:   Wed, 14 Jun 2023 16:07:26 +0530
Message-Id: <af0fd0fd64f33809875335a9cc2761085c3bd66f.1686739018.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
References: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
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

While adding support for "performance states" in the OPP and genpd core,
it was decided to set the `pstate` field via genpd's
pm_genpd_opp_to_performance_state() helper, to allow platforms to set
`pstate` even if they don't have a corresponding `level` field in the DT
OPP tables (More details are present in commit 6e41766a6a50 ("PM /
Domain: Implement of_genpd_opp_to_performance_state()")).

Revisiting that five years later clearly suggests that it was
over-designed as all current users are eventually using the `level`
value only.

The previous commit already added necessary checks to make sure pstate
is only used for genpd tables. Lets now simplify this a little, and use
`level` directly and remove `pstate` field altogether.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c    | 8 ++++----
 drivers/opp/debugfs.c | 2 +-
 drivers/opp/of.c      | 5 +----
 drivers/opp/opp.h     | 2 --
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bfb012f5383c..48ddd72d2c71 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -245,7 +245,7 @@ unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
 		return 0;
 	}
 
-	return opp->required_opps[index]->pstate;
+	return opp->required_opps[index]->level;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_required_pstate);
 
@@ -943,7 +943,7 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 static int _set_performance_state(struct device *dev, struct device *pd_dev,
 				  struct dev_pm_opp *opp, int i)
 {
-	unsigned int pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
+	unsigned int pstate = likely(opp) ? opp->required_opps[i]->level: 0;
 	int ret;
 
 	if (!pd_dev)
@@ -2728,8 +2728,8 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 	mutex_lock(&src_table->lock);
 
 	list_for_each_entry(opp, &src_table->opp_list, node) {
-		if (opp->pstate == pstate) {
-			dest_pstate = opp->required_opps[i]->pstate;
+		if (opp->level == pstate) {
+			dest_pstate = opp->required_opps[i]->level;
 			goto unlock;
 		}
 	}
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 0cc21e2b42ff..954ea31a2ff3 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -157,7 +157,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 			     &opp->clock_latency_ns);
 
 	if (opp_table->is_genpd)
-		debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
+		debugfs_create_u32("performance_state", S_IRUGO, d, &opp->level);
 
 	opp->of_name = of_node_full_name(opp->np);
 	debugfs_create_str("of_name", S_IRUGO, d, (char **)&opp->of_name);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e23ce6e78eb6..e6d1155d0990 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -945,9 +945,6 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (ret)
 		goto free_required_opps;
 
-	if (opp_table->is_genpd)
-		new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
-
 	ret = _opp_add(dev, new_opp, opp_table);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
@@ -1400,7 +1397,7 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 
 	opp = _find_opp_of_np(opp_table, required_np);
 	if (opp) {
-		pstate = opp->pstate;
+		pstate = opp->level;
 		dev_pm_opp_put(opp);
 	}
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 3805b92a6100..8a5ea38f3a3d 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -78,7 +78,6 @@ struct opp_config_data {
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
  * @removed:	flag indicating that OPP's reference is dropped by OPP core.
- * @pstate: Device's power domain's performance state.
  * @rates:	Frequencies in hertz
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
@@ -101,7 +100,6 @@ struct dev_pm_opp {
 	bool turbo;
 	bool suspend;
 	bool removed;
-	unsigned int pstate;
 	unsigned long *rates;
 	unsigned int level;
 
-- 
2.31.1.272.g89b43f80a514

