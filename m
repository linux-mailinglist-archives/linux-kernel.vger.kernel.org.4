Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7605BCB78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiISMIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiISMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:08:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D8628726;
        Mon, 19 Sep 2022 05:08:02 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWNcq5LY0zlW26;
        Mon, 19 Sep 2022 20:03:55 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 2/6] crypto: benchmark - add a crypto benchmark tool
Date:   Mon, 19 Sep 2022 20:05:33 +0800
Message-ID: <20220919120537.39258-3-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20220919120537.39258-1-shenyang39@huawei.com>
References: <20220919120537.39258-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a crypto benchmark to help the developer quickly get the
performance of a algorithm registered in crypto.

Due to the crypto algorithms have multifarious parameters, the tool
cannot support all test scenes. In order to provide users with simple
and easy-to-use tools and support as many test scenarios as possible,
benchmark refers to the crypto method to provide a unified struct
'crypto_bm_ops'. And the algorithm registers its own callbacks to parse
the user's input. In crypto, a algorithm class has multiple algorithms,
but all of them uses the same API. So in the benchmark, a algorithm
class uses the same 'ops' and distinguish specific algorithm by name.

First, consider the performance calculation model. Considering the
crypto subsystem model, a reasonable process code based on crypto api
should create a numa node based 'crypto_tfm' in advance and apply for
a certain amount of 'crypto_req' according to their own business.
In the real business processing stage, the thread send tasks based on
'crypto_req' and wait for completion.

Therefore, the benchmark will create 'crypto_tfm' and 'crypto_req' at
first, and then count all requests time to calculate performance.
So the result is the pure algorithm performance. When each algorithm
class implements its own 'ops', it needs to pay attention to the content
completed in the callback. Before the 'ops.perf', the tool had better
prepare the request data set. And in order to avoid the false high
performance of the algorithm caused by the false cache and TLB hit rate,
the size of data set should be larger than 'crypto_req' number.
The 'crypto_bm_ops' has following api:
 - init & uninit
 The initialize related functions. Algorithm can do some private setting.
 - create_tfm & release_tfm
 The 'crypto_tfm' related functions. Algorithm has different tfm name in
 crypto. But they both has a member named tfm, so use tfm to stand for
 algorithm handle. The benchmark has provides the tfm array.
 - create_req & release_req
 The 'crypto_req' related functions. The callbacks should create a 'reqnum'
 'crypto_req' group in struct 'crypto_bm_base'. And the also suggest
 prepare the request data in this function. In order to avoid the false
 high performance of the algorithm caused by the false cache and TLB hit
 rate, the size of data set should be larger than 'crypto_req' number.
 - perf
 The request sending functions. The registrant should use parameter 'loop'
 to send requests repeatly. And update the count in struct
 'crypto_bm_thread_data'.

Then consider the parameters that user can configure. Generally speaking,
the following parameters will affect the performance of the algorithm:
tfm number, request number, block size, numa node. And some parameters
will affect the stability of performance: testing time and requests sent
number. To sum up, the benchmark has following parameters:
 - algorithm
 The testing algorithm name. Showed in /proc/crypto.
 - algtype
 The testing algorithm class. Can get the algorithm class by echo 'algtype'
 to /sys/module/crypto_benchmark/parameters/help.
 - inputsize
 The testing length that can greatly impact performance. Such as data size
 for compress or key length for encryption.
 - loop
 The testing loop times. Avoid performance fluctuations caused by
 environment.
 - numamask
 The testing bind numamask. Used for allocate memory, create threads and
 create 'crypto_tfm'.
 - optype
 The testing algorithm operation type. Can get the algorithm available
 operation types by cat /sys/module/crypto_benchmark/parameters/help
 with specified 'algtype'.
 - reqnum
 The testing request number for per tfm. Used for test asynchrony api
 performance.
 - threadnum
 The testing thread number. To simplify model, create a 'crypto_tfm' per
 thread.
 - time
 The testing time. Used for stop the test thread.
 - run
 Start or stop the test.

Users can configure parameters under
/sys/modules/crypto_benchmark/parameters/.
Then echo 1 to 'run' to start the test. And if they want to stop the
test, just echo 0 to 'run'.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 crypto/Kconfig               |   2 +
 crypto/Makefile              |   5 +
 crypto/benchmark/Kconfig     |  11 +
 crypto/benchmark/Makefile    |   3 +
 crypto/benchmark/benchmark.c | 509 +++++++++++++++++++++++++++++++++++
 crypto/benchmark/benchmark.h |  76 ++++++
 6 files changed, 606 insertions(+)
 create mode 100644 crypto/benchmark/Kconfig
 create mode 100644 crypto/benchmark/Makefile
 create mode 100644 crypto/benchmark/benchmark.c
 create mode 100644 crypto/benchmark/benchmark.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 40423a14f86f..a0f618f349fc 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1438,4 +1438,6 @@ source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"

+source "crypto/benchmark/Kconfig"
+
 endif	# if CRYPTO
diff --git a/crypto/Makefile b/crypto/Makefile
index a6f94e04e1da..67edf4e1337c 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -212,3 +212,8 @@ obj-$(CONFIG_CRYPTO_SIMD) += crypto_simd.o
 # Key derivation function
 #
 obj-$(CONFIG_CRYPTO_KDF800108_CTR) += kdf_sp800108.o
+
+#
+# crypto benchmark
+#
+obj-y += benchmark/
diff --git a/crypto/benchmark/Kconfig b/crypto/benchmark/Kconfig
new file mode 100644
index 000000000000..abee14ba8e40
--- /dev/null
+++ b/crypto/benchmark/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config CRYPTO_BENCHMARK
+	bool "Testing performance of crypto algorithms"
+	depends on CRYPTO
+	help
+	  This option support test crypto async api performance.
+	  Select this if you want to test crypto algorithms performance
+	  conveniently.
+	  Before use it, you should check whether the algorithm class is
+	  supported.
diff --git a/crypto/benchmark/Makefile b/crypto/benchmark/Makefile
new file mode 100644
index 000000000000..5244178e14c4
--- /dev/null
+++ b/crypto/benchmark/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_BENCHMARK) += crypto_benchmark.o
+crypto_benchmark-objs += benchmark.o
diff --git a/crypto/benchmark/benchmark.c b/crypto/benchmark/benchmark.c
new file mode 100644
index 000000000000..9a833b277d87
--- /dev/null
+++ b/crypto/benchmark/benchmark.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 HiSilicon Limited.
+ */
+#include <linux/crypto.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/kthread.h>
+#include <linux/string.h>
+#include <linux/wait.h>
+
+#include "benchmark.h"
+
+enum crypto_bm_status {
+	CRYPTO_BM_STOP,
+	CRYPTO_BM_RUN,
+};
+
+enum crypto_bm_alg {
+	CRYPTO_BM_ALG_MAX,
+};
+
+struct crypto_bm_alg_ops {
+	const char *alg;
+	int (*init)(struct crypto_bm_base *base);
+	void (*uninit)(struct crypto_bm_base *base);
+	int (*create_tfm)(struct crypto_bm_base *base, u32 idx);
+	void (*release_tfm)(struct crypto_bm_base *base, u32 idx);
+	int (*create_req)(struct crypto_bm_base *base, u32 idx);
+	void (*release_req)(struct crypto_bm_base *base, u32 idx);
+	int (*perf)(struct crypto_bm_thread_data *data);
+};
+
+struct {
+	wait_queue_head_t wq;
+	atomic_t count;
+} crypto_bm_wq = { 0 };
+
+#define CRYPTO_BM_THREAD_MAX	1024U
+
+#define algorithm_desc		"Testing algorithm name"
+#define algtype_desc		"Testing algorithm type, according to enum crypto_bm_alg"
+#define inputsize_desc		"Testing input size"
+#define loop_desc		"Testing loop times, the unit is kile, 0/1(default, 1 ktimes), 2(2 ktimes) ..."
+#define numamask_desc		"Testing bind numamask, 0(default, not bind), 1(bind to node 0), 3(bind to node0 and node1) ..."
+#define optype_desc		"Testing algorithm operation type 0 && 1: 0(default, compress/encipher), 1(decompress/decipher)"
+#define reqnum_desc		"Testing request number for per tfm, 0/1 (default 1 request), 2(2 requests) ..."
+#define threadnum_desc		"Testing thread number, one 'crypto_tfm' per thread. 0/1 (default 1 thread), 2(2 threads) ..."
+#define time_desc		"Testing time, the unit is second, 0/1 (default 1 s), 2(2 s) ..."
+#define run_desc		"Start/stop all the tests based on the configuration, 0(default, not run, stop), or run"
+
+static atomic_t benchmark_status;
+
+static struct crypto_bm_attrs benchmark_attrs = { 0 };
+
+static struct crypto_bm_base benchmark_base = {
+	.attrs = &benchmark_attrs,
+};
+
+static struct crypto_bm_thread_data thread_data[CRYPTO_BM_THREAD_MAX] = { 0 };
+
+static struct task_struct *crypto_bm_perf[CRYPTO_BM_THREAD_MAX] = { NULL };
+static struct task_struct *test_thread;
+
+static struct crypto_bm_alg_ops benchmark_ops[] = {
+	{
+		/* sentinel */
+	}
+};
+
+static int crypto_bm_algorithm_param_set(const char *val, const struct kernel_param *kp)
+{
+	char *s = strstrip((char *)val);
+
+	if (atomic_read(&benchmark_status))
+		return -EBUSY;
+
+	if (!crypto_has_alg(s, 0, 0)) {
+		pr_err("failed to find the algorithm %s\n", s);
+		return -EINVAL;
+	}
+
+	return param_set_charp(s, kp);
+}
+
+static const struct kernel_param_ops alg_ops = {
+	.set = crypto_bm_algorithm_param_set,
+	.get = param_get_charp,
+};
+
+module_param_cb(algorithm, &alg_ops, &benchmark_attrs.algorithm, 0644);
+MODULE_PARM_DESC(algorithm, algorithm_desc);
+
+static int crypto_bm_numamask_param_set(const char *val, const struct kernel_param *kp)
+{
+	if (atomic_read(&benchmark_status))
+		return -EBUSY;
+
+	return param_set_hexulong(val, kp);
+}
+
+static const struct kernel_param_ops numamask_ops = {
+	.set = crypto_bm_numamask_param_set,
+	.get = param_get_hexulong,
+};
+
+module_param_cb(numamask, &numamask_ops, &benchmark_attrs.numamask, 0644);
+MODULE_PARM_DESC(numamask, numamask_desc);
+
+#define MODULE_PARAMETER_DEF(xxx) \
+static int xxx##_set(const char *val, const struct kernel_param *kp) \
+{ \
+	u32 n; \
+	int ret; \
+	if (atomic_read(&benchmark_status)) \
+		return -EBUSY; \
+	ret = kstrtou32(val, 10, &n); \
+	if (ret != 0) \
+		return -EINVAL; \
+	return param_set_uint(val, kp); \
+} \
+static const struct kernel_param_ops xxx##_ops = { \
+	.set = xxx##_set, \
+	.get = param_get_uint \
+}; \
+module_param_cb(xxx, &xxx##_ops, &benchmark_attrs.xxx, 0644); \
+MODULE_PARM_DESC(xxx, xxx##_desc)
+
+MODULE_PARAMETER_DEF(algtype);
+MODULE_PARAMETER_DEF(inputsize);
+MODULE_PARAMETER_DEF(loop);
+MODULE_PARAMETER_DEF(optype);
+MODULE_PARAMETER_DEF(reqnum);
+MODULE_PARAMETER_DEF(threadnum);
+MODULE_PARAMETER_DEF(time);
+
+static int crypto_bm_check_params(struct crypto_bm_attrs *attrs)
+{
+	if (attrs->algorithm == NULL) {
+		pr_err("algorithm is NULL\n");
+		return -EINVAL;
+	}
+
+	if (attrs->algtype >= CRYPTO_BM_ALG_MAX) {
+		pr_err("algorithm type %d is invalid\n", attrs->algtype);
+		return -EINVAL;
+	}
+
+	if (attrs->inputsize == 0) {
+		pr_err("input size is 0\n");
+		return -EINVAL;
+	}
+
+	if (attrs->threadnum >= CRYPTO_BM_THREAD_MAX) {
+		pr_err("thread number is bigger than %u\n", CRYPTO_BM_THREAD_MAX);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void crypto_bm_set_default_params(struct crypto_bm_attrs *attrs)
+{
+	attrs->loop = (attrs->loop == 0) ? 1 : attrs->loop;
+	attrs->reqnum = (attrs->reqnum == 0) ? 1 : attrs->reqnum;
+	attrs->threadnum = (attrs->threadnum == 0) ? 1 : attrs->threadnum;
+	attrs->time = (attrs->time == 0) ? 1 : attrs->time;
+}
+
+static int crypto_bm_init_alg(struct crypto_bm_base *base)
+{
+	u32 idx = base->attrs->algtype;
+
+	return benchmark_ops[idx].init(base);
+}
+
+static void crypto_bm_uninit_alg(struct crypto_bm_base *base)
+{
+	u32 idx = base->attrs->algtype;
+
+	benchmark_ops[idx].uninit(base);
+}
+
+static int crypto_bm_create_tfm(struct crypto_bm_base *base)
+{
+	struct crypto_bm_attrs *attrs = base->attrs;
+	int i, ret, nodes, sbit, count = 0;
+	u32 threadnum = attrs->threadnum;
+	u32 threadpernode, threadrest;
+	u32 idx = attrs->algtype;
+
+	base->gthread = kcalloc(threadnum, sizeof(*base->gthread), GFP_KERNEL);
+	if (!base->gthread)
+		return -ENOMEM;
+
+	nodes = bitmap_weight(&attrs->numamask, MAX_NUMNODES);
+
+	if (nodes == 0) {
+		for (i = 0; i < threadnum; i++) {
+			base->gthread[i].id = i;
+			base->gthread[i].node = NUMA_NO_NODE;
+			ret = benchmark_ops[idx].create_tfm(base, i);
+			if (ret)
+				goto out_free_tfm;
+		}
+	} else {
+		threadpernode = threadnum / nodes;
+		threadrest = threadnum % nodes;
+		for_each_set_bit(sbit, (unsigned long *)&attrs->numamask, MAX_NUMNODES) {
+			int start = count * threadpernode;
+			int end = (count + 1) * threadpernode;
+
+			end += (++count == nodes) ? threadrest : 0;
+			for (i = start; i < end; i++) {
+				base->gthread[i].id = i;
+				base->gthread[i].node = sbit;
+				ret = benchmark_ops[idx].create_tfm(base, i);
+				if (ret)
+					goto out_free_tfm;
+			}
+		}
+	}
+
+	return 0;
+
+out_free_tfm:
+	for (i--; i >= 0; i--)
+		benchmark_ops[idx].release_tfm(base, i);
+
+	kfree(base->gthread);
+
+	return ret;
+}
+
+static void crypto_bm_release_tfm(struct crypto_bm_base *base)
+{
+	u32 threadnum = base->attrs->threadnum;
+	u32 idx = base->attrs->algtype;
+	int i;
+
+	for (i = 0; i < threadnum; i++)
+		benchmark_ops[idx].release_tfm(base, i);
+
+	kfree(base->gthread);
+}
+
+static int crypto_bm_create_req(struct crypto_bm_base *base)
+{
+	u32 threadnum = base->attrs->threadnum;
+	u32 idx = base->attrs->algtype;
+	int i, ret;
+
+	for (i = 0; i < threadnum; i++) {
+		ret = benchmark_ops[idx].create_req(base, i);
+		if (ret)
+			goto out_release_req;
+	}
+
+	return 0;
+
+out_release_req:
+	for (i--; i >= 0 ; i--)
+		benchmark_ops[idx].release_req(base, i);
+
+	return ret;
+}
+
+static void crypto_bm_release_req(struct crypto_bm_base *base)
+{
+	u32 threadnum = base->attrs->threadnum;
+	u32 idx = base->attrs->algtype;
+	int i;
+
+	for (i = 0; i < threadnum; i++)
+		benchmark_ops[idx].release_req(base, i);
+}
+
+static int crypto_bm_test_perf(void *data)
+{
+	struct crypto_bm_thread_data *tdata = data;
+	struct crypto_bm_base *base = tdata->base;
+	struct crypto_bm_attrs *attrs = base->attrs;
+	unsigned long endtime = jiffies + attrs->time * HZ;
+	u32 idx = attrs->algtype;
+	int ret;
+
+	do {
+		if (kthread_should_stop())
+			break;
+
+		if (time_after(jiffies, endtime))
+			break;
+
+		ret = benchmark_ops[idx].perf(tdata);
+		if (ret)
+			break;
+	} while (1);
+
+	crypto_bm_perf[tdata->threadid] = NULL;
+	atomic_dec(&crypto_bm_wq.count);
+	wake_up(&crypto_bm_wq.wq);
+
+	return ret;
+}
+
+static void crypto_bm_show_perf(u64 time)
+{
+	u32 threadnum = benchmark_attrs.threadnum;
+	u32 inputsize = benchmark_attrs.inputsize;
+	u64 throughput, pps, reqsum = 0;
+	int i;
+
+	for (i = 0; i < threadnum; i++)
+		reqsum += atomic_read(&thread_data[i].count.recv_req);
+
+	/*
+	 *               reqsum * inputsize (bytes) / (1024 * 1024)
+	 * throughput = -------------------------------------------- (MB/s)
+	 *                          time (ns) / 1000000000
+	 */
+	throughput = reqsum * inputsize * 953 / (time);
+
+	/*
+	 *          reqsum / 1024
+	 * pps = -------------------
+	 *        time / 1000000000
+	 */
+	pps = reqsum * 976562 / (time);
+
+	pr_err("Crypto benchmark result:\n"
+	       "\t throughput \t pps \t\t time\n"
+	       "\t %llu MB/s \t %llu kPP/s \t %llu ms\n",
+	       throughput, pps, time / 1000000);
+}
+
+static int crypto_bm_test(void *data)
+{
+	struct crypto_bm_base *base = data;
+	u32 threadnum = base->attrs->threadnum;
+	struct timespec64 begin, end;
+	int i, ret, node;
+
+	init_waitqueue_head(&crypto_bm_wq.wq);
+	atomic_set(&crypto_bm_wq.count, threadnum);
+
+	memset(crypto_bm_perf, 0, sizeof(*crypto_bm_perf) * threadnum);
+
+	ret = crypto_bm_init_alg(base);
+	if (ret)
+		goto out_set_stop;
+
+	ret = crypto_bm_create_tfm(base);
+	if (ret)
+		goto out_uninit;
+
+	ret = crypto_bm_create_req(base);
+	if (ret)
+		goto out_free_tfm;
+
+
+	for (i = 0; i < threadnum; i++) {
+		node = base->gthread[i].node;
+		thread_data[i].threadid = i;
+		thread_data[i].base = base;
+		memset(&thread_data[i].count, 0, sizeof(thread_data[i].count));
+		crypto_bm_perf[i] = kthread_create_on_node(crypto_bm_test_perf, &thread_data[i],
+							   node, "crypto_bm_perf-%d", i);
+		if (IS_ERR(crypto_bm_perf[i])) {
+			ret = PTR_ERR(crypto_bm_perf[i]);
+			crypto_bm_perf[i] = NULL;
+			pr_err("failed to create %dth performance thread, ret = %d\n", i, ret);
+			goto out_stop_thread;
+		}
+		kthread_bind_mask(crypto_bm_perf[i], cpumask_of_node(node));
+	}
+	i = 0;
+
+	ktime_get_real_ts64(&begin);
+	for (i = 0; i < threadnum; i++)
+		wake_up_process(crypto_bm_perf[i]);
+	wait_event_interruptible(crypto_bm_wq.wq, atomic_read(&crypto_bm_wq.count) == 0);
+	ktime_get_real_ts64(&end);
+
+	crypto_bm_show_perf(timespec64_to_ns(&end) - timespec64_to_ns(&begin));
+
+out_stop_thread:
+	for (i--; i >= 0; i--) {
+		if (!crypto_bm_perf[i])
+			continue;
+		kthread_stop(crypto_bm_perf[i]);
+		crypto_bm_perf[i] = NULL;
+	}
+
+	crypto_bm_release_req(base);
+
+out_free_tfm:
+	crypto_bm_release_tfm(base);
+
+out_uninit:
+	crypto_bm_uninit_alg(base);
+
+out_set_stop:
+	atomic_set(&benchmark_status, CRYPTO_BM_STOP);
+	test_thread = NULL;
+
+	return ret;
+}
+
+static int crypto_bm_start_test(struct crypto_bm_base *base)
+{
+	int ret = 0;
+
+	if (atomic_cmpxchg(&benchmark_status, CRYPTO_BM_STOP, CRYPTO_BM_RUN)) {
+		pr_err("Crypto benchmark is busy now, please try later!\n");
+		return -EBUSY;
+	}
+
+	test_thread = kthread_run(crypto_bm_test, base, "crypto_bm_test");
+	if (IS_ERR(test_thread))
+		ret = PTR_ERR(test_thread);
+
+	return ret;
+}
+
+static void crypto_bm_stop_test(void)
+{
+	u32 threadnum = benchmark_attrs.threadnum;
+	int i, ret;
+
+	if (!atomic_read(&benchmark_status))
+		return;
+
+	for (i = 0; i < threadnum; i++) {
+		if (!crypto_bm_perf[i])
+			continue;
+		ret = kthread_stop(crypto_bm_perf[i]);
+		if (ret)
+			pr_err("failed to stop %dth performance thread, ret = %d\n", i, ret);
+		crypto_bm_perf[i] = NULL;
+	}
+
+	if (test_thread) {
+		ret = kthread_stop(test_thread);
+		if (ret)
+			pr_err("failed to stop test thread, ret = %d\n", ret);
+	}
+
+	atomic_set(&benchmark_status, CRYPTO_BM_STOP);
+}
+
+static int run_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	u32 n;
+
+	ret = kstrtou32(val, 10, &n);
+	if (ret != 0)
+		return -EINVAL;
+
+	if (n == 0) {
+		crypto_bm_stop_test();
+	} else {
+		ret = crypto_bm_check_params(&benchmark_attrs);
+		if (ret)
+			return ret;
+
+		crypto_bm_set_default_params(&benchmark_attrs);
+
+		ret = crypto_bm_start_test(&benchmark_base);
+		if (ret) {
+			pr_err("failed to start test, ret = %d\n", ret);
+			return ret;
+		}
+		pr_info("run set: algorithm %s, algtype %s, inputsize %d, loop %d, numamask 0x%lx, optype %d, reqnum %d, threadnum %d, time %d.\n",
+			benchmark_attrs.algorithm, benchmark_ops[benchmark_attrs.algtype].alg,
+			benchmark_attrs.inputsize, benchmark_attrs.loop, benchmark_attrs.numamask,
+			benchmark_attrs.optype, benchmark_attrs.reqnum, benchmark_attrs.threadnum,
+			benchmark_attrs.time);
+	}
+
+	return param_set_int(val, kp);
+}
+
+static const struct kernel_param_ops run_ops = {
+	.set = run_set,
+	.get = param_get_uint,
+};
+
+static u32 run;
+module_param_cb(run, &run_ops, &run, 0644);
+MODULE_PARM_DESC(run, run_desc);
+
+static int __init crypto_bm_init(void)
+{
+	atomic_set(&benchmark_status, CRYPTO_BM_STOP);
+
+	return 0;
+}
+
+static void __exit crypto_bm_exit(void)
+{
+}
+
+module_init(crypto_bm_init);
+module_exit(crypto_bm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for testing performance of crypto algorithms");
diff --git a/crypto/benchmark/benchmark.h b/crypto/benchmark/benchmark.h
new file mode 100644
index 000000000000..84cb49af81ba
--- /dev/null
+++ b/crypto/benchmark/benchmark.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 HiSilicon Limited.
+ */
+#ifndef CRYPTO_BM_H
+#define CRYPTO_BM_H
+
+#include <linux/crypto.h>
+#include <linux/errno.h>
+#include <linux/find.h>
+#include <linux/gfp.h>
+#include <linux/nodemask.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+
+/**
+ * struct crypto_bm_attrs - crypto benchmark attributes configured by users.
+ *
+ * @algorithm:	The algorithm name registered in crypto.
+ * @algtype:	The algorithm class list in enum crypto_bm_alg. Used to
+ *		choose the crypto_bm_ops.
+ * @inputsize:	The testing length that can greatly impact performance.
+ *		Such as data size for compress or key length for encryption.
+ * @loop:	The request sending loop times. The value is 1000 times
+ *		of user's setting.
+ * @numamask:	The mask of testing bind numa nodes.
+ * @optype:	The algorithm test operation. Defined by the algorithm self.
+ * @reqnum:	The crypto request number of a tfm.
+ * @threadnum:	The test thread number. And it is equal to tfm number.
+ * @time:	The testing time.
+ */
+struct crypto_bm_attrs {
+	char *algorithm;
+	u32 algtype;
+	u32 inputsize;
+	u32 loop;
+	unsigned long numamask;
+	u32 optype;
+	u32 reqnum;
+	u32 threadnum;
+	u32 time;
+};
+
+/**
+ * struct crypto_bm_base - crypto benchmark test objects.
+ *
+ * @attrs:	The test configuration.
+ * @gthread:	A array storing resources related to the test thread.
+ */
+struct crypto_bm_base {
+	struct crypto_bm_attrs *attrs;
+	struct {
+		u32 id;
+		int node;
+		void *tfm;
+		void **req;
+	} *gthread;
+};
+
+/**
+ * struct crypto_bm_thread_data - crypto benchmark test thread common information.
+ *
+ * @threadid:	The test thread number.
+ * @count:	Count the thread test request numbers.
+ * @base:	crypto benchmark test objects.
+ */
+struct crypto_bm_thread_data {
+	int threadid;
+	struct {
+		atomic_t send_req;
+		atomic_t recv_req;
+	} count;
+	struct crypto_bm_base *base;
+} ____cacheline_aligned;
+
+#endif
--
2.24.0
