Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEBD6C4E85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCVOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCVOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:52:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052465C6A;
        Wed, 22 Mar 2023 07:50:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF90B20ED8;
        Wed, 22 Mar 2023 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679496626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/1b+lUImqchwctHYvwFdftZc6h6aA5n3zMAKNVMaV4=;
        b=IO3cQVGFlvqDW6ZyGcdGTEGcrVoU+lFnGGdVxdblELxXQ8C+7Mx9vYTG9ZyP81FIx3wFYP
        NxKky5I0KbMgrgW+ZD7PthJn5RhNsYe2ioG0lh81ggFZZtzGim+qv+SCd6xX6OgJpv0PFH
        zC5SdKHQnt/Ky7F5U6F/EeVl+2J6anY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679496626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/1b+lUImqchwctHYvwFdftZc6h6aA5n3zMAKNVMaV4=;
        b=+iAL7cCRrrBwt1PYzay5Usw9GyrCJmiAwc0v+DILaDEAHuDT3a+KJhTUXdWebqT/FpMVOq
        OK80Ln6U6IIYANCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5685138E9;
        Wed, 22 Mar 2023 14:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ch52K7IVG2RZNgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 14:50:26 +0000
Message-ID: <f7aa436a-4bf2-66d8-4742-0a724cb95797@suse.cz>
Date:   Wed, 22 Mar 2023 15:50:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 05/14] mm/page_alloc: rename page_alloc_init() to
 page_alloc_init_cpuhp()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-6-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230321170513.2401534-6-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 18:05, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The page_alloc_init() name is really misleading because all this
> function does is sets up CPU hotplug callbacks for the page allocator.
> 
> Rename it to page_alloc_init_cpuhp() so that name will reflect what the
> function does.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/gfp.h | 2 +-
>  init/main.c         | 2 +-
>  mm/page_alloc.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 7c554e4bd49f..ed8cb537c6a7 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -319,7 +319,7 @@ extern void page_frag_free(void *addr);
>  #define __free_page(page) __free_pages((page), 0)
>  #define free_page(addr) free_pages((addr), 0)
>  
> -void page_alloc_init(void);
> +void page_alloc_init_cpuhp(void);
>  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
>  void drain_all_pages(struct zone *zone);
>  void drain_local_pages(struct zone *zone);
> diff --git a/init/main.c b/init/main.c
> index 4425d1783d5c..b2499bee7a3c 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -969,7 +969,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	boot_cpu_hotplug_init();
>  
>  	build_all_zonelists(NULL);
> -	page_alloc_init();
> +	page_alloc_init_cpuhp();
>  
>  	pr_notice("Kernel command line: %s\n", saved_command_line);
>  	/* parameters may set static keys */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ff6a2fff2880..d1276bfe7a30 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6383,7 +6383,7 @@ static int page_alloc_cpu_online(unsigned int cpu)
>  	return 0;
>  }
>  
> -void __init page_alloc_init(void)
> +void __init page_alloc_init_cpuhp(void)
>  {
>  	int ret;
>  

