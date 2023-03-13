Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844196B80BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCMScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjCMScC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3DB84F64;
        Mon, 13 Mar 2023 11:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9C33B811DA;
        Mon, 13 Mar 2023 18:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530E2C433D2;
        Mon, 13 Mar 2023 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732196;
        bh=Gw4rh6R98Knq0Cq2eoi4WmQjdtPb9YzLDaUDTvYSyIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXQiJ/sOvMKEbSllYfbGFpuz/RgUg5CL/sD49Lh4spZhIDmKdLEASRxJu6F9OEWo0
         RgzpjuRpFz58tWFPvKUPt4XvmamKX1LQkc1r8RsUMfD5lBfDacU34gNkrwlaT2YVp6
         aHyiZWw6EZxnraqJjj3f8guM0QKdDU5EReUhzjm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 03/36] cpufreq: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:45 +0100
Message-Id: <20230313182918.1312597-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=gregkh@linuxfoundation.org; h=from:subject; bh=Gw4rh6R98Knq0Cq2eoi4WmQjdtPb9YzLDaUDTvYSyIs=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82aUPCutMtKUNNhs9LOG6X3qh53xLZZPN5WkBnW9v2 0jrfvjZEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABNpqWeYH8otv4JPk5/ZeF3G 1QuTZM/qX97jxLBg1nPrCtdFvUvuvBAtKcluuPdCf8oEAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/cpufreq/cpufreq.c      | 7 ++++++-
 drivers/cpufreq/intel_pstate.c | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6d8fd3b8dcb5..6ad3119b8e15 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2932,11 +2932,16 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
 static int __init cpufreq_core_init(void)
 {
 	struct cpufreq_governor *gov = cpufreq_default_governor();
+	struct device *dev_root;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		cpufreq_global_kobject = kobject_create_and_add("cpufreq", &dev_root->kobj);
+		put_device(dev_root);
+	}
 	BUG_ON(!cpufreq_global_kobject);
 
 	if (!strlen(default_governor))
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 48a4613cef1e..102cf7f0ac63 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1473,10 +1473,13 @@ static struct kobject *intel_pstate_kobject;
 
 static void __init intel_pstate_sysfs_expose_params(void)
 {
+	struct device *dev_root = bus_get_dev_root(&cpu_subsys);
 	int rc;
 
-	intel_pstate_kobject = kobject_create_and_add("intel_pstate",
-						&cpu_subsys.dev_root->kobj);
+	if (dev_root) {
+		intel_pstate_kobject = kobject_create_and_add("intel_pstate", &dev_root->kobj);
+		put_device(dev_root);
+	}
 	if (WARN_ON(!intel_pstate_kobject))
 		return;
 
-- 
2.39.2

