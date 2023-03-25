Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0D6C8CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjCYIzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:55:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B9DBF4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD60FB8069F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 08:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E933AC433D2;
        Sat, 25 Mar 2023 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679734548;
        bh=7u5dawj2c2fO53iR4hy3wYysiDixPMrt/zLjhNT/b28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdeBzSAmWOb5OtTKlnceOFbh0Y7xF0HS24UVpYblMZH5+h8P/7T1Tb0Oy2T3cN6NE
         aIzasQ07PK0xoGUTeC1zCJ3ZIJbrykefNg8PDiszW07VZo9GxZJ2jnMD0HnCVGEvUk
         mKZ/4yIoECOSSTRYLMiCSjgaQHrBt93SNO+OFYp8=
Date:   Sat, 25 Mar 2023 09:55:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] staging: greybus: Inline pwm_chip_to_gb_pwm_chip()
Message-ID: <ZB63EVLK6/29UUi0@kroah.com>
References: <cover.1679732179.git.sumitraartsy@gmail.com>
 <f1ef1b643840e74f211264dda0c590f8458618f6.1679732179.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ef1b643840e74f211264dda0c590f8458618f6.1679732179.git.sumitraartsy@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 01:31:10AM -0700, Sumitra Sharma wrote:
> Convert 'pwm_chip_to_gb_pwm_chip' from a macro to a static
> inline function, to make the relevant types apparent in the
> definition and to benefit from the type checking performed by
> the compiler at call sites.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>  drivers/staging/greybus/pwm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> index 3fda172239d2..88da1d796f13 100644
> --- a/drivers/staging/greybus/pwm.c
> +++ b/drivers/staging/greybus/pwm.c
> @@ -21,9 +21,11 @@ struct gb_pwm_chip {
>  	struct pwm_chip		chip;
>  	struct pwm_chip		*pwm;
>  };
> -#define pwm_chip_to_gb_pwm_chip(chip) \
> -	container_of(chip, struct gb_pwm_chip, chip)
>  
> +static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct gb_pwm_chip, chip);
> +}
>  
>  static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
>  {
> -- 
> 2.25.1
> 
> 

This patch didn't apply due to changes made in my tree by a patch from
someone else before yours.  Can you rebase it and resend?

thanks,

greg k-h
