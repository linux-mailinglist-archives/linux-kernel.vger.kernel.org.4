Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A108697F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBOPY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjBOPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:24:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B613A86E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:24:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id be8so20561622plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbuK2YMcZd4/efbG59qp7NEzWA/KfSxPQatjxKotauc=;
        b=adSfwx2l32cZymQNminNVdHL2V/I/UNjOjzh5lKsvkexWwnjiH5rIingtZCu1DO0Zp
         jt9zT43qtqTSVqkSMXDZAaZ9lC/mjdJP02G2rHS2NzoTXQuGzhzJoyeGxK5e0owMEY/s
         +zfyEAak3Fqy4QHhXlChAVjxVq9bW96/nKkBEq9JmaduTvwuj1ER733aq04/+UFXgYKF
         6oAOkCrTlHGKswvHLjyM8BNr/9VTEY2vQS70SU3O9ASt3aHZfLnMC4bMVOW/syQ5y4yQ
         WDj6iLQ03mE0hiwiBAxVUzGUf5F4WJQBXeZL+/s7HW/Z2DfASpWfpWXGXbxciKWOEYop
         UM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbuK2YMcZd4/efbG59qp7NEzWA/KfSxPQatjxKotauc=;
        b=SliKN3BpY9F2ELiJYa2UwID9nTr3LlrdLuAPyGghral6lU5dRXrP0bBcoUFc5iI3Uh
         vgsA2X8Sjq4rqgWmtWLwy8hKd3Y1GEHN+HUXJLyYkYEj/pSUZBb/kPA6ooSql7OkIDSe
         jttMI3ZUqsp0J9/wKdwzdonoUwjj8Zfy7Tya15+BXgUIgVoB9g71z9AQUrJDBo6UQCYj
         5DFgwbEIkkM+oVlsBYcHvjpWzIGW08cSf/O0tWV4bXIqN2gzmhvVx9K35aUlu/R0uSOp
         nXO9v4FMNPXzllyWqTGCXSHHfUBpugzS5vp/n31kSbyeteCoFr37s7OGttpopvSnasgO
         24RQ==
X-Gm-Message-State: AO0yUKVGxoly3ITANxtO/6+1+V9wnGZVfF0Uo8dPQqfwFYflgVpI/PDP
        AcJU8Dw5h0B+FGldmgWq+Ih2sQ==
X-Google-Smtp-Source: AK7set8V9Fqs6trOvhUW2rNiDUj3z7a1R5k34O15orz/UDYcujudEPAHsE6rEO85Glc49uzLAaJxNw==
X-Received: by 2002:a17:902:e84e:b0:19a:a815:2877 with SMTP id t14-20020a170902e84e00b0019aa8152877mr3242820plg.6.1676474673787;
        Wed, 15 Feb 2023 07:24:33 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id jh12-20020a170903328c00b0019682e27995sm6176997plb.223.2023.02.15.07.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:24:33 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/2] mm: memory_hotplug: drop memoryless node from fallback lists
Date:   Wed, 15 Feb 2023 23:24:12 +0800
Message-Id: <20230215152412.13368-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
References: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In offline_pages(), if a node becomes memoryless, we
will clear its N_MEMORY state by calling node_states_clear_node().
But we do this after rebuilding the zonelists by calling
build_all_zonelists(), which will cause this memoryless node to
still be in the fallback list of other nodes. This will incur
some runtime overhead.

To drop memoryless node from fallback lists in this case, just
call node_states_clear_node() before calling build_all_zonelists().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fd40f7e9f176..1a5e5e8f7e13 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1931,12 +1931,12 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
+	node_states_clear_node(node, &arg);
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
 	}
 
-	node_states_clear_node(node, &arg);
 	if (arg.status_change_nid >= 0) {
 		kcompactd_stop(node);
 		kswapd_stop(node);
-- 
2.20.1

