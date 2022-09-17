Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC375BB6F5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIQHZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIQHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:11 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C1476DA
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220917072400epoutp039ceba28de3c67ead0b3c47740b47b259~VlPps8gLG1145411454epoutp03A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220917072400epoutp039ceba28de3c67ead0b3c47740b47b259~VlPps8gLG1145411454epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399440;
        bh=+ZbMTYZdc/DppQc8gTghPumZLSaPGhkJy35PEUzyPbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euOfVxRax6j7Gh4yMqsPjtxVQcjVujSrkdYsOztboVK/zpNpF8+CDJYL2oBmDMwq0
         sDRfsNcqDN29zhJygmJa5BIpBNgj9gX7MFv97rM9N8jRuX5tirlXOj7O4f7Wn39j5i
         kXgpqwEz7yyspKZnxFqyLwjrIpx2pQOqQHRvz9c0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220917072359epcas1p335f20463169d487198d531be5ee88a01~VlPozHWEd0974609746epcas1p3T;
        Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.134]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MV2Vk5SPqz4x9Pv; Sat, 17 Sep
        2022 07:23:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.6D.64988.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epcas1p14543c842bdf0b6f719d4e0d2ed3bf33c~VlPnVUmM00249402494epcas1p1R;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epsmtrp2ec28762b123305909a1758346f9b0539~VlPnUl4um1654916549epsmtrp2z;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
X-AuditID: b6c32a39-8d3fa7000001fddc-77-6325760e7ea5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.F0.18644.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epsmtip20edd88af62c0bb48c9a7c507ca4e7b7b~VlPnDfWyK3199331993epsmtip2Z;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 08/13] trinity: Add ioctl feature
Date:   Sat, 17 Sep 2022 16:23:51 +0900
Message-Id: <20220917072356.2255620-9-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmgS5fmWqywaI2dYu/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJu
        cWleul5eaomVoYGBkSlQYUJ2xry7D1kL9rYyVmw99pK1gXFZdhcjJ4eEgInEkf6JzF2MXBxC
        AjsYJU7uvMQI4XxilLi7YQMrhPOZUeLLoV/sMC031xxjg0jsYpS4teIbO1zVh8n/warYBFQl
        Zs5YA2aLCJRLNG88AWYzC+RIPLnTxAxiCwNNWt30DizOAlQ/bVYjC4jNK2AtseptL1icU8BG
        4uamJqi4oMTJmU9YIObISzRvnQ12uITAR3aJrX+mMEOc5yLxfflrVghbWOLV8S1QZ0tJfH63
        lw3CzpaY0rGIBcIukDj3fCtQLweQbSxxcUUKiMksoCmxfpc+RIWixM7fcxkh1vJJvPvawwpR
        zSvR0SYEUaIkseTPYahFEhJTZ3xjgrA9JM49PAAN0X5GiZXTDzNPYJSfheSbWUi+mYWweQEj
        8ypGsdSC4tz01GLDAlN4tCbn525iBCdNLcsdjNPfftA7xMjEwXiIUYKDWUmEV9VTJVmINyWx
        siq1KD++qDQntfgQoykwfCcyS4km5wPTdl5JvKGJpYGJmZGxiYWhmaGSOK+eNmOykEB6Yklq
        dmpqQWoRTB8TB6dUA9NuyWX39vStn3ttqRtnGuPyWZ+uRzlnTXz5yOvhKh9uiQen/jTeD1M0
        eP7z33L7B0UpU5cm7J7WunTm8WtbLoQK3FM40x55mffXNKXX39O/lp9aM3Hxf4WzZvPafhb1
        SjzcWbnl5MITEaz71HdPvpLG+a1YmGOmaOo0L8UE90383vcD95qycwY3KLSLHelWzJid1ruq
        +scX3syGAx0h2juq7/S5WXzaK8nG+eDviffSLAnPm7TmXr24Jm5G4dU8Po5b2a8ezhJbYv3V
        W0t8XdIhdY1y9gVutZP7jGJ0rGZ0dGr9NJ1VU5/sszNua86Or0+XfRMumdbOZ9p5xGdDdYzF
        v2QrFu1q0QPl9b9PyDgpsRRnJBpqMRcVJwIA8MB1ViMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvC5fmWqywV4Ri7+TjrFbTH34hM2i
        efF6Nov33buZLfa+3spucXnXHDaL240r2Cz29XxktHg+7TqLA6fH71+TGD02repk87hzbQ+b
        x/65a9g9+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK2Pe3YesBXtbGSu2HnvJ2sC4LLuLkZND
        QsBE4uaaY2xdjFwcQgI7GCW6Xmxkg0hISGy6t5y5i5EDyBaWOHy4GKLmI6PE9LknmUBq2ARU
        JWbOWMMOYosI1EocPDqfGcRmFiiQmP10JguILQy0YHXTO7AaFqD6abMaweK8AtYSq972gsU5
        BWwkbm5qAosLAcVnT5/LBFEjKHFy5hMWiJnyEs1bZzNPYOSfhSQ1C0lqASPTKkbJ1ILi3PTc
        YsMCo7zUcr3ixNzi0rx0veT83E2M4NDW0trBuGfVB71DjEwcjIcYJTiYlUR4VT1VkoV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg4mXxcNWSFlGyYOue
        G1zvHM9wX758z9HHPUvfal2eJrnP2NNkx+/1ck+uRbJypvt8qdyWbu9QyLJFKoFlcn7yn70T
        S8J2BJVtutX1VDlT9/+pE7fF10rd38Vv+qd30yJ1yfpnX9IrBSduYGD58ltz1e2pPA9V/lt1
        KHy8t/TL/xlhD8KvNxzROBGhUSFZmJl/l38FR8e0PjmHS2rbCrbyLPt63LlFKpw94e35ZTnS
        x8NEOgpuGM9fd2Z1fc037ZjXkwUU577jjdpk/lzs0iPPFV4X5/6rqnFuP3Cat1Ppytxp2eVT
        tRTZyy9avdlUzCSjX+bdVWlyJNSlo+sP8/W392ZrRBa8r9G0c7A9fHOXEktxRqKhFnNRcSIA
        lb/53NwCAAA=
X-CMS-MailID: 20220917072358epcas1p14543c842bdf0b6f719d4e0d2ed3bf33c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072358epcas1p14543c842bdf0b6f719d4e0d2ed3bf33c
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072358epcas1p14543c842bdf0b6f719d4e0d2ed3bf33c@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements ioctl operations.

The ioctl routines are added to give controls to the user
library. TRINITY_IOCTL_HWMEM_ALLOC/DEALLOC is for memory
allocation for the model load, RUN/STOP operations are
provided to control NPU works. And several STAT controls can
provide statistics of the NPU.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/trinity.c | 629 +++++++++++++++++++++++++++++++++
 1 file changed, 629 insertions(+)

diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index a785a5dca4d9..0fb5ccf9f035 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -22,6 +22,635 @@
 static DEFINE_IDA(dev_nrs);
 static DEFINE_IDA(model_ids);
 
+static uint64_t trinity_gen_model_id(int32_t dbuf_fd)
+{
+	uint64_t mid;
+
+	mid = ida_alloc_max(&model_ids, ((1 << TRINITY_SHIFT_MODEL_ID) - 1), GFP_KERNEL);
+	if (mid < 0)
+		return mid;
+
+	mid |= (dbuf_fd << TRINITY_SHIFT_MODEL_ID);
+
+	return mid;
+}
+
+static void trinity_release_model_id(uint64_t mid)
+{
+	ida_free(&model_ids, mid & ((1 << TRINITY_SHIFT_MODEL_ID) - 1));
+}
+
+static int32_t trinity_model_id_to_dbuf_fd(uint64_t id)
+{
+	return (id >> TRINITY_SHIFT_MODEL_ID) & UINT_MAX;
+}
+
+static void trinity_model_htable_init(const struct device *dev)
+{
+	int i;
+	struct trinity_driver *drv;
+
+	drv = dev_get_drvdata(dev);
+	for (i = 0; i < TRINITY_MODEL_HASH_SIZE; ++i)
+		INIT_HLIST_BL_HEAD(drv->model_htable + i);
+}
+
+static struct trinity_model *
+trinity_get_model_by_id(const struct trinity_driver *drv, const uint64_t id)
+{
+	struct hlist_bl_head *model_hlist;
+	struct hlist_bl_node *hn;
+	struct trinity_model *hm;
+	unsigned long key;
+	int32_t dbuf_fd;
+
+	dbuf_fd = trinity_model_id_to_dbuf_fd(id);
+	key = hash_long(dbuf_fd, TRINITY_MODEL_HASH_BITS);
+	model_hlist = (struct hlist_bl_head *)(drv->model_htable + key);
+
+	hlist_bl_lock(model_hlist);
+	hlist_bl_for_each_entry(hm, hn, model_hlist, hnode) {
+		if (hm->config.id != id)
+			continue;
+
+		hlist_bl_unlock(model_hlist);
+		return hm;
+	}
+	hlist_bl_unlock(model_hlist);
+
+	return NULL;
+}
+
+/**
+ * trinity_register_model() - Registers a model to the internal hashtable. Note
+ *		that the device is responsible for the hashtable maintenance.
+ *
+ * @drv: An instance of the trinity driver
+ * @model: Model information to be registered
+ *
+ * Returns 0 and sets model->id with a valid value, which is unique system-wide,
+ * on success. Otherwise, returns negative error.
+ */
+int32_t trinity_register_model(struct trinity_driver *drv,
+			       struct trinity_model *model)
+{
+	struct hlist_bl_head *model_hlist;
+	unsigned long key;
+	int32_t ret;
+
+	ret = trinity_hwmem_import_dmabuf_begin(drv_to_dev_ptr(drv),
+						model->config.dbuf_fd,
+						&model->import_info);
+	if (ret)
+		return ret;
+
+#ifdef ARM
+	/* sync model program data */
+	__cpuc_flush_dcache_area(model->import_info.addr,
+				 model->import_info.buf->size);
+#endif
+
+	model->config.id = trinity_gen_model_id(model->config.dbuf_fd);
+	model->owner_id = trinity_get_app_id();
+
+	INIT_HLIST_BL_NODE(&model->hnode);
+
+	key = hash_long(model->config.dbuf_fd, TRINITY_MODEL_HASH_BITS);
+	model_hlist = (struct hlist_bl_head *)(drv->model_htable + key);
+
+	hlist_bl_lock(model_hlist);
+	hlist_bl_add_head(&model->hnode, model_hlist);
+	hlist_bl_unlock(model_hlist);
+
+	kref_init(&model->refcnt);
+
+	return 0;
+}
+
+static void trinity_destroy_model(struct kref *refcnt)
+{
+	struct trinity_model *model =
+		container_of(refcnt, struct trinity_model, refcnt);
+
+	trinity_release_model_id(model->config.id);
+	trinity_hwmem_import_dmabuf_end(&model->import_info);
+	kfree(model);
+}
+
+static void trinity_model_get(struct trinity_model *model)
+{
+	if (!model)
+		return;
+
+	kref_get(&model->refcnt);
+}
+
+static void trinity_model_put(struct trinity_model *model)
+{
+	if (!model)
+		return;
+
+	kref_put(&model->refcnt, trinity_destroy_model);
+}
+
+phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr)
+{
+	if (domain)
+		return iommu_iova_to_phys(domain, daddr);
+
+	return TRINITY_PADDR_BASE + daddr;
+}
+
+void trinity_finish_req(struct trinity_driver *drv, struct trinity_req *req)
+{
+	if (drv->desc->check_profile(drv, req) < 0)
+		dev_warn(drv_to_dev_ptr(drv),
+			 "Unable to get profile data from NPU\n");
+	trinity_hwmem_import_dmabuf_end(&req->input.import_info);
+	trinity_stat_finish_req(drv, req);
+	trinity_model_put(req->model);
+}
+
+/**
+ * trinity_deregister_model() - Deregisters the model with a given id from the
+ *		table
+ *
+ * @drv: An instance of the trinity driver
+ * @id: An id of the model to be deregistered
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+int32_t trinity_deregister_model(const struct trinity_driver *drv,
+				 const uint64_t id)
+{
+	struct hlist_bl_head *model_hlist;
+	int32_t dbuf_fd;
+	unsigned long key;
+	struct hlist_bl_node *hn;
+	struct trinity_model *hm = NULL;
+
+	dbuf_fd = trinity_model_id_to_dbuf_fd(id);
+	key = hash_long(dbuf_fd, TRINITY_MODEL_HASH_BITS);
+	model_hlist = (struct hlist_bl_head *)(drv->model_htable + key);
+
+	hlist_bl_lock(model_hlist);
+	hlist_bl_for_each_entry(hm, hn, model_hlist, hnode) {
+		if (hm->config.id == id) {
+			hlist_bl_del_init(&hm->hnode);
+			break;
+		}
+	}
+	hlist_bl_unlock(model_hlist);
+
+	if (!hm)
+		return -ENOENT;
+
+	trinity_model_put(hm);
+
+	return 0;
+}
+
+/**
+ * trinity_deregister_models_owned() - Deregisters models owned
+ *
+ * @drv: An instance of the trinity driver
+ */
+void trinity_deregister_models_owned(struct trinity_driver *drv)
+{
+	struct hlist_bl_head *model_htable;
+	struct trinity_model *hm;
+	struct hlist_bl_node *hn;
+	int i, app_id;
+
+	app_id = trinity_get_app_id();
+	model_htable = drv->model_htable;
+retry:
+	for (i = 0; i < TRINITY_MODEL_HASH_SIZE; i++) {
+		hlist_bl_lock(model_htable + i);
+		hlist_bl_for_each_entry(hm, hn, model_htable + i, hnode) {
+			if (hm->owner_id == app_id) {
+				hlist_bl_del_init(&hm->hnode);
+				hlist_bl_unlock(model_htable + i);
+
+				trinity_model_put(hm);
+
+				goto retry;
+			}
+		}
+		hlist_bl_unlock(model_htable + i);
+	}
+}
+
+static int32_t trinity_submit_req(struct trinity_driver *drv,
+				  struct trinity_req *req)
+{
+	struct device *dev;
+	wait_queue_head_t wq;
+	unsigned long timeout, timeout_ms;
+	unsigned long retry;
+	int ret = 0;
+
+	dev = drv_to_dev_ptr(drv);
+
+	/* optional req setup before submission */
+	if (drv->desc->prepare_req) {
+		ret = drv->desc->prepare_req(drv, req);
+		if (ret < 0) {
+			dev_err(dev, "Unable to prepare req submission: %d",
+				ret);
+			return ret;
+		}
+	}
+
+	req->submit_retry = 0;
+	timeout_ms = req->input.config.timeout_ms;
+	/* use the default timeout if a user didn't set */
+	if (timeout_ms == 0)
+		timeout_ms = TRINITY_RUN_TIMEOUT_MSEC;
+
+	retry = 0;
+	init_waitqueue_head(&wq);
+	init_completion(&req->complete);
+
+	timeout = msecs_to_jiffies(timeout_ms);
+	while (wait_event_interruptible_timeout(wq, trinity_sched_ready(drv),
+						timeout / 10) == 0) {
+		if (retry == 10) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		retry++;
+	}
+
+	if (ret == 0) {
+		ret = trinity_stat_append_req(drv, req);
+		if (ret < 0) {
+			dev_err(dev, "Unable to append request stat: %d", ret);
+			return ret;
+		}
+
+		ret = trinity_sched_submit(drv, req);
+		if (ret < 0)
+			trinity_stat_remove_req(drv, req, true);
+	}
+
+	if (ret < 0) {
+		dev_err(dev, "Unable to submit req to scheduler: %d", ret);
+		return ret;
+	}
+
+	if (req->input.config.output_mode != TRINITY_OUTPUT_HW) {
+		timeout = wait_for_completion_timeout(&req->complete, timeout);
+		/* Check and handle the timeout if its handler exists */
+		if (timeout == 0) {
+			drv->desc->handle_timeout(drv, req);
+
+			req->stat->status = TRINITY_REQ_STATUS_ERROR;
+			ret = -ECANCELED;
+		} else if (req->stat->status == TRINITY_REQ_STATUS_ERROR) {
+			ret = -ECANCELED;
+		}
+
+		trinity_finish_req(drv, req);
+	}
+
+	return ret;
+}
+
+static int32_t trinity_run_input(struct trinity_driver *drv,
+				 struct trinity_input *input,
+				 struct trinity_req *req)
+{
+	struct trinity_model *model;
+	int32_t err;
+
+	model = trinity_get_model_by_id(drv, input->config.model_id);
+	if (!model) {
+		dev_err(drv_to_dev_ptr(drv), "Unable to find the model");
+		return -EINVAL;
+	}
+
+	/* skip to submit this req */
+	if (model->config.program_size == 0 &&
+	    input->config.output_mode != TRINITY_OUTPUT_HW)
+		return 0;
+
+	trinity_model_get(model);
+
+	err = trinity_hwmem_import_dmabuf_begin(drv_to_dev_ptr(drv),
+						input->config.dbuf_fd,
+						&input->import_info);
+	if (err < 0)
+		return err;
+
+	req->model = model;
+	err = trinity_submit_req(drv, req);
+	if (err == 0)
+		return 0;
+
+	if (err != -ECANCELED)
+		trinity_hwmem_import_dmabuf_end(&input->import_info);
+	return err;
+}
+
+/**
+ * trinity_ioctl() - A common callback for unlocked_ioctl() in file_operations for
+ *		a Trinity device node.
+ *
+ * @f: A file instance of the opened device node
+ * @cmd: The target IOCTL command to be handled
+ * @arg: A user argument
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct trinity_driver *drv = f->private_data;
+	const struct trinity_desc *desc = drv->desc;
+	ssize_t err = 0L;
+
+	switch (cmd) {
+	case TRINITY_IOCTL_GET_VERSION: {
+		if (copy_to_user((uint32_t __user *)arg, &(desc->ver),
+				 sizeof((desc->ver))))
+			return -EFAULT;
+
+		break;
+	}
+	case TRINITY_IOCTL_GET_API_LEVEL: {
+		uint32_t api_level = TRINITY_API_LEVEL;
+
+		if (copy_to_user((uint32_t __user *)arg, &api_level,
+				 sizeof(api_level)))
+			return -EFAULT;
+
+		break;
+	}
+	case TRINITY_IOCTL_GET_STATE: {
+		enum trinity_state ready;
+
+		ready = drv->desc->get_state(drv);
+		if (copy_to_user((enum trinity_state __user *)arg, &ready,
+				 sizeof(ready)))
+			return -EFAULT;
+
+		break;
+	}
+	case TRINITY_IOCTL_GET_TOPS: {
+		if (copy_to_user((uint32_t __user *)arg, &(drv->tops),
+				 sizeof((drv->tops))))
+			return -EFAULT;
+
+		break;
+	}
+	case TRINITY_IOCTL_GET_DSPM: {
+		if (copy_to_user((uint32_t __user *)arg, &(drv->dspm),
+				 sizeof((drv->dspm))))
+			return -EFAULT;
+
+		break;
+	}
+	case TRINITY_IOCTL_GET_NEXT_REQUEST: {
+		int32_t req_id = atomic_inc_return(&drv->global_req_id);
+
+		if (copy_to_user((int32_t __user *)arg, &req_id,
+				 sizeof(req_id)))
+			return -EFAULT;
+
+		break;
+	}
+	case TRINITY_IOCTL_HWMEM_ALLOC: {
+		struct trinity_ioctl_hwmem hwmem;
+
+		if (copy_from_user(&hwmem, (size_t __user *)arg, sizeof(hwmem)))
+			return -EFAULT;
+
+		err = trinity_hwmem_alloc(drv_to_dev_ptr(drv), hwmem.size,
+					  hwmem.type);
+		if (err >= 0)
+			trinity_stat_app_total_alloc(drv, hwmem.size);
+
+		break;
+	}
+	case TRINITY_IOCTL_HWMEM_DEALLOC: {
+		struct trinity_ioctl_hwmem hwmem;
+		struct dma_buf *dbuf;
+
+		if (copy_from_user(&hwmem, (size_t __user *)arg, sizeof(hwmem)))
+			return -EFAULT;
+
+		dbuf = dma_buf_get(hwmem.dbuf_fd);
+		if (IS_ERR(dbuf))
+			return PTR_ERR(dbuf);
+
+		err = trinity_hwmem_free(drv_to_dev_ptr(drv), hwmem.dbuf_fd);
+		if (err == 0)
+			trinity_stat_app_total_freed(drv, dbuf->size);
+
+		break;
+	}
+	case TRINITY_IOCTL_REGISTER_MODEL: {
+		struct trinity_model *model =
+			kzalloc(sizeof(struct trinity_model), GFP_KERNEL);
+
+		if (IS_ERR_OR_NULL(model))
+			return -ENOMEM;
+
+		if (copy_from_user(&model->config,
+				   (struct trinity_model __user *)arg,
+				   sizeof(model->config))) {
+			kfree(model);
+			return -EFAULT;
+		}
+
+		err = trinity_register_model(drv, model);
+		if (err < 0)
+			break;
+
+		if (copy_to_user((struct trinity_model __user *)arg,
+				 &model->config, sizeof(model->config)))
+			return -EFAULT;
+
+		break;
+	}
+	case TRINITY_IOCTL_DEREGISTER_MODEL: {
+		uint64_t id;
+
+		if (copy_from_user(&id, (uint64_t __user *)arg, sizeof(id)))
+			return -EFAULT;
+
+		err = trinity_deregister_model(drv, id);
+
+		break;
+	}
+	case TRINITY_IOCTL_RUN_INPUT: {
+		struct trinity_req *req;
+		struct trinity_input *input;
+
+		if (!IDU_LOADED(drv))
+			return -EFAULT;
+
+		req = drv->desc->alloc_req(drv);
+		if (!req)
+			return -ENOMEM;
+		req->drv = drv;
+		req->time_started = ktime_get();
+
+		input = &(req->input);
+		/** run input based on config received from the user */
+		if (copy_from_user(&input->config,
+				   (struct trinity_input __user *)arg,
+				   sizeof(input->config))) {
+			drv->desc->dealloc_req(drv, req);
+			return -EACCES;
+		}
+
+		err = trinity_run_input(drv, input, req);
+		if (err < 0) {
+			drv->desc->dealloc_req(drv, req);
+			return err;
+		}
+
+		if (copy_to_user((struct trinity_input __user *)arg,
+				 &input->config, sizeof(input->config))) {
+			drv->desc->dealloc_req(drv, req);
+			return -EACCES;
+		}
+
+		/* this will be freed when stop request is called */
+		if (!req->is_kernel)
+			drv->desc->dealloc_req(drv, req);
+
+		break;
+	}
+	case TRINITY_IOCTL_STOP_REQUESTS: {
+		if (!IDU_LOADED(drv))
+			return -EFAULT;
+
+		if (drv->desc->stop_reqs)
+			schedule_work(&drv->work_stop);
+
+		break;
+	}
+	case TRINITY_IOCTL_STAT_CURRENT_APP: {
+		struct trinity_ioctl_stat_app ioctl_stat_app;
+
+		if (copy_from_user(&ioctl_stat_app,
+				   (struct trinity_ioctl_stat_app __user *)arg,
+				   sizeof(ioctl_stat_app)))
+			return -EACCES;
+
+		trinity_stat_app_copy_ioctl(drv, &ioctl_stat_app);
+
+		if (copy_to_user((struct trinity_ioctl_stat_app __user *)arg,
+				 &ioctl_stat_app, sizeof(ioctl_stat_app)))
+			return -EACCES;
+
+		break;
+	}
+	case TRINITY_IOCTL_STAT_APPS: {
+		struct trinity_ioctl_stat_apps ioctl_stat_apps;
+
+		if (copy_from_user(&ioctl_stat_apps,
+				   (struct trinity_ioctl_stat_apps __user *)arg,
+				   sizeof(ioctl_stat_apps)))
+			return -EACCES;
+
+		trinity_stat_apps_copy_ioctl(drv, &ioctl_stat_apps);
+
+		if (copy_to_user((struct trinity_ioctl_stat_apps __user *)arg,
+				 &ioctl_stat_apps, sizeof(ioctl_stat_apps)))
+			return -EACCES;
+
+		break;
+	}
+	case TRINITY_IOCTL_STAT_REQS: {
+		struct trinity_ioctl_stat_reqs ioctl_stat_reqs;
+
+		if (copy_from_user(&ioctl_stat_reqs,
+				   (struct trinity_ioctl_stat_reqs __user *)arg,
+				   sizeof(ioctl_stat_reqs)))
+			return -EACCES;
+
+		if (ioctl_stat_reqs.app_id == 0)
+			ioctl_stat_reqs.app_id = trinity_get_app_id();
+
+		trinity_stat_reqs_copy_ioctl(drv, &ioctl_stat_reqs);
+
+		if (copy_to_user((struct trinity_ioctl_stat_reqs __user *)arg,
+				 &ioctl_stat_reqs, sizeof(ioctl_stat_reqs)))
+			return -EACCES;
+
+		break;
+	}
+	case TRINITY_IOCTL_GET_PROFILE_META: {
+		struct trinity_ioctl_profile_meta profile;
+
+		if (copy_from_user(
+			    &profile,
+			    (struct trinity_ioctl_profile_meta __user *)arg,
+			    sizeof(profile)))
+			return -EACCES;
+
+		if (drv->desc->get_profile_meta) {
+			err = drv->desc->get_profile_meta(drv, &profile);
+		} else {
+			profile.total_cycles = -1;
+			profile.total_ops = 0;
+			profile.profile_size = 0;
+			profile.input_footprint = -1;
+			profile.output_footprint = -1;
+		}
+
+		if (copy_to_user((struct trinity_ioctl_profile_meta __user *)arg,
+				 &profile, sizeof(profile)))
+			return -EACCES;
+
+		break;
+	}
+	case TRINITY_IOCTL_GET_PROFILE_BUFF: {
+		struct trinity_ioctl_profile_buff profile;
+
+		if (copy_from_user(
+			    &profile,
+			    (struct trinity_ioctl_profile_buff __user *)arg,
+			    sizeof(profile)))
+			return -EACCES;
+
+		if (drv->desc->get_profile_buff)
+			err = drv->desc->get_profile_buff(drv, &profile);
+
+		if (copy_to_user((struct trinity_ioctl_profile_buff __user *)arg,
+				 &profile, sizeof(profile)))
+			return -EACCES;
+
+		break;
+	}
+	case TRINITY_IOCTL_IDU_SET: {
+		struct trinity_ioctl_idu idu;
+
+		if ((struct trinity_ioctl_idu __user *)arg == NULL) {
+			drv->desc->idu_unset(drv);
+			break;
+		}
+
+		if (copy_from_user(&idu,
+				   (struct trinity_ioctl_idu __user *)arg,
+				   sizeof(idu))) {
+			return -EACCES;
+		}
+
+		err = drv->desc->idu_set(drv, &idu);
+
+		break;
+	}
+	default:
+		return -ENOTTY;
+	}
+
+	return err;
+}
+
 /**
  * trinity_release() - A common callback for close() in file_operations for a
  *		Trinity	device node. If there are device-specific data to be
-- 
2.25.1

