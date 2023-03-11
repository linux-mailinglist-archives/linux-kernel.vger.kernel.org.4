Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AD06B56D8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCKAkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCKAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:40:20 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ACA139D3F;
        Fri, 10 Mar 2023 16:40:06 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l13so7747881qtv.3;
        Fri, 10 Mar 2023 16:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0kuuT3+6RnS9K3QghRnceBdk8ynqQ1z+mh1LJkGVzo=;
        b=gYseOYKWDMGUISiNkRcjSjvTTZsw5ZpxUtUzYky9ZIu/8x2vFtu1Ubj2/1NfS4ntqc
         hX/h/yEUyA2imIDBGlqwTwoMvCjauAQN3YL66devi+3PsmAyF6mABKzTGpk4hMd7icxM
         YEG/1j8Vk1YoVpNOoeMrCgh/Uo/Rnn3iQf+MpFu+gZkimrhV0E2qnQdFooilVD+K/hHa
         rndAxQ/V0FYCu+PEVJ8K+hWV4ROJd99Mv7LFTpRov8IlSAc9cA6LofsPSnb+8TjoRVr2
         L5hPzI4NrF/E1TKlZrGIJ2bO/Ipsdij7LIspIYw/JuzSHIXAlX+sgOjl322atMjd1034
         P2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0kuuT3+6RnS9K3QghRnceBdk8ynqQ1z+mh1LJkGVzo=;
        b=WhVlndF5Bb4OF7zrC0OZQ3hQ92G6RMhm6JunaDo1YU81XrU41IxDquIEbfpXtbTJul
         Ojim18CbCSWswyP2qfRPClo1Eakt+y6fO2C/eK+TKb2f2sDYPRgxrOXpCnNtiDVPjHRf
         eNTABcX8cK9HIbudURmOn+jzik3o3jioO6tIgWevKmdEk8ZLsVQQoR/ESZj4AuPs2y7F
         kPLNiTLDVaOmRm9LKWLMfaqwhORShC8b0zi0qe4E2DY7gF7AOWYVNYJdRsznVS9LzWXC
         rKDWEwdN4RSIC38bnuSucty/2Ni3W1FIxQwUKnvOHrNYJTG9x6wth/G5GvmzMg8ulNbL
         o3bA==
X-Gm-Message-State: AO0yUKXmv0tRq5J5L5owNNn7SzYIBJjz282U80sXaDlSGw+yctR57PXF
        HHl9MzhRQhdcZUCu3B8/j0s=
X-Google-Smtp-Source: AK7set8ZGDP7wAjGGI9tJbICfiwjsQBTns3pou3iyFBkgtdpeY6NM2VuirqgiTSIHG6uE67a1R8tZQ==
X-Received: by 2002:ac8:57cd:0:b0:3bf:d9a9:25f7 with SMTP id w13-20020ac857cd000000b003bfd9a925f7mr12075430qta.6.1678495205288;
        Fri, 10 Mar 2023 16:40:05 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:40:04 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v4 6/9] memblock: introduce MEMBLOCK_MOVABLE flag
Date:   Fri, 10 Mar 2023 16:38:52 -0800
Message-Id: <20230311003855.645684-7-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311003855.645684-1-opendmb@gmail.com>
References: <20230311003855.645684-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MEMBLOCK_MOVABLE flag is introduced to designate a memblock
as only supporting movable allocations by the page allocator.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/memblock.h |  8 ++++++++
 mm/memblock.c            | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..8eb3ca32dfa7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -47,6 +47,7 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_MOVABLE	= 0x10,	/* designated movable block */
 };
 
 /**
@@ -125,6 +126,8 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_mark_movable(phys_addr_t base, phys_addr_t size);
+int memblock_clear_movable(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
@@ -265,6 +268,11 @@ static inline bool memblock_is_driver_managed(struct memblock_region *m)
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
 }
 
+static inline bool memblock_is_movable(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_MOVABLE;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index 25fd0626a9e7..794a099ec3e2 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -992,6 +992,30 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
 }
 
+/**
+ * memblock_mark_movable - Mark designated movable block with MEMBLOCK_MOVABLE.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_movable(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MOVABLE);
+}
+
+/**
+ * memblock_clear_movable - Clear flag MEMBLOCK_MOVABLE for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_movable(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_MOVABLE);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
-- 
2.34.1

