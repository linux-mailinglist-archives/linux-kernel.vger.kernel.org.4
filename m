Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461A68D627
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjBGMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBGMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:07:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285128234;
        Tue,  7 Feb 2023 04:07:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCFE45CBF5;
        Tue,  7 Feb 2023 12:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675771666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CAfqXTufQznFjzhKxR7PAIm3C3B6UZDzbiw7yiAREMw=;
        b=VZFiUfNNdjmPvjQvN9ZnRDc2vawwD0QLarQoib6R1AlHM3DLSqrW3BqzO+7Ud0EV1gLtlY
        ZO6MalUoQ0/m22MdIReQBalw1DZyMFkyjgJgUwuLS3oh/YzuisYMyhlfxQCkgdIlbCjvn7
        LkNafCxIg8oLsYLkm4K/vP7MqpufN5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675771666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CAfqXTufQznFjzhKxR7PAIm3C3B6UZDzbiw7yiAREMw=;
        b=w34l+R3o07EJwIRemq5DlfK2QqjTmEtdQaPS6+Adqey0Xl9FRXPmZFKfDrxG4Tzlyz9vn/
        Y2x2V51zq7nVL7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBC3A139ED;
        Tue,  7 Feb 2023 12:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z4tJLRI/4mOyTgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Feb 2023 12:07:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C8EB7A06D5; Tue,  7 Feb 2023 13:07:45 +0100 (CET)
Date:   Tue, 7 Feb 2023 13:07:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] udf: Use unsigned variables for size calculations
Message-ID: <20230207120745.56r6ok4llwr2sz7t@quack3>
References: <20230204183427.never.856-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204183427.never.856-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-02-23 10:34:27, Kees Cook wrote:
> To avoid confusing the compiler about possible negative sizes, switch
> various size variables that can never be negative from int to u32. Seen
> with GCC 13:
> 
> ../fs/udf/directory.c: In function 'udf_copy_fi':
> ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 80 and size [-2147483648, -1] [-Warray-bounds=]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ...
> ../fs/udf/directory.c:102:9: note: in expansion of macro 'memcpy'
>   102 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
>       |         ^~~~~~
> 
> Cc: Jan Kara <jack@suse.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Sigh. OK, applied but I really wish gcc was more clever because the
arithmetics making sure we cannot see negative values there is literaly in
two lines above the memcpy...

								Honza

> ---
>  fs/udf/directory.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 2e13c4b5fb81..e0bb73d414dd 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -71,8 +71,9 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
>  static int udf_copy_fi(struct udf_fileident_iter *iter)
>  {
>  	struct udf_inode_info *iinfo = UDF_I(iter->dir);
> -	int blksize = 1 << iter->dir->i_blkbits;
> -	int err, off, len, nameoff;
> +	u32 blksize = 1 << iter->dir->i_blkbits;
> +	u32 off, len, nameoff;
> +	int err;
>  
>  	/* Skip copying when we are at EOF */
>  	if (iter->pos >= iter->dir->i_size) {
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
