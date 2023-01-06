Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85ED660420
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjAFQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjAFQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:17:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2D7621D;
        Fri,  6 Jan 2023 08:17:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C150270C2;
        Fri,  6 Jan 2023 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673021868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B9WUSg1w6lXgk5OVW4/SCoCMWU1E1GVuFjkdC7c+hUY=;
        b=MK0/SWzgDjvH0OLCXOmD8llWuxeQ4+GDqR5thC5vVOXVkAaNOCeRAGWCEi3PKFwoEjfSXW
        m0/DnI2kdA2Wys54Xoi0K5pAFmUjIK0coJmR4915frMtjwnkHs4CvG5uu9ouO0YocwS5Uu
        BOkucLt/fNsv+ZxzFtx8Y/8BLith/Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673021868;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B9WUSg1w6lXgk5OVW4/SCoCMWU1E1GVuFjkdC7c+hUY=;
        b=spn+BCL1tlmrdvxJR1WtCbu+aQymd7Kaa0Q/iO3T7VVPpp9y8jCxke37K+2lYuujQZBiNh
        29mPtFxkkEu4k9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7166913596;
        Fri,  6 Jan 2023 16:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id blCiG6xJuGNaLwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Jan 2023 16:17:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B6B47A0742; Fri,  6 Jan 2023 17:17:47 +0100 (CET)
Date:   Fri, 6 Jan 2023 17:17:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jan Kara <jack@suse.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] udf: remove redundant variable netype
Message-ID: <20230106161747.a5j4orghkegeiqjg@quack3>
References: <20230105134925.45599-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105134925.45599-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-01-23 13:49:25, Colin Ian King wrote:
> The variable netype is assigned a value that is never read, the assignment
> is redundant the variable can be removed.
> 
> Cleans up clang scan-build warning:
> fs/exfat/dir.c:1012:5: warning: Value stored to 'step' is never read
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, I've added the patch to my tree. Just the warning message mentioned
in the changelog is apparently from somewhere else so I've just deleted it
;).

								Honza

> ---
>  fs/udf/truncate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index 036ebd892b85..775edaba82ee 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -125,7 +125,7 @@ void udf_discard_prealloc(struct inode *inode)
>  	struct kernel_lb_addr eloc;
>  	uint32_t elen;
>  	uint64_t lbcount = 0;
> -	int8_t etype = -1, netype;
> +	int8_t etype = -1;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  	int bsize = 1 << inode->i_blkbits;
>  
> @@ -136,7 +136,7 @@ void udf_discard_prealloc(struct inode *inode)
>  	epos.block = iinfo->i_location;
>  
>  	/* Find the last extent in the file */
> -	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 0)) != -1) {
> +	while (udf_next_aext(inode, &epos, &eloc, &elen, 0) != -1) {
>  		brelse(prev_epos.bh);
>  		prev_epos = epos;
>  		if (prev_epos.bh)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
