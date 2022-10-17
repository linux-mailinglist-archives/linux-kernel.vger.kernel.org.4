Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF61601201
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJQO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiJQO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A633422D4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EF1161199
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95136C433B5;
        Mon, 17 Oct 2022 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666018455;
        bh=k3LUoF1mLLygSUyHn+ANmlZeEI28iMMxN8qvT1nVFeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQD4DFFNW6xje0kUbTAaHTeOqNejlqD4ufAmxa8Vqtd54CSJjKIaFEUR7cmPXgst/
         HDLVY9GS0YdjuxvjtnQeSRZwu5mdKQ55GLhxjdeVok2blEse9217cWIO5ynwWcl4qJ
         vqXwyx8sm1gOz3M53phcJw9nIZA7iHzI2LHnA93M=
Date:   Mon, 17 Oct 2022 16:54:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y01sk3l8yCMvhvYm@kroah.com>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:19:31PM +0200, Peter Zijlstra wrote:
> 
> +GregKH who actually knows about debugfs.
> 
> On Mon, Oct 17, 2022 at 06:40:49PM +0530, Vishal Chourasia wrote:
> > smt=off operation on system with 1920 CPUs is taking approx 59 mins on v5.14
> > versus 29 mins on v5.11 measured using:
> > # time ppc64_cpu --smt=off
> > 
> > Doing a git bisect between kernel v5.11 and v5.14 pointed to the commit
> > 3b87f136f8fc ("sched,debug: Convert sysctl sched_domains to debugfs"). This
> > commit moves sched_domain information that was originally exported using sysctl
> > to debugfs.
> > 
> > Reverting the said commit, gives us the expected good result.
> > 
> > Previously sched domain information was exported at procfs(sysctl):
> > /proc/sys/kernel/sched_domain/ but now it gets exported at debugfs
> > :/sys/kernel/debug/sched/domains/ 
> > 
> > We also observe regression in kernel v6.0-rc4, which vanishes after reverting
> > the commit 3b87f136f8fc
> > 
> > # Output of `time ppc64_cpu --smt=off` on different kernel versions
> > |-------------------------------------+------------+----------+----------|
> > | kernel version                      | real       | user     | sys      |
> > |-------------------------------------+------------+----------+----------|
> > | v5.11                               | 29m22.007s | 0m0.001s | 0m6.444s |
> > | v5.14                               | 58m15.719s | 0m0.037s | 0m7.482s |
> > | v6.0-rc4                            | 59m30.318s | 0m0.055s | 0m7.681s |
> > | v6.0-rc4 with 3b87f136f8fc reverted | 32m20.486s | 0m0.029s | 0m7.361s |
> > |-------------------------------------+------------+----------+----------|
> > 
> > Machine with 1920 cpus was used for the above experiments.  Output of lscpu is
> > added below.
> > 
> > # lscpu 
> > Architecture: ppc64le
> > Byte Order: Little Endian
> > CPU(s): 1920
> > On-line CPU(s) list: 0-1919
> > Model name: POWER10 (architected), altivec supported
> > Model: 2.0 (pvr 0080 0200)
> > Thread(s) per core: 8
> > Core(s) per socket: 14
> > Socket(s): 17
> > Physical sockets: 15
> > Physical chips: 1
> > Physical cores/chip: 16
> > 
> > Through our experiments we have found that even when offlining 1 cpu, functions
> > responsible for exporting sched_domain information took more time in case of
> > debugfs relative to sysctl.
> > 
> > Experiments using trace-cmd function-graph plugin have shown execution time for
> > certain methods common in both the scenarios (procfs and debugfs) differ
> > drastically. 
> > 
> > Below table list the execution time for some of the symbols for sysctl(procfs)
> > and debugfs case. 
> > 
> > |--------------------------------+----------------+--------------|
> > | method                         | sysctl         | debugfs      |
> > |--------------------------------+----------------+--------------|
> > | unregister_sysctl_table        |   0.020050 s   | NA           |
> > | build_sched_domains            |   3.090563 s   | 3.119130 s   |
> > | register_sched_domain_sysctl   |   0.065487 s   | NA           |
> > | update_sched_domain_debugfs    |   NA           | 2.791232 s   |
> > | partition_sched_domains_locked |   3.195958 s   | 5.933254 s   |
> > |--------------------------------+----------------+--------------|
> > 
> > Note: partition_sched_domains_locked internally calls build_sched_domains
> >       and calls other functions respective to what's being currently used to
> >       export information i.e. sysctl or debugfs
> > 
> > Above numbers are quoted from the case where we tried offlining 1 cpu in system
> > with 1920 online cpus.
> > 
> > From the above table, register_sched_domain_sysctl and
> > unregister_sysctl_table_collectively took ~0.085 secs, whereas
> > update_sched_domain_debugfs took ~2.79 secs. 
> > 
> > Root cause:
> > 
> > The observed regression stems from the way these two pseudo-filesystems handle
> > creation and deletion of files and directories internally.  

Yes, debugfs is not optimized for speed or memory usage at all.  This
happens to be the first code path I have seen that cares about this for
debugfs files.

You can either work on not creating so many debugfs files (do you really
really need all of them all the time?)  Or you can work on moving
debugfs to use kernfs as the backend logic, which will save you both
speed and memory usage overall as kernfs is used to being used on
semi-fast paths.

Maybe do both?

hope this helps,

greg k-h
