Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05965E594
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjAEGYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAEGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:23:54 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEEA51334;
        Wed,  4 Jan 2023 22:23:53 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so578177wma.1;
        Wed, 04 Jan 2023 22:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S09kCi2B6W+kvjfavNwp/x7TIDaE6qjmKIYQzABeYWU=;
        b=2msMzmi40nC77FxE46rxpWT+z5YQUMPLVDCCeCH1e45S9qFIokmbdV9rQ13Adi0QxN
         pZr8wxm+zqF0IxMK20w0vd32jeqGLi7mWaxwCKiu1Oq3gYoTDUPPTzPkBcyrrV0r6lEz
         YmLviOTKxmh3Mffg0nWRy77SRvFHch0e0Jk3XFWeUQphJAU1T2wG4pgU9pmRb/eZqZN0
         oJInm+FIU2RWn23rruzx4KztNZJAKdwM36MpBN/J5F5OglJPw9Yf+49F/Gcd/KaTRqUL
         avDi725/ZtjkmGzlQj3Ds41/fzeLu/GmrYYnH74KlJR04fbicnmsMCe/axOGX5SnImp6
         8DEQ==
X-Gm-Message-State: AFqh2krlv1SXOpw+UP6wYOFyLLa1xnipBPhmUOCABdlBIBMrMxPoNwDp
        dYkoAZuQKxKUKHBq3Pa3/sve8Terdk2uYw==
X-Google-Smtp-Source: AMrXdXta3kcpToCjpDWKphQJt7JPvVt6ThBOAAgGR2aeSl3+CyUHKyydRa1aJXm3/RFSQop3seLLiA==
X-Received: by 2002:a05:600c:4255:b0:3d3:3d34:5d63 with SMTP id r21-20020a05600c425500b003d33d345d63mr37230769wmm.8.1672899832451;
        Wed, 04 Jan 2023 22:23:52 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b47b80cec3sm1206435wmb.42.2023.01.04.22.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:23:52 -0800 (PST)
Message-ID: <1a25b930-e003-6326-86ab-4d8cdc9b7da5@kernel.org>
Date:   Thu, 5 Jan 2023 07:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 09/10] serial: Make uart_handle_cts_change() status param
 bool
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-10-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230104151531.73994-10-ilpo.jarvinen@linux.intel.com>
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
> Convert uart_handle_cts_change() to bool which is more appropriate
> than unsigned int.
> 
> Cleanup callsites from operations that are not necessary with bool.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
...
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3285,11 +3285,11 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
>   /**
>    * uart_handle_cts_change - handle a change of clear-to-send state
>    * @uport: uart_port structure for the open port
> - * @status: new clear to send status, nonzero if active
> + * @status: new clear to send status, true if active

ANyone else having troubles to parse "new clear to send status"?

>    *
>    * Caller must hold uport->lock.
>    */
> -void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
> +void uart_handle_cts_change(struct uart_port *uport, bool status)

This should be "bool active" then.

thanks,
-- 
js
suse labs

