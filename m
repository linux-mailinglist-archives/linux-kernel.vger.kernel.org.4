Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E809665B57A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbjABRFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjABRFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:05:13 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E6FDB7;
        Mon,  2 Jan 2023 09:05:11 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id dc1510c9b7cfec88; Mon, 2 Jan 2023 18:05:10 +0100
Received: from kreacher.localnet (unknown [213.134.163.167])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C0F2C28C1374;
        Mon,  2 Jan 2023 18:05:09 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Hang Zhang <zh.nvgt@gmail.com>
Subject: [PATCH] ACPI: Drop the custom_method debugfs interface
Date:   Mon, 02 Jan 2023 18:05:09 +0100
Message-ID: <7499491.EvYhyI6sBW@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.167
X-CLIENT-HOSTNAME: 213.134.163.167
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrdduieefrdduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeifedrudeijedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepiihhrdhnvhhgthesghhmrghilhdr
 tghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI custom_method debugfs interface is security-sensitive and
concurrent access to it is broken [1].

Moreover, the recipe for preparing a customized version of a given
control method has changed at one point due to ACPICA changes, which
has not been reflected in its documentation, so whoever used it before
has had to adapt an no problems with it have been reported.

The latter likely means that the number of its users is limited at best
and attempting to fix the issues mentioned above is likely not worth the
effort.  Moreover, if it gets broken in the process, the breakage may not
be readily discovered, so deleting it altogheher appeares to be a better
option.

Accordingly, drop custom_method along with its (outdated anyway)
documentation.

Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/ # [1]
Reported-by: Hang Zhang <zh.nvgt@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/firmware-guide/acpi/method-customizing.rst |   89 ------------
 drivers/acpi/Kconfig                                     |   14 --
 drivers/acpi/Makefile                                    |    1 
 drivers/acpi/custom_method.c                             |  103 ---------------
 4 files changed, 207 deletions(-)

Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -444,20 +444,6 @@ config ACPI_HED
 	  which is used to report some hardware errors notified via
 	  SCI, mainly the corrected errors.
 
-config ACPI_CUSTOM_METHOD
-	tristate "Allow ACPI methods to be inserted/replaced at run time"
-	depends on DEBUG_FS
-	help
-	  This debug facility allows ACPI AML methods to be inserted and/or
-	  replaced without rebooting the system. For details refer to:
-	  Documentation/firmware-guide/acpi/method-customizing.rst.
-
-	  NOTE: This option is security sensitive, because it allows arbitrary
-	  kernel memory to be written to by root (uid=0) users, allowing them
-	  to bypass certain security measures (e.g. if root is not allowed to
-	  load additional kernel modules after boot, this feature may be used
-	  to override that restriction).
-
 config ACPI_BGRT
 	bool "Boottime Graphics Resource Table support"
 	depends on EFI && (X86 || ARM64)
Index: linux-pm/drivers/acpi/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -101,7 +101,6 @@ obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
 obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
-obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
Index: linux-pm/drivers/acpi/custom_method.c
===================================================================
--- linux-pm.orig/drivers/acpi/custom_method.c
+++ /dev/null
@@ -1,103 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * custom_method.c - debugfs interface for customizing ACPI control method
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/uaccess.h>
-#include <linux/debugfs.h>
-#include <linux/acpi.h>
-#include <linux/security.h>
-
-#include "internal.h"
-
-MODULE_LICENSE("GPL");
-
-static struct dentry *cm_dentry;
-
-/* /sys/kernel/debug/acpi/custom_method */
-
-static ssize_t cm_write(struct file *file, const char __user *user_buf,
-			size_t count, loff_t *ppos)
-{
-	static char *buf;
-	static u32 max_size;
-	static u32 uncopied_bytes;
-
-	struct acpi_table_header table;
-	acpi_status status;
-	int ret;
-
-	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
-	if (ret)
-		return ret;
-
-	if (!(*ppos)) {
-		/* parse the table header to get the table length */
-		if (count <= sizeof(struct acpi_table_header))
-			return -EINVAL;
-		if (copy_from_user(&table, user_buf,
-				   sizeof(struct acpi_table_header)))
-			return -EFAULT;
-		uncopied_bytes = max_size = table.length;
-		/* make sure the buf is not allocated */
-		kfree(buf);
-		buf = kzalloc(max_size, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-	}
-
-	if (buf == NULL)
-		return -EINVAL;
-
-	if ((*ppos > max_size) ||
-	    (*ppos + count > max_size) ||
-	    (*ppos + count < count) ||
-	    (count > uncopied_bytes)) {
-		kfree(buf);
-		buf = NULL;
-		return -EINVAL;
-	}
-
-	if (copy_from_user(buf + (*ppos), user_buf, count)) {
-		kfree(buf);
-		buf = NULL;
-		return -EFAULT;
-	}
-
-	uncopied_bytes -= count;
-	*ppos += count;
-
-	if (!uncopied_bytes) {
-		status = acpi_install_method(buf);
-		kfree(buf);
-		buf = NULL;
-		if (ACPI_FAILURE(status))
-			return -EINVAL;
-		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
-	}
-
-	return count;
-}
-
-static const struct file_operations cm_fops = {
-	.write = cm_write,
-	.llseek = default_llseek,
-};
-
-static int __init acpi_custom_method_init(void)
-{
-	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
-					acpi_debugfs_dir, NULL, &cm_fops);
-	return 0;
-}
-
-static void __exit acpi_custom_method_exit(void)
-{
-	debugfs_remove(cm_dentry);
-}
-
-module_init(acpi_custom_method_init);
-module_exit(acpi_custom_method_exit);
Index: linux-pm/Documentation/firmware-guide/acpi/method-customizing.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/method-customizing.rst
+++ /dev/null
@@ -1,89 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=======================================
-Linux ACPI Custom Control Method How To
-=======================================
-
-:Author: Zhang Rui <rui.zhang@intel.com>
-
-
-Linux supports customizing ACPI control methods at runtime.
-
-Users can use this to:
-
-1. override an existing method which may not work correctly,
-   or just for debugging purposes.
-2. insert a completely new method in order to create a missing
-   method such as _OFF, _ON, _STA, _INI, etc.
-
-For these cases, it is far simpler to dynamically install a single
-control method rather than override the entire DSDT, because kernel
-rebuild/reboot is not needed and test result can be got in minutes.
-
-.. note::
-
-  - Only ACPI METHOD can be overridden, any other object types like
-    "Device", "OperationRegion", are not recognized. Methods
-    declared inside scope operators are also not supported.
-
-  - The same ACPI control method can be overridden for many times,
-    and it's always the latest one that used by Linux/kernel.
-
-  - To get the ACPI debug object output (Store (AAAA, Debug)),
-    please run::
-
-      echo 1 > /sys/module/acpi/parameters/aml_debug_output
-
-
-1. override an existing method
-==============================
-a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
-   just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
-b) disassemble the table by running "iasl -d dsdt.dat".
-c) rewrite the ASL code of the method and save it in a new file,
-d) package the new file (psr.asl) to an ACPI table format.
-   Here is an example of a customized \_SB._AC._PSR method::
-
-      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
-      {
-         Method (\_SB_.AC._PSR, 0, NotSerialized)
-         {
-            Store ("In AC _PSR", Debug)
-            Return (ACON)
-         }
-      }
-
-   Note that the full pathname of the method in ACPI namespace
-   should be used.
-e) assemble the file to generate the AML code of the method.
-   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
-   If parameter "-vw 6084" is not supported by your iASL compiler,
-   please try a newer version.
-f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
-g) override the old method via the debugfs by running
-   "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
-
-2. insert a new method
-======================
-This is easier than overriding an existing method.
-We just need to create the ASL code of the method we want to
-insert and then follow the step c) ~ g) in section 1.
-
-3. undo your changes
-====================
-The "undo" operation is not supported for a new inserted method
-right now, i.e. we can not remove a method currently.
-For an overridden method, in order to undo your changes, please
-save a copy of the method original ASL code in step c) section 1,
-and redo step c) ~ g) to override the method with the original one.
-
-
-.. note:: We can use a kernel with multiple custom ACPI method running,
-   But each individual write to debugfs can implement a SINGLE
-   method override. i.e. if we want to insert/override multiple
-   ACPI methods, we need to redo step c) ~ g) for multiple times.
-
-.. note:: Be aware that root can mis-use this driver to modify arbitrary
-   memory and gain additional rights, if root's privileges got
-   restricted (for example if root is not allowed to load additional
-   modules after boot).



