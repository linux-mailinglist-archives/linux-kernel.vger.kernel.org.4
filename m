Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872CE74E2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGKAky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjGKAkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:40:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C521AC;
        Mon, 10 Jul 2023 17:40:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so3977499b3a.0;
        Mon, 10 Jul 2023 17:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689036049; x=1691628049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv3YcFx+E67TlMawHPFpx9khsk0UQoRAm7W/1UIFjxw=;
        b=leUms+CBlpLmSsE/qf03mSipNOUG3B43fCdqlgeHH+fNh8OZsq/BXX/yvfGVL8CTLG
         L7mVyJdoDLgO/XtDeGx6yLQtoVGegg9WzuD5V08HPmHYm8Ll1kOL8gcGGrReae/EVe6D
         +WAol/sd7AheBfOcpR2GuVRQvoehfDPXq/FjQpzEKKqXMFubkmmjhfJt35kcOVZU32yH
         Y+X4zG7qB6Uad84r0tv+PDr7C33IoQ0wKF9eSXSPoEpWkxKnKI3w1EtxbOUqLo+Cwy67
         FxY3BhGLWnBtoijx+f4sNqWX5JXX3qnbpJQ5SV/u5IBpAiQuKLfYz4rxIzJJV28L5zWt
         bzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036049; x=1691628049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv3YcFx+E67TlMawHPFpx9khsk0UQoRAm7W/1UIFjxw=;
        b=jh4H3eedCy2Jr7Yh4x6S0R61RPrzjEFwC3f2RJSg+UpWwVIvxgQTwEmgD6xe5Whhv6
         4A285vWEmWwaUtqJuw+Qnvpd/v0HQyRqq4/VZSsbuyjljXSxRvXMaxzueoLXE7JEfkCv
         IYnBaXyeg0LGhBU16uyx52hcAWFINiZlez6E7T+jbSe9f7kvsX2CEhb/7uUH8hadvJtb
         /uFnQFu0uE32fSLUKzbQUDSLR7m/T8OLpOjXNYcgkXkGZjin4kRc9tB5Av9zDJZsvuK6
         E/rYyEtlRtvWjsvJjp7UbSON+OUoYD9v/AHm7mzFGna99GzKcjkobZA0jDdpVJX3Tnbk
         RYvQ==
X-Gm-Message-State: ABy/qLYzp6CrpuV9CV3aw57i0AK8Zs6RvVRjxqrl9LaODcT7TJoU4+nK
        RHm+D056s8AbIz2s8KTwQ2I=
X-Google-Smtp-Source: APBJJlHVHuFWb1DBTwEgEs4Na5PXZ8piu5rpwuRUnYbKv90ZemBiZgvC7ON2H5iDAh5Loo26oohNZQ==
X-Received: by 2002:a05:6a20:9383:b0:12e:c5fb:757 with SMTP id x3-20020a056a20938300b0012ec5fb0757mr23302594pzh.5.1689036049405;
        Mon, 10 Jul 2023 17:40:49 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:96bf:7e77:39eb:7a23])
        by smtp.gmail.com with ESMTPSA id bu16-20020a632950000000b0055bac197d70sm287489pgb.53.2023.07.10.17.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:40:49 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:40:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Wells <wellsk40@gmail.com>,
        Durgesh Pattamatta <durgesh.pattamatta@nxp.com>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] Input: lpc32xx_ts - stop_tsc when driver remove
Message-ID: <ZKylDj4ONoD9cAUm@google.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
 <20230705052346.39337-9-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705052346.39337-9-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 05, 2023 at 01:23:45PM +0800, Yangtao Li wrote:
> When the driver is removed, we need to close the device.
> 
> Fixes: 3045a5f5202a ("Input: add LPC32xx touchscreen controller driver")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/input/touchscreen/lpc32xx_ts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
> index 15b5cb763526..ffdd748a9992 100644
> --- a/drivers/input/touchscreen/lpc32xx_ts.c
> +++ b/drivers/input/touchscreen/lpc32xx_ts.c
> @@ -305,6 +305,8 @@ static int lpc32xx_ts_remove(struct platform_device *pdev)
>  	struct lpc32xx_tsc *tsc = platform_get_drvdata(pdev);
>  	struct resource *res;
>  
> +	lpc32xx_stop_tsc(tsc);
> +

This change is not needed because lpc32xx_stop_tsc() is already being
called from lpc32xx_ts_close() which is called when we unregister input
device (provided that open() was called earlier).

Thanks.

-- 
Dmitry
