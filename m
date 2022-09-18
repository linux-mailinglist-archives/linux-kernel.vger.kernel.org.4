Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89F75BBC69
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIRIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIRIBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:01:21 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A38E26543
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:15 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id f14-20020a056e020b4e00b002eb541997edso17304120ilu.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=h4SdvsYg/JB9VfCa4Q/GjK3m7bZ9yQOY/aR/7T2edN8=;
        b=GrOBfoG6IGt527MD+Qhts5mNgmw2t8iWycbGeq58mgHLTwuYeAUmJjVfwOwB8PxxNT
         x/Dk+i4uhMUXIBWVDYldc7wR+Kq1G/bxriTCzu02mDpuJTZx4tR2NxglscQjzdmIDLrE
         iVi3KbYmAVCzZgy/jgz/L5ervIKqEvk8rFm6I31DuEU1OR4lN/IR42zKGII5gGMfQK/u
         eVNea34Ydpf0omdlIIvTCPoZC/zX591VPpJ1bWn+drQvjqmgyAIUJb0f+f1Ix/cAylCu
         3zsC+d4yZr3djUzZ/YdzJlOQ1k92Ts3CLoxTyE8pTJiCTryrT+Y3NSSCt3qZpsHU4SH/
         +ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=h4SdvsYg/JB9VfCa4Q/GjK3m7bZ9yQOY/aR/7T2edN8=;
        b=5dEhr86qxR9xgQJM++ctlywdiIh6bkRJwR5vLsWQlaU+MTKzYdb2Pv5uDTE5rJ7SU2
         7VBybuFS/e/0B71VN8HnxFGnte6UArK14uAM/M21z23vbv5Tk/Z2wGpA3Endfm047kNK
         I0Shuw4/G+L6kqTU2QqNkRDnz/2rxEu/RFIhMsHfZrHzH6Ogg8yLLRP8aADCnQ6XlRmS
         k3kLGQLLSpHDQm9sKH1UXgQEI4rRRbZj2kQNUurfPUSgFca/uuontgVtXfIyuItCs5Rh
         kLXx6xlzU16n1j+QpoHZdnkMfbdDmWFPKFa/ymUxWlCSmtchomtPTfVtNVe55KLV/XHm
         G9QA==
X-Gm-Message-State: ACrzQf0Q4gaprYoah0/n14Z2zmkr5+4k39z/pE9sJbyJBEYTh1BV1t22
        oc0eOt57cLS7eMJmPd/W+C6CV6XwaIU=
X-Google-Smtp-Source: AMsMyM4zwP84C+VuganW4axl59gQX5IMXkXmt49n4tsuARME7pR0+j3uMAK5GLN+Vn9594BY3IVAaEdBUPY=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:c05a:2e99:29cd:d157])
 (user=yuzhao job=sendgmr) by 2002:a05:6e02:1a63:b0:2f5:80db:c5c1 with SMTP id
 w3-20020a056e021a6300b002f580dbc5c1mr836566ilv.204.1663488074815; Sun, 18 Sep
 2022 01:01:14 -0700 (PDT)
Date:   Sun, 18 Sep 2022 02:00:06 -0600
In-Reply-To: <20220918080010.2920238-1-yuzhao@google.com>
Message-Id: <20220918080010.2920238-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20220918080010.2920238-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Subject: [PATCH mm-unstable v15 09/14] mm: multi-gen LRU: optimize multiple memcgs
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple memcgs are available, it is possible to use generations
as a frame of reference to make better choices and improve overall
performance under global memory pressure. This patch adds a basic
optimization to select memcgs that can drop single-use unmapped clean
pages first. Doing so reduces the chance of going into the aging path
or swapping, which can be costly.

A typical example that benefits from this optimization is a server
running mixed types of workloads, e.g., heavy anon workload in one
memcg and heavy buffered I/O workload in the other.

Though this optimization can be applied to both kswapd and direct
reclaim, it is only added to kswapd to keep the patchset manageable.
Later improvements may cover the direct reclaim path.

While ensuring certain fairness to all eligible memcgs, proportional
scans of individual memcgs also require proper backoff to avoid
overshooting their aggregate reclaim target by too much. Otherwise it
can cause high direct reclaim latency. The conditions for backoff are:
1. At low priorities, for direct reclaim, if aging fairness or direct
   reclaim latency is at risk, i.e., aging one memcg multiple times or
   swapping after the target is met.
2. At high priorities, for global reclaim, if per-zone free pages are
   above respective watermarks.

Server benchmark results:
  Mixed workloads:
    fio (buffered I/O): +[19, 21]%
                IOPS         BW
      patch1-8: 1880k        7343MiB/s
      patch1-9: 2252k        8796MiB/s

    memcached (anon): +[119, 123]%
                Ops/sec      KB/sec
      patch1-8: 862768.65    33514.68
      patch1-9: 1911022.12   74234.54

  Mixed workloads:
    fio (buffered I/O): +[75, 77]%
                IOPS         BW
      5.19-rc1: 1279k        4996MiB/s
      patch1-9: 2252k        8796MiB/s

    memcached (anon): +[13, 15]%
                Ops/sec      KB/sec
      5.19-rc1: 1673524.04   65008.87
      patch1-9: 1911022.12   74234.54

  Configurations:
    (changes since patch 6)

    cat mixed.sh
    modprobe brd rd_nr=3D2 rd_size=3D56623104

    swapoff -a
    mkswap /dev/ram0
    swapon /dev/ram0

    mkfs.ext4 /dev/ram1
    mount -t ext4 /dev/ram1 /mnt

    memtier_benchmark -S /var/run/memcached/memcached.sock \
      -P memcache_binary -n allkeys --key-minimum=3D1 \
      --key-maximum=3D50000000 --key-pattern=3DP:P -c 1 -t 36 \
      --ratio 1:0 --pipeline 8 -d 2000

    fio -name=3Dmglru --numjobs=3D36 --directory=3D/mnt --size=3D1408m \
      --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
      --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D32 \
      --rw=3Drandread --random_distribution=3Drandom --norandommap \
      --time_based --ramp_time=3D10m --runtime=3D90m --group_reporting &
    pid=3D$!

    sleep 200

    memtier_benchmark -S /var/run/memcached/memcached.sock \
      -P memcache_binary -n allkeys --key-minimum=3D1 \
      --key-maximum=3D50000000 --key-pattern=3DR:R -c 1 -t 36 \
      --ratio 0:1 --pipeline 8 --randomize --distinct-client-seed

    kill -INT $pid
    wait

Client benchmark results:
  no change (CONFIG_MEMCG=3Dn)

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
 mm/vmscan.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c579b254fec7..3f83325fdc71 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -131,6 +131,12 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
=20
+#ifdef CONFIG_LRU_GEN
+	/* help kswapd make better choices among multiple memcgs */
+	unsigned int memcgs_need_aging:1;
+	unsigned long last_reclaimed;
+#endif
+
 	/* Allocation order */
 	s8 order;
=20
@@ -4431,6 +4437,19 @@ static void lru_gen_age_node(struct pglist_data *pgd=
at, struct scan_control *sc)
=20
 	VM_WARN_ON_ONCE(!current_is_kswapd());
=20
+	sc->last_reclaimed =3D sc->nr_reclaimed;
+
+	/*
+	 * To reduce the chance of going into the aging path, which can be
+	 * costly, optimistically skip it if the flag below was cleared in the
+	 * eviction path. This improves the overall performance when multiple
+	 * memcgs are available.
+	 */
+	if (!sc->memcgs_need_aging) {
+		sc->memcgs_need_aging =3D true;
+		return;
+	}
+
 	set_mm_walk(pgdat);
=20
 	memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
@@ -4842,7 +4861,8 @@ static int isolate_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int sw
 	return scanned;
 }
=20
-static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, in=
t swappiness)
+static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, in=
t swappiness,
+			bool *need_swapping)
 {
 	int type;
 	int scanned;
@@ -4905,6 +4925,9 @@ static int evict_folios(struct lruvec *lruvec, struct=
 scan_control *sc, int swap
=20
 	sc->nr_reclaimed +=3D reclaimed;
=20
+	if (need_swapping && type =3D=3D LRU_GEN_ANON)
+		*need_swapping =3D true;
+
 	return scanned;
 }
=20
@@ -4914,9 +4937,8 @@ static int evict_folios(struct lruvec *lruvec, struct=
 scan_control *sc, int swap
  *    reclaim.
  */
 static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_con=
trol *sc,
-				    bool can_swap)
+				    bool can_swap, bool *need_aging)
 {
-	bool need_aging;
 	unsigned long nr_to_scan;
 	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
@@ -4926,8 +4948,8 @@ static unsigned long get_nr_to_scan(struct lruvec *lr=
uvec, struct scan_control *
 	    (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
 		return 0;
=20
-	need_aging =3D should_run_aging(lruvec, max_seq, min_seq, sc, can_swap, &=
nr_to_scan);
-	if (!need_aging)
+	*need_aging =3D should_run_aging(lruvec, max_seq, min_seq, sc, can_swap, =
&nr_to_scan);
+	if (!*need_aging)
 		return nr_to_scan;
=20
 	/* skip the aging path at the default priority */
@@ -4944,10 +4966,68 @@ static unsigned long get_nr_to_scan(struct lruvec *=
lruvec, struct scan_control *
 	return min_seq[!can_swap] + MIN_NR_GENS <=3D max_seq ? nr_to_scan : 0;
 }
=20
+static bool should_abort_scan(struct lruvec *lruvec, unsigned long seq,
+			      struct scan_control *sc, bool need_swapping)
+{
+	int i;
+	DEFINE_MAX_SEQ(lruvec);
+
+	if (!current_is_kswapd()) {
+		/* age each memcg once to ensure fairness */
+		if (max_seq - seq > 1)
+			return true;
+
+		/* over-swapping can increase allocation latency */
+		if (sc->nr_reclaimed >=3D sc->nr_to_reclaim && need_swapping)
+			return true;
+
+		/* give this thread a chance to exit and free its memory */
+		if (fatal_signal_pending(current)) {
+			sc->nr_reclaimed +=3D MIN_LRU_BATCH;
+			return true;
+		}
+
+		if (cgroup_reclaim(sc))
+			return false;
+	} else if (sc->nr_reclaimed - sc->last_reclaimed < sc->nr_to_reclaim)
+		return false;
+
+	/* keep scanning at low priorities to ensure fairness */
+	if (sc->priority > DEF_PRIORITY - 2)
+		return false;
+
+	/*
+	 * A minimum amount of work was done under global memory pressure. For
+	 * kswapd, it may be overshooting. For direct reclaim, the target isn't
+	 * met, and yet the allocation may still succeed, since kswapd may have
+	 * caught up. In either case, it's better to stop now, and restart if
+	 * necessary.
+	 */
+	for (i =3D 0; i <=3D sc->reclaim_idx; i++) {
+		unsigned long wmark;
+		struct zone *zone =3D lruvec_pgdat(lruvec)->node_zones + i;
+
+		if (!managed_zone(zone))
+			continue;
+
+		wmark =3D current_is_kswapd() ? high_wmark_pages(zone) : low_wmark_pages=
(zone);
+		if (wmark > zone_page_state(zone, NR_FREE_PAGES))
+			return false;
+	}
+
+	sc->nr_reclaimed +=3D MIN_LRU_BATCH;
+
+	return true;
+}
+
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_contr=
ol *sc)
 {
 	struct blk_plug plug;
+	bool need_aging =3D false;
+	bool need_swapping =3D false;
 	unsigned long scanned =3D 0;
+	unsigned long reclaimed =3D sc->nr_reclaimed;
+	DEFINE_MAX_SEQ(lruvec);
=20
 	lru_add_drain();
=20
@@ -4967,21 +5047,28 @@ static void lru_gen_shrink_lruvec(struct lruvec *lr=
uvec, struct scan_control *sc
 		else
 			swappiness =3D 0;
=20
-		nr_to_scan =3D get_nr_to_scan(lruvec, sc, swappiness);
+		nr_to_scan =3D get_nr_to_scan(lruvec, sc, swappiness, &need_aging);
 		if (!nr_to_scan)
-			break;
+			goto done;
=20
-		delta =3D evict_folios(lruvec, sc, swappiness);
+		delta =3D evict_folios(lruvec, sc, swappiness, &need_swapping);
 		if (!delta)
-			break;
+			goto done;
=20
 		scanned +=3D delta;
 		if (scanned >=3D nr_to_scan)
 			break;
=20
+		if (should_abort_scan(lruvec, max_seq, sc, need_swapping))
+			break;
+
 		cond_resched();
 	}
=20
+	/* see the comment in lru_gen_age_node() */
+	if (sc->nr_reclaimed - reclaimed >=3D MIN_LRU_BATCH && !need_aging)
+		sc->memcgs_need_aging =3D false;
+done:
 	clear_mm_walk();
=20
 	blk_finish_plug(&plug);
--=20
2.37.3.968.ga6b4b080e4-goog

