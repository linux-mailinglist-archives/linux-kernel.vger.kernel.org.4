Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792C06ABA39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCFJnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCFJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:43:18 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096DB44D;
        Mon,  6 Mar 2023 01:43:16 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id ay14so32161874edb.11;
        Mon, 06 Mar 2023 01:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pu1rmKeKz2ed6zEvq5/nqsVlZSSb14LZ7R+ktLj7zWo=;
        b=rGhys7i/vvYUAJLN2NdtWSpIxKfnextQvHS25iwmvv9ZpczI4Mz5RnZWEG+3Hjj/Hv
         70co3Bty7uHmOVKDSExO9LdlXGIrzQraMVI6UpC0M3JSZIdyPxk4aQWRQQ9uHK0qJCDR
         06DtJBRrWYQt3CJpAnR0fWCwq7/grT08debBFFg8gm96Vz/RXXtZl/atEUABv9JxrB/g
         3AgSneE9qvAq1QuUVWM4WDLGR9HC2PDFZrqs7qLzSVBl2vZ+uQIXOHUaX/RJiPCDiAF3
         6hQE7dmAa54rHJiodmfNgeqX+x9eZV6dp7LVkULsUkQsNYEfr3N27/OrNbbpd8VPLRwU
         kmLg==
X-Gm-Message-State: AO0yUKWZP+0C2rTmoeBPvh23R5B2K/WeOhpMMBdJamC55GbSSzLtvEIc
        ZtAUbGbyQ3wD4fVprUkxSzNh1/k+zQdcog==
X-Google-Smtp-Source: AK7set9t9Kt9gObUCcl+ZVJIw4DSQC2kmQkad89NJXmR7mZ1UThEg2xQM1b5/sxVc2KmOgWHrcoMMQ==
X-Received: by 2002:a17:907:20aa:b0:878:814d:bc99 with SMTP id pw10-20020a17090720aa00b00878814dbc99mr9967952ejb.66.1678095794967;
        Mon, 06 Mar 2023 01:43:14 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id r29-20020a50d69d000000b004af70c546dasm4803460edi.87.2023.03.06.01.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 01:43:14 -0800 (PST)
Message-ID: <cd278972-77c5-2118-0a47-327aa7406ec1@kernel.org>
Date:   Mon, 6 Mar 2023 10:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix race on RX DMA shutdown
Content-Language: en-US
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230306090011.80725-1-alexander.sverdlin@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230306090011.80725-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 03. 23, 10:00, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
>  From time to time DMA completion can come in the middle of DMA shutdown:
> 
> <process ctx>:				<IRQ>:
> lpuart32_shutdown()
>    lpuart_dma_shutdown()
>      del_timer_sync()
> 					lpuart_dma_rx_complete()
> 					  lpuart_copy_rx_to_tty()
> 					    mod_timer()
>      lpuart_dma_rx_free()
> 
> When the timer fires a bit later, sport->dma_rx_desc is NULL:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> pc : lpuart_copy_rx_to_tty+0xcc/0x5bc
> lr : lpuart_timer_func+0x1c/0x2c
> Call trace:
>   lpuart_copy_rx_to_tty
>   lpuart_timer_func
>   call_timer_fn
>   __run_timers.part.0
>   run_timer_softirq
>   __do_softirq
>   __irq_exit_rcu
>   irq_exit
>   handle_domain_irq
>   gic_handle_irq
>   call_on_irq_stack
>   do_interrupt_handler
>   ...
> 
> To fix this fold del_timer_sync() into lpuart_dma_rx_free() after
> dmaengine_terminate_sync() to make sure timer will not be re-started in
> lpuart_copy_rx_to_tty() <= lpuart_dma_rx_complete().
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

This should have some Fixes: tag, I believe.

> ---
>   drivers/tty/serial/fsl_lpuart.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index e945f41b93d43..47c267ee22e04 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1354,6 +1354,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
>   	struct dma_chan *chan = sport->dma_rx_chan;
>   
>   	dmaengine_terminate_sync(chan);

Maybe I'm missing something (I haven't looked into the code), but what 
happens if the timer ticks here? Won't the dmaengine be restarted there?

> +	del_timer_sync(&sport->lpuart_timer);
>   	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
>   	kfree(sport->rx_ring.buf);
>   	sport->rx_ring.tail = 0;


-- 
js
suse labs

