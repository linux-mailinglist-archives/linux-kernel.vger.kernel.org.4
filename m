Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0687F6AFF1C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 07:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCHGrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 01:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCHGrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:47:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FEA9E668
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 22:47:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso1074162pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 22:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678258064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gG2oN8vtildG2P61+wI9F4PrJ+MvdmYrBhZL9NTK/Uo=;
        b=qrtN7j5AXKWJsCG3E0PH4oiCMNwLFR6JCjdwKskXS/mauDKDcisfSfVFXcUnjsBlEC
         ax3etlGwgmryLx5JXpm28/mwLf2AV7y6/B5orDESXqchdDaCntCp7hrjMuxEJdWQv5IT
         AgCeScSiNGdLQAlN4bi06JOmybvt9w49xghgqxwRID4jZN4j6s3FLjJiNfBKrezBJUtD
         p6iFalHB5coyIDEkCp8PxdBSaszXHzQcAilmx0+npCC88zVByWDRXfvCkqVbjlL3IbYe
         Cc0SNWskqmmLHHu8PGumzRfI1SttVg1HYgrUfgJrnBRN0pkvdtNOacd31XdSqldMp0TG
         qIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678258064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG2oN8vtildG2P61+wI9F4PrJ+MvdmYrBhZL9NTK/Uo=;
        b=HhXic7ndzxYFUkFffY0QFS80lHOeAYki7BB5CPOoVqjEhAIfA1kuqHggjHMKwGVVH8
         KoTcK8XOjuMTnQ69er/NydIGDqO1Fn5L03LPO6D+wBs8S9BlkJb0qObeU3Cd9FWHclLS
         VUa3betfbAxw7EPkTAwGTudOMyOaZCb65cAWTr9VmJqVNDSvjamCNXRw04FU8EFB/H/j
         97WMirs4ef7R2tDnehZutXdbWDlLAORCKhcGSKeEGTnqWWCoAl9S48rHgfXrwLlzvNMZ
         rDoZhBBpQOWrldRMh1U9UZNef0cdyqxHl2jNk9hO99P7V78MoxZsvbncD11pz2J6zJiD
         9tOA==
X-Gm-Message-State: AO0yUKWWyYUP9DC9wUdTxukerdlZAx8mU4IP54F0NQk20MEGNSD23RdI
        QJ/5FChcaGIjkOitJOz6y3c=
X-Google-Smtp-Source: AK7set9j5/uTj4qvRxW7bRO0mbX+0sl5auSDS2wZRxqHsunyU90ihaJiYjiNyp921WUS0zv/keFrDg==
X-Received: by 2002:a17:90b:204:b0:23a:2038:bf4b with SMTP id fy4-20020a17090b020400b0023a2038bf4bmr17014620pjb.3.1678258063791;
        Tue, 07 Mar 2023 22:47:43 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090aca9400b0023317104415sm10149201pjt.17.2023.03.07.22.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 22:47:43 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        pierre.gondois@arm.com, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] Revert "riscv: Set more data to cacheinfo"
Date:   Wed,  8 Mar 2023 14:47:34 +0800
Message-Id: <20230308064734.512457-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

This reverts commit baf7cbd94b5688f167443a2cc3dcea3300132099.

There are some duplicate cache attributes populations executed
in both ci_leaf_init() and later cache_setup_properties().

Revert the commit baf7cbd94b56 ("riscv: Set more data to cacheinfo")
to setup only the level and type attributes at this early place.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/cacheinfo.c | 66 ++++++++---------------------------
 1 file changed, 15 insertions(+), 51 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 3a13113f1b29..305ebbdc780d 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -64,53 +64,12 @@ uintptr_t get_cache_geometry(u32 level, enum cache_type type)
 			   0;
 }
 
-static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
-			 unsigned int level, unsigned int size,
-			 unsigned int sets, unsigned int line_size)
+static void ci_leaf_init(struct cacheinfo *this_leaf,
+			 struct device_node *node,
+			 enum cache_type type, unsigned int level)
 {
 	this_leaf->level = level;
 	this_leaf->type = type;
-	this_leaf->size = size;
-	this_leaf->number_of_sets = sets;
-	this_leaf->coherency_line_size = line_size;
-
-	/*
-	 * If the cache is fully associative, there is no need to
-	 * check the other properties.
-	 */
-	if (sets == 1)
-		return;
-
-	/*
-	 * Set the ways number for n-ways associative, make sure
-	 * all properties are big than zero.
-	 */
-	if (sets > 0 && size > 0 && line_size > 0)
-		this_leaf->ways_of_associativity = (size / sets) / line_size;
-}
-
-static void fill_cacheinfo(struct cacheinfo **this_leaf,
-			   struct device_node *node, unsigned int level)
-{
-	unsigned int size, sets, line_size;
-
-	if (!of_property_read_u32(node, "cache-size", &size) &&
-	    !of_property_read_u32(node, "cache-block-size", &line_size) &&
-	    !of_property_read_u32(node, "cache-sets", &sets)) {
-		ci_leaf_init((*this_leaf)++, CACHE_TYPE_UNIFIED, level, size, sets, line_size);
-	}
-
-	if (!of_property_read_u32(node, "i-cache-size", &size) &&
-	    !of_property_read_u32(node, "i-cache-sets", &sets) &&
-	    !of_property_read_u32(node, "i-cache-block-size", &line_size)) {
-		ci_leaf_init((*this_leaf)++, CACHE_TYPE_INST, level, size, sets, line_size);
-	}
-
-	if (!of_property_read_u32(node, "d-cache-size", &size) &&
-	    !of_property_read_u32(node, "d-cache-sets", &sets) &&
-	    !of_property_read_u32(node, "d-cache-block-size", &line_size)) {
-		ci_leaf_init((*this_leaf)++, CACHE_TYPE_DATA, level, size, sets, line_size);
-	}
 }
 
 int populate_cache_leaves(unsigned int cpu)
@@ -121,24 +80,29 @@ int populate_cache_leaves(unsigned int cpu)
 	struct device_node *prev = NULL;
 	int levels = 1, level = 1;
 
-	/* Level 1 caches in cpu node */
-	fill_cacheinfo(&this_leaf, np, level);
+	if (of_property_read_bool(np, "cache-size"))
+		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+	if (of_property_read_bool(np, "i-cache-size"))
+		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+	if (of_property_read_bool(np, "d-cache-size"))
+		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
 
-	/* Next level caches in cache nodes */
 	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
 		of_node_put(prev);
 		prev = np;
-
 		if (!of_device_is_compatible(np, "cache"))
 			break;
 		if (of_property_read_u32(np, "cache-level", &level))
 			break;
 		if (level <= levels)
 			break;
-
-		fill_cacheinfo(&this_leaf, np, level);
-
+		if (of_property_read_bool(np, "cache-size"))
+			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+		if (of_property_read_bool(np, "i-cache-size"))
+			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+		if (of_property_read_bool(np, "d-cache-size"))
+			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
 	of_node_put(np);
-- 
2.20.1

