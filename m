Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F5B65412F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiLVMmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLVMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:42:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA5FCC;
        Thu, 22 Dec 2022 04:42:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA3DA17BDE;
        Thu, 22 Dec 2022 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671712948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XmkqMDqoOV2vZvcbKcSsCfN2Q0eQg7RCp79KQBrfRkU=;
        b=dSEDo37e26q8wi6ingQFJVEw8ZwHEMXjmoJnlKx5yU0EpR8/7YJpcefHYY7HrMFSWB6lDt
        ycqha5Hk438wJBN8l31iaa6ZjoXMTfcfMzt8d4xt1jJqjk4w7T9mGQDqrByjlXPqi9U0Km
        o9hwyEGzg18Ii5EMC0HnilSgQgQFD14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671712948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XmkqMDqoOV2vZvcbKcSsCfN2Q0eQg7RCp79KQBrfRkU=;
        b=mSsqGeCLP8TAnnwN4OgzqnF0AAYUERoi+NMcROyY2OO72miZv8uYpXvAr4Kv8QeeyabLxI
        LvOBfeTtXTWOKNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC4B413918;
        Thu, 22 Dec 2022 12:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mBLbMbRQpGOCHQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 12:42:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 478E4A0732; Thu, 22 Dec 2022 13:42:28 +0100 (CET)
Date:   Thu, 22 Dec 2022 13:42:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, kbusch@kernel.org
Subject: Re: [PATCH RESEND v2 4/5] sbitmap: add sbitmap_find_bit to remove
 repeat code in __sbitmap_get/__sbitmap_get_shallow
Message-ID: <20221222124228.pt3x3yenrqi44dhr@quack3>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-5-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222143353.598042-5-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-12-22 22:33:52, Kemeng Shi wrote:
> There are three differences between __sbitmap_get and
> __sbitmap_get_shallow when searching free bit:
> 1. __sbitmap_get_shallow limit number of bit to search per word.
> __sbitmap_get has no such limit.
> 2. __sbitmap_get_shallow always searches with wrap set. __sbitmap_get set
> wrap according to round_robin.
> 3. __sbitmap_get_shallow always searches from first bit in first word.
> __sbitmap_get searches from first bit when round_robin is not set
> otherwise searches from SB_NR_TO_BIT(sb, alloc_hint).
> 
> Add helper function sbitmap_find_bit function to do common search while
> accept "limit depth per word", "wrap flag" and "first bit to
> search" from caller to support the need of both __sbitmap_get and
> __sbitmap_get_shallow.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

One style nit below, otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


> @@ -215,11 +211,32 @@ static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
>  		alloc_hint = 0;
>  		if (++index >= sb->map_nr)
>  			index = 0;
> +
>  	}

Pointless empty line here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
