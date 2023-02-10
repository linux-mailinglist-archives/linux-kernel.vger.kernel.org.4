Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B469161C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjBJBPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBJBPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:15:31 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1481C5EA07
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:15:29 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PCbQ81jJRz501Qm;
        Fri, 10 Feb 2023 09:15:28 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 31A1FLFN006412;
        Fri, 10 Feb 2023 09:15:21 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 10 Feb 2023 09:15:22 +0800 (CST)
Date:   Fri, 10 Feb 2023 09:15:22 +0800 (CST)
X-Zmail-TransId: 2b0363e59aaafffffffff5e3bbcc
X-Mailer: Zmail v1.0
Message-ID: <202302100915227721315@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <david@redhat.com>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY2IDAvNl0ga3NtOiBzdXBwb3J0IHRyYWNraW5nIEtTTS1wbGFjZWQgemVyby1wYWdlcw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 31A1FLFN006412
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E59AB0.000/4PCbQ81jJRz501Qm
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

The core idea of this patch set is to enable users to perceive the number of any
pages merged by KSM, regardless of whether use_zero_page switch has been turned
on, so that users can know how much free memory increase is really due to their
madvise(MERGEABLE) actions. But the problem is, when enabling use_zero_pages,
all empty pages will be merged with kernel zero pages instead of with each
other as use_zero_pages is disabled, and then these zero-pages are no longer
monitored by KSM.

The motivations for me to do this contains three points:

1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
   unshare the shared zeropage as placed by KSM (which is against the 
   MADV_UNMERGEABLE documentation at least); see the link:
   https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/

2) We cannot know how many pages are zero pages placed by KSM when
   enabling use_zero_pages, which hides the critical information about
   how much actual memory are really saved by KSM. Knowing how many
   ksm-placed zero pages are helpful for user to use the policy of madvise
   (MERGEABLE) better because they can see the actual profit brought by KSM.

3) The zero pages placed-by KSM are different from those initial empty page
   (filled with zeros) which are never touched by applications. The former
   is active-merged by KSM while the later have never consume actual memory.

use_zero_pages is useful, not only because of cache colouring as described
in doc, but also because use_zero_pages can accelerate merging empty pages
when there are plenty of empty pages (full of zeros) as the time of
page-by-page comparisons (unstable_tree_search_insert) is saved. So we hope to
implement the support for ksm zero page tracking without affecting the feature
of use_zero_pages.

Zero pages may be the most common merged pages in actual environment(not only VM but
also including other application like containers). Enabling use_zero_pages in the
environment with plenty of empty pages(full of zeros) will be very useful. Users and
app developer can also benefit from knowing the proportion of zero pages in all
merged pages to optimize applications.

With the patch series, we can both unshare zero-pages(KSM-placed) accurately
and count ksm zero pages with enabling use_zero_pages.

v5->v6:
1) In [PATCH 1/6], fix some coments as Divid's suggestions [1].
2) In [PATCH 6/6], modify the patch as Divid's suggestions [2].
[1]: https://lore.kernel.org/lkml/0e0c90a2-d12c-f965-9cce-ecd5d28c09dd@redhat.com/
[2]: https://lore.kernel.org/lkml/3704dcf0-bd0a-8ab2-7f4f-045fc7c73171@redhat.com/

v4->v5:
---
1) fix warning:  mm/ksm.c:3238:9: warning: no previous prototype for 'zero_pages_sharing_show'
   [-Wmissing-prototypes].
   In [PATCH 3/6] (ksm: count all zero pages placed by KSM), declare the function
ssize_t zero_pages_sharing_show(struct kobject *kobj...) as 'static'.
2) In [PATCH 6/6],fix error of "} while (end_scans < start_scans + 20);" to
   "} while (end_scans < start_scans + 2);" in wait_two_full_scans().

---
v3->v4:

1) The patch series are readjusted to adapt to these recent changes of break_ksm()
   from David Hildenbrand's commits:
   https://lore.kernel.org/all/20221021101141.84170-9-david@redhat.com/T/#u

2) Some changes of patch itself:
   In [patch 2/6], add a check of mm exiting in unshare_zero_pages in case of
   unsharing the zero pages whose process is exiting; form a new function
   clean_rmap_item_zero_flag(), and add it after stable_tree_search() to fix;
   In [patch 3/6], all decreasing actions of zero pages count are put in
   clean_rmap_item_zero_flag(), which is more accurate.

3) Add a selftest of unsharing and counting ksm-placed zero pages.

---
v2->v3:

1) Add more descriptive information in cover letter.

2) In [patch 2/5], add more commit log for explaining reasons.

3) In [patch 2/5], fix misuse of break_ksm() in unmerge_ksm_pages():
   break_ksm(vma, addr, NULL) -> break_ksm(vma, addr, false);

---
v1->v2:

[patch 4/5] fix build warning, mm/ksm.c:550, misleading indentation; statement 
'rmap_item->mm->ksm_zero_pages_sharing--;' is not part of the previous 'if'.
*** BLURB HERE ***

xu xin (6):
  ksm: abstract the function try_to_get_old_rmap_item
  ksm: support unsharing zero pages placed by KSM
  ksm: count all zero pages placed by KSM
  ksm: count zero pages for each process
  ksm: add zero_pages_sharing documentation
  selftest: add testing unsharing and counting ksm zero page

 Documentation/admin-guide/mm/ksm.rst              |   7 +
 fs/proc/base.c                                    |   1 +
 include/linux/mm_types.h                          |   7 +-
 mm/ksm.c                                          | 185 +++++++++++++++++-----
 tools/testing/selftests/vm/ksm_functional_tests.c |  96 ++++++++++-
 5 files changed, 255 insertions(+), 41 deletions(-)

-- 
2.15.2
