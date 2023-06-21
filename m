Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765A073888D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjFUPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjFUPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975432978;
        Wed, 21 Jun 2023 08:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC06A6156A;
        Wed, 21 Jun 2023 15:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627C6C433C8;
        Wed, 21 Jun 2023 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687360122;
        bh=V9aNr83+u4TubllrTyVD8v0+IvuXLd+mK4FoyaNTvno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2UeTRX4eHzvBgEqrb+Oq6Ge/hQePE/4ifvWoFw22vovfEY/gA8irW+Ke17wZ1xMa
         MfASFyK2Czc6hcRTZd+ZOGp9a+BR0UElYRfo3BVKno9heiqyvHy4scdN4oQnS4iH8l
         8mtOujFjq4vtRYjCQbhdGmpp4x1MrLdLjEtKyW8QhFD6k+x/WlEiX4jfP0a6GXcHGc
         nQB0vx/NZkoPrB035dQF/4dyGZO+snpCPLg/8eJBAN+B4w17feILAAkTA2qoNu2f2k
         D2Sm0uVcVwNg2MUtfnwnMLYUoDo5ZIAhNqNrKVJYggxxIqG5klEc37iV/9qGbxOCsf
         D61f8vB+y0W8A==
Date:   Wed, 21 Jun 2023 16:08:38 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6040: Use maple tree register cache
Message-ID: <20230621150838.GG10378@google.com>
References: <20230609-mfd-twl6040-maple-v1-1-3493d051cd6f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609-mfd-twl6040-maple-v1-1-3493d051cd6f@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2023, Mark Brown wrote:

> The twl6040 is only capable of performing single register read and write
> operations which means it gains no advantage from using a rbtree register
> cache, convert it to using the more modern maple tree register cache
> instead. This should be more efficient.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/mfd/twl6040.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This has been applied for a while.

> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index e982119bbefa..523439a16b7c 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -608,7 +608,7 @@ static const struct regmap_config twl6040_regmap_config = {
>  	.volatile_reg = twl6040_volatile_reg,
>  	.writeable_reg = twl6040_writeable_reg,
>  
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  	.use_single_read = true,
>  	.use_single_write = true,
>  };
> 
> ---
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> change-id: 20230609-mfd-twl6040-maple-0904598891f2
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

-- 
Lee Jones [李琼斯]
