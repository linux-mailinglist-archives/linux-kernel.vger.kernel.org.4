Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31406E1ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDNIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDNIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:55:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2E5B98
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:55:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0F521FD96;
        Fri, 14 Apr 2023 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681462505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+b1nXR1/twCQQQ/roM9DsodBpfN4oiR4RlY92NuwKQQ=;
        b=fDrjVW3Fui9s9OCo1q3Z+4UE/rSwhTrGKrI/XGr8Mvl5ceC3tLTvGu/UYWOBvDVpRitixz
        RAvLnlQ1mrDgcCzHQcLuKEek+iPjvHn3YkXzrlL7zM67RBcHXIP8+jojJ3g2Ti3595Pp72
        tEchRF7u4bCA29jpNRLNTEd181bobJo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C57813498;
        Fri, 14 Apr 2023 08:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 42f5EOkUOWQteAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 14 Apr 2023 08:55:05 +0000
Date:   Fri, 14 Apr 2023 10:55:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Assume huge tail pages are valid when
 allocating contiguous pages
Message-ID: <ZDkU6PuuDsUb82lr@dhcp22.suse.cz>
References: <20230414082222.idgw745cgcduzy37@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414082222.idgw745cgcduzy37@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-04-23 09:22:22, Mel Gorman wrote:
[...]
> +
> +		/*
> +		 * Do not migrate huge pages that span the size of the region
> +		 * being allocated contiguous. e.g. Do not migrate a 1G page
> +		 * for a 1G allocation request. CMA is an exception as the
> +		 * region may be reserved for hardware that requires physical
> +		 * memory without a MMU or scatter/gather capability.
> +		 *
> +		 * Note that the compound check is race-prone versus
> +		 * free/split/collapse but it should be safe and result in
> +		 * a premature skip or a useless migration attempt.
> +		 */
> +		if (PageHuge(page) && compound_nr(page) >= nr_pages &&
> +		    !is_migrate_cma_page(page)) {
> +			return false;

Is the CMA check working as expected? The function sounds quite generic
and I agree that it would make sense if it was generic but it is used
only for GB pages in fact and unless I am missing something it would
allow to migrate CMA pages and potentially allocate over that region
without any possibility to migrate GB page out so the CMA region would
be essentially unusable for CMA users. GB pages already have their CMA
allocator path before we get to alloc_contig_pages. Or do I miss
something?
-- 
Michal Hocko
SUSE Labs
