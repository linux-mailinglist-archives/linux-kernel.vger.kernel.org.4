Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B45F1886
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiJABvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiJABv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:51:28 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909210EEC3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:51:23 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13189cd5789so7358885fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=ibQZiAr91QEAd19jn2k3eR7nx9WTdJ/KHXw39j0FUbM=;
        b=G2TB9CluSZ5KlEjqfpNPgT/PzGTic00pzfr4qq9WWVFk59tnDGRIgW/LoVj7tx9HqA
         NOJarNssCnXd83TKhDUucg3Om2Sf/g4Dmz6eGCTsRwp6iWumv7RE/g/6vZmsb4Xcs15d
         /AnI7B7/824eYZ7dL2xkhj7flXWOlD6xSyMDrrFNlKUweCUjAOdQ3wZZi6+ZGq0ojFCx
         4NwmiYCQ5Vd3G6dWvJ5/Vc/Bp6d6IwUq1OS6/s4VQpiqVecyb+JUxF5oiP2XFlOzINS1
         x471NtvtAxLeIUgV6feAQJqYj1LAqmQJVYK7skl6c/wpI/L+n3hu7DYtE2hAUczz6Lua
         Aclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ibQZiAr91QEAd19jn2k3eR7nx9WTdJ/KHXw39j0FUbM=;
        b=dZAn8SkcFoxAXxRt0Ee/+541LC3RVDjMxf7m1br1Ojbl6xV6UqfCGhY7NGmsh87kkr
         8HL4c5GxUuhDAQQFtcabmbcEge6UCfPGXX3WA14oTSb0knJ+c4WObSnm76awRvBxj2bB
         Cvrb+Bd2lhQLzP4kpHGCHB0uYb4yQ15r1gcYPQK4XLk9AWkkrBebK4UaTZpDtEzn3LAR
         m6dMiimzzlSGHjepD5oNnNXTRg1IAPtXq7mO6eNZnuLOl5FdoiaHwcV/t4dVUkzmHC8I
         3i1mChSRDvjk6vwFFJTz9gh/1n9adL/Suz3B8Jex7xnnlMKjtBLICaz8uSEgFmbqaslJ
         LEKw==
X-Gm-Message-State: ACrzQf1e/OQzO/PV+u81Fxx0qXyP0wj+oNxn0yNwI5SX5vQFNRVHcae4
        B+gtDvWfv9RPe+KNCiEAr9XWE9uhGe8=
X-Google-Smtp-Source: AMsMyM6lj2iKlOjt4BuSkt171/Zio0JVlJNDFCOAd18+Sl9ic1xrY1ZB6KDUpIvEZFRgBnqX7tjEPQ==
X-Received: by 2002:a05:6870:40cc:b0:126:ddb9:55e8 with SMTP id l12-20020a05687040cc00b00126ddb955e8mr461179oal.281.1664589081835;
        Fri, 30 Sep 2022 18:51:21 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056870d79200b0011f400edb17sm1169406oab.4.2022.09.30.18.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:51:20 -0700 (PDT)
Date:   Fri, 30 Sep 2022 18:49:08 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yury.norov@gmail.com, lkp@lists.01.org, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: [oliver.sang@intel.com: [cpumask]  b9a7ecc71f:
 WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address]
Message-ID: <YzeclACdH9JmaRza@yury-laptop>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0D1p3/gTzmblZ+Pf"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0D1p3/gTzmblZ+Pf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Can you please advise me?

The commit  b9a7ecc71fe582e ("cpumask: fix checking valid cpu range")
fixes broken cpumask_check(), which for now doesn't warn user when it
should. After the fix, I observed many false-positive warnings which
were addressed in the following patches.

The problem is that robots that test the series per-patch spotted that
the cpmask_check() started generating new warnings after b9a7ecc71fe582e.

I don't think it's that important, but if I'm wrong, I can move the
b9a7ecc71fe582e at the very end of the series (as I could do at the
very beginning). In that case, the bitmap-for-next history will be
rewritten, and you don't like it.

So, should I keep things as is, reorder patches or do something else?

Thanks,
Yury

----- Forwarded message from kernel test robot <oliver.sang@intel.com> -----

Date: Fri, 30 Sep 2022 09:52:04 +0800
From: kernel test robot <oliver.sang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
To: Yury Norov <yury.norov@gmail.com>
CC: lkp@lists.01.org, lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: [cpumask]  b9a7ecc71f: WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address


(please be noted we reported
    [cpumask] a9e4ab8629: WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address
at
    https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/F3LJPKA3GI5HP4ONEITCL6MJGSZ5IYOS/
when this commit is still on
    https://github.com/norov/linux cpumask
now we noticed the commit has been merged in linux-next and observed the
similar issue still existing.
report again FYI)


Greeting,

FYI, we noticed the following commit (built with clang-14):

commit: b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4 ("cpumask: fix checking valid cpu range")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
|                                                                                                                                                                            | 944c417dae | b9a7ecc71f |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
| WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address                                                                                                             | 0          | 45         |
| RIP:__is_kernel_percpu_address                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#pcpu_build_alloc_info                                                                                                                  | 0          | 45         |
| RIP:pcpu_build_alloc_info                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#pcpu_setup_first_chunk                                                                                                                 | 0          | 45         |
| RIP:pcpu_setup_first_chunk                                                                                                                                                 | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#setup_per_cpu_areas                                                                                                                    | 0          | 45         |
| RIP:setup_per_cpu_areas                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#build_all_zonelists_init                                                                                                               | 0          | 45         |
| RIP:build_all_zonelists_init                                                                                                                                               | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#setup_cpu_entry_areas                                                                                                                  | 0          | 45         |
| RIP:setup_cpu_entry_areas                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#pcpu_alloc                                                                                                                             | 0          | 45         |
| RIP:pcpu_alloc                                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#__kmem_cache_create                                                                                                                    | 0          | 45         |
| RIP:__kmem_cache_create                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#vmalloc_init                                                                                                                           | 0          | 45         |
| RIP:vmalloc_init                                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#__cpuhp_state_add_instance_cpuslocked                                                                                                  | 0          | 45         |
| RIP:__cpuhp_state_add_instance_cpuslocked                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#set_buffer_entries                                                                                                                     | 0          | 45         |
| RIP:set_buffer_entries                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#sched_init                                                                                                                             | 0          | 45         |
| RIP:sched_init                                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cpudl_init                                                                                                                             | 0          | 45         |
| RIP:cpudl_init                                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cpupri_init                                                                                                                            | 0          | 45         |
| RIP:cpupri_init                                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#group_init                                                                                                                             | 0          | 45         |
| RIP:group_init                                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#workqueue_init_early                                                                                                                   | 0          | 45         |
| RIP:workqueue_init_early                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#alloc_workqueue                                                                                                                        | 0          | 45         |
| RIP:alloc_workqueue                                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#kfree_rcu_batch_init                                                                                                                   | 0          | 45         |
| RIP:kfree_rcu_batch_init                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#rcu_init_one                                                                                                                           | 0          | 45         |
| RIP:rcu_init_one                                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#context_tracking_init                                                                                                                  | 0          | 45         |
| RIP:context_tracking_init                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#alloc_desc                                                                                                                             | 0          | 45         |
| RIP:alloc_desc                                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#_vm_unmap_aliases                                                                                                                      | 0          | 45         |
| RIP:_vm_unmap_aliases                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#purge_fragmented_blocks_allcpus                                                                                                        | 0          | 45         |
| RIP:purge_fragmented_blocks_allcpus                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#init_timer_cpus                                                                                                                        | 0          | 45         |
| RIP:init_timer_cpus                                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#softirq_init                                                                                                                           | 0          | 45         |
| RIP:softirq_init                                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#perf_event_init_all_cpus                                                                                                               | 0          | 45         |
| RIP:perf_event_init_all_cpus                                                                                                                                               | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#init_srcu_struct_fields                                                                                                                | 0          | 45         |
| RIP:init_srcu_struct_fields                                                                                                                                                | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#perf_pmu_register                                                                                                                      | 0          | 45         |
| RIP:perf_pmu_register                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#init_hw_breakpoint                                                                                                                     | 0          | 45         |
| RIP:init_hw_breakpoint                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#call_function_init                                                                                                                     | 0          | 45         |
| RIP:call_function_init                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#setup_zone_pageset                                                                                                                     | 0          | 45         |
| RIP:setup_zone_pageset                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#__zone_set_pageset_high_and_batch                                                                                                      | 0          | 45         |
| RIP:__zone_set_pageset_high_and_batch                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cyc2ns_init_secondary_cpus                                                                                                             | 0          | 45         |
| RIP:cyc2ns_init_secondary_cpus                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#__cpuhp_setup_state_cpuslocked                                                                                                         | 0          | 45         |
| RIP:__cpuhp_setup_state_cpuslocked                                                                                                                                         | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cgroup_rstat_boot                                                                                                                      | 0          | 45         |
| RIP:cgroup_rstat_boot                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cgroup_rstat_init                                                                                                                      | 0          | 45         |
| RIP:cgroup_rstat_init                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#nr_context_switches                                                                                                                    | 0          | 45         |
| RIP:nr_context_switches                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#smp_cpu_index_default                                                                                                                  | 0          | 45         |
| RIP:smp_cpu_index_default                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#topology_phys_to_logical_pkg                                                                                                           | 0          | 45         |
| RIP:topology_phys_to_logical_pkg                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#topology_phys_to_logical_die                                                                                                           | 0          | 45         |
| RIP:topology_phys_to_logical_die                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#smp_prepare_cpus_common                                                                                                                | 0          | 45         |
| RIP:smp_prepare_cpus_common                                                                                                                                                | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#workqueue_init                                                                                                                         | 0          | 45         |
| RIP:workqueue_init                                                                                                                                                         | 0          | 45         |
| calltrace:copy_process                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#wq_watchdog_reset_touched                                                                                                              | 0          | 45         |
| RIP:wq_watchdog_reset_touched                                                                                                                                              | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#start_shepherd_timer                                                                                                                   | 0          | 45         |
| RIP:start_shepherd_timer                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cblist_init_generic                                                                                                                    | 0          | 45         |
| RIP:cblist_init_generic                                                                                                                                                    | 0          | 45         |
| calltrace:irq_exit_rcu                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#try_check_zero                                                                                                                         | 0          | 45         |
| RIP:try_check_zero                                                                                                                                                         | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#rcu_tasks_trace_pregp_step                                                                                                             | 0          | 45         |
| RIP:rcu_tasks_trace_pregp_step                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#rcu_spawn_core_kthreads                                                                                                                | 0          | 45         |
| RIP:rcu_spawn_core_kthreads                                                                                                                                                | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cpu_stop_init                                                                                                                          | 0          | 45         |
| RIP:cpu_stop_init                                                                                                                                                          | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#__lockup_detector_reconfigure                                                                                                          | 0          | 45         |
| RIP:__lockup_detector_reconfigure                                                                                                                                          | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#idle_threads_init                                                                                                                      | 0          | 45         |
| RIP:idle_threads_init                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cpuhp_init_state                                                                                                                       | 0          | 45         |
| RIP:cpuhp_init_state                                                                                                                                                       | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#percpu_down_write                                                                                                                      | 0          | 45         |
| RIP:percpu_down_write                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#select_fallback_rq                                                                                                                     | 0          | 45         |
| RIP:select_fallback_rq                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#set_cpu_sibling_map                                                                                                                    | 0          | 45         |
| RIP:set_cpu_sibling_map                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#sched_core_lock                                                                                                                        | 0          | 45         |
| RIP:sched_core_lock                                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#sched_core_unlock                                                                                                                      | 0          | 45         |
| RIP:sched_core_unlock                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#speculative_store_bypass_ht_init                                                                                                       | 0          | 45         |
| RIP:speculative_store_bypass_ht_init                                                                                                                                       | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cpumask_any_and_distribute                                                                                                             | 0          | 45         |
| RIP:cpumask_any_and_distribute                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#refresh_zone_stat_thresholds                                                                                                           | 0          | 45         |
| RIP:refresh_zone_stat_thresholds                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#bringup_nonboot_cpus                                                                                                                   | 0          | 45         |
| RIP:bringup_nonboot_cpus                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#native_smp_cpus_done                                                                                                                   | 0          | 45         |
| RIP:native_smp_cpus_done                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#asym_cpu_capacity_scan                                                                                                                 | 0          | 45         |
| RIP:asym_cpu_capacity_scan                                                                                                                                                 | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#build_sched_domains                                                                                                                    | 0          | 45         |
| RIP:build_sched_domains                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cpumask_next_wrap                                                                                                                      | 0          | 45         |
| RIP:cpumask_next_wrap                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#load_balance                                                                                                                           | 0          | 45         |
| RIP:load_balance                                                                                                                                                           | 0          | 45         |
| RIP:console_emit_next_record                                                                                                                                               | 0          | 42         |
| WARNING:at_include/linux/cpumask.h:#init_sched_rt_class                                                                                                                    | 0          | 45         |
| RIP:init_sched_rt_class                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#init_sched_dl_class                                                                                                                    | 0          | 45         |
| RIP:init_sched_dl_class                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#find_idlest_cpu                                                                                                                        | 0          | 45         |
| RIP:find_idlest_cpu                                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#kfree_rcu_scheduler_running                                                                                                            | 0          | 45         |
| RIP:kfree_rcu_scheduler_running                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#filelock_init                                                                                                                          | 0          | 45         |
| RIP:filelock_init                                                                                                                                                          | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#pcpu_populate_chunk                                                                                                                    | 0          | 45         |
| RIP:pcpu_populate_chunk                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#mnt_get_count                                                                                                                          | 0          | 45         |
| RIP:mnt_get_count                                                                                                                                                          | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#bpf_prog_alloc                                                                                                                         | 0          | 45         |
| RIP:bpf_prog_alloc                                                                                                                                                         | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#smp_call_function_many_cond                                                                                                            | 0          | 45         |
| RIP:smp_call_function_many_cond                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#topology_init                                                                                                                          | 0          | 45         |
| RIP:topology_init                                                                                                                                                          | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#clocksource_watchdog                                                                                                                   | 0          | 45         |
| RIP:clocksource_watchdog                                                                                                                                                   | 0          | 45         |
| RIP:default_idle                                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#vmstat_shepherd                                                                                                                        | 0          | 45         |
| RIP:vmstat_shepherd                                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cryptd_init                                                                                                                            | 0          | 45         |
| RIP:cryptd_init                                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#blk_mq_init                                                                                                                            | 0          | 45         |
| RIP:blk_mq_init                                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#irq_matrix_alloc                                                                                                                       | 0          | 45         |
| RIP:irq_matrix_alloc                                                                                                                                                       | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#flush_all_cpus_locked                                                                                                                  | 0          | 45         |
| RIP:flush_all_cpus_locked                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#collect_percpu_times                                                                                                                   | 0          | 45         |
| RIP:collect_percpu_times                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#net_dev_init                                                                                                                           | 0          | 45         |
| RIP:net_dev_init                                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#loopback_dev_init                                                                                                                      | 0          | 45         |
| RIP:loopback_dev_init                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#dev_lstats_read                                                                                                                        | 0          | 45         |
| RIP:dev_lstats_read                                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#sched_rt_period_timer                                                                                                                  | 0          | 45         |
| RIP:sched_rt_period_timer                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#queue_stop_cpus_work                                                                                                                   | 0          | 45         |
| RIP:queue_stop_cpus_work                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#tracer_init_tracefs                                                                                                                    | 0          | 45         |
| RIP:tracer_init_tracefs                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#get_nr_inodes                                                                                                                          | 0          | 45         |
| RIP:get_nr_inodes                                                                                                                                                          | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#get_nr_dirty_inodes                                                                                                                    | 0          | 45         |
| RIP:get_nr_dirty_inodes                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#mnt_get_writers                                                                                                                        | 0          | 45         |
| RIP:mnt_get_writers                                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#ip_rt_init                                                                                                                             | 0          | 45         |
| RIP:ip_rt_init                                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#ipv4_mib_init_net                                                                                                                      | 0          | 45         |
| RIP:ipv4_mib_init_net                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#tcp_v4_init                                                                                                                            | 0          | 45         |
| RIP:tcp_v4_init                                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#tcp_tasklet_init                                                                                                                       | 0          | 45         |
| RIP:tcp_tasklet_init                                                                                                                                                       | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#tcp_orphan_count_sum                                                                                                                   | 0          | 45         |
| RIP:tcp_orphan_count_sum                                                                                                                                                   | 0          | 45         |
| RIP:udp_table_init                                                                                                                                                         | 0          | 3          |
| WARNING:at_include/linux/cpumask.h:#icmp_init                                                                                                                              | 0          | 45         |
| RIP:icmp_init                                                                                                                                                              | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#__queue_work                                                                                                                           | 0          | 45         |
| RIP:__queue_work                                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#init_tracer_tracefs                                                                                                                    | 0          | 45         |
| RIP:init_tracer_tracefs                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cpuhp_sysfs_init                                                                                                                       | 0          | 45         |
| RIP:cpuhp_sysfs_init                                                                                                                                                       | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#tick_init_sysfs                                                                                                                        | 0          | 45         |
| RIP:tick_init_sysfs                                                                                                                                                        | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#kcov_init                                                                                                                              | 0          | 45         |
| RIP:kcov_init                                                                                                                                                              | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#set_pgdat_percpu_threshold                                                                                                             | 0          | 45         |
| RIP:set_pgdat_percpu_threshold                                                                                                                                             | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#acpi_processor_throttling_init                                                                                                         | 0          | 45         |
| RIP:acpi_processor_throttling_init                                                                                                                                         | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#populate_cache_leaves                                                                                                                  | 0          | 45         |
| RIP:populate_cache_leaves                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#blk_mq_map_queues                                                                                                                      | 0          | 45         |
| RIP:blk_mq_map_queues                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#sbitmap_init_node                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#blkg_alloc                                                                                                                             | 0          | 45         |
| RIP:blkg_alloc                                                                                                                                                             | 0          | 45         |
| RIP:sbitmap_init_node                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#iolatency_pd_init                                                                                                                      | 0          | 45         |
| RIP:iolatency_pd_init                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#__percpu_ref_switch_mode                                                                                                               | 0          | 45         |
| RIP:__percpu_ref_switch_mode                                                                                                                                               | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#blk_mq_init_allocated_queue                                                                                                            | 0          | 45         |
| RIP:blk_mq_init_allocated_queue                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#blk_mq_sysfs_init                                                                                                                      | 0          | 45         |
| RIP:blk_mq_sysfs_init                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#blk_mq_map_swqueue                                                                                                                     | 0          | 45         |
| RIP:blk_mq_map_swqueue                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#blk_stat_add_callback                                                                                                                  | 0          | 45         |
| RIP:blk_stat_add_callback                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#blk_mq_update_queue_map                                                                                                                | 0          | 45         |
| RIP:blk_mq_update_queue_map                                                                                                                                                | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#flush_tlb_mm_range                                                                                                                     | 0          | 45         |
| RIP:flush_tlb_mm_range                                                                                                                                                     | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#spi_alloc_pcpu_stats                                                                                                                   | 0          | 45         |
| RIP:spi_alloc_pcpu_stats                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#ipv6_init_mibs                                                                                                                         | 0          | 45         |
| RIP:ipv6_init_mibs                                                                                                                                                         | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#icmpv6_init                                                                                                                            | 0          | 45         |
| RIP:icmpv6_init                                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#cpumask_next                                                                                                                           | 0          | 45         |
| RIP:cpumask_next                                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#ipv6_add_dev                                                                                                                           | 0          | 45         |
| RIP:ipv6_add_dev                                                                                                                                                           | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#ipip6_tunnel_init                                                                                                                      | 0          | 45         |
| RIP:ipip6_tunnel_init                                                                                                                                                      | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#dev_fetch_sw_netstats                                                                                                                  | 0          | 45         |
| RIP:dev_fetch_sw_netstats                                                                                                                                                  | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#snmp6_fill_stats                                                                                                                       | 0          | 45         |
| RIP:snmp6_fill_stats                                                                                                                                                       | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#update_sched_domain_debugfs                                                                                                            | 0          | 45         |
| RIP:update_sched_domain_debugfs                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#rt_fibinfo_free_cpus                                                                                                                   | 0          | 45         |
| RIP:rt_fibinfo_free_cpus                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#qdisc_alloc                                                                                                                            | 0          | 45         |
| RIP:qdisc_alloc                                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#rcu_barrier                                                                                                                            | 0          | 45         |
| RIP:rcu_barrier                                                                                                                                                            | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#nr_processes                                                                                                                           | 0          | 28         |
| RIP:nr_processes                                                                                                                                                           | 0          | 28         |
| WARNING:at_include/linux/cpumask.h:#alloc_fair_sched_group                                                                                                                 | 0          | 45         |
| RIP:alloc_fair_sched_group                                                                                                                                                 | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#alloc_rt_sched_group                                                                                                                   | 0          | 45         |
| RIP:alloc_rt_sched_group                                                                                                                                                   | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#free_rt_sched_group                                                                                                                    | 0          | 45         |
| RIP:free_rt_sched_group                                                                                                                                                    | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#online_fair_sched_group                                                                                                                | 0          | 45         |
| RIP:online_fair_sched_group                                                                                                                                                | 0          | 45         |
| WARNING:at_include/linux/cpumask.h:#c_start                                                                                                                                | 0          | 27         |
| RIP:c_start                                                                                                                                                                | 0          | 27         |
| WARNING:at_include/linux/cpumask.h:#cgroup_rstat_flush_locked                                                                                                              | 0          | 27         |
| RIP:cgroup_rstat_flush_locked                                                                                                                                              | 0          | 27         |
| WARNING:at_include/linux/cpumask.h:#__percpu_counter_sum                                                                                                                   | 0          | 35         |
| RIP:__percpu_counter_sum                                                                                                                                                   | 0          | 35         |
| WARNING:at_include/linux/cpumask.h:#percpu_ref_switch_to_atomic_rcu                                                                                                        | 0          | 19         |
| RIP:percpu_ref_switch_to_atomic_rcu                                                                                                                                        | 0          | 19         |
| WARNING:at_include/linux/cpumask.h:#unregister_fair_sched_group                                                                                                            | 0          | 29         |
| RIP:unregister_fair_sched_group                                                                                                                                            | 0          | 29         |

....

+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/r/202209292151.f0b8f7f1-oliver.sang@intel.com


[    1.587838][    T0] ------------[ cut here ]------------
[ 1.588505][ T0] WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:110 __is_kernel_percpu_address (include/linux/cpumask.h:110 include/linux/cpumask.h:117 include/linux/cpumask.h:178 mm/percpu.c:2320) 
[    1.589783][    T0] Modules linked in:
[    1.590250][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc4-00018-gb9a7ecc71fe5 #1
[    1.591281][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 1.592535][ T0] RIP: 0010:__is_kernel_percpu_address (include/linux/cpumask.h:110 include/linux/cpumask.h:117 include/linux/cpumask.h:178 mm/percpu.c:2320) 
[ 1.593336][ T0] Code: 29 cb 72 16 48 8b 4d c8 48 01 c8 48 05 00 00 00 00 48 39 d0 0f 87 af 00 00 00 e8 61 99 ec ff e9 36 ff ff ff e8 57 99 ec ff 90 <0f> 0b 90 e9 49 ff ff ff 48 c7 c1 88 73 a7 89 80 e1 07 80 c1 03 38
All code
========
   0:	29 cb                	sub    %ecx,%ebx
   2:	72 16                	jb     0x1a
   4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   8:	48 01 c8             	add    %rcx,%rax
   b:	48 05 00 00 00 00    	add    $0x0,%rax
  11:	48 39 d0             	cmp    %rdx,%rax
  14:	0f 87 af 00 00 00    	ja     0xc9
  1a:	e8 61 99 ec ff       	callq  0xffffffffffec9980
  1f:	e9 36 ff ff ff       	jmpq   0xffffffffffffff5a
  24:	e8 57 99 ec ff       	callq  0xffffffffffec9980
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	90                   	nop
  2d:	e9 49 ff ff ff       	jmpq   0xffffffffffffff7b
  32:	48 c7 c1 88 73 a7 89 	mov    $0xffffffff89a77388,%rcx
  39:	80 e1 07             	and    $0x7,%cl
  3c:	80 c1 03             	add    $0x3,%cl
  3f:	38                   	.byte 0x38

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	90                   	nop
   3:	e9 49 ff ff ff       	jmpq   0xffffffffffffff51
   8:	48 c7 c1 88 73 a7 89 	mov    $0xffffffff89a77388,%rcx
   f:	80 e1 07             	and    $0x7,%cl
  12:	80 c1 03             	add    $0x3,%cl
  15:	38                   	.byte 0x38
[    1.595672][    T0] RSP: 0000:ffffffff88207b20 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
[    1.596689][    T0] RAX: ffffffff814ed015 RBX: ffffffffff30c690 RCX: ffffffff882b0440
[    1.597660][    T0] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff89a77170
[    1.598625][    T0] RBP: ffffffff88207b60 R08: 0000000000000001 R09: 0000000000000001
[    1.599589][    T0] R10: 0000000000000000 R11: dffff7fff134ee2e R12: dffffc0000000000
[    1.600507][    T0] R13: 0000000000000002 R14: 1ffffffff134ee71 R15: dffffc0000000000
[    1.601435][    T0] FS:  0000000000000000(0000) GS:ffffffff89abe000(0000) knlGS:0000000000000000
[    1.602503][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.603292][    T0] CR2: ffff88843ffff000 CR3: 000000000827f000 CR4: 00000000000406b0
[    1.604301][    T0] Call Trace:
[    1.604704][    T0]  <TASK>
[ 1.605070][ T0] assign_lock_key (kernel/locking/lockdep.c:966) 
[ 1.605641][ T0] register_lock_class (kernel/locking/lockdep.c:?) 
[ 1.606283][ T0] ? __lock_acquire (kernel/locking/lockdep.c:?) 
[ 1.606885][ T0] __lock_acquire (kernel/locking/lockdep.c:?) 
[ 1.607457][ T0] ? __cpuhp_setup_state_cpuslocked (kernel/cpu.c:2099) 
[ 1.608221][ T0] lock_acquire (kernel/locking/lockdep.c:5666) 
[ 1.608764][ T0] ? register_syscore_ops (include/linux/list.h:102 drivers/base/syscore.c:24) 
[ 1.609431][ T0] ? __kasan_check_read (mm/kasan/shadow.c:31) 
[ 1.610050][ T0] __mutex_lock_common (kernel/locking/mutex.c:603) 
[ 1.610682][ T0] ? register_syscore_ops (include/linux/list.h:102 drivers/base/syscore.c:24) 
[ 1.611316][ T0] ? rcu_read_lock_held_common (kernel/rcu/update.c:104) 
[ 1.611988][ T0] ? lock_release (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:227 kernel/locking/lockdep.c:351 kernel/locking/lockdep.c:5348 kernel/locking/lockdep.c:5686) 
[ 1.612555][ T0] ? register_syscore_ops (include/linux/list.h:102 drivers/base/syscore.c:24) 
[ 1.613178][ T0] ? rcu_read_lock_any_held (kernel/rcu/update.c:344) 
[ 1.613844][ T0] mutex_lock_nested (kernel/locking/mutex.c:747 kernel/locking/mutex.c:799) 
[ 1.614394][ T0] register_syscore_ops (include/linux/list.h:102 drivers/base/syscore.c:24) 
[ 1.615010][ T0] kvm_guest_init (arch/x86/kernel/kvm.c:873) 
[ 1.615603][ T0] setup_arch (arch/x86/kernel/setup.c:1299) 
[ 1.616127][ T0] start_kernel (init/main.c:953) 
[ 1.616683][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:557) 
[ 1.617354][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:538) 
[ 1.617991][ T0] secondary_startup_64_no_verify (??:?) 
[    1.618723][    T0]  </TASK>
[    1.619100][    T0] irq event stamp: 0
[ 1.619596][ T0] hardirqs last enabled at (0): 0x0 
[ 1.620473][ T0] hardirqs last disabled at (0): 0x0 
[ 1.621376][ T0] softirqs last enabled at (0): 0x0 
[ 1.622287][ T0] softirqs last disabled at (0): 0x0 
[    1.623156][    T0] ---[ end trace 0000000000000000 ]---
[    1.623917][    T0] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    1.624731][    T0] Booting paravirtualized kernel on KVM
[    1.625408][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    1.626742][    T0] setup_percpu: NR_CPUS:64 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1


To reproduce:

        # build kernel
	cd linux
	cp config-6.0.0-rc4-00018-gb9a7ecc71fe5 .config
	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.0.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 14.0.6 (git://gitmirror/llvm_project f28c006a5895fc0e329fe15fead81e37457cb1d1)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=140006
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=140006
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=140006
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_KERNEL_ZSTD=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
CONFIG_CONTEXT_TRACKING_USER=y
CONFIG_CONTEXT_TRACKING_USER_FORCE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
CONFIG_X86_VSMP=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_MID=y
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
CONFIG_ACRN_GUEST=y
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=12
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_STRICT_SIGALTSTACK_SIZE=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_RETPOLINE=y
CONFIG_CPU_IBRS_ENTRY=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=y
CONFIG_NFIT_SECURITY_DEBUG=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
CONFIG_DPTF_PCH_FIVR=y
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_CONFIGFS=y
CONFIG_ACPI_PFRUT=y
CONFIG_PMIC_OPREGION=y
# CONFIG_BYTCRC_PMIC_OPREGION is not set
CONFIG_CHTCRC_PMIC_OPREGION=y
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_BXT_WC_PMIC_OPREGION=y
CONFIG_CHT_WC_PMIC_OPREGION=y
# CONFIG_TPS68470_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
CONFIG_ZONE_DMA32=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
# CONFIG_PTE_MARKER_UFFD_WP is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
CONFIG_PCIE_BUS_PERFORMANCE=y
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
CONFIG_YENTA=y
CONFIG_YENTA_O2=y
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
# CONFIG_YENTA_TOSHIBA is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_CPS_GEN2=y
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_CS_DSP=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
CONFIG_EFI_DISABLE_PCI_DMA=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
CONFIG_EFI_DISABLE_RUNTIME=y
CONFIG_EFI_COCO_SECRET=y
CONFIG_EFI_EMBEDDED_FIRMWARE=y
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_USB=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
CONFIG_NFTL=y
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_SBC_GXX=y
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
CONFIG_MTD_CK804XROM=y
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
CONFIG_MTD_PCI=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_MCHP48L640 is not set
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
CONFIG_MTD_NAND_CAFE=y
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y
# CONFIG_MTD_NAND_ARASAN is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_SPI_NAND=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
# CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE is not set
CONFIG_MTD_SPI_NOR_SWP_KEEP=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_FD_RAWCMD is not set
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_UBLK=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=y
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=y
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_GSC=y
CONFIG_INTEL_MEI_HDCP=y
CONFIG_INTEL_MEI_PXP=y
CONFIG_VMWARE_VMCI=y
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
CONFIG_BCM_VK=y
# CONFIG_BCM_VK_TTY is not set
CONFIG_MISC_ALCOR_PCI=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
# CONFIG_ATA_FORCE is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=y
CONFIG_SATA_SX4=y
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_MV=y
CONFIG_SATA_NV=y
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
CONFIG_SATA_SIS=y
CONFIG_SATA_SVW=y
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
CONFIG_SATA_VITESSE=y

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=y
# CONFIG_PATA_AMD is not set
CONFIG_PATA_ARTOP=y
CONFIG_PATA_ATIIXP=y
# CONFIG_PATA_ATP867X is not set
CONFIG_PATA_CMD64X=y
# CONFIG_PATA_CYPRESS is not set
CONFIG_PATA_EFAR=y
CONFIG_PATA_HPT366=y
CONFIG_PATA_HPT37X=y
CONFIG_PATA_HPT3X2N=y
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
CONFIG_PATA_JMICRON=y
CONFIG_PATA_MARVELL=y
# CONFIG_PATA_NETCELL is not set
CONFIG_PATA_NINJA32=y
CONFIG_PATA_NS87415=y
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=y
# CONFIG_PATA_PDC_OLD is not set
CONFIG_PATA_RADISYS=y
CONFIG_PATA_RDC=y
CONFIG_PATA_SCH=y
CONFIG_PATA_SERVERWORKS=y
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=y
# CONFIG_PATA_TOSHIBA is not set
CONFIG_PATA_TRIFLEX=y
# CONFIG_PATA_VIA is not set
CONFIG_PATA_WINBOND=y

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=y
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
CONFIG_PATA_RZ1000=y

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=y
CONFIG_ATA_GENERIC=y
CONFIG_PATA_LEGACY=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
# CONFIG_MD_FAULTY is not set
CONFIG_BCACHE=y
CONFIG_BCACHE_DEBUG=y
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
# CONFIG_BLK_DEV_DM is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_APPLESPI=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=y
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_AD7879_SPI=y
CONFIG_TOUCHSCREEN_ADC=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_ILITEK=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
# CONFIG_TOUCHSCREEN_MSG2638 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_IMAGIS=y
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
CONFIG_TOUCHSCREEN_WM97XX=y
CONFIG_TOUCHSCREEN_WM9705=y
# CONFIG_TOUCHSCREEN_WM9712 is not set
# CONFIG_TOUCHSCREEN_WM9713 is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
# CONFIG_TOUCHSCREEN_USB_PANJIT is not set
CONFIG_TOUCHSCREEN_USB_3M=y
# CONFIG_TOUCHSCREEN_USB_ITM is not set
# CONFIG_TOUCHSCREEN_USB_ETURBO is not set
CONFIG_TOUCHSCREEN_USB_GUNZE=y
# CONFIG_TOUCHSCREEN_USB_DMC_TSC10 is not set
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
# CONFIG_TOUCHSCREEN_USB_JASTEC is not set
CONFIG_TOUCHSCREEN_USB_ELO=y
# CONFIG_TOUCHSCREEN_USB_E2I is not set
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
# CONFIG_TOUCHSCREEN_USB_ETT_TC45USB is not set
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2005 is not set
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=y
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_TOUCHSCREEN_ZINITIX=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_AD714X_SPI=y
# CONFIG_INPUT_ARIZONA_HAPTICS is not set
CONFIG_INPUT_ATC260X_ONKEY=y
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MAX8997_HAPTIC=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
# CONFIG_INPUT_TWL6040_VIBRA is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PALMAS_PWRBUTTON is not set
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA7280_HAPTICS=y
# CONFIG_INPUT_DA9055_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_WM831X_ON=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_ADXL34X_SPI=y
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_IQS269A=y
# CONFIG_INPUT_IQS626A is not set
CONFIG_INPUT_IQS7222=y
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_SOC_BUTTON_ARRAY is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_HYPERV_KEYBOARD=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_IPMB=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_NVRAM is not set
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_CHT_WC is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_DMA=y
CONFIG_SPI_DW_PCI=y
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_DLN2=y
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
CONFIG_SPI_INTEL=y
# CONFIG_SPI_INTEL_PCI is not set
CONFIG_SPI_INTEL_PLATFORM=y
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_MICROCHIP_CORE=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_MERRIFIELD is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_JASPERLAKE=y
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_METEORLAKE=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_VX855=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CRYSTAL_COVE=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_DLN2=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_MADERA is not set
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TPS68470=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WHISKEY_COVE=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_MERRIFIELD=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_IP5XXX_POWER=y
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_WM97XX is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_CHARGER_AXP20X is not set
CONFIG_BATTERY_AXP20X=y
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_CHARGER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_MAX77976=y
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_MP2629=y
CONFIG_CHARGER_MT6360=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=y
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_SENSORS_PECI_CPUTEMP=y
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
# CONFIG_SENSORS_FSP_3Y is not set
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_DPS920AB=y
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR36021=y
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IR38064_REGULATOR=y
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LM25066_REGULATOR=y
# CONFIG_SENSORS_LT7182S is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=y
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE152=y
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
# CONFIG_SENSORS_ASUS_WMI is not set
CONFIG_SENSORS_ASUS_EC=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INT3406_THERMAL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=y
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
CONFIG_INTEL_MENLOW=y
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WDAT_WDT=y
CONFIG_WM831X_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
CONFIG_INTEL_MID_WATCHDOG=y
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_KEMPLD_WDT=y
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_PCI is not set
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=y
CONFIG_INTEL_SOC_PMIC_CHTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_PMC_BXT=y
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_ATC260X=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_SY7636A=y
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS68470=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_REGULATOR_QCOM_LABIBB=y
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# Camera sensor devices
#
CONFIG_VIDEO_CCS_PLL=y
CONFIG_VIDEO_AR0521=y
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
CONFIG_VIDEO_IMX214=y
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
# CONFIG_VIDEO_IMX274 is not set
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX319=y
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_MAX9271_LIB=y
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
CONFIG_VIDEO_MT9T001=y
# CONFIG_VIDEO_MT9T112 is not set
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
CONFIG_VIDEO_NOON010PC30=y
CONFIG_VIDEO_OG01A1B=y
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV2740=y
CONFIG_VIDEO_OV5647=y
# CONFIG_VIDEO_OV5648 is not set
CONFIG_VIDEO_OV5670=y
# CONFIG_VIDEO_OV5675 is not set
CONFIG_VIDEO_OV5693=y
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV6650=y
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7740=y
# CONFIG_VIDEO_OV8856 is not set
CONFIG_VIDEO_OV8865=y
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
CONFIG_VIDEO_OV9734=y
CONFIG_VIDEO_RDACM20=y
# CONFIG_VIDEO_RDACM21 is not set
CONFIG_VIDEO_RJ54N1=y
CONFIG_VIDEO_S5C73M3=y
CONFIG_VIDEO_S5K4ECGX=y
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_CCS=y
# CONFIG_VIDEO_ET8EK8 is not set
CONFIG_VIDEO_M5MOLS=y
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_AK7375=y
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
CONFIG_VIDEO_LM3646=y
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=y
# CONFIG_VIDEO_TDA1997X is not set
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_UDA1342=y
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_ADV7604=y
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=y
CONFIG_VIDEO_ADV7842_CEC=y
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
# CONFIG_VIDEO_TC358743 is not set
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_ADV7511=y
# CONFIG_VIDEO_ADV7511_CEC is not set
CONFIG_VIDEO_AK881X=y
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_ST_MIPID02=y
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_QM1D1B0004=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=y
# CONFIG_MEDIA_TUNER_TDA18271 is not set
# CONFIG_MEDIA_TUNER_TDA827X is not set
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_STB0899=y
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
# CONFIG_DVB_STV6111 is not set

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0288=y
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA8261=y
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TS2020=y
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_TUNER_CX24113=y
# CONFIG_DVB_TUNER_ITD1000 is not set
CONFIG_DVB_VES1X93=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
# CONFIG_DVB_CX22700 is not set
# CONFIG_DVB_CX22702 is not set
# CONFIG_DVB_CXD2820R is not set
# CONFIG_DVB_CXD2841ER is not set
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_L64781=y
CONFIG_DVB_MT352=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_RTL2832_SDR=y
CONFIG_DVB_S5H1432=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_SP887X=y
# CONFIG_DVB_STV0367 is not set
# CONFIG_DVB_TDA10048 is not set
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_STV0297 is not set
CONFIG_DVB_TDA10021=y
# CONFIG_DVB_TDA10023 is not set
# CONFIG_DVB_VES1820 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
# CONFIG_DVB_AU8522_DTV is not set
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LG2160=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y
CONFIG_DVB_S921=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_ATBM8830=y
CONFIG_DVB_HELENE=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ISL6405=y
# CONFIG_DVB_ISL6421 is not set
CONFIG_DVB_ISL6423=y
CONFIG_DVB_IX2505V=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBH29 is not set
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_TDA665x=y
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
# CONFIG_DRM_I915_PXP is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
CONFIG_DRM_I915_DEBUG_MMIO=y
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
CONFIG_DRM_QXL=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=y
CONFIG_DRM_CIRRUS_QEMU=y
# CONFIG_DRM_GM12U320 is not set
CONFIG_DRM_PANEL_MIPI_DBI=y
# CONFIG_DRM_SIMPLEDRM is not set
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9163=y
CONFIG_TINYDRM_ILI9225=y
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=y
CONFIG_TINYDRM_ST7586=y
CONFIG_TINYDRM_ST7735R=y
CONFIG_DRM_VBOXVIDEO=y
# CONFIG_DRM_GUD is not set
CONFIG_DRM_SSD130X=y
# CONFIG_DRM_SSD130X_I2C is not set
# CONFIG_DRM_SSD130X_SPI is not set
CONFIG_DRM_HYPERV=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_MATROX_MAVEN=y
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_CTL_FAST_LOOKUP is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_CTL_INPUT_VALIDATION=y
CONFIG_SND_CTL_DEBUG=y
CONFIG_SND_JACK_INJECTION_DEBUG=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_VX_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
CONFIG_SND_MTS64=y
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=y
CONFIG_SND_PORTMAN2X4=y
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_SB_COMMON=y
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
CONFIG_SND_ALS4000=y
CONFIG_SND_ASIHPI=y
# CONFIG_SND_ATIIXP is not set
CONFIG_SND_ATIIXP_MODEM=y
CONFIG_SND_AU8810=y
CONFIG_SND_AU8820=y
# CONFIG_SND_AU8830 is not set
CONFIG_SND_AW2=y
CONFIG_SND_BT87X=y
# CONFIG_SND_BT87X_OVERCLOCK is not set
# CONFIG_SND_CA0106 is not set
CONFIG_SND_CMIPCI=y
CONFIG_SND_OXYGEN_LIB=y
CONFIG_SND_OXYGEN=y
CONFIG_SND_CS4281=y
# CONFIG_SND_CS46XX is not set
CONFIG_SND_CTXFI=y
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
CONFIG_SND_LAYLA20=y
CONFIG_SND_DARLA24=y
CONFIG_SND_GINA24=y
# CONFIG_SND_LAYLA24 is not set
CONFIG_SND_MONA=y
# CONFIG_SND_MIA is not set
CONFIG_SND_ECHO3G=y
CONFIG_SND_INDIGO=y
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
CONFIG_SND_INDIGOIOX=y
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=y
CONFIG_SND_FM801=y
# CONFIG_SND_FM801_TEA575X_BOOL is not set
# CONFIG_SND_HDSP is not set
CONFIG_SND_HDSPM=y
CONFIG_SND_ICE1724=y
# CONFIG_SND_INTEL8X0 is not set
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
CONFIG_SND_LOLA=y
CONFIG_SND_LX6464ES=y
CONFIG_SND_MIXART=y
CONFIG_SND_NM256=y
CONFIG_SND_PCXHR=y
CONFIG_SND_RIPTIDE=y
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_VIA82XX is not set
CONFIG_SND_VIA82XX_MODEM=y
CONFIG_SND_VIRTUOSO=y
CONFIG_SND_VX222=y
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_SCODEC_CS35L41=y
CONFIG_SND_HDA_CS_DSP_CONTROLS=y
CONFIG_SND_HDA_SCODEC_CS35L41_I2C=y
# CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=y
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
CONFIG_SND_HDA_CODEC_CS8409=y
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_SPI=y
# CONFIG_SND_USB is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_ADI=y
CONFIG_SND_SOC_ADI_AXI_I2S=y
CONFIG_SND_SOC_ADI_AXI_SPDIF=y
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_SOC_AMD_ACP3x=y
# CONFIG_SND_SOC_AMD_RENOIR is not set
CONFIG_SND_SOC_AMD_ACP5x=y
# CONFIG_SND_SOC_AMD_VANGOGH_MACH is not set
CONFIG_SND_SOC_AMD_ACP6x=y
# CONFIG_SND_SOC_AMD_YC_MACH is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
# CONFIG_SND_SOC_FSL_MQS is not set
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_FSL_MICFIL=y
CONFIG_SND_SOC_FSL_EASRC=y
# CONFIG_SND_SOC_FSL_XCVR is not set
CONFIG_SND_SOC_FSL_UTILS=y
# CONFIG_SND_SOC_FSL_RPMSG is not set
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
CONFIG_SND_SOC_IMG_SPDIF_IN=y
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
CONFIG_SND_SOC_INTEL_AVS=y

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
# CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO=y
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373=y
CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT274 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT286 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_RT298=y
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567 is not set
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_MTK_BTCVSD=y
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI=y
# CONFIG_SND_SOC_SOF_ACPI is not set
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=y
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=y
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
# CONFIG_SND_SOC_ADAU1372_I2C is not set
CONFIG_SND_SOC_ADAU1372_SPI=y
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU1761_SPI=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
CONFIG_SND_SOC_AK4104=y
CONFIG_SND_SOC_AK4118=y
CONFIG_SND_SOC_AK4375=y
CONFIG_SND_SOC_AK4458=y
# CONFIG_SND_SOC_AK4554 is not set
CONFIG_SND_SOC_AK4613=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_AW8738=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CS35L32=y
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS35L35=y
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS35L41_LIB=y
CONFIG_SND_SOC_CS35L41=y
CONFIG_SND_SOC_CS35L41_SPI=y
CONFIG_SND_SOC_CS35L41_I2C=y
CONFIG_SND_SOC_CS35L45_TABLES=y
CONFIG_SND_SOC_CS35L45=y
CONFIG_SND_SOC_CS35L45_SPI=y
CONFIG_SND_SOC_CS35L45_I2C=y
CONFIG_SND_SOC_CS42L42=y
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4234=y
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS4271_SPI=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
# CONFIG_SND_SOC_CS43130 is not set
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CX2072X=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_ES8328_SPI=y
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDA=y
CONFIG_SND_SOC_ICS43432=y
CONFIG_SND_SOC_INNO_RK3036=y
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
# CONFIG_SND_SOC_MAX98927 is not set
CONFIG_SND_SOC_MAX98520=y
CONFIG_SND_SOC_MAX98373=y
# CONFIG_SND_SOC_MAX98373_I2C is not set
CONFIG_SND_SOC_MAX98390=y
CONFIG_SND_SOC_MAX98396=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM5102A=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
CONFIG_SND_SOC_PCM512x_SPI=y
CONFIG_SND_SOC_RK3328=y
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=y
CONFIG_SND_SOC_RT298=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5659=y
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_RT5682_I2C=y
CONFIG_SND_SOC_RT9120=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2518=y
CONFIG_SND_SOC_SSM2602=y
# CONFIG_SND_SOC_SSM2602_SPI is not set
CONFIG_SND_SOC_SSM2602_I2C=y
# CONFIG_SND_SOC_SSM4567 is not set
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS2562=y
# CONFIG_SND_SOC_TAS2764 is not set
CONFIG_SND_SOC_TAS2770=y
# CONFIG_SND_SOC_TAS2780 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS5805M=y
CONFIG_SND_SOC_TAS6424=y
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TFA989X is not set
CONFIG_SND_SOC_TLV320ADC3XXX=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
CONFIG_SND_SOC_TLV320AIC3X_SPI=y
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=y
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=y
CONFIG_SND_SOC_UDA1334=y
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8731_I2C=y
CONFIG_SND_SOC_WM8731_SPI=y
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=y
# CONFIG_SND_SOC_WM8750 is not set
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8770 is not set
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8804_SPI=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8940=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8974=y
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8985=y
# CONFIG_SND_SOC_ZL38060 is not set
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_MT6660 is not set
CONFIG_SND_SOC_NAU8315=y
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8821=y
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_NAU8825=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
CONFIG_SND_SOC_LPASS_TX_MACRO=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=y
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_APPLEIR=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_BETOP_FF=y
CONFIG_HID_BIGBEN_FF=y
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_PRODIKEYS=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CREATIVE_SB0540=y
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LETSKETCH=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MEGAWORLD_FF=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SEMITEK=y
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_HYPERV_MOUSE=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_U2FZERO=y
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=y
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_OTG_FSM=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_UDC=y
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_GENERIC=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_TAHVO_USB=y
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=y
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
CONFIG_USB_MAX3420_UDC=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_UAC1=y
CONFIG_USB_F_UAC1_LEGACY=y
CONFIG_USB_F_UAC2=y
CONFIG_USB_F_MIDI=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_F_TCM=y
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_UAC1=y
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
CONFIG_USB_CONFIGFS_F_UAC2=y
# CONFIG_USB_CONFIGFS_F_MIDI is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_UVC is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
CONFIG_USB_ZERO_HNPTEST=y
CONFIG_USB_AUDIO=y
# CONFIG_GADGET_UAC1 is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
CONFIG_USB_GADGET_TARGET=y
# CONFIG_USB_G_SERIAL is not set
CONFIG_USB_MIDI_GADGET=y
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
CONFIG_USB_RAW_GADGET=y
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_CCG=y
# CONFIG_UCSI_ACPI is not set
CONFIG_UCSI_STM32G0=y
CONFIG_TYPEC_TPS6598X=y
# CONFIG_TYPEC_ANX7411 is not set
CONFIG_TYPEC_RT1719=y
CONFIG_TYPEC_HD3SS3220=y
CONFIG_TYPEC_STUSB160X=y
CONFIG_TYPEC_WUSB3801=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
CONFIG_TYPEC_MUX_PI3USB30532=y
CONFIG_TYPEC_MUX_INTEL_PMC=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set
CONFIG_MMC_CRYPTO=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=y
CONFIG_MMC_ALCOR=y
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_APU=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_IS31FL319X=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_RT8515 is not set
CONFIG_LEDS_SGM3140=y

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
# CONFIG_UIO_HV_GENERIC is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_PMEM=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
# CONFIG_COMEDI_PCL730 is not set
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=y
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
CONFIG_COMEDI_RTI800=y
CONFIG_COMEDI_RTI802=y
# CONFIG_COMEDI_DAC02 is not set
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
# CONFIG_COMEDI_DAS16 is not set
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=y
CONFIG_COMEDI_DT2811=y
# CONFIG_COMEDI_DT2814 is not set
# CONFIG_COMEDI_DT2815 is not set
# CONFIG_COMEDI_DT2817 is not set
# CONFIG_COMEDI_DT282X is not set
# CONFIG_COMEDI_DMM32AT is not set
# CONFIG_COMEDI_FL512 is not set
# CONFIG_COMEDI_AIO_AIO12_8 is not set
# CONFIG_COMEDI_AIO_IIRO_16 is not set
CONFIG_COMEDI_II_PCI20KC=y
# CONFIG_COMEDI_C6XDIGIO is not set
# CONFIG_COMEDI_MPC624 is not set
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
# CONFIG_COMEDI_NI_AT_AO is not set
# CONFIG_COMEDI_NI_ATMIO is not set
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
# CONFIG_COMEDI_S526 is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
# CONFIG_COMEDI_NI_USB6501 is not set
CONFIG_COMEDI_USBDUX=y
# CONFIG_COMEDI_USBDUXFAST is not set
# CONFIG_COMEDI_USBDUXSIGMA is not set
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=y

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=y
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
# CONFIG_ADT7316_SPI is not set
# CONFIG_ADT7316_I2C is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=y
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
# CONFIG_ADE7854_I2C is not set
CONFIG_ADE7854_SPI=y
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=y
CONFIG_FB_TFT_BD663474=y
# CONFIG_FB_TFT_HX8340BN is not set
CONFIG_FB_TFT_HX8347D=y
# CONFIG_FB_TFT_HX8353D is not set
CONFIG_FB_TFT_HX8357D=y
# CONFIG_FB_TFT_ILI9163 is not set
CONFIG_FB_TFT_ILI9320=y
CONFIG_FB_TFT_ILI9325=y
# CONFIG_FB_TFT_ILI9340 is not set
# CONFIG_FB_TFT_ILI9341 is not set
# CONFIG_FB_TFT_ILI9481 is not set
CONFIG_FB_TFT_ILI9486=y
# CONFIG_FB_TFT_PCD8544 is not set
CONFIG_FB_TFT_RA8875=y
CONFIG_FB_TFT_S6D02A1=y
# CONFIG_FB_TFT_S6D1121 is not set
CONFIG_FB_TFT_SEPS525=y
# CONFIG_FB_TFT_SH1106 is not set
CONFIG_FB_TFT_SSD1289=y
# CONFIG_FB_TFT_SSD1305 is not set
# CONFIG_FB_TFT_SSD1306 is not set
CONFIG_FB_TFT_SSD1331=y
CONFIG_FB_TFT_SSD1351=y
# CONFIG_FB_TFT_ST7735R is not set
CONFIG_FB_TFT_ST7789V=y
# CONFIG_FB_TFT_TINYLCD is not set
CONFIG_FB_TFT_TLS8204=y
CONFIG_FB_TFT_UC1611=y
# CONFIG_FB_TFT_UC1701 is not set
# CONFIG_FB_TFT_UPD161704 is not set
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_NET is not set
# CONFIG_MOST_VIDEO is not set
CONFIG_MOST_I2C=y
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
CONFIG_FIELDBUS_DEV=y
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_GPE=y
CONFIG_SURFACE_HOTPLUG=y
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_MXM_WMI=y
CONFIG_PEAQ_WMI=y
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=y
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=y
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=y
CONFIG_ADV_SWBUTTON=y
CONFIG_APPLE_GMUX=y
CONFIG_ASUS_LAPTOP=y
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_TF103C_DOCK=y
CONFIG_MERAKI_MX100=y
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
CONFIG_GPD_POCKET_FAN=y
CONFIG_HP_ACCEL=y
CONFIG_WIRELESS_HOTKEY=y
CONFIG_HP_WMI=y
CONFIG_IBM_RTL=y
# CONFIG_SENSORS_HDAPS is not set
CONFIG_THINKPAD_LMI=y
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
CONFIG_INTEL_ATOMISP2_PM=y
CONFIG_INTEL_SAR_INT1092=y
CONFIG_INTEL_SKL_INT3472=y
CONFIG_INTEL_PMC_CORE=y

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=y
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TELEMETRY=y
CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=y
CONFIG_INTEL_WMI_THUNDERBOLT=y

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_INT0002_VGPIO=y
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
CONFIG_INTEL_CHTWC_INT33FE=y
CONFIG_INTEL_ISHTP_ECLITE=y
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_INTEL_RST is not set
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_WMI is not set
CONFIG_PCENGINES_APU2=y
CONFIG_BARCO_P50_GPIO=y
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_SAMSUNG_Q10=y
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
CONFIG_TOSHIBA_WMI=y
CONFIG_ACPI_CMPC=y
CONFIG_PANASONIC_LAPTOP=y
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_SERIAL_MULTI_INSTANTIATE=y
CONFIG_MLX_PLATFORM=y
CONFIG_TOUCHSCREEN_DMI=y
CONFIG_FW_ATTR_CLASS=y
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
CONFIG_INTEL_SCU_PLATFORM=y
CONFIG_INTEL_SCU_WDT=y
# CONFIG_INTEL_SCU_IPC_UTIL is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_WINMATE_FM07_KEYS=y
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
CONFIG_LMK04832=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_TPS68470=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_CLK_TWL6040 is not set
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_COMMON_CLK_PWM=y
CONFIG_XILINX_VCU=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_DW_APB_TIMER=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=y
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_INTEL_CHT_WC=y
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
# CONFIG_IIO_BUFFER_DMAENGINE is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
CONFIG_ADXL313=y
CONFIG_ADXL313_I2C=y
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL355_SPI=y
CONFIG_ADXL367=y
# CONFIG_ADXL367_SPI is not set
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_FXLS8962AF_SPI=y
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=y
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=y
CONFIG_SCA3300=y
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
# CONFIG_AD7124 is not set
CONFIG_AD7192=y
# CONFIG_AD7266 is not set
# CONFIG_AD7280 is not set
CONFIG_AD7291=y
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=y
CONFIG_AD7768_1=y
CONFIG_AD7780=y
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
CONFIG_AD7949=y
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_DLN2_ADC is not set
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
CONFIG_LTC2497=y
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=y
# CONFIG_MAX1241 is not set
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=y
# CONFIG_MEDIATEK_MT6360_ADC is not set
CONFIG_MEN_Z188_ADC=y
CONFIG_MP2629_ADC=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_VADC_COMMON=y
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STX104=y
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=y
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_ADS8344=y
CONFIG_TI_ADS8688=y
CONFIG_TI_ADS124S08=y
CONFIG_TI_ADS131E08=y
CONFIG_TI_AM335X_ADC=y
# CONFIG_TI_TLC4541 is not set
# CONFIG_TI_TSC2046 is not set
CONFIG_VF610_ADC=y
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74413R=y
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_ADA4250 is not set
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_SCD30_CORE is not set
CONFIG_SCD4X=y
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SENSEAIR_SUNRISE_CO2=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD3552R=y
CONFIG_AD5064=y
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
CONFIG_AD5446=y
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
CONFIG_LTC2688=y
CONFIG_AD5686=y
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
# CONFIG_AD5764 is not set
CONFIG_AD5766=y
CONFIG_AD5770R=y
CONFIG_AD5791=y
CONFIG_AD7293=y
CONFIG_AD7303=y
CONFIG_AD8801=y
# CONFIG_CIO_DAC is not set
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_LTC1660=y
CONFIG_LTC2632=y
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Filters
#
CONFIG_ADMV8818=y
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
# CONFIG_ADF4371 is not set
CONFIG_ADMV1013=y
# CONFIG_ADMV1014 is not set
# CONFIG_ADMV4420 is not set
CONFIG_ADRF6780=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
# CONFIG_ADXRS290 is not set
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BMI160_SPI is not set
CONFIG_FXOS8700=y
# CONFIG_FXOS8700_I2C is not set
CONFIG_FXOS8700_SPI=y
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
CONFIG_AL3010=y
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=y
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2591=y
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=y
# CONFIG_MAG3110 is not set
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
# CONFIG_IIO_ST_MAGN_I2C_3AXIS is not set
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_SENSORS_RM3100_SPI is not set
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
CONFIG_MAX5481=y
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_MCP41010=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_DLHL60D=y
CONFIG_DPS310=y
# CONFIG_HID_SENSOR_PRESS is not set
CONFIG_HP03=y
# CONFIG_ICP10100 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5611_SPI=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
# CONFIG_IIO_ST_PRESS_SPI is not set
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=y
# CONFIG_SX9310 is not set
CONFIG_SX9324=y
# CONFIG_SX9360 is not set
CONFIG_SX9500=y
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_HID_SENSOR_TEMP=y
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TMP117=y
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
CONFIG_MAX31856=y
# CONFIG_MAX31865 is not set
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CRC is not set
CONFIG_PWM_DWC=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_QCOM_USB_HS=y
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_TUSB1210=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=y
CONFIG_BTT=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_ADGS1408 is not set
# CONFIG_MUX_GPIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
# CONFIG_INTERRUPT_CNT is not set
CONFIG_INTEL_QEP=y
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
# CONFIG_MOST_CDEV is not set
CONFIG_MOST_SND=y
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
CONFIG_F2FS_FS_LZ4=y
# CONFIG_F2FS_FS_LZ4HC is not set
# CONFIG_F2FS_FS_ZSTD is not set
# CONFIG_F2FS_IOSTAT is not set
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_SM3_AVX_X86_64=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_NITROX=y
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_FRAME_POINTER=y
CONFIG_OBJTOOL=y
CONFIG_STACK_VALIDATION=y
CONFIG_NOINSTR_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
CONFIG_NET_NS_REFCNT_TRACKER=y
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
# CONFIG_KASAN_STACK is not set
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_EFI_PGT_DUMP=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-next/master'
	export commit='b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4'
	export kconfig='x86_64-randconfig-a014-20220926'
	export nr_vm=300
	export submit_id='6333f5c30dfd5d03efbcb0a7'
	export job_file='/lkp/jobs/scheduled/vm-meta-311/boot-1-quantal-x86_64-core-20190426.cgz-b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4-20220928-66543-1ccqwt2-0.yaml'
	export id='cd859c2bae40742b8c81006be9ddf0e5a3e72696'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='quantal-x86_64-core-20190426.cgz'
	export compiler='clang-14'
	export enqueue_time='2022-09-28 15:20:35 +0800'
	export _id='6333f5c30dfd5d03efbcb0a7'
	export _rt='/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-randconfig-a014-20220926/clang-14/b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-randconfig-a014-20220926/clang-14/b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4/8'
	export scheduler_version='/lkp/lkp/.src-20220922-085543'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/quantal/quantal-x86_64-core-20190426.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-randconfig-a014-20220926/clang-14/b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4/8
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a014-20220926/clang-14/b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4/vmlinuz-6.0.0-rc4-00018-gb9a7ecc71fe5
branch=linux-next/master
job=/lkp/jobs/scheduled/vm-meta-311/boot-1-quantal-x86_64-core-20190426.cgz-b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4-20220928-66543-1ccqwt2-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a014-20220926
commit=b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-a014-20220926/clang-14/b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-311'
	export kernel='/pkg/linux/x86_64-randconfig-a014-20220926/clang-14/b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4/vmlinuz-6.0.0-rc4-00018-gb9a7ecc71fe5'
	export dequeue_time='2022-09-28 15:57:31 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-311/boot-1-quantal-x86_64-core-20190426.cgz-b9a7ecc71fe582eaf67dcbf1f45fb30cd05510a4-20220928-66543-1ccqwt2-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"



----- End forwarded message -----

--0D1p3/gTzmblZ+Pf
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
F9exxGf7AgAAAAAEWVo=

--0D1p3/gTzmblZ+Pf--
