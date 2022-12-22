Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78A653EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiLVLXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiLVLXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:23:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF181EE;
        Thu, 22 Dec 2022 03:23:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19E9223940;
        Thu, 22 Dec 2022 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671708200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7//GWIteFgH1E0ImEj9IrbM2aYh4kFVO4zFsnlVSG0=;
        b=TsbymAibCwFsC0kzQbs0g54rk6xYAfYEj5MIFHZeX5X5+OOYIakazt1cJXV7uEi3qmcHux
        8IDBoOVHPykhxPuClSrfKWnrAUw8jOY4uYtyp/oB0/RZCLQ1WlDGqXMun5fQCQNfkAs3kM
        dDqQBB5w+X+MFpasnHVksH6JJrmjD5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671708200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7//GWIteFgH1E0ImEj9IrbM2aYh4kFVO4zFsnlVSG0=;
        b=ARBTYnbj+oCFe2R0D9NbmqK4FVwODoDm/qByVjoYBv4ovWcb7TqR3KgBOjBu3xhL4Lqhh2
        En4zaFhH1uNAulAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BD01138FD;
        Thu, 22 Dec 2022 11:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o43WAig+pGOoeAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 11:23:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 73E47A0732; Thu, 22 Dec 2022 12:23:19 +0100 (CET)
Date:   Thu, 22 Dec 2022 12:23:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, kbusch@kernel.org
Subject: Re: [PATCH RESEND v2 2/5] sbitmap: remove redundant check in
 __sbitmap_queue_get_batch
Message-ID: <20221222112319.26wtwxeyry6ybvse@quack3>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222143353.598042-3-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-12-22 22:33:50, Kemeng Shi wrote:
> Commit fbb564a557809 ("lib/sbitmap: Fix invalid loop in
> __sbitmap_queue_get_batch()") mentioned that "Checking free bits when
> setting the target bits. Otherwise, it may reuse the busying bits."
> This commit add check to make sure all masked bits in word before
> cmpxchg is zero. Then the existing check after cmpxchg to check any
> zero bit is existing in masked bits in word is redundant.
> 
> Actually, old value of word before cmpxchg is stored in val and we
> will filter out busy bits in val by "(get_mask & ~val)" after cmpxchg.
> So we will not reuse busy bits methioned in commit fbb564a557809
> ("lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()"). Revert
> new-added check to remove redundant check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

...

> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index cb5e03a2d65b..11e75f4040fb 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -518,11 +518,9 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>  
>  			get_mask = ((1UL << nr_tags) - 1) << nr;
>  			val = READ_ONCE(map->word);
> -			do {
> -				if ((val & ~get_mask) != val)
> -					goto next;
> -			} while (!atomic_long_try_cmpxchg(ptr, &val,
> -							  get_mask | val));
> +			while (!atomic_long_try_cmpxchg(ptr, &val,
> +							  get_mask | val))
> +				;
>  			get_mask = (get_mask & ~val) >> nr;
>  			if (get_mask) {
>  				*offset = nr + (index << sb->shift);

So I agree this will result in correct behavior but it can change
performance. In the original code, we end up doing
atomic_long_try_cmpxchg() only for words where we have a chance of getting
all tags allocated. Now we just accept any word where we could allocate at
least one bit. Frankly the original code looks rather restrictive and also
the fact that we look only from the first zero bit in the word looks
unnecessarily restrictive so maybe I miss some details about what's
expected from __sbitmap_queue_get_batch(). So all in all I wanted to point
out this needs more scrutiny from someone understanding better expectations
from __sbitmap_queue_get_batch().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
