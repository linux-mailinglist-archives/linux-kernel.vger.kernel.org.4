Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB32665405
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAKFyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjAKFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:54:34 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7281A1B3;
        Tue, 10 Jan 2023 21:54:33 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso11786153wms.5;
        Tue, 10 Jan 2023 21:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxOtWbCJbWwdNH5UZWTBXbdnFffgpyUQ5aKg6pc140I=;
        b=nRi6mUGnJA85WSvxy6vSiEex0/5dgsMJUtcPP3miBRoC05Avcy3ZcK6QaW6tB/vz8S
         w8EZ8o1VhDwDgNDYjPCOLtJc8/N1gcaotivrRdURCC+ujBkf3EYgs8WPQrzJJa0UFeIS
         X+33lM3CkE1qv4VYe/9wL1NC28NwNYpWQj6XqV8WYm5MhgQ+4Nt7WwuO59Lw9caepyc3
         hjjaqiILhr7781t+BjiVg/S4axtJK/NXMHoZZN3mhmxJm8loyIZ/qpwzkTyIEQkifmZA
         Xz9SW63nWC/PT3TCndL3aLd02hJ0cS30fjlUWBTL17p6j0HB7qaXT1CJ/f4xCCuH6eOV
         RwuA==
X-Gm-Message-State: AFqh2kpbE/+o+EyeN6YOQbTQZoYV3Cc53bk3s+LrOqbqdoftgQau7wFb
        yy0ZNlDDQ2rfLBZ2r8Msco0=
X-Google-Smtp-Source: AMrXdXskeTikh5sSLb6x7oWwZ9962bd5j2ffLsT14BVqKWDYei6Wj3Niq1g3jQ2YbIId1sBjYqEEYA==
X-Received: by 2002:a05:600c:1c11:b0:3d0:a531:5413 with SMTP id j17-20020a05600c1c1100b003d0a5315413mr50423073wms.34.1673416472485;
        Tue, 10 Jan 2023 21:54:32 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003d974076f13sm18325055wmo.3.2023.01.10.21.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 21:54:32 -0800 (PST)
Message-ID: <c668edde-4902-2cd7-5668-a578731e86fa@kernel.org>
Date:   Wed, 11 Jan 2023 06:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 09/13] serial: Make uart_handle_cts_change() status
 param bool active
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
 <20230110120226.14972-10-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230110120226.14972-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 01. 23, 13:02, Ilpo Järvinen wrote:
> Convert uart_handle_cts_change() to bool which is more appropriate
> than unsigned int.
> 
> Rename status to active to better describe what the parameter means.
> While at it, make the comment about the active parameter easier to
> parse.
> 
> Cleanup callsites from operations that are not necessary with bool.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

