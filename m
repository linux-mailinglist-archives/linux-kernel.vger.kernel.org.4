Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22951643D29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiLFGfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiLFGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:35:13 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2FC222BB;
        Mon,  5 Dec 2022 22:35:07 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id vv4so3855864ejc.2;
        Mon, 05 Dec 2022 22:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpnQoUu9q4dFU9fd5dKoOeViJZYTdUELrMbvm+lIUes=;
        b=PdeNrPpM/mc+Cn2I67Gjf1Wf/KOBET8M9rLbFYu4k015n4kFVbsPalmuzy63Mg9X34
         mOVIxlsEJywstwTEeW6zYvycsf2NHaSJZ+i+ltWCECyE989UM4ZZ8fuJTN0xkJSsR7b5
         yEfvMMBbf2krcxSZWauJFtmktBL5f37TzaecV6NzGFsGDoNC1rv1uMYHBo6/UvGqBnmg
         tgdFJ3zl5fZL3qe5nApW7QQcOJr9Odmm109Ge+GQvqjPV/JB6NAV8ojjDM15FptrktUI
         Yo7f7zOXPrrNN11rXdiSTqh8na+SsJNRNzkjAHKPDXJKb9IgcrDwUvJnIZuVIjkGu4+k
         0iaA==
X-Gm-Message-State: ANoB5pmoM63Q3jH2Y9azp4rzjujtoSrG9VMOlE+Nzw4SSCBdyxSV7Gk3
        LKajedG+50+aHJmDsTsBCaQ=
X-Google-Smtp-Source: AA0mqf7yArbjielBwMBLaQxWoE6QrvZhv1NGCA4k1c00+nH6n+Lo2x5YH+IBjHfZuQ9spSLA0SU+sA==
X-Received: by 2002:a17:906:2b81:b0:7c0:f716:e395 with SMTP id m1-20020a1709062b8100b007c0f716e395mr5959496ejg.160.1670308505447;
        Mon, 05 Dec 2022 22:35:05 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090680d400b007c081cf2d25sm6995881ejx.204.2022.12.05.22.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 22:35:05 -0800 (PST)
Message-ID: <b3aff238-c473-e587-dd04-cc5ef4517722@kernel.org>
Date:   Tue, 6 Dec 2022 07:35:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] serial: Adapt Arm semihosting earlycon driver to
 RISC-V
Content-Language: en-US
To:     Bin Meng <bmeng@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20221205050038.195746-1-bmeng@tinylab.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221205050038.195746-1-bmeng@tinylab.org>
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

On 05. 12. 22, 6:00, Bin Meng wrote:
...
> --- a/drivers/tty/serial/earlycon-arm-semihost.c
> +++ b/drivers/tty/serial/earlycon-arm-semihost.c
...
> @@ -23,7 +27,18 @@
>    */
>   static void smh_putc(struct uart_port *port, unsigned char c)
>   {
> -#ifdef CONFIG_ARM64
> +#if defined(CONFIG_RISCV)
> +	asm volatile("addi    a1, %0, 0\n"
> +		     "addi    a0, zero, 3\n"
> +		     ".balign 16\n"
> +		     ".option push\n"
> +		     ".option norvc\n"
> +		     "slli    zero, zero, 0x1f\n"
> +		     "ebreak\n"
> +		     "srai    zero, zero, 0x7\n"
> +		     ".option pop\n"
> +		     : : "r" (&c) : "a0", "a1", "memory");
> +#elif defined(CONFIG_ARM64)
>   	asm volatile("mov  x1, %0\n"
>   		     "mov  x0, #3\n"
>   		     "hlt  0xf000\n"

Hmm, can we implement all those smh_putc() variants in respective 
arch/*/include/semihost.h instead?

thanks,
-- 
js
suse labs

