Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74F72564D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbjFGHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbjFGHrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:47:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256FA10DE;
        Wed,  7 Jun 2023 00:45:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D90C11FDA7;
        Wed,  7 Jun 2023 07:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686123943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuzBLDH+6vBS19qokiGMN61hDvOG3cixMFx4ZnGpwsY=;
        b=ZDkJ+wP8Mk1V/Gd6g8XOWPnH7eQTgy7RacOhnKeA+SsDIxenMOIUXFebEOuHd6KqQ427io
        LoBSLRjHgMr4kPdRG1+i/MFd9BGqm+aR/V7Hx4IG/9u48F2p+Lm6lsBKbjqhhGmlEiINZi
        R8q+PDmS/Ej5gskkjY+fqjtEXyedPgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686123943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuzBLDH+6vBS19qokiGMN61hDvOG3cixMFx4ZnGpwsY=;
        b=zyDAsG/SWmg9baJajNBw87o4keZirFobvvi8GI83urryWwLZAiL3l/gXexud90fOb/yXui
        zM0qgtsA2dzdZ3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A983F13776;
        Wed,  7 Jun 2023 07:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AqTkJ6c1gGRlKQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 07 Jun 2023 07:45:43 +0000
Message-ID: <571c997a-0f26-4076-f5c4-cf2aacd36e90@suse.cz>
Date:   Wed, 7 Jun 2023 09:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/mprotect: Fix do_mprotect_pkey() limit check
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jeff Xu <jeffxu@chromium.org>, stable@vger.kernel.org
References: <20230606182912.586576-1-Liam.Howlett@oracle.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230606182912.586576-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/23 20:29, Liam R. Howlett wrote:
> The return of do_mprotect_pkey() can still be incorrectly returned as
> success if there is a gap that spans to or beyond the end address passed
> in.  Update the check to ensure that the end address has indeed been
> seen.
> 
> Link: https://lore.kernel.org/all/CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com/
> Fixes: 82f951340f25 ("mm/mprotect: fix do_mprotect_pkey() return on error")
> Reported-by: Jeff Xu <jeffxu@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mprotect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 92d3d3ca390a..c59e7561698c 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -867,7 +867,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  	}
>  	tlb_finish_mmu(&tlb);
>  
> -	if (!error && vma_iter_end(&vmi) < end)
> +	if (!error && tmp < end)
>  		error = -ENOMEM;
>  
>  out:
