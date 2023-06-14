Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02FE72F71A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbjFNH6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbjFNH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:58:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615631BD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:57:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25bf9a449f2so1574199a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686729477; x=1689321477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2GQtatCI8xf5RRMmGGuODYCr1q8L++ao1oPCAWkom8=;
        b=GafY5PAZ7waaF2DoKxvJW/zVVats5SSqhBPxY1Lb+bJWQKMUxDAMY/jFBUmmgjB0O9
         u2l6ooQro92Fdqi2d8ZImec+gytWasvCwA8NQG5febdyJ3TK3EoC2VJZlOAd55jU89Cf
         U9qQBXZi7Xgqc3Olky3NtaokX9cPobmICP/XV2Re97Dh+XVCPkUy9znVcXiY1jFXXVSh
         ho/+o7T3llnpEKZBqpyXLg+925pp43Vu+4oQLduw4k6EjfqxVnASAx7a1FheTwb9NYdN
         uULWGQASlOYPj3bX2+KCKmbAt/fyESVS2s8iGsnixZFRQIacvVSnbLisxBdQbcQp3IOE
         QPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686729477; x=1689321477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2GQtatCI8xf5RRMmGGuODYCr1q8L++ao1oPCAWkom8=;
        b=CXp7idmZRF8diX+AAskaBRZjvYmZ+C1sfHAYU1pqpQ2yYC+vkyrCEPhyXAamkofO/b
         lr/hXiXD5erx7p4gxrKCu5WWPHUbwgldhJYwyW4XQC8OBXleP/eCYSqhqH+8vMMQNVyo
         MbV6cimXPGxkE4qNhw5b32fzXeqaHjwwus18Y3p6KrhNRFlUY8ItCauWtcLRk0KhLLSg
         uWdx2Nc8vCORlE62R8N1cn53ss1JCJwx+Vt5NzLK9FhbXm4cp7WX8nrsLeaJlfBfBKb7
         XyMq3PceZvf0vidvAZ5e2nRfRKJM3Y1sT4AzjoojAvmW8YWMky3mOTky4Z5Q95bN6CQc
         lfFQ==
X-Gm-Message-State: AC+VfDzee55rthv6oKLXigQj4k/IXRxmoeNb4yEQChlCz/GWc3nQOK+l
        lsyORwoGLpNWRPuM9fU8ZHSZcSfryo55gc+J2AQ=
X-Google-Smtp-Source: ACHHUZ7v/56Yyf9wHMv8Mz+cmIrQlbrCV1srMF8e9LKe27otcLulX5TUGF4AKzep2vt6khHIHITiBQ==
X-Received: by 2002:a17:90a:77cb:b0:258:99d1:6b84 with SMTP id e11-20020a17090a77cb00b0025899d16b84mr843119pjs.41.1686729477445;
        Wed, 14 Jun 2023 00:57:57 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001acae9734c0sm11505502plg.266.2023.06.14.00.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 00:57:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: don't drop performance constraint on OPP table removal
Date:   Wed, 14 Jun 2023 13:27:53 +0530
Message-Id: <8f4574ab6c334dfe1d76c567062e43d751af2457.1686729428.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was added (long back) by commit 009acd196fc8 ("PM / OPP:
Support updating performance state of device's power domain") and at
that time the `opp->pstate` field was used to store the performance
state required by a device's OPP.

Over time that changed and the `->pstate` field is now used only for
genpd devices and consumer devices access that via the required-opps
instead.

Because of all these changes, _opp_table_kref_release() now drops the
constraint only when the genpd's OPP table gets freed and not the
device's. Which is definitely not what we wanted. And dropping the
constraint doesn't have much meaning as the genpd itself is going away.

Moreover, if we want to drop constraints here, then just dropping the
performance constraint alone isn't sufficient as there are other
resource constraints like clk, regulator, etc. too, which must be
handled.

Probably the right thing to do here is to leave this decision to the
consumers, which can call `dev_pm_opp_set_rate(dev, 0)` or similar APIs
to drop all constraints properly. Which many of the consumers already
do.

Remove the special code, which is broken anyway.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 10 +---------
 drivers/opp/of.c   |  8 --------
 drivers/opp/opp.h  |  2 --
 3 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9f918077cd62..7290168ec806 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1522,16 +1522,8 @@ static void _opp_table_kref_release(struct kref *kref)
 
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node) {
-		/*
-		 * The OPP table is getting removed, drop the performance state
-		 * constraints.
-		 */
-		if (opp_table->genpd_performance_state)
-			dev_pm_genpd_set_performance_state((struct device *)(opp_dev->dev), 0);
-
+	list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node)
 		_remove_opp_dev(opp_dev, opp_table);
-	}
 
 	mutex_destroy(&opp_table->genpd_virt_dev_lock);
 	mutex_destroy(&opp_table->lock);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ac2179d5da4c..943c7fb7402b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1034,14 +1034,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 		goto remove_static_opp;
 	}
 
-	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		/* Any non-zero performance state would enable the feature */
-		if (opp->pstate) {
-			opp_table->genpd_performance_state = true;
-			break;
-		}
-	}
-
 	lazy_link_required_opp_table(opp_table);
 
 	return 0;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index eb71385d96c1..3805b92a6100 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -182,7 +182,6 @@ enum opp_table_access {
  * @paths: Interconnect path handles
  * @path_count: Number of interconnect paths
  * @enabled: Set to true if the device's resources are enabled/configured.
- * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_required_opps: Helper responsible to set required OPPs.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -233,7 +232,6 @@ struct opp_table {
 	struct icc_path **paths;
 	unsigned int path_count;
 	bool enabled;
-	bool genpd_performance_state;
 	bool is_genpd;
 	int (*set_required_opps)(struct device *dev,
 		struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down);
-- 
2.31.1.272.g89b43f80a514

