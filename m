Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214AF653EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiLVLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiLVLBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:01:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE9B1AF08;
        Thu, 22 Dec 2022 03:01:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF4C023DB3;
        Thu, 22 Dec 2022 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671706876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+dl7G0GNCLu0gu0DfO0iUTy26W+/XjzsHbrb8CbzRc=;
        b=wJoYsMpHUmp1D1l4OW8CTdcaRSlzma2fTZQeVgxaAu6kl7miE+wJPwMe9dY+p2+037rdCB
        ylBBryZVMWvHEC6UZloVe3u2j5SeLKK0XQbPX2qc4MWnnQCdKyqLTzReDvKUWUPj+3iMyz
        trJDh+KhDO3N0gNQdLMqj7oAQ+EcTEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671706876;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+dl7G0GNCLu0gu0DfO0iUTy26W+/XjzsHbrb8CbzRc=;
        b=Pz6m/+ddKEnsEXmjXsTEUsWWsyO6oY/5VlF7PSFJvXz08DSUb+40qS6mUJfc717D/Zsguv
        WZAfRYicDl1Oc+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D49613918;
        Thu, 22 Dec 2022 11:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TdlYJvw4pGM2bwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 11:01:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2A6F3A0732; Thu, 22 Dec 2022 12:01:16 +0100 (CET)
Date:   Thu, 22 Dec 2022 12:01:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, kbusch@kernel.org
Subject: Re: [PATCH RESEND v2 1/5] sbitmap: remove unnecessary calculation of
 alloc_hint in __sbitmap_get_shallow
Message-ID: <20221222110116.mpxvoiiok24yxsgd@quack3>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222143353.598042-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-12-22 22:33:49, Kemeng Shi wrote:
> We calculate allow_hint in next word as following:
> 
> /* low sb->shift bit of alloc_hint will be 0 after this shift */
> alloc_hint = index << sb->shift;
> 
> /* get low sb->shift bit of alloc_hit */
> SB_NR_TO_BIT(sb, alloc_hint)
> 
> So alloc_hit in next word will always be zero. Simpfy alloc_hit calculation
> in __sbitmap_get_shallow according to the alloc_hit calculation in
> __sbitmap_get.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me, nice cleanup. I'd just somewhat rephrase the changelog
to:

Updates to alloc_hint in the loop in __sbitmap_get_shallow() are mostly
pointless and equivalent to setting alloc_hint to zero (because
SB_NR_TO_BIT() considers only low sb->shift bits from alloc_hint). So
simplify the logic.

Anyway, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  lib/sbitmap.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 586deb333237..cb5e03a2d65b 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -243,6 +243,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
>  	int nr = -1;
>  
>  	index = SB_NR_TO_INDEX(sb, alloc_hint);
> +	alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
>  
>  	for (i = 0; i < sb->map_nr; i++) {
>  again:
> @@ -250,7 +251,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
>  					min_t(unsigned int,
>  					      __map_depth(sb, index),
>  					      shallow_depth),
> -					SB_NR_TO_BIT(sb, alloc_hint), true);
> +					alloc_hint, true);
>  		if (nr != -1) {
>  			nr += index << sb->shift;
>  			break;
> @@ -260,13 +261,9 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
>  			goto again;
>  
>  		/* Jump to next index. */
> -		index++;
> -		alloc_hint = index << sb->shift;
> -
> -		if (index >= sb->map_nr) {
> +		alloc_hint = 0;
> +		if (++index >= sb->map_nr)
>  			index = 0;
> -			alloc_hint = 0;
> -		}
>  	}
>  
>  	return nr;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
