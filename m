Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C265DFFB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbjADW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjADW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:29:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB64100C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:29:30 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w3so5787086ply.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=Hfe+MFjZwf4GhbRTb/n0MeBe4tDdfcoDltOF8kUyq95lxJGT1bmwJ3terbJbTvdYgA
         T3F2vtAqIapoYNnxHgXL0lEy0m6cDr2zwMiUrfMcr5ObyooUGPZ1ilXxaeYA5qBFI88V
         nUVNDLkDhMco0foAWAF5M5JeYAb4dCcZIGlpyUo6rILHOFH87NsUbwytwTdd5pvcFsqN
         lFl1ze5EfmtZWQyo53QWgSPHE6F1uUhN9rwM8TJ6WnLU+UDzyEsHEKE9IdB5VeUn4MLl
         NOme36sCBKuMJieR7fJ4Op2wc1uc1mtAzm8+vVY9BIw7ko2Brfs4RW5pG33DrfBjZdjF
         eVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=Z7u9b+OhK/8Uc2TDyJLtwWOypd9IMlxAep3l5aVefuwuR3oYNEzSWSRaBCjW9QPRF1
         KA9nAkKBfabp9NnvKkUBKfBs2LIGKj02RTaX/B3gdcnnCUMjNSYT+7OPQ/NsAVQy4Wlk
         knZ2zoywVy+JUiMookOjH2trr/8S33PXUW/YstJj26qfzFgVSOGRPh/bfoSsFID+BLlL
         2fKjBjHx8EjTfJxUv2Wh/ReXyDqHMIlNMrG7HJc2cpncq03ptP5wZ1Z4CtM1EP7OdK4L
         CO9AYBlK46ysnDB+O5LI3wa7PXD1GQBIqqe3nYY/kJYeWCeWUYTRGBmRJupEw+66WDdC
         bWsQ==
X-Gm-Message-State: AFqh2kriTA5YePTaNfepfMjfEBjmI/5PdPTdWO1VMIDy8bmfhkgaAw4V
        8uKbPJSCCAD7rPJkVpU6YCU=
X-Google-Smtp-Source: AMrXdXvjHO1/f6Sq+pgRKHHQ4iuZMwTMptCrxrPJngmrmRWnM+LMgeTWuvpeSQVWPX/ja0ASqBHniQ==
X-Received: by 2002:a17:902:ab85:b0:192:f469:5283 with SMTP id f5-20020a170902ab8500b00192f4695283mr2563352plr.3.1672871369638;
        Wed, 04 Jan 2023 14:29:29 -0800 (PST)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e1c900b001927ebc40e2sm19138025pla.193.2023.01.04.14.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:29:28 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH] workingset: fix confusion around eviction vs refault container
Date:   Wed,  4 Jan 2023 14:29:27 -0800
Message-Id: <20230104222927.2378210-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
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

From: Johannes Weiner <hannes@cmpxchg.org>

Refault decisions are made based on the lruvec where the page was
evicted, as that determined its LRU order while it was alive. Stats
and workingset aging must then occur on the lruvec of the new page, as
that's the node and cgroup that experience the refault and that's the
lruvec whose nonresident info ages out by a new resident page. Those
lruvecs could be different when a page is shared between cgroups, or
the refaulting page is allocated on a different node.

There are currently two mix-ups:

1. When swap is available, the resident anon set must be considered
   when comparing the refault distance. The comparison is made against
   the right anon set, but the check for swap is not. When pages get
   evicted from a cgroup with swap, and refault in one without, this
   can incorrectly consider a hot refault as cold - and vice
   versa. Fix that by using the eviction cgroup for the swap check.

2. The stats and workingset age are updated against the wrong lruvec
   altogether: the right cgroup but the wrong NUMA node. When a page
   refaults on a different NUMA node, this will have confusing stats
   and distort the workingset age on a different lruvec - again
   possibly resulting in hot/cold misclassifications down the line.

Fix the swap check and the refault pgdat to address both concerns.

This was found during code review. It hasn't caused notable issues in
production, suggesting that those refault-migrations are relatively
rare in practice.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Co-developed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/workingset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index ae7e984b23c6..79585d55c45d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -457,6 +457,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 */
 	nr = folio_nr_pages(folio);
 	memcg = folio_memcg(folio);
+	pgdat = folio_pgdat(folio);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
@@ -474,7 +475,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_INACTIVE_FILE);
 	}
-	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
+	if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
 		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_ACTIVE_ANON);
 		if (file) {
-- 
2.30.2
