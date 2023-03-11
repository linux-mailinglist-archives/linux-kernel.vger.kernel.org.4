Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81C86B56E1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCKAlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCKAkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:40:47 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1FC13B28B;
        Fri, 10 Mar 2023 16:40:20 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l13so7748197qtv.3;
        Fri, 10 Mar 2023 16:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUweBIxK1ApmrVss49z+UC3wE/nMfv3P38hD7KfWAG8=;
        b=b8xlkMmx2Va+LMTaL4tjD8wYbm4UC16eGq/CrQTHkbnm9E2UfknGNDOooRPnWFHGH6
         HXTiYXZS1Z4zgkWMhxH4u7I5AbqAc5eeOZhtfDX036xKJJ+55cFVd3c276/H96DePLC8
         NxCS1PwmJLpvBg7BPQFk06uiCf28nVWffj5kbhUi3KznMOjevla6Bq8op4cw4ED6lVfx
         6utHCbAoUN93i+J0xNphYV6jvsuIXhNDDr9S6CzOTcNB+n/aroO0U+CSERlTywJM50e6
         ZLL4BiS8iPRnwj68gAb4ZS7lToep1wKzor8UHnBFdOyaf37GDfSlrp6Wutseal3QZY+N
         YWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUweBIxK1ApmrVss49z+UC3wE/nMfv3P38hD7KfWAG8=;
        b=WcEJQl+74H0HBoFCpm3XER4uC5sPOXs4186zlVu3VSTM9EW7KkCbA1B3ktiGA2yb37
         JZHxceZjQ7w9F1FKz1qZpo4mHp+WVLmdfvoFQZJggOSyr+t+Gvo9t9LEm02jYPuCzxbN
         E9UHZKIaZK//oh4dHIIT6hxk24lUNG+ofEopxB+RniiaA52Ime8yPJK1uvuPFpTAA6K9
         jks2nxAqEI8H6NdexDCurGy60W7StygFTW4hB647bS3Vip+kw/0GSeHtCQ5xe1UcIEFa
         NK5YEpsI1+pwCFpIVJEPYww3AlXTW9pPDkqNvR/C8WO74nW6zIX9x7c9KjgXdNUb+8v4
         uZyg==
X-Gm-Message-State: AO0yUKWf1++j8yWycFvI/mYawxngxhllT0WaC5Dt+EVgbWf1D3ye5z/H
        QlG6SQppFAFHZCztQkULKMA=
X-Google-Smtp-Source: AK7set9au5WlIK4MR23yBqVZHrwwWy+PuYch9qrfX49bao0ol0Y+CZl0Oj9zvXShGjOoENldS5rAGQ==
X-Received: by 2002:a05:622a:5c9:b0:3bf:d366:50d5 with SMTP id d9-20020a05622a05c900b003bfd36650d5mr42637917qtb.56.1678495215959;
        Fri, 10 Mar 2023 16:40:15 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:40:15 -0800 (PST)
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
Subject: [PATCH v4 9/9] mm/page_alloc: allow base for movablecore
Date:   Fri, 10 Mar 2023 16:38:55 -0800
Message-Id: <20230311003855.645684-10-opendmb@gmail.com>
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

A Designated Movable Block can be created by including the base
address of the block when specifying a movablecore range on the
kernel command line.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 14 ++++++-
 mm/page_alloc.c                               | 38 ++++++++++++++++---
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..5e3bf6e0a264 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3353,7 +3353,7 @@
 			reporting absolute coordinates, such as tablets
 
 	movablecore=	[KNL,X86,IA-64,PPC]
-			Format: nn[KMGTPE] | nn%
+			Format: nn[KMGTPE] | nn[KMGTPE]@ss[KMGTPE] | nn%
 			This parameter is the complement to kernelcore=, it
 			specifies the amount of memory used for migratable
 			allocations.  If both kernelcore and movablecore is
@@ -3363,6 +3363,18 @@
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
index d4358d19d5a1..cb3c55acf7de 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8504,9 +8504,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 }
 
 static int __init cmdline_parse_core(char *p, unsigned long *core,
-				     unsigned long *percent)
+				     unsigned long *percent, bool movable)
 {
-	unsigned long long coremem;
+	unsigned long long coremem, address;
 	char *endptr;
 
 	if (!p)
@@ -8521,6 +8521,17 @@ static int __init cmdline_parse_core(char *p, unsigned long *core,
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
 
@@ -8543,17 +8554,32 @@ static int __init cmdline_parse_kernelcore(char *p)
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
2.34.1

