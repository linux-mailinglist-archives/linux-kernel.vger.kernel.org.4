Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50465BC9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjACJAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbjACI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:59:57 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1921DFED;
        Tue,  3 Jan 2023 00:59:56 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id tz12so72046747ejc.9;
        Tue, 03 Jan 2023 00:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCnHYwwZj7hf09BfA6BHyTHlj6ziwHCFkuL5r8JlPOA=;
        b=3UB2TlncEmGraNcuKFdFWVv6G0QXuXahuYpW8XfbVAf/auOcxG/Dpg0zVAGtvTBjEd
         QXMYECYpMtR91Zuad+Yc7u2avDwANa6CDRfzGoj3G1APjwUBlPdWDLRcLpAh4MSO51Iv
         1k3oMN0JCY0+wLW94bATR6c0ohdvW8bl+5sD8YiCQs4dtKbZ+NSq0E1JBfVkg4NOt9tk
         B9LkOQo/WGp3tv9aSh5SAZaEdMxSVcdH0xNsFM+YCOI50urzHaPqkOc/QSpjvVI76FV+
         lLxb5JnJmtT5PoEcQL0LQcKtPRYdGHyN3yj8Y1lUPoYkE06CKBTJ/Gx+JZWA2hSwmgEE
         HRXQ==
X-Gm-Message-State: AFqh2kqbLfSohb3trKddlzM3OMTG5PnMq/EkhAd4uYxdsDywSWQxNIQb
        joJmeEdmggDqfK/gX8tq2lXsyW9aWFo=
X-Google-Smtp-Source: AMrXdXvcP1oGDt/E0YoVGqFqd8qZMTeJ6LyuXS9DMAb0Wb1kAju/36tyX6fdevafL0MBe6S1FJb+FA==
X-Received: by 2002:a17:906:4e4b:b0:7c1:4040:ef17 with SMTP id g11-20020a1709064e4b00b007c14040ef17mr37017092ejw.54.1672736395375;
        Tue, 03 Jan 2023 00:59:55 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906375700b007bfacaea851sm13838036ejc.88.2023.01.03.00.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:59:54 -0800 (PST)
Message-ID: <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
Date:   Tue, 3 Jan 2023 09:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <cover.1671898144.git.drv@mailo.com>
 <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 12. 22, 7:21, Deepak R Varma wrote:
> The refcount_* APIs are designed to address known issues with the
> atomic_t APIs for reference counting. They provide following distinct
> advantages
>     - protect the reference counters from overflow/underflow
>     - avoid use-after-free errors
>     - provide improved memory ordering guarantee schemes
>     - neater and safer.

Really? (see below)

> --- a/drivers/tty/serial/dz.c
> +++ b/drivers/tty/serial/dz.c
...
> @@ -687,23 +686,19 @@ static int dz_map_port(struct uart_port *uport)
>   static int dz_request_port(struct uart_port *uport)
>   {
>   	struct dz_mux *mux = to_dport(uport)->mux;
> -	int map_guard;
>   	int ret;
> 
> -	map_guard = atomic_add_return(1, &mux->map_guard);
> -	if (map_guard == 1) {
> -		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
> -					"dz")) {
> -			atomic_add(-1, &mux->map_guard);
> -			printk(KERN_ERR
> -			       "dz: Unable to reserve MMIO resource\n");
> +	refcount_inc(&mux->map_guard);
> +	if (refcount_read(&mux->map_guard) == 1) {

This is now racy, right?

thanks,
-- 
js
suse labs

