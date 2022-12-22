Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6516540F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiLVMXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:23:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B8183A1;
        Thu, 22 Dec 2022 04:23:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CD0023F5A;
        Thu, 22 Dec 2022 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671711805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JGTVKFyl7otLKEdjkOD52Fmznj6uU0nVNnmSn793tAk=;
        b=ebc79wn6DbK3kVuFjy9swBJvtyl4OQWVss7W+FNKFwSaDjUw06NgRIjdDUwAoQblIjxFJL
        Qk9gQhi6xsj+Cs4E7kdysnOEeuenvXy70g7Lf/U4kHtawjp5rvIJgd1EAOCr74YziEuuu5
        +8wPll0KgxZd7V3mffcRmuSFTz39ORA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671711805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JGTVKFyl7otLKEdjkOD52Fmznj6uU0nVNnmSn793tAk=;
        b=9KjJTaXlAMvAfodKWoN03cpnHjb7DygV2UslSmnTVGdEb2CRTvaBJWQVaOmQituM5XfQDX
        z5SRr00hYTiCo1Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E97813918;
        Thu, 22 Dec 2022 12:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fz38Gj1MpGNsFQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 12:23:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 001F9A0732; Thu, 22 Dec 2022 13:23:24 +0100 (CET)
Date:   Thu, 22 Dec 2022 13:23:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, kbusch@kernel.org
Subject: Re: [PATCH RESEND v2 3/5] sbitmap: rewrite sbitmap_find_bit_in_index
 to reduce repeat code
Message-ID: <20221222122324.z3sueeqwc26pqeh5@quack3>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-4-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222143353.598042-4-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-12-22 22:33:51, Kemeng Shi wrote:
> Rewrite sbitmap_find_bit_in_index as following:
> 1. Rename sbitmap_find_bit_in_index to sbitmap_find_bit_in_word
> 2. Accept "struct sbitmap_word *" directly instead of accepting
> "struct sbitmap *" and "int index" to get "struct sbitmap_word *".
> 3. Accept depth/shallow_depth and wrap for __sbitmap_get_word from caller
> to support need of both __sbitmap_get_shallow and __sbitmap_get.
> 
> With helper function sbitmap_find_bit_in_word, we can remove repeat
> code in __sbitmap_get_shallow to find bit considring deferred clear.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  lib/sbitmap.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Just one style nit below. Please fix that up. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 11e75f4040fb..3f7e276a427d 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -167,15 +167,16 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>  	return nr;
>  }
>  
> -static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
> -				     unsigned int alloc_hint)
> +static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
> +				    unsigned int depth,
> +				    unsigned int alloc_hint,
> +				    bool wrap)
>  {
> -	struct sbitmap_word *map = &sb->map[index];
>  	int nr;
>  
>  	do {
> -		nr = __sbitmap_get_word(&map->word, __map_depth(sb, index),
> -					alloc_hint, !sb->round_robin);
> +		nr = __sbitmap_get_word(&map->word, depth,
> +					alloc_hint, wrap);
>  		if (nr != -1)
>  			break;
>  		if (!sbitmap_deferred_clear(map))
> @@ -203,7 +204,8 @@ static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
>  		alloc_hint = 0;
>  
>  	for (i = 0; i < sb->map_nr; i++) {
> -		nr = sbitmap_find_bit_in_index(sb, index, alloc_hint);
> +		nr = sbitmap_find_bit_in_word(&sb->map[index], __map_depth(sb, index),

Please avoid lines over 80 characters.

> +					      alloc_hint, !sb->round_robin);
>  		if (nr != -1) {
>  			nr += index << sb->shift;
>  			break;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
