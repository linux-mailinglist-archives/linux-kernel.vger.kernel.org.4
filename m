Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA32606A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJTVz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiJTVzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:55:20 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18522AF180;
        Thu, 20 Oct 2022 14:54:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j21so866144qkk.9;
        Thu, 20 Oct 2022 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea/3nCCOnpBrAub9VWj+VXkTFR+eMwl9pcvHopG8Sl4=;
        b=jHO9VXRMOgdapG/UgLZpqe+Gt5pAn7UO5fZglesQLnrsJyUhoJnB3qHY4gaLpiyFOy
         bUH75Aj62S7L5f3ngX4qS9txpVrLZd93mjdMBZQ0U7flk0sQPbYTCS7mQ7RIXxkvnq+x
         jZEhV0P3om90L4r12ay7KkkDquUuCss1I8xiwWwxRyQvMekR87gzk1POzYfJyWllelOY
         t3uQ+y3KkAhEZ1RY6johTUnoMIIbx77+Xuo9N2Y/I+jQ6VcUfI2jAsKkEsTB9FyFs08b
         ORM6yLBHqPM6zcCt7XPaHUmhLZp0rubUzkkslI1uggLXAFRo3Mk+qOGm9V0JvNMvR1uL
         F9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea/3nCCOnpBrAub9VWj+VXkTFR+eMwl9pcvHopG8Sl4=;
        b=lXKdRarQ0RF70oHNuKjanvtRUgerT5b3h6DAejk2oh/5jNbu1kCiVvu3DMFhIqShb/
         OgS1PxqTuxc5exHrRpxNXJAQSMEgPwESBLn9Rz+VhZKVte3uOYuv6EiinnnYNbapbVby
         YVdrtt+VDG9ewwqCBRz0vVTk3Jxlq3DTiuJfXe2x3mE/Vyzp1CE2+t2e0JGqDsclSUsj
         46QJP74af1/DMDiCIvw/cC2/eKMxQWxbWz4jN6RVqj+BDjdyl9ygsa2+VET5C6AZBSu2
         c0VzpTv4zo8pDdwIbXri2BzUwUl4WRAEJ39piGIkW5Tzb/HOSF8uHEUVVUiIBdzAz9X0
         Xupw==
X-Gm-Message-State: ACrzQf26CfXnuQtsYSLY2NY2pyYC8DuK4NnEGJYIC3c+4voxLBfvifOg
        03y+dXrEhw6+WVoVMxPidFk=
X-Google-Smtp-Source: AMsMyM4pzFRAGr5Df27Tt7JSy+ztbl+cUDOBbNs8UPvLwkFRB8ksm3avZsXosGl3xlV877vJr3B/0g==
X-Received: by 2002:a05:620a:4250:b0:6cf:a822:7c7e with SMTP id w16-20020a05620a425000b006cfa8227c7emr11637421qko.503.1666302888216;
        Thu, 20 Oct 2022 14:54:48 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:47 -0700 (PDT)
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
Subject: [PATCH v3 9/9] mm/page_alloc: allow base for movablecore
Date:   Thu, 20 Oct 2022 14:53:18 -0700
Message-Id: <20221020215318.4193269-10-opendmb@gmail.com>
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

A Designated Movable Block can be created by including the base
address of the block when specifying a movablecore range on the
kernel command line.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 14 ++++++-
 mm/page_alloc.c                               | 38 ++++++++++++++++---
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..f4f783cd683e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3325,7 +3325,7 @@
 			reporting absolute coordinates, such as tablets
 
 	movablecore=	[KNL,X86,IA-64,PPC]
-			Format: nn[KMGTPE] | nn%
+			Format: nn[KMGTPE] | nn[KMGTPE]@ss[KMGTPE] | nn%
 			This parameter is the complement to kernelcore=, it
 			specifies the amount of memory used for migratable
 			allocations.  If both kernelcore and movablecore is
@@ -3335,6 +3335,18 @@
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
index a39eca3bc01b..385fc9082945 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8461,9 +8461,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 }
 
 static int __init cmdline_parse_core(char *p, unsigned long *core,
-				     unsigned long *percent)
+				     unsigned long *percent, bool movable)
 {
-	unsigned long long coremem;
+	unsigned long long coremem, address;
 	char *endptr;
 
 	if (!p)
@@ -8478,6 +8478,17 @@ static int __init cmdline_parse_core(char *p, unsigned long *core,
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
 
@@ -8500,17 +8511,32 @@ static int __init cmdline_parse_kernelcore(char *p)
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

