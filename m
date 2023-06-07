Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C125B725DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjFGLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjFGLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:54:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F051BD4;
        Wed,  7 Jun 2023 04:54:43 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357AdBJ4003442;
        Wed, 7 Jun 2023 11:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=crJnwFdMcicgcZCckmfie44U2n+CsIGh9YorMoL7IOw=;
 b=L2JF0/+LKK+PE6Hj2+oAMI8VGlQIyKpc+0ExvJ52K+FczUAD1mEKuhUP9sXxQ7wv02og
 sLZS43PwfPc/pm7vb7UJv5nv7Iq2MfM/c0btFVpWv+x7G2P9f3ALRKsafECfN6Ojdc5g
 Q5yLGBKI0ziTLJs5Fmge9+cq3HZicKaLQg6SjzoDNo5mIcangOiqAOl1EH53wh2v4MeM
 Sq1trwOOiEBJ7iczDLtwt1NuFTAL7D1GTrU1xIZOhaW0rN3mJn37oSyAAwZEU/cLoTw3
 xmneP4TCzcN+WbJPTMvlyhdpVHrlwxAc9zoQZGI5footgUb6ABSWZT/TKPPpph9vrmQd nA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a719qtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 11:54:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357Bse9G014213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 11:54:40 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 04:54:38 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 2/2] misc: fastrpc: detect privileged processes based on group ID
Date:   Wed, 7 Jun 2023 17:24:24 +0530
Message-ID: <1686138864-17136-3-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686138864-17136-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1686138864-17136-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FdiivPkhXAOsnoFtJoGN4NZ2zkYmhkQQ
X-Proofpoint-ORIG-GUID: FdiivPkhXAOsnoFtJoGN4NZ2zkYmhkQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070099
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the information on privileged group IDs during rpmsg probing based
on DT property. Check if the process requesting an offload to remote
subsystem is privileged by comparing it's group ID with privileged
group ID. Initialization process attributes are updated for a
privileged process which is sent to remote process for resource
management.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d04..6c7db0b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -21,6 +21,7 @@
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/cred.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -166,6 +167,11 @@ struct fastrpc_mem_unmap_req_msg {
 	u64 len;
 };
 
+struct gid_list {
+	u32 *gids;
+	u32 gidcount;
+};
+
 struct fastrpc_msg {
 	int pid;		/* process group id */
 	int tid;		/* thread id */
@@ -277,6 +283,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *fdevice;
 	struct fastrpc_buf *remote_heap;
 	struct list_head invoke_interrupted_mmaps;
+	struct gid_list gidlist;
 	bool secure;
 	bool unsigned_support;
 	u64 dma_mask;
@@ -305,6 +312,7 @@ struct fastrpc_user {
 	spinlock_t lock;
 	/* lock for allocations */
 	struct mutex mutex;
+	struct gid_list gidlist;
 };
 
 static void fastrpc_free_map(struct kref *ref)
@@ -522,6 +530,31 @@ static void fastrpc_context_put_wq(struct work_struct *work)
 }
 
 #define CMP(aa, bb) ((aa) == (bb) ? 0 : (aa) < (bb) ? -1 : 1)
+
+static u32 sorted_lists_intersection(u32 *listA,
+		u32 lenA, u32 *listB, u32 lenB)
+{
+	u32 i = 0, j = 0;
+
+	while (i < lenA && j < lenB) {
+		if (listA[i] < listB[j])
+			i++;
+		else if (listA[i] > listB[j])
+			j++;
+		else
+			return listA[i];
+	}
+	return 0;
+}
+
+static int uint_cmp_func(const void *p1, const void *p2)
+{
+	u32 a1 = *((u32 *)p1);
+	u32 a2 = *((u32 *)p2);
+
+	return CMP(a1, a2);
+}
+
 static int olaps_cmp(const void *a, const void *b)
 {
 	struct fastrpc_buf_overlap *pa = (struct fastrpc_buf_overlap *)a;
@@ -1230,6 +1263,50 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
 	return false;
 }
 
+static int fastrpc_get_process_gids(struct gid_list *gidlist)
+{
+	struct group_info *group_info = get_current_groups();
+	int i, num_gids;
+	u32 *gids = NULL;
+
+	if (!group_info)
+		return -EFAULT;
+
+	num_gids = group_info->ngroups + 1;
+	gids = kcalloc(num_gids, sizeof(u32), GFP_KERNEL);
+	if (!gids)
+		return -ENOMEM;
+
+	/* Get the real GID */
+	gids[0] = __kgid_val(current_gid());
+
+	/* Get the supplemental GIDs */
+	for (i = 1; i < num_gids; i++)
+		gids[i] = __kgid_val(group_info->gid[i - 1]);
+
+	sort(gids, num_gids, sizeof(*gids), uint_cmp_func, NULL);
+	gidlist->gids = gids;
+	gidlist->gidcount = num_gids;
+
+	return 0;
+}
+
+static void fastrpc_check_privileged_process(struct fastrpc_user *fl,
+				struct fastrpc_init_create *init)
+{
+	u32 gid = sorted_lists_intersection(fl->gidlist.gids,
+			fl->gidlist.gidcount, fl->cctx->gidlist.gids,
+			fl->cctx->gidlist.gidcount);
+
+	/* disregard any privilege bits from userspace */
+	init->attrs &= (~FASTRPC_MODE_PRIVILEGED);
+	if (gid) {
+		dev_info(&fl->cctx->rpdev->dev, "%s: %s (PID %d, GID %u) is a privileged process\n",
+				__func__, current->comm, fl->tgid, gid);
+		init->attrs |= FASTRPC_MODE_PRIVILEGED;
+	}
+}
+
 static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 					      char __user *argp)
 {
@@ -1386,6 +1463,8 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
+	fastrpc_get_process_gids(&fl->gidlist);
+
 	inbuf.pgid = fl->tgid;
 	inbuf.namelen = strlen(current->comm) + 1;
 	inbuf.filelen = init.filelen;
@@ -1400,6 +1479,8 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 			goto err;
 	}
 
+	fastrpc_check_privileged_process(fl, &init);
+
 	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
 		       1024 * 1024);
 	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
@@ -1519,6 +1600,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	spin_lock_irqsave(&cctx->lock, flags);
 	list_del(&fl->user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
+	kfree(fl->gidlist.gids);
 
 	if (fl->init_mem)
 		fastrpc_buf_free(fl->init_mem);
@@ -2118,6 +2200,43 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	return err;
 }
 
+static int fastrpc_init_privileged_gids(struct device *dev, char *prop_name,
+						struct gid_list *gidlist)
+{
+	int err = 0;
+	u32 len = 0, i;
+	u32 *gids = NULL;
+
+	if (!of_find_property(dev->of_node, prop_name, &len))
+		return 0;
+	if (len == 0)
+		return 0;
+
+	len /= sizeof(u32);
+	gids = kcalloc(len, sizeof(u32), GFP_KERNEL);
+	if (!gids)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		err = of_property_read_u32_index(dev->of_node, prop_name,
+								i, &gids[i]);
+		if (err) {
+			dev_err(dev, "%s: failed to read GID %u\n",
+					__func__, i);
+			goto read_error;
+		}
+		dev_info(dev, "adsprpc: %s: privileged GID: %u\n", __func__, gids[i]);
+	}
+	sort(gids, len, sizeof(*gids), uint_cmp_func, NULL);
+	gidlist->gids = gids;
+	gidlist->gidcount = len;
+
+	return 0;
+read_error:
+	kfree(gids);
+	return err;
+}
+
 static const struct file_operations fastrpc_fops = {
 	.open = fastrpc_device_open,
 	.release = fastrpc_device_release,
@@ -2277,6 +2396,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!data)
 		return -ENOMEM;
 
+	err = fastrpc_init_privileged_gids(rdev, "qcom,fastrpc-gids", &data->gidlist);
+	if (err)
+		dev_err(rdev, "Privileged gids init failed.\n");
+
 	if (vmcount) {
 		data->vmcount = vmcount;
 		data->perms = BIT(QCOM_SCM_VMID_HLOS);
@@ -2382,6 +2505,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
+	kfree(cctx->gidlist.gids);
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);
-- 
2.7.4

