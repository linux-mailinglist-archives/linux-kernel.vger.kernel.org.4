Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA44161D937
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKEJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKEJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:54:12 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2242D18B21
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QO/uh1tfrB1vZ/birVU9li3LJoDhOtqTeKkjmuQEcpU=; b=f8PZKPFaPnsa8knKT47i9fE0mj
        aPMGaxO8zVXZyxJw7hhyjdY4uvNrXmbqRHSafTyZWk/g8BzjhCu914LSe3zgUxxIsg+6gYlyIIyO7
        lDHZlOIyJGF9WsoQWnE4Cl/1UtZdjggV34hs38KfCrXqNmSrljZff2IkB7ocrp4Gy9K/dCuaeFeuj
        DkWey3994d15MZEeU9o/P8W8QrYdwL7LQnJEIG6Z+t8EQgXAN2Ksnf9RirKKbjp92ni2CIiIrgqw4
        WqLxmEJSQtVJTAm5xnBVPkhwwKPnnmMnofe+rOmye/FM633hokTlk13EMWHPa/1DhC6+Im2uTGbWs
        QLgtsy7w==;
Received: from [2a01:799:95a:cb00:749c:a195:60ac:1a6b] (port=61208)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1orFsN-0003Pc-4Z; Sat, 05 Nov 2022 10:54:07 +0100
Message-ID: <4b97cc9b-4143-2a2f-f431-a7ea83a2e945@tronnes.org>
Date:   Sat, 5 Nov 2022 10:54:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4a 31/38] timers: drm: Use timer_shutdown_sync() for on
 stack timers
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20221105060024.598488967@goodmis.org>
 <20221105060200.540142479@goodmis.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221105060200.540142479@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 05.11.2022 07.00, skrev Steven Rostedt:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is released, timer_shutdown_sync() must be called.
> 
> Link: https://lore.kernel.org/all/20221104054053.431922658@goodmis.org/
> 
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>

>  drivers/gpu/drm/gud/gud_pipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index 7c6dc2bcd14a..08429bdd57cf 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -272,7 +272,7 @@ static int gud_usb_bulk(struct gud_device *gdrm, size_t len)
>  
>  	usb_sg_wait(&ctx.sgr);
>  
> -	if (!del_timer_sync(&ctx.timer))
> +	if (!timer_shutdown_sync(&ctx.timer))
>  		ret = -ETIMEDOUT;
>  	else if (ctx.sgr.status < 0)
>  		ret = ctx.sgr.status;
