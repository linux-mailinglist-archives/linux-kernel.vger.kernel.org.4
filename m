Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0FC5E9A50
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiIZHQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiIZHQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:16:51 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55532052;
        Mon, 26 Sep 2022 00:16:46 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id bq9so8740469wrb.4;
        Mon, 26 Sep 2022 00:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ioYGPRvwOzTPXX99j4J/86pZ+x1+n0p+8AnOz//0Jhc=;
        b=oaXmMK7zWNr/X2XgflIbyeGIUvEvSyxF0uMyTxiCcDBXg4QqC2ZrgHKmtpYSgeDbOG
         MRSySzK3ru2WA21EeskQfK5/ynq7a+ToEcJFd+iKMq7vtgXzp9ngH90DzJvZtmOgl4uZ
         jQsw2knzf+NYdKPjQZMSuXROCbDVjSPzJVrNoYHxqep2EkYrVEINU/xMfHLm3sRBX13g
         6BFbkdg+Jv9R1Dan5HyxXy3f9Ycd2VH7u4RUHxYBVsitpdbjvF77uOmO2/Az/JHbum0g
         OWfnCSODOb1GAHYJMOgIFZrjqZDrBmBUa1xBfj/L2Fp19uRHmNLqAdKJGfzrS+oc0hA4
         XmPQ==
X-Gm-Message-State: ACrzQf1qOe8z7Y8DuBRTQEffeFYr2rGsI0ZJggtCcyz5T+XhG6crfxYn
        pa7ng2CoTV/TjR5kcx1lPg++dMjaUME=
X-Google-Smtp-Source: AMsMyM6PzY2abUiBbLPacTKWhY3Ho5enMulUINnroWZ+u5YNMzPvvIkUrzm3gGWeVYZ8yYDHKpt7/w==
X-Received: by 2002:a5d:47cc:0:b0:22c:86fe:ad94 with SMTP id o12-20020a5d47cc000000b0022c86fead94mr9236407wrc.599.1664176604539;
        Mon, 26 Sep 2022 00:16:44 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003b4fe03c881sm10532225wmo.48.2022.09.26.00.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 00:16:44 -0700 (PDT)
Message-ID: <f61a3a55-808e-01cc-287e-d840f7948d2f@kernel.org>
Date:   Mon, 26 Sep 2022 09:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] serial: 8250: Fix restoring termios speed after suspend
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220924104324.4035-1-pali@kernel.org>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220924104324.4035-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 09. 22, 12:43, Pali Rohár wrote:
> Since commit edc6afc54968 ("tty: switch to ktermios and new framework")
> termios speed is no longer stored only in c_cflag member but also in new
> additional c_ispeed and c_ospeed members. If BOTHER flag is set in c_cflag
> then termios speed is stored only in these new members.
> 
> Since commit 027b57170bf8 ("serial: core: Fix initializing and restoring
> termios speed") termios speed is available also in struct console.
> 
> So properly restore also c_ispeed and c_ospeed members after suspend to fix
> restoring termios speed which is not represented by Bnnn constant.
> 
> Fixes: 4516d50aabed ("serial: 8250: Use canary to restart console after suspend")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>   drivers/tty/serial/8250/8250_port.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 39b35a61958c..441f317c55af 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3314,8 +3314,13 @@ static void serial8250_console_restore(struct uart_8250_port *up)
>   	unsigned int baud, quot, frac = 0;
>   
>   	termios.c_cflag = port->cons->cflag;
> -	if (port->state->port.tty && termios.c_cflag == 0)
> +	termios.c_ispeed = port->cons->ispeed;
> +	termios.c_ospeed = port->cons->ospeed;
> +	if (port->state->port.tty && termios.c_cflag == 0) {

I don't currently know how safe it is to assume port->state->port.tty 
cannot change between the test above and the dereferences below.

In anyway, you should cache it as it is used 4 times now. It would make 
the code definitely more readable.

>   		termios.c_cflag = port->state->port.tty->termios.c_cflag;
> +		termios.c_ispeed = port->state->port.tty->termios.c_ispeed;
> +		termios.c_ospeed = port->state->port.tty->termios.c_ospeed;
> +	}
>   
>   	baud = serial8250_get_baud_rate(port, &termios, NULL);
>   	quot = serial8250_get_divisor(port, baud, &frac);

-- 
js
suse labs

