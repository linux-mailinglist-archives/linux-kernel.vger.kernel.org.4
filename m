Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D263846B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKYHVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKYHVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:21:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BFCDFB4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:21:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so6936807pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnOuR6T/WgxRd8AZST6J7Q+SPMdibaqVHgbOqiWKxkY=;
        b=AwYAnwumoN5DuRWx1OopsFU6/GyQ319pAMDJKThH9E57yE2IAa3GYDejRPYZvTzf1O
         vODl9XRpP/SGE2E4nj4AdRAW3XFtDB7aeVfACW/+5tCL+v0N/55SCJ1IvvQuEQD1ShS1
         woUkwi6SCEbDjgIsOBxXJugD8vwGNVjKx+znCcU8cguBhCuDH+hePJZpgSNSrzSxvtJ1
         VW2e90v1+jXjBsd+8fj5hfP0sW8QL/b9kTH48bh9GiSxRv+1r8Z56s4eNn362IJtwEp8
         qjbS7AQD2uecNjHRnGOLfw55GVOF3INg5JHxynQeX8YoT3udrlMN87YFGKtstt4U1qCt
         2Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnOuR6T/WgxRd8AZST6J7Q+SPMdibaqVHgbOqiWKxkY=;
        b=DONk5MLXoHFEQr2xwQPqxSw0Nxnr893x/ymV3I81JvY3p8Np0C3/i45soac6p1NV3H
         xwrDQdJx7f8B6LzsxuwN4esvKa4JeTxyQG7PFKW/LF68n2lo0fIVV/TcAbKv594QsnCO
         exV8lO7I/Ws141G0871UgeBrhbNOGauRUbsJgcqrCL+TBx8qj5VYOdYqoAanivfYUIeG
         VWxYPNC6bXgyQadtnYiyH3stPAIUG88c82wCok2Sb1o0kkdIIrdQs+TqLx3RB/nQnsQt
         msKX8/4/4vQ945FTN2/3JB+LjP0J+9revZZyccjSwYdHO+9YTECMwT3p1wE/9cZIGxMq
         34gQ==
X-Gm-Message-State: ANoB5pmMYyKohlkHUiXm+ucoTV7dwrKKAZmKvqtZGGYTsLgKwuKAQCLN
        1gXKLGTOaK8H43AP2Jy0P06Dq9Q2XmuGJQ==
X-Google-Smtp-Source: AA0mqf4EvY3QGnFDFWjTU0Kx12OeCxUpqGIhANKLf9s+i8nihsr7tYcEcaJHeVnusPHPypQ43FM5SQ==
X-Received: by 2002:a17:903:2013:b0:188:f7d0:3952 with SMTP id s19-20020a170903201300b00188f7d03952mr16749606pla.164.1669360890654;
        Thu, 24 Nov 2022 23:21:30 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id b4-20020a62cf04000000b0057255b7c8easm2394119pfg.33.2022.11.24.23.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:21:30 -0800 (PST)
Date:   Fri, 25 Nov 2022 12:51:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Tushar.Khandelwal@arm.com, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: arm_mhuv2: Fix return value check in
 mhuv2_probe()
Message-ID: <20221125072127.doikcyawtja7ul2l@vireshk-i7>
References: <20221125063549.2546364-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125063549.2546364-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-22, 14:35, Yang Yingliang wrote:
> If devm_of_iomap() fails, it returns ERR_PTR() and never
> return NULL, so replace NULL pointer check with IS_ERR()
> to fix this problem.
> 
> Fixes: 5a6338cce9f4 ("mailbox: arm_mhuv2: Add driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mailbox/arm_mhuv2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
> index a47aef8df52f..c6d4957c4da8 100644
> --- a/drivers/mailbox/arm_mhuv2.c
> +++ b/drivers/mailbox/arm_mhuv2.c
> @@ -1062,8 +1062,8 @@ static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
>  	int ret = -EINVAL;
>  
>  	reg = devm_of_iomap(dev, dev->of_node, 0, NULL);
> -	if (!reg)
> -		return -ENOMEM;
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
>  
>  	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
>  	if (!mhu)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
