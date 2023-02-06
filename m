Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB868BFF4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBFOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:22:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E92271F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:22:32 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316BvBrB017808;
        Mon, 6 Feb 2023 14:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8pVCKR95UYar7CDkFZyHmi085Ldot0hMkd4M0rzUh9s=;
 b=BSXLzf2MJEhfFTBwlglhkN+7KgrBd8M1M71tZGfTtx+tk0bIyi/34J6TiTA+Yn889+uX
 XU50OaLB4pTnsedeAEoatuTmEOty/7QRML/jNz1h0ZC5vw7nEzh+ZLZdsXP27Ym1Ytbx
 Cq3uk4/LYwkxZIEmMTXR0B4G9Ffg24Rg//a8OOv7OuKhfQ4uA4rl9TW/RGYDjvEARqA+
 suChMF8yi0P3WJwqjNwUDygH7BvZ60PnxvbErnaAV6gtW71W4GpIjUH/oz52bdHmhNun
 mgOTHY5dUOgsE2c1GuBLuIg3QRVza7UbHRU00NKyn2rbIjrrmrmDMffsDOGts5GzObCU Hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhechbx9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:22:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316EMIw5024912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 14:22:18 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 06:22:13 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <vbabka@suse.cz>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V6 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
Date:   Mon, 6 Feb 2023 19:51:33 +0530
Message-ID: <08e04b5d2fc7a2300a52fb7fff1bc6316a53927c.1675690847.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1675690847.git.quic_charante@quicinc.com>
References: <cover.1675690847.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ig4qu_18s9s2hQE3FBtLNc-Gh_Ighomr
X-Proofpoint-ORIG-GUID: Ig4qu_18s9s2hQE3FBtLNc-Gh_Ighomr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently fadvise(2) is supported only for the files that doesn't
associated with noop_backing_dev_info thus for the files, like shmem,
fadvise results into NOP. But then there is file_operations->fadvise()
that lets the file systems to implement their own fadvise
implementation. Use this support to implement some of the POSIX_FADV_XXX
functionality for shmem files.

This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
advices to shmem files which can be helpful for the clients who may want
to manage the shmem pages of the files that are created through
shmem_file_setup[_with_mnt](). One usecase is implemented on the
Snapdragon SoC's running Android where the graphics client is allocating
lot of shmem pages per process and pinning them. When this process is
put to background, the instantaneous reclaim is performed on those shmem
pages using the logic implemented downstream[3][4]. With this patch, the
client can now issue the fadvise calls on the shmem files that does the
instantaneous reclaim which can aid the use cases like mentioned above.

This usecase lead to ~2% reduction in average launch latencies of the
apps and 10% in total number of kills by the low memory killer running
on Android.

Some questions asked while reviewing this patch:
Q) Can the same thing be achieved with FD mapped to user and use
madvise?
A) All drivers are not mapping all the shmem fd's to user space and want
to manage them with in the kernel. Ex: shmem memory can be mapped to the
other subsystems and they fill in the data and then give it to other
subsystem for further processing, where, the user mapping is not at all
required.  A simple example, memory that is given for gpu subsystem
which can be filled directly and give to display subsystem. And the
respective drivers know well about when to keep that memory in ram or
swap based on may be a user activity.

Q) Should we add the documentation section in Manual pages?
A) The man[1] pages for the fadvise() whatever says is also applicable
for shmem files. so couldn't feel it correct to add specific to shmem
files separately.

Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
and this difference will cause confusion?
A) man pages [2] says that "POSIX_FADV_DONTNEED attempts to free cached
pages associated with the specified region." This means on issuing this
FADV, it is expected to free the file cache pages. And it is
implementation defined If the dirty pages may be attempted to writeback.
And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
covers the semantics of MADV_PAGEOUT for file pages and there is no
purpose of PAGEOUT for file pages.

[1] https://linux.die.net/man/2/fadvise
[2] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html
[3] https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.1.0.r3-rel/kgsl_reclaim.c#L289
[4] https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10/mm/shmem.c#4310

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/shmem.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0005ab2..58aa3d7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -39,6 +39,9 @@
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
+#include <linux/mm_inline.h>
+#include <linux/fadvise.h>
+#include <linux/page_idle.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt;
@@ -2327,6 +2330,117 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
 #define shmem_initxattrs NULL
 #endif
 
+static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
+				loff_t end, struct list_head *list)
+{
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, end) {
+		if (xas_retry(&xas, folio))
+			continue;
+		if (xa_is_value(folio))
+			continue;
+
+		if (!folio_try_get(folio))
+			continue;
+		if (folio_test_unevictable(folio) || folio_mapped(folio) ||
+				folio_isolate_lru(folio)) {
+			folio_put(folio);
+			continue;
+		}
+		folio_put(folio);
+
+		/*
+		 * Prepare the page to be passed to the reclaim_pages().
+		 * VM couldn't reclaim the page unless we clear PG_young.
+		 */
+		folio_clear_referenced(folio);
+		folio_test_clear_young(folio);
+		list_add(&folio->lru, list);
+		if (need_resched()) {
+			xas_pause(&xas);
+			cond_resched_rcu();
+		}
+	}
+	rcu_read_unlock();
+}
+
+static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
+				loff_t end)
+{
+	LIST_HEAD(folio_list);
+
+	if (!total_swap_pages)
+		return 0;
+
+	lru_add_drain();
+	shmem_isolate_pages_range(mapping, start, end, &folio_list);
+	reclaim_pages(&folio_list);
+
+	return 0;
+}
+
+static int shmem_fadvise_willneed(struct address_space *mapping,
+				 pgoff_t start, pgoff_t long end)
+{
+	struct page *page;
+	pgoff_t index;
+
+	xa_for_each_range(&mapping->i_pages, index, page, start, end) {
+		if (!xa_is_value(page))
+			continue;
+		page = shmem_read_mapping_page(mapping, index);
+		if (!IS_ERR(page))
+			put_page(page);
+	}
+
+	return 0;
+}
+
+static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	loff_t endbyte;
+	pgoff_t start_index;
+	pgoff_t end_index;
+	struct address_space *mapping;
+	struct inode *inode = file_inode(file);
+	int ret = 0;
+
+	if (S_ISFIFO(inode->i_mode))
+		return -ESPIPE;
+
+	mapping = file->f_mapping;
+	if (!mapping || len < 0 || !shmem_mapping(mapping))
+		return -EINVAL;
+
+	endbyte = fadvise_calc_endbyte(offset, len);
+
+	start_index = offset >> PAGE_SHIFT;
+	end_index   = endbyte >> PAGE_SHIFT;
+	switch (advice) {
+	case POSIX_FADV_DONTNEED:
+		ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
+		break;
+	case POSIX_FADV_WILLNEED:
+		ret = shmem_fadvise_willneed(mapping, start_index, end_index);
+		break;
+	case POSIX_FADV_NORMAL:
+	case POSIX_FADV_RANDOM:
+	case POSIX_FADV_SEQUENTIAL:
+	case POSIX_FADV_NOREUSE:
+		/*
+		 * No bad return value, but ignore advice.
+		 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
 				     umode_t mode, dev_t dev, unsigned long flags)
 {
@@ -3933,6 +4047,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
 #endif
+	.fadvise	= shmem_fadvise,
 };
 
 static const struct inode_operations shmem_inode_operations = {
-- 
2.7.4

