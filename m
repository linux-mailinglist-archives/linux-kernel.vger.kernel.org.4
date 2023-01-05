Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77065E5A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjAEG2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjAEG23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:28:29 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679BA50F55;
        Wed,  4 Jan 2023 22:28:28 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id gh17so87995595ejb.6;
        Wed, 04 Jan 2023 22:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6ns4ugZeKhq6AEZuEwHEVN2cWVAPxdt18M+sWa8jps=;
        b=jhi53DJNdnkr6+ZOVD5bgfuZ/wK3wo2NJNJ08V3+ILq1Mtq8OzG6/VQ+ocsiQl4Q1D
         0IoWHmIgwDek83Kl+6y2HKr1HD4S3QuhTWHw4QyI9hpwxxgTSt0O4a+Ew/ZE0cghdwWA
         U2jYR8t42v8RhzexxasVXmW8YIUFlwmXkaPzXyWeSi5APnHbrcLX/gTjWfOT0na/uY3d
         9MS0RNFhKJepFXAwwvk5NBO2lTRmZfRy2EFEGPIRXWYVkRe05dB2OFHcvj8Ll7bLHyYX
         pMFQRnzWU+nXjIGRUtDY3nGls+bahpRK5TgXWRnfzOx6kwwQ9o460y+IhJ5eXtPbbbfc
         3HcA==
X-Gm-Message-State: AFqh2krlFWqSqADS/5QXezjlN3vW3dSVhedmMagZ4NpDXA/hV9Zd3P8s
        i8/4ifhTw8bNID7QXnezsgQ=
X-Google-Smtp-Source: AMrXdXuFMK4nHIdmvrTluR1wPLW23pwWT8qD02Jm9O9l81qxkKLjpIoT94SwlYpr4DA2/WiQulXcxQ==
X-Received: by 2002:a17:906:6dcb:b0:7e7:4dd7:bbcc with SMTP id j11-20020a1709066dcb00b007e74dd7bbccmr44144221ejt.73.1672900106951;
        Wed, 04 Jan 2023 22:28:26 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id tz6-20020a170907c78600b007c0d0dad9c6sm16098840ejc.108.2023.01.04.22.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:28:26 -0800 (PST)
Message-ID: <349bca60-7d64-6329-8d3d-d645fc297ea3@kernel.org>
Date:   Thu, 5 Jan 2023 07:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 10/10] tty: Return bool from tty_termios_hw_change()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-11-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230104151531.73994-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 01. 23, 16:15, Ilpo Järvinen wrote:
> Change tty_termios_hw_change() return to bool and convert it to

If you are going to resend, should it be "to return bool" instead?

> a or-chained return statement.

and s/a/an/

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/tty_ioctl.c | 10 ++++------
>   include/linux/tty.h     |  2 +-
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index ce511557b98b..4a80fabf6d5e 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -270,13 +270,11 @@ EXPORT_SYMBOL(tty_termios_copy_hw);
>    *	between the two termios structures, or a speed change is needed.
>    */
>   
> -int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
> +bool tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
>   {
> -	if (a->c_ispeed != b->c_ispeed || a->c_ospeed != b->c_ospeed)
> -		return 1;
> -	if ((a->c_cflag ^ b->c_cflag) & ~(HUPCL | CREAD | CLOCAL))
> -		return 1;
> -	return 0;
> +	return a->c_ispeed != b->c_ispeed ||
> +	       a->c_ospeed != b->c_ospeed ||
> +	       (a->c_cflag ^ b->c_cflag) & ~(HUPCL | CREAD | CLOCAL);
>   }
>   EXPORT_SYMBOL(tty_termios_hw_change);
>   
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 730c3301d710..093935e97f42 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -453,7 +453,7 @@ unsigned char tty_get_char_size(unsigned int cflag);
>   unsigned char tty_get_frame_size(unsigned int cflag);
>   
>   void tty_termios_copy_hw(struct ktermios *new, const struct ktermios *old);
> -int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
> +bool tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
>   int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
>   
>   void tty_wakeup(struct tty_struct *tty);

-- 
js
suse labs

