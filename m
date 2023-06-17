Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC107342F3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjFQSOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFQSOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:14:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A8AB9;
        Sat, 17 Jun 2023 11:14:36 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-62ff4f06b3cso18418426d6.1;
        Sat, 17 Jun 2023 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687025676; x=1689617676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITEoI0GfprmKSy6yT2L8mv5Xf8y2ioJT/R5QvHkoK9A=;
        b=XsPvwiWJEUN4qNlVOl9D6l+1K8/8xi9KCAWhuK2fTLOJGrnSNxEx7FptZgfvIQnrS4
         Ka8DA11VnjAahPPCwK08+hlD2ua2xAQU+5CjM2G+rSm1amQdUGPQR0USD5qbtT79L4sf
         9aBaPwHWjcVdogfrv3XtyUxdVqUATRtqsY3eK3w9F9wHnBVj+gaNKzH3kdsWzjZyxfrz
         lsKKhYXQnJJColKa60tJi+CI5IrnKi81TEF79FixdhiLR8Um5Di9eZqa1ovoZHzzct3P
         7V7/FLcw4QmLQUgZypgqcJDSzHcTruYtVAEKRid+Fht3VGlCDvUYJNOf5ShLK/YfUBy9
         xKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687025676; x=1689617676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITEoI0GfprmKSy6yT2L8mv5Xf8y2ioJT/R5QvHkoK9A=;
        b=EbHALx4s8yYJ9IH6GcfttaZyWSahnMjQW8fg5BVsFeLm9M7S1xOhyIgR9UClYJ+OTI
         y6Va7Kd7+Q+Hqbrer14d8vNfMT0ZqPKA0Um1mExbUayWgdKwggeQlczqTTbw94Iqtf15
         sGYQ9QPdjiV9kNdQaLFKfYti4XrL/MgOZkmHsi9IQuMKsMljBijt7WZikBQImeQwfPSE
         AZPjXhe8ZMoRQeU/ieLNSaBa0gmCBHG8/Kw3QVr4+TuNwjlBrGtm0KkojtzCwhuXp4Eh
         s6/BYD5iRwmGXpegcBNcoIlREKF18OxXS3EPlgJPZKqmpn6Wgwa27C4CKHhXeXLyjrwZ
         07Pg==
X-Gm-Message-State: AC+VfDwAhanmSOW1R/pv4Y0Q8sMITrMYNKz1KMBz4p2C1pzjZJnSW8jz
        sJKvQIgQiA5A0vlHb2djGVdVQadAAvw=
X-Google-Smtp-Source: ACHHUZ6PkiWxEYa7Ywq5Sp44xTa7+d+48UQf+qZWsIwV2axAsSY0vKmk3QyWBEt9RR6wi/L56ZrSNw==
X-Received: by 2002:a05:6214:d4f:b0:62d:e09c:fd73 with SMTP id 15-20020a0562140d4f00b0062de09cfd73mr7785730qvr.59.1687025675976;
        Sat, 17 Jun 2023 11:14:35 -0700 (PDT)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id i18-20020a0cf112000000b0062df126ca11sm5414346qvl.21.2023.06.17.11.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 11:14:35 -0700 (PDT)
Date:   Sat, 17 Jun 2023 14:14:33 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS
Message-ID: <ZI34CQzkDBKpv48n@errol.ini.cmu.edu>
References: <20230617085319.2139-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617085319.2139-1-jszhang@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 04:53:19PM +0800, Jisheng Zhang wrote:
> mmc host drivers should have enabled the asynchronous probe option, but
> it seems like we didn't set it for litex_mmc when introducing litex mmc
> support, so let's set it now.
> 
> Tested with linux-on-litex-vexriscv on sipeed tang nano 20K fpga.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks!

>  drivers/mmc/host/litex_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index 39c6707fdfdb..9af6b0902efe 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -649,6 +649,7 @@ static struct platform_driver litex_mmc_driver = {
>  	.driver = {
>  		.name = "litex-mmc",
>  		.of_match_table = litex_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  module_platform_driver(litex_mmc_driver);
> -- 
> 2.40.1
> 
