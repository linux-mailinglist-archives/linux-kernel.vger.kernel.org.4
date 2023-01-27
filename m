Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0409A67E64C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjA0NNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjA0NNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:13:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A397F6AE;
        Fri, 27 Jan 2023 05:12:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6787D1FEB5;
        Fri, 27 Jan 2023 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674825103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fouNxxkFzjTHgVQFqjDkni86KspMvUxxLQyIG+dvBKk=;
        b=XU3VUITe7xgI/ueB5adJntRQa4zbWfZzZUKxFZ5pyWuP74NvGMG7CrKr4ao/juv/enTyCC
        yo7aDZvNC6a+llpCeya2u3H2QSgPvHtdN1g+/NTRf87S7RlL51jHYLZkhrTVjIKQkTD0YO
        MTI+MXGLTgialQmVaJl2zysKIaWDxOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674825103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fouNxxkFzjTHgVQFqjDkni86KspMvUxxLQyIG+dvBKk=;
        b=LStxQp8ywYuZfWfMBCzbwXGOauoYI+eTLWojM+CnzZkrsfbl/5UxwFmNSO34FQ7X+xZHJU
        VpTLm7GGTTk9x9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56F451336F;
        Fri, 27 Jan 2023 13:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Di08FY/N02N+GQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 27 Jan 2023 13:11:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B31CEA06B4; Fri, 27 Jan 2023 14:11:42 +0100 (CET)
Date:   Fri, 27 Jan 2023 14:11:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230127131142.yrlel7df3yvp56rx@quack3>
References: <20230127165912.0e4a7b66@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127165912.0e4a7b66@canb.auug.org.au>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27-01-23 16:59:12, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> fs/udf/inode.c: In function 'udf_writepages':
> fs/udf/inode.c:211:48: error: passing argument 3 of 'write_cache_pages' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   211 |         return write_cache_pages(mapping, wbc, udf_adinicb_writepage, NULL);
>       |                                                ^~~~~~~~~~~~~~~~~~~~~
>       |                                                |
>       |                                                int (*)(struct page *, struct writeback_control *, void *)
> In file included from fs/udf/inode.c:36:
> include/linux/writeback.h:375:66: note: expected 'writepage_t' {aka 'int (*)(struct folio *, struct writeback_control *, void *)'} but argument is of type 'int (*)(struct page *, struct writeback_control *, void *)'
>   375 |                       struct writeback_control *wbc, writepage_t writepage,
>       |                                                      ~~~~~~~~~~~~^~~~~~~~~
> 
> Caused by commit
> 
>   a36a897cc496 ("fs: convert writepage_t callback to pass a folio")
> 
> interacting with commit
> 
>   79d3c6dbada4 ("udf: Convert in-ICB files to use udf_writepages()")
> 
> from the ext3 tree.
> 
> I have applied the following merge fix patch (I wasn't sure what to do
> with the PageLocked()).

Thanks for the fixup! The right function to replace PageLocked() with is
folio_test_locked(). Anyway, I'll prepare a suggested conflict resolution
for Linus when pushing the changes.

								Honza

> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 27 Jan 2023 16:50:34 +1100
> Subject: [PATCH] udf: fix up for "fs: convert writepage_t callback to pass a folio"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/udf/inode.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 3b2adf4cbc57..b47bf9c73f4d 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -185,16 +185,17 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
>  	}
>  }
>  
> -static int udf_adinicb_writepage(struct page *page,
> +static int udf_adinicb_writepage(struct folio *folio,
>  				 struct writeback_control *wbc, void *data)
>  {
> +	struct page *page = &folio->page;
>  	struct inode *inode = page->mapping->host;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  
> -	BUG_ON(!PageLocked(page));
> +//	BUG_ON(!PageLocked(page));
>  	memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
>  		       i_size_read(inode));
> -	unlock_page(page);
> +	folio_unlock(folio);
>  	mark_inode_dirty(inode);
>  
>  	return 0;
> -- 
> 2.35.1
> 
> -- 
> Cheers,
> Stephen Rothwell


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
