Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E33725267
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbjFGDY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjFGDYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:24:17 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21627B1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:24:16 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b28fc460bcso1885056a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 20:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686108255; x=1688700255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OgwZPlgTY4glqblC0q55tNx4aE1dg2OGEiZu4tHi+PA=;
        b=j9g0z6iCjf5/NTI/5hhX2u4AuPVNqXlbHH3MbIGdy40fOLvhk+dKprh+tscjzve6bg
         KtHVmhf5oKWv94BxnbHyCk+H+VVxiOoD6pVSgdfqjv6ebPIzVvLcKWbpQYoQGigw+pw+
         25Heu3c3+wxTXeQBoQ0YawhVpa98WophCTYonpf7Xe1X7v9FEpNKWUPIvCO4HETrKUpm
         51tPr+e8LjGaIKLVgGtIkHv65cUe5hZev1xjKPB01f7/gY4U7oLeScGKVCoUzdyugGNH
         FfWgwHmpl95zM1H8As0qwVAA6CvqLyJLGASCgRVliIYGf5x5n5Q0jejrXivqMmG5R6qz
         Tqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686108255; x=1688700255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgwZPlgTY4glqblC0q55tNx4aE1dg2OGEiZu4tHi+PA=;
        b=lFOw2E8sBta5NrXYAcPkJ9aYRPw5VgY5pelVF8AwDV7ZfpAhe52KgSxhCVUey73MO5
         BgvIfQlkTL+JeLQFnqZOqmPmhFhqq5X/6644ta1KzWtkB9FmSQ51cSPyzk7iuE5SxH8T
         5jY9rIT6REpYl3XSit2ylj0UIS60cDZwet3nqGuNriiN1T9lyBOl8N1PotVQN6OYYPvb
         QANy4TkL8T6+r/vzJEpwmzxwtqQbGvncDdes856dx4FQf0xjhFF9AHv80PUItY4lP5oN
         YQujFw8kJkJ7084/g6lYwpUeqwdaHJp5RAJfUbNPnSAFCYNw6PmfGPjh2/IpfPRXkvOF
         pgZw==
X-Gm-Message-State: AC+VfDzAsSK75NQlqQXrw2/8AtkcIHP2u1H+Izw2OdaaGzIHqtmPi1KE
        QkJw+NcSStlGLt0bsMaayuZIVXhrwqM3ScnENWRlEzP7
X-Google-Smtp-Source: ACHHUZ6TlFM03zUCwMYtVp47KAlUrytE63DdFa39QIYecIs6QaU7rVWkQQqN5KhIXWUqpkvpc6EKQw==
X-Received: by 2002:a9d:750a:0:b0:6af:9219:25ae with SMTP id r10-20020a9d750a000000b006af921925aemr4154937otk.11.1686108255477;
        Tue, 06 Jun 2023 20:24:15 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id x21-20020a62fb15000000b0064fff9f540csm7337567pfm.164.2023.06.06.20.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 20:24:14 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm/mm_init.c: drop 'nid' parameter from check_for_memory()
Date:   Wed,  7 Jun 2023 03:24:02 +0000
Message-Id: <20230607032402.4679-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node_id in pgdat has already been set in free_area_init_node(),
so use it internally instead of passing a redundant parameter.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index b82718d596c3..78e67041ae9f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1725,7 +1725,7 @@ static void __init free_area_init_node(int nid)
 }
 
 /* Any regular or high memory on that node ? */
-static void check_for_memory(pg_data_t *pgdat, int nid)
+static void check_for_memory(pg_data_t *pgdat)
 {
 	enum zone_type zone_type;
 
@@ -1733,9 +1733,9 @@ static void check_for_memory(pg_data_t *pgdat, int nid)
 		struct zone *zone = &pgdat->node_zones[zone_type];
 		if (populated_zone(zone)) {
 			if (IS_ENABLED(CONFIG_HIGHMEM))
-				node_set_state(nid, N_HIGH_MEMORY);
+				node_set_state(pgdat->node_id, N_HIGH_MEMORY);
 			if (zone_type <= ZONE_NORMAL)
-				node_set_state(nid, N_NORMAL_MEMORY);
+				node_set_state(pgdat->node_id, N_NORMAL_MEMORY);
 			break;
 		}
 	}
@@ -1887,7 +1887,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 		/* Any memory on that node */
 		if (pgdat->node_present_pages)
 			node_set_state(nid, N_MEMORY);
-		check_for_memory(pgdat, nid);
+		check_for_memory(pgdat);
 	}
 
 	memmap_init();
-- 
2.25.1

