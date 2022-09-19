Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD965BCB79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiISMI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiISMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:08:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367782AC43;
        Mon, 19 Sep 2022 05:08:02 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWNc839tQzMn3F;
        Mon, 19 Sep 2022 20:03:20 +0800 (CST)
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
Subject: [RFC PATCH 3/6] crytpo: benchmark - support compression/decompresssion
Date:   Mon, 19 Sep 2022 20:05:34 +0800
Message-ID: <20220919120537.39258-4-shenyang39@huawei.com>
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

Register compression algorithms to crypto benchmark. Users can echo 0 to
'algtype' to appoint the compression/decompression.

Due to the compression protocol, the tool cannot set the compressed
data length to 'inputsize'. So in this algorithm class, the 'inputsize'
is used as origin data size in decompression.

To avoid the false high performance of the algorithm caused by the false
cache and TLB hit rate, the size of data set is four times of crypto_req
number at most.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 crypto/benchmark/Makefile    |   2 +-
 crypto/benchmark/benchmark.c |  11 +
 crypto/benchmark/bm_comp.c   | 425 +++++++++++++++++++++++++++++++++++
 crypto/benchmark/bm_comp.h   |  18 ++
 4 files changed, 455 insertions(+), 1 deletion(-)
 create mode 100644 crypto/benchmark/bm_comp.c
 create mode 100644 crypto/benchmark/bm_comp.h

diff --git a/crypto/benchmark/Makefile b/crypto/benchmark/Makefile
index 5244178e14c4..f638535442ba 100644
--- a/crypto/benchmark/Makefile
+++ b/crypto/benchmark/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_BENCHMARK) += crypto_benchmark.o
-crypto_benchmark-objs += benchmark.o
+crypto_benchmark-objs += benchmark.o bm_comp.o
diff --git a/crypto/benchmark/benchmark.c b/crypto/benchmark/benchmark.c
index 9a833b277d87..b5dcf5829b22 100644
--- a/crypto/benchmark/benchmark.c
+++ b/crypto/benchmark/benchmark.c
@@ -11,6 +11,7 @@
 #include <linux/wait.h>

 #include "benchmark.h"
+#include "bm_comp.h"

 enum crypto_bm_status {
 	CRYPTO_BM_STOP,
@@ -18,6 +19,7 @@ enum crypto_bm_status {
 };

 enum crypto_bm_alg {
+	CRYPTO_BM_COMP,
 	CRYPTO_BM_ALG_MAX,
 };

@@ -65,6 +67,15 @@ static struct task_struct *test_thread;

 static struct crypto_bm_alg_ops benchmark_ops[] = {
 	{
+		.alg		= "CRYPTO_COMPRESS",
+		.init		= crypto_bm_init_comp,
+		.uninit		= crypto_bm_uninit_comp,
+		.create_tfm	= crypto_bm_create_tfm_comp,
+		.release_tfm	= crypto_bm_release_tfm_comp,
+		.create_req	= crypto_bm_create_req_comp,
+		.release_req	= crypto_bm_release_req_comp,
+		.perf		= crypto_bm_perf_comp,
+	}, {
 		/* sentinel */
 	}
 };
diff --git a/crypto/benchmark/bm_comp.c b/crypto/benchmark/bm_comp.c
new file mode 100644
index 000000000000..2772a8e86e2e
--- /dev/null
+++ b/crypto/benchmark/bm_comp.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 HiSilicon Limited.
+ */
+#include <linux/scatterlist.h>
+#include <crypto/acompress.h>
+
+#include "benchmark.h"
+#include "bm_comp.h"
+
+#define COMP_BUF_SIZE		1024
+#define REQ_NUM			1024
+#define DATAPERREQ		4
+
+enum crypto_bm_comp_optype {
+	CRYPTO_BM_COMPRESS,
+	CRYPTO_BM_DECOMPRESS,
+	CRYPTO_BM_OPS_MAX,
+};
+
+struct crypto_bm_comp_buffer {
+	void *input;
+	void *output;
+	struct scatterlist *src;
+	struct scatterlist *dst;
+};
+
+struct crypto_bm_comp_cb_data {
+	atomic_t is_used;
+	struct crypto_bm_thread_data *tdata;
+};
+
+struct crypto_bm_comp_data {
+	u32 input_size;
+	u32 output_size;
+	u32 last_used;
+	struct crypto_bm_comp_buffer *buffers;
+	struct crypto_bm_comp_cb_data *cb_datas;
+};
+
+struct crypto_bm_comp_testvec {
+	int inlen;
+	int outlen;
+	char input[COMP_BUF_SIZE];
+	char output[COMP_BUF_SIZE];
+};
+
+struct crypto_bm_comp_test_func {
+	int (*testfun)(struct acomp_req *req);
+};
+
+static int dataperreq;
+
+static int totalreq;
+
+static struct crypto_bm_comp_data *data_array;
+
+static const struct crypto_bm_comp_testvec comp_compress_tv = {
+	.inlen	= 70,
+	.input	= "Join us now and share the software "
+		"Join us now and share the software ",
+};
+
+static const struct crypto_bm_comp_test_func testfunc[] = {
+	{
+		.testfun = crypto_acomp_compress,
+	}, {
+		.testfun = crypto_acomp_decompress,
+	}, {
+		/* sentinel */
+	}
+};
+
+static void crypto_bm_comp_cb(struct crypto_async_request *base, int err);
+
+int crypto_bm_init_comp(struct crypto_bm_base *base)
+{
+	struct crypto_bm_attrs *attrs = base->attrs;
+
+	if (attrs->optype >= CRYPTO_BM_OPS_MAX) {
+		pr_err("Optype should be 0 for compression or 1 for decompression!\n");
+		return -ENOMEM;
+	}
+
+	if (attrs->reqnum * DATAPERREQ >= REQ_NUM)
+		totalreq = attrs->reqnum * DATAPERREQ;
+	else
+		totalreq = REQ_NUM;
+
+	dataperreq = totalreq / attrs->reqnum;
+
+	data_array = kcalloc(attrs->threadnum, sizeof(*data_array), GFP_KERNEL);
+	if (!data_array)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void crypto_bm_uninit_comp(struct crypto_bm_base *base)
+{
+	kfree(data_array);
+}
+
+int crypto_bm_create_tfm_comp(struct crypto_bm_base *base, u32 idx)
+{
+	char *alg = base->attrs->algorithm;
+	int node = base->gthread[idx].node;
+	int ret = 0;
+
+	base->gthread[idx].tfm = crypto_alloc_acomp_node(alg, 0, 0, node);
+	if (IS_ERR(base->gthread[idx].tfm)) {
+		ret = PTR_ERR(base->gthread[idx].tfm);
+		pr_err("failed to alloc %dth acomp, ret = %d\n", idx, ret);
+	}
+
+	return ret;
+}
+
+void crypto_bm_release_tfm_comp(struct crypto_bm_base *base, u32 idx)
+{
+	crypto_free_acomp(base->gthread[idx].tfm);
+}
+
+static void crypto_bm_comp_copy_data_compress(u32 idx)
+{
+	struct crypto_bm_comp_data *data = &data_array[idx];
+	u32 block, inlen, inputsize = data->input_size;
+	void *buffer;
+	int i, j;
+
+	block = DIV_ROUND_UP(inputsize, comp_compress_tv.inlen);
+	for (i = 0; i < totalreq; i++) {
+		inlen = inputsize;
+		buffer = data->buffers[i].input;
+		for (j = 0; j < block; j++) {
+			memcpy(buffer, comp_compress_tv.input,
+			       j == block - 1 ? inlen : comp_compress_tv.inlen);
+			buffer += comp_compress_tv.inlen;
+			inlen -= comp_compress_tv.inlen;
+		}
+	}
+}
+
+static int crypto_bm_comp_copy_data_decompress(struct crypto_bm_base *base, u32 idx)
+{
+	struct crypto_bm_comp_data *data = &data_array[idx];
+	struct crypto_acomp *acomp = base->gthread[idx].tfm;
+	struct crypto_wait wait;
+	struct acomp_req *req;
+	u32 block, inlen;
+	void *buffer;
+	int i, ret;
+
+	req = acomp_request_alloc(acomp);
+	if (!req)
+		return -ENOMEM;
+
+	inlen = data->input_size;
+	block = DIV_ROUND_UP(inlen, comp_compress_tv.inlen);
+	buffer = data->buffers[0].input;
+	for (i = 0; i < block; i++) {
+		memcpy(buffer, comp_compress_tv.input,
+		       i == block - 1 ? inlen : comp_compress_tv.inlen);
+		buffer += comp_compress_tv.inlen;
+		inlen -= comp_compress_tv.inlen;
+	}
+
+	/*
+	 * For decompression, the tool need to prepare compressed data according
+	 * to crypto_bm_attrs.inputsize. And here it is hard to make the compressed
+	 * data length equal to 'inputsize' value, so make the origin data length
+	 * equal to 'inputsize' value.
+	 */
+	crypto_init_wait(&wait);
+	acomp_request_set_callback(req, 0, crypto_req_done, &wait);
+	acomp_request_set_params(req, data->buffers[0].src, data->buffers[0].dst,
+				 data->input_size, data->output_size);
+
+	ret = crypto_wait_req(crypto_acomp_compress(req), &wait);
+	if (ret) {
+		pr_err("failed to prepare decompression data.\n");
+		goto out_free_req;
+	}
+
+	for (i = 0; i < totalreq; i++)
+		memcpy(data->buffers[i].input, data->buffers[0].output, req->dlen);
+
+out_free_req:
+	acomp_request_free(req);
+
+	return ret;
+}
+
+static int crypto_bm_comp_init_data(struct crypto_bm_base *base, u32 idx)
+{
+	struct crypto_bm_comp_data *data = &data_array[idx];
+	int i, ret, node = base->gthread[idx].node;
+	struct crypto_bm_comp_buffer *buffer;
+	u32 reqnum = base->attrs->reqnum;
+	u32 optype = base->attrs->optype;
+
+	data->input_size = base->attrs->inputsize;
+	data->output_size = base->attrs->inputsize;
+
+	data->buffers = kcalloc_node(1, sizeof(*data->buffers) * totalreq, GFP_KERNEL, node);
+	if (!data->buffers)
+		return -ENOMEM;
+
+	data->cb_datas = kcalloc_node(1, sizeof(*data->cb_datas) * reqnum, GFP_KERNEL, node);
+	if (!data->cb_datas) {
+		ret = -ENOMEM;
+		goto out_free_buffers;
+	}
+
+	for (i = 0; i < totalreq; i++) {
+		buffer = &data->buffers[i];
+		buffer->src = kcalloc_node(1, sizeof(struct scatterlist), GFP_KERNEL, node);
+		if (!buffer->src) {
+			ret = -ENOMEM;
+			goto out_free_src;
+		}
+
+		buffer->dst = kcalloc_node(1, sizeof(struct scatterlist), GFP_KERNEL, node);
+		if (!buffer->dst) {
+			ret = -ENOMEM;
+			goto out_free_dst;
+		}
+
+		buffer->input = kcalloc_node(1, data->input_size, GFP_KERNEL, node);
+		if (!buffer->input) {
+			ret = -ENOMEM;
+			goto out_free_input;
+		}
+
+		buffer->output = kcalloc_node(1, data->output_size, GFP_KERNEL, node);
+		if (!buffer->output) {
+			ret = -ENOMEM;
+			goto out_free_output;
+		}
+
+		sg_init_one(buffer->src, buffer->input, data->input_size);
+		sg_init_one(buffer->dst, buffer->output, data->output_size);
+	}
+
+	if (optype == CRYPTO_BM_COMPRESS) {
+		crypto_bm_comp_copy_data_compress(idx);
+	} else {
+		ret = crypto_bm_comp_copy_data_decompress(base, idx);
+		if (ret) {
+			i--;
+			goto out_free_output;
+		}
+	}
+
+	return 0;
+
+out_free_output:
+	kfree(buffer->input);
+
+out_free_input:
+	kfree(buffer->dst);
+
+out_free_dst:
+	kfree(buffer->src);
+
+out_free_src:
+	for (i--; i >= 0; i--) {
+		buffer = &data->buffers[i];
+		kfree(buffer->src);
+		kfree(buffer->dst);
+		kfree(buffer->input);
+		kfree(buffer->output);
+	}
+
+	kfree(data->cb_datas);
+
+out_free_buffers:
+	kfree(data->buffers);
+
+	return ret;
+}
+
+static void crypto_bm_comp_uninit_data(struct crypto_bm_base *base, u32 idx)
+{
+	struct crypto_bm_comp_data *data = &data_array[idx];
+	struct crypto_bm_comp_buffer *buffer;
+	int i;
+
+	for (i = 0; i < totalreq; i++) {
+		buffer = &data->buffers[i];
+		kfree(buffer->src);
+		kfree(buffer->dst);
+		kfree(buffer->input);
+		kfree(buffer->output);
+	}
+
+	kfree(data->cb_datas);
+	kfree(data->buffers);
+}
+
+static int crypto_bm_comp_alloc_req(struct crypto_bm_base *base, u32 idx)
+{
+	struct crypto_bm_comp_data *data = &data_array[idx];
+	int node = base->gthread[idx].node;
+	u32 reqnum = base->attrs->reqnum;
+	struct acomp_req *req;
+	int i;
+
+	base->gthread[idx].req = kcalloc_node(reqnum, sizeof(struct acomp_req *), GFP_KERNEL, node);
+	if (!base->gthread[idx].req)
+		return -ENOMEM;
+
+	for (i = 0; i < reqnum; i++) {
+		req = acomp_request_alloc(base->gthread[idx].tfm);
+		if (!req) {
+			pr_err("failed to allocate acomp request\n");
+			goto out_free_req;
+		}
+
+		acomp_request_set_callback(req, 0, crypto_bm_comp_cb, &data->cb_datas[i]);
+		base->gthread[idx].req[i] = req;
+	}
+
+	return 0;
+
+out_free_req:
+	for (i--; i >= 0; i--)
+		acomp_request_free(base->gthread[idx].req[i]);
+
+	kfree(base->gthread[idx].req);
+
+	return -EINVAL;
+}
+
+static void crypto_bm_comp_free_req(struct crypto_bm_base *base, u32 idx)
+{
+	u32 reqnum = base->attrs->reqnum;
+	int i;
+
+	for (i = 0; i < reqnum; i++)
+		acomp_request_free(base->gthread[idx].req[i]);
+}
+
+int crypto_bm_create_req_comp(struct crypto_bm_base *base, u32 idx)
+{
+	int ret;
+
+	ret = crypto_bm_comp_init_data(base, idx);
+	if (ret)
+		return ret;
+
+	ret = crypto_bm_comp_alloc_req(base, idx);
+	if (ret)
+		goto out_free_buf;
+
+	return 0;
+
+out_free_buf:
+	crypto_bm_comp_uninit_data(base, idx);
+
+	return ret;
+}
+
+void crypto_bm_release_req_comp(struct crypto_bm_base *base, u32 idx)
+{
+	crypto_bm_comp_free_req(base, idx);
+	crypto_bm_comp_uninit_data(base, idx);
+}
+
+static void crypto_bm_comp_cb(struct crypto_async_request *base, int err)
+{
+	struct crypto_bm_comp_cb_data *data = base->data;
+
+	atomic_inc(&data->tdata->count.recv_req);
+	atomic_set(&data->is_used, 0);
+}
+
+int crypto_bm_perf_comp(struct crypto_bm_thread_data *data)
+{
+	struct crypto_bm_base *base = data->base;
+	int i, j, ret, last_used, send_req = 0;
+	u32 loop = base->attrs->loop * 1000;
+	u32 reqnum = base->attrs->reqnum;
+	u32 threadid = data->threadid;
+	struct crypto_bm_comp_data *comp_data = &data_array[threadid];
+	struct crypto_bm_comp_buffer *buffer;
+	struct acomp_req *req;
+
+	for (i = 0; i < reqnum; i++)
+		comp_data->cb_datas[i].tdata = data;
+
+	for (i = 0; i < loop; i++) {
+		for (j = 0; j < reqnum; j++) {
+			if (atomic_read(&comp_data->cb_datas[j].is_used))
+				continue;
+			req = base->gthread[threadid].req[j];
+			last_used = comp_data->last_used;
+			buffer = &comp_data->buffers[last_used + j * dataperreq];
+			acomp_request_set_params(req, buffer->src, buffer->dst,
+						 comp_data->input_size, comp_data->output_size);
+			atomic_set(&comp_data->cb_datas[j].is_used, 1);
+			ret = testfunc[base->attrs->optype].testfun(req);
+			if (!ret) {
+				atomic_inc(&data->count.recv_req);
+				atomic_set(&comp_data->cb_datas[j].is_used, 0);
+			}
+			if (unlikely(ret && ret != -EINPROGRESS && ret != -EBUSY)) {
+				pr_err("failed to compress req, ret %d\n", ret);
+				atomic_set(&comp_data->cb_datas[j].is_used, 0);
+				break;
+			}
+			ret = 0;
+			comp_data->last_used = (last_used + 1) % dataperreq;
+			send_req++;
+		}
+	}
+
+	atomic_add(send_req, &data->count.send_req);
+	send_req = atomic_read(&data->count.send_req);
+
+	while (atomic_read(&data->count.recv_req) != send_req)
+		;
+
+	return ret;
+}
diff --git a/crypto/benchmark/bm_comp.h b/crypto/benchmark/bm_comp.h
new file mode 100644
index 000000000000..78b45f8b22a6
--- /dev/null
+++ b/crypto/benchmark/bm_comp.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 HiSilicon Limited.
+ */
+#ifndef CRYPTO_BM_COMP_H
+#define CRYPTO_BM_COMP_H
+
+#include <linux/types.h>
+
+int crypto_bm_init_comp(struct crypto_bm_base *base);
+void crypto_bm_uninit_comp(struct crypto_bm_base *base);
+int crypto_bm_create_tfm_comp(struct crypto_bm_base *base, u32 idx);
+void crypto_bm_release_tfm_comp(struct crypto_bm_base *base, u32 idx);
+int crypto_bm_create_req_comp(struct crypto_bm_base *base, u32 idx);
+void crypto_bm_release_req_comp(struct crypto_bm_base *base, u32 idx);
+int crypto_bm_perf_comp(struct crypto_bm_thread_data *data);
+
+#endif
--
2.24.0
