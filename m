Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F756010EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJQOTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJQOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:19:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E9205FE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UGZc5yCBDXZnLcMnFnCj+NcMED6gyHfplWFSG0Gu/UQ=; b=ONW4V1KLGK1K1F/YGNcXBo5OcY
        b6W0lU131H9mmPYA9LtH/G2qWiwzSoX53pyMykwXavYOPxEwfhbdTiu9fFbIPqNFHgWpnArwfSbzG
        FPnPlDmjbCpbzTmfddi0czj3fuscbzOps+ToPCdmkQ0Xiz9iQMur0M9BpjB48bryt3BzTW2zHqc9g
        I1fIPLCVeo8Jk9kCx+XONjcYL9QBcBYg4aA0T/bhlAWyacfJEIxlkb+vVGLvzrBb/TLzyQpEoF5ZP
        G7RKoVY3zZkYdwInh8LkXsd3SH1zLkPSmTkcmITuUkDkW9Kpg2drWQh9Msk0fFdB/cE493xdOJaS/
        fpj2zp5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okQxo-004EYh-Il; Mon, 17 Oct 2022 14:19:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1BD73000DD;
        Mon, 17 Oct 2022 16:19:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F8FE2BB730E2; Mon, 17 Oct 2022 16:19:31 +0200 (CEST)
Date:   Mon, 17 Oct 2022 16:19:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+GregKH who actually knows about debugfs.

On Mon, Oct 17, 2022 at 06:40:49PM +0530, Vishal Chourasia wrote:
> smt=off operation on system with 1920 CPUs is taking approx 59 mins on v5.14
> versus 29 mins on v5.11 measured using:
> # time ppc64_cpu --smt=off
> 
> Doing a git bisect between kernel v5.11 and v5.14 pointed to the commit
> 3b87f136f8fc ("sched,debug: Convert sysctl sched_domains to debugfs"). This
> commit moves sched_domain information that was originally exported using sysctl
> to debugfs.
> 
> Reverting the said commit, gives us the expected good result.
> 
> Previously sched domain information was exported at procfs(sysctl):
> /proc/sys/kernel/sched_domain/ but now it gets exported at debugfs
> :/sys/kernel/debug/sched/domains/ 
> 
> We also observe regression in kernel v6.0-rc4, which vanishes after reverting
> the commit 3b87f136f8fc
> 
> # Output of `time ppc64_cpu --smt=off` on different kernel versions
> |-------------------------------------+------------+----------+----------|
> | kernel version                      | real       | user     | sys      |
> |-------------------------------------+------------+----------+----------|
> | v5.11                               | 29m22.007s | 0m0.001s | 0m6.444s |
> | v5.14                               | 58m15.719s | 0m0.037s | 0m7.482s |
> | v6.0-rc4                            | 59m30.318s | 0m0.055s | 0m7.681s |
> | v6.0-rc4 with 3b87f136f8fc reverted | 32m20.486s | 0m0.029s | 0m7.361s |
> |-------------------------------------+------------+----------+----------|
> 
> Machine with 1920 cpus was used for the above experiments.  Output of lscpu is
> added below.
> 
> # lscpu 
> Architecture: ppc64le
> Byte Order: Little Endian
> CPU(s): 1920
> On-line CPU(s) list: 0-1919
> Model name: POWER10 (architected), altivec supported
> Model: 2.0 (pvr 0080 0200)
> Thread(s) per core: 8
> Core(s) per socket: 14
> Socket(s): 17
> Physical sockets: 15
> Physical chips: 1
> Physical cores/chip: 16
> 
> Through our experiments we have found that even when offlining 1 cpu, functions
> responsible for exporting sched_domain information took more time in case of
> debugfs relative to sysctl.
> 
> Experiments using trace-cmd function-graph plugin have shown execution time for
> certain methods common in both the scenarios (procfs and debugfs) differ
> drastically. 
> 
> Below table list the execution time for some of the symbols for sysctl(procfs)
> and debugfs case. 
> 
> |--------------------------------+----------------+--------------|
> | method                         | sysctl         | debugfs      |
> |--------------------------------+----------------+--------------|
> | unregister_sysctl_table        |   0.020050 s   | NA           |
> | build_sched_domains            |   3.090563 s   | 3.119130 s   |
> | register_sched_domain_sysctl   |   0.065487 s   | NA           |
> | update_sched_domain_debugfs    |   NA           | 2.791232 s   |
> | partition_sched_domains_locked |   3.195958 s   | 5.933254 s   |
> |--------------------------------+----------------+--------------|
> 
> Note: partition_sched_domains_locked internally calls build_sched_domains
>       and calls other functions respective to what's being currently used to
>       export information i.e. sysctl or debugfs
> 
> Above numbers are quoted from the case where we tried offlining 1 cpu in system
> with 1920 online cpus.
> 
> From the above table, register_sched_domain_sysctl and
> unregister_sysctl_table_collectively took ~0.085 secs, whereas
> update_sched_domain_debugfs took ~2.79 secs. 
> 
> Root cause:
> 
> The observed regression stems from the way these two pseudo-filesystems handle
> creation and deletion of files and directories internally.  
> 
> update_sched_domain_debugfs builds and exports sched_domains information to the
> userspace. It begins with removing/tearing down the per-cpu directories present
> in /sys/kernel/debug/sched/domains/ one by one for each possible cpu. And then
> recreate per-cpu per-domain files and directories one by one for each possible
> cpus.
> 
> Excerpt from the trace-cmd output for the debugfs case
> ...
>              |  update_sched_domain_debugfs() {
> + 14.526 us  |    debugfs_lookup();
> # 1092.64 us |    debugfs_remove();
> + 48.408 us  |    debugfs_create_dir();      -   creates per-cpu    dir
>   9.038 us   |    debugfs_create_dir();      -   creates per-domain dir
>   9.638 us   |    debugfs_create_ulong();   -+
>   7.762 us   |    debugfs_create_ulong();    |
>   7.776 us   |    debugfs_create_u64();      |
>   7.502 us   |    debugfs_create_u32();      |__ creates per-domain files
>   7.646 us   |    debugfs_create_u32();      |
>   7.702 us   |    debugfs_create_u32();      |
>   6.974 us   |    debugfs_create_str();      |
>   7.628 us   |    debugfs_create_file();    -+
> ...                                          -   repeat other domains and cpus
> 
> As a first step, We used debugfs_remove_recursive to remove entries for each cpu
> in one go instead of calling debugfs_remove per cpu. But, We did not see any
> improvement whatsoever.   
> 
> We understand debugfs doesn't concern itself with performance, and that smt=off
> operation won't be invoked much often, statistically speaking. But, We should
> understand that as the CPUs in a system will scale debugfs becomes a massive
> performance bottleneck that shouldn't be ignored.
> 
> Even in a system with 240 CPUs system, update_sched_domain_debugfs is 1600 times
> slower than register_sched_domain_sysctl when building sched_domain directory
> for 240 CPUs only.
> 
> # For 240 CPU system
> |------------------------------+---------------|
> | method                       | time taken    |
> |------------------------------+---------------|
> | update_sched_domain_debugfs  | 236550.996 us |
> | register_sched_domain_sysctl | 13907.940 us  |
> |------------------------------+---------------|
> 
> Any ideas on how to improve here from the community is much appreciated.
> 
> Meanwhile, We will keep posting our progress updates.
> 
> -- vishal.c


