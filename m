Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A265F686
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjAEWM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjAEWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0E5C93B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:11:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3746961C9A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 22:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D4C433D2;
        Thu,  5 Jan 2023 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672956672;
        bh=redQC2w+sdVL4qAUPGunaamvsqLS1mVAo6Z+Uu9kFhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6fReCGEHn/asDsMJd+J8VnfDj+kAXqHN/tMg90YeS7UWLccoMBBXWuA/vD+QsN5G
         qCdBzUheHNsdur189fxTPFW27xSJxPDEkUT8G2qifUZxdLCTQ4zQyxx4fdwmlnCBQB
         nykDKU31K+Wm+yP4+OHBAVq76AXYibyizWISNUZaKQa0f5p8fIG756AhVZm2XKlhdn
         zZ7A0IxTVe2KygM8P+YWcYmZjS2te/yzVQuuHvFZShxhO9J7GIXwvJwRGBBLQIx+89
         nxNAi5hACEoR0A9MVQMkKKb5HPXT6ApjPFH3oAM+W0Ru9ziXn+TAdQzOWvve2ME+DE
         R3pHg5GIEUtyQ==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        Jonathan.Cameron@Huawei.com, amit@kernel.org,
        benh@kernel.crashing.org, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, foersleo@amazon.de,
        gthelen@google.com, markubo@amazon.de, rientjes@google.com,
        shakeelb@google.com, baolin.wang@linux.alibaba.com,
        guoqing.jiang@linux.dev, xhao@linux.alibaba.com, hanyihao@vivo.com,
        changbin.du@gmail.com, kuba@kernel.org,
        rongwei.wang@linux.alibaba.com, rikard.falkeborn@gmail.com,
        geert@linux-m68k.org, kilobyte@angband.pl, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev
Subject: Re: [RFC PLAN] Some humble ideas for DAMON future works
Date:   Thu,  5 Jan 2023 22:11:09 +0000
Message-Id: <20230105221109.53398-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119133110.24901-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On Wed, 19 Jan 2022 13:31:10 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> After the DAMON code is merged (kudos to the community for the great helps), a
> few people asked me about my plan for DAMON future works, and if DAMON will be
> somewhat usable for their use cases.  I indeed have some humble plans, though
> those are only in rough brainsorming level at the moment. so I'd like to share
> those here before going forward and start coding, so that I can get some
> feedback to fail fast.

After sharing the summary of 2022 DAMON developments[1], I started thinking the
DAMON development plans for 2023.  While doing that, I just remembered this
DAMON future plans mail that I wrote at the beginning of 2022.  Checking the
status of DAMON development based on the long term plan could be helpful for
setting 2023 plan, so I'm gonna do it.

> 
> User-space Policy or In-kernel Policy?  Both.
> =============================================
> 
[...]
> I'd like to help both.  For the reason, I made DAMON as an in-kernel mechanism
> for both user and kernel-space policies.  It provides highly tunable general
> user space interface to help the first party.  It also provides in-kernel
> policies which built on top of DAMON using its kernel-space API for specific
> common use cases with conservative default parameters that assumed to incur no
> regression but some extent of benefits in most cases, namely DAMON-based
> proactive reclamation.  I will continue pursuing the two ways.

In 2023, we made some more user-space policies friendly knobs via DAMON sysfs
interface, but also made some in-kernel policies including DAMON_LRU_SORT.  We
may continue developing DAMON for two kind of policies.

> 
> Imaginable DAMON-based Policies
> ===============================
> 
[...]
> 
> DAMON-based Proactive LRU-pages (de)Activation
> ----------------------------------------------
> 
> My idea for helping this situation is manipulating the orders of pages in LRU
> lists using DAMON-provided monitoring results.  That is, making DAMON
> proactively finds hot/cold memory regions and moves pages of the hot regions to
> the head of the active list, while moving pages of the cold regions to the tail
> of the inactive list.  This will help eventual reclamation under memory
> pressure to evict cold pages first, so incur less additional page faults.

We did make this[1].  On our test, it reduced 20% of memory pressure stall.  It
may have some more rooms of improvements, though.

[1] https://lwn.net/Articles/905370/

[...]
> 
> DAMON-based THP Coalesce/Split
> ------------------------------
> 
> THP is know to significantly improve performance, but also increase memory
> footprint[1].  We can minimize the memory overhead while preserving the
> performance benefit by asking DAMON to provide MADV_HUGEPAGE-like hints for hot
> memory regions of >= 2MiB size, and MADV_NOHUGEPAGE-like hints for cold memory
> regions.  Our experimental user space policy implementation[2] of this idea
> removes 76.15% of THP memory waste while preserving 51.25% of THP speedup in
> total.
> 
> [1] https://www.usenix.org/conference/osdi16/technical-sessions/presentation/kwon
> [2] https://damonitor.github.io/doc/html/v34/vm/damon/eval.html

We didn't make this in 2022, mainly due to lack of time.  This would still be
in the TODO list.

> 
> DAMON-based Tiered Memory (Pro|De)motion
> ----------------------------------------
> 
> In tiered memory systems utilizing DRAM and PMEM[1], we can promote hot pages to
> DRAM and demote cold pages to PMEM using DAMON.  A patch for allowing
> access-aware demotion user space policy development is already submitted[2] by
> Baolin.
> 
> [1] https://www.intel.com/content/www/us/en/products/details/memory-storage/optane-memory.html
> [2] https://lore.kernel.org/linux-mm/cover.1640171137.git.baolin.wang@linux.alibaba.com/

We didn't make this in 2022, mainly due to lack of time.  This would still be
in the TODO list.

> 
> DAMON-based Proactive Compaction
> --------------------------------
> 
> Compaction uses migration scanner to find migration source pages.  Hot pages
> would be more likely to be unmovable compared to cold pages, so it would be
> better to try migration of cold pages first.  DAMON could be used here.  That
> is, proactively monitoring accesses via DAMON and start compaction so that the
> migration scanner scan cold memory ranges first.  I should admit I'm not
> familiar with compaction code and I have no PoC data for this but just the
> groundless idea, though.

We didn't make this in 2022, mainly due to lack of time.  This would still be
in the TODO list.

[...]
> 
> How DAMON Should Be Evolved For Supporting Those
> ================================================
> 
> Let's discuss what kind of changes in DAMON will be needed to efficiently
> support above mentioned policies.
> 
> Simultaneously Monitoring Different Types of Address Spaces
> -----------------------------------------------------------
> 
> It would be better to run all the above mentioned policies simultaneously on
> single system.  As some policies such as LRU-pages (de)activation would better
> to run on physical address space while some policies such as THP coalesce/split
> would need to run on virtual address spaces, DAMON should support concurrently
> monitoring different address spaces.  We can always do this by creating one
> DAMON context for each address space and running those.  However, as the
> address spaces will conflict, each other will be interfered.  Current idea for
> avoiding this is allowing multiple DAMON contexts to run on a single thread,
> forcing them to have same monitoring contexts.

We didn't make this in 2022, mainly due to lack of time.  This would still be
in the TODO list.

> 
> Online Parameters Updates
> -------------------------
> 
> Someone would also want to dynamically turn on/off and/or tune each policy.
> This is impossible with current DAMON, because it prohibits updating any
> parameter while it is running.  We disallow the online parameters update
> mainly because we want to avoid doing additional synchronization between the
> running kdamond and the parameters updater.  The idea for supporting the use
> case while avoiding the additional synchronization is, allowing users to pause
> DAMON and update parameters while it is paused.

We did make this in 2022.  DAMON sysfs interface, DAMON_RECLAIM, and
DAMON_LRU_SORT support online tuning.

> 
> A Better DAMON interface
> ------------------------
> 
> DAMON is currently exposing its major functionality to the user space via the
> debugfs.  After all, DAMON is not for only debugging.  Also, this makes the
> interface depends on debugfs unnecessarily, and considered unreliable.  Also,
> the interface is quite unflexible for future interface extension.  I admit it
> was not a good choice.
> 
> It would be better to implement another reliable and easily extensible
> interface, and deprecate the debugfs interface.  The idea is exposing the
> interface via sysfs using hierarchical Kobjects under mm_kobject.  For example,
> the usage would be something like below:
> 
>     # cd /sys/kernel/mm/damon
>     # echo 1 > nr_kdamonds
>     # echo 1 > kdamond_1/contexts/nr_contexts
>     # echo va > kdamond_1/contexts/context_1/target_type
>     # echo 1 > kdamond_1/contexts/context_1/targets/nr_targets
>     # echo $(pidof <workload>) > \
>                     kdamond_1/contexts/context_1/targets/target_1/pid
>     # echo Y > monitor_on

We did make this in 2022.  It makes extension of DAMON features easy.

> 
> More DAMON Future Works
> =======================
> 
> In addition to above mentioned things, there are many works to do.  It would be
> better to extend DAMON for more use cases and address spaces support, including
> page granularity, idleness only, read/write only, page cache only, and cgroups
> monitoring supports.

We didn't make this in 2022, mainly due to lack of time.  This would still be
in the TODO list.

Nevertheless, DAMOS filters feature could be used for effective support of
cgroups-based access-aware memory management.

One interesting idea for cgroups and page granularity monitoring, which I
shared during Kernel Summit'22 is using LRU-lists as a source of access
information.  Need more time for designing, though.

> 
> Also it would be valuable to improve the accuracy of monitoring, using some
> adaptive monitoring attributes tuning or some new fancy idea[1].

We didn't make this in 2022, mainly due to lack of time.  This would still be
in the TODO list.

> 
> DAMOS could also be improved by utilizing its own autotuning feature, for
> example, by monitoring PSI and other metrics related to the given action.

Transparent Memory Offloading, which was presented at ASPLOS'22 just after this
posting, made me sure again the importance of adaptive auto tuning.

We didn't make this in 2022, mainly due to lack of time.  This would still be
in the TODO list.  I'm personally trying to make this a prioritized task of
2023.

So, some of the TODO tasks are done, and still we have many more interesting
ideas to implement.  There will be some more new tasks, too.  I'm gonna think
about it more and may share some revised future plans soon.  If you want to
get the early version of the plan, or discuss and participate in the future
planning, please feel free to post question or inputs via mailing list
(damon@lists.linux.dev) or DAMON Beer/Coffee/Tea Chat series[1].  DAMON is
planned, prioritized and developed by the community's real needs.

[1] https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/


Thanks,
SJ

[...]
