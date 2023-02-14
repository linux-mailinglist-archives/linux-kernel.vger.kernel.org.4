Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE33695ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBNHlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:41:06 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7F19F2A;
        Mon, 13 Feb 2023 23:41:04 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id hx15so37850268ejc.11;
        Mon, 13 Feb 2023 23:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibr0JmwCf86ZCLRHWY3ftNxmBj8tH23Zp5NASkQDznI=;
        b=MbPBoAQXrEan+aQZnB45J5rjiDyfB9YMEWBH4qDDQj+2GGvoii48m/FKmmMMJZut5q
         seNUpOsHNIVTKr9lWIwWLeNJ4Ipg8WGfF/Fd1yZKjoiVkKLAMHf3sJrfkCPkDA5nfGXy
         ClSZsmZiWGnwb7eXwxjgZwxpku8HtlggvVkeMVxwxzOvTNoTy0+cAtUJFru5iE2KyiQV
         5iu7LmZXz4wST/siBYSdCcj9MrT01aVYWZqwP1RFiuOVIIVarefSc34b2dAygkx7N8Go
         p2Q6xWsPKusM8Oz7G63AcdEimNpOUtQYy/20xNlaXSeeOcyogJsj1kKEhfn9bFacV7BU
         7jcw==
X-Gm-Message-State: AO0yUKXNy7dYgTkTS5tSWVx2MfjPDGn+HlgktuLn7uDwQ9/plSlHZ4Ww
        60LGy1fK7bb3S5hr8idQQ+w=
X-Google-Smtp-Source: AK7set9pdCKpmJ0Gb/BFyXvdJCR2bz4uPy4FxqPlUKWIxlPdVwD7QxnW46TzsdOIJJlUKDmepQ9nsA==
X-Received: by 2002:a17:907:1108:b0:8af:305b:76af with SMTP id qu8-20020a170907110800b008af305b76afmr1544166ejb.33.1676360463008;
        Mon, 13 Feb 2023 23:41:03 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906580a00b0086f4b8f9e42sm7794220ejq.65.2023.02.13.23.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:41:02 -0800 (PST)
Message-ID: <5f67e2cf-f141-fde4-96de-28ceeeec9c06@kernel.org>
Date:   Tue, 14 Feb 2023 08:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230213140638.620206-1-fe@dev.tdt.de>
 <20230213140638.620206-2-fe@dev.tdt.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] tty: new helper function tty_get_mget
In-Reply-To: <20230213140638.620206-2-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 02. 23, 15:06, Florian Eckert wrote:
> For a given struct tty_struct, this provides the appropriate tty line
> state flags needed to add more modes to the ledtrig-tty trigger.
> 
> The new function is then used to get via tty_tiocmget() the different tty
> line states.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>   drivers/tty/tty_io.c | 32 +++++++++++++++++++++++++-------
>   include/linux/tty.h  |  3 ++-
>   2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 3149114bf130..e4dc59eda43f 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2493,26 +2493,44 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
>   	return retval;
>   }
>   
> +/*
> + * tty_get_mget		-	get modem status
> + * @tty: tty device
> + *
> + * Obtain the modem status bits from the tty driver if the feature
> + * is supported. Return -ENOTTY if it is not available.
> + *

Superfluous empty line.

> + */
> +

This empty line is even wrong wrt kernel-doc!

> +int tty_get_mget(struct tty_struct *tty)
> +{
> +	int retval = -ENOTTY;
> +
> +	if (tty->ops->tiocmget)
> +		retval = tty->ops->tiocmget(tty);
> +
> +	return retval;
> +}
...
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -419,8 +419,9 @@ void tty_unthrottle(struct tty_struct *tty);
>   int tty_throttle_safe(struct tty_struct *tty);
>   int tty_unthrottle_safe(struct tty_struct *tty);
>   int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
> -int tty_get_icount(struct tty_struct *tty,
> +int tty_get_icount(struct tty_struct *tty

The robot already complained about this ^^^.

Have you even tried to compile-test this?

>   		struct serial_icounter_struct *icount);
> +extern int tty_get_mget(struct tty_struct *tty);

No need for extern. Didn't you notice the surrounding declarations?

>   int is_current_pgrp_orphaned(void);
>   void tty_hangup(struct tty_struct *tty);
>   void tty_vhangup(struct tty_struct *tty);

thanks,
-- 
js
suse labs

