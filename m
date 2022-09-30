Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADE75F02F0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiI3CqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiI3CqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:46:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE20D1DCC59;
        Thu, 29 Sep 2022 19:46:13 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MdvgY0pDhzHqVF;
        Fri, 30 Sep 2022 10:43:53 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:46:11 +0800
Received: from huawei.com (10.69.192.56) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 10:46:11 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <wangzhou1@hisilicon.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>
Subject: [PATCH] crypto/hisilicon: Add null judgment to the callback interface
Date:   Fri, 30 Sep 2022 10:43:20 +0800
Message-ID: <20220930024320.29922-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The algorithm acceleration function interface provided by the
current crypto subsystem is in asynchronous mode, but some users
will call it in synchronous mode, thus not providing a callback
interface for the "base.complete" of the request.

In this usage scenario, there is no problem in using software to
complete encryption and decryption operations. But if the hardware
driver is loaded, a kernel calltrace error will be generated
because the "base.complete" callback interface is empty.

Kernel log:
 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : 0x0
 lr : sec_skcipher_callback+0x108/0x140 [hisi_sec2]
 sp : ffff80002cda3cb0
 x29: ffff80002cda3cb0 x28: ffff0020a9a56080 x27: ffff2040076a4800
 x26: 0000000000000000 x25: dead000000000100 x24: dead000000000122
 x23: ffff0020881eb4d0 x22: ffff0020960c6f00 x21: ffff0020881eb4b0
 x20: ffff0020881eb478 x19: ffff2040076a4880 x18: 000000000000001c
 x17: 00000000a3f246e1 x16: ffffb38bc5e73d40 x15: 000000006c63877d
 x14: 0000000000000000 x13: 0000000000000000 x12: ffff2040063b1dd0
 x11: ffff2040063b1da8 x10: ffff2040063b1da8 x9 : ffffb38b8da71f78
 x8 : ffff2040063b1dd0 x7 : 0000000000000000 x6 : ffff2040063b1fd0
 x5 : 0000000000000228 x4 : 0000000000000000 x3 : ffff00209ba33000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2040076a4820
 Call trace:
  0x0
  sec_req_cb+0xc8/0x254 [hisi_sec2]
  qm_work_process+0x1d8/0x330 [hisi_qm]
  process_one_work+0x1e0/0x450
  worker_thread+0x158/0x450
  kthread+0x118/0x120
  ret_from_fork+0x10/0x20
  Code: bad PC value
  ---[ end trace 0000000000000000 ]---

In order to prevent the occurrence of kernel errors in this scenario,
it is necessary to add a judgment on whether the "base.complete"
interface of the hardware device driver is empty.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 12 ++++++++----
 drivers/crypto/hisilicon/sec2/sec_crypto.c  | 12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 3ba6f15deafc..5b09f4a72020 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -430,7 +430,8 @@ static void hpre_dh_cb(struct hpre_ctx *ctx, void *resp)
 		atomic64_inc(&dfx[HPRE_OVER_THRHLD_CNT].value);
 
 	hpre_hw_data_clr_all(ctx, req, areq->dst, areq->src);
-	kpp_request_complete(areq, ret);
+	if (areq->base.complete)
+		kpp_request_complete(areq, ret);
 	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
 }
 
@@ -451,7 +452,8 @@ static void hpre_rsa_cb(struct hpre_ctx *ctx, void *resp)
 	areq = req->areq.rsa;
 	areq->dst_len = ctx->key_sz;
 	hpre_hw_data_clr_all(ctx, req, areq->dst, areq->src);
-	akcipher_request_complete(areq, ret);
+	if (areq->base.complete)
+		akcipher_request_complete(areq, ret);
 	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
 }
 
@@ -1460,7 +1462,8 @@ static void hpre_ecdh_cb(struct hpre_ctx *ctx, void *resp)
 	memmove(p + curve_sz, p + areq->dst_len - curve_sz, curve_sz);
 
 	hpre_ecdh_hw_data_clr_all(ctx, req, areq->dst, areq->src);
-	kpp_request_complete(areq, ret);
+	if (areq->base.complete)
+		kpp_request_complete(areq, ret);
 
 	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
 }
@@ -1766,7 +1769,8 @@ static void hpre_curve25519_cb(struct hpre_ctx *ctx, void *resp)
 	hpre_key_to_big_end(sg_virt(areq->dst), CURVE25519_KEY_SIZE);
 
 	hpre_curve25519_hw_data_clr_all(ctx, req, areq->dst, areq->src);
-	kpp_request_complete(areq, ret);
+	if (areq->base.complete)
+		kpp_request_complete(areq, ret);
 
 	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
 }
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 77c9f13cf69a..b9d74d3ac12c 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -1416,12 +1416,14 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
 			break;
 
 		backlog_sk_req = backlog_req->c_req.sk_req;
-		backlog_sk_req->base.complete(&backlog_sk_req->base,
+		if (backlog_sk_req->base.complete)
+			backlog_sk_req->base.complete(&backlog_sk_req->base,
 						-EINPROGRESS);
 		atomic64_inc(&ctx->sec->debug.dfx.recv_busy_cnt);
 	}
 
-	sk_req->base.complete(&sk_req->base, err);
+	if (sk_req->base.complete)
+		sk_req->base.complete(&sk_req->base, err);
 }
 
 static void set_aead_auth_iv(struct sec_ctx *ctx, struct sec_req *req)
@@ -1694,12 +1696,14 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
 			break;
 
 		backlog_aead_req = backlog_req->aead_req.aead_req;
-		backlog_aead_req->base.complete(&backlog_aead_req->base,
+		if (backlog_aead_req->base.complete)
+			backlog_aead_req->base.complete(&backlog_aead_req->base,
 						-EINPROGRESS);
 		atomic64_inc(&c->sec->debug.dfx.recv_busy_cnt);
 	}
 
-	a_req->base.complete(&a_req->base, err);
+	if (a_req->base.complete)
+		a_req->base.complete(&a_req->base, err);
 }
 
 static void sec_request_uninit(struct sec_ctx *ctx, struct sec_req *req)
-- 
2.33.0

