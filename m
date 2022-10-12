Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1A5FC873
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJLPc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:32:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A498263D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:32:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 26B9E1F381;
        Wed, 12 Oct 2022 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665588773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5DBzCeO215OOajCS2K1ajL8njr4qHFYDFUKbY3eWpA=;
        b=YXPd6OUbss93REbGV/CmJjxbHwmkC0TsYZk1bVnom0Q1iIIZF5no88q4JVeP6DWHw9+2lu
        unMjDS++ewAcMVLvLVkpLaQ1b3PfOMMxs+ApgL3qqxj6RO/6F+FetdS07de0Gs6ZDaK7wV
        oH7NPHsuXlzYjGI3xwjE1H7YSenWnUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665588773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5DBzCeO215OOajCS2K1ajL8njr4qHFYDFUKbY3eWpA=;
        b=sxpD0K832rcV0dLo5/gu9QOioRlkHQRiDogmh66Lb6Ajohq1bK7IwpC7/c+NKZyPljEKVi
        nc5QQzVHOA1xvtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F039A13ACD;
        Wed, 12 Oct 2022 15:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pYieOiTeRmPsRAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Oct 2022 15:32:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 783C1A06F3; Wed, 12 Oct 2022 17:32:46 +0200 (CEST)
Date:   Wed, 12 Oct 2022 17:32:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Li zeming <zeming@nfschina.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: udf: Optimize udf_free_in_core_inode and
 udf_find_fileset function
Message-ID: <20221012153246.pt6ju4i3cdsenbny@quack3>
References: <20221012104235.3331-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012104235.3331-1-zeming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-10-22 18:42:35, Li zeming wrote:
> These two functions perform the following optimizations.
> 1. Delete the type cast of foo pointer. Void * does not need to convert
> the type.
> 2. Delete the initialization assignment of bh variable, which is
> assigned first.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Thanks for the patch. It looks good, I'll queue it into my tree once the
merge window closes.

								Honza

> ---
>  fs/udf/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 4042d9739fb7..06eda8177b5f 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -162,7 +162,7 @@ static void udf_free_in_core_inode(struct inode *inode)
>  
>  static void init_once(void *foo)
>  {
> -	struct udf_inode_info *ei = (struct udf_inode_info *)foo;
> +	struct udf_inode_info *ei = foo;
>  
>  	ei->i_data = NULL;
>  	inode_init_once(&ei->vfs_inode);
> @@ -820,7 +820,7 @@ static int udf_find_fileset(struct super_block *sb,
>  			    struct kernel_lb_addr *fileset,
>  			    struct kernel_lb_addr *root)
>  {
> -	struct buffer_head *bh = NULL;
> +	struct buffer_head *bh;
>  	uint16_t ident;
>  	int ret;
>  
> -- 
> 2.18.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
