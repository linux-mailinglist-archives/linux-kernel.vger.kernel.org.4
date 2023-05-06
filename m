Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB986F8D3A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjEFAwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEFAwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7D25FD6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E826348A
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C7BC4339B
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683334362;
        bh=1SS00KeWpuyIU/DKhcDX5dtOBMR10FYpGFsGPZXyfbw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=k9sPCO/coikBd6vrwndjknAkCzl6x4f4gpvxrxDGfMmC/Tqf6FfjcvossntGZd91h
         49YTwzwY/WhordJPUR6+SCNR444gF3N8Rpfmh/j83NOFBUEO2H5i3rbTv3qXzevBSJ
         ZcF1d/lylD4gjgTi6+HxJYM+E50XijPcCGHrCAH+tIBK74klmzLndinBH4DXwgQy/y
         +r/Me7GL0PIkALH1jb27Ep0gF17CMB1+J9/r5t1XrWUvI7uCx2V8ZaW2RkYOo7D6j/
         U3Xi2qfka4Y0uCeRlrWI6kyM8ANM2jx2D4A/x39YYCdc5P0EyoZ/S/YmuuqsShDNhD
         sWOnKfqtSpZNw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-547303fccefso1627707eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 17:52:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDzBOyaF/G7UzPd9cdy/X86VKQ/1x70DfehwKfjh3ubBAZjU6aoo
        j4/+zNtfu3xNsgkOQhVqWEP2eIHkQugWZnzz8tk=
X-Google-Smtp-Source: ACHHUZ65N71PhcWlfTQnr8plARJc8DTyW98HBWGYEvov+ompwC4lcan6sFdmtdY4n5o5e4LuKeEqIR0gUtSwsurrrG0=
X-Received: by 2002:a4a:6f44:0:b0:542:5d35:12a0 with SMTP id
 i4-20020a4a6f44000000b005425d3512a0mr1226518oof.3.1683334361695; Fri, 05 May
 2023 17:52:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:981:0:b0:4d3:d9bf:b562 with HTTP; Fri, 5 May 2023
 17:52:41 -0700 (PDT)
In-Reply-To: <20230407194433.25659-1-listdansp@mail.ru>
References: <20230407194433.25659-1-listdansp@mail.ru>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 6 May 2023 09:52:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8em5AxsA=m9oRqyCuzcnx6DzkOoxe_UAqkjB6zT5AiPQ@mail.gmail.com>
Message-ID: <CAKYAXd8em5AxsA=m9oRqyCuzcnx6DzkOoxe_UAqkjB6zT5AiPQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: do not dereference a null ctx on error
To:     Danila Chernetsov <listdansp@mail.ru>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project <lvc-project@linuxtesting.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-04-08 4:44 GMT+09:00, Danila Chernetsov <listdansp@mail.ru>:
> In ntfs_mft_data_extend_allocation_nolock(), if an error condition occurs
> prior to 'ctx' being set to a non-NULL value, avoid dereferencing the NULL
> 'ctx' pointer in error handling.
Please check the warnings from checkpatch.pl.

ERROR: trailing whitespace
#107: FILE: fs/ntfs/mft.c:1958:
+^I$

ERROR: "(foo*)" should be "(foo *)"
#118: FILE: fs/ntfs/mft.c:1967:
+			if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(

ERROR: else should follow close brace '}'
#146: FILE: fs/ntfs/mft.c:1984:
 		}
+		else if (IS_ERR(ctx->mrec)) {

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
