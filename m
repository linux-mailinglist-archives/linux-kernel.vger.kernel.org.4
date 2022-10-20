Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D33606A95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJTVzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJTVyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:54:53 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF05FCA;
        Thu, 20 Oct 2022 14:54:40 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id x15so640365qvp.1;
        Thu, 20 Oct 2022 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0ZvpnVNYZiRg/rCuSdzxC9eb6lzs9TieDFdQySZsn8=;
        b=SZ1PlrYOPpSqmq/vLnLZafqj76vcgQtuklt87DwVjrckcKo++SoYbWCoXH2RuEmcb6
         4y4tJhiFfNsKAYGCDqNldMQv8ggfF9el1/DuGHGyFTTgGJTgBB1ub2t8TJn/8VQ/0njh
         x9PBzyecXTaH7sPHGenWV53OQv2MF6VIv7XIRqYd6awOmsAXwfizyl7Pvu/dtb12NoEI
         FmlTxSQ26E38t9VXc438mbDPBM+Nsfx1gqnxiKl0224bwHFJKJ36YENdqiT+aCbkxIGU
         QeFvaN4zOD3HePcbtw0ZaU1yZSvLexZNzQIPkdE25F5wKPOiXAjcD1OSAUZXG39Xan4S
         LqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0ZvpnVNYZiRg/rCuSdzxC9eb6lzs9TieDFdQySZsn8=;
        b=S4uFdewn95nKOBfbiI6JPdHxZ6TaB3LIdEoxikXMwVjzoaX9vOdeNeHBKge5q++Bvy
         RQSMWzqfQSsp52Xx/ztM+JGrKnVBLhQASGHysyOL0A1BoPiOy0yVTZeULNKjbrwGO+Zm
         06ibPrp3imh0NVKcANbXyCNkjQvXrLZO8mUlduiAxlgcqIKokZSr5qGrL8Slq4ujobUy
         Co1xms4BuijitPMxcS1w8TzWZwxj/1W72dU0OicVvnf8iopLZTydy+CT2LR/LUMEmYsK
         NL7k/4kvLpVExK3R39gxBLr+RDW47A8swhSRpJ08Ux6BjAJVgrTvfE3JNmCzZ0rX2n2f
         5eUg==
X-Gm-Message-State: ACrzQf1BF3pmwIx8hf7H8MsXWFbMYMHok+xqoG97PAIMj7FzHjdFqFnp
        tuGWHTzyUVpQAprFHrpCVOQ=
X-Google-Smtp-Source: AMsMyM7a38TE8ilGlotanmpyp3rhbuPFqLEEes3huL7M5Q8qh4Xm+gSlVT2+xpnn07tUAZEUhQLqSA==
X-Received: by 2002:a05:6214:29ef:b0:4b4:5d8c:637c with SMTP id jv15-20020a05621429ef00b004b45d8c637cmr13527095qvb.77.1666302879221;
        Thu, 20 Oct 2022 14:54:39 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:38 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v3 6/9] memblock: introduce MEMBLOCK_MOVABLE flag
Date:   Thu, 20 Oct 2022 14:53:15 -0700
Message-Id: <20221020215318.4193269-7-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020215318.4193269-1-opendmb@gmail.com>
References: <20221020215318.4193269-1-opendmb@gmail.com>
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
index 511d4783dcf1..46a4deb07d92 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -979,6 +979,30 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
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
2.25.1

