Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FDF6F7CE2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjEEGUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjEEGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26814E45
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 883CD63B44
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E6DC4339C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683267628;
        bh=IA4DiBK1fkEoOLwHSLdBoQc5dOe//aOd8n7nFG1mCjg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=EaBZKldYQAxIYNedXpmL8Fb851fFAd5Ucnt4TkGOtmVG+gt65C4k92hRL9pKODu0J
         pMhmrBbUsgxNKJ1gsdzlaXSFAKFmWENjC+d9Nv0N+BU5Dp/y9EYCQ9vDU66Y3hrBdC
         5hsdXv7NFysQRFRZ3gAqn26dVZUYKQpVYHGNLG5uoJUv9CeQwWoW/5KE/t+/+iXA9q
         q0cxxWW0v4AoqJ1LuBVAJpy8d+rdniR5gv+bJFwuuQVvbynLX+W93LznfUzdCZc6tl
         cZ5/C4X7qAnp9ube//17Pdup93sgsaZk7XowLZVglpY5G7CceUX0XCfmPvz/iWJR1s
         TamuxsT28kVKw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-546ef028d62so831860eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:20:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDz8+NmWOEVv+4Tq7P6zmpFv3eFmV1nkNZ1lYiU6aYEiy/uXfR2o
        PINKckkJ7pnS3RYkCe2bsuVKy20k2dA48IE2uGI=
X-Google-Smtp-Source: ACHHUZ7mhlrgKZroAsJa36mQn/dg+ji8DHYMX8/HtQQoLuTVe09OyvWCwZ1ySTM5U/ASeQQW1LcK13tKFEGT1vz+gQU=
X-Received: by 2002:a4a:3858:0:b0:544:dc2c:9f78 with SMTP id
 o24-20020a4a3858000000b00544dc2c9f78mr200217oof.6.1683267627985; Thu, 04 May
 2023 23:20:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7858:0:b0:4d3:d9bf:b562 with HTTP; Thu, 4 May 2023
 23:20:27 -0700 (PDT)
In-Reply-To: <20230407194433.25659-1-listdansp@mail.ru>
References: <20230407194433.25659-1-listdansp@mail.ru>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 5 May 2023 15:20:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_nMBzkTo882h=DgHGgzRHfh7+NMQ7A-0SJ5yN_ZE0d7w@mail.gmail.com>
Message-ID: <CAKYAXd_nMBzkTo882h=DgHGgzRHfh7+NMQ7A-0SJ5yN_ZE0d7w@mail.gmail.com>
Subject: Re: [PATCH] ntfs: do not dereference a null ctx on error
To:     Danila Chernetsov <listdansp@mail.ru>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-04-08 4:44 GMT+09:00, Danila Chernetsov <listdansp@mail.ru>:
> In ntfs_mft_data_extend_allocation_nolock(), if an error condition occurs
> prior to 'ctx' being set to a non-NULL value, avoid dereferencing the NULL
> 'ctx' pointer in error handling.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
> ---
>  fs/ntfs/mft.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 48030899dc6e..e1126ce6f8ec 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -1955,36 +1955,40 @@ static int
> ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
>  				"attribute.%s", es);
>  		NVolSetErrors(vol);
>  	}
> -	a = ctx->attr;
> +	
>  	if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
>  		ntfs_error(vol->sb, "Failed to truncate mft data attribute "
>  				"runlist.%s", es);
>  		NVolSetErrors(vol);
>  	}
> -	if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
> -		if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
> +	if (ctx) {
> +		a = ctx->attr;
> +		if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
> +			if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
>  				a->data.non_resident.mapping_pairs_offset),
>  				old_alen - le16_to_cpu(
> -				a->data.non_resident.mapping_pairs_offset),
> +					a->data.non_resident.mapping_pairs_offset),
>  				rl2, ll, -1, NULL)) {
> -			ntfs_error(vol->sb, "Failed to restore mapping pairs "
> +				ntfs_error(vol->sb, "Failed to restore mapping pairs "
>  					"array.%s", es);
> -			NVolSetErrors(vol);
> -		}
> -		if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
> -			ntfs_error(vol->sb, "Failed to restore attribute "
> +				NVolSetErrors(vol);
> +			}
> +			if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
> +				ntfs_error(vol->sb, "Failed to restore attribute "
>  					"record.%s", es);
> -			NVolSetErrors(vol);
> +				NVolSetErrors(vol);
> +			}
> +			flush_dcache_mft_record_page(ctx->ntfs_ino);
> +			mark_mft_record_dirty(ctx->ntfs_ino);
>  		}
> -		flush_dcache_mft_record_page(ctx->ntfs_ino);
> -		mark_mft_record_dirty(ctx->ntfs_ino);
> -	} else if (IS_ERR(ctx->mrec)) {
> -		ntfs_error(vol->sb, "Failed to restore attribute search "
> +		else if (IS_ERR(ctx->mrec)) {
> +			ntfs_error(vol->sb, "Failed to restore attribute search "
>  				"context.%s", es);
> -		NVolSetErrors(vol);
> +			NVolSetErrors(vol);
> +		}
> +		if (ctx)
I think that this check is not needed.
> +			ntfs_attr_put_search_ctx(ctx);
>  	}
> -	if (ctx)
> -		ntfs_attr_put_search_ctx(ctx);
>  	if (!IS_ERR(mrec))
>  		unmap_mft_record(mft_ni);
>  	up_write(&mft_ni->runlist.lock);
> --
> 2.25.1
>
>
