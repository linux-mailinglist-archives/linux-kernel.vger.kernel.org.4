Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3D5B797F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiIMS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiIMS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9446D6C77D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523F36153C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D271C43470;
        Tue, 13 Sep 2022 17:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091108;
        bh=9ivYQelMNdPJnaUU9EF7chmzaREKfF8OhPMBITLg3Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMkprEXAQC24XJuiTGGjHyvCehrXWfCWngVdHpBZekHiCxDCwHZs0bOCXOeUCGKF8
         NAWMZpAkMK5j5PUmvn9X13/I1Xx+Q3H3d8j6AH3HocE847FyXcbB6E0u2ImFA1+HiW
         XcP4TCbJSNnGyPtX5aBTXrfh8r6R56LOXK7Gx2fZgrTD4kVu1uEWKufBq3AF/YeWfU
         kFigvWxhkISGTBBEeedP/5RwKIBFKlDPHTlQk3gqZByQpGK9poN3cLcmo80BDROsnc
         Cjen7hGO3HLbS2379iozDv043UszchvmX+3WKTheH4+4Sw7BMZXvVAjUurep7BxVqc
         JnJE5k/ZtpKhQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/22] mm/damon/lru_sort: deduplicate hot/cold schemes generators
Date:   Tue, 13 Sep 2022 17:44:49 +0000
Message-Id: <20220913174449.50645-23-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damon_lru_sort_new_{hot,cold}_scheme() have quite a lot of duplicates.
This commit factors out the duplicate to a separate function and use it
for reducing the duplicate.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 8d9c3d1fd6be..07a0908963fd 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -135,6 +135,25 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
+static struct damos *damon_lru_sort_new_scheme(
+		struct damos_access_pattern *pattern, enum damos_action action)
+{
+	struct damos_quota quota = damon_lru_sort_quota;
+
+	/* Use half of total quota for hot/cold pages sorting */
+	quota.ms = quota.ms / 2;
+
+	return damon_new_scheme(
+			/* find the pattern, and */
+			pattern,
+			/* (de)prioritize on LRU-lists */
+			action,
+			/* under the quota. */
+			&quota,
+			/* (De)activate this according to the watermarks. */
+			&damon_lru_sort_wmarks);
+}
+
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
@@ -149,19 +168,8 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 		.min_age_region = 0,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_quota quota = damon_lru_sort_quota;
-
-	/* Use half of total quota for hot pages sorting */
-	quota.ms = quota.ms / 2;
 
-	return damon_new_scheme(
-			&pattern,
-			/* prioritize those on LRU lists, as soon as found */
-			DAMOS_LRU_PRIO,
-			/* under the quota. */
-			&quota,
-			/* (De)activate this according to the watermarks. */
-			&damon_lru_sort_wmarks);
+	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
 }
 
 /* Create a DAMON-based operation scheme for cold memory regions */
@@ -178,19 +186,8 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 		.min_age_region = cold_thres,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_quota quota = damon_lru_sort_quota;
 
-	/* Use half of total quota for cold pages sorting */
-	quota.ms = quota.ms / 2;
-
-	return damon_new_scheme(
-			&pattern,
-			/* mark those as not accessed, as soon as found */
-			DAMOS_LRU_DEPRIO,
-			/* under the quota. */
-			&quota,
-			/* (De)activate this according to the watermarks. */
-			&damon_lru_sort_wmarks);
+	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
 static int damon_lru_sort_apply_parameters(void)
-- 
2.25.1

