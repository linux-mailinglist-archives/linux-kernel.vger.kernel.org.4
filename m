Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF73E72B735
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjFLFNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFLFNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:13:11 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDD5FB;
        Sun, 11 Jun 2023 22:13:10 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9788554a8c9so694996966b.2;
        Sun, 11 Jun 2023 22:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686546788; x=1689138788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/kWdHQ/ZksQh1sHAU7xUcJLGSlV/yI789RhpZXKfRE=;
        b=I0hv7Y3x3lI8M8nD9Kho2cAa8R77wpfqJqhIk5AJMqb3LrbNx5Pe4/KynmFyEdgQDq
         uIP9thrWTQaM/0Kn7XF9s+NtmBeBiuUeXHjAKQbhDvbVxWwD15zf9BdbP66wWoQKoY/2
         kJoX5NUdgYjtuAuijcryB68Y5QD2YLqzaNpiz5qsdFthVhO01tE1qipGEQn5WV1UAi7L
         AlY4Al5L+dkziJdnykDfln2iAdepVbBHgYy6V0MX0yBiFbGt2Clqe8E99iyb3obme6cF
         os+zJQDU4BZlXJgYvdgJ+wuM2hXoB/PZOg8zfl5HQtYnPw/h3KXBjOs5U1JKdUMwAWgw
         d6hQ==
X-Gm-Message-State: AC+VfDxDvhHqpNfPEqgyUFvRYji/zIOK4JznsN5iQ03hZ54LVLG9fM25
        0CAMQRtSD+He0/SmoZZUfUI=
X-Google-Smtp-Source: ACHHUZ5c17qY5AyhpjBNaSKA+UiVrfEBjtFC1aShHzbmMUc0ji2I5r6GGQz2+rH2btH2xcInHkbe1A==
X-Received: by 2002:a17:907:7285:b0:953:517a:8f1a with SMTP id dt5-20020a170907728500b00953517a8f1amr9576993ejc.58.1686546787978;
        Sun, 11 Jun 2023 22:13:07 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090633cc00b00965f31ff894sm4587641eja.137.2023.06.11.22.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 22:13:07 -0700 (PDT)
Message-ID: <69054d03-39e5-8c42-a9a9-8934ab4bf6c9@kernel.org>
Date:   Mon, 12 Jun 2023 07:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] tty: serial: samsung_tty: Use abs() to simplify
 some code
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Walter Harms <wharms@bfs.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
 <7bd165e82ed3675d4ddee343ab373031e995a126.1686412569.git.christophe.jaillet@wanadoo.fr>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <7bd165e82ed3675d4ddee343ab373031e995a126.1686412569.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 06. 23, 17:59, Christophe JAILLET wrote:
> Use abs() instead of hand-writing it.
> 
> Suggested-by: Walter Harms <wharms@bfs.de>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: new patch
> ---
>   drivers/tty/serial/samsung_tty.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 0b37019820b4..b29e9dfd81a6 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -24,6 +24,7 @@
>   #include <linux/dmaengine.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/slab.h>
> +#include <linux/math.h>
>   #include <linux/module.h>
>   #include <linux/ioport.h>
>   #include <linux/io.h>
> @@ -1485,9 +1486,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>   		}
>   		quot--;
>   
> -		calc_deviation = req_baud - baud;
> -		if (calc_deviation < 0)
> -			calc_deviation = -calc_deviation;
> +		calc_deviation = abs(req_baud - baud);

Does this work provided req_baud and baud are unsigned?

thanks,
-- 
js
suse labs

