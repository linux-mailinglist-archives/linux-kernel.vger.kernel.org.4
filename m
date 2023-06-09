Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E0729737
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbjFIKnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbjFIKl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB21BFF;
        Fri,  9 Jun 2023 03:40:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359ATMXj001184;
        Fri, 9 Jun 2023 10:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NN6eiIuHt5ju4Koc6y3iuQjGcM9R8729RQjnsafk9CA=;
 b=VlaMyI0N1snyZs1JzHwNCn3DBdXRXAzd5XgVpvSKOwHPh/1UfomFG1oXUW/X/+DFA5xI
 iYOvwveA7GYliPCMsKQqHvthBA27txkZpunTDZP1JBTKEFVrKgqzvAixko7HeoD2lpAo
 xresGEjt2QlIh+dhEypZVwuUtutG78CdiiRikU9xfjvOU+40wLz6xEPGg5afHHkRPoIY
 N51TYiZrsQFTLMErd/IzSidjQNRKzGu70WrOhfslSkDfYHSdI+D46l7JsNTW+OKDepAZ
 vir8eBjTDCEEnyDTdGDULYXVxFzhtrGI1TQNKbQhGC8A+V+ueIDmibBLk+UGss20BFZQ vA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3w7drkv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:39:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359AdvQN018347
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 10:39:57 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 03:39:54 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, <quic_anane@quicinc.com>
Subject: [PATCH v1 1/2] misc: fastrpc: Add cached buffer support
Date:   Fri, 9 Jun 2023 16:09:46 +0530
Message-ID: <1686307187-15199-2-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686307187-15199-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1686307187-15199-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tEjLTE9JCckode59PBlJfLTN2Lclo_S1
X-Proofpoint-ORIG-GUID: tEjLTE9JCckode59PBlJfLTN2Lclo_S1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FastRPC driver uses DMA API for region allocation for any buf_alloc
request and the DMA region is unmap and freed once the usage is
complete.

Cached buffer support enables caching of certain types of buffers
instead of freeing which help in reducing the overhead of DMA API
call for every buffer allocation request.

A list of cached buffer is maintained which will get reused when
needed and this buffer list will get freed during device release.

Co-developed-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 133 +++++++++++++++++++++++++++++++++++++-------
 include/uapi/misc/fastrpc.h |   8 +++
 2 files changed, 122 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d04..a961a66 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -41,6 +41,10 @@
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
+/* Maximum buffers cached in cached buffer list */
+#define FASTRPC_MAX_CACHED_BUFS (32)
+#define FASTRPC_MAX_CACHE_BUF_SIZE (8*1024*1024)
+
 /* Add memory to static PD pool, protection thru XPU */
 #define ADSP_MMAP_HEAP_ADDR  4
 /* MAP static DMA buffer on DSP User PD */
@@ -195,6 +199,7 @@ struct fastrpc_buf {
 	struct dma_buf *dmabuf;
 	struct device *dev;
 	void *virt;
+	u32 type;
 	u64 phys;
 	u64 size;
 	/* Lock for dma buf attachments */
@@ -293,6 +298,7 @@ struct fastrpc_user {
 	struct list_head maps;
 	struct list_head pending;
 	struct list_head mmaps;
+	struct list_head cached_bufs;
 
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sctx;
@@ -300,6 +306,8 @@ struct fastrpc_user {
 
 	int tgid;
 	int pd;
+	/* total cached buffers */
+	u32 num_cached_buf;
 	bool is_secure_dev;
 	/* Lock for lists */
 	spinlock_t lock;
@@ -391,17 +399,95 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 	return ret;
 }
 
-static void fastrpc_buf_free(struct fastrpc_buf *buf)
+static void __fastrpc_buf_free(struct fastrpc_buf *buf)
 {
 	dma_free_coherent(buf->dev, buf->size, buf->virt,
 			  FASTRPC_PHYS(buf->phys));
 	kfree(buf);
 }
 
+static void fastrpc_cached_buf_list_add(struct fastrpc_buf *buf)
+{
+	struct fastrpc_user *fl = buf->fl;
+
+	if (buf->size < FASTRPC_MAX_CACHE_BUF_SIZE) {
+		spin_lock(&fl->lock);
+		if (fl->num_cached_buf > FASTRPC_MAX_CACHED_BUFS) {
+			spin_unlock(&fl->lock);
+			goto skip_buf_cache;
+		}
+
+		list_add_tail(&buf->node, &fl->cached_bufs);
+		fl->num_cached_buf++;
+		buf->type = -1;
+		spin_unlock(&fl->lock);
+	}
+	return;
+
+skip_buf_cache:
+	__fastrpc_buf_free(buf);
+}
+
+static void fastrpc_buf_free(struct fastrpc_buf *buf, bool cache)
+{
+	if (cache)
+		fastrpc_cached_buf_list_add(buf);
+	else
+		__fastrpc_buf_free(buf);
+}
+
+static inline bool fastrpc_get_cached_buf(struct fastrpc_user *fl,
+		size_t size, int buf_type, struct fastrpc_buf **obuf)
+{
+	bool found = false;
+	struct fastrpc_buf *buf, *n, *cbuf = NULL;
+
+	if (buf_type == USER_BUF)
+		return found;
+
+	/* find the smallest buffer that fits in the cache */
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(buf, n, &fl->cached_bufs, node) {
+		if (buf->size >= size && (!cbuf || cbuf->size > buf->size))
+			cbuf = buf;
+	}
+	if (cbuf) {
+		list_del_init(&cbuf->node);
+		fl->num_cached_buf--;
+	}
+	spin_unlock(&fl->lock);
+	if (cbuf) {
+		cbuf->type = buf_type;
+		*obuf = cbuf;
+		found = true;
+	}
+
+	return found;
+}
+
+static void fastrpc_cached_buf_list_free(struct fastrpc_user *fl)
+{
+	struct fastrpc_buf *buf, *n, *free;
+
+	do {
+		free = NULL;
+		spin_lock(&fl->lock);
+		list_for_each_entry_safe(buf, n, &fl->cached_bufs, node) {
+			list_del(&buf->node);
+			fl->num_cached_buf--;
+			free = buf;
+			break;
+		}
+		spin_unlock(&fl->lock);
+		if (free)
+			fastrpc_buf_free(free, false);
+	} while (free);
+}
+
 static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 			     u64 size, struct fastrpc_buf **obuf)
 {
-	struct fastrpc_buf *buf;
+	struct fastrpc_buf *buf = NULL;
 
 	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
 	if (!buf)
@@ -432,16 +518,23 @@ static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 }
 
 static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
-			     u64 size, struct fastrpc_buf **obuf)
+			     u64 size, u32 buf_type, struct fastrpc_buf **obuf)
 {
 	int ret;
 	struct fastrpc_buf *buf;
 
+	if (fastrpc_get_cached_buf(fl, size, buf_type, obuf))
+		return 0;
 	ret = __fastrpc_buf_alloc(fl, dev, size, obuf);
-	if (ret)
-		return ret;
+	if (ret == -ENOMEM) {
+		fastrpc_cached_buf_list_free(fl);
+		ret = __fastrpc_buf_alloc(fl, dev, size, obuf);
+		if (ret)
+			return ret;
+	}
 
 	buf = *obuf;
+	buf->type = buf_type;
 
 	if (fl->sctx && fl->sctx->sid)
 		buf->phys += ((u64)fl->sctx->sid << 32);
@@ -490,7 +583,7 @@ static void fastrpc_context_free(struct kref *ref)
 		fastrpc_map_put(ctx->maps[i]);
 
 	if (ctx->buf)
-		fastrpc_buf_free(ctx->buf);
+		fastrpc_buf_free(ctx->buf, true);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
@@ -674,7 +767,7 @@ static void fastrpc_release(struct dma_buf *dmabuf)
 {
 	struct fastrpc_buf *buffer = dmabuf->priv;
 
-	fastrpc_buf_free(buffer);
+	fastrpc_buf_free(buffer, false);
 }
 
 static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
@@ -951,7 +1044,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 
 	ctx->msg_sz = pkt_size;
 
-	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
+	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, METADATA_BUF, &ctx->buf);
 	if (err)
 		return err;
 
@@ -1334,7 +1427,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
 	}
 err_map:
-	fastrpc_buf_free(fl->cctx->remote_heap);
+	fastrpc_buf_free(fl->cctx->remote_heap, false);
 err_name:
 	kfree(name);
 err:
@@ -1403,7 +1496,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
 		       1024 * 1024);
 	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
-				&imem);
+				INITMEM_BUF, &imem);
 	if (err)
 		goto err_alloc;
 
@@ -1450,7 +1543,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 
 err_invoke:
 	fl->init_mem = NULL;
-	fastrpc_buf_free(imem);
+	fastrpc_buf_free(imem, false);
 err_alloc:
 	fastrpc_map_put(map);
 err:
@@ -1521,7 +1614,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (fl->init_mem)
-		fastrpc_buf_free(fl->init_mem);
+		fastrpc_buf_free(fl->init_mem, false);
 
 	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
 		list_del(&ctx->node);
@@ -1533,9 +1626,10 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 
 	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
 		list_del(&buf->node);
-		fastrpc_buf_free(buf);
+		fastrpc_buf_free(buf, false);
 	}
 
+	fastrpc_cached_buf_list_free(fl);
 	fastrpc_session_free(cctx, fl->sctx);
 	fastrpc_channel_ctx_put(cctx);
 
@@ -1570,6 +1664,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	INIT_LIST_HEAD(&fl->maps);
 	INIT_LIST_HEAD(&fl->mmaps);
 	INIT_LIST_HEAD(&fl->user);
+	INIT_LIST_HEAD(&fl->cached_bufs);
 	fl->tgid = current->tgid;
 	fl->cctx = cctx;
 	fl->is_secure_dev = fdevice->secure;
@@ -1600,7 +1695,7 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&bp, argp, sizeof(bp)))
 		return -EFAULT;
 
-	err = fastrpc_buf_alloc(fl, fl->sctx->dev, bp.size, &buf);
+	err = fastrpc_buf_alloc(fl, fl->sctx->dev, bp.size, USER_BUF, &buf);
 	if (err)
 		return err;
 	exp_info.ops = &fastrpc_dma_buf_ops;
@@ -1610,7 +1705,7 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 	buf->dmabuf = dma_buf_export(&exp_info);
 	if (IS_ERR(buf->dmabuf)) {
 		err = PTR_ERR(buf->dmabuf);
-		fastrpc_buf_free(buf);
+		fastrpc_buf_free(buf, false);
 		return err;
 	}
 
@@ -1805,7 +1900,7 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 		spin_lock(&fl->lock);
 		list_del(&buf->node);
 		spin_unlock(&fl->lock);
-		fastrpc_buf_free(buf);
+		fastrpc_buf_free(buf, false);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
 	}
@@ -1866,7 +1961,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, &buf);
+	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, USER_BUF, &buf);
 	if (err) {
 		dev_err(dev, "failed to allocate buffer\n");
 		return err;
@@ -1935,7 +2030,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 err_assign:
 	fastrpc_req_munmap_impl(fl, buf);
 err_invoke:
-	fastrpc_buf_free(buf);
+	fastrpc_buf_free(buf, false);
 
 	return err;
 }
@@ -2380,7 +2475,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		list_del(&buf->node);
 
 	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
+		fastrpc_buf_free(cctx->remote_heap, false);
 
 	of_platform_depopulate(&rpdev->dev);
 
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index f33d914..91c7c4f 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -64,6 +64,14 @@ enum fastrpc_proc_attr {
 	FASTRPC_MODE_PRIVILEGED		= (1 << 6),
 };
 
+ /* Types of fastrpc DMA bufs sent to DSP */
+ enum fastrpc_buf_type {
+	METADATA_BUF,
+	COPYDATA_BUF,
+	INITMEM_BUF,
+	USER_BUF,
+};
+
 /* Fastrpc attribute for memory protection of buffers */
 #define FASTRPC_ATTR_SECUREMAP	(1)
 
-- 
2.7.4

