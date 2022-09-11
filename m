Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7057A5B4C9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIKIfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIKIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:35:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E331303F8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:35:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a259e8c000000b006958480b858so5146943ybq.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=YbtCFZvILXpJC+a2fdohEwEfZPgdvsYvrLOiWC4FHmU=;
        b=VR7VeyMXlcZH0eIG2slwMf0Avl0QqmZ584jICzhQKSzU/7NMm+PbJkUcbdepWXQr/S
         6nUUBz/fNLBk5+WG1cKXVERR2VF96XEyBO99p2hk3IZ9WhPLcqOZ6jPMDvaxCammepA7
         QhbUnmh9Yfj4gPEgmJZAuGcUeoi0vKqpfNYzhaIyY7/GyttjK13Ns9fsjZwgYQJREeiw
         azxOTeFd6y0wkTKF0eUWIRGNHWvlvJ0jGWncuDH/V3fi9jlU81x+s5nZQIGLVo/k2Nc/
         1MCYRhH2TlBG7mJpwa4RTypq+EZpqYGdlWs7nqyc1imZ9/iHVpjkzbGCvwiRwW77BlFn
         Q0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=YbtCFZvILXpJC+a2fdohEwEfZPgdvsYvrLOiWC4FHmU=;
        b=zxKofpxV8wNRjm8b/Ly6HYYDtSHU/DbB84s23W4VxSjy3kyS1ZXbwawgR6fCtNz5+V
         mtx0z05wDaz2OQcMAuEMRhAPPoapXANfzTNHK0RhTJnyKRxH0O0mbi8bm2fwueOE+po2
         999zx/MnahnSV9Zg0wdIKVjMro9kRUVU/3DtiyeOO7MwnZ14C1sgWbWoNeht1VRylVpc
         iH+QK3Aje/Z5Iq3hX8e0ZU2ps1JyjE5H6aVu36VhqILLjZBjjz4iIYo3x5rCnqNFlCWT
         /YIrO+HR2sjzHmVSide7G4BEs9fNXaqjDAJgVhr5dxRqIZipIzEuJBihiaETnNYXaDcs
         9YQA==
X-Gm-Message-State: ACgBeo32w2vneTRUFoaRYZdeprCHY+TLSYHZo9OGseRhN8vtvbseel8L
        19HzGySL9wfyS1+5fV+UqqVjaqmXLpRf
X-Google-Smtp-Source: AA6agR7fFiGV7ORO5loPzZn8xBcfu1/VrYN+FRNC79M2U4ZQJuiDnvJNiUt4h+qem/NB9lNHcwzyAtCQz3pA
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2d4:203:5076:f273:1383:891d])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:725:b0:6ae:4951:cc24 with SMTP id
 l5-20020a056902072500b006ae4951cc24mr13154999ybt.50.1662885326656; Sun, 11
 Sep 2022 01:35:26 -0700 (PDT)
Date:   Sun, 11 Sep 2022 01:34:16 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220911083418.2818369-1-yuanchu@google.com>
Subject: [RFC PATCH 0/2] mm: multi-gen LRU: per-process heatmaps
From:   Yuanchu Xie <yuanchu@google.com>
To:     linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Cc:     Michael Larabel <Michael@MichaelLarabel.com>,
        Jon Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuanchu Xie <yuanchu@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, the MGLRU debugfs interface (/sys/kernel/debug/lru_gen) provides
a histogram counting the number of pages belonging to each generation,
providing some data for memory coldness, but we don't actually know
where the memory actually is. However, since MGLRU revamps the page
reclaim mechanism to walk page tables, we can hook into MGLRU page table
access bit harvesting with a BPF program to collect information on
relative hotness and coldness, NUMA nodes, whether a page is anon/file,
etc.

Using BPF programs to collect and aggregate page access information
allows for the userspace agent to customize what to collect and how to
aggregate. It could focus on a particular region of interest and count a
moving average access frequency, or find allocations that are never
accessed that could be eliminated all together. Currently MGLRU relies
on heuristics with regards to what generation a page is assigned, for
example, pages accessed through page tables are always assigned to the
youngest generation. Exposing page access data can allow future work to
customize page generation assignments (with more BPF).

We demonstrate feasibility with a proof-of-concept that prints a live
heatmap of a process, with configurable MGLRU aging intervals and
aggregation intervals. This is a very rough PoC that still needs a lot
of work, but it shows a lot can be done by exposing page access
information from MGLRU. I will be presenting this work at the coming
LPC.

As an example. I ran the memtier benchmark[1] and captured a heatmap of
memcached being populated and running the benchmark (similar to the one
Yu posted for OpenWRT[2]):

$ cat ./run_memtier_benchmark.sh
    run_memtier_benchmark()
    {
        # populate dataset
        memtier_benchmark/memtier_benchmark -s 127.0.0.1 -p 11211 \
            -P memcache_binary -n allkeys -t 1 -c 1 --ratio 1:0 --pipeline 8 \
            --key-minimum=1 --key-maximum=$2 --key-pattern=P:P \
            -d 1000

        # access dataset using Guassian pattern
        memtier_benchmark/memtier_benchmark -s 127.0.0.1 -p 11211 \
            -P memcache_binary --test-time $1 -t 1 -c 1 --ratio 0:1 \
            --pipeline 8 --key-minimum=1 --key-maximum=$2 \
            --key-pattern=G:G --randomize --distinct-client-seed

        # collect results
    }

    run_duration_secs=3600
    max_key=8000000

    run_memtier_benchmark $run_duration_secs $max_key

In the following screenshot we can see the process of populating the
dataset and accessing the dataset:
https://services.google.com/fh/files/events/memcached_memtier_startup.png

Patch 1 adds the infrastructure to enable BPF programs to monitor page
access bit harvesting

Patch 2 includes a proof-of-concept python TUI program displaying online
per-process heatmaps.

[1] https://github.com/RedisLabs/memtier_benchmark
[2] https://lore.kernel.org/all/20220831041731.3836322-1-yuzhao@google.com/

Yuanchu Xie (2):
  mm: multi-gen LRU: support page access info harvesting with eBPF
  mm: add a BPF-based per-process heatmap tool

 include/linux/mmzone.h          |   1 +
 mm/vmscan.c                     | 154 ++++++++
 tools/vm/heatmap/Makefile       |  30 ++
 tools/vm/heatmap/heatmap.bpf.c  | 123 +++++++
 tools/vm/heatmap/heatmap.user.c | 188 ++++++++++
 tools/vm/heatmap/heatmap_tui.py | 600 ++++++++++++++++++++++++++++++++
 6 files changed, 1096 insertions(+)
 create mode 100644 tools/vm/heatmap/Makefile
 create mode 100644 tools/vm/heatmap/heatmap.bpf.c
 create mode 100644 tools/vm/heatmap/heatmap.user.c
 create mode 100755 tools/vm/heatmap/heatmap_tui.py

-- 
2.37.2.789.g6183377224-goog

