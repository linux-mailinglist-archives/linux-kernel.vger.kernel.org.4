Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302E5BD071
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiISPRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiISPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:16:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242EC1209B;
        Mon, 19 Sep 2022 08:16:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWSqs2RbFzpStl;
        Mon, 19 Sep 2022 23:13:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:16:32 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:16:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 8/8] kallsyms: Add self-test facility
Date:   Mon, 19 Sep 2022 23:15:33 +0800
Message-ID: <20220919151533.1734-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220919151533.1734-1-thunder.leizhen@huawei.com>
References: <20220919151533.1734-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added test cases for basic functions and performance of functions
kallsyms_lookup_name(), kallsyms_on_each_symbol() and
kallsyms_on_each_match_symbol(). It also calculates the compression rate
of the kallsyms compression algorithm for the current symbol set.

The basic functions test begins by testing a set of symbols whose address
values are known. Then, traverse all symbol addresses and find the
corresponding symbol name based on the address. It's impossible to
determine whether these addresses are correct, but we can use the above
three functions along with the addresses to test each other. Due to the
traversal operation of kallsyms_on_each_symbol() is too slow, only 60
symbols can be tested in one second, so let it test on average once
every 128 symbols. The other two functions validate all symbols.

If the basic functions test is passed, print only performance test
results. If the test fails, print error information, but do not perform
subsequent performance tests.

Start self-test automatically after system startup if
CONFIG_KALLSYMS_SELFTEST=y.

Example of output content: (prefix 'kallsyms_selftest:' is omitted)
 start
  ---------------------------------------------------------
 | nr_symbols | compressed size | original size | ratio(%) |
 |---------------------------------------------------------|
 |     174099 |       1960154   |      3750756  |  52.26   |
  ---------------------------------------------------------
 kallsyms_lookup_name() looked up 174099 symbols
 The time spent on each symbol is (ns): min=5250, max=726560, avg=302132
 kallsyms_on_each_symbol() traverse all: 16659500 ns
 kallsyms_on_each_match_symbol() traverse all: 557400 ns
 finish

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 init/Kconfig               |  13 ++
 kernel/Makefile            |   1 +
 kernel/kallsyms.c          |   2 +-
 kernel/kallsyms_selftest.c | 424 +++++++++++++++++++++++++++++++++++++
 4 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 kernel/kallsyms_selftest.c

diff --git a/init/Kconfig b/init/Kconfig
index 532362fcfe31fd3..2fcace3b9f063bf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1716,6 +1716,19 @@ config KALLSYMS
 	  symbolic stack backtraces. This increases the size of the kernel
 	  somewhat, as all symbols have to be loaded into the kernel image.
 
+config KALLSYMS_SELFTEST
+	bool "Test the function and performance of some interfaces in kallsyms"
+	depends on KALLSYMS
+	default n
+	help
+	  Test the function and performance of some interfaces, such as
+	  kallsyms_lookup_name. It also calculates the compression rate of the
+	  kallsyms compression algorithm for the current symbol set.
+
+	  Start self-test automatically after system startup. Suggest executing
+	  "dmesg | grep kallsyms_selftest" to collect test results. "finish" is
+	  displayed in the last line, indicating that the test is complete.
+
 config KALLSYMS_ALL
 	bool "Include all symbols in kallsyms"
 	depends on DEBUG_KERNEL && KALLSYMS
diff --git a/kernel/Makefile b/kernel/Makefile
index 318789c728d3290..122a5fed457bd98 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -68,6 +68,7 @@ endif
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
+obj-$(CONFIG_KALLSYMS_SELFTEST) += kallsyms_selftest.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index cbcc9c560f5c188..34e306eecbb60c8 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -193,7 +193,7 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	return name - kallsyms_names;
 }
 
-static unsigned long kallsyms_sym_address(int idx)
+unsigned long kallsyms_sym_address(int idx)
 {
 	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
 		return kallsyms_addresses[idx];
diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
new file mode 100644
index 000000000000000..756759d1f45a6e3
--- /dev/null
+++ b/kernel/kallsyms_selftest.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test the function and performance of kallsyms
+ *
+ * Copyright (C) Huawei Technologies Co., Ltd., 2022
+ *
+ * Authors: Zhen Lei <thunder.leizhen@huawei.com> Huawei
+ */
+
+#define pr_fmt(fmt) "kallsyms_selftest: " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#include <linux/random.h>
+#include <linux/sched/clock.h>
+#include <linux/kthread.h>
+#include <linux/vmalloc.h>
+
+#include "kallsyms_internal.h"
+
+extern unsigned long kallsyms_sym_address(int idx);
+
+#define MAX_NUM_OF_RECORDS		64
+
+struct test_stat {
+	int min;
+	int max;
+	int save_cnt;
+	int real_cnt;
+	u64 sum;
+	char *name;
+	unsigned long addr;
+	unsigned long addrs[MAX_NUM_OF_RECORDS];
+};
+
+struct test_item {
+	char *name;
+	unsigned long addr;
+};
+
+#define ITEM_FUNC(s)				\
+	{					\
+		.name = #s,			\
+		.addr = (unsigned long)s,	\
+	}
+
+#define ITEM_DATA(s)				\
+	{					\
+		.name = #s,			\
+		.addr = (unsigned long)&s,	\
+	}
+
+static int test_var_bss_static;
+static int test_var_data_static = 1;
+int test_var_bss;
+int test_var_data = 1;
+
+static int test_func_static(void)
+{
+	test_var_bss_static++;
+	test_var_data_static++;
+
+	return 0;
+}
+
+int test_func(void)
+{
+	return test_func_static();
+}
+
+__weak int test_func_weak(void)
+{
+	test_var_bss++;
+	test_var_data++;
+	return 0;
+}
+
+static struct test_item test_items[] = {
+	ITEM_FUNC(test_func_static),
+	ITEM_FUNC(test_func),
+	ITEM_FUNC(test_func_weak),
+	ITEM_FUNC(vmalloc),
+	ITEM_FUNC(vfree),
+#ifdef CONFIG_KALLSYMS_ALL
+	ITEM_DATA(test_var_bss_static),
+	ITEM_DATA(test_var_data_static),
+	ITEM_DATA(test_var_bss),
+	ITEM_DATA(test_var_data),
+	ITEM_DATA(vmap_area_list),
+#endif
+};
+
+static char stub_name[KSYM_NAME_LEN];
+
+static int stat_symbol_len(void *data, const char *name,
+			   struct module *mod, unsigned long addr)
+{
+	*(u32 *)data += strlen(name);
+
+	return 0;
+}
+
+static void test_kallsyms_compression_ratio(void)
+{
+	int i;
+	const u8 *name;
+	u32 pos;
+	u32 ratio, total_size, total_len = 0;
+
+	kallsyms_on_each_symbol(stat_symbol_len, &total_len);
+
+	/*
+	 * A symbol name cannot start with a number. This stub name helps us
+	 * traverse the entire symbol table without finding a match. It's used
+	 * for subsequent performance tests, and its length is the average
+	 * length of all symbol names.
+	 */
+	memset(stub_name, '4', sizeof(stub_name));
+	pos = total_len / kallsyms_num_syms;
+	stub_name[pos] = 0;
+
+	pos = kallsyms_num_syms - 1;
+	name = &kallsyms_names[kallsyms_markers[pos >> 8]];
+	for (i = 0; i <= (pos & 0xff); i++)
+		name = name + (*name) + 1;
+
+	/*
+	 * 1. The length fields is not counted
+	 * 2. The memory occupied by array kallsyms_token_table[] and
+	 *    kallsyms_token_index[] needs to be counted.
+	 */
+	total_size = (name - kallsyms_names) - kallsyms_num_syms;
+	pos = kallsyms_token_index[0xff];
+	total_size += pos + strlen(&kallsyms_token_table[pos]) + 1;
+	total_size += 0x100 * sizeof(u16);
+
+	pr_info(" ---------------------------------------------------------\n");
+	pr_info("| nr_symbols | compressed size | original size | ratio(%%) |\n");
+	pr_info("|---------------------------------------------------------|\n");
+	ratio = 10000ULL * total_size / total_len;
+	pr_info("| %10d |    %10d   |   %10d  |  %2d.%-2d   |\n",
+		kallsyms_num_syms, total_size, total_len, ratio / 100, ratio % 100);
+	pr_info(" ---------------------------------------------------------\n");
+}
+
+static int lookup_name(void *data, const char *name, struct module *mod, unsigned long addr)
+{
+	u64 t0, t1, t;
+	unsigned long flags;
+	struct test_stat *stat = (struct test_stat *)data;
+
+	local_irq_save(flags);
+	t0 = sched_clock();
+	(void)kallsyms_lookup_name(name);
+	t1 = sched_clock();
+	local_irq_restore(flags);
+
+	t = t1 - t0;
+	if (t < stat->min)
+		stat->min = t;
+
+	if (t > stat->max)
+		stat->max = t;
+
+	stat->real_cnt++;
+	stat->sum += t;
+
+	return 0;
+}
+
+static void test_perf_kallsyms_lookup_name(void)
+{
+	struct test_stat stat;
+
+	memset(&stat, 0, sizeof(stat));
+	stat.min = INT_MAX;
+	kallsyms_on_each_symbol(lookup_name, &stat);
+	pr_info("kallsyms_lookup_name() looked up %d symbols\n", stat.real_cnt);
+	pr_info("The time spent on each symbol is (ns): min=%d, max=%d, avg=%lld\n",
+		stat.min, stat.max, stat.sum / stat.real_cnt);
+}
+
+static int find_symbol(void *data, const char *name,
+		       struct module *mod, unsigned long addr)
+{
+	struct test_stat *stat = (struct test_stat *)data;
+
+	if (strcmp(name, stat->name) == 0) {
+		stat->real_cnt++;
+		stat->addr = addr;
+
+		if (stat->save_cnt < MAX_NUM_OF_RECORDS) {
+			stat->addrs[stat->save_cnt] = addr;
+			stat->save_cnt++;
+		}
+
+		if (stat->real_cnt == stat->max)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void test_perf_kallsyms_on_each_symbol(void)
+{
+	u64 t0, t1;
+	unsigned long flags;
+	struct test_stat stat;
+
+	memset(&stat, 0, sizeof(stat));
+	stat.max = INT_MAX;
+	stat.name = stub_name;
+	local_irq_save(flags);
+	t0 = sched_clock();
+	kallsyms_on_each_symbol(find_symbol, &stat);
+	t1 = sched_clock();
+	local_irq_restore(flags);
+	pr_info("kallsyms_on_each_symbol() traverse all: %lld ns\n", t1 - t0);
+}
+
+static int match_symbol(void *data, unsigned long addr)
+{
+	struct test_stat *stat = (struct test_stat *)data;
+
+	stat->real_cnt++;
+	stat->addr = addr;
+
+	if (stat->save_cnt < MAX_NUM_OF_RECORDS) {
+		stat->addrs[stat->save_cnt] = addr;
+		stat->save_cnt++;
+	}
+
+	if (stat->real_cnt == stat->max)
+		return 1;
+
+	return 0;
+}
+
+static void test_perf_kallsyms_on_each_match_symbol(void)
+{
+	u64 t0, t1;
+	unsigned long flags;
+	struct test_stat stat;
+
+	memset(&stat, 0, sizeof(stat));
+	stat.max = INT_MAX;
+	stat.name = stub_name;
+	local_irq_save(flags);
+	t0 = sched_clock();
+	kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
+	t1 = sched_clock();
+	local_irq_restore(flags);
+	pr_info("kallsyms_on_each_match_symbol() traverse all: %lld ns\n", t1 - t0);
+}
+
+static int test_kallsyms_basic_function(void)
+{
+	int i, j, ret;
+	int next = 0, nr_failed = 0;
+	char *prefix;
+	unsigned short rand;
+	unsigned long addr;
+	char namebuf[KSYM_NAME_LEN];
+	struct test_stat stat, stat1, stat2;
+
+	prefix = "kallsyms_lookup_name() for";
+	for (i = 0; i < ARRAY_SIZE(test_items); i++) {
+		addr = kallsyms_lookup_name(test_items[i].name);
+		if (addr != test_items[i].addr) {
+			nr_failed++;
+			pr_info("%s %s failed: addr=%lx, expect %lx\n",
+				prefix, test_items[i].name, addr, test_items[i].addr);
+		}
+	}
+
+	prefix = "kallsyms_on_each_symbol() for";
+	for (i = 0; i < ARRAY_SIZE(test_items); i++) {
+		memset(&stat, 0, sizeof(stat));
+		stat.max = INT_MAX;
+		stat.name = test_items[i].name;
+		kallsyms_on_each_symbol(find_symbol, &stat);
+		if (stat.addr != test_items[i].addr || stat.real_cnt != 1) {
+			nr_failed++;
+			pr_info("%s %s failed: count=%d, addr=%lx, expect %lx\n",
+				prefix, test_items[i].name,
+				stat.real_cnt, stat.addr, test_items[i].addr);
+		}
+	}
+
+	prefix = "kallsyms_on_each_match_symbol() for";
+	for (i = 0; i < ARRAY_SIZE(test_items); i++) {
+		memset(&stat, 0, sizeof(stat));
+		stat.max = INT_MAX;
+		stat.name = test_items[i].name;
+		kallsyms_on_each_match_symbol(match_symbol, test_items[i].name, &stat);
+		if (stat.addr != test_items[i].addr || stat.real_cnt != 1) {
+			nr_failed++;
+			pr_info("%s %s failed: count=%d, addr=%lx, expect %lx\n",
+				prefix, test_items[i].name,
+				stat.real_cnt, stat.addr, test_items[i].addr);
+		}
+	}
+
+	if (nr_failed)
+		return -EFAULT;
+
+	for (i = 0; i < kallsyms_num_syms; i++) {
+		addr = kallsyms_sym_address(i);
+		if (!is_ksym_addr(addr))
+			continue;
+
+		ret = lookup_symbol_name(addr, namebuf);
+		if (unlikely(ret)) {
+			namebuf[0] = 0;
+			goto failed;
+		}
+
+		stat.addr = kallsyms_lookup_name(namebuf);
+
+		memset(&stat1, 0, sizeof(stat1));
+		stat1.max = INT_MAX;
+		kallsyms_on_each_match_symbol(match_symbol, namebuf, &stat1);
+
+		/*
+		 * kallsyms_on_each_symbol() is too slow, randomly select some
+		 * symbols for test.
+		 */
+		if (i >= next) {
+			memset(&stat2, 0, sizeof(stat2));
+			stat2.max = INT_MAX;
+			stat2.name = namebuf;
+			kallsyms_on_each_symbol(find_symbol, &stat2);
+
+			/*
+			 * kallsyms_on_each_symbol() and kallsyms_on_each_match_symbol()
+			 * need to get the same traversal result.
+			 */
+			if (stat1.addr != stat2.addr ||
+			    stat1.real_cnt != stat2.real_cnt ||
+			    memcmp(stat1.addrs, stat2.addrs,
+				   stat1.save_cnt * sizeof(stat1.addrs[0])))
+				goto failed;
+
+			/*
+			 * The average of random increments is 128, that is, one of
+			 * them is tested every 128 symbols.
+			 */
+			get_random_bytes(&rand, sizeof(rand));
+			next = i + (rand & 0xff) + 1;
+		}
+
+		/* Need to be found at least once */
+		if (!stat1.real_cnt)
+			goto failed;
+
+		/*
+		 * kallsyms_lookup_name() returns the address of the first
+		 * symbol found and cannot be NULL.
+		 */
+		if (!stat.addr || stat.addr != stat1.addrs[0])
+			goto failed;
+
+		/*
+		 * If the addresses of all matching symbols are recorded, the
+		 * target address needs to be exist.
+		 */
+		if (stat1.real_cnt <= MAX_NUM_OF_RECORDS) {
+			for (j = 0; j < stat1.save_cnt; j++) {
+				if (stat1.addrs[j] == addr)
+					break;
+			}
+
+			if (j == stat1.save_cnt)
+				goto failed;
+		}
+	}
+
+	return 0;
+
+failed:
+	pr_info("Test for %dth symbol failed: (%s) addr=%lx", i, namebuf, addr);
+	return -EFAULT;
+}
+
+static int test_entry(void *p)
+{
+	int ret;
+
+	do {
+		schedule_timeout(5 * HZ);
+	} while (system_state != SYSTEM_RUNNING);
+
+	pr_info("start\n");
+	ret = test_kallsyms_basic_function();
+	if (ret) {
+		pr_info("abort\n");
+		return ret;
+	}
+
+	test_kallsyms_compression_ratio();
+	test_perf_kallsyms_lookup_name();
+	test_perf_kallsyms_on_each_symbol();
+	test_perf_kallsyms_on_each_match_symbol();
+	pr_info("finish\n");
+
+	return 0;
+}
+
+static int __init kallsyms_test_init(void)
+{
+	struct task_struct *t;
+
+	t = kthread_create(test_entry, NULL, "kallsyms_test");
+	if (IS_ERR(t)) {
+		pr_info("Create kallsyms selftest task failed\n");
+		return PTR_ERR(t);
+	}
+	kthread_bind(t, 0);
+	wake_up_process(t);
+
+	return 0;
+}
+late_initcall(kallsyms_test_init);
-- 
2.25.1

