Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6523A5FD4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJMGYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJMGYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:06 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B0112D830
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:24:03 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id t4so528820wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gjZZ7/Kg7/TXwaADKRZWpKNZKsMLdDzprHWHgT8uXE=;
        b=U2Vl/cZs+okm8uIGURJ7p0rFTrNTRAYIWBiGiFHb/gdnsqSqUeJUB8GPYb5EGpTKly
         NB1mR7ghMOPW40JGjikAOvbmBgraEZ674rHh9HQuy8O5uQ9/bgR6zvQp9Iv6nYUjb0RF
         pbYwzYXrACH9i2ZpvjHE/viUgiXI60+E5ivHQYtdkFGkeGTECCo09vLTnLjTGpD/sC/G
         ZFZZUhRM2Zk+EhWVWmx6Y3qZF5NETjALsntB6Gxae3trWLAsR8OlGgwngRdjUq80yh2K
         trpg2qMn3Bu9Y0fwPhJqvd5zxX6zL/NVxh+1l6J/PhbhKfj1xfGoM1YNxtdYq+gpY4w+
         XeFw==
X-Gm-Message-State: ACrzQf3jXCzyFfDOcdVHIOIspj6FpD9fSbU/np59pqm4OnTJaEkrH7kB
        BWVzdSeq+YAG6LKEr2YEM6HOIncvHZ1TPg==
X-Google-Smtp-Source: AMsMyM6wlrhDr8o6VC/11yjIGhyGVKWBo7O7gt3kViMhHTjlJD3FdY6SpNFSfm4mhYA4J625vaf+Eg==
X-Received: by 2002:a05:600c:3591:b0:3b4:bf48:9f10 with SMTP id p17-20020a05600c359100b003b4bf489f10mr5475506wmq.76.1665642242061;
        Wed, 12 Oct 2022 23:24:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003b4868eb71bsm3621593wmq.25.2022.10.12.23.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 23:24:01 -0700 (PDT)
Message-ID: <8e491117-241f-4000-2909-9d4db00ab6a9@kernel.org>
Date:   Thu, 13 Oct 2022 08:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH linux-next] serial: dz: use atomic_inc and atomic_dec
 instead of atomic_add
Content-Language: en-US
To:     xu.panda668@gmail.com, macro@orcam.me.uk
Cc:     linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20221012100916.347942-1-xu.panda668@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221012100916.347942-1-xu.panda668@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 10. 22, 12:09, xu.panda668@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> There is a better way for atomic_dec_return and atomic_inc.

While the patch below looks fine, I don't understand this sentence ^^^. 
Care to reformulate? And please append () when writing about function names.

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>   drivers/tty/serial/dz.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
> index 829b452daee9..84476cef3278 100644
> --- a/drivers/tty/serial/dz.c
> +++ b/drivers/tty/serial/dz.c
> @@ -404,14 +404,14 @@ static int dz_startup(struct uart_port *uport)
>   	int ret;
>   	u16 tmp;
>   
> -	irq_guard = atomic_add_return(1, &mux->irq_guard);
> +	irq_guard = atomic_inc_return(&mux->irq_guard);
>   	if (irq_guard != 1)
>   		return 0;
>   
>   	ret = request_irq(dport->port.irq, dz_interrupt,
>   			  IRQF_SHARED, "dz", mux);
>   	if (ret) {
> -		atomic_add(-1, &mux->irq_guard);
> +		atomic_dec(&mux->irq_guard);
>   		printk(KERN_ERR "dz: Cannot get IRQ %d!\n", dport->port.irq);
>   		return ret;
>   	}
> @@ -448,7 +448,7 @@ static void dz_shutdown(struct uart_port *uport)
>   	dz_stop_tx(&dport->port);
>   	spin_unlock_irqrestore(&dport->port.lock, flags);
>   
> -	irq_guard = atomic_add_return(-1, &mux->irq_guard);
> +	irq_guard = atomic_dec_return(&mux->irq_guard);
>   	if (!irq_guard) {
>   		/* Disable interrupts.  */
>   		tmp = dz_in(dport, DZ_CSR);
> @@ -668,7 +668,7 @@ static void dz_release_port(struct uart_port *uport)
>   	iounmap(uport->membase);
>   	uport->membase = NULL;
>   
> -	map_guard = atomic_add_return(-1, &mux->map_guard);
> +	map_guard = atomic_dec_return(&mux->map_guard);
>   	if (!map_guard)
>   		release_mem_region(uport->mapbase, dec_kn_slot_size);
>   }
> @@ -691,11 +691,11 @@ static int dz_request_port(struct uart_port *uport)
>   	int map_guard;
>   	int ret;
>   
> -	map_guard = atomic_add_return(1, &mux->map_guard);
> +	map_guard = atomic_inc_return(&mux->map_guard);
>   	if (map_guard == 1) {
>   		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
>   					"dz")) {
> -			atomic_add(-1, &mux->map_guard);
> +			atomic_dec(&mux->map_guard);
>   			printk(KERN_ERR
>   			       "dz: Unable to reserve MMIO resource\n");
>   			return -EBUSY;
> @@ -703,7 +703,7 @@ static int dz_request_port(struct uart_port *uport)
>   	}
>   	ret = dz_map_port(uport);
>   	if (ret) {
> -		map_guard = atomic_add_return(-1, &mux->map_guard);
> +		map_guard = atomic_dec_return(&mux->map_guard);
>   		if (!map_guard)
>   			release_mem_region(uport->mapbase, dec_kn_slot_size);
>   		return ret;

-- 
js
suse labs

