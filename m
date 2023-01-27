Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B467ECC2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjA0Rxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjA0Rxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:53:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0132D7F69A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:53:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B177CB8214D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA0CC433D2;
        Fri, 27 Jan 2023 17:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674842026;
        bh=I5D+KnN4ZzayWQDixcs85vgccbaebhLgzxg/xX7mDhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1gm+/d2B67hghTWu39vvjRGgcL5E/1TlJZDOe8AxBka1qpTmMHwH8zfB2FBH4pVg
         wH62uu0uChqpijInPuLoH3HSOuyX1SWOQ+wtEw5MhWri9ndTxOaVxxjUxRZsDt5jwb
         Hp5OF4x+PaFu5JCOay6TYuIkIK0YqDZ9QhtA/qAMrfzneIlKhcfS3ue/S0QAD2j4PZ
         UaabDaShEHknc8kRztNNHUW2g25/4d+89KC+7YG408vwJCri7P+WqO3SMJvCFIAvGI
         f575JJba+Exh9+tvTDZ9sHKP/bdf86AymCo4/FHWodboTeVFGxVkHnXoX9ty7cQKk7
         xtXfSI1oigr5A==
Date:   Fri, 27 Jan 2023 10:53:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     jack@suse.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] udf: remove reporting loc in debug output
Message-ID: <Y9QPqPeNCqhO2xev@dev-arch.thelio-3990X>
References: <20230127162906.872395-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127162906.872395-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:29:06AM -0800, Tom Rix wrote:
> clang build fails with
> fs/udf/partition.c:86:28: error: variable 'loc' is uninitialized when used here [-Werror,-Wuninitialized]
>                           sb, block, partition, loc, index);
>                                                 ^~~
> 
> loc is now only know when bh is valid.  So remove reporting loc in debug output.
> 
> Fixes: 4215db46d538 ("udf: Use udf_bread() in udf_get_pblock_virt15()")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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
