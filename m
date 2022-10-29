Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A400612109
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJ2Hb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2Hb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1911BB946;
        Sat, 29 Oct 2022 00:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEDA860ACE;
        Sat, 29 Oct 2022 07:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8CAC433D6;
        Sat, 29 Oct 2022 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667028715;
        bh=fekE5mNaYU4tr5MhqcASkIRisSfr+Jn/AaUqP85eL+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uluSYSgud7ecH98orcfLZR6rZJpz5vUm8xklBEvKmggI+8OHnG4WimG5LQ0GrO/Qb
         txnao02M1F7L8uZKqImEiln9TlcWj7LekeXoC4SvXonhrgsWBiXPWoD/p9DoA+Arki
         /M6YkBm1MbL/Rkl47i40POXLMzQmC/viFg0B6/9Q=
Date:   Sat, 29 Oct 2022 09:32:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use ARRAY_SIZE() to get argument count
Message-ID: <Y1zXIjCe3LGwApWD@kroah.com>
References: <Y1vZXUi0Bjiub8HZ@ubunlion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vZXUi0Bjiub8HZ@ubunlion>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:00:05PM +0530, Deepak R Varma wrote:
> The ARRAY_SIZE(foo) macro should be preferred over sizeof operator
> based computation such as sizeof(foo)/sizeof(foo[0]) for finding
> number of elements in an array. Issue identified using coccicheck.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/fbtft/fbtft.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> index 2c2b5f1c1df3..5506a473be91 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -231,7 +231,7 @@ struct fbtft_par {
>  	bool polarity;
>  };
> 
> -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> +#define NUMARGS(...)  ARRAY_SIZE(((int[]){ __VA_ARGS__ }))

Please please please test-build your patches before sending them out.
To not do so just wastes reviewer resources :(

thanks,

greg k-h
