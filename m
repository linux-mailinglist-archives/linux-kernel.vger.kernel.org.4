Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B316607783
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJUNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJUNEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:04:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413484AD7C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:04:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so4682757wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ub/Q3aGASlrAXKX6JbBno3sJc5izj2B9kHx5Vfj31no=;
        b=gEJ6INl1uo2EhdrqvpQPhIeMhpnTp/XTU+JHgRvsZWO7q0dliF+YoqCWZGjqTDPHmV
         NZH1YUUL4hRBFfUiUbBxtJlGJEGGhg+dCZZ5CXddKxrwdK8Y/zY35MWxxyY+6rJdfWjg
         CnbFzh/3uiviFDfs2zHAudI3cY/42hpKZeJehUUk9xx3FSp3PBuGwS/5p4sFoknG0opI
         gVV94ui6Y5m95IH2FzeDetax+EyO183Vv4HjyeOnWa/m0s6DKjbB4cyPxwYDCFH386sI
         xHdi6c3J+arK/FjKtZNzt6ZtvYDD8D58x/R8xf4TT33C6TWaVCThCozrmMCQ0Arl9o/Y
         x6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub/Q3aGASlrAXKX6JbBno3sJc5izj2B9kHx5Vfj31no=;
        b=FcyiANvz8w8jT5kUhVs0DZXF80AE6h+Azdgsz6D5yKPjrN92FfDeOx7zZCS6vBKqDW
         bvA37qBYi0Iv7BTNpGasUa0kVfaPvZUZEUe10PSQjMU8RPScAHzuhaXAMA898cBQvWcx
         1IGNnRGVZ/cmFhp/2ZcBXZLUxX1oXhaX3jLX8XrmFquJ2z3I3LmRJOWzNWwJ9SXaUUgn
         pOwFT0vCMoF8bxF/26X6nc3/kHcB4iBQIqePB2gfuK8nG7umxB7zGo5ojuHqzdlsgCLN
         /xrbcsa9JC18e2g2CBt+UTSr3jCmFM1Q4Ncfp6Y980NOIZs4VADuTWAl3yVfYDkdiePs
         Q66Q==
X-Gm-Message-State: ACrzQf10WSHsfKQD0Ic0vJebsFibJGqUhCX0LGkcblS34+dYzhlMDjkr
        lwg3lLcdNFeot4iaqwuNlXP5joBfwWY9Mg==
X-Google-Smtp-Source: AMsMyM7Upp2advF48Gmvc7xuqXWi5BXIj28tAi5l0CGstD4rPMbCg2nWp/QDAkA7mw9jbyrpjk+Z9w==
X-Received: by 2002:adf:fa05:0:b0:22e:362a:ce57 with SMTP id m5-20020adffa05000000b0022e362ace57mr12200802wrr.96.1666357481661;
        Fri, 21 Oct 2022 06:04:41 -0700 (PDT)
Received: from localhost ([2a01:cb19:8b2c:5e00:becf:29f6:2774:7ce2])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003bdd2add8fcsm2878337wmq.24.2022.10.21.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:04:41 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tps6507x-ts: remove variable loops
In-Reply-To: <20221020181642.24417-1-colin.i.king@gmail.com>
References: <20221020181642.24417-1-colin.i.king@gmail.com>
Date:   Fri, 21 Oct 2022 15:04:39 +0200
Message-ID: <87y1t9pbtk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 19:16, Colin Ian King <colin.i.king@gmail.com> wrote:

> The variable loops is being incremented but is never referenced,
> it is redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/touchscreen/tps6507x-ts.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
> index 357a3108f2e5..f48871767763 100644
> --- a/drivers/input/touchscreen/tps6507x-ts.c
> +++ b/drivers/input/touchscreen/tps6507x-ts.c
> @@ -119,7 +119,6 @@ static s32 tps6507x_adc_conversion(struct tps6507x_ts *tsc,
>  static s32 tps6507x_adc_standby(struct tps6507x_ts *tsc)
>  {
>  	s32 ret;
> -	s32 loops = 0;
>  	u8 val;
>  
>  	ret = tps6507x_write_u8(tsc,  TPS6507X_REG_ADCONFIG,
> @@ -141,7 +140,6 @@ static s32 tps6507x_adc_standby(struct tps6507x_ts *tsc)
>  		ret = tps6507x_read_u8(tsc, TPS6507X_REG_INT, &val);
>  		if (ret)
>  			return ret;
> -		loops++;
>  	}
>  
>  	return ret;
> -- 
> 2.37.3
