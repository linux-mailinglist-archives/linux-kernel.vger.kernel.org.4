Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047396B80A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjCMSbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCMSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DEE15179;
        Mon, 13 Mar 2023 11:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F21CF6147D;
        Mon, 13 Mar 2023 18:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EE6C4339C;
        Mon, 13 Mar 2023 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732207;
        bh=hXLKonMm2sNxAWG39959mWWF++bz6QKPSxDIBNJCa+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ab6OR33cN0NvU+6g9zXWYvinHqjfhlr0RvqZqfI7FeYbPnSOY27hkdBPgdUe7B7pe
         hd3L1GyUMfQf2/hLNWmByUFkExGLumyWwXoqB7zn5mDFlXVYvHv/lI2ebq2gej16Sc
         FyBvyj89uQPe6Xjp317pH+/OcPBdcZCQFKy4TKTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 06/36] cpuidle: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:48 +0100
Message-Id: <20230313182918.1312597-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943; i=gregkh@linuxfoundation.org; h=from:subject; bh=hXLKonMm2sNxAWG39959mWWF++bz6QKPSxDIBNJCa+k=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82WVLjjRum3e46v65hebO/hNqY6eZsRx/8JQt6IFe5 pKdzu+LO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi7p0MC5beqH1Sx1G8to+5 UepNkvmyoEc3vzEs6Epd4rBanU9C4mzqmtvV/lPeGarnAgA=
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
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/cpuidle/cpuidle.c |  2 +-
 drivers/cpuidle/cpuidle.h |  2 +-
 drivers/cpuidle/sysfs.c   | 12 +++++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

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
index 48948b171749..84e4946f1072 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -119,11 +119,17 @@ static struct attribute_group cpuidle_attr_group = {
 
 /**
  * cpuidle_add_interface - add CPU global sysfs attributes
- * @dev: the target device
  */
-int cpuidle_add_interface(struct device *dev)
+int cpuidle_add_interface(void)
 {
-	return sysfs_create_group(&dev->kobj, &cpuidle_attr_group);
+	struct device *dev_root = bus_get_dev_root(&cpu_subsys);
+	int retval = -EINVAL;
+
+	if (dev_root) {
+		retval = sysfs_create_group(&dev_root->kobj, &cpuidle_attr_group);
+		put_device(dev_root);
+	}
+	return retval;
 }
 
 /**
-- 
2.39.2

