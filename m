Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5533B688390
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjBBP6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjBBP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:58:27 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75BC7D283
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:57:29 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id k18so1228398qvm.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IcK2j7GaecPZ1Vx44z6AigZg/DHMEIHlEpQ2CSXmGNM=;
        b=0/2QcsVnBHC20DmS2GdpIB11iAxP9z1WAI7Y8vitVSx3DLYzJM2Yap61ooPAdTvQ4q
         6zU45QD9XPGJ9qh9EXvxA0vwy6ap0T+oeZtY4OHAkqmn7NF5bF+ci2FkIN57tcMuT8Cj
         qdmgblY3QKvKhbbDgPQhgpoIWKPDxp3A1mA/1WXAhGY+Jbzhq0TNnLoK1kYzgyfE6gvs
         B6ZDalOl0eVh2kgFGsonC2DbI9vwH4laWAp2OkcqNZbB5BKsiJ/uHHgxcuuyL/CDAKRo
         U/Iw2hQ+ONWFW22h4t20EWnb/CLcg4oCnPZyaQC//Z12zJBJkX4sd9HWdXQnJM7+Ldjv
         Vr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcK2j7GaecPZ1Vx44z6AigZg/DHMEIHlEpQ2CSXmGNM=;
        b=ENzBy93pCeO9Rgu37xa53p///sPLG2pWgo1xygD9rsq86xBFCY+Qsv3ir2XGnBR4Aq
         /fz7Nneuh7kbJpcnIwkywdsy3LcA8GR0oTM03dWYjJTeZDlm+ZOfNSEhjgIJ2EEd2E7j
         v+wJF0gELfVKf2wOMIcvupD6GKKC7jWKM5/8PbuCxEhf4KFPQI52n0IIWGj1WWvuYe2D
         NxK3QzFm0mHw9ptm8Hu844dHYFUXOPHFaUN/nzRvQEkPyUWcTtvtBCsox2nZgM3VYnUE
         0Y9/4S8GlYiVpW14KfqSSN/PnXitoZiPV0UeC7560plJIAlt5AQSMbXaehbv+9x3il3n
         8r9A==
X-Gm-Message-State: AO0yUKUqFXXYTGUkcN1VkhQe2lJ8KxhErwwSKMIWPlpycHnM3rF2bg4/
        hfApNFTU0nXaY7acTQX7NA3vCA==
X-Google-Smtp-Source: AK7set/JFU+snISJEv3RhRVGviz46AiF1b1OLNWcNoUU+KaFBG5vpNUKkelttsvbOGif1nFM9oGDow==
X-Received: by 2002:a05:6214:4202:b0:542:adcb:60d7 with SMTP id nd2-20020a056214420200b00542adcb60d7mr8723122qvb.39.1675353387251;
        Thu, 02 Feb 2023 07:56:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:c833])
        by smtp.gmail.com with ESMTPSA id w14-20020a05620a444e00b0071f0054b094sm8692489qkp.43.2023.02.02.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:56:26 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: [RFC PATCH] mm: memcontrol: don't account swap failures not due to cgroup limits
Date:   Thu,  2 Feb 2023 10:56:26 -0500
Message-Id: <20230202155626.1829121-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.1
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

Christian reports the following situation in a cgroup that doesn't
have memory.swap.max configured:

  $ cat memory.swap.events
  high 0
  max 0
  fail 6218

Upon closer examination, this is an ARM64 machine that doesn't support
swapping out THPs. In that case, the first get_swap_page() fails, and
the kernel falls back to splitting the THP and swapping the 4k
constituents one by one. /proc/vmstat confirms this with a high rate
of thp_swpout_fallback events.

While the behavior can ultimately be explained, it's unexpected and
confusing. I see three choices how to address this:

a) Specifically exlude THP fallbacks from being counted, as the
   failure is transient and the memory is ultimately swapped.

   Arguably, though, the user would like to know if their cgroup's
   swap limit is causing high rates of THP splitting during swapout.

b) Only count cgroup swap events when they are actually due to a
   cgroup's own limit. Exclude failures that are due to physical swap
   shortage or other system-level conditions (like !THP_SWAP). Also
   count them at the level where the limit is configured, which may be
   above the local cgroup that holds the page-to-be-swapped.

   This is in line with how memory.swap.high, memory.high and
   memory.max events are counted.

   However, it's a change in documented behavior.

c) Leave it as is. The documentation says system-level events are
   counted, so stick to that.

   This is the conservative option, but isn't very user friendly.
   Cgroup events are usually due to a local control choice made by the
   user. Mixing in events that are beyond the user's control makes it
   difficult to id root causes and configure the system properly.

Implement option b).

Reported-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 +++---
 mm/memcontrol.c                         | 12 +++++-------
 mm/swap_slots.c                         |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c8ae7c897f14..a8ffb89a4169 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1605,9 +1605,9 @@ PAGE_SIZE multiple when read back.
 		failed.
 
 	  fail
-		The number of times swap allocation failed either
-		because of running out of swap system-wide or max
-		limit.
+
+		The number of times swap allocation failed because of
+		the max limit.
 
 	When reduced under the current usage, the existing swap
 	entries are reclaimed gradually and the swap usage may stay
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab457f0394ab..c2a6206ce84b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7470,17 +7470,15 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	if (!memcg)
 		return 0;
 
-	if (!entry.val) {
-		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		return 0;
-	}
-
 	memcg = mem_cgroup_id_get_online(memcg);
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
-		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
-		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
+		struct mem_cgroup *swap_over_limit;
+
+		swap_over_limit = mem_cgroup_from_counter(counter, swap);
+		memcg_memory_event(swap_over_limit, MEMCG_SWAP_MAX);
+		memcg_memory_event(swap_over_limit, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
 		return -ENOMEM;
 	}
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0bec1f705f8e..66076bd60e2b 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -342,7 +342,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 
 	get_swap_pages(1, &entry, 1);
 out:
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
+	if (entry.val && mem_cgroup_try_charge_swap(folio, entry) < 0) {
 		put_swap_folio(folio, entry);
 		entry.val = 0;
 	}
-- 
2.39.1

