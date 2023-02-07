Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7C68D502
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjBGLBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBGLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:01:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF8C2A9BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:01:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 487C31FD81;
        Tue,  7 Feb 2023 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675767685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzqtHwylccrOKyTIhDhNG1l3BMPIMI3DFTMpbVf3iL4=;
        b=VPAT3VNKfiJKDuAF3HJNQ6lpfApFPOQzwDvPHVHHB4C8+eELlws3QCYpCjIUi8HXIkfKfQ
        B1Tgfs/UIE5xxCtO1SyGclMMDpT92z/B26rnuluZyuejlxvIdw+bmK6Z+vZ8FNnkyTcD75
        OV2e88ZxwZDRR5VMjY/zPaldMEPegMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675767685;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzqtHwylccrOKyTIhDhNG1l3BMPIMI3DFTMpbVf3iL4=;
        b=WSi6PKwJ5mcZ5fVBc2EC0QGceztefltIxpxJxNXUxgYryfFMFbgbJOIm3+q4faeOqkHl0t
        cKQFqR4OuiIYpiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D42C13467;
        Tue,  7 Feb 2023 11:01:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BDXoDoUv4mMSMgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Feb 2023 11:01:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B42B7A06D5; Tue,  7 Feb 2023 12:01:24 +0100 (CET)
Date:   Tue, 7 Feb 2023 12:01:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tom Rix <trix@redhat.com>
Cc:     jack@suse.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] udf: remove reporting loc in debug output
Message-ID: <20230207110124.xbme2i2y6yasofci@quack3>
References: <20230127162906.872395-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127162906.872395-1-trix@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27-01-23 08:29:06, Tom Rix wrote:
> clang build fails with
> fs/udf/partition.c:86:28: error: variable 'loc' is uninitialized when used here [-Werror,-Wuninitialized]
>                           sb, block, partition, loc, index);
>                                                 ^~~
> 
> loc is now only know when bh is valid.  So remove reporting loc in debug output.
> 
> Fixes: 4215db46d538 ("udf: Use udf_bread() in udf_get_pblock_virt15()")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks! Patch applied!

								Honza

> ---
>  fs/udf/partition.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/partition.c b/fs/udf/partition.c
> index 92765d2f6958..5bcfe78d5cab 100644
> --- a/fs/udf/partition.c
> +++ b/fs/udf/partition.c
> @@ -82,8 +82,8 @@ uint32_t udf_get_pblock_virt15(struct super_block *sb, uint32_t block,
>  
>  	bh = udf_bread(sbi->s_vat_inode, newblock, 0, &err);
>  	if (!bh) {
> -		udf_debug("get_pblock(UDF_VIRTUAL_MAP:%p,%u,%u) VAT: %u[%u]\n",
> -			  sb, block, partition, loc, index);
> +		udf_debug("get_pblock(UDF_VIRTUAL_MAP:%p,%u,%u)\n",
> +			  sb, block, partition);
>  		return 0xFFFFFFFF;
>  	}
>  
> -- 
> 2.26.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
