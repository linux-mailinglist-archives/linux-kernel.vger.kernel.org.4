Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73765E565
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAEGEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAEGEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:04:23 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211145371F;
        Wed,  4 Jan 2023 22:04:21 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id s9so3109351wru.13;
        Wed, 04 Jan 2023 22:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlzjy/tUPJnkVrmNqr25y6Fm/QT0oZOn8xZvoiyVAZQ=;
        b=7wUBsKlk5f8xloc1c5Y4FAih6FanrJwFWqpKIsx/76GnK1d1yXW5/dopbNNd5oMjdj
         AdO+IH23X+nqsEEuwXABdmWzjhLnIMYSOVMQQdlSA6YAAglXm19VgF2NwlfVFWbdIcbl
         bQtuF3aZUpv7SYcR6yOiUccsChyhrdC/Tvx+8RVepBC6oSr1UEy3qTfBYdMCZwjj9SIT
         3qM9+WUM2hogm788BKX3tfks2mv8Eev1KqTMCaI93e+sA4pSkL9c6UJwOqyjyLKTO8L1
         045BFePDVG+mKwX/gyPOSAMTX+RtNzdRRi2wkP9RR7qIo6t/OVxjXO5nNFCX1EN0h8Rd
         Ha1w==
X-Gm-Message-State: AFqh2kp6luPXsCzUXm2HKQQHykSi8e7qlVmI79qrMnhf4oS8wiPwd5cB
        dTeEdQ990srKPkA3P+VoHhkMIMS4OOg=
X-Google-Smtp-Source: AMrXdXt5f7okScDmznxQFhaDpXnyoOvWU2wYeFkVTTukWoLwwTkx+ZxQbZOMvzbf6bflR0QfmgT/1Q==
X-Received: by 2002:adf:a4de:0:b0:2a9:89e:2b53 with SMTP id h30-20020adfa4de000000b002a9089e2b53mr2196023wrb.45.1672898659734;
        Wed, 04 Jan 2023 22:04:19 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003cfa3a12660sm6186842wmb.1.2023.01.04.22.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:04:19 -0800 (PST)
Message-ID: <1fd3cc28-32f4-f9d7-e9de-00655abcf2b8@kernel.org>
Date:   Thu, 5 Jan 2023 07:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/10] tty: moxa: Make local var storing
 tty_port_initialized() bool
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-5-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230104151531.73994-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 01. 23, 16:15, Ilpo Järvinen wrote:
> Return type of tty_port_initialized() is bool, use matching type for
> the local variable.
> 
> Also reorder the local vars to reverse-xmas-tree while at it.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/moxa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
> index bc474f3c3f8f..2d9635e14ded 100644
> --- a/drivers/tty/moxa.c
> +++ b/drivers/tty/moxa.c
> @@ -1664,8 +1664,8 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
>   		u16 __iomem *ip)
>   {
>   	struct tty_struct *tty = tty_port_tty_get(&p->port);
> +	bool inited = tty_port_initialized(&p->port);
>   	void __iomem *ofsAddr;
> -	unsigned int inited = tty_port_initialized(&p->port);
>   	u16 intr;
>   
>   	if (tty) {

-- 
js
suse labs

