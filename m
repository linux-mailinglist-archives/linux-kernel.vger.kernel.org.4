Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB370D867
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjEWJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjEWJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC4E52;
        Tue, 23 May 2023 02:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50290625DB;
        Tue, 23 May 2023 09:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CB5C433D2;
        Tue, 23 May 2023 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684832745;
        bh=Ktz8c9CHrsBCyq8EDDrmqMvG7rMPCaYUk0I1BJHxuRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBQwJUE045rFUQP9CaTfylO/L9qUNlhLCuacZzQ7g7NvBB7whRU3HywN4vIjcTQNw
         G8e15bN/SttNz1xQ5JXEJfOBlob1rY+TU1VWrvgvMYXk9qFcw5bShck8PJukkTB/k4
         6cO0EuE3NCKUtTquSoFblwoY50wyOPN1RqimPXJ6hgT7UxWa0I7nh7azSxsaJ4k+Ow
         pgWLL0+CT5mLRprPhu9Ah2yCKdsUafPo/JvkWEt+2QnVCRMRRYUcl9jwZBj1Xuojca
         DldQSCcSX5MQl8Bf+7JFlCWzkHpS/tlKfpTKpB4Czd/w65EUdg9UZQxMJZWiM2NGgQ
         7sJ4Ai9VuNAYQ==
Date:   Tue, 23 May 2023 10:05:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] i2c: Replace all non-returning strlcpy with strscpy
Message-ID: <20230523090540.GC2174496@google.com>
References: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, Azeem Shaikh wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/leds/flash/leds-as3645a.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Please resubmit, taking the time to check the subject line please.

> diff --git a/drivers/leds/flash/leds-as3645a.c b/drivers/leds/flash/leds-as3645a.c
> index bb2249771acb..7dc574b18f5f 100644
> --- a/drivers/leds/flash/leds-as3645a.c
> +++ b/drivers/leds/flash/leds-as3645a.c
> @@ -651,8 +651,8 @@ static int as3645a_v4l2_setup(struct as3645a *flash)
>  		},
>  	};
>  
> -	strlcpy(cfg.dev_name, led->dev->kobj.name, sizeof(cfg.dev_name));
> -	strlcpy(cfgind.dev_name, flash->iled_cdev.dev->kobj.name,
> +	strscpy(cfg.dev_name, led->dev->kobj.name, sizeof(cfg.dev_name));
> +	strscpy(cfgind.dev_name, flash->iled_cdev.dev->kobj.name,
>  		sizeof(cfgind.dev_name));
>  
>  	flash->vf = v4l2_flash_init(
> 

-- 
Lee Jones [李琼斯]
