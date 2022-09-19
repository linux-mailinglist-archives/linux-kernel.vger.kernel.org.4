Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD365BCB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiISMIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiISMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:08:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916402B25B;
        Mon, 19 Sep 2022 05:08:02 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MWNg512lbzHnxJ;
        Mon, 19 Sep 2022 20:05:53 +0800 (CST)
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
Subject: [RFC PATCH 4/6] crypto: benchmark - add help information
Date:   Mon, 19 Sep 2022 20:05:35 +0800
Message-ID: <20220919120537.39258-5-shenyang39@huawei.com>
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

Add a new module parameters 'help' to make users understand the benchmark
module parameters. And due to the algorithms have different notes, add
a new callback 'help' to show the differences.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 crypto/benchmark/benchmark.c | 79 ++++++++++++++++++++++++++++++++++++
 crypto/benchmark/bm_comp.c   | 10 +++++
 crypto/benchmark/bm_comp.h   |  1 +
 3 files changed, 90 insertions(+)

diff --git a/crypto/benchmark/benchmark.c b/crypto/benchmark/benchmark.c
index b5dcf5829b22..a3ccd8955eaa 100644
--- a/crypto/benchmark/benchmark.c
+++ b/crypto/benchmark/benchmark.c
@@ -32,6 +32,12 @@ struct crypto_bm_alg_ops {
 	int (*create_req)(struct crypto_bm_base *base, u32 idx);
 	void (*release_req)(struct crypto_bm_base *base, u32 idx);
 	int (*perf)(struct crypto_bm_thread_data *data);
+	void (*help)(void);
+};
+
+struct crypto_bm_mp_info {
+	const char *mp;
+	const char *help_info;
 };
 
 struct {
@@ -51,6 +57,9 @@ struct {
 #define threadnum_desc		"Testing thread number, one 'crypto_tfm' per thread. 0/1 (default 1 thread), 2(2 threads) ..."
 #define time_desc		"Testing time, the unit is second, 0/1 (default 1 s), 2(2 s) ..."
 #define run_desc		"Start/stop all the tests based on the configuration, 0(default, not run, stop), or run"
+#define help_desc		"Some help information. Echo a module parameter can get the info " \
+				"of module parameter. Cat 'help' directly can get the help "\
+				"information provided by 'algtype'."
 
 static atomic_t benchmark_status;
 
@@ -75,11 +84,47 @@ static struct crypto_bm_alg_ops benchmark_ops[] = {
 		.create_req	= crypto_bm_create_req_comp,
 		.release_req	= crypto_bm_release_req_comp,
 		.perf		= crypto_bm_perf_comp,
+		.help		= crypto_bm_help_comp,
 	}, {
 		/* sentinel */
 	}
 };
 
+static struct crypto_bm_mp_info modules_help[] = {
+	{
+		.mp		= "algorithm",
+		.help_info	= "Please input a crypto supported algorithm name.\n"
+				  "The algorithm name can be found on /proc/crypto.",
+	}, {
+		.mp		= "algtype",
+		.help_info	= "Please input a valid value to choose algorithm class.\n"
+				  "0: CRYPTO_BM_COMP",
+	}, {
+		.mp		= "inputsize",
+		.help_info	= "Please input a valid value as testing input size.",
+	}, {
+		.mp		= "loop",
+		.help_info	= "Please input the send loop times.",
+	}, {
+		.mp		= "numamask",
+		.help_info	= "Please input a bitmap as testing numa nodes.",
+	}, {
+		.mp		= "optype",
+		.help_info	= "Please input a valid value for testing operation.\n"
+				  "Can get the algorithm type support optype by cat 'help'."
+	}, {
+		.mp		= "reqnum",
+		.help_info	= "Please input a valid value for per thread request number.",
+	}, {
+		.mp		= "threadnum",
+		.help_info	= "Please input a valid value for creating threads.\n"
+				  "One thread will create a crypto_tfm.",
+	}, {
+		.mp		= "time",
+		.help_info	= "Please input a valid value for testing time.",
+	}
+};
+
 static int crypto_bm_algorithm_param_set(const char *val, const struct kernel_param *kp)
 {
 	char *s = strstrip((char *)val);
@@ -103,6 +148,40 @@ static const struct kernel_param_ops alg_ops = {
 module_param_cb(algorithm, &alg_ops, &benchmark_attrs.algorithm, 0644);
 MODULE_PARM_DESC(algorithm, algorithm_desc);
 
+static int crypto_bm_help_param_set(const char *val, const struct kernel_param *kp)
+{
+	int size = ARRAY_SIZE(modules_help);
+	char *s = strstrip((char *)val);
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (!strcmp(s, modules_help[i].mp))
+			pr_err("%s\n", modules_help[i].help_info);
+	}
+
+	return 0;
+}
+
+static int crypto_bm_help_param_get(char *val, const struct kernel_param *kp)
+{
+	u32 idx = benchmark_attrs.algtype;
+
+	if (idx >= CRYPTO_BM_ALG_MAX)
+		return -EINVAL;
+
+	benchmark_ops[idx].help();
+
+	return 0;
+}
+
+static const struct kernel_param_ops help_ops = {
+	.set = crypto_bm_help_param_set,
+	.get = crypto_bm_help_param_get,
+};
+
+module_param_cb(help, &help_ops, NULL, 0644);
+MODULE_PARM_DESC(help, help_desc);
+
 static int crypto_bm_numamask_param_set(const char *val, const struct kernel_param *kp)
 {
 	if (atomic_read(&benchmark_status))
diff --git a/crypto/benchmark/bm_comp.c b/crypto/benchmark/bm_comp.c
index 2772a8e86e2e..62192a55b2ab 100644
--- a/crypto/benchmark/bm_comp.c
+++ b/crypto/benchmark/bm_comp.c
@@ -423,3 +423,13 @@ int crypto_bm_perf_comp(struct crypto_bm_thread_data *data)
 
 	return ret;
 }
+
+void crypto_bm_help_comp(void)
+{
+	pr_err("Welcome to use the crypto benchmark to test compress algorithm!\n"
+	       "There ars some different moduel parameters requirement:\n"
+	       "optype: 0 for compression, 1 for decompression\n"
+	       "inputsize: for compression, the inputsize is src_len,\n"
+	       "           for decompression, the inputsize is dst_len, and the src_len will depend on the data compression ratio.\n"
+	       );
+}
diff --git a/crypto/benchmark/bm_comp.h b/crypto/benchmark/bm_comp.h
index 78b45f8b22a6..aedafde2c3ad 100644
--- a/crypto/benchmark/bm_comp.h
+++ b/crypto/benchmark/bm_comp.h
@@ -14,5 +14,6 @@ void crypto_bm_release_tfm_comp(struct crypto_bm_base *base, u32 idx);
 int crypto_bm_create_req_comp(struct crypto_bm_base *base, u32 idx);
 void crypto_bm_release_req_comp(struct crypto_bm_base *base, u32 idx);
 int crypto_bm_perf_comp(struct crypto_bm_thread_data *data);
+void crypto_bm_help_comp(void);
 
 #endif
-- 
2.24.0

