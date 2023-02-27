Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865FE6A3A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjB0Erp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0Ern (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:47:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B551BAE4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:47:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so4847963wrb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5pnNZDw7QdzXNOM+p7zLL9mRnQ7pTZFlC2sCefY6Q8=;
        b=AHQerDa0D2gjrEM3/6+pbLu4EiE7JH0iQUJsmQawF//n2hqu4ifk3pKnMxtJo70oe8
         LWTykC2xWmhDNGh78Zz/3SkmxqKnp24YjESUQjfYtHcjiY0u6Rd6vRG6rm53+FN7xO/z
         baZjhYDb6P0t6WXduyD8vQk/lHvDiHo1CwkmuXCcpwegaaCCmVWubqfR0BcuABcpqRgY
         ZEzTFevfoq70+52/jkAF190nHN32zUIrxZMMowEThZQJ1ro1EHgTl6Ysn2ooLE/BkWnk
         Ro65Q4vGICHCDBzDy5V3t4QEPxQWWnk+Uj++pbyGKLtRpS9+bW0KSIg6ujs5aEIx6LRm
         Q1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5pnNZDw7QdzXNOM+p7zLL9mRnQ7pTZFlC2sCefY6Q8=;
        b=gxRBcgdfsIuLvfzfwpv9m7LEFM6JX668QfeGWaY2MKODLl9FDjC34N1HBg/bWghsPu
         tsPTOZmpbXbsA/VBT+C9q26i8FEb0sxWM9Hp9/LVu/l393gBs0yG59AxTvoC5ONvWl7+
         rFkWQ8+EiAyxH27LkNWzn8jyWWAYrD+SDk9MCYeiq8RLyke20YRBzjs8UMAMkPLo15by
         Q6zkL5oSh1jW9268idi6c3GkVeS3EVEo3kze/+GfemKTwqljaZFOQPo5KaC22Fxgby5Q
         dERZ3eYewz+HqwW6bufzqHhtqj/+2uyKFJY1UskEpB5J4xtuVphsaGaUyBywcLW0TavF
         vlZg==
X-Gm-Message-State: AO0yUKV34YcERt1+WvMPRnBuzfXgce0cztERCH9DSAazWkxH5lS2i28E
        L8gjzlnoUxAoKivExchZKKI=
X-Google-Smtp-Source: AK7set+fSKmzs4msMrukUAYpzEAtIIuForVzV1d56gIL7HgeIIg8/V8ApAM576tUsxHihha54pYg4g==
X-Received: by 2002:a5d:4105:0:b0:2c5:5eff:5c81 with SMTP id l5-20020a5d4105000000b002c55eff5c81mr19270737wrp.38.1677473260421;
        Sun, 26 Feb 2023 20:47:40 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d54d0000000b002c71703876bsm5908843wrv.14.2023.02.26.20.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:47:40 -0800 (PST)
Date:   Mon, 27 Feb 2023 07:47:36 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kang Chen <void0red@gmail.com>
Cc:     paskripkin@gmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: add a null check of kzalloc in
 go_add_group_info_attr
Message-ID: <Y/w16PI4klfJaeXA@kadam>
References: <20230226132500.3933232-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226132500.3933232-1-void0red@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 09:25:00PM +0800, Kang Chen wrote:
> kzalloc may fails, pdata_attr might be null and will cause
> illegal address access later.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_p2p.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> index 93d3c9c43..802e1170a 100644
> --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> @@ -31,6 +31,8 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  
>  	pdata_attr = kzalloc(MAX_P2P_IE_LEN, GFP_KERNEL);
> +	if (!pdata_attr)
> +		return 0;

Return success here is not a good thing.  We have to fix the caller to
check for errors.  (Fixing a bug half way just makes it harder to find
the bug so it makes the situation worse).

regards,
dan carpenter

