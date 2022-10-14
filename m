Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B59A5FEA83
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJNI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJNI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:26:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0349C1C2096
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:26:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 173A21F385;
        Fri, 14 Oct 2022 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665735971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVZ2D28KqKmtfNQ7aUXL9vYnFuIk40wXqGtavN6tqEk=;
        b=bDGBAkWOT0jebnqgPJJL817+/ZAPrXKn61UUAo10zWH24XtVaHSTj5OB/g7gsKxtYrG3m5
        8HNvEGGfqgIWhJtuKXOWMe14GLLBH/Pw8ZycUrK9to8xuyxN+GmFQkAsV6yLS56H5t1TDO
        IhaojZrQ/OTSwW5vdeKlVnIfMJNcRb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665735971;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVZ2D28KqKmtfNQ7aUXL9vYnFuIk40wXqGtavN6tqEk=;
        b=09DMyqdRV2BK8YnHrh2pDlpF9Nj0wQiiMMD5V7J82xQMTN6KGm7Rh3UbzKXNzTuMiOSr9G
        gmc4fdCtp4h4/hAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D832813A4A;
        Fri, 14 Oct 2022 08:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SlAcNCIdSWMHewAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Oct 2022 08:26:10 +0000
Message-ID: <25a1c9b8-a96c-fcfa-e275-410d62ddfdc2@suse.cz>
Date:   Fri, 14 Oct 2022 10:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm: slub: make slab_sysfs_init() a late_initcall
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 12:27, Rasmus Villemoes wrote:
> Currently, slab_sysfs_init() is an __initcall aka device_initcall. It
> is rather time-consuming; on my board it takes around 11ms. That's
> about 1% of the time budget I have from U-Boot letting go and until
> linux must assume responsibility of keeping the external watchdog
> happy.
> 
> There's no particular reason this would need to run at device_initcall
> time, so instead make it a late_initcall to allow vital functionality
> to get started a bit sooner.
> 
> This actually ends up winning more than just those 11ms, because the
> slab caches that get created during other device_initcalls (and before
> my watchdog device gets probed) now don't end up doing the somewhat
> expensive sysfs_slab_add() themselves. Some example lines (with
> initcall_debug set) before/after:
> 
> initcall ext4_init_fs+0x0/0x1ac returned 0 after 1386 usecs
> initcall journal_init+0x0/0x138 returned 0 after 517 usecs
> initcall init_fat_fs+0x0/0x68 returned 0 after 294 usecs
> 
> initcall ext4_init_fs+0x0/0x1ac returned 0 after 240 usecs
> initcall journal_init+0x0/0x138 returned 0 after 32 usecs
> initcall init_fat_fs+0x0/0x68 returned 0 after 18 usecs
> 
> Altogether, this means I now get to petting the watchdog around 17ms
> sooner. [Of course, the time the other initcalls save is instead spent
> in slab_sysfs_init(), which goes from 11ms to 16ms, so there's no
> overall change in boot time.]
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks, added to slab.git for-6.2/slub-sysfs

> ---
> 
> The numbers certainly suggest that someone might want to look into
> making sysfs/kobject/kset perform better. But that would be way more
> complicated than this patch, and could not possibly achieve the same
> win as getting the sysfs_slab_add() overhead completely out of the
> way.
> 
> 
>  mm/slub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4b98dff9be8e..dade5c84a7bb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6070,8 +6070,7 @@ static int __init slab_sysfs_init(void)
>  	mutex_unlock(&slab_mutex);
>  	return 0;
>  }
> -
> -__initcall(slab_sysfs_init);
> +late_initcall(slab_sysfs_init);
>  #endif /* CONFIG_SYSFS */
>  
>  #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)

