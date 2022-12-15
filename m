Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD864E39B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLOWBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:01:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E387C248E3;
        Thu, 15 Dec 2022 14:01:30 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 17so471830pll.0;
        Thu, 15 Dec 2022 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tT3e/BlligUWUFhcZfX4iVlpqtA9bkBjABn6+pGDkBo=;
        b=Legp2iApAg21IOMNB/w8A4Pg82zRjGYDL1b8x97fAiSxxcv+HlX9V7BuC1PL8QVGhn
         mkp+qLcm5NOLpWgILHZFfOtkR8jhe7mvyOnsq4dR8c+WAfOYlsDCRJtP2FerRkW4XPLl
         u7Lo0mLMYmyB4HimZPgtetRp0VRpHqmDHXxti7mYvIHKbi1sYBTAUCC8zDG7kzohMsWM
         z+XM2QyL1FC8P+O1NnyVLq+pDS9BMtVsU67F6JEigptxT+Rnetz4tj8cb+yE3TP+4D22
         nilrfOApy4zY9PmwvP/NGQ6bwIsYJo1Qkl4SHV2ORFR1pPziUWuEG7DGDvntk6xfm8/K
         XjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT3e/BlligUWUFhcZfX4iVlpqtA9bkBjABn6+pGDkBo=;
        b=SqExFZf1GFWiWv2bo6WuZPBpv9wvs4C7BJUw0OFaXPxSXBhXvmeMw1+8E9QVGo7Tiy
         DQFArgFN50evZZaRWx0heToASt1EaO/XeXOFuVBjEME3UdVxwoLUSfWRK19Xd3xRl2wA
         piCK89hys+10KYH8WyFWKuSTt8d31bXFSj1NEdoT/0hkwCh9+nhwhFziADeKMS8XQ8ty
         F1tsfMxJSK4IRvFLXk+0Izo6H7TZT1hfoz74gbeZLgHz9gd0potRY48/PFVPXfRew5mZ
         Cpiht/kLZYBUqORfqr4oXUo45GcNpxTUE36USb7a8vwkNdeLwyPQzVwiJSRxr8E8Tkbt
         fxxA==
X-Gm-Message-State: ANoB5pnoUqgYmJ4hMuJTE8Mx7EmXHVHKFR8EfMbeZ+Zi9iNfnQ/GwBGq
        rsKoxkIeKlvFVDH6gehwFT4=
X-Google-Smtp-Source: AA0mqf4DqlzuM7laIaEvYTSbFNVU8bvo5QfFiwdX7jTZt4xcTeA0HUeubcr6MPPHgQkt8hggDGYAAg==
X-Received: by 2002:a17:903:1d1:b0:189:c47b:af27 with SMTP id e17-20020a17090301d100b00189c47baf27mr41321392plh.10.1671141690248;
        Thu, 15 Dec 2022 14:01:30 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6004:4a46:4691:4e2c])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902a38f00b00178b6ccc8a0sm132738pla.51.2022.12.15.14.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 14:01:29 -0800 (PST)
Date:   Thu, 15 Dec 2022 14:01:25 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Joe Wu <joewu@msi.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-input@vger.kernel.org, Derek Huang <derekhuang@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev,
        Douglas Anderson <dianders@chromium.org>,
        "Dustin L . Howett" <dustin@howett.net>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y5uZNVzEgsKzlPD0@google.com>
References: <20221215061550.18993-1-joewu@msi.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215061550.18993-1-joewu@msi.corp-partner.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Thu, Dec 15, 2022 at 02:15:50PM +0800, Joe Wu wrote:
> This patch is to add extra 3 buttons: 'brightness up',
> 'brightness down' and 'leave PC(cros) mode' to support
> monitor navigation function.

I understand "brightness up" and "brightness down" but I have no idea
what "leave PC(cros) mode" means. I also do not think we should be
abusing F13 for this.

Thanks.

> 
> Signed-off-by: Joe Wu <joewu@msi.corp-partner.google.com>
> 
> ---
> 
>  drivers/input/keyboard/cros_ec_keyb.c          | 15 +++++++++++++++
>  include/linux/platform_data/cros_ec_commands.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index c14136b733a9..bf1cf0b782d2 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -100,6 +100,21 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
>  		.code		= KEY_VOLUMEDOWN,
>  		.bit		= EC_MKBP_VOL_DOWN,
>  	},
> +	{
> +		.ev_type        = EV_KEY,
> +		.code           = KEY_BRIGHTNESSUP,
> +		.bit            = EC_MKBP_BRI_UP,
> +	},
> +	{
> +		.ev_type        = EV_KEY,
> +		.code           = KEY_BRIGHTNESSDOWN,
> +		.bit            = EC_MKBP_BRI_DOWN,
> +	},
> +	{
> +		.ev_type        = EV_KEY,
> +		.code           = KEY_F13,
> +		.bit            = EC_MKBP_CROS_LEAVE,
> +	},
>  
>  	/* Switches */
>  	{
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 5744a2d746aa..79218da8a8cb 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3471,6 +3471,9 @@ struct ec_response_get_next_event_v1 {
>  #define EC_MKBP_VOL_UP		1
>  #define EC_MKBP_VOL_DOWN	2
>  #define EC_MKBP_RECOVERY	3
> +#define EC_MKBP_BRI_UP          4
> +#define EC_MKBP_BRI_DOWN        5
> +#define EC_MKBP_CROS_LEAVE      6
>  
>  /* Switches */
>  #define EC_MKBP_LID_OPEN	0
> -- 
> 2.17.1
> 

-- 
Dmitry
