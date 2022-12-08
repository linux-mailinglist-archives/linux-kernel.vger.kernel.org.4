Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3836468E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLHGIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHGIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:08:39 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403D8659C;
        Wed,  7 Dec 2022 22:08:36 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id h11so391390wrw.13;
        Wed, 07 Dec 2022 22:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdO3M4VLxTphcxgv9reIX5OeBW+Opupnq1O9ICQuNB4=;
        b=eV81okQWQq3T9rRr/qR+lIjzhNOjGHZ7Nt9jJ/PQnctPNxCzk70VA68FKO5ynfkFOK
         V7Gczyj0J8FkNis/oW5S34Ae6AQV0PzFC/uiMKh0mA2+z1MX6czFMz+USPiJXgxwTknt
         0qJmykPoYPhXnN53u9fpJvGFtLi0YFVrEoqaToVUi1ztdGfSDiQh14RFaCBHWWdUTJNu
         lplYl6VRlyq61LNNu3Zy8rpw+YCIthZO8t6j9CmIT6/dXQdJxz5KjSMU3Q+Jj3WG6e/8
         C0Ssv0XW9HqbauZ/NoFhUllPhBj0ujWPEM5s6UNM+gOvNbaB8qPlLHF77kC4JQ+iLZ4T
         1idA==
X-Gm-Message-State: ANoB5plXQR7q8NozIDFyfESAj04TTmJNHsbzZffeJlRfb/bhzHUrmjOj
        XqTJ3xsOKUVfj55l4oiQ5ypmK7NBge4=
X-Google-Smtp-Source: AA0mqf7lxoQKokXxjdZsYvTxsGgExAkaZEk7+P4TZNw91MWt4o3d93lsiW94n/OhA/2dzdza7A6CMg==
X-Received: by 2002:a5d:5a90:0:b0:242:6af:8a26 with SMTP id bp16-20020a5d5a90000000b0024206af8a26mr960431wrb.70.1670479715067;
        Wed, 07 Dec 2022 22:08:35 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id bs21-20020a056000071500b002428c4fb16asm1027522wrb.10.2022.12.07.22.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 22:08:34 -0800 (PST)
Message-ID: <0443d5e9-b2ce-7e6b-c69b-708d67a5bf97@kernel.org>
Date:   Thu, 8 Dec 2022 07:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] serial: earlycon-arm-semihost: Move smh_putc()
 variants in respective arch's semihost.h
Content-Language: en-US
To:     Bin Meng <bmeng@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20221207135352.592556-1-bmeng@tinylab.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221207135352.592556-1-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 12. 22, 14:53, Bin Meng wrote:
> Move smh_putc() variants in respective arch/*/include/asm/semihost.h,
> in preparation to add RISC-V support.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
...
> --- /dev/null
> +++ b/arch/arm/include/asm/semihost.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + * Adapted for ARM and earlycon:
> + * Copyright (C) 2014 Linaro Ltd.
> + * Author: Rob Herring <robh@kernel.org>
> + */

Much better. There are three minor issues:
1) protection against multiple #include-s is missing here.

> +#ifdef CONFIG_THUMB2_KERNEL
> +#define SEMIHOST_SWI	"0xab"
> +#else
> +#define SEMIHOST_SWI	"0x123456"
> +#endif
> +
> +static inline void smh_putc(struct uart_port *port, unsigned char c)

2) port is unused in all implementations. So it should be dropped.
3) can you make "c" an explicit u8?

> +{
> +	asm volatile("mov  r1, %0\n"
> +		     "mov  r0, #3\n"
> +		     "svc  " SEMIHOST_SWI "\n"
> +		     : : "r" (&c) : "r0", "r1", "memory");
> +}

thanks,
-- 
js
suse labs

