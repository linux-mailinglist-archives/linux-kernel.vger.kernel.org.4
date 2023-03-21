Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F56C29FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCUFo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUFoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:44:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1D15C89
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679377492; x=1710913492;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=wl03io2d0k+evhco+yEGlMgMTYRsc0nwIfZbAUjHAuM=;
  b=bkAJ4pGWuwb5uAO//GqsUnezlL72H7jtxctH/kWPCDFncDT0RzW65PKB
   r4C6DhV+GbvK9KI0s8UJNcY8dNqNspBObBg/3IhloCC6u+0Q+OEVwhy7L
   R/xoiBljFfvDAIyBZE1Xi/1q4T2NTgE879ZLSetEdGvZLWKUM1Sh32Wve
   gw0AyQxKfti0wrYlXNLH55Z/kTUA0O39aOqnqXcMFvZHWDpOOiAoi2HM4
   +V3ZoQsLQlUXrSPy1jAvO3E6/kctELBanV117/UG6yhCIqoWW3G/BQcJI
   IAXQj2PM46QLralZkSMoFyEc82yF7Om2up/8kRhAikX/pcjGgvAnJep06
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336358814"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="336358814"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="750405917"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="750405917"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:44:47 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     lkp <lkp@intel.com>, "bharata@amd.com" <bharata@amd.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "ziy@nvidia.com" <ziy@nvidia.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>
Subject: Re: [linus:master] [migrate_pages] 7e12beb8ca:
 vm-scalability.throughput -3.4% regression
References: <202303192325.ecbaf968-yujie.liu@intel.com>
        <87o7onua4t.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ab92aaddf1b52ede15e2c608696c36765a2602c1.camel@intel.com>
Date:   Tue, 21 Mar 2023 13:43:37 +0800
In-Reply-To: <ab92aaddf1b52ede15e2c608696c36765a2602c1.camel@intel.com> (Yujie
        Liu's message of "Tue, 21 Mar 2023 11:24:32 +0800")
Message-ID: <87h6ueu0ae.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Liu, Yujie" <yujie.liu@intel.com> writes:

> Hi Ying,
>
> On Mon, 2023-03-20 at 15:58 +0800, Huang, Ying wrote:
>> Hi, Yujie,
>>
>> kernel test robot <yujie.liu@intel.com> writes:
>>
>> > Hello,
>> >
>> > FYI, we noticed a -3.4% regression of vm-scalability.throughput due to=
 commit:
>> >
>> > commit: 7e12beb8ca2ac98b2ec42e0ea4b76cdc93b58654 ("migrate_pages: batc=
h flushing TLB")
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> >
>> > in testcase: vm-scalability
>> > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L =
CPU @ 2.40GHz (Cascade Lake) with 128G memory
>> > with following parameters:
>> >
>> >         runtime: 300s
>> >         size: 512G
>> >         test: anon-cow-rand-mt
>> >         cpufreq_governor: performance
>> >
>> > test-description: The motivation behind this suite is to exercise func=
tions and regions of the mm/ of the Linux kernel which are of interest to u=
s.
>> > test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalabil=
ity.git/
>> >
>> >
>> > If you fix the issue, kindly add following tag
>> > > Reported-by: kernel test robot <yujie.liu@intel.com>
>> > > Link: https://lore.kernel.org/oe-lkp/202303192325.ecbaf968-yujie.liu=
@intel.com
>> >
>>
>> Thanks a lot for report!  Can you try whether the debug patch as
>> below can restore the regression?
>
> We've tested the patch and found the throughput score was partially
> restored from -3.6% to -1.4%, still with a slight performance drop.
> Please check the detailed data as follows:

Good!  Thanks for your detailed data!

>       0.09 =C2=B1 17%      +1.2        1.32 =C2=B1  7%      +0.4        0=
.45 =C2=B1 21%  perf-profile.children.cycles-pp.flush_tlb_func

It appears that we can reduce the unnecessary TLB flushing effectively
with the previous debug patch.  But the batched flush (full flush) is
still slower than the non-batched flush (flush one page).

Can you try the debug patch as below to check whether it can restore the
regression completely?  The new debug patch can be applied on top of the
previous debug patch.

Best Regards,
Huang, Ying

---------------------------8<-----------------------------------------
From b36b662c80652447d7374faff1142a941dc9d617 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Mon, 20 Mar 2023 15:38:12 +0800
Subject: [PATCH] dbg, migrate_pages: don't batch flushing for single page
 migration

---
 mm/migrate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 98f1c11197a8..7271209c1a03 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1113,8 +1113,8 @@ static void migrate_folio_done(struct folio *src,
 static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_ne=
w_page,
 			       unsigned long private, struct folio *src,
 			       struct folio **dstp, int force, bool avoid_force_lock,
-			       enum migrate_mode mode, enum migrate_reason reason,
-			       struct list_head *ret)
+			       bool batch_flush, enum migrate_mode mode,
+			       enum migrate_reason reason, struct list_head *ret)
 {
 	struct folio *dst;
 	int rc =3D -EAGAIN;
@@ -1253,7 +1253,7 @@ static int migrate_folio_unmap(new_page_t get_new_pag=
e, free_page_t put_new_page
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, TTU_BATCH_FLUSH);
+		try_to_migrate(src, batch_flush ? TTU_BATCH_FLUSH : 0);
 		page_was_mapped =3D 1;
 	}
=20
@@ -1641,6 +1641,7 @@ static int migrate_pages_batch(struct list_head *from=
, new_page_t get_new_page,
 	bool nosplit =3D (reason =3D=3D MR_NUMA_MISPLACED);
 	bool no_split_folio_counting =3D false;
 	bool avoid_force_lock;
+	bool batch_flush =3D !list_is_singular(from);
=20
 retry:
 	rc_saved =3D 0;
@@ -1690,7 +1691,7 @@ static int migrate_pages_batch(struct list_head *from=
, new_page_t get_new_page,
=20
 			rc =3D migrate_folio_unmap(get_new_page, put_new_page, private,
 						 folio, &dst, pass > 2, avoid_force_lock,
-						 mode, reason, ret_folios);
+						 batch_flush, mode, reason, ret_folios);
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
@@ -1804,7 +1805,8 @@ static int migrate_pages_batch(struct list_head *from=
, new_page_t get_new_page,
 	stats->nr_failed_pages +=3D nr_retry_pages;
 move:
 	/* Flush TLBs for all unmapped folios */
-	try_to_unmap_flush();
+	if (batch_flush)
+		try_to_unmap_flush();
=20
 	retry =3D 1;
 	for (pass =3D 0;
--=20
2.30.2

