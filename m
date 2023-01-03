Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3119565C8CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjACVQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjACVQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:16:23 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E31408A;
        Tue,  3 Jan 2023 13:16:22 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso19793564otn.2;
        Tue, 03 Jan 2023 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJtaPRwwUCXKLamHYJ5ehkr68u6NOGdWwQtIIti8GjE=;
        b=eBrb+IvPAHfFFmTLeQxDPVmeMW6j22h2Ll/7hMT8imAb7XOxGfrGTRVJ1V3sBZt5Zk
         B91cicuXW5NTqJHHLEqKlOA5Q5ba5HlhdXJca3m3LO42BWCturfdD4AXgMpRO1/TKV79
         /K3kCFzXLBw3bq8JNsgUkhQ7vgLXNRzY7VYL7zIw9QkwdAz1heBoQ30e4GOyjboUkR7z
         67vU69FwZ1ZzmZ11hK93r82fVfcY/xXi0DJFSbR3g0JwvgP906sOq9WtRVmpyucLmR48
         u9i/Mzs+DmWAP5tki5i/K4uT9s0Aiqivjt9JW5zt+0hjxLPSoyv0JZXgaf3VVD4N0r6K
         M+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJtaPRwwUCXKLamHYJ5ehkr68u6NOGdWwQtIIti8GjE=;
        b=bRMchH2BJcKdTUL1v9yj9y8J5SBpLtr+WhAAETNHJZhFsWcnjT5ysXNvwGgdFaOox7
         S711a/qYeQcIHgdYIf2B43btQ6hm53q7djZqDlJxQb/b7tYDvRWb4CNJWW1vNnqK1JpI
         zaQcTIYZnKrtwaQ+c1X2qgJGXlbBLWrY7LTgwz2+Rsz5cCQoxzUAsk/ugFZJAQaZXqjW
         IGst3+g33vx7Xu75YVo5ozB7ErHcMQUJNxkifiUrl+vWHD84A5efDhT/pX9O8nkfLWhb
         eRs/h+6XlH4osGJvzh/Rk4Lkt11gMY5NVueQH8sEojI0kw0Lo7VME4KiCgg3b8B4QmZO
         Dd/Q==
X-Gm-Message-State: AFqh2kqpAMgNfJ2lR7NRDS/Are/ZGhNpNsPjqjVsbVYVx2Eqp3EL3O2t
        UppKBIZeAqes3zpbLYIqPY4=
X-Google-Smtp-Source: AMrXdXvviuAsb+qMyuPnPjvI4wgV8XN/uqdNjb56Sif/64u1ATO0FPqUCA6UbYb3UWBgBNpCIxoEmQ==
X-Received: by 2002:a05:6830:1399:b0:676:7425:528 with SMTP id d25-20020a056830139900b0067674250528mr20823512otq.0.1672780582067;
        Tue, 03 Jan 2023 13:16:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cc10-20020a05683061ca00b0067079fc1ac9sm15737500otb.44.2023.01.03.13.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:16:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:16:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sander Vanheule <sander@svanheule.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: realtek_otto: Use devm_clk_get_enabled() helper
Message-ID: <20230103211620.GG212337@roeck-us.net>
References: <5e4255782fbb43d1b4b5cd03bd12d7a184497134.1672498920.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e4255782fbb43d1b4b5cd03bd12d7a184497134.1672498920.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:02:17PM +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/realtek_otto_wdt.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
> index 2a5298c5e8e4..2c30ddd574c5 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c
> @@ -235,27 +235,14 @@ static const struct watchdog_info otto_wdt_info = {
>  		WDIOF_PRETIMEOUT,
>  };
>  
> -static void otto_wdt_clock_action(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int otto_wdt_probe_clk(struct otto_wdt_ctrl *ctrl)
>  {
> -	struct clk *clk = devm_clk_get(ctrl->dev, NULL);
> -	int ret;
> +	struct clk *clk;
>  
> +	clk = devm_clk_get_enabled(ctrl->dev, NULL);
>  	if (IS_ERR(clk))
>  		return dev_err_probe(ctrl->dev, PTR_ERR(clk), "Failed to get clock\n");
>  
> -	ret = clk_prepare_enable(clk);
> -	if (ret)
> -		return dev_err_probe(ctrl->dev, ret, "Failed to enable clock\n");
> -
> -	ret = devm_add_action_or_reset(ctrl->dev, otto_wdt_clock_action, clk);
> -	if (ret)
> -		return ret;
> -
>  	ctrl->clk_rate_khz = clk_get_rate(clk) / 1000;
>  	if (ctrl->clk_rate_khz == 0)
>  		return dev_err_probe(ctrl->dev, -ENXIO, "Failed to get clock rate\n");
> -- 
> 2.34.1
> 
