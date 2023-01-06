Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1048965FC31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjAFHhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjAFHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:36:43 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EBDB43;
        Thu,  5 Jan 2023 23:36:42 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id s9so514208wru.13;
        Thu, 05 Jan 2023 23:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzVe0pLyjmPge14+7JwNFlVI9TqNDRuuVylOl2kg1Co=;
        b=lI6epv+Y5sX3ssp9XynYH8y+m+luFo6GyWUtpBL+kXwvoKfjjzcFvi+xyu73XqHuXO
         siAbQzHpcv0hHPtHzdfHmGius642dYcJ5wymj//N53ZEhhpMWBltBSnJsCpgoiSl18nz
         gyYRjUX/MHO2LCPhEK+3WeD0QVw2DTPxPoRj/dqEf1AhrcxATHk55WpeOi2Ky0G3rZoF
         SzeI4Wq53jKu9Vg7NlIwCZC4Lzz4qBEJdbcaoB0lveOtkojJ2mgf7PKprmKmL7zHuRAX
         HFiAnXWCyQ0wF5fkvGd438y8YN38IS31nyzxFOEfxAbu0WvSf6Ml+3VQoik5aB3CImgH
         RSjg==
X-Gm-Message-State: AFqh2krdw1stMQjn1XofBm6xjXDQ2RovywESTCAqe99JdmAXTI/zGWv4
        q3wmsd95ARyKqo1xF7anO3W2dI+c7Wg=
X-Google-Smtp-Source: AMrXdXtPt0ag0rkCaE4nqXFoISH+uK3Zzq0fB085NZaWE0JE1aLA0Qe/fAu/SFnXktbO+CQ3h3sAGQ==
X-Received: by 2002:a5d:67c3:0:b0:2a4:bd16:2931 with SMTP id n3-20020a5d67c3000000b002a4bd162931mr6037393wrw.62.1672990600904;
        Thu, 05 Jan 2023 23:36:40 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id v14-20020adff68e000000b002365730eae8sm362278wrp.55.2023.01.05.23.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 23:36:40 -0800 (PST)
Message-ID: <d5c3269e-b91b-087f-6b85-f5d55a9f7185@kernel.org>
Date:   Fri, 6 Jan 2023 08:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230105124744.105950-1-ilpo.jarvinen@linux.intel.com>
 <20230105124744.105950-2-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/3] serial: 8250: RT288x/Au1xxx code away from core
In-Reply-To: <20230105124744.105950-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 01. 23, 13:47, Ilpo Järvinen wrote:
> A non-trivial amount of RT288x/Au1xxx code is encapsulated into
> ifdeffery in 8250_port / 8250_early and some if UPIO_AU blocks.
> 
> Create a separate file from them. Add mapsize, bugs, and divisor latch
> read/write functions into plat_serial8250_port to carry the setup
> necessary for these devices over to uart port.
> 
> Also handle errors properly in the cases where RT288x/Au1xxx code is
> not configured.
> 
> It seems that 0x1000 mapsize is likely overkill but I've kept it the
> same as previously (the value was shrunk to that value in b2b13cdfd05e
> ("SERIAL 8250: Fixes for Alchemy UARTs.")). Seemingly, the driver only
> needs to access register at 0x28 for the divisor latch.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
...
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
...
> @@ -28,8 +32,11 @@ struct plat_serial8250_port {
>   	unsigned char	has_sysrq;	/* supports magic SysRq */
>   	upf_t		flags;		/* UPF_* flags */
>   	unsigned int	type;		/* If UPF_FIXED_TYPE */
> +	unsigned short	bugs;		/* port bugs */
>   	unsigned int	(*serial_in)(struct uart_port *, int);
>   	void		(*serial_out)(struct uart_port *, int, int);
> +	int		(*dl_read)(struct uart_8250_port *);
> +	void		(*dl_write)(struct uart_8250_port *, int);

int sounds very weird in the write-to-HW context. Even though both the 
others and the original are ints. They all should be simply u32.

>   	void		(*set_termios)(struct uart_port *,
>   			               struct ktermios *new,
>   			               const struct ktermios *old);

Could you document the new ones in the kernel-doc manner above the 
structure (but so far without the kernel-doc tag /**). So that:
1) they are documented
2) once someone decides to document them all, they can simply stick the 
kernel-doc tag and document only the rest.

thanks,
-- 
js
suse labs

