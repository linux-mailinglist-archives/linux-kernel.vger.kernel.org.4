Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0CA6AB745
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCFHvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCFHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:51:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3784D1E1E5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:51:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D341D21D66;
        Mon,  6 Mar 2023 07:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678089101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2m309QEoxNkbd3Zt8B9KYqe2aoELZppDrass+pnAeo=;
        b=LLPtpMVsajSSJ4yVb53aLeKTUMdZu/9uZTdN2XZv/62JSX4KVNR02Mnj8krSRXe8cC/pn7
        LPclrsCaRv6kls6gxqiMNMRt3YSnvqPsr2GIxe/ZdOr8jmm5wHTm+nSMdLJj/Bmrnthl9l
        Oxi46gjcoM1SitnsC0KUY13BsJT3Ntk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B46F313A66;
        Mon,  6 Mar 2023 07:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yapeKY2bBWQeNAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 06 Mar 2023 07:51:41 +0000
Date:   Mon, 6 Mar 2023 08:51:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: avoid high-order page allocation warn
 with __GFP_NOFAIL
Message-ID: <ZAWbjIJCarmxGa8k@dhcp22.suse.cz>
References: <20230305053035.1911-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305053035.1911-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc couple of more people recently involved with vmalloc code]

On Sun 05-03-23 13:30:35, Gao Xiang wrote:
> My knowledge of this is somewhat limited, however, since vmalloc already
> supported __GFP_NOFAIL in commit 9376130c390a ("mm/vmalloc: add
> support for __GFP_NOFAIL").  __GFP_NOFAIL could trigger the following
> stack and allocate high-order pages when CONFIG_HAVE_ARCH_HUGE_VMALLOC
> is enabled:
> 
>  __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
>  alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
>  vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
>
>  __vmalloc_area_node mm/vmalloc.c:3057 [inline]
>  __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
>  kvmalloc_node+0x156/0x1a0 mm/util.c:606
>  kvmalloc include/linux/slab.h:737 [inline]
>  kvmalloc_array include/linux/slab.h:755 [inline]
>  kvcalloc include/linux/slab.h:760 [inline]
>  (codebase: Linux 6.2-rc2)
> 
> Don't warn such cases since high-order pages with __GFP_NOFAIL is
> somewhat legel.

OK, this is definitely a bug and it seems my 9376130c390a was
incomplete because it hasn't covered the high order case. Not sure how
that happened but removing the warning is not the right thing to do
here. The higher order allocation is an optimization rather than a must.
So it is perfectly fine to fail that allocation and retry rather than
go into a very expensive and potentially impossible higher order
allocation that must not fail.

The proper fix should look like this unless I am missing something. I
would appreciate another pair of eyes on this because I am not fully
familiar with the high order optimization part much.

Thanks!
--- 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ef910bf349e1..a8aa2765618a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2883,6 +2883,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
+	gfp_t alloc_gfp = gfp;
+	bool nofail = false;
 	struct page *page;
 	int i;
 
@@ -2931,20 +2933,30 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
+	} else {
+		alloc_gfp &= ~__GFP_NOFAIL;
+		nofail = true;
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
-
 	while (nr_allocated < nr_pages) {
 		if (fatal_signal_pending(current))
 			break;
 
 		if (nid == NUMA_NO_NODE)
-			page = alloc_pages(gfp, order);
+			page = alloc_pages(alloc_gfp, order);
 		else
-			page = alloc_pages_node(nid, gfp, order);
-		if (unlikely(!page))
-			break;
+			page = alloc_pages_node(nid, alloc_gfp, order);
+		if (unlikely(!page)) {
+			if (!nofail)
+				break;
+
+			/* fall back to the zero order allocations */
+			alloc_gfp |= __GFP_NOFAIL;
+			order = 0;
+			continue;
+		}
+
 		/*
 		 * Higher order allocations must be able to be treated as
 		 * indepdenent small pages by callers (as they can with
-- 
Michal Hocko
SUSE Labs
