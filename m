Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C626B808F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCMSa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCMSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B022A17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82B58B811DC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7583C433D2;
        Mon, 13 Mar 2023 18:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732178;
        bh=Pe0/hNNaMoU0gM+93u/XR+fgNuZd3OVKlbnEDdjzewc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeCZUVqpSJff9VP+DW9jFNHP3D6bViNOBeHt4CUyGJvvU7OCa6RIm78891LP9xQz7
         8yZkNNQ+e1qH+Uem/4Honp0okUzvw/kfI5VcCknWxDwcKw0TcL2lCQsPOgwjQnjOc9
         DwUmr8BGMFwrepQxn1GemY6tmvKPe5fMBe6RDIAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/36] powerpc/pseries: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:56 +0100
Message-Id: <20230313182918.1312597-14-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=gregkh@linuxfoundation.org; h=from:subject; bh=Pe0/hNNaMoU0gM+93u/XR+fgNuZd3OVKlbnEDdjzewc=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82RXZKQEzrFPtAtj+X3h7e5d64drtd1yuCEeKHLii9 8/9zIeCjhgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIUDvDfJctHGsOFU1n5xUW kdguExvkeDYkiGF6TL621vL83jeZU8IYMq78nJtmyQoA
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

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 .../platforms/pseries/pseries_energy.c        | 28 +++++++++++--------
 arch/powerpc/platforms/pseries/suspend.c      | 10 +++++--
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 09e98d301db0..2c661b798235 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -300,20 +300,22 @@ static struct device_attribute attr_percpu_deactivate_hint =
 static int __init pseries_energy_init(void)
 {
 	int cpu, err;
-	struct device *cpu_dev;
+	struct device *cpu_dev, *dev_root;
 
 	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY))
 		return 0; /* H_BEST_ENERGY hcall not supported */
 
 	/* Create the sysfs files */
-	err = device_create_file(cpu_subsys.dev_root,
-				&attr_cpu_activate_hint_list);
-	if (!err)
-		err = device_create_file(cpu_subsys.dev_root,
-				&attr_cpu_deactivate_hint_list);
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		err = device_create_file(dev_root, &attr_cpu_activate_hint_list);
+		if (!err)
+			err = device_create_file(dev_root, &attr_cpu_deactivate_hint_list);
+		put_device(dev_root);
+		if (err)
+			return err;
+	}
 
-	if (err)
-		return err;
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		err = device_create_file(cpu_dev,
@@ -337,14 +339,18 @@ static int __init pseries_energy_init(void)
 static void __exit pseries_energy_cleanup(void)
 {
 	int cpu;
-	struct device *cpu_dev;
+	struct device *cpu_dev, *dev_root;
 
 	if (!sysfs_entries)
 		return;
 
 	/* Remove the sysfs files */
-	device_remove_file(cpu_subsys.dev_root, &attr_cpu_activate_hint_list);
-	device_remove_file(cpu_subsys.dev_root, &attr_cpu_deactivate_hint_list);
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		device_remove_file(dev_root, &attr_cpu_activate_hint_list);
+		device_remove_file(dev_root, &attr_cpu_deactivate_hint_list);
+		put_device(dev_root);
+	}
 
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index 1b902cbf85c5..5c43435472cc 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -143,6 +143,7 @@ static const struct platform_suspend_ops pseries_suspend_ops = {
  **/
 static int pseries_suspend_sysfs_register(struct device *dev)
 {
+	struct device *dev_root;
 	int rc;
 
 	if ((rc = subsys_system_register(&suspend_subsys, NULL)))
@@ -151,8 +152,13 @@ static int pseries_suspend_sysfs_register(struct device *dev)
 	dev->id = 0;
 	dev->bus = &suspend_subsys;
 
-	if ((rc = device_create_file(suspend_subsys.dev_root, &dev_attr_hibernate)))
-		goto subsys_unregister;
+	dev_root = bus_get_dev_root(&suspend_subsys);
+	if (dev_root) {
+		rc = device_create_file(dev_root, &dev_attr_hibernate);
+		put_device(dev_root);
+		if (rc)
+			goto subsys_unregister;
+	}
 
 	return 0;
 
-- 
2.39.2

