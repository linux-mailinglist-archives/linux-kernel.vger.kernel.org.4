Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7D5EE976
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiI1WfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiI1Wed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:34:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FD0F962D;
        Wed, 28 Sep 2022 15:34:10 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u8so3412009qvv.9;
        Wed, 28 Sep 2022 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Tjj6ATF6Canh9drI6EDoMALKIa5USqpwu3Z1hroTt1E=;
        b=kc8MnC2tZjfyT1OHr7oem13ar6CbGvXTPlsJPg4ls4ohROc83adATaBlEJCZezeH1C
         vsZ5oUUA+B9L0g+Bkk39PLzeubyp2DyfVoJoZ9Zuq2Qsb8+StameSMoVBPuMt3bVCnRL
         coy4RGa8VfE6Rbw622dqywhJ4WJzOSAvVN20qhVzwAACdHRDu9rFPEkPLP2ljJiJY43l
         IqGSh57dsBe0H2HHsWh1998DsIFN/Qm+GtfjxXU8olPYvmv6jkBMS834HsYzg10Atmro
         bL25Bin46Q5OK+V8UdIyXx7CaaLqS7R6BnZCiF4UnAN1AD9nXKL/uUXTGBwtWYMMWzbv
         oyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Tjj6ATF6Canh9drI6EDoMALKIa5USqpwu3Z1hroTt1E=;
        b=G8q4WO/BYf5SoZBqaQHHYm5OZMqzL+w6xkgrZA93HZaDfV3ozkGDnPIVxozaMNdeKQ
         Vi5VqQ69l2lqGDp0XAdwBvx5Urkm9Jh70f+nrs+SQ6DpGLuyl3ER804+vkOYbVM/HI+f
         P0Is2B3VzSWSMcEiwDYwlSRcv6IYVQTP3bK0Z7gXuVcZxFlYGCRVPlJZRjK/1qcYcpxJ
         +HeYVZ0Gjk8A3Agp+BXMkJ9Gft9/xHnxQm+X68n+lXF+Y2C+lme4yY9fdGtbEQ5Sre2a
         DHX6QB0G5XQ+/+fkIxKZ6Nqrv7W50IRCJfaol2xBaWwgZKYEdst5JMBFZOSel5eIZzaL
         WfOw==
X-Gm-Message-State: ACrzQf0t2/jk69j5WYKqIA4T5oNgArJIiaLgh/ZKWYTKozwrQ51WAjLW
        SX/lxmE6MpwTAXXY7x2leH8=
X-Google-Smtp-Source: AMsMyM6VoQtRRInmPkH9hx0tn+zQ9wF1eVVy8Cf8ySuI7caOUVeCsNTyQ/vn10yr9RGUky2CsTBgnQ==
X-Received: by 2002:a05:6214:2301:b0:498:9f6f:28d with SMTP id gc1-20020a056214230100b004989f6f028dmr277150qvb.5.1664404449183;
        Wed, 28 Sep 2022 15:34:09 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:34:08 -0700 (PDT)
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
Subject: [PATCH v2 9/9] mm/page_alloc: allow base for movablecore
Date:   Wed, 28 Sep 2022 15:33:01 -0700
Message-Id: <20220928223301.375229-10-opendmb@gmail.com>
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
index c07111a897c0..a151752c4266 100644
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

