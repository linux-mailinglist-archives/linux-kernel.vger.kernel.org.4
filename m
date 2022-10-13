Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B004B5FD52C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJMGsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJMGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:48:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A102142C8B;
        Wed, 12 Oct 2022 23:48:29 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mp0Th1s51zHv4C;
        Thu, 13 Oct 2022 14:48:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 14:48:25 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <sfrench@samba.org>, <pc@cjr.nz>, <lsahlber@redhat.com>,
        <sprasad@microsoft.com>, <linux-cifs@vger.kernel.org>
CC:     <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>,
        <yebin10@huawei.com>
Subject: [PATCH -next 1/2] smb3: refactor about 'smb3_init_transform_rq'
Date:   Thu, 13 Oct 2022 15:10:34 +0800
Message-ID: <20221013071035.2890124-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221013071035.2890124-1-yebin10@huawei.com>
References: <20221013071035.2890124-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce 'orq' and 'nrq' variable for cleanup code. No functional change.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/cifs/smb2ops.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 421be43af425..180f0260cbc4 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4457,21 +4457,24 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	int rc = -ENOMEM;
 
 	for (i = 1; i < num_rqst; i++) {
-		npages = old_rq[i - 1].rq_npages;
+		struct smb_rqst *orq = old_rq + i - 1;
+		struct smb_rqst *nrq = new_rq + i;
+
+		npages = orq->rq_npages;
 		pages = kmalloc_array(npages, sizeof(struct page *),
 				      GFP_KERNEL);
 		if (!pages)
 			goto err_free;
 
-		new_rq[i].rq_pages = pages;
-		new_rq[i].rq_npages = npages;
-		new_rq[i].rq_offset = old_rq[i - 1].rq_offset;
-		new_rq[i].rq_pagesz = old_rq[i - 1].rq_pagesz;
-		new_rq[i].rq_tailsz = old_rq[i - 1].rq_tailsz;
-		new_rq[i].rq_iov = old_rq[i - 1].rq_iov;
-		new_rq[i].rq_nvec = old_rq[i - 1].rq_nvec;
+		nrq->rq_pages = pages;
+		nrq->rq_npages = npages;
+		nrq->rq_offset = orq->rq_offset;
+		nrq->rq_pagesz = orq->rq_pagesz;
+		nrq->rq_tailsz = orq->rq_tailsz;
+		nrq->rq_iov = orq->rq_iov;
+		nrq->rq_nvec = orq->rq_nvec;
 
-		orig_len += smb_rqst_len(server, &old_rq[i - 1]);
+		orig_len += smb_rqst_len(server, orq);
 
 		for (j = 0; j < npages; j++) {
 			pages[j] = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
@@ -4484,14 +4487,14 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 			char *dst, *src;
 			unsigned int offset, len;
 
-			rqst_page_get_length(&new_rq[i], j, &len, &offset);
+			rqst_page_get_length(nrq, j, &len, &offset);
 
-			dst = (char *) kmap(new_rq[i].rq_pages[j]) + offset;
-			src = (char *) kmap(old_rq[i - 1].rq_pages[j]) + offset;
+			dst = (char *) kmap(nrq->rq_pages[j]) + offset;
+			src = (char *) kmap(orq->rq_pages[j]) + offset;
 
 			memcpy(dst, src, len);
-			kunmap(new_rq[i].rq_pages[j]);
-			kunmap(old_rq[i - 1].rq_pages[j]);
+			kunmap(nrq->rq_pages[j]);
+			kunmap(orq->rq_pages[j]);
 		}
 	}
 
-- 
2.31.1

