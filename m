Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0DA6FD656
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbjEJFrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEJFrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:47:53 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6323ABA;
        Tue,  9 May 2023 22:47:52 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1227579566b.1;
        Tue, 09 May 2023 22:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697671; x=1686289671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg0FkSVvrjlyggw4C3h0xdz7n3dXd4oy5mZxYMDijT0=;
        b=lixYvLaLGQTRVWGn3heWXGsbKpZC9c/QMQHMebo6JQ/QUrOQaiTSzsiGACN516bBk7
         g3hP9Yc6z0208N/CBVpFHLkihXjvhvxeD72xDI0ERHMZfo8M3ggIbylYFY86UDEPPdJ+
         2dOeoD4KdW8nsR1dDXCuJHb39yOzumw8FHYg001t4rL0h4Z6uGxHytjbtpRXuuI8M6h7
         hpM4oKXMzuYIG+/Rz620ZWjstBnEg4Arrxf0Tu3dGq8Gav4g6Ql7MbyNRZW7cukl4W3Y
         04y5u6l7N16CuyoaM9Rlm5yZDnsx6uXACO6zQTxvPSQ9HBqYBl9Pu6Y+sbn4OV6gjQg3
         +q8w==
X-Gm-Message-State: AC+VfDwZTT/CohvZNcSgKhQ/gUG/KJ7UD3EZh8Knnojtizsm9eRU4Eul
        NfZ7TCfh9pOURCRLo71P7Go=
X-Google-Smtp-Source: ACHHUZ5h2mn/D2OP/eltk2czCD55FmQUa5PyiY/W/Kk9ERcEWCZWCuXABlynT8JMCgY0PPz38Ty4Pw==
X-Received: by 2002:a17:907:62aa:b0:94f:62a2:d1ab with SMTP id nd42-20020a17090762aa00b0094f62a2d1abmr15410946ejc.63.1683697670652;
        Tue, 09 May 2023 22:47:50 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id la26-20020a170906ad9a00b00967a18df1easm2214299ejb.117.2023.05.09.22.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 22:47:50 -0700 (PDT)
Message-ID: <f03cd481-c5ee-2561-ea0a-b1ce5d039631@kernel.org>
Date:   Wed, 10 May 2023 07:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/6] serial: 8250: Change dl_read/write to handle value
 as u32
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>
References: <20230509113924.19540-1-ilpo.jarvinen@linux.intel.com>
 <20230509113924.19540-2-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230509113924.19540-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 05. 23, 13:39, Ilpo Järvinen wrote:
> Divisor latch read/write functions currently handle the value is int.

*as* int?

> As the value is related to HW context, u32 makes much more sense than a
> signed type.
> 
> While at it, name the parameters in the callback signature.
...
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
...
> @@ -847,7 +847,7 @@ static void disable_rsa(struct uart_8250_port *up)
>   static int size_fifo(struct uart_8250_port *up)
>   {
>   	unsigned char old_fcr, old_mcr, old_lcr;
> -	unsigned short old_dl;
> +	unsigned int old_dl;

I am missing the context, but why not u32 here?

thanks,
-- 
js
suse labs

