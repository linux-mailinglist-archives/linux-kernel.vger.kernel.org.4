Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F656ACAD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCFRkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCFRkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:40:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACE6A1D0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:39:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 331F31FDDD;
        Mon,  6 Mar 2023 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678124291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjsdVtOT19sgmnwLtBgOV0bQr30Doz68iTxFvJb7MVY=;
        b=iKZM4a3kjBj5igyGY9nYaFFnSsecXkdh5ETnei0KWtPfemR/f5AArLWkAJ4+Lg4TtIE0kl
        vUB6kadcOXfROHaa35OTTCCy1yWNEWmcg/Ms2e1M8gjrIm2RrgNQ1GNa7ht1TCwke30eAw
        1FfzsnYou26QuH3TIZzqY+mDnTm1v1U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1443D13513;
        Mon,  6 Mar 2023 17:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yRV7AQMlBmStdwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 06 Mar 2023 17:38:11 +0000
Date:   Mon, 6 Mar 2023 18:38:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm, vmalloc: fix high order __GFP_NOFAIL allocations
Message-ID: <ZAYlAvZ/e52/XSLi@dhcp22.suse.cz>
References: <20230305053035.1911-1-hsiangkao@linux.alibaba.com>
 <ZAWbjIJCarmxGa8k@dhcp22.suse.cz>
 <ZAXZMz0n+CpWPVqy@pc636>
 <ZAXynvdNqcI0f6Us@dhcp22.suse.cz>
 <6452176f-4c17-8e09-8561-c659cbea4014@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6452176f-4c17-8e09-8561-c659cbea4014@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. Here is an incremental diff
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bef6cf2b4d46..b01295672a31 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2938,7 +2938,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		/*
 		 * Higher order nofail allocations are really expensive and
 		 * potentially dangerous (pre-mature OOM, disruptive reclaim
-		 * and compaction etc.
+		 * and compaction etc).
 		 */
 		alloc_gfp &= ~__GFP_NOFAIL;
 		nofail = true;
@@ -2965,7 +2965,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 
 		/*
 		 * Higher order allocations must be able to be treated as
-		 * indepdenent small pages by callers (as they can with
+		 * independent small pages by callers (as they can with
 		 * small-page vmallocs). Some drivers do their own refcounting
 		 * on vmalloc_to_page() pages, some use page->mapping,
 		 * page->lru, etc.
-- 
Michal Hocko
SUSE Labs
