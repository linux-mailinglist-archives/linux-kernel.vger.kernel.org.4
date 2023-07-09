Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13F74C471
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjGINvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGINvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:51:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AD3114;
        Sun,  9 Jul 2023 06:51:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8ad9eede0so27059015ad.1;
        Sun, 09 Jul 2023 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688910665; x=1691502665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TedygSIVmNctQbeMqIt6+adjDWuI/4xC/VFYdzgvfI=;
        b=QQQcqXS1lweh7hYqS96vzPxYDNuMI+PzDO6W6y4EwWSSaXIoZvtEDcfhG1pytxImev
         wMlx83o+ykInPGOA2T8TyLz6QhyqALsy3QGIec8uPeOQzFMbVXnwzGY1QR+VB0Ee80RQ
         QqGyPh/YoKl2sEp8UNwQiJNbNsGZ78EIP1/kuqh9fIcFBM70/oasjAwwJ7oS/iku9pDk
         M4RjFmktIKpfQV/DxHWlCyjtmaZUWsejeZJcr3C8A6QV0JAvyXzv+eH9XCXlnHU/BaQI
         76uXG69ez7anQ+6k/cdgm4nEMYRpTNG/OxeZ75JPprP8D/wc8BGmg4LQYLeTxZN2MQF0
         xgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688910665; x=1691502665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TedygSIVmNctQbeMqIt6+adjDWuI/4xC/VFYdzgvfI=;
        b=Vw0UzEqoS9XkLCkAY7PiIfT25t3bnDTftMlG8mQjHn5/ppw7MCspJgOUlZm+ocFwig
         kDDfz3D3Fup1yhptJfTNFzSJiOBblwbP7wt09fjF+yCZ/CPJTd/+U/LNzyiIFjUH4fwk
         T6ZpWzJOEKTdjN2lfhPPm4pATPu2vLJhh4b/aoLx+/0i6z0qamIopi8VDiJbbVH/HYvL
         6j93xZXrNWtibwAgSTFM0pHARapmvAJfEOqjrgD6WJH75Kf/nUOdAuIJ1AB6LadMra9C
         2P1ycok7WTv7kzTlqWxO1PoiBG69NTB41G8NBhkT/hNpURN+w2vBcVyG/iRUI61SvTs9
         l2KQ==
X-Gm-Message-State: ABy/qLYcGWZp2faT2MtEEL4J0mQXsFGU8RfyouLtRp1v5u0wQrbT7Vfs
        T2DHNCIu/ftwheYZQ55UJmQtYLWDzPk=
X-Google-Smtp-Source: APBJJlGPp+UafruZ6YbdTmvx8Nq+8uvEz0r9QDOeU7k0hZzC9uFmWWbITBJorxRFy7n6DzT808rcxQ==
X-Received: by 2002:a17:902:e80d:b0:1b8:b459:f47a with SMTP id u13-20020a170902e80d00b001b8b459f47amr13153836plg.34.1688910665539;
        Sun, 09 Jul 2023 06:51:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b0019f3cc463absm6362632plt.0.2023.07.09.06.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 06:51:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 9 Jul 2023 06:51:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL
 demux
Message-ID: <ebba6278-2d4b-411b-ad95-8db70752eff8@roeck-us.net>
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 01:15:49PM +0200, Geert Uytterhoeven wrote:
> When booting rts7751r2dplus_defconfig on QEMU, the system hangs due to
> an interrupt storm on IRQ 20.  IRQ 20 aka event 0x280 is a cascaded IRL
> interrupt, which maps to IRQ_VOYAGER, the interrupt used by the Silicon
> Motion SM501 multimedia companion chip.  As rts7751r2d_irq_demux() does
> not take into account the new virq offset, the interrupt is no longer
> translated, leading to an unhandled interrupt.
> 
> Fix this by taking into account the virq offset when translating
> cascaded IRL interrupts.
> 
> Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/r/fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> Highlander and Dreamcast probably have the same issue.
> I'll send patches for these later...
> ---
>  arch/sh/boards/mach-r2d/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-r2d/irq.c b/arch/sh/boards/mach-r2d/irq.c
> index e34f81e9ae813b8d..c37b40398c5bc83e 100644
> --- a/arch/sh/boards/mach-r2d/irq.c
> +++ b/arch/sh/boards/mach-r2d/irq.c
> @@ -117,10 +117,10 @@ static unsigned char irl2irq[R2D_NR_IRL];
>  
>  int rts7751r2d_irq_demux(int irq)
>  {
> -	if (irq >= R2D_NR_IRL || irq < 0 || !irl2irq[irq])
> +	if (irq >= 16 + R2D_NR_IRL || irq < 16 || !irl2irq[irq - 16])
>  		return irq;
>  
> -	return irl2irq[irq];
> +	return irl2irq[irq - 16];
>  }
>  
>  /*
> -- 
> 2.34.1
> 
