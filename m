Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835DC6C459E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCVJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCVJGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:06:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C521A35;
        Wed, 22 Mar 2023 02:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46F59B818DC;
        Wed, 22 Mar 2023 09:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0354C433D2;
        Wed, 22 Mar 2023 09:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679475968;
        bh=5iTvZYY8kxzlSWKBEa1LKiUhFH5Si7+MgSTVL7dasA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mV2a/x37jDTdNHVF+UgW1ymYblVv+zxAcDuPzIDJxdfg0Y+bJp8DuKJW2ovBQ6j02
         zmg3bhEiBy2j+3zkbblnVS8UAKW92H2AvVE9sQ0oFxq/9pxKoSS43pRNjPb8rINMzB
         nc5Xmp+4yrlIF6itTwNc3monWOCZMXvg8alQHdEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 03/19] cpuidle: move to use bus_get_dev_root()
Date:   Wed, 22 Mar 2023 10:05:57 +0100
Message-Id: <20230322090557.2943479-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CAJZ5v0hRScLjW27k_rHZ1jnLyn7B3O26oP9Jd3AwDL97VSJ8tQ@mail.gmail.com>
References: <CAJZ5v0hRScLjW27k_rHZ1jnLyn7B3O26oP9Jd3AwDL97VSJ8tQ@mail.gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; i=gregkh@linuxfoundation.org; h=from:subject; bh=5iTvZYY8kxzlSWKBEa1LKiUhFH5Si7+MgSTVL7dasA0=; b=owGbwMvMwCRo6H6F97bub03G02pJDClSRz5OuOF61DrQcc2ND//vTfW5dDslOS1KQKuZVyiUY a+V0fRVHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARMxmGORwOz6rXnbBvvbzy yDzrj1oGeh913jLMM6zrZ3hQqCCoV/puxS/D0woyV+uTAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

This allows us to clean up the cpuidle_add_interface() call a bit as it
was only called in one place, with the same argument so just put that
into the function itself.  Note that cpuidle_remove_interface() should
also probably be removed in the future as there are no callers of it for
some reason.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: - reworked cpuidle_add_interface() to exit early if dev_root is not
      valid based on review from Rafael.

 drivers/cpuidle/cpuidle.c |  2 +-
 drivers/cpuidle/cpuidle.h |  2 +-
 drivers/cpuidle/sysfs.c   | 13 ++++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0b00f21cefe3..8e929f6602ce 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -808,7 +808,7 @@ static int __init cpuidle_init(void)
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-	return cpuidle_add_interface(cpu_subsys.dev_root);
+	return cpuidle_add_interface();
 }
 
 module_param(off, int, 0444);
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index 9f336af17fa6..52701d9588f1 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -30,7 +30,7 @@ extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
 
 struct device;
 
-extern int cpuidle_add_interface(struct device *dev);
+extern int cpuidle_add_interface(void);
 extern void cpuidle_remove_interface(struct device *dev);
 extern int cpuidle_add_device_sysfs(struct cpuidle_device *device);
 extern void cpuidle_remove_device_sysfs(struct cpuidle_device *device);
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 48948b171749..d6f5da61cb7d 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -119,11 +119,18 @@ static struct attribute_group cpuidle_attr_group = {
 
 /**
  * cpuidle_add_interface - add CPU global sysfs attributes
- * @dev: the target device
  */
-int cpuidle_add_interface(struct device *dev)
+int cpuidle_add_interface(void)
 {
-	return sysfs_create_group(&dev->kobj, &cpuidle_attr_group);
+	struct device *dev_root = bus_get_dev_root(&cpu_subsys);
+	int retval;
+
+	if (!dev_root)
+		return -EINVAL;
+
+	retval = sysfs_create_group(&dev_root->kobj, &cpuidle_attr_group);
+	put_device(dev_root);
+	return retval;
 }
 
 /**
-- 
2.40.0

