Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEE565E58F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjAEGVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjAEGV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:21:29 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0EA51334;
        Wed,  4 Jan 2023 22:21:28 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso562533wmp.3;
        Wed, 04 Jan 2023 22:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAEMQFdfgVBcmOVq2pNOL15xuSdJkLLmqjgylxoc+Sk=;
        b=PLEr4PHUbbArUyMcSpFnEXGftMwdxViKNYWQ4snnieH9SKsdQwYrqCjP1ItfPJRCEQ
         IaxkOOR9Ndzlh803Ip9N+3/e1mKby6xUEREoK/eqMXCycuKeA5PBXi8OmaAEC63MQdU3
         MH0XVjr9VBOA1PSJEgkmX3mNvx7yXFVgfGbmcv4ukzzpWzvSwgr67X105c+ClRG/353P
         E2+qQlffgoNvC/F4gQ8ezyaIsJdh7uYBufghtti3RzjsfMEiuqltY+SzlbixpQMTyBJY
         YBmFD6Yi31ifAkYTaTOnkgPGkFIn4dnrkmXVIHgtW2O+vsdSiSWngqGjP3RQekmiRN90
         qvGw==
X-Gm-Message-State: AFqh2kqWueU9t4w+Ssfd5vs5D8cnfl4XyYdIj4wV/5TqoEntHyIRBk2R
        AH1zD2J0EczD+wPxYHqsNzc=
X-Google-Smtp-Source: AMrXdXtjXHqhoeoZ1KizKFs5ywBzvrDm8GK2iCayrbwAQ5Jm2g2BgyV1ip7zp2zWX3Yh9NlupvFNbg==
X-Received: by 2002:a05:600c:1e24:b0:3d3:5075:7526 with SMTP id ay36-20020a05600c1e2400b003d350757526mr36594024wmb.31.1672899687507;
        Wed, 04 Jan 2023 22:21:27 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id i3-20020a1c5403000000b003cf5ec79bf9sm1177448wmb.40.2023.01.04.22.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:21:27 -0800 (PST)
Message-ID: <de514a2c-1649-9035-db6b-9461f3c069d7@kernel.org>
Date:   Thu, 5 Jan 2023 07:21:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 08/10] tty/serial: Make
 ->dcd_change()+uart_handle_dcd_change() status bool
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-9-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230104151531.73994-9-ilpo.jarvinen@linux.intel.com>
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
> Convert status parameter for ->dcd_change() and
> uart_handle_dcd_change() to bool which matches to how the parameter is
> used.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -896,8 +896,7 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
>    * The following are helper functions for the low level drivers.
>    */
>   
> -extern void uart_handle_dcd_change(struct uart_port *uport,
> -		unsigned int status);
> +extern void uart_handle_dcd_change(struct uart_port *uport, bool status);
>   extern void uart_handle_cts_change(struct uart_port *uport,
>   		unsigned int status);
Note to myself: huh, we still have some superfluous "extern"s in headers.

thanks,
-- 
-- 
js
suse labs

