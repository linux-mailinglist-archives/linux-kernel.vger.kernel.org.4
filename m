Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E459A64F76A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 04:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLQDuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 22:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQDuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 22:50:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB467DA5;
        Fri, 16 Dec 2022 19:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cwTAlwyRnIdU3NKPvVzb93OoqeXxCXwcvJ0JBZV+Usg=; b=xScNyQQbXpEtrbFDEg3FmPWXP7
        UxnPVVBILt1mr/0ZCcfWKA3whCsumTSM7M4XQ5dGSnu1BuQ13sGznlvy7aBp4nZswJEzT30Vn6K1P
        ABtz0+jE8KfsNWvu3Ob+dOzYVik/uUaQJqukhmJEr5I69iCt15mfeX+5wUVDTLAodSmqriw5Q8mgK
        tjE4bxNhBmrHujiQy8K/FtwxoeBASzhn272aNyZRd2KOv7QRIv5fvh2vSoPGHc9YkgkLVlSLPqpEw
        lV8X4mc1ER6CseyJrnDdvFOQQhF2EWj78dCJ/whh+pqqtcNgCNXIpjUtHrrmFUe5ATLwW1DQ7Gjt8
        BzDezvHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6OCx-004vhz-E8; Sat, 17 Dec 2022 03:49:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     dave@stgolabs.net, a.manzanares@samsung.com, mcgrof@kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] cxl_test: upgrade as a first class citizen selftests capable driver
Date:   Fri, 16 Dec 2022 19:49:47 -0800
Message-Id: <20221217034947.1174795-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To unit test CXL today we make use of the ndctl meson test suite but
this requires the cxl_test driver. There is however is no kconfig option
for this driver as its required to be built as an external driver. To
debug CXL with this framework is not inuitive as it departs itself from
typical Linux kernel development debugging processes, requiring an
external module build which also happens to *rebuild* all CXL related
production drivers with some new magic incantations, and replacing
your production CXL modules with the new ones.

This is quite complex, departs ourselves from the typical build/boot
debugging process most folks are used to, and requires a manual error-prone
process which in some kernels / configurations can leads up to a kernel
crash [0].

We can replace this by having the requirements be defined through proper
kconfig symbols and having the cxl_test driver and requirements also become
part of the standard Linux kernel build process. This matches most other
kernel kernel debugging frameworks for subsystems, which don't require any
external modules.

Let's review the current strategy today, first, so nothing is lost:

  * one must manually *build*, and then as a second step install
    the cxl_test driver as an external modules:

    make M=tools/testing/cxl/
    sudo M=tools/testing/cxl/ modules_install

    Provided your depmod.d was configured correctly on your Linux
    distribution you will end up with a complete set of CXL production
    modules and cxl_test mock drivers to let you now use the ndctl
    test suite. To be clear, you will not only end up with cxl_test
    but also with a complete set of module replacements for your CXL
    environment.

    This works by:

    a) allowing the external module to re-define the __mock macro
       to __weak, used on to_cxl_host_bridge() and allows the mock driver
       to provide a replacement for that single call.

    b) the external module build process *rebuilds* all production
       modules *again* but uses the the binutils --wrap=symbol
       feature [0] [1] to let the production CXL code use the mocked up
       CXL features.

We can simplify all this considerably and do away with the external
modules requirements. The __mock stuff is raplaced by addressing the
to_cxl_host_bridge() mapping using a define based on your kernel
configuration. If using the production code you use the produciton
__to_cxl_host_bridge(), otherwise mock_to_cxl_host_bridge() will be
used. This is the *only* eyesore in the CXL code to enable use of the
mock driver.

The magic --wrap=symbol incantations are also just tucked in a new
production drivers/cxl/Makefile.mock which is only read when the kernel
has been configured for debugging using the CXl mock framework.

The last bit of work left is to move as built-in code shared code
between a production environment (non-debugging) and between what is
needed for the same code to run when doing mock debugging. Today the
requirements are small:

  * The code to implement to_cxl_host_bridge()
  * When mock debugging is enabled, just the code we need to
    support mock_to_cxl_host_bridge()

For both cases this is needed you have CXL_ACPI enabled.

In the future if we wanted to then now use the kernel selftests,
for example a tools/testing/sefltests/cxl/ directory, we can easily
do so. This also enables us to separate out unit tests out from the
ndctl tree and allow unit tests to also be developed and written
upstream on the kernel.

Another benefit of this approach is that there is no bit rot,
in the sense that now bots can go willy nilly test building this
code, whereas before only those who knew the proper incantations
actually were building this code and loading it properly.

[0] https://lkml.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org
[1] https://sourceware.org/binutils/docs-2.23.1/ld/Options.html#index-g_t_002d_002dwrap_003d_0040var_007bsymbol_007d-263
[2] https://lwn.net/Articles/558106/
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

What do folks think?

The test results:

https://gist.github.com/mcgrof/2ab7f1601141faa5ac7b16240b4ea652

The summary of test results:

Summary of Failures:

1/5 ndctl:cxl / cxl-topology.sh      FAIL             0.50s   exit status 1
2/5 ndctl:cxl / cxl-region-sysfs.sh  FAIL             0.44s   exit status 1
5/5 ndctl:cxl / cxl-xor-region.sh    FAIL             0.45s   exit status 1

Ok:                 2   
Expected Fail:      0   
Fail:               3   
Unexpected Pass:    0   
Skipped:            0   
Timeout:            0  

I don't quite get the failures yet, but hey it's a start.
This commit depends on Dan's patch:

https://lkmll.kernel.org/r/6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch

But I can build another RFC if folks want without it.

 drivers/cxl/Kconfig                           | 23 +++++++
 drivers/cxl/Makefile                          |  2 +
 drivers/cxl/Makefile.mock                     | 15 +++++
 drivers/cxl/acpi.c                            | 13 ----
 drivers/cxl/core/Makefile                     |  4 ++
 drivers/cxl/core/acpi.c                       | 30 +++++++++
 drivers/cxl/cxl.h                             | 19 +++---
 lib/Kconfig.debug                             |  8 +++
 lib/Makefile                                  |  1 +
 lib/test_cxl/Makefile                         | 13 ++++
 lib/test_cxl/acpi.c                           | 28 +++++++++
 lib/test_cxl/core.c                           | 37 +++++++++++
 .../testing/cxl/test => lib/test_cxl}/cxl.c   |  7 ---
 .../testing/cxl/test => lib/test_cxl}/mem.c   |  0
 .../testing/cxl/test => lib/test_cxl}/mock.c  | 30 ---------
 .../testing/cxl/test => lib/test_cxl}/mock.h  |  0
 tools/testing/cxl/Kbuild                      | 61 -------------------
 tools/testing/cxl/config_check.c              | 13 ----
 tools/testing/cxl/cxl_acpi_test.c             |  6 --
 tools/testing/cxl/cxl_core_test.c             |  6 --
 tools/testing/cxl/cxl_mem_test.c              |  6 --
 tools/testing/cxl/cxl_pmem_test.c             |  6 --
 tools/testing/cxl/cxl_port_test.c             |  6 --
 tools/testing/cxl/mock_acpi.c                 | 35 -----------
 tools/testing/cxl/test/Kbuild                 | 10 ---
 tools/testing/cxl/watermark.h                 | 25 --------
 26 files changed, 173 insertions(+), 231 deletions(-)
 create mode 100644 drivers/cxl/Makefile.mock
 create mode 100644 drivers/cxl/core/acpi.c
 create mode 100644 lib/test_cxl/Makefile
 create mode 100644 lib/test_cxl/acpi.c
 create mode 100644 lib/test_cxl/core.c
 rename {tools/testing/cxl/test => lib/test_cxl}/cxl.c (99%)
 rename {tools/testing/cxl/test => lib/test_cxl}/mem.c (100%)
 rename {tools/testing/cxl/test => lib/test_cxl}/mock.c (88%)
 rename {tools/testing/cxl/test => lib/test_cxl}/mock.h (100%)
 delete mode 100644 tools/testing/cxl/Kbuild
 delete mode 100644 tools/testing/cxl/config_check.c
 delete mode 100644 tools/testing/cxl/cxl_acpi_test.c
 delete mode 100644 tools/testing/cxl/cxl_core_test.c
 delete mode 100644 tools/testing/cxl/cxl_mem_test.c
 delete mode 100644 tools/testing/cxl/cxl_pmem_test.c
 delete mode 100644 tools/testing/cxl/cxl_port_test.c
 delete mode 100644 tools/testing/cxl/mock_acpi.c
 delete mode 100644 tools/testing/cxl/test/Kbuild
 delete mode 100644 tools/testing/cxl/watermark.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 0ac53c422c31..051f2a531ce0 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -49,6 +49,11 @@ config CXL_MEM_RAW_COMMANDS
 
 	  If developing CXL hardware or the driver say Y, otherwise say N.
 
+config CXL_ACPI_BUILTIN
+	bool
+	depends on CXL_ACPI
+	default y
+
 config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
@@ -129,4 +134,22 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_DEBUG_MOCK_ACPI
+	bool
+	default y
+	depends on CXL_DEBUG_MOCK
+	depends on CXL_ACPI
+
+config CXL_DEBUG_MOCK
+	bool "Enables CXL debug mocking framework"
+	depends on CXL_BUS
+	depends on CXL_BUS!=y
+	depends on CXL_ACPI!=y
+	depends on CXL_PMEM!=y
+	select TEST_CXL
+	help
+	  Enables CXL debugging mocking facilities. Enable this if you want
+	  to test CXL with the ability to mock topologies otherwise not easily
+	  possible with a real system or qemu.
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index db321f48ba52..894488b4746a 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+include $(srctree)/drivers/cxl/Makefile.mock
+
 obj-y += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
diff --git a/drivers/cxl/Makefile.mock b/drivers/cxl/Makefile.mock
new file mode 100644
index 000000000000..523acf01894a
--- /dev/null
+++ b/drivers/cxl/Makefile.mock
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+ifneq ($(CONFIG_CXL_DEBUG_MOCK),)
+ldflags-y += --wrap=acpi_table_parse_cedt
+ldflags-y += --wrap=is_acpi_device_node
+ldflags-y += --wrap=acpi_evaluate_integer
+ldflags-y += --wrap=acpi_pci_find_root
+ldflags-y += --wrap=nvdimm_bus_register
+ldflags-y += --wrap=devm_cxl_port_enumerate_dports
+ldflags-y += --wrap=devm_cxl_setup_hdm
+ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
+ldflags-y += --wrap=devm_cxl_enumerate_decoders
+ldflags-y += --wrap=cxl_await_media_ready
+ldflags-y += --wrap=cxl_hdm_decode_init
+ldflags-y += --wrap=cxl_rcrb_to_component
+endif
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 657ef250d848..715766dac899 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -309,19 +309,6 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	return -ENOMEM;
 }
 
-__mock struct acpi_device *to_cxl_host_bridge(struct device *host,
-					      struct device *dev)
-{
-	struct acpi_device *adev = to_acpi_device(dev);
-
-	if (!acpi_pci_find_root(adev->handle))
-		return NULL;
-
-	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0)
-		return adev;
-	return NULL;
-}
-
 /*
  * A host bridge is a dport to a CFMWS decode and it is a uport to the
  * dport (PCIe Root Ports) in the host bridge.
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79c7257f4107..969567113a42 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+include $(srctree)/drivers/cxl/Makefile.mock
+
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
@@ -11,3 +13,5 @@ cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+
+obj-$(CONFIG_CXL_ACPI_BUILTIN) += acpi.o
diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
new file mode 100644
index 000000000000..b68cf5b45385
--- /dev/null
+++ b/drivers/cxl/core/acpi.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/memregion.h>
+#include <linux/workqueue.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <linux/acpi.h>
+#include <cxlmem.h>
+#include <cxlpci.h>
+#include <cxl.h>
+#include "core.h"
+
+struct acpi_device *__to_cxl_host_bridge(struct device *host,
+					 struct device *dev)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+
+	if (!acpi_pci_find_root(adev->handle))
+		return NULL;
+
+	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0)
+		return adev;
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(__to_cxl_host_bridge, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ed2b0a2e80e2..e7cb044372fe 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -693,12 +693,17 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 }
 #endif
 
-/*
- * Unit test builds overrides this to __weak, find the 'strong' version
- * of these symbols in tools/testing/cxl/.
- */
-#ifndef __mock
-#define __mock static
-#endif
+#ifdef CONFIG_CXL_ACPI_BUILTIN
+
+struct acpi_device *__to_cxl_host_bridge(struct device *host, struct device *dev);
+
+#ifdef CONFIG_CXL_DEBUG_MOCK_ACPI
+struct acpi_device *mock_to_cxl_host_bridge(struct device *host, struct device *dev);
+#define to_cxl_host_bridge mock_to_cxl_host_bridge
+#else
+#define to_cxl_host_bridge __to_cxl_host_bridge
+#endif /* CONFIG_CXL_DEBUG_MOCK_ACPI */
+
+#endif /* CONFIG_CXL_ACPI_BUILTIN */
 
 #endif /* __CXL_H__ */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 67c86b20c96a..ef87a513e3db 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2104,6 +2104,14 @@ config CPUMASK_KUNIT_TEST
 
 	  If unsure, say N.
 
+config TEST_CXL
+	tristate "Let's you load a CXL mock driver"
+	depends on CXL_BUS
+	depends on CXL_DEBUG_MOCK
+	default n
+	help
+	  Enable this to allow you to compile a CXL mock driver.
+
 config TEST_LIST_SORT
 	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..a29f9632e817 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_CXL_DEBUG_MOCK) += test_cxl/
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_cxl/Makefile b/lib/test_cxl/Makefile
new file mode 100644
index 000000000000..b4f0f6d890ef
--- /dev/null
+++ b/lib/test_cxl/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+ccflags-y := -I$(srctree)/drivers/cxl/
+
+obj-$(CONFIG_CXL_DEBUG_MOCK) +=		core.o
+obj-$(CONFIG_CXL_DEBUG_MOCK_ACPI) +=	acpi.o
+
+obj-$(CONFIG_TEST_CXL) += cxl_test.o
+obj-$(CONFIG_TEST_CXL) += cxl_mock.o
+obj-$(CONFIG_TEST_CXL) += cxl_mock_mem.o
+
+cxl_test-y := cxl.o
+cxl_mock-y := mock.o
+cxl_mock_mem-y := mem.o
diff --git a/lib/test_cxl/acpi.c b/lib/test_cxl/acpi.c
new file mode 100644
index 000000000000..18fbc32a96d3
--- /dev/null
+++ b/lib/test_cxl/acpi.c
@@ -0,0 +1,28 @@
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <cxl.h>
+#include "mock.h"
+
+struct acpi_device *mock_to_cxl_host_bridge(struct device *host,
+					    struct device *dev)
+{
+	int index;
+	struct acpi_device *found = NULL;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_bridge(dev)) {
+		found = ACPI_COMPANION(dev);
+		goto out;
+	}
+
+	if (dev->bus == &platform_bus_type)
+		goto out;
+
+	found = __to_cxl_host_bridge(host, dev);
+out:
+	put_cxl_mock_ops(index);
+	return found;
+}
+EXPORT_SYMBOL_NS_GPL(mock_to_cxl_host_bridge, CXL);
+
+MODULE_IMPORT_NS(CXL);
diff --git a/lib/test_cxl/core.c b/lib/test_cxl/core.c
new file mode 100644
index 000000000000..1d37ab5e9305
--- /dev/null
+++ b/lib/test_cxl/core.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//Copyright(c) 2021 Intel Corporation. All rights reserved.
+
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/srcu.h>
+#include "mock.h"
+
+static LIST_HEAD(mock);
+DEFINE_SRCU(cxl_mock_srcu);
+
+struct cxl_mock_ops *get_cxl_mock_ops(int *index)
+{
+	*index = srcu_read_lock(&cxl_mock_srcu);
+	return list_first_or_null_rcu(&mock, struct cxl_mock_ops, list);
+}
+EXPORT_SYMBOL_GPL(get_cxl_mock_ops);
+
+void put_cxl_mock_ops(int index)
+{
+	srcu_read_unlock(&cxl_mock_srcu, index);
+}
+EXPORT_SYMBOL_GPL(put_cxl_mock_ops);
+
+void register_cxl_mock_ops(struct cxl_mock_ops *ops)
+{
+	list_add_rcu(&ops->list, &mock);
+}
+EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
+
+void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
+{
+	list_del_rcu(&ops->list);
+	synchronize_srcu(&cxl_mock_srcu);
+}
+EXPORT_SYMBOL_GPL(unregister_cxl_mock_ops);
diff --git a/tools/testing/cxl/test/cxl.c b/lib/test_cxl/cxl.c
similarity index 99%
rename from tools/testing/cxl/test/cxl.c
rename to lib/test_cxl/cxl.c
index 920bd969c554..ef8071f48142 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/lib/test_cxl/cxl.c
@@ -10,7 +10,6 @@
 #include <linux/mm.h>
 #include <cxlmem.h>
 
-#include "../watermark.h"
 #include "mock.h"
 
 static int interleave_arithmetic;
@@ -1121,12 +1120,6 @@ static __init int cxl_test_init(void)
 {
 	int rc, i;
 
-	cxl_acpi_test();
-	cxl_core_test();
-	cxl_mem_test();
-	cxl_pmem_test();
-	cxl_port_test();
-
 	register_cxl_mock_ops(&cxl_mock_ops);
 
 	cxl_mock_pool = gen_pool_create(ilog2(SZ_2M), NUMA_NO_NODE);
diff --git a/tools/testing/cxl/test/mem.c b/lib/test_cxl/mem.c
similarity index 100%
rename from tools/testing/cxl/test/mem.c
rename to lib/test_cxl/mem.c
diff --git a/tools/testing/cxl/test/mock.c b/lib/test_cxl/mock.c
similarity index 88%
rename from tools/testing/cxl/test/mock.c
rename to lib/test_cxl/mock.c
index 5dface08e0de..fa2b2d5c7054 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/lib/test_cxl/mock.c
@@ -11,36 +11,6 @@
 #include <cxlpci.h>
 #include "mock.h"
 
-static LIST_HEAD(mock);
-
-void register_cxl_mock_ops(struct cxl_mock_ops *ops)
-{
-	list_add_rcu(&ops->list, &mock);
-}
-EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
-
-static DEFINE_SRCU(cxl_mock_srcu);
-
-void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
-{
-	list_del_rcu(&ops->list);
-	synchronize_srcu(&cxl_mock_srcu);
-}
-EXPORT_SYMBOL_GPL(unregister_cxl_mock_ops);
-
-struct cxl_mock_ops *get_cxl_mock_ops(int *index)
-{
-	*index = srcu_read_lock(&cxl_mock_srcu);
-	return list_first_or_null_rcu(&mock, struct cxl_mock_ops, list);
-}
-EXPORT_SYMBOL_GPL(get_cxl_mock_ops);
-
-void put_cxl_mock_ops(int index)
-{
-	srcu_read_unlock(&cxl_mock_srcu, index);
-}
-EXPORT_SYMBOL_GPL(put_cxl_mock_ops);
-
 bool __wrap_is_acpi_device_node(const struct fwnode_handle *fwnode)
 {
 	struct acpi_device *adev =
diff --git a/tools/testing/cxl/test/mock.h b/lib/test_cxl/mock.h
similarity index 100%
rename from tools/testing/cxl/test/mock.h
rename to lib/test_cxl/mock.h
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
deleted file mode 100644
index 427174feeb7d..000000000000
--- a/tools/testing/cxl/Kbuild
+++ /dev/null
@@ -1,61 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-ldflags-y += --wrap=acpi_table_parse_cedt
-ldflags-y += --wrap=is_acpi_device_node
-ldflags-y += --wrap=acpi_evaluate_integer
-ldflags-y += --wrap=acpi_pci_find_root
-ldflags-y += --wrap=nvdimm_bus_register
-ldflags-y += --wrap=devm_cxl_port_enumerate_dports
-ldflags-y += --wrap=devm_cxl_setup_hdm
-ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
-ldflags-y += --wrap=devm_cxl_enumerate_decoders
-ldflags-y += --wrap=cxl_await_media_ready
-ldflags-y += --wrap=cxl_hdm_decode_init
-ldflags-y += --wrap=cxl_rcrb_to_component
-
-DRIVERS := ../../../drivers
-CXL_SRC := $(DRIVERS)/cxl
-CXL_CORE_SRC := $(DRIVERS)/cxl/core
-ccflags-y := -I$(srctree)/drivers/cxl/
-ccflags-y += -D__mock=__weak
-
-obj-m += cxl_acpi.o
-
-cxl_acpi-y := $(CXL_SRC)/acpi.o
-cxl_acpi-y += mock_acpi.o
-cxl_acpi-y += config_check.o
-cxl_acpi-y += cxl_acpi_test.o
-
-obj-m += cxl_pmem.o
-
-cxl_pmem-y := $(CXL_SRC)/pmem.o
-cxl_pmem-y += $(CXL_SRC)/security.o
-cxl_pmem-y += config_check.o
-cxl_pmem-y += cxl_pmem_test.o
-
-obj-m += cxl_port.o
-
-cxl_port-y := $(CXL_SRC)/port.o
-cxl_port-y += config_check.o
-cxl_port-y += cxl_port_test.o
-
-
-obj-m += cxl_mem.o
-
-cxl_mem-y := $(CXL_SRC)/mem.o
-cxl_mem-y += config_check.o
-cxl_mem-y += cxl_mem_test.o
-
-obj-m += cxl_core.o
-
-cxl_core-y := $(CXL_CORE_SRC)/port.o
-cxl_core-y += $(CXL_CORE_SRC)/pmem.o
-cxl_core-y += $(CXL_CORE_SRC)/regs.o
-cxl_core-y += $(CXL_CORE_SRC)/memdev.o
-cxl_core-y += $(CXL_CORE_SRC)/mbox.o
-cxl_core-y += $(CXL_CORE_SRC)/pci.o
-cxl_core-y += $(CXL_CORE_SRC)/hdm.o
-cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
-cxl_core-y += config_check.o
-cxl_core-y += cxl_core_test.o
-
-obj-m += test/
diff --git a/tools/testing/cxl/config_check.c b/tools/testing/cxl/config_check.c
deleted file mode 100644
index de5e5b3652fd..000000000000
--- a/tools/testing/cxl/config_check.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/bug.h>
-
-void check(void)
-{
-	/*
-	 * These kconfig symbols must be set to "m" for cxl_test to load
-	 * and operate.
-	 */
-	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_BUS));
-	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_ACPI));
-	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_PMEM));
-}
diff --git a/tools/testing/cxl/cxl_acpi_test.c b/tools/testing/cxl/cxl_acpi_test.c
deleted file mode 100644
index 8602dc27c81c..000000000000
--- a/tools/testing/cxl/cxl_acpi_test.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-
-#include "watermark.h"
-
-cxl_test_watermark(cxl_acpi);
diff --git a/tools/testing/cxl/cxl_core_test.c b/tools/testing/cxl/cxl_core_test.c
deleted file mode 100644
index 464a9255e4d6..000000000000
--- a/tools/testing/cxl/cxl_core_test.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-
-#include "watermark.h"
-
-cxl_test_watermark(cxl_core);
diff --git a/tools/testing/cxl/cxl_mem_test.c b/tools/testing/cxl/cxl_mem_test.c
deleted file mode 100644
index ba7fb8a44288..000000000000
--- a/tools/testing/cxl/cxl_mem_test.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-
-#include "watermark.h"
-
-cxl_test_watermark(cxl_mem);
diff --git a/tools/testing/cxl/cxl_pmem_test.c b/tools/testing/cxl/cxl_pmem_test.c
deleted file mode 100644
index 3fd884fae537..000000000000
--- a/tools/testing/cxl/cxl_pmem_test.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-
-#include "watermark.h"
-
-cxl_test_watermark(cxl_pmem);
diff --git a/tools/testing/cxl/cxl_port_test.c b/tools/testing/cxl/cxl_port_test.c
deleted file mode 100644
index be183917a9f6..000000000000
--- a/tools/testing/cxl/cxl_port_test.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-
-#include "watermark.h"
-
-cxl_test_watermark(cxl_port);
diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
deleted file mode 100644
index 55813de26d46..000000000000
--- a/tools/testing/cxl/mock_acpi.c
+++ /dev/null
@@ -1,35 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
-
-#include <linux/platform_device.h>
-#include <linux/device.h>
-#include <linux/acpi.h>
-#include <cxl.h>
-#include "test/mock.h"
-
-struct acpi_device *to_cxl_host_bridge(struct device *host, struct device *dev)
-{
-	int index;
-	struct acpi_device *adev, *found = NULL;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_bridge(dev)) {
-		found = ACPI_COMPANION(dev);
-		goto out;
-	}
-
-	if (dev->bus == &platform_bus_type)
-		goto out;
-
-	adev = to_acpi_device(dev);
-	if (!acpi_pci_find_root(adev->handle))
-		goto out;
-
-	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0) {
-		found = adev;
-		dev_dbg(host, "found host bridge %s\n", dev_name(&adev->dev));
-	}
-out:
-	put_cxl_mock_ops(index);
-	return found;
-}
diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
deleted file mode 100644
index 4e59e2c911f6..000000000000
--- a/tools/testing/cxl/test/Kbuild
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I$(srctree)/drivers/cxl/
-
-obj-m += cxl_test.o
-obj-m += cxl_mock.o
-obj-m += cxl_mock_mem.o
-
-cxl_test-y := cxl.o
-cxl_mock-y := mock.o
-cxl_mock_mem-y := mem.o
diff --git a/tools/testing/cxl/watermark.h b/tools/testing/cxl/watermark.h
deleted file mode 100644
index 9d81d4a5f6be..000000000000
--- a/tools/testing/cxl/watermark.h
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-#ifndef _TEST_CXL_WATERMARK_H_
-#define _TEST_CXL_WATERMARK_H_
-#include <linux/module.h>
-#include <linux/printk.h>
-
-int cxl_acpi_test(void);
-int cxl_core_test(void);
-int cxl_mem_test(void);
-int cxl_pmem_test(void);
-int cxl_port_test(void);
-
-/*
- * dummy routine for cxl_test to validate it is linking to the properly
- * mocked module and not the standard one from the base tree.
- */
-#define cxl_test_watermark(x)				\
-int x##_test(void)					\
-{							\
-	pr_debug("%s for cxl_test\n", KBUILD_MODNAME);	\
-	return 0;					\
-}							\
-EXPORT_SYMBOL(x##_test)
-#endif /* _TEST_CXL_WATERMARK_H_ */
-- 
2.35.1

