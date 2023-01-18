Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6728670EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjARAmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjARAla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:30 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFA33B67A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:44 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4d4b54d0731so215769497b3.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTRJVqBDkGUHWO7WMmajNVElkfX34x7nOoLfAt9+bEQ=;
        b=EX4UN/0eFUWIexqbQBRbpsGvA8KNCkS9OA2NXANeTD6ptgjqai35FyeOaIlNA+FBeT
         Cnm1APiNeCIgthHh2iELTziFYadXwmKI+My466IFRjTf/8YHjX/qU076qk38a1evmlWx
         9cOBrA43RLYgGR0khB9BTTTnuGuKySesuafSPYRMecz6/nmWTUyMMYSArHGqmlT0Lqvp
         18oLpRY+JKlwBTFpzRAjjAaW5oIyD/R7ryPOJioSA9lpHAZcpz2CvjjALChgEZLHXOM7
         SoqMJT034sFZS2SsfMRRiWjeQ3w338ooV2rbafg3XxSq36dYpf7Y7Qlv8xp/0Z4MLaY/
         8dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTRJVqBDkGUHWO7WMmajNVElkfX34x7nOoLfAt9+bEQ=;
        b=ECmhb/TiKXSZPq9FmAoV7nNggFFrlItUwRSplg1rLZ0cbX+QHY6nIYbRU0QK85i5va
         X3Z8gYpS+1x9pxJKZX73Q54JRY62lQyd3095vKPkLitxQPVhL27N+J3XQDYUUG3EXJfd
         s+3MSFWLb48iXVAnWEctGlNJqHKr4YSko5AOAlpx6iwbYqDarzj0K1NOtTLdeplpoZrX
         fv8TiXjS5X/ALnn3EvzigPcKUdP55YOR2wh2a/a4JzuWEXQHRGPx14OoXl7+YV2Fm5TG
         3oUJvG1sJDmkrX2zcAT2yZWSllG1X/c7f5F6TOerRhAiURL+XoI76bS+0OfGJI60LVf9
         bfpQ==
X-Gm-Message-State: AFqh2koqTorviGJj1HiU5vqZ/ewqOdab86Q8VF/iKqvOcQx5UceCQ4dS
        pggOi7ex4befzLERHWOZfLm4HK9xR4dV/w==
X-Google-Smtp-Source: AMrXdXtD7bqi98Yh7h2wUwVBLNMYi2DQaFvYeFfYECMq032GE0MLbvHBZdI0aQprknrCs8TdSBeXA1M9DG39IQ==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a25:6089:0:b0:7b4:6882:d442 with SMTP id
 u131-20020a256089000000b007b46882d442mr579253ybb.429.1674001123956; Tue, 17
 Jan 2023 16:18:43 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:18:22 +0000
In-Reply-To: <20230118001827.1040870-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230118001827.1040870-1-talumbau@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230118001827.1040870-3-talumbau@google.com>
Subject: [PATCH mm-unstable v1 2/7] mm: multi-gen LRU: section for rmap/PT
 walk feedback
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section for lru_gen_look_around() in the code and the design
doc.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 Documentation/mm/multigen_lru.rst | 14 ++++++++++++++
 mm/vmscan.c                       |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/mm/multigen_lru.rst b/Documentation/mm/multigen_lru.rst
index 6e1483e70fdc..bd988a142bc2 100644
--- a/Documentation/mm/multigen_lru.rst
+++ b/Documentation/mm/multigen_lru.rst
@@ -156,6 +156,20 @@ This time-based approach has the following advantages:
    and memory sizes.
 2. It is more reliable because it is directly wired to the OOM killer.
 
+Rmap/PT walk feedback
+---------------------
+Searching the rmap for PTEs mapping each page on an LRU list (to test
+and clear the accessed bit) can be expensive because pages from
+different VMAs (PA space) are not cache friendly to the rmap (VA
+space). For workloads mostly using mapped pages, searching the rmap
+can incur the highest CPU cost in the reclaim path.
+
+``lru_gen_look_around()`` exploits spatial locality to reduce the
+trips into the rmap. It scans the adjacent PTEs of a young PTE and
+promotes hot pages. If the scan was done cacheline efficiently, it
+adds the PMD entry pointing to the PTE table to the Bloom filter. This
+forms a feedback loop between the eviction and the aging.
+
 Summary
 -------
 The multi-gen LRU can be disassembled into the following parts:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a741765896b6..eb9263bf6806 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4569,6 +4569,10 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	}
 }
 
+/******************************************************************************
+ *                          rmap/PT walk feedback
+ ******************************************************************************/
+
 /*
  * This function exploits spatial locality when shrink_folio_list() walks the
  * rmap. It scans the adjacent PTEs of a young PTE and promotes hot pages. If
-- 
2.39.0.314.g84b9a713c41-goog

