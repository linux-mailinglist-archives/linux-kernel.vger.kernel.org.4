Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB36B739D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCMKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCMKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:17:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431B25E34
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:17:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1CB51FD86;
        Mon, 13 Mar 2023 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678702640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7CPT3GvN3GDj0yZR4nAVrIGiQ3zmlRQtIducfl8qM4=;
        b=asgGxVf2afibuOcIK9UyDny8lRDKFLtuNnELKrCNjRDtaIFINxdx8yBH6Ah7r6w1xGKPop
        MHhbhbG8D5dD7CAuXUxOQFsn1hQwAwantt5yzfxacr2vbWePJALfZHL/wcZKx7Sa8vgIT+
        pe9bU8S5BihP5yO+4J71bzspfJfnEFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678702640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7CPT3GvN3GDj0yZR4nAVrIGiQ3zmlRQtIducfl8qM4=;
        b=n1LxRZCwkDKJHfMwzH03fq++r1Ri+H3WqhpSyyDCuDuxnAabxASshPcRYbTb8NLJIZau5b
        iOpQExQCT1lE+BBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91C5513582;
        Mon, 13 Mar 2023 10:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FWuTIzD4DmTKOQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 13 Mar 2023 10:17:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1B193A06FD; Mon, 13 Mar 2023 11:17:20 +0100 (CET)
Date:   Mon, 13 Mar 2023 11:17:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     almaz.alexandrovich@paragon-software.com, jack@suse.com,
        dushistov@mail.ru, brauner@kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] udf: use wrapper i_blocksize() in
 udf_discard_prealloc()
Message-ID: <20230313101720.ogqufcqeqfxcdzfz@quack3>
References: <20230310030821.66090-1-frank.li@vivo.com>
 <20230310030821.66090-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310030821.66090-2-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-03-23 11:08:20, Yangtao Li wrote:
> Convert to use i_blocksize() for readability.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks. I've queued this cleanup into my tree.

								Honza

> ---
>  fs/udf/truncate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index 871856c69df5..2e7ba234bab8 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -127,7 +127,7 @@ void udf_discard_prealloc(struct inode *inode)
>  	uint64_t lbcount = 0;
>  	int8_t etype = -1;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
> -	int bsize = 1 << inode->i_blkbits;
> +	int bsize = i_blocksize(inode);
>  
>  	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
>  	    ALIGN(inode->i_size, bsize) == ALIGN(iinfo->i_lenExtents, bsize))
> @@ -149,7 +149,7 @@ void udf_discard_prealloc(struct inode *inode)
>  		lbcount -= elen;
>  		udf_delete_aext(inode, prev_epos);
>  		udf_free_blocks(inode->i_sb, inode, &eloc, 0,
> -				DIV_ROUND_UP(elen, 1 << inode->i_blkbits));
> +				DIV_ROUND_UP(elen, bsize));
>  	}
>  	/* This inode entry is in-memory only and thus we don't have to mark
>  	 * the inode dirty */
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
