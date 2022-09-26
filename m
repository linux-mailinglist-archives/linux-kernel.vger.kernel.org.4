Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE665EAA00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiIZPPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiIZPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:14:19 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE557D1CC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:57:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c19so4099221qkm.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nxWlvz8nHKxF79bLiRXoWvFCmNni5yV7mxHmCxzwA1c=;
        b=Pm8S7GcSFRJWTzik7LhbfogyC+//ZqsABilFvcQgI1rbJfqhpFRdanL1+GHXzprwnB
         rX2IGIitEbL0wUDSi9cTNbod47SaPSyBy1s2M/5H5oBEUnarJed+X2kV8S+NiGjcxDM2
         vyiCvtjy2NTBluE9HJcH16mhvyA2bKbIXJVu1otPRo9tqdUIPRMnydMZ/oIzuoWf11ut
         +nM6kLfw8XCbjB5tY3+nupim51GjwAgoM6PbDihvDKfLcwrDvb6/cuOqvgB8YzwSaOsa
         psRi+d0w+GC+hRxyaO6MjNfx63poKtPW1lqwUQp53OOsA/8Eh8fpODIaU+m2krXZThHf
         NCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nxWlvz8nHKxF79bLiRXoWvFCmNni5yV7mxHmCxzwA1c=;
        b=uoyufhJC9lKhVDXJYBw5GBC44eHiUSflejDsQcAJQYm7oTAQqbC68iy2tIbxX5511e
         fqB8XDOW5StX6Ol7y0st7ZUS8PmFifk9dS7Hm0VopRrhRdyIybBK+sMdEq2nKFRKW4hj
         DTjyaWZGvK2BCCFSLClYCFU3f8/GilCt45wJhoDY7+/r8HW/lb3cQ8/ZJ7SGQKCqiVpl
         Il9bGn4BKsMnF9aj7I73izCs/bPIhno5HsgWsN4fTe48t1u8fUkn3HyXuhlpWABxu2w2
         SJl08CK1EwA3JgphdKnRDLPjn7LLusdNSDKzk2WiE2XC+TyKg8003upiIiIBPU6HhHpt
         Kywg==
X-Gm-Message-State: ACrzQf26SqnUQjGX5pkS98mgWL7N5tNLWSEiroAE2HbcF2JmQrtLI0ED
        joMIhL0/vL2sK/lSf53YtG29uQ==
X-Google-Smtp-Source: AMsMyM5O56YPOTRdHT3lUuv+iV2e4l+65dldttI4qaDrt0US4VeJH9VyMv8TwUNBtUP9qPXPOLlhbA==
X-Received: by 2002:a05:620a:1b9b:b0:6cf:3c66:8e47 with SMTP id dv27-20020a05620a1b9b00b006cf3c668e47mr14337449qkb.478.1664200636452;
        Mon, 26 Sep 2022 06:57:16 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id k15-20020a05620a0b8f00b006cf3592cc20sm10804639qkh.55.2022.09.26.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:57:16 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm: memcontrol: use do_memsw_account() in a few more places
Date:   Mon, 26 Sep 2022 09:57:03 -0400
Message-Id: <20220926135704.400818-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926135704.400818-1-hannes@cmpxchg.org>
References: <20220926135704.400818-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's slightly more descriptive and consistent with other places that
distinguish cgroup1's combined memory+swap accounting scheme from
cgroup2's dedicated swap accounting.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4be1b48b9659..76bb0a18a2f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1667,17 +1667,17 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
 	unsigned long max = READ_ONCE(memcg->memory.max);
 
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
-		if (mem_cgroup_swappiness(memcg))
-			max += min(READ_ONCE(memcg->swap.max),
-				   (unsigned long)total_swap_pages);
-	} else { /* v1 */
+	if (do_memsw_account()) {
 		if (mem_cgroup_swappiness(memcg)) {
 			/* Calculate swap excess capacity from memsw limit */
 			unsigned long swap = READ_ONCE(memcg->memsw.max) - max;
 
 			max += min(swap, (unsigned long)total_swap_pages);
 		}
+	} else {
+		if (mem_cgroup_swappiness(memcg))
+			max += min(READ_ONCE(memcg->swap.max),
+				   (unsigned long)total_swap_pages);
 	}
 	return max;
 }
@@ -7334,7 +7334,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	if (mem_cgroup_disabled())
 		return;
 
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (!do_memsw_account())
 		return;
 
 	memcg = folio_memcg(folio);
@@ -7399,7 +7399,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (do_memsw_account())
 		return 0;
 
 	memcg = folio_memcg(folio);
@@ -7451,10 +7451,10 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	memcg = mem_cgroup_from_id(id);
 	if (memcg) {
 		if (!mem_cgroup_is_root(memcg)) {
-			if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
-				page_counter_uncharge(&memcg->swap, nr_pages);
-			else
+			if (do_memsw_account())
 				page_counter_uncharge(&memcg->memsw, nr_pages);
+			else
+				page_counter_uncharge(&memcg->swap, nr_pages);
 		}
 		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
 		mem_cgroup_id_put_many(memcg, nr_pages);
-- 
2.37.3

