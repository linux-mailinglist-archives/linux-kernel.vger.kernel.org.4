Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1B5BBC71
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIRIC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIRIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:01:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4AE26556
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f5960500bso227553787b3.14
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=0lTs8OS4olIPIqW+zqXK+/D/SmJn39+HbHh4ssv4OPc=;
        b=ge8HszPxUD+tCp8FfsT5/b9vWMoIlv7vDucG3NX8Jd/WWZRXKp3s6KdpS2ATsFZ0h4
         yr9uRGrLWGDXh3tB05gX1g3OKUW+1CId3jrGLA6Cn3S952Xi/+7itXbZ6/sSIwNIid40
         2jx54DLIjOD+ZefkkWEUG7NxCurgwPHPE7b68cC3X2q6FhIrqaOxpdRwuXH0hXNnuZKP
         tKYp5T5ArNkzd9RKemRHLxyKae++8c0rAHX2PqHaxmuwFp6D2Tq5lIo6sbYCPXMBrcWw
         0G8Wj8+DdhwSZrBP5j9qKBkpw0mS3Y77QI1QCk77h36GttXdpeJkRKot4LvOyJPbS4ll
         NNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=0lTs8OS4olIPIqW+zqXK+/D/SmJn39+HbHh4ssv4OPc=;
        b=4WZVuztsuKVFvo5C9DT2GJXIsOHMulyv11/eDemDIB5iNz/W3TNpXuVwrhoK+GsskW
         97mFfQSZQU7PTxQLS6cC0IJZe+1WtiNAojzelwkWrAAuT8I5C152Gs/6i2O3LxdYsFDq
         LpYOKxEiBWjCQIWZwY+Z4XKpvDagriyGzhDiNFm30IVm4JP75zAlAhgk5P6s2NujENJc
         BJDx1ZiOP8srRJIT4lzvymFodEwDw2qVRLMJ4Gjog6h6tSyIKJ2l8NwPxP6KI/cxWiNl
         2us8VuL3FhUnUvA5SZsUiP8meW+HwG/zRuOERMojvrHzw6YpAw6Q+37GcgRB6kBaz29G
         Lceg==
X-Gm-Message-State: ACrzQf0l5ds7/GGzjmGOLtmeAMngJ8dGGUPuxwNaEpzi190fvkAhfwfg
        kyPZoyQN5fyQapH9Mu8kWltRabnHBgo=
X-Google-Smtp-Source: AMsMyM7zHFJ1jk7yR5tVWl3kOUihOs1Lu7Ep0zEUNVRne0ZlxIUTVL1OexpefsjiMYQICWpRaU4/Wz/Gjng=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:c05a:2e99:29cd:d157])
 (user=yuzhao job=sendgmr) by 2002:a25:c512:0:b0:6a8:fec2:7c88 with SMTP id
 v18-20020a25c512000000b006a8fec27c88mr9813193ybe.61.1663488077668; Sun, 18
 Sep 2022 01:01:17 -0700 (PDT)
Date:   Sun, 18 Sep 2022 02:00:08 -0600
In-Reply-To: <20220918080010.2920238-1-yuzhao@google.com>
Message-Id: <20220918080010.2920238-12-yuzhao@google.com>
Mime-Version: 1.0
References: <20220918080010.2920238-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Subject: [PATCH mm-unstable v15 11/14] mm: multi-gen LRU: thrashing prevention
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

Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention, as
requested by many desktop users [1].

When set to value N, it prevents the working set of N milliseconds
from getting evicted. The OOM killer is triggered if this working set
cannot be kept in memory. Based on the average human detectable lag
(~100ms), N=3D1000 usually eliminates intolerable lags due to thrashing.
Larger values like N=3D3000 make lags less noticeable at the risk of
premature OOM kills.

Compared with the size-based approach [2], this time-based approach
has the following advantages:
1. It is easier to configure because it is agnostic to applications
   and memory sizes.
2. It is more reliable because it is directly wired to the OOM killer.

[1] https://lore.kernel.org/r/Ydza%2FzXKY9ATRoh6@google.com/
[2] https://lore.kernel.org/r/20101028191523.GA14972@google.com/

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
 include/linux/mmzone.h |  2 ++
 mm/vmscan.c            | 74 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 95c58c7fbdff..87347945270b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -422,6 +422,8 @@ struct lru_gen_struct {
 	unsigned long max_seq;
 	/* the eviction increments the oldest generation numbers */
 	unsigned long min_seq[ANON_AND_FILE];
+	/* the birth time of each generation in jiffies */
+	unsigned long timestamps[MAX_NR_GENS];
 	/* the multi-gen LRU lists, lazily sorted on eviction */
 	struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the multi-gen LRU sizes, eventually consistent */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 10f31f3c5054..9ef2ec3d3c0c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4293,6 +4293,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool c=
an_swap)
 	for (type =3D 0; type < ANON_AND_FILE; type++)
 		reset_ctrl_pos(lruvec, type, false);
=20
+	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
=20
@@ -4422,7 +4423,7 @@ static bool should_run_aging(struct lruvec *lruvec, u=
nsigned long max_seq, unsig
 	return false;
 }
=20
-static void age_lruvec(struct lruvec *lruvec, struct scan_control *sc)
+static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc, uns=
igned long min_ttl)
 {
 	bool need_aging;
 	unsigned long nr_to_scan;
@@ -4436,16 +4437,36 @@ static void age_lruvec(struct lruvec *lruvec, struc=
t scan_control *sc)
 	mem_cgroup_calculate_protection(NULL, memcg);
=20
 	if (mem_cgroup_below_min(memcg))
-		return;
+		return false;
=20
 	need_aging =3D should_run_aging(lruvec, max_seq, min_seq, sc, swappiness,=
 &nr_to_scan);
+
+	if (min_ttl) {
+		int gen =3D lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
+		unsigned long birth =3D READ_ONCE(lruvec->lrugen.timestamps[gen]);
+
+		if (time_is_after_jiffies(birth + min_ttl))
+			return false;
+
+		/* the size is likely too small to be helpful */
+		if (!nr_to_scan && sc->priority !=3D DEF_PRIORITY)
+			return false;
+	}
+
 	if (need_aging)
 		try_to_inc_max_seq(lruvec, max_seq, sc, swappiness);
+
+	return true;
 }
=20
+/* to protect the working set of the last N jiffies */
+static unsigned long lru_gen_min_ttl __read_mostly;
+
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_contro=
l *sc)
 {
 	struct mem_cgroup *memcg;
+	bool success =3D false;
+	unsigned long min_ttl =3D READ_ONCE(lru_gen_min_ttl);
=20
 	VM_WARN_ON_ONCE(!current_is_kswapd());
=20
@@ -4468,12 +4489,32 @@ static void lru_gen_age_node(struct pglist_data *pg=
dat, struct scan_control *sc)
 	do {
 		struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
=20
-		age_lruvec(lruvec, sc);
+		if (age_lruvec(lruvec, sc, min_ttl))
+			success =3D true;
=20
 		cond_resched();
 	} while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
=20
 	clear_mm_walk();
+
+	/* check the order to exclude compaction-induced reclaim */
+	if (success || !min_ttl || sc->order)
+		return;
+
+	/*
+	 * The main goal is to OOM kill if every generation from all memcgs is
+	 * younger than min_ttl. However, another possibility is all memcgs are
+	 * either below min or empty.
+	 */
+	if (mutex_trylock(&oom_lock)) {
+		struct oom_control oc =3D {
+			.gfp_mask =3D sc->gfp_mask,
+		};
+
+		out_of_memory(&oc);
+
+		mutex_unlock(&oom_lock);
+	}
 }
=20
 /*
@@ -5231,6 +5272,28 @@ static void lru_gen_change_state(bool enabled)
  *                          sysfs interface
  *************************************************************************=
*****/
=20
+static ssize_t show_min_ttl(struct kobject *kobj, struct kobj_attribute *a=
ttr, char *buf)
+{
+	return sprintf(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)))=
;
+}
+
+static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *=
attr,
+			     const char *buf, size_t len)
+{
+	unsigned int msecs;
+
+	if (kstrtouint(buf, 0, &msecs))
+		return -EINVAL;
+
+	WRITE_ONCE(lru_gen_min_ttl, msecs_to_jiffies(msecs));
+
+	return len;
+}
+
+static struct kobj_attribute lru_gen_min_ttl_attr =3D __ATTR(
+	min_ttl_ms, 0644, show_min_ttl, store_min_ttl
+);
+
 static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *a=
ttr, char *buf)
 {
 	unsigned int caps =3D 0;
@@ -5279,6 +5342,7 @@ static struct kobj_attribute lru_gen_enabled_attr =3D=
 __ATTR(
 );
=20
 static struct attribute *lru_gen_attrs[] =3D {
+	&lru_gen_min_ttl_attr.attr,
 	&lru_gen_enabled_attr.attr,
 	NULL
 };
@@ -5294,12 +5358,16 @@ static struct attribute_group lru_gen_attr_group =
=3D {
=20
 void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
+	int i;
 	int gen, type, zone;
 	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
=20
 	lrugen->max_seq =3D MIN_NR_GENS + 1;
 	lrugen->enabled =3D lru_gen_enabled();
=20
+	for (i =3D 0; i <=3D MIN_NR_GENS + 1; i++)
+		lrugen->timestamps[i] =3D jiffies;
+
 	for_each_gen_type_zone(gen, type, zone)
 		INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
=20
--=20
2.37.3.968.ga6b4b080e4-goog

