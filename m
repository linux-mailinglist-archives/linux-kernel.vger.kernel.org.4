Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9270FDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjEXSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjEXSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:19:16 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 11:19:08 PDT
Received: from smtp-lb.pixar.com (smtp-lb.pixar.com [138.72.247.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00702E47
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:19:08 -0700 (PDT)
DomainKey-Signature: s=emeryville; d=pixar.com; c=nofws; q=dns;
  h=Authentication-Results:IronPort-SDR:X-PixarMID:
   X-PixarRecvListener:X-PixarRemoteIP:X-PixarMailFlowPolicy:
   Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
   MIME-Version:Content-Transfer-Encoding;
  b=d1j/4YnC+mVvTtW7b3uSZjWpcsNFVh9Y3rggMUxn2rnE5NbtE8FOGnS5
   aPNPzIeAjIRempRcFZuZY6VwxgLEE0UnLG3wONdp9wIVUQV58Qc390y6Z
   UG7OSoYO9ovNreTTkE4Yn7zCEKoFXj8p6aKbh5VVXenaPUz21+C2fWn23
   NhWMv71pmHsyius6Tw5G6y4OjhkilIzzXG/REuYzB0Vsq7FBCIqtJTZij
   lsRG16OuY3JZqKJGyWlEAv52k237aDVlaOU8uDs8ITJegU6U59ZY4y6Hm
   41Nj7gYunXZx+ae6iwc7VgeJ0n+HZqjUmw0+bnSQRmas8i61Eap7gxCSy
   w==;
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=pixar.com; i=@pixar.com; q=dns/txt; s=dkimdefault;
  t=1684952348; x=1716488348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ww88k/sRfXor8CGXgyhHTr6O6My3nfazkW6nHTYMUoE=;
  b=fHnFefEvF0bbH0frkbR6r20UGIwhKiyLDDc0bDmTswmj6w/g7xK3oJfm
   dYYVFFuL27hrPFApW6XIJEKFiKwFOHXUMb9iICLgorst7maptfBmNQ5db
   GuaypsXuO0qkQzGQBZgPpBbS9xMNcqyoTXrjpCMGpJFVoLjmHeS3Tn86H
   0DSodqrwtjnqzJpWAUZVJ/PQgU4eXjDkGqFSp7JX5HTqOK/gJstWkEIM/
   Lh6XzhLhykRd2sWp7UPmPoJXzM7dIXZRwcb4o5LlysIz6pRCRqT5GE19O
   01IFz/s4O+9ecg4dt/ZWg1G+Gh7SC+/LZzFeOUVHKBqkVLCyyuKReXzSF
   Q==;
Authentication-Results: smtp-lb.pixar.com; dkim=none (message not signed) header.i=none
IronPort-SDR: Uzb3RSa/vzGo8sU7GYm5MeSjCugi8B7FA1VjUyt3kXYw31N9HCzMXHDZpzskXLstM8+drU6fYk
 jblJdBUQLRRw==
X-PixarMID: 33424248
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.53.70
X-PixarMailFlowPolicy: $RELAYED
Received: by belboz.pixar.com (Postfix, from userid 1690)
        id 63EC8601DB34; Wed, 24 May 2023 11:18:04 -0700 (PDT)
From:   "Lars R. Damerow" <lars@pixar.com>
To:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, muchun.song@linux.dev, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, lars@pixar.com
Subject: [PATCH] mm/memcontrol: export memcg.swap watermark via sysfs for v2 memcg
Date:   Wed, 24 May 2023 11:17:33 -0700
Message-Id: <20230524181734.125696-1-lars@pixar.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is similar to commit 8e20d4b33266 ("mm/memcontrol: export
memcg->watermark via sysfs for v2 memcg"), but exports the swap counter's
watermark.

We allocate jobs to our compute farm using heuristics determined by memory
and swap usage from previous jobs. Tracking the peak swap usage for new
jobs is important for determining when jobs are exceeding their expected
bounds, or when our baseline metrics are getting outdated.

Our toolset was written to use the "memory.memsw.max_usage_in_bytes" file
in cgroups v1, and altering it to poll cgroups v2's "memory.swap.current"
would give less accurate results as well as add complication to the code.
Having this watermark exposed in sysfs is much preferred.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
 mm/memcontrol.c                         | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f67c0829350b..1ffe019483ac 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1582,6 +1582,13 @@ PAGE_SIZE multiple when read back.
 
 	Healthy workloads are not expected to reach this limit.
 
+  memory.swap.peak
+	A read-only single value file which exists on non-root
+	cgroups.
+
+	The max swap usage recorded for the cgroup and its
+	descendants since the creation of the cgroup.
+
   memory.swap.max
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..1862fee15274 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7656,6 +7656,14 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
 }
 
+static u64 swap_peak_read(struct cgroup_subsys_state *css,
+			  struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return (u64)memcg->swap.watermark * PAGE_SIZE;
+}
+
 static int swap_high_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -7734,6 +7742,11 @@ static struct cftype swap_files[] = {
 		.seq_show = swap_max_show,
 		.write = swap_max_write,
 	},
+	{
+		.name = "swap.peak",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = swap_peak_read,
+	},
 	{
 		.name = "swap.events",
 		.flags = CFTYPE_NOT_ON_ROOT,

base-commit: 9d646009f65d62d32815f376465a3b92d8d9b046
-- 
2.39.2

