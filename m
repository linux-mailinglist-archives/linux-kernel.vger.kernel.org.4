Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56CE71EEDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjFAQ1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjFAQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:27:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C710186
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:27:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso451873a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1685636820; x=1688228820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ACJ9Qwha81LGr+RoxzBokRD6gcXSKrY0efwdDtNyXI=;
        b=dg0s4ZFVNYn6tepQuLsU2NKYtfl+oKWqpjFftzP47VwcfA0Ize5oVpiPgWqlAWp+5j
         xQBDKj3yUXWWxyz5/RCb+lkiDGZP4sRos+T9SN8FlMZ7XUZGVaVQIJTEypfh5ezqMjS0
         uO1rmmHWRmVZUclfyHBGsUnZso2/aBY4CMXnsSi8ZIsh+yjhj79StoTGtdfVC07Z5ZcI
         LxvTdjr+etxaN2x/tqmZHe1+fUJYt/sTgD8S3HF9QyFqNCB+UTT4IFVkXUZl4bjwvIbY
         a60PPtBL5WOun5rAgCPL8svmav5dhdOsWr0p4QH+tfPKP7YTYl3LJIGqPk209bvx+HGA
         oH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685636820; x=1688228820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ACJ9Qwha81LGr+RoxzBokRD6gcXSKrY0efwdDtNyXI=;
        b=ix3wloF/sPp8FLk8jMSwwoNsr6ztYu/6pzZgldYInWFyHl/iYo538gUSAIvIon1czk
         UppR6FmltOBKf0Pc6qdV4JXBizZUwNFctVoM2jO9obOvCvdcYlfSX8R3IoMTOtxOorIz
         S33pQ1dsXwEEpzwVTdeWts/YYY7SsPvnL2Skjd3Z4xd0oJ5QYLvcU/QyPgnOYjGc3Var
         cC8Ge1/GG1+KvTbuWGJsoYOHt+tTF588MFmK1QcIy2bAz/SGrUgVg25QFKkOhWDDqcLq
         TOx36zrRQ2Tr2TpD71j5kusUd0NiUEnn68pvysBSUvsqSujqrp6aOCSCwluZFeGAApx4
         SLAw==
X-Gm-Message-State: AC+VfDy7B5IhacpCgnfyMGHgJMMQu7U2NcafRrgkT3Q7biQsP3pc5UwY
        /loK2K0UPdXtqk55gQWhxHjNrw==
X-Google-Smtp-Source: ACHHUZ5ZKzhnwfchbLJtNrudHDOJef/3ChfLyjHB1poNZDA0WJGKeMYyQ+glJ+rHoAHIrsc+xr0HEQ==
X-Received: by 2002:a17:902:f682:b0:1af:a058:cc2d with SMTP id l2-20020a170902f68200b001afa058cc2dmr7831816plg.57.1685636820614;
        Thu, 01 Jun 2023 09:27:00 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001acaf7e26bbsm3750487plk.53.2023.06.01.09.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:27:00 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     david@redhat.com
Cc:     osalvador@suse.de, rppt@kernel.org, mhocko@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] mm/mm_init.c: remove reset_node_present_pages()
Date:   Thu,  1 Jun 2023 16:26:26 +0000
Message-Id: <20230601162626.1030-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reset_node_present_pages() only get called in hotadd_init_pgdat(), move
the action that clear present pages to free_area_init_core_hotplug(), so
the helper can be removed.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memory_hotplug.c | 18 ------------------
 mm/mm_init.c        | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 65e385f34679..ee1c0d9a4d5a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1172,16 +1172,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	return ret;
 }
 
-static void reset_node_present_pages(pg_data_t *pgdat)
-{
-	struct zone *z;
-
-	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
-		z->present_pages = 0;
-
-	pgdat->node_present_pages = 0;
-}
-
 /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
 static pg_data_t __ref *hotadd_init_pgdat(int nid)
 {
@@ -1204,14 +1194,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	 */
 	build_all_zonelists(pgdat);
 
-	/*
-	 * When memory is hot-added, all the memory is in offline state. So
-	 * clear all zones' present_pages because they will be updated in
-	 * online_pages() and offline_pages().
-	 * TODO: should be in free_area_init_core_hotplug?
-	 */
-	reset_node_present_pages(pgdat);
-
 	return pgdat;
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 78e67041ae9f..e24ea1db9e26 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1491,6 +1491,7 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 {
 	int nid = pgdat->node_id;
 	enum zone_type z;
+	struct zone *zone;
 	int cpu;
 
 	pgdat_init_internals(pgdat);
@@ -1507,6 +1508,8 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 	pgdat->kswapd_order = 0;
 	pgdat->kswapd_highest_zoneidx = 0;
 	pgdat->node_start_pfn = 0;
+	pgdat->node_present_pages = 0;
+
 	for_each_online_cpu(cpu) {
 		struct per_cpu_nodestat *p;
 
@@ -1514,8 +1517,15 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 		memset(p, 0, sizeof(*p));
 	}
 
-	for (z = 0; z < MAX_NR_ZONES; z++)
-		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
+	/* When memory is hot-added, all the memory is in offline state. So
+	 * clear all zones' present_pages and managed_pages because they will
+	 * be updated in online_pages() and offline_pages().
+	 */
+	for (z = 0; z < MAX_NR_ZONES; z++) {
+		zone = &pgdat->node_zones[z];
+		zone->present_pages = 0;
+		zone_init_internals(zone, z, nid, 0);
+	}
 }
 #endif
 
-- 
2.25.1

