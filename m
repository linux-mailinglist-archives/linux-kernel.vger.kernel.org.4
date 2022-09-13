Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DF5B7BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIMT7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIMT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:44 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239877EB4;
        Tue, 13 Sep 2022 12:58:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r20so8906218qtn.12;
        Tue, 13 Sep 2022 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5WWAAzNcGRX09yf3QcgLeiV4ytIgw0QIAz2zMov/ZDY=;
        b=Yz1mtV6YiuvArbfHbQBXNKT9eLELbvn7bnniGDLD1BumkiBsr2ZDlVa36+Wy8wKT5o
         ryYhGAJx49vUh11TKsorymepYWGSO76xJbhP0rWVGH3ntJ/cZBgl0HG4OoxTwsRCKi5P
         r8fZHkmi9dhCwHqvtScDgQwe7gg6nWmJBlbT6hYOH0ew7iRaIAjSwvoSk6SKm+tRfQu+
         rKZsLcxmkz1cCAli2W9VyR6gyYWGuJOVoZMSgPsY0YmHve5v7DOrmmIyu3LMUZg6pUfw
         lIU/zKc3QMqDUaQMXnCFOtpC/YhN4nYgSjeSX0Y2GgcVNB6wvWWTn+zhjMxvZzDNv7zs
         69cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5WWAAzNcGRX09yf3QcgLeiV4ytIgw0QIAz2zMov/ZDY=;
        b=keVK2qTyr0mAp68rSoSKQu2s0EYZtJ0bTuSBrK5zTl1JgbNXoxxQl1YT+pY8QQzoz0
         saVuhpTmIfoHIlBlo8DPQph6N9bE1/SKbIQ0mQEzvJ6CSVLrj7KOolr1QEdWAj7xha3k
         jfiloyjwHoBL9F+DpmL44ThLdRC+qo8HZ/o+79vkLb9dmAzWkXqy0EM1fIQEw4dJ+v92
         kHtBXq0M4tJ1FmigwLMPiaWcUMZniDCaQFa3pXHMp+hSsvOMjSvsGgOQdOEgFRi988b5
         N076arQ4q2iblI1BbvgMK6xXc6PgFMdsZloZwzQXQwuhoitoR9uLj5eSXeinyEvHrJ2R
         po1Q==
X-Gm-Message-State: ACgBeo2xHUdK/BT7ZkzDVqAXW7ZG+QvWOf73qetsowJQVpNQB96yeXcY
        Z+r+U5DL2URTREHK2PAfiUM=
X-Google-Smtp-Source: AA6agR6JFHHtW1Pd7kJf3d4lhxO33YWLvSfzGCmyAGQLZ1dEkgSuVHnr1X0agG5L8d/cKj0D7xYuZA==
X-Received: by 2002:a05:622a:1998:b0:343:6452:dbd9 with SMTP id u24-20020a05622a199800b003436452dbd9mr30254647qtc.423.1663099118855;
        Tue, 13 Sep 2022 12:58:38 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:38 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: [PATCH 12/21] memblock: introduce MEMBLOCK_MOVABLE flag
Date:   Tue, 13 Sep 2022 12:54:59 -0700
Message-Id: <20220913195508.3511038-13-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index b5d3026979fc..5d6a210d98ec 100644
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

