Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D521640280
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiLBIud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiLBIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:50:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C69B0A28
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:50:28 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BC3C1FE16;
        Fri,  2 Dec 2022 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669971027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZIm84O2bOoJ4U2lQJhS8k8kVVfk2BSguwHQiEl9M5c=;
        b=bUk3okfzs0YoxvvN5f+8+xRn5zpW4Gi8OmvjTDMX8cYsCbH0Vu7ctaHt/1juowu6cw8hR5
        11ok1o+tPH4vwlJ/kIIWjQScvYCPvPQjQdw8BoPTom8tZJMJ0GlXr0gWN8dICTztWxDfKY
        tz0fTw31190RQHEkhH9cA3w4QatgETI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E0DC9133DE;
        Fri,  2 Dec 2022 08:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id c4f6M1K8iWMiMgAAGKfGzw
        (envelope-from <mhocko@suse.com>); Fri, 02 Dec 2022 08:50:26 +0000
Date:   Fri, 2 Dec 2022 09:50:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Eric Dumazet <edumazet@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kselftests: cgroup: update kmem test precision tolerance
Message-ID: <Y4m8Unt6FhWKC6IH@dhcp22.suse.cz>
References: <202212010958.c1053bd3-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212010958.c1053bd3-yujie.liu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so this is a full patch to fix this
--- 
From 7f338ed952ba4a100822004bc8399bf720b42899 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 2 Dec 2022 09:45:29 +0100
Subject: [PATCH] kselftests: cgroup: update kmem test precision tolerance

1813e51eece0 ("memcg: increase MEMCG_CHARGE_BATCH to 64") has changed
the batch size while this test case has been left behind. This has led
to a test failure reported by test bot:
not ok 2 selftests: cgroup: test_kmem # exit=1

Update the tolerance for the pcp charges to reflect the
MEMCG_CHARGE_BATCH change to fix this.

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202212010958.c1053bd3-yujie.liu@intel.com
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 tools/testing/selftests/cgroup/test_kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 22b31ebb3513..1d073e28254b 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -24,7 +24,7 @@
  * the maximum discrepancy between charge and vmstat entries is number
  * of cpus multiplied by 32 pages.
  */
-#define MAX_VMSTAT_ERROR (4096 * 32 * get_nprocs())
+#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
 
 
 static int alloc_dcache(const char *cgroup, void *arg)
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
