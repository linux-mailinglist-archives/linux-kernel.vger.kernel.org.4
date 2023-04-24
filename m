Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7C6D0E76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjC3TSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjC3TSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:18:08 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA5EB52
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:18:07 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n15-20020a170902f60f00b001a273a4a685so3198465plg.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXlZsArwPDY7OuU2BxzeoXG1UXSoglEAfUQ5EzzMXG4=;
        b=QmYQM+j13cdbjBiZy3Y+dzkJUgGOVHTdr9lvDbSE859fYaJtq+8zmH02RDaKbdpvap
         CqejHKuoW/4IBz5mIHOf6Y8AHa6GMb/hCZ7zMABh1AePaLkgpcjAyzU7xGg8rQCDHyuT
         xd/GhSCAHuv9H/zwirCUR2wyGX+B6mkWwB9WVRwD19bK9qyHzg7+GCXy42vkNiRXXZdr
         kN4hOyhVE2VLeXDBEBRHB8fSA0RE0BkgU+jq32E4Jq+3xIhGwrpX/kGZ92PdxYBPFxyB
         8OgXFYA1yB1rgGnRYxUqB9CL2/ZWFsevIT5f1UxupCOTzAHu4BNZEW/BqlkhNKD16qxi
         CoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXlZsArwPDY7OuU2BxzeoXG1UXSoglEAfUQ5EzzMXG4=;
        b=qvTi/aMtpKB6w2CpMin1BuoekJqIsfvRt1hUhLEkBy8Gj+ykRmaamt2vRStS1G3sSP
         S2v5Z32CL42p+uKEnfxbbqegA4AT7f1imV5WPj57/QJEMfTcnsD6nSJMXyptWkndOYAM
         HdjxR8Jf9tmnZKQ75poPq6F1+y9wXNeVSp2Gv4Ivc0jFerl8o4MHXOcMUFbrbbgGDvqR
         +og+K/aFJaRUpc6DBiR4DVlbP6T6XPhEgq3aqTo5CFz/Husr13Ru3zl6Ab1bWfYTrNwy
         CzMsVieyjHjJsRiZ88wSJtlcdwt/9HKgNEjUjQC/IEMGMEEwcKUFTkhfdgedGbtWwih1
         iM2g==
X-Gm-Message-State: AAQBX9fOfEGT+KHmVtFWyZOC1cxdfK6yMO8foq13BRQn5lN8mDaH7MJg
        ams6FKOAM/YFQ4bVuYCJZguCnpUukmDHp1/O
X-Google-Smtp-Source: AKy350acDpkb2oKWRJtDPrvhJr6G7w3aWGLRFehCl/mgbnA6nqxhni7pGTt+2Eb5S7HVMulqi96jSmdvt00VgGJt
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:ec11:b0:237:9cbe:22ad with SMTP
 id l17-20020a17090aec1100b002379cbe22admr7641616pjy.5.1680203887352; Thu, 30
 Mar 2023 12:18:07 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:17:55 +0000
In-Reply-To: <20230330191801.1967435-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330191801.1967435-3-yosryahmed@google.com>
Subject: [PATCH v3 2/8] memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
but this is actually sometimes flushing directly from the callsite.

What it's doing is ratelimited calls. A better name would be
mem_cgroup_flush_stats_ratelimited().

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 2 +-
 mm/workingset.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b6eda2ab205d..ac3f3b3a45e2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1037,7 +1037,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_delayed(void);
+void mem_cgroup_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1535,7 +1535,7 @@ static inline void mem_cgroup_flush_stats(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_delayed(void)
+static inline void mem_cgroup_flush_stats_ratelimited(void)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0205e58ea430..c3b6aae78901 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -653,7 +653,7 @@ void mem_cgroup_flush_stats(void)
 		__mem_cgroup_flush_stats();
 }
 
-void mem_cgroup_flush_stats_delayed(void)
+void mem_cgroup_flush_stats_ratelimited(void)
 {
 	if (time_after64(jiffies_64, flush_next_time))
 		mem_cgroup_flush_stats();
diff --git a/mm/workingset.c b/mm/workingset.c
index 00c6f4d9d9be..af862c6738c3 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -462,7 +462,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
-	mem_cgroup_flush_stats_delayed();
+	mem_cgroup_flush_stats_ratelimited();
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.40.0.348.gf938b09366-goog

