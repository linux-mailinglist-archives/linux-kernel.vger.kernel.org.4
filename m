Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C996F1B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjD1PDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjD1PDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:03:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8DB26A5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:03:09 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SDvnOD024817;
        Fri, 28 Apr 2023 15:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=GjdL63RtZMlFerOhVgECcz++9zg0UdD0TUKzlrJonvg=;
 b=nKjktdGVvpaZEyMlUGtUTqSXDnVNgSMBinN2rNX4x8Hhobe43f/r3FcAeT6P52Litw/f
 81FDUC9OJ8lzQjYb7TR8ywdlrAGM6Pl5MlnbRutG0Gemks7YfhuAbKpjs00q459VGHDr
 yWuNlblV4rRiepjUxm1avQGsvyFVlbZej/6axiG5aLz8l+MljpNLLadYD+h43tq80yZF
 eb7THlrX2CTGn0cBfutvA6Piip4/0r11g26cZDlKVsOyvF21LAhDoAEHlAvqGlzCoiGu
 u1eNawWPa4Enc9xrZ3LaxEnH6d03hRrEhdMnVCi0/mXX5E5IGYhu6YcHNYzH5sfUorM8 iw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7thv3d1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 15:03:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33SF31FY020244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 15:03:01 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 28 Apr 2023 08:02:57 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <fvdl@google.com>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V8 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
Date:   Fri, 28 Apr 2023 20:32:27 +0530
Message-ID: <4acf1d89f58167292b9ec47507d68ff6b7057a28.1682692818.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1682692818.git.quic_charante@quicinc.com>
References: <cover.1682692818.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vFgVdY9KiRpcK2gNcbmi_I215EMU0aSu
X-Proofpoint-ORIG-GUID: vFgVdY9KiRpcK2gNcbmi_I215EMU0aSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
advises to shmem files which can be helpful for the clients who may want
to manage the shmem pages of the files that are created through
shmem_file_setup[_with_mnt](). One usecase is implemented on the
Snapdragon SoC's running Android where the graphics client is allocating
lot of shmem pages per process and pinning them. When this process is
put to background, the instantaneous reclaim is performed on those shmem
pages using the logic implemented downstream[3][4]. With this patch, the
client can now issue the fadvise calls on the shmem files that does the
instantaneous reclaim which can aid the use cases like mentioned above.
Application that does require the reclaimed pages, say when the app put
to foreground, can issue the POSIX_FADV_WILLNEED to bring back them from
the swap area. Alternatively the drivers can also use
shmem_read_mapping_page_gfp() to bring back the reclaimed shmem pages.

This usecase lead to ~2% reduction in average launch latencies of the
apps and 10% in total number of kills by the low memory killer running
on Android.

Currently we are not supporting the mapped pages which can be
implemented as a next step[5].

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
[5] https://lore.kernel.org/all/CAPTztWZ-PTmF=AazhCuC3u-Ca_mY+QsJGgMdu4W0DC05zk3-iA@mail.gmail.com/

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/shmem.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393..07e33f2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -40,6 +40,9 @@
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
+#include <linux/mm_inline.h>
+#include <linux/fadvise.h>
+#include <linux/page_idle.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt;
@@ -2538,6 +2541,129 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 static const struct inode_operations shmem_symlink_inode_operations;
 static const struct inode_operations shmem_short_symlink_operations;
 
+static void shmem_isolate_pages_range(struct address_space *mapping, pgoff_t start,
+				pgoff_t end, struct list_head *list)
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
+				!folio_isolate_lru(folio)) {
+			folio_put(folio);
+			continue;
+		}
+		folio_put(folio);
+
+		/*
+		 * Prepare the folios to be passed to reclaim_pages().
+		 * VM can't reclaim a folio unless young bit is
+		 * cleared in its flags.
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
+static void shmem_fadvise_dontneed(struct address_space *mapping, pgoff_t start,
+				pgoff_t end)
+{
+	LIST_HEAD(folio_list);
+
+	if (!total_swap_pages || mapping_unevictable(mapping))
+		return;
+
+	lru_add_drain();
+	shmem_isolate_pages_range(mapping, start, end, &folio_list);
+	reclaim_pages(&folio_list);
+}
+
+static void shmem_fadvise_willneed(struct address_space *mapping,
+				 pgoff_t start, pgoff_t end)
+{
+	struct folio *folio;
+	pgoff_t index;
+
+	xa_for_each_range(&mapping->i_pages, index, folio, start, end) {
+		if (!xa_is_value(folio))
+			continue;
+		folio = shmem_read_folio(mapping, index);
+		if (!IS_ERR(folio))
+			folio_put(folio);
+	}
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
+	switch (advice) {
+	case POSIX_FADV_DONTNEED:
+		/*
+		 * Look at the documentation in the generic_fadvise() for
+		 * the reasoning behind these calculations.
+		 */
+		start_index = (offset+(PAGE_SIZE-1)) >> PAGE_SHIFT;
+		end_index = (endbyte >> PAGE_SHIFT);
+
+		if ((endbyte & ~PAGE_MASK) != ~PAGE_MASK &&
+				endbyte != inode->i_size - 1) {
+			if (end_index == 0)
+				break;
+			end_index--;
+		}
+
+		if (end_index >= start_index)
+			shmem_fadvise_dontneed(mapping, start_index, end_index);
+		break;
+	case POSIX_FADV_WILLNEED:
+		start_index = offset >> PAGE_SHIFT;
+		end_index   = endbyte >> PAGE_SHIFT;
+		shmem_fadvise_willneed(mapping, start_index, end_index);
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
 static int
 shmem_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
@@ -3941,6 +4067,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.fadvise	= shmem_fadvise,
 #endif
 };
 
-- 
2.7.4

