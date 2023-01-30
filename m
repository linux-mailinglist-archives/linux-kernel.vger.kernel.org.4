Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A517680F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjA3Ni2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjA3NiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:38:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB9F27495
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:38:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF0FE21AED;
        Mon, 30 Jan 2023 13:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675085902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/J2bGSJghp9M5TIZw+roMv7bi0bOHhh3HcKHIrzTDkM=;
        b=vVAbrU5OdjtdMJ/42bCdBOnnT+8SuWf4Ml/HbxmuUXxbZzbQkewavN0hVkF7Cw53Evbscn
        ol0RgV4prLk4oDG6MCWR0mnzdYrKxFCBKFe+MXimtt8Z9vz1wL54B7C54x9EibsztjIFJu
        qMGtpok+78AZUvA0lQx7QU6hyBwoe5o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB52213A06;
        Mon, 30 Jan 2023 13:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mwvMLE7I12MfYwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 30 Jan 2023 13:38:22 +0000
Date:   Mon, 30 Jan 2023 14:38:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: extend max struct page size for kmsan
Message-ID: <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
References: <20230130130739.563628-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130130739.563628-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-01-23 14:07:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After x86 has enabled support for KMSAN, it has become possible
> to have larger 'struct page' than was expected when commit
> 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b
> architectures") was merged:
> 
> include/linux/mm.h:156:10: warning: no case matching constant switch condition '96'
>         switch (sizeof(struct page)) {
> 
> Extend the maximum accordingly.
> 
> Fixes: 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b architectures")
> Fixes: 4ca8cc8d1bbe ("x86: kmsan: enable KMSAN builds for x86")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Michal Hocko <mhocko@suse.com>

I haven't really followed KMSAN development but I would have expected
that it would, like other debugging tools, add its metadata to page_ext
rather than page directly.

> ---
> This seems to show up extremely rarely in randconfig builds, but
> enough to trigger my build machine.
> 
> I saw a related discussion at [1] about raising MAX_STRUCT_PAGE_SIZE,
> but as I understand it, that needs to be addressed separately.
> 
> [1] https://lore.kernel.org/lkml/20220701142310.2188015-11-glider@google.com/
> ---
>  include/linux/mm.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b73ba2e5cfd2..aa39d5ddace1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -137,7 +137,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
>   * define their own version of this macro in <asm/pgtable.h>
>   */
>  #if BITS_PER_LONG == 64
> -/* This function must be updated when the size of struct page grows above 80
> +/* This function must be updated when the size of struct page grows above 96
>   * or reduces below 56. The idea that compiler optimizes out switch()
>   * statement, and only leaves move/store instructions. Also the compiler can
>   * combine write statements if they are both assignments and can be reordered,
> @@ -148,12 +148,18 @@ static inline void __mm_zero_struct_page(struct page *page)
>  {
>  	unsigned long *_pp = (void *)page;
>  
> -	 /* Check that struct page is either 56, 64, 72, or 80 bytes */
> +	 /* Check that struct page is either 56, 64, 72, 80, 88 or 96 bytes */
>  	BUILD_BUG_ON(sizeof(struct page) & 7);
>  	BUILD_BUG_ON(sizeof(struct page) < 56);
> -	BUILD_BUG_ON(sizeof(struct page) > 80);
> +	BUILD_BUG_ON(sizeof(struct page) > 96);
>  
>  	switch (sizeof(struct page)) {
> +	case 96:
> +		_pp[11] = 0;
> +		fallthrough;
> +	case 88:
> +		_pp[10] = 0;
> +		fallthrough;
>  	case 80:
>  		_pp[9] = 0;
>  		fallthrough;
> -- 
> 2.39.0

-- 
Michal Hocko
SUSE Labs
