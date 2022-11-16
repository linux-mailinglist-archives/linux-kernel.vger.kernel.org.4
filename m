Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4062B502
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiKPIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiKPIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:20:30 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122FE26C;
        Wed, 16 Nov 2022 00:20:26 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="96127459"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="96127459"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Nov 2022 17:20:24 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EEC8CD66A0;
        Wed, 16 Nov 2022 17:20:23 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 27FDACFF82;
        Wed, 16 Nov 2022 17:20:23 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id F0DEB2340D52;
        Wed, 16 Nov 2022 17:20:21 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v6 07/10] RDMA/rxe: Implement flush execution in responder side
Date:   Wed, 16 Nov 2022 16:19:48 +0800
Message-Id: <20221116081951.32750-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116081951.32750-1-lizhijian@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27266.006
X-TMASE-Result: 10--10.026900-10.000000
X-TMASE-MatchedRID: c6/7RAzFTV0YQkBYLWi1BUXBhxFdFgcQltF+xW+zhUiPaLJ/Ca3ST6Yn
        mMLJRh+J/4scBkl4LgDSKuuqNb2DumZmwCqBnuAf8Jb881FGn9k6rt3TPmIRUToUdFbHYUawvwU
        evDt+uW5/XjpbSJS7a2950PcJhKMdnpdzfoA7wecvYlQ7uxD3/BZSD+Gbjz3I2h2Q1gVs6s4Ipj
        Lek0l1pffC3ymPybwF7i7ibx9W3/ns7aQkqkpFyoQTwECUVvOpeF+F9LT9kRKKS8s/FMqmOD3vM
        QJZlrWj7p17JCLIX7chNte7Oe3mUMPPAZZxvyXfK+Mvg9XOyneX2rvknNYlE4G+e1larbBtdr1N
        S4jlWBFEwmBZjmgait2ix/jbchn5XjASuXbGkhkRyVsAxhhjrJs7CfArGWFOmyiLZetSf8mfop0
        ytGwvXiq2rl3dzGQ1Nf8r/wCEScMpA9Xluo86BGHcRVcwSOyQKZ6V2CjzgUqdU1XnrkYOkA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the requested placement types that also registered in the destination
memory region are acceptable.
Otherwise, responder will also reply NAK "Remote Access Error" if it
found a placement type violation.

We will persist data via arch_wb_cache_pmem(), which could be
architecture specific.

This commit also add 2 helpers to update qp.resp from the incoming packet.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
v6: call iova_to_vaddr to transform iova
v5: add QP attr check for flush access
    rename flush_nvdimm_iova -> rxe_flush_pmem_iova()
v4: add send_read_response_ack and flush resource
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    |  36 ++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  | 176 +++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |   6 +
 4 files changed, 199 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..944d564a11cd 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -68,6 +68,7 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fd423c015be0..592965ee89fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/libnvdimm.h>
+
 #include "rxe.h"
 #include "rxe_loc.h"
 
@@ -196,6 +198,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	mr->offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->ibmr.type = IB_MR_TYPE_USER;
+	mr->ibmr.page_size = PAGE_SIZE;
 
 	return 0;
 
@@ -303,6 +306,39 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	return addr;
 }
 
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
+{
+	size_t offset;
+
+	if (length == 0)
+		return 0;
+
+	if (mr->ibmr.type == IB_MR_TYPE_DMA)
+		return -EFAULT;
+
+	offset = (iova - mr->ibmr.iova + mr->offset) & mr->page_mask;
+	while (length > 0) {
+		u8 *va;
+		int bytes;
+
+		bytes = mr->ibmr.page_size - offset;
+		if (bytes > length)
+			bytes = length;
+
+		va = iova_to_vaddr(mr, iova, length);
+		if (!va)
+			return -EFAULT;
+
+		arch_wb_cache_pmem(va, bytes);
+
+		length -= bytes;
+		iova += bytes;
+		offset = 0;
+	}
+
+	return 0;
+}
+
 /* copy data from a range (vaddr, vaddr+length-1) to or from
  * a mr object starting at iova.
  */
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 8caa9941e70e..43cf3fb04674 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -22,6 +22,7 @@ enum resp_states {
 	RESPST_EXECUTE,
 	RESPST_READ_REPLY,
 	RESPST_ATOMIC_REPLY,
+	RESPST_PROCESS_FLUSH,
 	RESPST_COMPLETE,
 	RESPST_ACKNOWLEDGE,
 	RESPST_CLEANUP,
@@ -57,6 +58,7 @@ static char *resp_state_name[] = {
 	[RESPST_EXECUTE]			= "EXECUTE",
 	[RESPST_READ_REPLY]			= "READ_REPLY",
 	[RESPST_ATOMIC_REPLY]			= "ATOMIC_REPLY",
+	[RESPST_PROCESS_FLUSH]			= "PROCESS_FLUSH",
 	[RESPST_COMPLETE]			= "COMPLETE",
 	[RESPST_ACKNOWLEDGE]			= "ACKNOWLEDGE",
 	[RESPST_CLEANUP]			= "CLEANUP",
@@ -256,19 +258,38 @@ static enum resp_states check_op_seq(struct rxe_qp *qp,
 	}
 }
 
+static bool check_qp_attr_access(struct rxe_qp *qp,
+				 struct rxe_pkt_info *pkt)
+{
+	if (((pkt->mask & RXE_READ_MASK) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
+	    ((pkt->mask & RXE_WRITE_MASK) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_WRITE)) ||
+	    ((pkt->mask & RXE_ATOMIC_MASK) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_ATOMIC))) {
+		return false;
+	}
+
+	if (pkt->mask & RXE_FLUSH_MASK) {
+		u32 flush_type = feth_plt(pkt);
+
+		if ((flush_type & IB_FLUSH_GLOBAL &&
+		     !(qp->attr.qp_access_flags & IB_ACCESS_FLUSH_GLOBAL)) ||
+		    (flush_type & IB_FLUSH_PERSISTENT &&
+		     !(qp->attr.qp_access_flags & IB_ACCESS_FLUSH_PERSISTENT)))
+			return false;
+	}
+
+	return true;
+}
+
 static enum resp_states check_op_valid(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
 	switch (qp_type(qp)) {
 	case IB_QPT_RC:
-		if (((pkt->mask & RXE_READ_MASK) &&
-		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
-		    ((pkt->mask & RXE_WRITE_MASK) &&
-		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_WRITE)) ||
-		    ((pkt->mask & RXE_ATOMIC_MASK) &&
-		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_ATOMIC))) {
+		if (!check_qp_attr_access(qp, pkt))
 			return RESPST_ERR_UNSUPPORTED_OPCODE;
-		}
 
 		break;
 
@@ -425,6 +446,23 @@ static enum resp_states check_length(struct rxe_qp *qp,
 	return RESPST_CHK_RKEY;
 }
 
+static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
+{
+	qp->resp.va = reth_va(pkt);
+	qp->resp.offset = 0;
+	qp->resp.rkey = reth_rkey(pkt);
+	qp->resp.resid = reth_len(pkt);
+	qp->resp.length = reth_len(pkt);
+}
+
+static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
+{
+	qp->resp.va = atmeth_va(pkt);
+	qp->resp.offset = 0;
+	qp->resp.rkey = atmeth_rkey(pkt);
+	qp->resp.resid = sizeof(u64);
+}
+
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -436,23 +474,26 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	u32 pktlen;
 	int mtu = qp->mtu;
 	enum resp_states state;
-	int access;
+	int access = 0;
 
 	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
-		if (pkt->mask & RXE_RETH_MASK) {
-			qp->resp.va = reth_va(pkt);
-			qp->resp.offset = 0;
-			qp->resp.rkey = reth_rkey(pkt);
-			qp->resp.resid = reth_len(pkt);
-			qp->resp.length = reth_len(pkt);
-		}
+		if (pkt->mask & RXE_RETH_MASK)
+			qp_resp_from_reth(qp, pkt);
+
 		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
 						     : IB_ACCESS_REMOTE_WRITE;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		u32 flush_type = feth_plt(pkt);
+
+		if (pkt->mask & RXE_RETH_MASK)
+			qp_resp_from_reth(qp, pkt);
+
+		if (flush_type & IB_FLUSH_GLOBAL)
+			access |= IB_ACCESS_FLUSH_GLOBAL;
+		if (flush_type & IB_FLUSH_PERSISTENT)
+			access |= IB_ACCESS_FLUSH_PERSISTENT;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
-		qp->resp.va = atmeth_va(pkt);
-		qp->resp.offset = 0;
-		qp->resp.rkey = atmeth_rkey(pkt);
-		qp->resp.resid = sizeof(u64);
+		qp_resp_from_atmeth(qp, pkt);
 		access = IB_ACCESS_REMOTE_ATOMIC;
 	} else {
 		return RESPST_EXECUTE;
@@ -501,12 +542,21 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		}
 	}
 
+	if (pkt->mask & RXE_FLUSH_MASK) {
+		/* FLUSH MR may not set va or resid
+		 * no need to check range since we will flush whole mr
+		 */
+		if (feth_sel(pkt) == IB_FLUSH_MR)
+			goto skip_check_range;
+	}
+
 	if (mr_check_range(mr, va + qp->resp.offset, resid)) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
 
-	if (pkt->mask & RXE_WRITE_MASK)	 {
+skip_check_range:
+	if (pkt->mask & RXE_WRITE_MASK) {
 		if (resid > mtu) {
 			if (pktlen != mtu || bth_pad(pkt)) {
 				state = RESPST_ERR_LENGTH;
@@ -610,11 +660,61 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
 		res->last_psn = pkt->psn;
 		res->cur_psn = pkt->psn;
 		break;
+	case RXE_FLUSH_MASK:
+		res->flush.va = qp->resp.va + qp->resp.offset;
+		res->flush.length = qp->resp.length;
+		res->flush.type = feth_plt(pkt);
+		res->flush.level = feth_sel(pkt);
 	}
 
 	return res;
 }
 
+static enum resp_states process_flush(struct rxe_qp *qp,
+				       struct rxe_pkt_info *pkt)
+{
+	u64 length, start;
+	struct rxe_mr *mr = qp->resp.mr;
+	struct resp_res *res = qp->resp.res;
+
+	/* oA19-14, oA19-15 */
+	if (res && res->replay)
+		return RESPST_ACKNOWLEDGE;
+	else if (!res) {
+		res = rxe_prepare_res(qp, pkt, RXE_FLUSH_MASK);
+		qp->resp.res = res;
+	}
+
+	if (res->flush.level == IB_FLUSH_RANGE) {
+		start = res->flush.va;
+		length = res->flush.length;
+	} else { /* level == IB_FLUSH_MR */
+		start = mr->ibmr.iova;
+		length = mr->ibmr.length;
+	}
+
+	if (res->flush.type & IB_FLUSH_PERSISTENT) {
+		if (rxe_flush_pmem_iova(mr, start, length))
+			return RESPST_ERR_RKEY_VIOLATION;
+		/* Make data persistent. */
+		wmb();
+	} else if (res->flush.type & IB_FLUSH_GLOBAL) {
+		/* Make data global visibility. */
+		wmb();
+	}
+
+	qp->resp.msn++;
+
+	/* next expected psn, read handles this separately */
+	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+	qp->resp.ack_psn = qp->resp.psn;
+
+	qp->resp.opcode = pkt->opcode;
+	qp->resp.status = IB_WC_SUCCESS;
+
+	return RESPST_ACKNOWLEDGE;
+}
+
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
@@ -916,6 +1016,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		return RESPST_READ_REPLY;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
 		return RESPST_ATOMIC_REPLY;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		return RESPST_PROCESS_FLUSH;
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1089,6 +1191,19 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 	return ret;
 }
 
+static int send_read_response_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
+{
+	int ret = send_common_ack(qp, syndrome, psn,
+			IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY,
+			"RDMA READ response of length zero ACK");
+
+	/* have to clear this since it is used to trigger
+	 * long read replies
+	 */
+	qp->resp.res = NULL;
+	return ret;
+}
+
 static enum resp_states acknowledge(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt)
 {
@@ -1099,6 +1214,8 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 		send_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
 		send_atomic_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
+	else if (pkt->mask & RXE_FLUSH_MASK)
+		send_read_response_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 	else if (bth_ack(pkt))
 		send_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 
@@ -1155,6 +1272,22 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 		/* SEND. Ack again and cleanup. C9-105. */
 		send_ack(qp, AETH_ACK_UNLIMITED, prev_psn);
 		return RESPST_CLEANUP;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		struct resp_res *res;
+
+		/* Find the operation in our list of responder resources. */
+		res = find_resource(qp, pkt->psn);
+		if (res) {
+			res->replay = 1;
+			res->cur_psn = pkt->psn;
+			qp->resp.res = res;
+			rc = RESPST_PROCESS_FLUSH;
+			goto out;
+		}
+
+		/* Resource not found. Class D error. Drop the request. */
+		rc = RESPST_CLEANUP;
+		goto out;
 	} else if (pkt->mask & RXE_READ_MASK) {
 		struct resp_res *res;
 
@@ -1348,6 +1481,9 @@ int rxe_responder(void *arg)
 		case RESPST_ATOMIC_REPLY:
 			state = atomic_reply(qp, pkt);
 			break;
+		case RESPST_PROCESS_FLUSH:
+			state = process_flush(qp, pkt);
+			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
 			break;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 22a299b0a9f0..19ddfa890480 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -165,6 +165,12 @@ struct resp_res {
 			u64		va;
 			u32		resid;
 		} read;
+		struct {
+			u32		length;
+			u64		va;
+			u8		type;
+			u8		level;
+		} flush;
 	};
 };
 
-- 
2.31.1

