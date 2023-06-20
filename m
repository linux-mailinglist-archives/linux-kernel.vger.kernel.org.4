Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBC0736F03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjFTOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjFTOos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BC172C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9FC1612DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2323C433C8;
        Tue, 20 Jun 2023 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687272283;
        bh=0M+nLDZFlAC5uRcRvEMx4cqFIB9rQ/EvGoomT6DUzoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLwwgaMml5dK+FvsH6PsvtOiiQAoV4boR4i1tQlPEadC77P2+sXwbSxIp4PEiZIgP
         HSXE7vnBYJ9iviRTAL++jSv27eMNV+0lGziwRlGKEP86qj4a/Esh6lIClJelE/uZuv
         +tR910dysRtoUG5PHzjiugQN8txycfwTQpj9dffs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] x86/resctrl: make pseudo_lock_class a static const structure
Date:   Tue, 20 Jun 2023 16:44:34 +0200
Message-ID: <20230620144431.583290-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620144431.583290-4-gregkh@linuxfoundation.org>
References: <20230620144431.583290-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; i=gregkh@linuxfoundation.org; h=from:subject; bh=ZrmDno1rLPLMmfgPHDkLl0x2OYPv6j0/RiEkxcIsOsI=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd/uvrP4R+Pdra3ZSeXnI1OfTEsTVnjFV5hkEM8dub 84rtyzpiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgImcjWSYw7351gv3jes5d+1P 6PystCDmbO6OhQwLls9a8+Z240fe5VUcpnyzrBllF2yMBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the pseudo_lock_class structure to be declared at build
time placing it into read-only memory, instead of having to be
dynamically allocated at boot time.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 41 ++++++++++++-----------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 458cb7419502..8f559eeae08e 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -45,7 +45,21 @@ static u64 prefetch_disable_bits;
  */
 static unsigned int pseudo_lock_major;
 static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
-static struct class *pseudo_lock_class;
+
+static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
+{
+	const struct rdtgroup *rdtgrp;
+
+	rdtgrp = dev_get_drvdata(dev);
+	if (mode)
+		*mode = 0600;
+	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdtgrp->kn->name);
+}
+
+static const struct class pseudo_lock_class = {
+	.name = "pseudo_lock",
+	.devnode = pseudo_lock_devnode,
+};
 
 /**
  * get_prefetch_disable_bits - prefetch disable bits of supported platforms
@@ -1353,7 +1367,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 					    &pseudo_measure_fops);
 	}
 
-	dev = device_create(pseudo_lock_class, NULL,
+	dev = device_create(&pseudo_lock_class, NULL,
 			    MKDEV(pseudo_lock_major, new_minor),
 			    rdtgrp, "%s", rdtgrp->kn->name);
 
@@ -1383,7 +1397,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	goto out;
 
 out_device:
-	device_destroy(pseudo_lock_class, MKDEV(pseudo_lock_major, new_minor));
+	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, new_minor));
 out_debugfs:
 	debugfs_remove_recursive(plr->debugfs_dir);
 	pseudo_lock_minor_release(new_minor);
@@ -1424,7 +1438,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
 
 	pseudo_lock_cstates_relax(plr);
 	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
-	device_destroy(pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
+	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
 	pseudo_lock_minor_release(plr->minor);
 
 free:
@@ -1560,16 +1574,6 @@ static const struct file_operations pseudo_lock_dev_fops = {
 	.mmap =		pseudo_lock_dev_mmap,
 };
 
-static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
-{
-	const struct rdtgroup *rdtgrp;
-
-	rdtgrp = dev_get_drvdata(dev);
-	if (mode)
-		*mode = 0600;
-	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdtgrp->kn->name);
-}
-
 int rdt_pseudo_lock_init(void)
 {
 	int ret;
@@ -1580,21 +1584,18 @@ int rdt_pseudo_lock_init(void)
 
 	pseudo_lock_major = ret;
 
-	pseudo_lock_class = class_create("pseudo_lock");
-	if (IS_ERR(pseudo_lock_class)) {
-		ret = PTR_ERR(pseudo_lock_class);
+	ret = class_register(&pseudo_lock_class);
+	if (ret) {
 		unregister_chrdev(pseudo_lock_major, "pseudo_lock");
 		return ret;
 	}
 
-	pseudo_lock_class->devnode = pseudo_lock_devnode;
 	return 0;
 }
 
 void rdt_pseudo_lock_release(void)
 {
-	class_destroy(pseudo_lock_class);
-	pseudo_lock_class = NULL;
+	class_unregister(&pseudo_lock_class);
 	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
 	pseudo_lock_major = 0;
 }
-- 
2.41.0

