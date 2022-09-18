Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E5E5BBC73
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIRIDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIRIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:01:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834C2656D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-348608c1cd3so230586327b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=U43YKqHWj215EGLcMoze5D0BcuNypR2wHlQCyfq09BE=;
        b=Zi5tEMzGHXn0KcfY9hanumq4akKyayUThAqzjRPK2vLh7ajqle01c8rsAka8I4RF/P
         hGb5psS8mPFQCuBNoQRJkDYjsHKrTRmts0DvNvsw5QwaYnZ1tuY8DAzxvF7cYy7WNiQs
         VbuSOTHX1QyKRhVAQ4Szlnq9VF69GOArldvEUI20SEpfZ5v+5KrP4iCG3TtervpDhndN
         PxLdYDLl67VStV/VOviJT3XcGKffce3BELt0g32nRXcHJ2LX/niWbRyBwcEvIthGypKL
         BtnnqRPASiSFrmlM+qAXkRG1rrNnjCsS59ki4NZpYMvyz6NYNTkguXFJbA7d+RrpZE30
         93Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=U43YKqHWj215EGLcMoze5D0BcuNypR2wHlQCyfq09BE=;
        b=vju9BVapYITM9+Xyx+I1H8qMvsWrL6tiu/fpUzumS0zc6z8k8xhYYS1jSZz4Jzpzv3
         gViLyla9APthvTIk40XJrQNkIEPQubNoCRzqDbEpiNSQG00aY9TFuuvGT8fS6DZvZqW+
         UnAeS8VuMpB51UGsk9JYaJShiqIxBea1DTeG2suYVuiNzTPuLHmaAyAcPHg6adhoid0t
         fvI+HyyPYNjbtxM6ixoa7MpGunmfCvRBdpEydsgDXFpPsuKDOizug0NJ35Fzg+xL1wgE
         fKONg9wJdKDCS2xyb8YIsSfo/GnJdl0YkvWaKFqQqawkrXiEvaVKAN8aUCjbfTbY7JiR
         PPNQ==
X-Gm-Message-State: ACrzQf0N5QOzG/EBROo/8AxcF/j9MXAqMGuxv7Sf6VgQPDgrcNUsmkEO
        qsqoLfAEIpBttMcEf3ob6B4w8ZSR4/I=
X-Google-Smtp-Source: AMsMyM66MNkQEaLvu5kyj8BMVzxMevTO3WrbIVmnzeqVnEKeIXSYb2bIrmckdOI5x8PNi3muKmXd2tQGQYA=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:c05a:2e99:29cd:d157])
 (user=yuzhao job=sendgmr) by 2002:a0d:eec2:0:b0:348:67bc:a1a3 with SMTP id
 x185-20020a0deec2000000b0034867bca1a3mr10293691ywe.148.1663488080721; Sun, 18
 Sep 2022 01:01:20 -0700 (PDT)
Date:   Sun, 18 Sep 2022 02:00:10 -0600
In-Reply-To: <20220918080010.2920238-1-yuzhao@google.com>
Message-Id: <20220918080010.2920238-14-yuzhao@google.com>
Mime-Version: 1.0
References: <20220918080010.2920238-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Subject: [PATCH mm-unstable v15 13/14] mm: multi-gen LRU: admin guide
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an admin guide.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 Documentation/admin-guide/mm/index.rst        |   1 +
 Documentation/admin-guide/mm/multigen_lru.rst | 162 ++++++++++++++++++
 mm/Kconfig                                    |   3 +-
 mm/vmscan.c                                   |   4 +
 4 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-g=
uide/mm/index.rst
index 1bd11118dfb1..d1064e0ba34a 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -32,6 +32,7 @@ the Linux memory management.
    idle_page_tracking
    ksm
    memory-hotplug
+   multigen_lru
    nommu-mmap
    numa_memory_policy
    numaperf
diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/=
admin-guide/mm/multigen_lru.rst
new file mode 100644
index 000000000000..33e068830497
--- /dev/null
+++ b/Documentation/admin-guide/mm/multigen_lru.rst
@@ -0,0 +1,162 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Multi-Gen LRU
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The multi-gen LRU is an alternative LRU implementation that optimizes
+page reclaim and improves performance under memory pressure. Page
+reclaim decides the kernel's caching policy and ability to overcommit
+memory. It directly impacts the kswapd CPU usage and RAM efficiency.
+
+Quick start
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Build the kernel with the following configurations.
+
+* ``CONFIG_LRU_GEN=3Dy``
+* ``CONFIG_LRU_GEN_ENABLED=3Dy``
+
+All set!
+
+Runtime options
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``/sys/kernel/mm/lru_gen/`` contains stable ABIs described in the
+following subsections.
+
+Kill switch
+-----------
+``enabled`` accepts different values to enable or disable the
+following components. Its default value depends on
+``CONFIG_LRU_GEN_ENABLED``. All the components should be enabled
+unless some of them have unforeseen side effects. Writing to
+``enabled`` has no effect when a component is not supported by the
+hardware, and valid values will be accepted even when the main switch
+is off.
+
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Values Components
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+0x0001 The main switch for the multi-gen LRU.
+0x0002 Clearing the accessed bit in leaf page table entries in large
+       batches, when MMU sets it (e.g., on x86). This behavior can
+       theoretically worsen lock contention (mmap_lock). If it is
+       disabled, the multi-gen LRU will suffer a minor performance
+       degradation for workloads that contiguously map hot pages,
+       whose accessed bits can be otherwise cleared by fewer larger
+       batches.
+0x0004 Clearing the accessed bit in non-leaf page table entries as
+       well, when MMU sets it (e.g., on x86). This behavior was not
+       verified on x86 varieties other than Intel and AMD. If it is
+       disabled, the multi-gen LRU will suffer a negligible
+       performance degradation.
+[yYnN] Apply to all the components above.
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+E.g.,
+::
+
+    echo y >/sys/kernel/mm/lru_gen/enabled
+    cat /sys/kernel/mm/lru_gen/enabled
+    0x0007
+    echo 5 >/sys/kernel/mm/lru_gen/enabled
+    cat /sys/kernel/mm/lru_gen/enabled
+    0x0005
+
+Thrashing prevention
+--------------------
+Personal computers are more sensitive to thrashing because it can
+cause janks (lags when rendering UI) and negatively impact user
+experience. The multi-gen LRU offers thrashing prevention to the
+majority of laptop and desktop users who do not have ``oomd``.
+
+Users can write ``N`` to ``min_ttl_ms`` to prevent the working set of
+``N`` milliseconds from getting evicted. The OOM killer is triggered
+if this working set cannot be kept in memory. In other words, this
+option works as an adjustable pressure relief valve, and when open, it
+terminates applications that are hopefully not being used.
+
+Based on the average human detectable lag (~100ms), ``N=3D1000`` usually
+eliminates intolerable janks due to thrashing. Larger values like
+``N=3D3000`` make janks less noticeable at the risk of premature OOM
+kills.
+
+The default value ``0`` means disabled.
+
+Experimental features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``/sys/kernel/debug/lru_gen`` accepts commands described in the
+following subsections. Multiple command lines are supported, so does
+concatenation with delimiters ``,`` and ``;``.
+
+``/sys/kernel/debug/lru_gen_full`` provides additional stats for
+debugging. ``CONFIG_LRU_GEN_STATS=3Dy`` keeps historical stats from
+evicted generations in this file.
+
+Working set estimation
+----------------------
+Working set estimation measures how much memory an application needs
+in a given time interval, and it is usually done with little impact on
+the performance of the application. E.g., data centers want to
+optimize job scheduling (bin packing) to improve memory utilizations.
+When a new job comes in, the job scheduler needs to find out whether
+each server it manages can allocate a certain amount of memory for
+this new job before it can pick a candidate. To do so, the job
+scheduler needs to estimate the working sets of the existing jobs.
+
+When it is read, ``lru_gen`` returns a histogram of numbers of pages
+accessed over different time intervals for each memcg and node.
+``MAX_NR_GENS`` decides the number of bins for each histogram. The
+histograms are noncumulative.
+::
+
+    memcg  memcg_id  memcg_path
+       node  node_id
+           min_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
+           ...
+           max_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
+
+Each bin contains an estimated number of pages that have been accessed
+within ``age_in_ms``. E.g., ``min_gen_nr`` contains the coldest pages
+and ``max_gen_nr`` contains the hottest pages, since ``age_in_ms`` of
+the former is the largest and that of the latter is the smallest.
+
+Users can write the following command to ``lru_gen`` to create a new
+generation ``max_gen_nr+1``:
+
+    ``+ memcg_id node_id max_gen_nr [can_swap [force_scan]]``
+
+``can_swap`` defaults to the swap setting and, if it is set to ``1``,
+it forces the scan of anon pages when swap is off, and vice versa.
+``force_scan`` defaults to ``1`` and, if it is set to ``0``, it
+employs heuristics to reduce the overhead, which is likely to reduce
+the coverage as well.
+
+A typical use case is that a job scheduler runs this command at a
+certain time interval to create new generations, and it ranks the
+servers it manages based on the sizes of their cold pages defined by
+this time interval.
+
+Proactive reclaim
+-----------------
+Proactive reclaim induces page reclaim when there is no memory
+pressure. It usually targets cold pages only. E.g., when a new job
+comes in, the job scheduler wants to proactively reclaim cold pages on
+the server it selected, to improve the chance of successfully landing
+this new job.
+
+Users can write the following command to ``lru_gen`` to evict
+generations less than or equal to ``min_gen_nr``.
+
+    ``- memcg_id node_id min_gen_nr [swappiness [nr_to_reclaim]]``
+
+``min_gen_nr`` should be less than ``max_gen_nr-1``, since
+``max_gen_nr`` and ``max_gen_nr-1`` are not fully aged (equivalent to
+the active list) and therefore cannot be evicted. ``swappiness``
+overrides the default value in ``/proc/sys/vm/swappiness``.
+``nr_to_reclaim`` limits the number of pages to evict.
+
+A typical use case is that a job scheduler runs this command before it
+tries to land a new job on a server. If it fails to materialize enough
+cold pages because of the overestimation, it retries on the next
+server according to the ranking result obtained from the working set
+estimation step. This less forceful approach limits the impacts on the
+existing jobs.
diff --git a/mm/Kconfig b/mm/Kconfig
index ab6ef5115eb8..ceec438c0741 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1125,7 +1125,8 @@ config LRU_GEN
 	# make sure folio->flags has enough spare bits
 	depends on 64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP
 	help
-	  A high performance LRU implementation to overcommit memory.
+	  A high performance LRU implementation to overcommit memory. See
+	  Documentation/admin-guide/mm/multigen_lru.rst for details.
=20
 config LRU_GEN_ENABLED
 	bool "Enable by default"
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7657d54c9c42..1456f133f256 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5310,6 +5310,7 @@ static ssize_t show_min_ttl(struct kobject *kobj, str=
uct kobj_attribute *attr, c
 	return sprintf(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)))=
;
 }
=20
+/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
 static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *=
attr,
 			     const char *buf, size_t len)
 {
@@ -5343,6 +5344,7 @@ static ssize_t show_enabled(struct kobject *kobj, str=
uct kobj_attribute *attr, c
 	return snprintf(buf, PAGE_SIZE, "0x%04x\n", caps);
 }
=20
+/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
 static ssize_t store_enabled(struct kobject *kobj, struct kobj_attribute *=
attr,
 			     const char *buf, size_t len)
 {
@@ -5490,6 +5492,7 @@ static void lru_gen_seq_show_full(struct seq_file *m,=
 struct lruvec *lruvec,
 	seq_putc(m, '\n');
 }
=20
+/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
 static int lru_gen_seq_show(struct seq_file *m, void *v)
 {
 	unsigned long seq;
@@ -5648,6 +5651,7 @@ static int run_cmd(char cmd, int memcg_id, int nid, u=
nsigned long seq,
 	return err;
 }
=20
+/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
 static ssize_t lru_gen_seq_write(struct file *file, const char __user *src=
,
 				 size_t len, loff_t *pos)
 {
--=20
2.37.3.968.ga6b4b080e4-goog

