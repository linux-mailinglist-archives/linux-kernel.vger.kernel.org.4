Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D169C644E31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLFVss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLFVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:48:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F093E0A5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:48:45 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47B7021C31;
        Tue,  6 Dec 2022 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670363324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eObdsh0f1WoSow7cySCAshfEk8V655iOUfOT8wA5uY=;
        b=XarreB7m60SF4+AcLNKNd2OUP5Rxq4StRg05ASDpWWcaMCdHSWg+2KAGp/bOcpp1buKqm2
        qbuo9W28yEkDZF7fG5zxFlSnZy41WYMQBI71qaJ3h/eFjcf/L9lCQes4uWhmqbhADmGPvK
        KxTmFOUv8uyTem0I8x0cni6INneOTuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670363324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eObdsh0f1WoSow7cySCAshfEk8V655iOUfOT8wA5uY=;
        b=862gYlhO+Lrnm8WSWXalMv6GF93TCP8bc6LZfvvVoVJBr/bxQYjgvv15eVqYaDeBDfj0Yo
        eSfPgMPGRFYbD8Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 28D5F13326;
        Tue,  6 Dec 2022 21:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KnMzCby4j2OTdAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 06 Dec 2022 21:48:44 +0000
Message-ID: <8a8f5758-365e-d716-de06-3963d7b7ec43@suse.cz>
Date:   Tue, 6 Dec 2022 22:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: do not show ?? for VM_LOCKONFAULT pages
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric B Munson <emunson@akamai.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221205173007.580210-1-Jason@zx2c4.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221205173007.580210-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 18:30, Jason A. Donenfeld wrote:
> When VM_LOCKONFAULT was added, /proc/PID/smaps wasn't hooked up to it,
> so looking at /proc/PID/smaps, it shows '??' instead of something
> intelligable. This can be reached by userspace by simply calling
> `mlock2(..., MLOCK_ONFAULT);`.
> 
> Fix this by adding "lf" to denote VM_LOCKONFAULT.
> 
> Cc: Eric B Munson <emunson@akamai.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Fixes: de60f5f10c58 ("mm: introduce VM_LOCKONFAULT")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  fs/proc/task_mmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8a74cdcc9af0..60851e96530b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -667,6 +667,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_RAND_READ)]	= "rr",
>  		[ilog2(VM_DONTCOPY)]	= "dc",
>  		[ilog2(VM_DONTEXPAND)]	= "de",
> +		[ilog2(VM_LOCKONFAULT)]	= "lf",
>  		[ilog2(VM_ACCOUNT)]	= "ac",
>  		[ilog2(VM_NORESERVE)]	= "nr",
>  		[ilog2(VM_HUGETLB)]	= "ht",

