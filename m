Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B845BDEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiITHpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiITHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:44:57 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00250B03;
        Tue, 20 Sep 2022 00:43:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so1744115pgb.4;
        Tue, 20 Sep 2022 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DwntjDTT7S/B25WE5xhW03LkQ0xXMkMae0WsFOXBjUc=;
        b=Acn8RHGW/HBEwBLLfeZtVCSHzJAn3dBek5VoJq8YsndMvterRrvzlGiVef6xgf9H6+
         Qn0hqog0/gtNTvGWZimD1DqrQQEqaOa5+GbFKucs9TBn7DGrNlWH/h1LYR1E2H4AKk/n
         5Urk7BcTcAdpdRi15YSkqrGdddDHH0KMSsaIIh09RKGvM9J2i9tpQEjTNvwgaOrv9KFP
         YttD62Cb3T+6IY/Twol5s3N+RMjVyAC1wVyQK1+ZK/p9MyofAFZGEHCAGWzE/0+EaH5B
         GJlMWf8AckOxaNqTXs5dOA7w6c4vMCedQjiwuac1EYE7G6xwwc6ep5qVmRwY7pjDNyyG
         Un/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DwntjDTT7S/B25WE5xhW03LkQ0xXMkMae0WsFOXBjUc=;
        b=0MqBtLkA8doYX26898H43Zhdpuvywd4hApQctn7+rhvpfNz66O6fZ678XgJcrdiHxP
         FxGW3ywKtijkLg/TOfqhO7LDAxlLtBtGVZND2A6o65sMbzZvGrDT8hlw8qkUOki5/uBj
         eObp4ZKEHiI1DK+eIu8jTm+bzsYOokx9xMRftsqdW1iV6InnNEGfyhpi4bpF02XpDBmS
         po8ayQxOxhlskU0YKIH5aJM0s5HTo7yUJOrlL/GOjsXmFJ7f9M9i5iAHGEYyucD87Qi6
         mALTM9gLO4wutBM/geCUlKnKOWLHiqlJlKqnaaofp4gUj7AM8TvXiDWDrd7meFRa574B
         4guQ==
X-Gm-Message-State: ACrzQf0Wt+dhQbCxwW6VH4QKrnK+Rn+Rvfejw9DkmmK9XQMWv4OsaEC+
        kbmUj/JK9kIHCMzMYYsbtPI=
X-Google-Smtp-Source: AMsMyM6dS2wE2gNsl5YqarTVAl8ZxUux0JKxNbd4jvFgCcRHpcqgG48pleb5TeBWJjUL3wDwzI3h3Q==
X-Received: by 2002:a05:6a00:a95:b0:547:b3e0:b1c0 with SMTP id b21-20020a056a000a9500b00547b3e0b1c0mr22470409pfl.53.1663659829184;
        Tue, 20 Sep 2022 00:43:49 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id z14-20020aa79e4e000000b005375a574846sm831306pfq.125.2022.09.20.00.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 00:43:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4851C101278; Tue, 20 Sep 2022 14:43:45 +0700 (WIB)
Date:   Tue, 20 Sep 2022 14:43:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 13/14] mm: multi-gen LRU: admin guide
Message-ID: <YylvMMfGNh6yfb9D@debian.me>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-14-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220815071332.627393-14-yuzhao@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 01:13:32AM -0600, Yu Zhao wrote:
> +=============
> +Multi-Gen LRU
> +=============
> +The multi-gen LRU is an alternative LRU implementation that optimizes
> +page reclaim and improves performance under memory pressure. Page
> +reclaim decides the kernel's caching policy and ability to overcommit
> +memory. It directly impacts the kswapd CPU usage and RAM efficiency.
> +
> +Quick start
> +===========
> +Build the kernel with the following configurations.
> +
> +* ``CONFIG_LRU_GEN=y``
> +* ``CONFIG_LRU_GEN_ENABLED=y``
> +
> +All set!
> +
> +Runtime options
> +===============
> +``/sys/kernel/mm/lru_gen/`` contains stable ABIs described in the
> +following subsections.
> +
> +Kill switch
> +-----------
> +``enabled`` accepts different values to enable or disable the
> +following components. Its default value depends on
> +``CONFIG_LRU_GEN_ENABLED``. All the components should be enabled
> +unless some of them have unforeseen side effects. Writing to
> +``enabled`` has no effect when a component is not supported by the
> +hardware, and valid values will be accepted even when the main switch
> +is off.
> +
> +====== ===============================================================
> +Values Components
> +====== ===============================================================
> +0x0001 The main switch for the multi-gen LRU.
> +0x0002 Clearing the accessed bit in leaf page table entries in large
> +       batches, when MMU sets it (e.g., on x86). This behavior can
> +       theoretically worsen lock contention (mmap_lock). If it is
> +       disabled, the multi-gen LRU will suffer a minor performance
> +       degradation for workloads that contiguously map hot pages,
> +       whose accessed bits can be otherwise cleared by fewer larger
> +       batches.
> +0x0004 Clearing the accessed bit in non-leaf page table entries as
> +       well, when MMU sets it (e.g., on x86). This behavior was not
> +       verified on x86 varieties other than Intel and AMD. If it is
> +       disabled, the multi-gen LRU will suffer a negligible
> +       performance degradation.
> +[yYnN] Apply to all the components above.
> +====== ===============================================================
> +
> +E.g.,
> +::
> +
> +    echo y >/sys/kernel/mm/lru_gen/enabled
> +    cat /sys/kernel/mm/lru_gen/enabled
> +    0x0007
> +    echo 5 >/sys/kernel/mm/lru_gen/enabled
> +    cat /sys/kernel/mm/lru_gen/enabled
> +    0x0005
> +
> +Thrashing prevention
> +--------------------
> +Personal computers are more sensitive to thrashing because it can
> +cause janks (lags when rendering UI) and negatively impact user
> +experience. The multi-gen LRU offers thrashing prevention to the
> +majority of laptop and desktop users who do not have ``oomd``.
> +
> +Users can write ``N`` to ``min_ttl_ms`` to prevent the working set of
> +``N`` milliseconds from getting evicted. The OOM killer is triggered
> +if this working set cannot be kept in memory. In other words, this
> +option works as an adjustable pressure relief valve, and when open, it
> +terminates applications that are hopefully not being used.
> +
> +Based on the average human detectable lag (~100ms), ``N=1000`` usually
> +eliminates intolerable janks due to thrashing. Larger values like
> +``N=3000`` make janks less noticeable at the risk of premature OOM
> +kills.
> +
> +The default value ``0`` means disabled.
> +
> +Experimental features
> +=====================
> +``/sys/kernel/debug/lru_gen`` accepts commands described in the
> +following subsections. Multiple command lines are supported, so does
> +concatenation with delimiters ``,`` and ``;``.
> +
> +``/sys/kernel/debug/lru_gen_full`` provides additional stats for
> +debugging. ``CONFIG_LRU_GEN_STATS=y`` keeps historical stats from
> +evicted generations in this file.
> +
> +Working set estimation
> +----------------------
> +Working set estimation measures how much memory an application needs
> +in a given time interval, and it is usually done with little impact on
> +the performance of the application. E.g., data centers want to
> +optimize job scheduling (bin packing) to improve memory utilizations.
> +When a new job comes in, the job scheduler needs to find out whether
> +each server it manages can allocate a certain amount of memory for
> +this new job before it can pick a candidate. To do so, the job
> +scheduler needs to estimate the working sets of the existing jobs.
> +
> +When it is read, ``lru_gen`` returns a histogram of numbers of pages
> +accessed over different time intervals for each memcg and node.
> +``MAX_NR_GENS`` decides the number of bins for each histogram. The
> +histograms are noncumulative.
> +::
> +
> +    memcg  memcg_id  memcg_path
> +       node  node_id
> +           min_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
> +           ...
> +           max_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
> +
> +Each bin contains an estimated number of pages that have been accessed
> +within ``age_in_ms``. E.g., ``min_gen_nr`` contains the coldest pages
> +and ``max_gen_nr`` contains the hottest pages, since ``age_in_ms`` of
> +the former is the largest and that of the latter is the smallest.
> +
> +Users can write ``+ memcg_id node_id max_gen_nr
> +[can_swap [force_scan]]`` to ``lru_gen`` to create a new generation
> +``max_gen_nr+1``. ``can_swap`` defaults to the swap setting and, if it
> +is set to ``1``, it forces the scan of anon pages when swap is off,
> +and vice versa. ``force_scan`` defaults to ``1`` and, if it is set to
> +``0``, it employs heuristics to reduce the overhead, which is likely
> +to reduce the coverage as well.
> +
> +A typical use case is that a job scheduler writes to ``lru_gen`` at a
> +certain time interval to create new generations, and it ranks the
> +servers it manages based on the sizes of their cold pages defined by
> +this time interval.
> +
> +Proactive reclaim
> +-----------------
> +Proactive reclaim induces page reclaim when there is no memory
> +pressure. It usually targets cold pages only. E.g., when a new job
> +comes in, the job scheduler wants to proactively reclaim cold pages on
> +the server it selected to improve the chance of successfully landing
> +this new job.
> +
> +Users can write ``- memcg_id node_id min_gen_nr [swappiness
> +[nr_to_reclaim]]`` to ``lru_gen`` to evict generations less than or
> +equal to ``min_gen_nr``. Note that ``min_gen_nr`` should be less than
> +``max_gen_nr-1`` as ``max_gen_nr`` and ``max_gen_nr-1`` are not fully
> +aged and therefore cannot be evicted. ``swappiness`` overrides the
> +default value in ``/proc/sys/vm/swappiness``. ``nr_to_reclaim`` limits
> +the number of pages to evict.
> +
> +A typical use case is that a job scheduler writes to ``lru_gen``
> +before it tries to land a new job on a server. If it fails to
> +materialize enough cold pages because of the overestimation, it
> +retries on the next server according to the ranking result obtained
> +from the working set estimation step. This less forceful approach
> +limits the impacts on the existing jobs.

The documentation can be improved, like:

---- >8 ----
diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/admin-guide/mm/multigen_lru.rst
index 33e068830497e7..16d5c3317447f2 100644
--- a/Documentation/admin-guide/mm/multigen_lru.rst
+++ b/Documentation/admin-guide/mm/multigen_lru.rst
@@ -10,13 +10,11 @@ memory. It directly impacts the kswapd CPU usage and RAM efficiency.
 
 Quick start
 ===========
-Build the kernel with the following configurations.
+Build the kernel with the following configurations:
 
 * ``CONFIG_LRU_GEN=y``
 * ``CONFIG_LRU_GEN_ENABLED=y``
 
-All set!
-
 Runtime options
 ===============
 ``/sys/kernel/mm/lru_gen/`` contains stable ABIs described in the
@@ -51,8 +49,7 @@ Values Components
 [yYnN] Apply to all the components above.
 ====== ===============================================================
 
-E.g.,
-::
+Below is the example of enabling multi-gen LRU::
 
     echo y >/sys/kernel/mm/lru_gen/enabled
     cat /sys/kernel/mm/lru_gen/enabled
@@ -65,21 +62,21 @@ Thrashing prevention
 --------------------
 Personal computers are more sensitive to thrashing because it can
 cause janks (lags when rendering UI) and negatively impact user
-experience. The multi-gen LRU offers thrashing prevention to the
+experience. The multi-gen LRU offers thrashing prevention for the
 majority of laptop and desktop users who do not have ``oomd``.
 
 Users can write ``N`` to ``min_ttl_ms`` to prevent the working set of
 ``N`` milliseconds from getting evicted. The OOM killer is triggered
 if this working set cannot be kept in memory. In other words, this
-option works as an adjustable pressure relief valve, and when open, it
-terminates applications that are hopefully not being used.
+option works as an adjustable pressure relief valve; and when it is open,
+it terminates applications that are hopefully not being used.
 
 Based on the average human detectable lag (~100ms), ``N=1000`` usually
 eliminates intolerable janks due to thrashing. Larger values like
 ``N=3000`` make janks less noticeable at the risk of premature OOM
 kills.
 
-The default value ``0`` means disabled.
+The default value is ``0`` which means disabled.
 
 Experimental features
 =====================
@@ -88,14 +85,14 @@ following subsections. Multiple command lines are supported, so does
 concatenation with delimiters ``,`` and ``;``.
 
 ``/sys/kernel/debug/lru_gen_full`` provides additional stats for
-debugging. ``CONFIG_LRU_GEN_STATS=y`` keeps historical stats from
-evicted generations in this file.
+debugging. When ``CONFIG_LRU_GEN_STATS=y`` is configured, the kernel keeps
+historical stats from evicted generations in this file.
 
 Working set estimation
 ----------------------
 Working set estimation measures how much memory an application needs
 in a given time interval, and it is usually done with little impact on
-the performance of the application. E.g., data centers want to
+the performance of the application. For example, data centers want to
 optimize job scheduling (bin packing) to improve memory utilizations.
 When a new job comes in, the job scheduler needs to find out whether
 each server it manages can allocate a certain amount of memory for
@@ -115,19 +112,19 @@ histograms are noncumulative.
            max_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
 
 Each bin contains an estimated number of pages that have been accessed
-within ``age_in_ms``. E.g., ``min_gen_nr`` contains the coldest pages
+within ``age_in_ms``. Here, ``min_gen_nr`` contains the coldest pages
 and ``max_gen_nr`` contains the hottest pages, since ``age_in_ms`` of
 the former is the largest and that of the latter is the smallest.
 
 Users can write the following command to ``lru_gen`` to create a new
-generation ``max_gen_nr+1``:
+generation ``max_gen_nr+1``::
 
-    ``+ memcg_id node_id max_gen_nr [can_swap [force_scan]]``
+    memcg_id node_id max_gen_nr [can_swap [force_scan]]
 
-``can_swap`` defaults to the swap setting and, if it is set to ``1``,
-it forces the scan of anon pages when swap is off, and vice versa.
-``force_scan`` defaults to ``1`` and, if it is set to ``0``, it
-employs heuristics to reduce the overhead, which is likely to reduce
+``can_swap`` defaults to the swap setting. If it is set to ``1``,
+it forces the scan of anon pages when swap is off and vice versa.
+``force_scan`` defaults to ``1``. If it is set to ``0``, it
+uses heuristics to reduce the overhead, which is likely to reduce
 the coverage as well.
 
 A typical use case is that a job scheduler runs this command at a
@@ -138,15 +135,15 @@ this time interval.
 Proactive reclaim
 -----------------
 Proactive reclaim induces page reclaim when there is no memory
-pressure. It usually targets cold pages only. E.g., when a new job
+pressure. It usually targets cold pages only. For example, when a new job
 comes in, the job scheduler wants to proactively reclaim cold pages on
 the server it selected, to improve the chance of successfully landing
 this new job.
 
 Users can write the following command to ``lru_gen`` to evict
-generations less than or equal to ``min_gen_nr``.
+generations less than or equal to ``min_gen_nr``::
 
-    ``- memcg_id node_id min_gen_nr [swappiness [nr_to_reclaim]]``
+    memcg_id node_id min_gen_nr [swappiness [nr_to_reclaim]]
 
 ``min_gen_nr`` should be less than ``max_gen_nr-1``, since
 ``max_gen_nr`` and ``max_gen_nr-1`` are not fully aged (equivalent to
@@ -155,7 +152,7 @@ overrides the default value in ``/proc/sys/vm/swappiness``.
 ``nr_to_reclaim`` limits the number of pages to evict.
 
 A typical use case is that a job scheduler runs this command before it
-tries to land a new job on a server. If it fails to materialize enough
+tries to land a new job on a server. If it fails to get enough
 cold pages because of the overestimation, it retries on the next
 server according to the ranking result obtained from the working set
 estimation step. This less forceful approach limits the impacts on the

 
> +/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
>  static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *attr,
>  			     const char *buf, size_t len)
>  {
> @@ -5321,6 +5322,7 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
>  	return snprintf(buf, PAGE_SIZE, "0x%04x\n", caps);
>  }
>  
> +/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
>  static ssize_t store_enabled(struct kobject *kobj, struct kobj_attribute *attr,
>  			     const char *buf, size_t len)
>  {
> @@ -5468,6 +5470,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
>  	seq_putc(m, '\n');
>  }
>  
> +/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
>  static int lru_gen_seq_show(struct seq_file *m, void *v)
>  {
>  	unsigned long seq;
> @@ -5626,6 +5629,7 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
>  	return err;
>  }
>  
> +/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
>  static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
>  				 size_t len, loff_t *pos)
>  {

Shouldn't these functions be described by writing kernel-doc comments?
I don't see any mentions of these in multigen_lru.rst.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
