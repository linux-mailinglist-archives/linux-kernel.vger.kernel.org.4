Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED763F81C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLATYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLATYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:24:40 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70497BE6A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:24:39 -0800 (PST)
Date:   Thu, 1 Dec 2022 11:24:19 -0800
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
Subject: Re: [linus:master] [memcg] 1813e51eec:
 kernel-selftests.cgroup.test_kmem.test_kmem_memcg_deletion.fail
Message-ID: <Y4j/YzsmTi22u2Cf@P9FQF9L96D.corp.robot.car>
References: <202212010958.c1053bd3-yujie.liu@intel.com>
 <Y4h/AsTy97na/t5D@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4h/AsTy97na/t5D@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:16:34AM +0100, Michal Hocko wrote:
> On Thu 01-12-22 16:05:44, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed kernel-selftests.cgroup.test_kmem.test_kmem_memcg_deletion.fail due to commit (built with gcc-11):
> > 
> > commit: 1813e51eece0ad6f4aacaeb738e7cced46feb470 ("memcg: increase MEMCG_CHARGE_BATCH to 64")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linux-next/master 700e0cd3a5ce6a2cb90d9a2aab729b52f092a7d6]
> > 
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-2ed09c3b-1_20221128
> > with following parameters:
> > 
> > 	group: cgroup
> > 
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > 
> > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > # memory.current = 40161280
> > # slab + anon + file + kernel_stack = 14478624
> > # slab = 13453184
> > # anon = 0
> > # file = 0
> > # kernel_stack = 0
> > # pagetables = 0
> > # percpu = 1025440
> > # sock = 0
> > # not ok 2 test_kmem_memcg_deletion  <--
> > # ok 3 test_kmem_proc_kpagecgroup
> > # ok 4 test_kmem_kernel_stacks
> > # ok 5 test_kmem_dead_cgroups
> > # ok 6 test_percpu_basic
> > not ok 2 selftests: cgroup: test_kmem # exit=1
> 
> IIUC we need this
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

Yep.

>  
>  
>  static int alloc_dcache(const char *cgroup, void *arg)
> 
> But honestly, I am rather dubious of tests like this one. Does it really
> give us any useful testing coverage?

As I remember, we've had some issues in the past when some memcg stats leftovers
were not prpoerly propagated on the cgroup deletion, so that over time the
numbers on the parent level beacame completely crazy.

Thanks!
