Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5065B7BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiIMUAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiIMT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:59:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A1786FF;
        Tue, 13 Sep 2022 12:58:50 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q11so6264314qkc.12;
        Tue, 13 Sep 2022 12:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ed+iX/nv/XMEFygJ1SlfRX9x+uzs7Q6SqUw+PcSFA+Y=;
        b=kTC2V8I0KbKQgYVpiMXWXobqHukHN5wc9G7pyTq0OXIlmxgzs1DdLdIuMurl376JOh
         TI+sLZOsyYvKvgQV1mtsgOKDhgkCHY9vgTN75V+209rBR7AYRtArLxFXLQfDpntS8+77
         1VJuC85XaAr9lDOJi4JPuZBYlxos4LmgTFUlBZzjlAHRPleIyKNPrsw1Q/TybKJ6LhLy
         P7jZiatOzHC+C4lsh8jLuUsBJv4lBg9GwtABHfhEamUAOb2Eu3rURCtfJTb4hzSEiYzf
         Mf68rOnlVxAV76vW2E0E1N4Dtdqb6V3ShGLPb0HbK61ur+zHBF+wQNqRrMeYo3aOEqsI
         sQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ed+iX/nv/XMEFygJ1SlfRX9x+uzs7Q6SqUw+PcSFA+Y=;
        b=T20Otj5Ly/TC8a+VsTAB82tQyD56hLYzJ8A4iZBRUOyYuwJeTDyvVkJfEHZchkr9o6
         ovTG9933VUDtGHgYWjS02Q2PzvykKjGg+0Xcf5ibS8YFftj7Lvdo8mI8IyeqEdEQQqmD
         eOHN3hJvGlb59TdFRhlOU2NPZKO8xO9Rgg7k3BHXEV9VLL1gspkQTrZ8u7QmR3JApcXq
         XoGDa/otK7QtsgqNQ1tNSYzu61A3bg76kCI76EIg2UuKYl+NfACgAVj5jBaZ1gSY8yTj
         hZ8telwUlJk6v3baBvwa27UpL1fVEfRFib1tJe7DaAJNOEsRtvf4NYmtjFLdZfckWgpy
         YmBQ==
X-Gm-Message-State: ACgBeo2WYpA/Dl/zJgmMXFGqBPH6+kwbgNEU7VqoDjxR5ATWpXEDnboa
        HFc2tVUeLx1KXCIVCtXzQ6w=
X-Google-Smtp-Source: AA6agR6oL/h20WlhqK4D/I9yr1owRo+hnv02mOT7OtmgSO2hWSXNGrz7MzYBNL87UH+0Ca4e8ZJtlg==
X-Received: by 2002:a05:620a:2956:b0:6ce:60f5:d887 with SMTP id n22-20020a05620a295600b006ce60f5d887mr4614697qkp.303.1663099129650;
        Tue, 13 Sep 2022 12:58:49 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:49 -0700 (PDT)
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
Subject: [PATCH 15/21] mm/page_alloc: allow base for movablecore
Date:   Tue, 13 Sep 2022 12:55:02 -0700
Message-Id: <20220913195508.3511038-16-opendmb@gmail.com>
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

A Designated Movable Block can be created by including the base
address of the block when specifying a movablecore range on the
kernel command line.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 14 ++++++-
 mm/page_alloc.c                               | 38 ++++++++++++++++---
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 426fa892d311..8141fac7c7cb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3312,7 +3312,7 @@
 			reporting absolute coordinates, such as tablets
 
 	movablecore=	[KNL,X86,IA-64,PPC]
-			Format: nn[KMGTPE] | nn%
+			Format: nn[KMGTPE] | nn[KMGTPE]@ss[KMGTPE] | nn%
 			This parameter is the complement to kernelcore=, it
 			specifies the amount of memory used for migratable
 			allocations.  If both kernelcore and movablecore is
@@ -3322,6 +3322,18 @@
 			that the amount of memory usable for all allocations
 			is not too small.
 
+			If @ss[KMGTPE] is included, memory within the region
+			from ss to ss+nn will be designated as a movable block
+			and included in ZONE_MOVABLE. Designated Movable Blocks
+			must be aligned to pageblock_order. Designated Movable
+			Blocks take priority over values of kernelcore= and are
+			considered part of any memory specified by more general
+			movablecore= values.
+			Multiple Designated Movable Blocks may be specified,
+			comma delimited.
+			Example:
+				movablecore=100M@2G,100M@3G,1G@1024G
+
 	movable_node	[KNL] Boot-time switch to make hotplugable memory
 			NUMA nodes to be movable. This means that the memory
 			of such nodes will be usable only for movable
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69753cc51e19..e38dd1b32771 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8370,9 +8370,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 }
 
 static int __init cmdline_parse_core(char *p, unsigned long *core,
-				     unsigned long *percent)
+				     unsigned long *percent, bool movable)
 {
-	unsigned long long coremem;
+	unsigned long long coremem, address;
 	char *endptr;
 
 	if (!p)
@@ -8387,6 +8387,17 @@ static int __init cmdline_parse_core(char *p, unsigned long *core,
 		*percent = coremem;
 	} else {
 		coremem = memparse(p, &p);
+		if (movable && *p == '@') {
+			address = memparse(++p, &p);
+			if (*p != '\0' ||
+			    !memblock_is_region_memory(address, coremem) ||
+			    memblock_is_region_reserved(address, coremem))
+				return -EINVAL;
+			memblock_reserve(address, coremem);
+			return dmb_reserve(address, coremem, NULL);
+		} else if (*p != '\0') {
+			return -EINVAL;
+		}
 		/* Paranoid check that UL is enough for the coremem value */
 		WARN_ON((coremem >> PAGE_SHIFT) > ULONG_MAX);
 
@@ -8409,17 +8420,32 @@ static int __init cmdline_parse_kernelcore(char *p)
 	}
 
 	return cmdline_parse_core(p, &required_kernelcore,
-				  &required_kernelcore_percent);
+				  &required_kernelcore_percent, false);
 }
 
 /*
  * movablecore=size sets the amount of memory for use for allocations that
- * can be reclaimed or migrated.
+ * can be reclaimed or migrated. movablecore=size@base defines a Designated
+ * Movable Block.
  */
 static int __init cmdline_parse_movablecore(char *p)
 {
-	return cmdline_parse_core(p, &required_movablecore,
-				  &required_movablecore_percent);
+	int ret = -EINVAL;
+
+	while (p) {
+		char *k = strchr(p, ',');
+
+		if (k)
+			*k++ = 0;
+
+		ret = cmdline_parse_core(p, &required_movablecore,
+					 &required_movablecore_percent, true);
+		if (ret)
+			break;
+		p = k;
+	}
+
+	return ret;
 }
 
 early_param("kernelcore", cmdline_parse_kernelcore);
-- 
2.25.1

