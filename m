Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4476C6C503A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCVQKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCVQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:10:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D2C136FB;
        Wed, 22 Mar 2023 09:10:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3B533CCD;
        Wed, 22 Mar 2023 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679501410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+7eyTKeVn1sl0E1m2LZkECMl7RTMp0jt5zZuoqxsew=;
        b=UvU8A7W2avxjunPSL/m9XAmogri1XixdGqLj+DBNKVOD0L07rFrG2jTryRX9BvxuqWx+qv
        GhuA27cWKfkYQnbgQJiLelw8eHrykrPOhoFt9GwHiqbzUh7lLlg3y0CEALMkLhkkG4VzAO
        KSn+bmx8CE3l9VKh7mLK2TJKP41Vas0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679501410;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+7eyTKeVn1sl0E1m2LZkECMl7RTMp0jt5zZuoqxsew=;
        b=pFtujWUPfcX+V8RK3RYZdmSAUw6NzcCwQFRSbCSR0ziPmuupZpSCXyE6okiXw0rEZUsPlR
        CZoVYZtJPHd8ATBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C15E13416;
        Wed, 22 Mar 2023 16:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q47WEWIoG2TIZQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 16:10:10 +0000
Message-ID: <f712fa24-91f7-38e7-fd6e-b33ab52ce88c@suse.cz>
Date:   Wed, 22 Mar 2023 17:10:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 06/14] init: fold build_all_zonelists() and
 page_alloc_init_cpuhp() to mm_init()
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
 <20230321170513.2401534-7-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230321170513.2401534-7-rppt@kernel.org>
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
> Both build_all_zonelists() and page_alloc_init_cpuhp() must be called
> after SMP setup is complete but before the page allocator is set up.
> 
> Still, they both are a part of memory management initialization, so move
> them to mm_init().

Well, logic grouping is one thing, but not breaking a functional order is
more important. So this moves both calls to happen later than theyw ere. I
guess it could only matter for page_alloc_init_cpuhp() in case cpu hotplugs
would be processed in some of the calls we "skipped" over by moving this
later. And one of them is setup_arch()... so are we sure no arch does some
cpu hotplug for non-boot cpus there?

> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  init/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index b2499bee7a3c..4423906177c1 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -833,6 +833,10 @@ static void __init report_meminit(void)
>   */
>  static void __init mm_init(void)
>  {
> +	/* Initializations relying on SMP setup */
> +	build_all_zonelists(NULL);
> +	page_alloc_init_cpuhp();
> +
>  	/*
>  	 * page_ext requires contiguous pages,
>  	 * bigger than MAX_ORDER unless SPARSEMEM.
> @@ -968,9 +972,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
>  	boot_cpu_hotplug_init();
>  
> -	build_all_zonelists(NULL);
> -	page_alloc_init_cpuhp();
> -
>  	pr_notice("Kernel command line: %s\n", saved_command_line);
>  	/* parameters may set static keys */
>  	jump_label_init();

