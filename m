Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E62640C14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiLBRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiLBRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:23:43 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 09:23:08 PST
Received: from out-206.mta0.migadu.com (out-206.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ce])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E7DBF6B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:23:07 -0800 (PST)
Date:   Fri, 2 Dec 2022 09:16:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670001383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Iyf0EnB7OzEo139Ba2aL1bqTplHNZ8kxQ6sIzX92Xk=;
        b=nl7+RrUrTXK1s3Lr3EamD3DykStZYrZ142fU4QdsUjhPpiQwesO9qQ6HlrXpOOuDcBLhL9
        Y7EvFHsU98LZrMV8ynLM5IEO/N5E2fOH5PalDRxJTxS4RaEftX/Cz1HpNeh/u5EvIEoocP
        woP72s6yWZQFC63/tZwv3C9giigI1qI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Shakeel Butt <shakeelb@google.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Eric Dumazet <edumazet@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftests: cgroup: update kmem test precision tolerance
Message-ID: <Y4oy4foegCdOKVKj@P9FQF9L96D.corp.robot.car>
References: <202212010958.c1053bd3-yujie.liu@intel.com>
 <Y4m8Unt6FhWKC6IH@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4m8Unt6FhWKC6IH@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 09:50:26AM +0100, Michal Hocko wrote:
> OK, so this is a full patch to fix this
> --- 
> From 7f338ed952ba4a100822004bc8399bf720b42899 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 2 Dec 2022 09:45:29 +0100
> Subject: [PATCH] kselftests: cgroup: update kmem test precision tolerance
> 
> 1813e51eece0 ("memcg: increase MEMCG_CHARGE_BATCH to 64") has changed
> the batch size while this test case has been left behind. This has led
> to a test failure reported by test bot:
> not ok 2 selftests: cgroup: test_kmem # exit=1
> 
> Update the tolerance for the pcp charges to reflect the
> MEMCG_CHARGE_BATCH change to fix this.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202212010958.c1053bd3-yujie.liu@intel.com
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  tools/testing/selftests/cgroup/test_kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index 22b31ebb3513..1d073e28254b 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -24,7 +24,7 @@
>   * the maximum discrepancy between charge and vmstat entries is number
>   * of cpus multiplied by 32 pages.
>   */
> -#define MAX_VMSTAT_ERROR (4096 * 32 * get_nprocs())
> +#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())

Hi Michal!

You need to update comments above too (it says 32 pages in a couple of places).
I actually sent the similar patch to Andrew yesterday, but hit reply and missed
adding people to cc.

Please, feel free to send your v2 with comments fixed and my acked-by,
or we can go with my version.

Thanks!

--

From 354850a59bb8e000490a23bc768f4d3183faf8e4 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <roman.gushchin@linux.dev>
Date: Thu, 1 Dec 2022 18:05:07 -0800
Subject: [PATCH] kselftests/cgroup: adjust memcg charge batch size

Commit 1813e51eece0 ("memcg: increase MEMCG_CHARGE_BATCH to 64")
doubled the memcg charge batch size, which broke the kmem_memcg_deletion
test. Bump the corresponding error margin on the test side to fix the
problem.

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202212010958.c1053bd3-yujie.liu@intel.com
Fixes: 1813e51eece0 ("memcg: increase MEMCG_CHARGE_BATCH to 64")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeelb@google.com>
---
 tools/testing/selftests/cgroup/test_kmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 22b31ebb3513..258ddc565deb 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -19,12 +19,12 @@


 /*
- * Memory cgroup charging is performed using percpu batches 32 pages
+ * Memory cgroup charging is performed using percpu batches 64 pages
  * big (look at MEMCG_CHARGE_BATCH), whereas memory.stat is exact. So
  * the maximum discrepancy between charge and vmstat entries is number
- * of cpus multiplied by 32 pages.
+ * of cpus multiplied by 64 pages.
  */
-#define MAX_VMSTAT_ERROR (4096 * 32 * get_nprocs())
+#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())


 static int alloc_dcache(const char *cgroup, void *arg)
--
2.38.1
