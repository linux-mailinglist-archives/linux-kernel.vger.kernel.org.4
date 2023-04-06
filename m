Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331796D9BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjDFPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbjDFPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:14:49 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FA449FF;
        Thu,  6 Apr 2023 08:14:47 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id p34so22773574wms.3;
        Thu, 06 Apr 2023 08:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794086; x=1683386086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTGfYrqfzS07zpfH0JC+lthwHQN3E94OuA9UZu3JUac=;
        b=Q83y9iB1IJZ0G79EXIxMQMOIU9BpXDuLAjUf7pEp5b++Ovms/y1InFmGHEXQytR2GE
         p0QInp2rW1Gfd4q/g1PsKInyLIDBKOeCTPEym/P8Dvjkna6aj5On33YyxfiX/8sbiYDt
         hzOMbtAGSwk2GpGsfFr9uwPoZTrXVOl+r40IkAZfm+oKZnBvzJj7bm5RRYqEHi7GrNy+
         WZVisxxRRovcdMuCRiyDVdtS/ENoj3v3+vmr3lvRkpeQY/xSaCTNabZ5EfWTKbV5AEAb
         2ky8vG5Ibt2Ls69jcQPUhLTFgtykHaU74NCj2GVLBi+RDYDznzlg0YLnG5y6+rMPhzb8
         38PA==
X-Gm-Message-State: AAQBX9cYDWyvf/wo70LLYkoYY4Mq49ClfpRD6UM5JmvDPuKWbpOcR8E3
        Rhia8c1dk2NorNOZFCZRLYE=
X-Google-Smtp-Source: AKy350bioooJgfp2IytRIDWd0TtyTY5KBmKx4pJ+VtEwGO+IsLJWXioFGYateblkCLF62e/3sqxzDw==
X-Received: by 2002:a7b:c38a:0:b0:3ed:e715:1784 with SMTP id s10-20020a7bc38a000000b003ede7151784mr8689914wmj.15.1680794085640;
        Thu, 06 Apr 2023 08:14:45 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b003ef67848a21sm5560213wmb.13.2023.04.06.08.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:14:45 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com,
        stefan@agner.ch, Lucas Tanure <tanure@linux.com>
Subject: [PATCH 1/2] memblock: Differentiate regions overlap from both regions being the same
Date:   Thu,  6 Apr 2023 16:14:28 +0100
Message-Id: <20230406151429.524591-2-tanure@linux.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406151429.524591-1-tanure@linux.com>
References: <20230406151429.524591-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for memblock_addrs_overlap to return a different value when
both regions are exactly the same region, where base and size are equal
between the regions.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 include/linux/memblock.h | 18 +++++++++++++++---
 mm/memblock.c            | 37 ++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..c7ba8b01a637 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -49,6 +49,18 @@ enum memblock_flags {
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
 };
 
+/**
+ * enum memblock_overlap_type - result of comparison between two memory regions
+ * @MEMBLOCK_NO_OVERLAPS: there is no overlap between the two regions
+ * @MEMBLOCK_OVERLAPS: the two regions overlap each other, but are not the same
+ * @MEMBLOCK_EQUAL: both bases and sizes are equal, so the two regions are exactly the same
+ */
+enum memblock_overlap_type {
+	MEMBLOCK_NO_OVERLAPS,
+	MEMBLOCK_OVERLAPS,
+	MEMBLOCK_EQUAL,
+};
+
 /**
  * struct memblock_region - represents a memory region
  * @base: base address of the region
@@ -118,8 +130,8 @@ int memblock_reserve(phys_addr_t base, phys_addr_t size);
 int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 #endif
 void memblock_trim_memory(phys_addr_t align);
-bool memblock_overlaps_region(struct memblock_type *type,
-			      phys_addr_t base, phys_addr_t size);
+unsigned int memblock_overlaps_region(struct memblock_type *type,
+				      phys_addr_t base, phys_addr_t size);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
@@ -486,7 +498,7 @@ bool memblock_is_memory(phys_addr_t addr);
 bool memblock_is_map_memory(phys_addr_t addr);
 bool memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
 bool memblock_is_reserved(phys_addr_t addr);
-bool memblock_is_region_reserved(phys_addr_t base, phys_addr_t size);
+unsigned int memblock_is_region_reserved(phys_addr_t base, phys_addr_t size);
 
 void memblock_dump_all(void);
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 25fd0626a9e7..948cc1bc3edf 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -175,24 +175,33 @@ static inline phys_addr_t memblock_cap_size(phys_addr_t base, phys_addr_t *size)
 /*
  * Address comparison utilities
  */
-static unsigned long __init_memblock memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
-				       phys_addr_t base2, phys_addr_t size2)
+static unsigned int __init_memblock memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
+							   phys_addr_t base2, phys_addr_t size2)
 {
-	return ((base1 < (base2 + size2)) && (base2 < (base1 + size1)));
+	if (base1 == base2 && size1 == size2)
+		return MEMBLOCK_EQUAL;
+
+	if ((base1 < (base2 + size2)) && (base2 < (base1 + size1)))
+		return MEMBLOCK_OVERLAPS;
+
+	return MEMBLOCK_NO_OVERLAPS;
 }
 
-bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
-					phys_addr_t base, phys_addr_t size)
+unsigned int __init_memblock memblock_overlaps_region(struct memblock_type *type,
+						      phys_addr_t base, phys_addr_t size)
 {
-	unsigned long i;
+	unsigned long i, ret;
 
 	memblock_cap_size(base, &size);
 
-	for (i = 0; i < type->cnt; i++)
-		if (memblock_addrs_overlap(base, size, type->regions[i].base,
-					   type->regions[i].size))
-			break;
-	return i < type->cnt;
+	for (i = 0; i < type->cnt; i++) {
+		ret = memblock_addrs_overlap(base, size, type->regions[i].base,
+					     type->regions[i].size);
+		if (ret)
+			return ret;
+	}
+
+	return MEMBLOCK_NO_OVERLAPS;
 }
 
 /**
@@ -1857,9 +1866,11 @@ bool __init_memblock memblock_is_region_memory(phys_addr_t base, phys_addr_t siz
  * memory block.
  *
  * Return:
- * True if they intersect, false if not.
+ * MEMBLOCK_NO_OVERLAPS if there is no intersection,
+ * MEMBLOCK_OVERLAPS if they only intersect,
+ * MEMBLOCK_EQUAL if the region matches base and size to an reserved memory.
  */
-bool __init_memblock memblock_is_region_reserved(phys_addr_t base, phys_addr_t size)
+unsigned int __init_memblock memblock_is_region_reserved(phys_addr_t base, phys_addr_t size)
 {
 	return memblock_overlaps_region(&memblock.reserved, base, size);
 }
-- 
2.40.0

