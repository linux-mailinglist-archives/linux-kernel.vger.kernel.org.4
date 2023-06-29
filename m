Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C392742E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjF2UEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjF2UDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:03:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50B3A81
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:02:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666683eb028so732502b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688068964; x=1690660964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUs7U0BtKPJKG1fzCWygEf2HA0xht76oAjLsL2vUhyc=;
        b=Twu/FkGZNZQcuDHDwKEwB2wyE3v1LbCDu0eqxi7o+F27rEm7sqDp80j39YE6UCfvl4
         2rIhpm93D6ABz6M5sH7Md4uHRs/x09fOmcjvBWU2B8XV/lFuQKbjCTsr/PE9Iic01fqu
         XPdl1KDY1NNtAmWmfm7AiO7oGkDHBajxuQFGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068964; x=1690660964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUs7U0BtKPJKG1fzCWygEf2HA0xht76oAjLsL2vUhyc=;
        b=KGiEjXXqHcmFx1zQORTXyUKoiA6kuO2HUYynsN9GCQkLUnAO+0XCWSqKeRSTYZ21p8
         5KOfAmYInVGqLQZlK7vKym9/DdIhmzVRTIdbliKUmvuSwYCEF0nJOiicfaL2I6foW5Xh
         zUPFNHCMx1nGMb2taENHj8X3y6geYGZFeOgiy6YpP1NG9WSsbqzXHLbqRqPcBouNkRFP
         j8GVhqtiVHdny7ZL6rMp2ZZvPgyZnGu9MoxRxMeWOxz9cq4xQbEkhnGjP2aInRzIae9c
         dO2O7q6NGLKNAYJtAp26VtR9jCyFFAcl006+r+XU3eYRT653vYIJWn5eKE1t6hf+r7uq
         0Ucg==
X-Gm-Message-State: ABy/qLZuW5/fYrxYc5VtUpiXvpY/6LQjObEdp0qbCDFba/uuu6ExmFZy
        17cYtmaykzG9OOTZfbp4IhbFug==
X-Google-Smtp-Source: APBJJlG5QTXFLOoEdTJA9LqV+/oEh+5BpFurv2cnrHa3QVzL6i65AYGPHUPw04F0k7YjzN3v6dquOg==
X-Received: by 2002:a05:6a00:2d1a:b0:643:aa8d:8cd7 with SMTP id fa26-20020a056a002d1a00b00643aa8d8cd7mr968304pfb.32.1688068963869;
        Thu, 29 Jun 2023 13:02:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q136-20020a632a8e000000b0055b0c330b30sm4599477pgq.84.2023.06.29.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:02:43 -0700 (PDT)
Date:   Thu, 29 Jun 2023 13:02:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] openprom: Use struct_size() helper
Message-ID: <202306291300.7DBE393BC@keescook>
References: <ZJTYWQ5NA726baWK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJTYWQ5NA726baWK@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 05:25:13PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.

This commit log could be more descriptive since the replacement below
isn't in the standard "sizeof(struct) + sizeof(element) * count" format.
:) It took me a moment to figure out what was going on:

struct openpromio
{
        unsigned int oprom_size;        /* Actual size of the oprom_array. */
        char    oprom_array[];          /* Holds property names and values. */
};

sizeof(struct openpromio) == sizeof(int)   :P


> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/sbus/char/openprom.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
> index 30b9751aad30..de56c8fec373 100644
> --- a/drivers/sbus/char/openprom.c
> +++ b/drivers/sbus/char/openprom.c
> @@ -76,7 +76,9 @@ static int copyin(struct openpromio __user *info, struct openpromio **opp_p)
>  	if (bufsize > OPROMMAXPARAM)
>  		bufsize = OPROMMAXPARAM;
>  
> -	if (!(*opp_p = kzalloc(sizeof(int) + bufsize + 1, GFP_KERNEL)))
> +	*opp_p = kzalloc(struct_size(*opp_p, oprom_array, bufsize + 1),
> +			 GFP_KERNEL);
> +	if (!*opp_p)
>  		return -ENOMEM;
>  
>  	if (copy_from_user(&(*opp_p)->oprom_array,
> @@ -95,7 +97,9 @@ static int getstrings(struct openpromio __user *info, struct openpromio **opp_p)
>  	if (!info || !opp_p)
>  		return -EFAULT;
>  
> -	if (!(*opp_p = kzalloc(sizeof(int) + OPROMMAXPARAM + 1, GFP_KERNEL)))
> +	*opp_p = kzalloc(struct_size(*opp_p, oprom_array, OPROMMAXPARAM + 1),
> +			 GFP_KERNEL);
> +	if (!*opp_p)
>  		return -ENOMEM;

With that understood, yeah, these look good to me. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
