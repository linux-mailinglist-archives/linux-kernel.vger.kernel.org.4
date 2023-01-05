Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01D865F635
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjAEVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjAEVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:50:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB146E407
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CCB661C60
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 21:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1758C433F0;
        Thu,  5 Jan 2023 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672955359;
        bh=uPhaNTNENZf5mGw9EH+DvbTe4+iskK+IX8fyXCEc/b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1vQhvrwks9De8sHyhAVIDK96HEI3Qp6V6J/94JngqUfbWfnIhx0UxaqicJ6hfvMk
         6CjUqB4QjufqDBU2QaCZE22uIVoavl90IpYuTbynfhyv7/7wkt9Msv9yJ2x/1IoLdZ
         mBJGTLs2MNdLKXL3kEm2sbtG4fzlOOoFm+EX0V/t3yB1/CumMZfn02p5ZQOaMrHf1T
         nNIV2z3/Z1NcB53mCXZB7r1CsY83CJutYcLT7wyf+hEWvaplYYW89cWvvvju1Pbr5U
         F7ZeKW9t745T3t3LFVdog+vp7wd79YtTcmhtFaxcunAL2XJKxfFAhqtKb/0h4r+CMS
         EyFOXQpLG9b/w==
Date:   Thu, 5 Jan 2023 14:49:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ndesaulniers@google.com, Vijendar.Mukunda@amd.com,
        Syed.SabaKareem@amd.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: amd: Return ENODEV if acp63 is not found.
Message-ID: <Y7dF3VvQs6l7rr3p@dev-arch.thelio-3990X>
References: <20230105211912.824250-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105211912.824250-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Thu, Jan 05, 2023 at 04:19:12PM -0500, Tom Rix wrote:
> The clang build fails with
> sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used
>   uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>         default:
>         ^~~~~~~
> 
> When no device is found -ENODEV should be returned.
> A switch with a single case is overkill, change to if-else.
> 
> Fixes: 1d325cdaf7a2 ("ASoC: amd: ps: refactor platform device creation logic")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch! I sent basically the same thing earlier today
(sorry for forgetting to Cc you directly) and was told it was not
correct:

https://lore.kernel.org/6bb126b7-1cb4-0c4c-d357-fadc3ffdd3f9@amd.com/

I am just waiting for some feedback before sending a v2.

> ---
>  sound/soc/amd/ps/pci-ps.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 401cfd0036be..cba8800ab4ea 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -205,8 +205,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>  		memset(&pdevinfo, 0, sizeof(pdevinfo));
>  	}
>  
> -	switch (adata->pdev_mask) {
> -	case ACP63_PDM_DEV_MASK:
> +	if (adata->pdev_mask == ACP63_PDM_DEV_MASK) {
>  		adata->pdm_dev_index  = 0;
>  		acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
>  					     0, adata->res, 1, NULL, 0);
> @@ -214,8 +213,8 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>  					     0, NULL, 0, NULL, 0);
>  		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
>  					     0, NULL, 0, NULL, 0);
> -		break;
> -	default:
> +	} else {
> +		ret = -ENODEV;
>  		dev_dbg(&pci->dev, "No PDM devices found\n");
>  		goto de_init;
>  	}
> -- 
> 2.27.0
> 
> 
