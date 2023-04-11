Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F54B6DD29C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDKGSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjDKGSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:18:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560851986
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:18:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ie17-20020a17090b401100b00246d4b282eeso2080051pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681193890; x=1683785890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqsMqbvDS5QxxMg57RO5e5hW3sg0toXxEzCmNLhErn4=;
        b=dTr9g9fYGDe5Q1TMQqYfmPf/nqf/tcQ0TQt81AKB/681zSZSwsraTVaMcxYbKxz58k
         MQEaV0uxJ3MGq4/WIjZeS/SlX1yyiYL2CLW1xgxcvaLHvsu/HlTuSlS1UW6q9e09G3Kz
         Jh4F95W06FaFdix8IyC4W4ILMFsU6P2uJG2mwaSCPVak76VPFjR6HNGBUx1X0dTLyCuz
         2UMvZzJryD3MfAaDHUitSUPAQvD2b9i4rcv8ykBQ54wjuCs263HwN0QZW/NJpvxBmxFJ
         WQ4n6ufAXu93fzIbaKZAXFpnFrnXOHLSoSXET+7D4i4HD1LQnyW6dUWUiquRaW2/NiXg
         SdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681193890; x=1683785890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqsMqbvDS5QxxMg57RO5e5hW3sg0toXxEzCmNLhErn4=;
        b=04ZGO6vfT/XpM2R+SGQiEqDUuU7sMD9cgkhVBGNAmPFEarglCjJSSjv3/aqPMRe9x4
         aT0HdJAf6GNSn3cT0CbIPAKmJxpOFTa68CYHD8jXG1uED7hlj9v/trBsViTJCbWhJYfw
         uiafSGuSTq8cpgSECs2L6yUarTvwYR7xZ3VBZf7vvuBUEfT/5vyVj3/G8KhTAmf6Sws2
         hU5l9N30Fyy/NSBZNEKLyfFVs4KjZTgzbY0fA/XqTCbn2ADT6JAkwzq9YI8qT+omq4H4
         tk+zZ445y6pmBWZt9kcIxrSyF3HsY1ml8KIQb7qSvs0YoDURrRdTciPxyhvtSQgwsVQy
         vLdw==
X-Gm-Message-State: AAQBX9cgP56PI3bq9rbJv/2N4TGDMrZfemJ4gpMtn6mSd7ZfhKBhP8sg
        Yf9pCod/TuoJJDaKESLtvlxo9g==
X-Google-Smtp-Source: AKy350bg11o+dXIS5dKvMfOAeCQT/Iep+crKcwYO7Uvf0zwtpYVEFqEAozETHZiksP8Hnvm2SxWKjA==
X-Received: by 2002:a17:90b:3845:b0:240:883:8ff8 with SMTP id nl5-20020a17090b384500b0024008838ff8mr17957570pjb.3.1681193889742;
        Mon, 10 Apr 2023 23:18:09 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id nl6-20020a17090b384600b0023faa95f75csm10191290pjb.36.2023.04.10.23.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:18:09 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH RESEND] mm/vmscan: simplify shrink_node()
Date:   Tue, 11 Apr 2023 06:17:57 +0000
Message-Id: <20230411061757.12041-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The difference between sc->nr_reclaimed and nr_reclaimed is computed
three times. Introduce a new variable to record the value, so it only
needs to be computed once.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/vmscan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..b86573104974 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6451,7 +6451,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
-	unsigned long nr_reclaimed, nr_scanned;
+	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 
@@ -6477,13 +6477,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		reclaim_state->reclaimed_slab = 0;
 	}
 
+	nr_node_reclaimed = sc->nr_reclaimed - nr_reclaimed;
+
 	/* Record the subtree's reclaim efficiency */
 	if (!sc->proactive)
 		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
-			   sc->nr_scanned - nr_scanned,
-			   sc->nr_reclaimed - nr_reclaimed);
+			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
 
-	if (sc->nr_reclaimed - nr_reclaimed)
+	if (nr_node_reclaimed)
 		reclaimable = true;
 
 	if (current_is_kswapd()) {
@@ -6545,8 +6546,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
 
-	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
-				    sc))
+	if (should_continue_reclaim(pgdat, nr_node_reclaimed, sc))
 		goto again;
 
 	/*
-- 
2.25.1

