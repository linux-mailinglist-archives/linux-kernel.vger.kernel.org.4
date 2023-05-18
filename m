Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9624C7086BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjERRYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjERRYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:24:48 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA61BC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:24:47 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33550237f6fso17843265ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684430687; x=1687022687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hywhvRw5FPWeQqeSjCDIST6iJlDQulZr0/+R915twUw=;
        b=IYeiL9EihSFckDbegyPZ4kzoYz0iHP59St91qSK0vum7W3w+gOnaVjwyoZZPZ31kzf
         H3kSvTnY5sMRy/1mc5f45lmgksA+QBOGdCcBc/hnbJFXNauftlKgvXRvGEz2AB/S3xEa
         OxshL3JZAlpyzPR8qZGwExTejSecgT0zj60G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684430687; x=1687022687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hywhvRw5FPWeQqeSjCDIST6iJlDQulZr0/+R915twUw=;
        b=ku5uNwVxF8QW691OM3chbWLUb9Vt35MI0osEg7CHmaoKAo7xRN45iZhrS+c1dTmwM5
         GBbYBA1E/p2wKE9+KPlH9OzUIXEeVkjoXGtnmCafgD1U35EybrHBaU5xBRYRt7R6KtIk
         Z/UFZbuILNtLGiC6VNY4HVE+CDIGG2sbNcCV8idDKgxD7upvM7xFE9MIGQL8MmUTeuyX
         DO/fnJ2+QYCvwOIeBaitvFMyFKCFPosS8ptALjyyxuD4zqcuLM3BM1K0yz7AlKzkSUdV
         WnQldlIPt1QiBAGrw04/BcYUNwUB9cI/fj4IaQO57ml2LKEfKVsu8d0o4/Bnn99oXZUm
         UHYA==
X-Gm-Message-State: AC+VfDxTqmvCfbqgaPp7MspEQndvBH+SaU1a3/bBcR1fzD0245NEO7FD
        eegso+SHd907cYO9kKDWaWbMcgss3jKcz6whqyfs2g==
X-Google-Smtp-Source: ACHHUZ5pKHDVk60vj7I8yaEz5EBMcA4h/dwM6fOQSeBRzzl7digIzqatgIRbVvmqdGwDTkEmyAIUqQ==
X-Received: by 2002:a92:d247:0:b0:335:c68d:bef1 with SMTP id v7-20020a92d247000000b00335c68dbef1mr5487410ilg.8.1684430687083;
        Thu, 18 May 2023 10:24:47 -0700 (PDT)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id z16-20020a92ced0000000b00313ca4be5e1sm469641ilq.12.2023.05.18.10.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:24:46 -0700 (PDT)
Date:   Thu, 18 May 2023 11:24:44 -0600
From:   Raul E Rangel <rrangel@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Input: libps2 - do not discard non-ack bytes when
 controlling LEDs
Message-ID: <ZGZfXOwnEi8hYKlv@google.com>
References: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
 <20230511185252.386941-8-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511185252.386941-8-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:52:47AM -0700, Dmitry Torokhov wrote:
> Upon receiving a PS/2 command the device and controller are supposed to
> stop sending normal data (scancodes or movement packets) and instead
> immediately start delivering ACK/NAK and command response. Unfortunately
> often EC has an output buffer which may contain latched data by the time
> the EC receives a command from the host. The kernel used to ignore such
> data, but that may cause "stuck" keys if the data dropped happens to be a
> break code or a part of a break code. This occasionally happens, for
> example, on Chromebooks when the kernel tries to toggle CapsLock LED on
> a keyboard while user releases Alt+Search keyboard shortcut.
> 
> Fix this by passing the first non-ACK byte to the normal handler for a
> handful of PS/2 commands that are expected to be used during normal device
> operation (as opposed to probe/configuration time).
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/serio/libps2.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> index 7c5fc853072a..6d78a1fe00c1 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -21,7 +21,10 @@
>  
>  #define PS2_CMD_SETSCALE11	0x00e6
>  #define PS2_CMD_SETRES		0x10e8
> +#define PS2_CMD_EX_SETLEDS	0x20eb
> +#define PS2_CMD_SETLEDS		0x10ed
>  #define PS2_CMD_GETID		0x02f2
> +#define PS2_CMD_SETREP		0x10f3 /* Set repeat rate/set report rate */
>  #define PS2_CMD_RESET_BAT	0x02ff
>  
>  #define PS2_RET_BAT		0xaa
> @@ -35,6 +38,7 @@
>  #define PS2_FLAG_CMD1		BIT(2)	/* Waiting for the first byte of command response */
>  #define PS2_FLAG_WAITID		BIT(3)	/* Command executing is GET ID */
>  #define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
> +#define PS2_FLAG_PASS_NOACK	BIT(5)	/* Pass non-ACK byte to receive handler */
>  
>  static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte,
>  			   unsigned int timeout, unsigned int max_attempts)
> @@ -281,9 +285,28 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
>  
>  	serio_pause_rx(ps2dev->serio);
>  
> -	/* Some mice do not ACK the "get ID" command, prepare to handle this. */
> -	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
>  	ps2dev->cmdcnt = receive;
> +
> +	switch (command) {
> +	case PS2_CMD_GETID:
> +		/*
> +		 * Some mice do not ACK the "get ID" command, prepare to
> +		 * handle this.
> +		 */
> +		ps2dev->flags = PS2_FLAG_WAITID;
> +		break;
> +
> +	case PS2_CMD_SETLEDS:
> +	case PS2_CMD_EX_SETLEDS:
> +	case PS2_CMD_SETREP:
> +		ps2dev->flags = PS2_FLAG_PASS_NOACK;
> +		break;
> +
> +	default:
> +		ps2dev->flags = 0;
> +		break;
> +	}
> +
>  	if (receive) {
>  		/* Indicate that we expect response to the command. */
>  		ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
> @@ -512,14 +535,19 @@ static void ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
>  		 * Do not signal errors if we get unexpected reply while
>  		 * waiting for an ACK to the initial (first) command byte:
>  		 * the device might not be quiesced yet and continue
> -		 * delivering data.
> +		 * delivering data. For certain commands (such as set leds and
> +		 * set repeat rate) that can be used during normal device
> +		 * operation, we even pass this data byte to the normal receive
> +		 * handler.
>  		 * Note that we reset PS2_FLAG_WAITID flag, so the workaround
>  		 * for mice not acknowledging the Get ID command only triggers
>  		 * on the 1st byte; if device spews data we really want to see
>  		 * a real ACK from it.
>  		 */
>  		dev_dbg(&ps2dev->serio->dev, "unexpected %#02x\n", data);
> -		ps2dev->flags &= ~PS2_FLAG_WAITID;
> +		if (ps2dev->flags & PS2_FLAG_PASS_NOACK)
> +			ps2dev->receive_handler(ps2dev, data);
> +		ps2dev->flags &= ~(PS2_FLAG_WAITID | PS2_FLAG_PASS_NOACK);
>  		return;
>  	}
>  

Great refactoring. It made this final patch super simple!

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
