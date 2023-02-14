Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F416696EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBNUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjBNUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:55:11 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5942ED65;
        Tue, 14 Feb 2023 12:55:09 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a9so19811596ljr.13;
        Tue, 14 Feb 2023 12:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0pq+m0/U7p0zUEPB+aA1burF2pr6Ir+gD6+zbkqrV0=;
        b=MtWGP1nEjHF60A5txZB64h5a/LmqKrfw/Y93+e5WU2FPyj9Dmvba5OF/rzlL7gK2ha
         xVTMJJRaUhwWyuuFB53HyGNJlBYn0muYx9YGgHojo+dtnU3gyO15p8d/73BE+7vu5vkq
         McFlwAqqSE+Rtp+2J4EGGDCw9npIvMCEJlaVB3iSPwDeGqgu9aTBahKt2+CE6wkNz9LF
         7ogpFKfEk3/QwhAPCjGWafEnTMron826T+0D9pIRlx22eXGkjqHnP9TSaqBi6UIPyatW
         3FmKhQvYGiy2RjK7YMtJ6Yt1kh9Owni6IiOk4eFGyzUEwj3yVdNKcEf5sCVsfAUxiASF
         vpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0pq+m0/U7p0zUEPB+aA1burF2pr6Ir+gD6+zbkqrV0=;
        b=UVCDKoJSl4O4FCF6KPgE9psf6UySWOE2f1g9ILi/9ei8522VczbiyZgi7DC7+Q9r40
         r3UL3f1Ps353+BFyxql5zq8ZSYPov+JarnGrOEZn8NhX61JOvOQYKFkNJ7sZuPG470L9
         IUN4SBk+OZa63zCaaVtSfdaL1e/XuXyPuzuN5UhNjdRFqdDWW8Qk+qq2WBLuhTCB/1qT
         XocEvRtPip949QDBFUkWExGjDZnJ5aEAt2RCjmdw7qd74cq/ghk+P1le3dymP0rDtAze
         dLXKIoj6gC1QIDK0xvWXH0omFtok2aKGsFVpuHhsJJNdOXqcz1vGG8uiA/lRwBNEVk6z
         AEkw==
X-Gm-Message-State: AO0yUKUYRgMKIwMK66QmVRu8528p/MroZJ1zqtl8TSr5/5J19v45VcE5
        1hvW684N68YE0LvGMFmTKqCByG29WSY=
X-Google-Smtp-Source: AK7set8tW5JHF2lSbEiDoQt6ac7vS0uGvRLdYO+97v1LHbbm7fPh3T6bRGS90GYsdMNi6EPjYwZGnA==
X-Received: by 2002:a2e:9141:0:b0:293:4b8c:3b82 with SMTP id q1-20020a2e9141000000b002934b8c3b82mr1443045ljg.9.1676408107510;
        Tue, 14 Feb 2023 12:55:07 -0800 (PST)
Received: from [192.168.1.103] ([178.176.75.124])
        by smtp.gmail.com with ESMTPSA id g7-20020a2e9e47000000b002932b817990sm2479168ljk.31.2023.02.14.12.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 12:55:07 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH 08/12] pata_parport: use dev_* and print_hex_* instead of
 printk
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211144232.15138-1-linux@zary.sk>
 <20230211144232.15138-9-linux@zary.sk>
Message-ID: <a51aa862-e713-5b7a-d86a-bebca092a54c@gmail.com>
Date:   Tue, 14 Feb 2023 23:55:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230211144232.15138-9-linux@zary.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again! :-)

   Resending the mail from Gmail account, as OMP account doesn't work ATM... :-/

On 2/11/23 5:42 PM, Ondrej Zary wrote:

> Use dev_info/dev_err/dev_dbg/print_hex_* instead of printk.
> Remove version print from log_adapter and meaningless VERSION defines.

   Sounds like this needs to be in a separate patch...

> Remove now useless verbose parameter of bpck6 module.

   This one too...

> Signed-off-by: Ondrej Zary <linux@zary.sk>
[...]

> diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
> index 89160a94b30e..d5bc419b2ab3 100644
> --- a/drivers/ata/pata_parport/bpck.c
> +++ b/drivers/ata/pata_parport/bpck.c
[...]
> @@ -421,24 +416,12 @@ static void bpck_log_adapter(struct pi_adapter *pi)
>  {	char	*mode_string[5] = { "4-bit","8-bit","EPP-8",
>  				    "EPP-16","EPP-32" };
>  	char scratch[128];
> -#ifdef DUMP_EEPROM
> -	int i;
> -#endif
>  
>  	bpck_read_eeprom(pi,scratch);
> -
> -#ifdef DUMP_EEPROM
> -	   for(i=0;i<128;i++)
> -		if ((scratch[i] < ' ') || (scratch[i] > '~'))
> -		    scratch[i] = '.';
> -	   printk("bpck EEPROM: %64.64s\n", scratch);
> -	   printk("             %64.64s\n", &scratch[64]);
> -#endif
> -
> -	printk("bpck %s, backpack %8.8s unit %d",
> -		BPCK_VERSION, &scratch[110], pi->unit);
> -	printk(" at 0x%x, mode %d (%s), delay %d\n",pi->port,
> -		pi->mode,mode_string[pi->mode],pi->delay);
> +	print_hex_dump_bytes("bpck EEPROM: ", DUMP_PREFIX_NONE, scratch, 128);

   Conversion to print_hex_dump_bytes() deserved its own patch, IMHO...

> +	dev_info(&pi->dev, "backpack %8.8s unit %d at 0x%x, mode %d (%s), delay %d\n",
> +		 &scratch[110], pi->unit, pi->port, pi->mode,
> +		 mode_string[pi->mode], pi->delay);
>  }
>  
>  static struct pi_protocol bpck = {
[...]
> diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
> index 9b8db1122154..92b359460e34 100644
> --- a/drivers/ata/pata_parport/frpw.c
> +++ b/drivers/ata/pata_parport/frpw.c
[...]
> @@ -272,11 +266,9 @@ static void frpw_log_adapter(struct pi_adapter *pi)
>  {       char    *mode_string[6] = {"4-bit","8-bit","EPP",
>  				   "EPP-8","EPP-16","EPP-32"};
>  
> -	printk("frpw %s, Freecom (%s) adapter at 0x%x, ",
> -		FRPW_VERSION,((pi->private%2) == 0)?"Xilinx":"ASIC",pi->port);
> -        printk("mode %d (%s), delay %d\n",pi->mode,
> -		mode_string[pi->mode],pi->delay);
> -
> +	dev_info(&pi->dev, "Freecom (%s) adapter at 0x%x, mode %d (%s), delay %d\n",
> +		 ((pi->private % 2) == 0) ? "Xilinx":"ASIC",

   Need to add the spaces around ':' as you added spaces around '?'...

[...]

MBR, Sergey
