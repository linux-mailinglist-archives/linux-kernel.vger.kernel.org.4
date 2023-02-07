Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0410B68D714
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjBGMo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjBGMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:44:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607FAF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:44:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC6DA5D644;
        Tue,  7 Feb 2023 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675773888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bV88dT2qNkupACeymYc17iJHiiwWQyH4efqPn1zs0d8=;
        b=dQMeq2LIBcaH/jMfwb4KHF/JsoykIOlr2T8Xt+ggiU84R6mAOgwb1DztKxUkWn6cXeTLtv
        MLFWCLKYdi4sAe+pohyYO+gE8uh2IalrnzNkDNX5jfLXkyH9C/6L6HYn7jGHtWAy+3z7ER
        b69d2eQv1nPmRVaCSTRChRCR9B+1JnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675773888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bV88dT2qNkupACeymYc17iJHiiwWQyH4efqPn1zs0d8=;
        b=OVcb4/DjvSCy7umjnR7qcqCRTch+exzIC/3eL1Oq3maoYXf8A3VADqiMVyVGxr6wfRntwf
        XxEuN+seP9xB9MDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD60313467;
        Tue,  7 Feb 2023 12:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J49DKsBH4mOLXgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Feb 2023 12:44:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7879DA06D5; Tue,  7 Feb 2023 13:44:47 +0100 (CET)
Date:   Tue, 7 Feb 2023 13:44:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] udf: KASAN: slab-out-of-bounds in udf_readdir
Message-ID: <20230207124447.jneehkows3ksulgq@quack3>
References: <20230206162206.845488-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206162206.845488-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-02-23 19:22:06, Vladislav Efanov wrote:
> The KASAN report is:
> [ 1922.586560] BUG: KASAN: slab-out-of-bounds in udf_readdir+0xe00/0x19e0
> [ 1922.586922] Write of size 89 at addr ffff888000cd9ea6 by task rm/18493
> 
> udf_readdir() tries to write file name out of allocated memory
> buffer bounds. The UDF_NAME_LEN_CS0 (255) is used as max length
> for file name in udf_put_filename(). But UDF_NAME_LEN (254) is
> used as the size for buffer allocation in udf_readdir(). As the
> result out-of-bounds write happened.
> 
> Found by Linux Verification Center (linuxtesting.org) with xfstests
> 
> Fixes: 066b9cded00b ("udf: Use separate buffer for copying split names")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>

Thanks for the fix Vladislav! But this code is not there anymore in current
version of UDF code. It got fixed as part of the directory code rewrite -
you can check current code state in my tree:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next

								Honza

> ---
>  fs/udf/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/dir.c b/fs/udf/dir.c
> index be640f4b2f2c..b95607c42ad4 100644
> --- a/fs/udf/dir.c
> +++ b/fs/udf/dir.c
> @@ -169,7 +169,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
>  				nameptr = (char *)(fibh.ebh->b_data + poffset - lfi);
>  			} else {
>  				if (!copy_name) {
> -					copy_name = kmalloc(UDF_NAME_LEN,
> +					copy_name = kmalloc(UDF_NAME_LEN_CS0,
>  							    GFP_NOFS);
>  					if (!copy_name) {
>  						ret = -ENOMEM;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
