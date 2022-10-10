Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3A45FA313
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJJR7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:59:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B4A78230;
        Mon, 10 Oct 2022 10:59:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f140so11415104pfa.1;
        Mon, 10 Oct 2022 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zN/KjsCEx2zMtEPwS1BKpAmSphZD0IO6nl7YyDXtL7I=;
        b=fXqfedqDgMytgQwcbHuYJGLHuxZEy/2DeKE1BMP/BK7EE8oS6TfYEqNPVIyhccsp/l
         LUlusXsTq9E2Ee2ia5OV3eHfC+28hTurg5cErnPhMRmfAmLWsTrt+Bdg1pXJ6WMEXTmv
         KaMiGz9iIvUV5CzTiGzZr2gUV2KBq8lt8zITykuIuU/FlsoHhrKPEpFFUq/I19wFxjn3
         RzZTDCYcVo1NkapqwtvsbbpER0pJkuyat96JdDk8/LPZ4ptMUJay4/jxN4KZthYsRSQw
         2IufrFfGB0edloAJcxBhv7jzYJGoolZmjPXy1+NxUc2YJhq/BcHLrypgFeQeBEPpj44F
         Xlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN/KjsCEx2zMtEPwS1BKpAmSphZD0IO6nl7YyDXtL7I=;
        b=NSrR3B7rSfKcQ+ILrYLbYAizITmgCbatd3AWfHOW9orwG+tUznUNyXoOP0sV5XAzlW
         pqRH7gLH58DbZ4kCYYJmKsvBQY8x377TZFSFg5fi2j7VSWHfp9UQPbMQ0Zz76fRQo25Y
         5tATXFLPHHmm/i8Vv5yxDS8GYRnbHmLUCNkxgfciQAiVBgOSlgnSDJkeEc5zrDeNXs2+
         OvJFNNoZGpQ48gPhZggYjHvdlKe6hblzJZILNC1H0LlQV3Cyp5+ub6og7//QFNOznxVd
         49R9KyyYUrLDDlbdDleyt+ovbLUnF2F9ST2tx9AR3ebfGmTfIzA+AenZboH0JETUlR0O
         wNeQ==
X-Gm-Message-State: ACrzQf0DGCy1p2Wk5j8nfNQ9yeoPb9aZaw89I87ItTjnLLO5ssg2fVPv
        H/iGcPpnuanFOtc40LRzVXA=
X-Google-Smtp-Source: AMsMyM5T1heBkPii4UShM09nkXeqTs9kRM0l2fFArAYuUIGT76FaBWaRlltgwohNj//2CUSAPg83dg==
X-Received: by 2002:a63:814a:0:b0:460:9253:bf8e with SMTP id t71-20020a63814a000000b004609253bf8emr10193428pgd.469.1665424769299;
        Mon, 10 Oct 2022 10:59:29 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:bff:9bd3:c2da:5f42])
        by smtp.gmail.com with ESMTPSA id z4-20020aa79e44000000b0054223a0185asm7237591pfq.161.2022.10.10.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:59:28 -0700 (PDT)
Date:   Mon, 10 Oct 2022 10:59:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v1 1/1] pinctrl: st: Switch to use fwnode instead of
 of_node
Message-ID: <Y0RdfcC5FVRX/XI9@google.com>
References: <20221010075615.43244-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010075615.43244-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:56:15AM +0300, Andy Shevchenko wrote:
> The OF node in the GPIO library is deprecated and soon
> will be removed.
> 
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/pinctrl/pinctrl-st.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index cf7f9cbe6044..987878c83349 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1175,7 +1175,7 @@ static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
>  
>  	for (i = 0; i < info->nbanks; i++) {
>  		chip = &info->banks[i].gpio_chip;
> -		if (chip->of_node == np) {
> +		if (chip->fwnode == of_fwnode_handle(np)) {
>  			if (offset < chip->ngpio)
>  				retval = chip->base + offset;
>  			break;
> @@ -1518,7 +1518,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
>  	bank->gpio_chip = st_gpio_template;
>  	bank->gpio_chip.base = bank_num * ST_GPIO_PINS_PER_BANK;
>  	bank->gpio_chip.ngpio = ST_GPIO_PINS_PER_BANK;
> -	bank->gpio_chip.of_node = np;
> +	bank->gpio_chip.fwnode = of_fwnode_handle(np);
>  	bank->gpio_chip.parent = dev;
>  	spin_lock_init(&bank->lock);
>  
> -- 
> 2.35.1
> 

Thanks.

-- 
Dmitry
