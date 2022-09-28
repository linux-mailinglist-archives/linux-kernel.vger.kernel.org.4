Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12B5EE970
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiI1Wei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiI1WeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:34:12 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C9FB333;
        Wed, 28 Sep 2022 15:34:02 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a20so8859725qtw.10;
        Wed, 28 Sep 2022 15:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5WWAAzNcGRX09yf3QcgLeiV4ytIgw0QIAz2zMov/ZDY=;
        b=XG34Y6tDaJWwx6DqjTOFzsu9FQfdW30BYf0FXo1qOyK2ddb1gPjKGPuXlnXn7WJbbp
         3at5ITh2zqc5ND+psxUlpktCRqb1IAzsURp8laAwU3meMWmslVlJ04PurbIm8TjZW067
         nvbJ2vgFDTno5HMU+Gfi0PWAZYLTaVzf8H1Dyc6ZNAhhNr+6tXQhmbbkKh+4XQNl5zF1
         K+hxIbMy/hJCcqrK4JjzhlxcdtKPFgihmjVSBLcdQYwclydS6XWbaKLgt1yT+hrAmziP
         mvTMSR2mIOdkNftizVll21ORt676/ts4LNcVaPrB5p5YHLQb1rddtODGPalGlxkiWHGt
         FAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5WWAAzNcGRX09yf3QcgLeiV4ytIgw0QIAz2zMov/ZDY=;
        b=Eb0ykG2QwAMxlMzJHSd+WHk/y+BZoyHXyw8BoQB4TABcgS8QkyLqpCh5NtLmSs36Cb
         zemF950YB0+p6jaApVupXGZHERtguFGAa8fusD8pKCLSdxyZJdeJy4J1ts3QVqrZfXPv
         ZKyB9FNeXwl6DNySGtdTal3fLtv/tK8/DRr9UaBfDxJ9MWsTe+VGt2kCdu0cLvat7LjW
         Q+DFXb4RQFSCEAp7vnmZvZ3tafNuclGDT5u6lWMsDHJJCaNmgv9cB1vIb05ASAuGCQvR
         KR4kuNM5ytjkrdVfH/24heBxQ+tr3zQRMJJEbIrdE8VHxE1+y1EjSjPiolk8Y0zE5sM0
         SRvA==
X-Gm-Message-State: ACrzQf2IjVpMyHfC3duP0V/wNNVow5jJ5RWQw0IrLNbY/PfJxU9xgwPx
        jQm8ZrJBpztupomup6YAwQw=
X-Google-Smtp-Source: AMsMyM5hls3k73DLDHwmozK6Fn+6fum9LVyQsQgOKR/Uau82IHif8GbeTAVnzUtgkLXNeRQjKZrgzg==
X-Received: by 2002:ac8:584c:0:b0:35c:ceee:197a with SMTP id h12-20020ac8584c000000b0035cceee197amr50280qth.662.1664404440788;
        Wed, 28 Sep 2022 15:34:00 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:34:00 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 6/9] memblock: introduce MEMBLOCK_MOVABLE flag
Date:   Wed, 28 Sep 2022 15:32:58 -0700
Message-Id: <20220928223301.375229-7-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928223301.375229-1-opendmb@gmail.com>
References: <20220928223301.375229-1-opendmb@gmail.com>
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

