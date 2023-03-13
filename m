Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04866B809B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCMSa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjCMSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003C683156;
        Mon, 13 Mar 2023 11:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A62DB61468;
        Mon, 13 Mar 2023 18:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC821C433D2;
        Mon, 13 Mar 2023 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732194;
        bh=t8dfYO0KLvBwnDTabEC6Q8qADtWU+S9Nx/DV5qsE0XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGioplhrdEI2WqXg6RyaSAemRoVq2lTQmz+O74akI8S9P9KQkkWd6rr7lyXz9TOWu
         93VPXul7gBSXKunekt9nTj5YFJm9jkFMULQsNkcyklppo3VhpDzmKOlM4ECFCWBc/0
         EJdkJ0YcrmkEerZiECNBOO1bcKrZigw0DW5ReISg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 20/36] cpufreq: amd-pstate: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:29:02 +0100
Message-Id: <20230313182918.1312597-20-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3145; i=gregkh@linuxfoundation.org; h=from:subject; bh=t8dfYO0KLvBwnDTabEC6Q8qADtWU+S9Nx/DV5qsE0XE=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82ZXXBZRtTAvFnk1yaP1WWbM0JFjTKdUxcNbZcksJO Qub2vqOWBYGQSYGWTFFli/beI7urzik6GVoexpmDisTyBAGLk4BmMgWYYb5kfuLXv/YzP60ZLu+ eUv93CrDthfdDPMse++sO3xneoxO/u2AP5HT/y86oMkJAA==
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

In doing so, remove the unneded kobject structure that was only being
created to cause a subdirectory for the attributes.  The name of the
attribute group is the correct way to do this, saving code and
complexity as well as allowing the attributes to properly show up to
userspace tools (the raw kobject would not allow that.)

Cc: Huang Rui <ray.huang@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/cpufreq/amd-pstate.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 73c7643b2697..b92454c50118 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,7 +63,6 @@ static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_DISABLE;
-struct kobject *amd_pstate_kobj;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -932,6 +931,7 @@ static struct attribute *pstate_global_attributes[] = {
 };
 
 static const struct attribute_group amd_pstate_global_attr_group = {
+	.name = "amd_pstate",
 	.attrs = pstate_global_attributes,
 };
 
@@ -1253,6 +1253,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 
 static int __init amd_pstate_init(void)
 {
+	struct device *dev_root;
 	int ret;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
@@ -1299,24 +1300,19 @@ static int __init amd_pstate_init(void)
 	if (ret)
 		pr_err("failed to register with return %d\n", ret);
 
-	amd_pstate_kobj = kobject_create_and_add("amd_pstate", &cpu_subsys.dev_root->kobj);
-	if (!amd_pstate_kobj) {
-		ret = -EINVAL;
-		pr_err("global sysfs registration failed.\n");
-		goto kobject_free;
-	}
-
-	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
-	if (ret) {
-		pr_err("sysfs attribute export failed with error %d.\n", ret);
-		goto global_attr_free;
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
+		put_device(dev_root);
+		if (ret) {
+			pr_err("sysfs attribute export failed with error %d.\n", ret);
+			goto global_attr_free;
+		}
 	}
 
 	return ret;
 
 global_attr_free:
-	kobject_put(amd_pstate_kobj);
-kobject_free:
 	cpufreq_unregister_driver(current_pstate_driver);
 	return ret;
 }
-- 
2.39.2

