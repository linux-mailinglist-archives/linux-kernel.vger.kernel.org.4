Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E66ED095
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDXOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjDXOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:48:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8C09EE5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:47:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84FF521A79;
        Mon, 24 Apr 2023 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682347670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EguKY0cZkMrWGDpyRY3VFx21djInsbc1dIZ4hVv8EFY=;
        b=tDVTM+Y0Ku93kVfp41sWODCyjfiJELTwbHKXXk71xwzQbDIjzQ93oVmk2UDwEELuUhXYuL
        mjo3dmHGoeyyqetHmuEQATcarlO7LSJyr19J3q/uYzDMrI080elHambvdLgQms2l5eqkmI
        aJE5FqMq4TMc/4g16jncNzibKW0DKrs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EE8F1390E;
        Mon, 24 Apr 2023 14:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CilcFJaWRmQCTAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 24 Apr 2023 14:47:50 +0000
Date:   Mon, 24 Apr 2023 16:47:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
Message-ID: <ZEaWlf/EanQGN2FV@dhcp22.suse.cz>
References: <c3868b58c6714c09a43440d7d02c7b4eed6e03f6.1682342634.git.baolin.wang@linux.alibaba.com>
 <50b5e05dbb007e3a969ac946bc9ee0b2b77b185f.1682342634.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50b5e05dbb007e3a969ac946bc9ee0b2b77b185f.1682342634.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-04-23 21:45:40, Baolin Wang wrote:
> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
> checks whether the given zone contains holes, and uses pfn_to_online_page()
> to validate if the start pfn is online and valid, as well as using pfn_valid()
> to validate the end pfn.
> 
> However, the __pageblock_pfn_to_page() function may return non-NULL even
> if the end pfn of a pageblock is in a memory hole in some situations. For
> example, if the pageblock order is MAX_ORDER, which will fall into 2
> sub-sections, and the end pfn of the pageblock may be hole even though
> the start pfn is online and valid.
> 
> See below memory layout as an example and suppose the pageblock order
> is MAX_ORDER.
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000001fa3c7ffff]
> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7dfffff]
> 
> Focus on the last memory range, and there is a hole for the range [mem
> 0x0000001fa7590000-0x0000001fa7dfffff]. That means the last pageblock
> will contain the range from 0x1fa7c00000 to 0x1fa7ffffff, since the
> pageblock must be 4M aligned. And in this pageblock, these pfns will
> fall into 2 sub-section (the sub-section size is 2M aligned).
> 
> So, the 1st sub-section (indicates pfn range: 0x1fa7c00000 -
> 0x1fa7dfffff ) in this pageblock is valid by calling subsection_map_init()
> in free_area_init(), but the 2nd sub-section (indicates pfn range:
> 0x1fa7e00000 - 0x1fa7ffffff ) in this pageblock is not valid.
> 
> This did not break anything until now, but the zone continuous is fragile
> in this possible scenario. So as previous discussion[1], it is better to
> add some comments to explain this possible issue in case there are some
> future pfn walkers that rely on this.
> 
> [1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Changes from v2:
>  - Update the commit log and comments per Michal, thanks.
> Changes from v1:
>  - Update the comments per Ying and Mike, thanks.
> 
> Note, I did not add Huang Ying's reviewed tag, since there are some
> updates per Michal's suggestion. Ying, please review the v3. Thanks.
> ---
>  mm/page_alloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6457b64fe562..bd124390c79b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1502,6 +1502,15 @@ void __free_pages_core(struct page *page, unsigned int order)
>   * interleaving within a single pageblock. It is therefore sufficient to check
>   * the first and last page of a pageblock and avoid checking each individual
>   * page in a pageblock.
> + *
> + * Note: the function may return non-NULL struct page even for a page block
> + * which contains a memory hole (i.e. there is no physical memory for a subset
> + * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
> + * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
> + * even though the start pfn is online and valid. This should be safe most of
> + * the time because struct pages are still zero pre-filled and pfn walkers
> + * shouldn't touch any physical memory range for which they do not recognize
> + * any specific metadata in struct pages.
>   */
>  struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>  				     unsigned long end_pfn, struct zone *zone)
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
