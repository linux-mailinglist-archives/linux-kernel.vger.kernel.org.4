Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA10964F54C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiLPXmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLPXmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:42:50 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFE41659C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:42:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gt4so3942887pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8eMlqU7UDnLX/up+pVxkrc5BZW7H9Ol2LWdKZ84nYg=;
        b=dQUikkg6hkuWWwRBdf1oCF9eqzcRBkkg2ys4s1YdEuypaPDJaW03Dw8IAYlZGvfcCD
         Z6Ye0wgulKIK0S/urmlNj1Kife5UHjEQwBvxS5Xr+KfyAnyKqZ20rIACHvf+Q5zByvYz
         ZhkTSL7QpnqUE65j/waG4wk6X26fJb4ky297k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8eMlqU7UDnLX/up+pVxkrc5BZW7H9Ol2LWdKZ84nYg=;
        b=NxCZOWEzdWreDzOIJQK6qX6tj/K1dGqYDwezrpp6VOCQLfBorEVCHuik3exrU1AwFS
         hkS3BziiWhYE38Cr8ZN2m6MBqR8vHGdzUkuw6jt7uWbLq/KODidrAwMTGavr3UUhFvo6
         E3vgZFlyDBax5rbETTF/8UzJh4ZKJ4urg1h3KYReSAHCmSWTvPaNA6yBod7JWmlOxIG8
         9KWlYu1UuxVOK2fGvvJ/E04C7EZ560lZltEw1QiKY04n3VQueTGPbNbwySsf41UkRI65
         yAz9h0BnNm6aCt173HlMgjbbOwAjljemxFzk8ZKQHnhdAuvwznh0l5JLpNMr3g8FikfU
         fY6w==
X-Gm-Message-State: ANoB5pmpLkSfn1vDgiQv6iw6RegC1wwVK9+jNnKUqtPlRoeDy2uYNA91
        tUpl4/2CjlNTDARLWFX3cK1OdA==
X-Google-Smtp-Source: AA0mqf5Mex4CAF1HE8L5uPi4ordZdIeQ33YE9Tyt04Vb9YIponYEVEdQAm+0OdNA8S7D6ecjR9yHxA==
X-Received: by 2002:a05:6a20:a692:b0:ad:ceba:1bdc with SMTP id ba18-20020a056a20a69200b000adceba1bdcmr23566045pzb.16.1671234169249;
        Fri, 16 Dec 2022 15:42:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 7-20020a631347000000b0047063eb4098sm2011111pgt.37.2022.12.16.15.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:42:48 -0800 (PST)
Date:   Fri, 16 Dec 2022 15:42:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] [next] pcmcia: synclink_cs: replace 1-element array
 with flex-array member
Message-ID: <202212161542.CA466D97B@keescook>
References: <Y5uN9Rr3v1uWH765@mail.google.com>
 <Y5z4Og3XmCGQwTO9@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5z4Og3XmCGQwTO9@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 11:59:06AM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct RXBUF and refactor the rest of the code
> accordingly. While at it, fix an edge case which could cause
> rx_buf_count to be 0 when max_frame_size was set to the maximum
> allowed value (65535).
> 
> It's worth mentioning that struct RXBUF was allocating 1 byte "too much"
> for what is required (ignoring bytes added by padding).

What was the result of using __packed to make sure there wasn't a sizing
error?

-Kees

> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
> 
> - v3:
>   fix size calculation mistakes using overflow.h macros: (Req: Andy
>   Shevchenko, Kees Cook)
>   add notes struct RXBUF size (Kees Cook)
> 
> - v2: removed changes to how the size of RXBUF was calculated. I
>   changed my mind after thinking about the existing padding in the
>   struct. Happy to discuss it if anyone sees it differently.
> 
> - v1: https://lore.kernel.org/lkml/Y5mMWEtHWKOiPVU+@mail.google.com/
> ---
>  drivers/char/pcmcia/synclink_cs.c | 33 +++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index b2735be81ab2..eee6772a0978 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -105,7 +105,7 @@ static MGSL_PARAMS default_params = {
>  typedef struct {
>  	int count;
>  	unsigned char status;
> -	char data[1];
> +	char data[];
>  } RXBUF;
>  
>  /* The queue of BH actions to be performed */
> @@ -229,12 +229,18 @@ typedef struct _mgslpc_info {
>  } MGSLPC_INFO;
>  
>  #define MGSLPC_MAGIC 0x5402
> +#define MGSLPC_MAX_FRAME_SIZE 65535
> +#define MGSLPC_MIN_FRAME_SIZE 4096
>  
>  /*
>   * The size of the serial xmit buffer is 1 page, or 4096 bytes
>   */
>  #define TXBUFSIZE 4096
>  
> +/*
> + * RXBUF accommodates at least 1 buffer (header+data) of MGSLPC_MAX_FRAME_SIZE
> + */
> +#define RXBUF_MAX_SIZE (sizeof(RXBUF) + MGSLPC_MAX_FRAME_SIZE)
>  
>  #define CHA     0x00   /* channel A offset */
>  #define CHB     0x40   /* channel B offset */
> @@ -529,7 +535,7 @@ static int mgslpc_probe(struct pcmcia_device *link)
>  	tty_port_init(&info->port);
>  	info->port.ops = &mgslpc_port_ops;
>  	INIT_WORK(&info->task, bh_handler);
> -	info->max_frame_size = 4096;
> +	info->max_frame_size = MGSLPC_MIN_FRAME_SIZE;
>  	init_waitqueue_head(&info->status_event_wait_q);
>  	init_waitqueue_head(&info->event_wait_q);
>  	spin_lock_init(&info->lock);
> @@ -2611,19 +2617,20 @@ static int mgslpc_proc_show(struct seq_file *m, void *v)
>  static int rx_alloc_buffers(MGSLPC_INFO *info)
>  {
>  	/* each buffer has header and data */
> -	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> +	if (check_add_overflow(sizeof(RXBUF), info->max_frame_size, &info->rx_buf_size))
> +		return -EINVAL;
>  
> -	/* calculate total allocation size for 8 buffers */
> -	info->rx_buf_total_size = info->rx_buf_size * 8;
> +	/* try to alloc as many buffers that can fit within RXBUF_MAX_SIZE (up to 8) */
> +	if (check_mul_overflow(info->rx_buf_size, 8, &info->rx_buf_total_size))
> +		return -EINVAL;
>  
> -	/* limit total allocated memory */
> -	if (info->rx_buf_total_size > 0x10000)
> -		info->rx_buf_total_size = 0x10000;
> +	if (info->rx_buf_total_size > RXBUF_MAX_SIZE)
> +		info->rx_buf_total_size = RXBUF_MAX_SIZE;
>  
>  	/* calculate number of buffers */
>  	info->rx_buf_count = info->rx_buf_total_size / info->rx_buf_size;
>  
> -	info->rx_buf = kmalloc(info->rx_buf_total_size, GFP_KERNEL);
> +	info->rx_buf = kcalloc(info->rx_buf_count, info->rx_buf_size, GFP_KERNEL);
>  	if (info->rx_buf == NULL)
>  		return -ENOMEM;
>  
> @@ -2695,10 +2702,10 @@ static int mgslpc_add_device(MGSLPC_INFO *info)
>  		current_dev->next_device = info;
>  	}
>  
> -	if (info->max_frame_size < 4096)
> -		info->max_frame_size = 4096;
> -	else if (info->max_frame_size > 65535)
> -		info->max_frame_size = 65535;
> +	if (info->max_frame_size < MGSLPC_MIN_FRAME_SIZE)
> +		info->max_frame_size = MGSLPC_MIN_FRAME_SIZE;
> +	else if (info->max_frame_size > MGSLPC_MAX_FRAME_SIZE)
> +		info->max_frame_size = MGSLPC_MAX_FRAME_SIZE;
>  
>  	printk("SyncLink PC Card %s:IO=%04X IRQ=%d\n",
>  		info->device_name, info->io_base, info->irq_level);
> -- 
> 2.38.1
> 

-- 
Kees Cook
