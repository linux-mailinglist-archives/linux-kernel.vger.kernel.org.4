Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE164B8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiLMPlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiLMPlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:41:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019911834A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:41:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4CE8D1FDAE;
        Tue, 13 Dec 2022 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670946071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=hZHHLXA3S9Kbf2JRMvqBzSTM8rtSEvTfbtQDdV3liug=;
        b=QrGlBWEJKe2JGY12pd07OU2dSw6YPyobFQF9jHRi9mlDwHetfE3brIYzrrYOBjXg7zLOuk
        lksp7w1AYQah06bSaZNXj2rD6nTXILeGqlkVDxAw7APO94ovtECr8kJB21vYREfDbZQkK3
        d06cZXzHYaT1gL3v9QW6l638CANOfwI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E43C138EE;
        Tue, 13 Dec 2022 15:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1nMPCRedmGMyHgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 13 Dec 2022 15:41:11 +0000
Date:   Tue, 13 Dec 2022 16:41:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: memcg reclaim demotion wrt. isolation
Message-ID: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have just noticed that that pages allocated for demotion targets
includes __GFP_KSWAPD_RECLAIM (through GFP_NOWAIT). This is the case
since the code has been introduced by 26aa2d199d6f ("mm/migrate: demote
pages during reclaim"). I suspect the intention is to trigger the aging
on the fallback node and either drop or further demote oldest pages.

This makes sense but I suspect that this wasn't intended also for
memcg triggered reclaim. This would mean that a memory pressure in one
hierarchy could trigger paging out pages of a different hierarchy if the
demotion target is close to full.

I haven't really checked at the current kswapd wake up checks but I
suspect that kswapd would back off in most cases so this shouldn't
really cause any big problems. But I guess it would be better to simply
not wake kswapd up for the memcg reclaim. What do you think?
---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8fcc5fa768c0..1f3161173b85 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1568,7 +1568,7 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
  * Folios which are not demoted are left on @demote_folios.
  */
 static unsigned int demote_folio_list(struct list_head *demote_folios,
-				     struct pglist_data *pgdat)
+				     struct pglist_data *pgdat, bool cgroup_reclaim)
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
@@ -1589,6 +1589,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	if (list_empty(demote_folios))
 		return 0;
 
+	/* local memcg reclaim shouldn't directly reclaim from other memcgs */
+	if (cgroup_reclaim)
+		mtc->gfp_mask &= ~__GFP_RECLAIM;
+
 	if (target_nid == NUMA_NO_NODE)
 		return 0;
 
@@ -2066,7 +2070,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */
 
 	/* Migrate folios selected for demotion */
-	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
+	nr_reclaimed += demote_folio_list(&demote_folios, pgdat, cgroup_reclaim(sc));
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
 		/* Folios which weren't demoted go back on @folio_list for retry: */
-- 
Michal Hocko
SUSE Labs
