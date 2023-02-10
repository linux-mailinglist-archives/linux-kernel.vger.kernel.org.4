Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10226915A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjBJAe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjBJAee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:34:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E56F21A;
        Thu,  9 Feb 2023 16:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FD97CE26DD;
        Fri, 10 Feb 2023 00:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0741BC433D2;
        Fri, 10 Feb 2023 00:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675989141;
        bh=jOXSqjDphYYv6As1ICdSHiifRZOXRL5MGDV+D2X4kSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFTYCkbh4eXYkqXrFwzuOQorD7AZFMCqeVAdHZZCoRxY1qe165VQ+Er3RPN+4rKBk
         Y1zzf0Kg43nZz2tFSWryihLZHofc6xUD8cCbghNMmmMhbdJjGaiE7Yl1fOvPFo7dXL
         3IAwfEPCbX8JXGAwiL5l4ZuvrpISQcsdDtWrE2SfRZA4SieOd3AfthO7bF3iOYZeEh
         rZWuqBC0XV/uM0/ORHPMc95Vyg+Il3qdQnWefTGuQrMz3FQL0kdRWQreLcYNUU9Znf
         n+NXh5wqB2U7iZwyBAF3AcvWQ6w+Rsq2XoQR6gGLiZlFGa8cXbjzmZOBDBxGFsdFHH
         BA5gTpyfV5krQ==
Date:   Fri, 10 Feb 2023 01:32:18 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     paulmck@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, qiuxu.zhuo@intel.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Keeping rcu-related kthreads running on
 housekeeping CPUS
Message-ID: <Y+WQkmiypKUUUfcj@lothringen>
References: <20230209102730.974465-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209102730.974465-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 06:27:30PM +0800, Zqiang wrote:
> For kernels built with CONFIG_NO_HZ_FULL=y and CONFIG_RCU_NOCB_CPU=y,
> when passing cpulist to "isolcpus=", "nohz_full=" and "rcu_nocbs="
> bootparams, after system starting, the rcu-related kthreads(include
> rcu_gp, rcuog*, rcuop* kthreads etc) will running on housekeeping
> CPUs, but for cpulist contains CPU0, the result will deferent, these
> rcu-related kthreads will be restricted to running on CPU0.
> 
> Although invoke kthread_create() to spwan rcu-related kthreads and
> when it's starting, invoke set_cpus_allowed_ptr() to allowed cpumaks
> is housekeeping_cpumask(HK_TYPE_KTHREAD), but due to these rcu-related
> kthreads are created before starting other CPUS, that is to say, at
> this time, only CPU0 is online, when these rcu-related kthreads running
> and set allowed cpumaks is housekeeping cpumask, if find that only CPU0
> is online and CPU0 exists in "isolcpus=", "nohz_full=" and "rcu_nocbs="
> bootparams, invoke set_cpus_allowed_ptr() will return error.
> 
> set_cpus_allowed_ptr()
>  ->__set_cpus_allowed_ptr()
>    ->__set_cpus_allowed_ptr_locked
>      {
>                 bool kthread = p->flags & PF_KTHREAD;
>                 ....
>                 if (kthread || is_migration_disabled(p))
>                         cpu_valid_mask = cpu_online_mask;
>                 ....
>                 dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
>                 if (dest_cpu >= nr_cpu_ids) {
>                         ret = -EINVAL;
>                         goto out;
>                 }
>                 ....
>      }
> 
> At this time, only CPU0 is set in the cpu_online_mask, the ctx->new_mask
> is housekeeping cpumask and not contains CPU0, this will result dest_cpu
> is illegal cpu value, the set_cpus_allowed_ptr() will return -EINVAL and
> failed to set housekeeping cpumask.
> 
> This commit therefore add additional cpus_allowed_ptr() call in CPU hotplug
> path. and reset the CPU affinity of rcuboost, rcuog, rcuop kthreads after
> all other CPUs are online.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch! But based on that and your other fix, I suspect that
nohz_full=0... has never been seriously used.

A few points:

* This is a problem for kthreads in general. And since HK_TYPE_KTHREAD =
  HK_TYPE_RCU and both are going to be merged in the future, I think we should
  stop handling the RCU kthreads housekeeping affinity from RCU but let the
  kthread code handle that and also fix the issue from the kthread code.
  RCU boost may be an exception since we try to enforce some node locality
  within the housekeeping range.  

* If CPU 0 is isolated and it is the boot CPU, we should wait for a secondary
  CPU to boot before activating nohz_full at all. Unfortunately the nohz_full
  code is not yet ready for runtime housekeeping cpumask change but work is
  in progress (I'm saying that for 10 years...)

* I'm tempted to revert 08ae95f4fd3b (nohz_full: Allow the boot CPU to be
  nohz_full) since it doesn't work and nobody ever complained?

Thanks.
