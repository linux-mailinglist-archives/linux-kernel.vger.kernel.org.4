Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05E7326FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbjFPGBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjFPGBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:01:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304412D5A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:01:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666748c1edfso375701b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686895265; x=1689487265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2Tdae4NzuKasm7w2+zUMrYnjwOZmFXGaFRcSVLtGS4=;
        b=BbB9u9JdxNAjx2Ql8WLL+3yj6h+ldwDT8Yw7wP7Kpw8XyKqq/J1PUQcl7cKwKw1+ip
         LK0XVbFfmGWWUcggaSPTtfr2Fe6riRprYHi8k7L/aZoYFM0kf673jZa9rLbxPZmo4AYG
         iLGuEmGro6saoLWdy+Q0mx17ezVIn7wlQxekyMxehrRvICw4A5vOFg/OPhgITsKb2BcB
         CdqgJMkyl4IJXoii+v/eT3IPubgRVew4vjMuWZKh4wiOuUdD0Luw0w2EO0OxNI4g9dtD
         WwCDdaFU1c4HIk3lFyyGJMVcVBSQeaKix2q4IvuggWgccz4NDsXFGSlg2vxVMHMqlqU7
         L2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686895265; x=1689487265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2Tdae4NzuKasm7w2+zUMrYnjwOZmFXGaFRcSVLtGS4=;
        b=HFTkU9SA9/ES0cvEqdAkxiRQTKKtjIKEe2aFCxnM8XHyB4dfXkwE+816gBNjkvqqqy
         TmMt45Sk1aoPX3W/bdNw+Ih7NK3ZPUUr3wNZqHfDbvg0KNAYRexhTR9UXWPhR2MQhZQ1
         +6tHE/lKoxfmAVy14ZN406VbTrFjfxcILaPJ5p2JwuwUxX/rF+druXxL5FRn7Cvb9+1k
         jlvFJc20EidMdSQN7d5arg4LXgafw5U4/lC3V/uLc22B8xlR6LUtvakmQH74d3m0y15d
         4hx6A6cu6ag1sLRbVWF5gg/kDCjlyqgd2Vl0qLYtvGhMM14eOIXTdkbclVnONcKo4Hk3
         nx+Q==
X-Gm-Message-State: AC+VfDzE36M4OrCFdSkUWbgYDkvEsJLnY4zPQmMmIxk9QYUA3NOyhEMm
        Fq5eadQKuz4L1F8aW+LWnadMiw==
X-Google-Smtp-Source: ACHHUZ60sq1ipG1z94+WQu+zmM7i765xoHf5/NNQO8ODM5H/I7pDV1nW7CsA+JwiRlp1ezi51TAn5g==
X-Received: by 2002:a05:6a00:2382:b0:64d:277c:4ab2 with SMTP id f2-20020a056a00238200b0064d277c4ab2mr1350915pfc.24.1686895260664;
        Thu, 15 Jun 2023 23:01:00 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id g3-20020a62e303000000b00654ecbafeadsm1879921pfh.218.2023.06.15.23.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 23:01:00 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:30:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: spear: Remove unused of_gpio.h inclusion
Message-ID: <20230616060052.kid7gtdunrlhhqu2@vireshk-i7>
References: <20230615164158.25406-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615164158.25406-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-23, 19:41, Andy Shevchenko wrote:
> The of_gpio.h is not and shouldn't be used in the drivers. Remove it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/spear/pinctrl-spear.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
> index 18de2e70ea50..b8caaa5a2d4e 100644
> --- a/drivers/pinctrl/spear/pinctrl-spear.c
> +++ b/drivers/pinctrl/spear/pinctrl-spear.c
> @@ -18,7 +18,6 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
