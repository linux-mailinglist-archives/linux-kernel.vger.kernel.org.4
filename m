Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A072973D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbjFIKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbjFIKl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353A01FDC;
        Fri,  9 Jun 2023 03:40:04 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359AJMaq016557;
        Fri, 9 Jun 2023 10:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1Mx5zaCc4BAFmXKZXl06MSVCN40RKvwkVuuo/nEoGLI=;
 b=iyljq8RHyll58dtbJthgsQAuycKgXm103r5Ivs+ck/r/yJen1b+rAw20zzCsbA5FvvOG
 N1bEZZBFqsDnvDlZWYGI+Rj3ddryOeE9kh7u/YzGH2+/zdFxVrTiy/p0Je6OSmhYokXj
 v0pWnNEDIlN37KqA2x+fjC3x7owdNWngNIrGhx2rce1l25LwwiaevZ7dZLEnMEsdYIFG
 VoAgUwhRdCdr3EOX5SA8TIVc4SWyO+0TKmP0NqvIvDGQ6hUsFbLszFh8cdctJCdYUe+X
 tfWR6uAffjCvJlbKLid+vJqHw8Sw/vn32/9GFEiDcNNL03UDcrgFG5089f5G3KGa5yXU Uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3vu4gn90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:40:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359Ae0hL027348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 10:40:01 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 03:39:57 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, <quic_anane@quicinc.com>
Subject: [PATCH v1 2/2] misc: fastrpc: Add persistent header buffer support
Date:   Fri, 9 Jun 2023 16:09:47 +0530
Message-ID: <1686307187-15199-3-git-send-email-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: vB4PLFwChLabtF-Jc0c9zWpveYkVfoPD
X-Proofpoint-ORIG-GUID: vB4PLFwChLabtF-Jc0c9zWpveYkVfoPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This change enables the usage of persistent header buffers which
are allocated during process initialization and is mapped to CDSP.
This mechanism helps in reducing the RPC overhead for remote calls.

For any user process remote RPC call to CDSP, it is tried to use
persistent header buffers. In case all persistent buffers are
already in use, there is a fallback to cached buffer usage and
allocation using DMA API.

Co-developed-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 215 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 173 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a961a66..0132b63 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -44,6 +44,8 @@
 /* Maximum buffers cached in cached buffer list */
 #define FASTRPC_MAX_CACHED_BUFS (32)
 #define FASTRPC_MAX_CACHE_BUF_SIZE (8*1024*1024)
+/* Max no. of persistent headers pre-allocated per user process */
+#define FASTRPC_MAX_PERSISTENT_HEADERS    (25)
 
 /* Add memory to static PD pool, protection thru XPU */
 #define ADSP_MMAP_HEAP_ADDR  4
@@ -54,7 +56,9 @@
 /* Add memory to userPD pool, for user heap */
 #define ADSP_MMAP_ADD_PAGES 0x1000
 /* Add memory to userPD pool, for LLC heap */
-#define ADSP_MMAP_ADD_PAGES_LLC 0x3000,
+#define ADSP_MMAP_ADD_PAGES_LLC 0x3000
+/* Map persistent header buffer on DSP */
+#define ADSP_MMAP_PERSIST_HDR  0x4000
 
 #define DSP_UNSUPPORTED_API (0x80000414)
 /* MAX NUMBER of DSP ATTRIBUTES SUPPORTED */
@@ -208,6 +212,7 @@ struct fastrpc_buf {
 	/* mmap support */
 	struct list_head node; /* list of user requested mmaps */
 	uintptr_t raddr;
+	bool in_use;
 };
 
 struct fastrpc_dma_buf_attachment {
@@ -303,11 +308,17 @@ struct fastrpc_user {
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sctx;
 	struct fastrpc_buf *init_mem;
+	/* Pre-allocated header buffer */
+	struct fastrpc_buf *pers_hdr_buf;
+	/* Pre-allocated buffer divided into N chunks */
+	struct fastrpc_buf *hdr_bufs;
 
 	int tgid;
 	int pd;
 	/* total cached buffers */
 	u32 num_cached_buf;
+	/* total persistent headers */
+	u32 num_pers_hdrs;
 	bool is_secure_dev;
 	/* Lock for lists */
 	spinlock_t lock;
@@ -399,6 +410,37 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 	return ret;
 }
 
+static bool fastrpc_get_persistent_buf(struct fastrpc_user *fl,
+		size_t size, int buf_type, struct fastrpc_buf **obuf)
+{
+	u32 i = 0;
+	bool found = false;
+	struct fastrpc_buf *buf = NULL;
+
+	spin_lock(&fl->lock);
+	/*
+	 * Persistent header buffer can be used only if
+	 * metadata length is less than 1 page size.
+	 */
+	if (!fl->num_pers_hdrs || buf_type != METADATA_BUF || size > PAGE_SIZE) {
+		spin_unlock(&fl->lock);
+		return found;
+	}
+
+	for (i = 0; i < fl->num_pers_hdrs; i++) {
+		buf = &fl->hdr_bufs[i];
+		/* If buffer not in use, then assign it for requested alloc */
+		if (!buf->in_use) {
+			buf->in_use = true;
+			*obuf = buf;
+			found = true;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+	return found;
+}
+
 static void __fastrpc_buf_free(struct fastrpc_buf *buf)
 {
 	dma_free_coherent(buf->dev, buf->size, buf->virt,
@@ -430,6 +472,15 @@ static void fastrpc_cached_buf_list_add(struct fastrpc_buf *buf)
 
 static void fastrpc_buf_free(struct fastrpc_buf *buf, bool cache)
 {
+	struct fastrpc_user *fl = buf->fl;
+
+	if (buf->in_use) {
+		/* Don't free persistent header buf. Just mark as available */
+		spin_lock(&fl->lock);
+		buf->in_use = false;
+		spin_unlock(&fl->lock);
+		return;
+	}
 	if (cache)
 		fastrpc_cached_buf_list_add(buf);
 	else
@@ -523,6 +574,8 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 	int ret;
 	struct fastrpc_buf *buf;
 
+	if (fastrpc_get_persistent_buf(fl, size, buf_type, obuf))
+		return 0;
 	if (fastrpc_get_cached_buf(fl, size, buf_type, obuf))
 		return 0;
 	ret = __fastrpc_buf_alloc(fl, dev, size, obuf);
@@ -1305,6 +1358,107 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	return err;
 }
 
+static int fastrpc_mem_map_to_dsp(struct fastrpc_user *fl, int fd, int offset,
+				u32 flags, u32 va, u64 phys,
+				size_t size, uintptr_t *raddr)
+{
+	struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
+	struct fastrpc_mem_map_req_msg req_msg = { 0 };
+	struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
+	struct fastrpc_phy_page pages = { 0 };
+	struct device *dev = fl->sctx->dev;
+	int err = 0;
+	u32 sc;
+
+	req_msg.pgid = fl->tgid;
+	req_msg.fd = fd;
+	req_msg.offset = offset;
+	req_msg.vaddrin = va;
+	req_msg.flags = flags;
+	req_msg.num = sizeof(pages);
+	req_msg.data_len = 0;
+
+	args[0].ptr = (u64) (uintptr_t) &req_msg;
+	args[0].length = sizeof(req_msg);
+
+	pages.addr = phys;
+	pages.size = size;
+
+	args[1].ptr = (u64) (uintptr_t) &pages;
+	args[1].length = sizeof(pages);
+
+	args[2].ptr = (u64) (uintptr_t) &pages;
+	args[2].length = 0;
+
+	args[3].ptr = (u64) (uintptr_t) &rsp_msg;
+	args[3].length = sizeof(rsp_msg);
+
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
+	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
+	if (err) {
+		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
+			fd, va, size);
+		return err;
+	}
+	*raddr = rsp_msg.vaddr;
+
+	return 0;
+}
+
+static int fastrpc_create_persistent_headers(struct fastrpc_user *fl)
+{
+	int err = 0;
+	int i = 0;
+	u64 virtb = 0;
+	struct device *dev = fl->sctx->dev;
+	struct fastrpc_buf *hdr_bufs, *buf, *pers_hdr_buf = NULL;
+	u32 num_pers_hdrs = 0;
+	size_t hdr_buf_alloc_len = 0;
+
+	/*
+	 * Pre-allocate memory for persistent header buffers based
+	 * on concurrency info passed by user. Upper limit enforced.
+	 */
+	num_pers_hdrs = FASTRPC_MAX_PERSISTENT_HEADERS;
+	hdr_buf_alloc_len = num_pers_hdrs * PAGE_SIZE;
+	err = fastrpc_buf_alloc(fl, dev, hdr_buf_alloc_len,
+			METADATA_BUF, &pers_hdr_buf);
+	if (err)
+		return err;
+
+	virtb = (u64) (uintptr_t)(pers_hdr_buf->virt);
+	err = fastrpc_mem_map_to_dsp(fl, -1, 0,
+				ADSP_MMAP_PERSIST_HDR, 0, (u64) (uintptr_t)(pers_hdr_buf->phys),
+				pers_hdr_buf->size, &pers_hdr_buf->raddr);
+	if (err)
+		goto err_dsp_map;
+
+	hdr_bufs = kcalloc(num_pers_hdrs, sizeof(struct fastrpc_buf),
+				GFP_KERNEL);
+	if (!hdr_bufs)
+		return -ENOMEM;
+
+	spin_lock(&fl->lock);
+	fl->pers_hdr_buf = pers_hdr_buf;
+	fl->num_pers_hdrs = num_pers_hdrs;
+	fl->hdr_bufs = hdr_bufs;
+	for (i = 0; i < num_pers_hdrs; i++) {
+		buf = &fl->hdr_bufs[i];
+		buf->fl = fl;
+		buf->virt = (void *)(virtb + (i * PAGE_SIZE));
+		buf->phys = pers_hdr_buf->phys + (i * PAGE_SIZE);
+		buf->size = PAGE_SIZE;
+		buf->type = pers_hdr_buf->type;
+		buf->in_use = false;
+	}
+	spin_unlock(&fl->lock);
+
+	return 0;
+err_dsp_map:
+	fastrpc_buf_free(pers_hdr_buf, 0);
+	return err;
+}
+
 static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_request)
 {
 	/* Check if the device node is non-secure and channel is secure*/
@@ -1537,6 +1691,12 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	if (err)
 		goto err_invoke;
 
+	if (fl->cctx->domain_id == CDSP_DOMAIN_ID) {
+		err = fastrpc_create_persistent_headers(fl);
+		if (err)
+			goto err_invoke;
+	}
+
 	kfree(args);
 
 	return 0;
@@ -1629,6 +1789,10 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 		fastrpc_buf_free(buf, false);
 	}
 
+	if (fl->pers_hdr_buf)
+		fastrpc_buf_free(fl->pers_hdr_buf, false);
+	kfree(fl->hdr_bufs);
+
 	fastrpc_cached_buf_list_free(fl);
 	fastrpc_session_free(cctx, fl->sctx);
 	fastrpc_channel_ctx_put(cctx);
@@ -2089,16 +2253,11 @@ static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)
 
 static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 {
-	struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
-	struct fastrpc_mem_map_req_msg req_msg = { 0 };
-	struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
 	struct fastrpc_mem_unmap req_unmap = { 0 };
-	struct fastrpc_phy_page pages = { 0 };
-	struct fastrpc_mem_map req;
+	struct fastrpc_mem_map req = {0};
 	struct device *dev = fl->sctx->dev;
 	struct fastrpc_map *map = NULL;
 	int err;
-	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -2110,57 +2269,29 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	req_msg.pgid = fl->tgid;
-	req_msg.fd = req.fd;
-	req_msg.offset = req.offset;
-	req_msg.vaddrin = req.vaddrin;
 	map->va = (void *) (uintptr_t) req.vaddrin;
-	req_msg.flags = req.flags;
-	req_msg.num = sizeof(pages);
-	req_msg.data_len = 0;
-
-	args[0].ptr = (u64) (uintptr_t) &req_msg;
-	args[0].length = sizeof(req_msg);
-
-	pages.addr = map->phys;
-	pages.size = map->size;
-
-	args[1].ptr = (u64) (uintptr_t) &pages;
-	args[1].length = sizeof(pages);
-
-	args[2].ptr = (u64) (uintptr_t) &pages;
-	args[2].length = 0;
-
-	args[3].ptr = (u64) (uintptr_t) &rsp_msg;
-	args[3].length = sizeof(rsp_msg);
-
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
+	/* map to dsp, get virtual adrress for the user*/
+	err = fastrpc_mem_map_to_dsp(fl, map->fd, req.offset,
+					req.flags, req.vaddrin, map->phys,
+					map->size, (uintptr_t *)&req.vaddrout);
 	if (err) {
-		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
-			req.fd, req.vaddrin, map->size);
+		dev_err(dev, "failed to map buffer on dsp, fd = %d\n", map->fd);
 		goto err_invoke;
 	}
 
 	/* update the buffer to be able to deallocate the memory on the DSP */
-	map->raddr = rsp_msg.vaddr;
-
-	/* let the client know the address to use */
-	req.vaddrout = rsp_msg.vaddr;
+	map->raddr = req.vaddrout;
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
 		/* unmap the memory and release the buffer */
-		req_unmap.vaddr = (uintptr_t) rsp_msg.vaddr;
+		req_unmap.vaddr = (uintptr_t)req.vaddrout;
 		req_unmap.length = map->size;
 		fastrpc_req_mem_unmap_impl(fl, &req_unmap);
 		return -EFAULT;
 	}
-
 	return 0;
-
 err_invoke:
 	fastrpc_map_put(map);
-
 	return err;
 }
 
-- 
2.7.4

