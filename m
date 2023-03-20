Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C376C0F92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCTKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCTKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:46:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D87F25B83
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8847B80DFD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27288C433EF;
        Mon, 20 Mar 2023 10:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679308983;
        bh=b7PFh3YhCgSl4cZHu1XnSk4/kQBLuxV+91gIq3yFMaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImOUHhynTTZoM9nBetVrrEMlNZ9aqCaSvqF4LPrJhWwbhkL/MG4hA0RnvlKyLiwfB
         TwaDI0LwOqmHkurwpNzDggxlD7Np7ath9Q0YfGxQ2w+o5JeRSlcGoGDafpE0UmcjSO
         Dg/Z2y1+iZaEU9eGcfllLmDKSLKpJcAg3SQHJqCU=
Date:   Mon, 20 Mar 2023 11:43:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] staging: rtl8723bs: use inline functions for
 dev_to_sdio_func
Message-ID: <ZBg4tGlY+Epz0Vhd@kroah.com>
References: <20230320103441.6537-1-eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320103441.6537-1-eng.mennamahmoud.mm@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:34:41PM +0200, Menna Mahmoud wrote:
> Convert `dev_to_sdio_func` macro into a static inline function.
> it is not great to have macro that use `container_of` macro,
> because from looking at the definition one cannot tell
> what type it applies to.
> 
> One can get the same benefit from an efficiency point of view
> by making an inline function.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 490431484524..7ee821dbbae0 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -10,7 +10,10 @@
>  #include <linux/jiffies.h>
>  
>  #ifndef dev_to_sdio_func
> -#define dev_to_sdio_func(d)     container_of(d, struct sdio_func, dev)
> +static inline struct sdio_func *dev_to_sdio_func(struct device *d)
> +{
> +	return container_of(d, struct sdio_func, dev);
> +}
>  #endif

Why is the "#ifndef" check still needed now?  Really it was never
needed, but now would be a great time to remove it as it doubly does not
make any sense here.

Oh wait, no, this whole thing can just be removed entirely, right?
There already is a dev_to_sdio_func macro defined, so the #ifndef check
catches that so your change doesn't actually modify any code that is
used.  So this should all be removed, not changed to an inline function.

thanks,

greg k-h
