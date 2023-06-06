Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0389B724086
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjFFLJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjFFLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:09:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB911BD8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:08:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b01d912a76so27503725ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686049687; x=1688641687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVSJj1sRiRvqAoJoUbfYZTV6sidf/krCZCWHmgJCGhk=;
        b=oWir6YuIJqL+Gp4V0Fk0VI2xVPrF4usjZ6/Xlw+2+DQYHFSkQ2ZrlnS4VOYaSXcis8
         nqoM/nTyzPQ2MYzMhjiIIh19XVfHEh9KpH1WCL8f38Dp+u5ck7Zn1FwhJustPdB+tTvY
         TYkYoeZ/yrCzMuh8Anlqo19kkZgwUoqXdkKMjn7i5plWwRwtCG7Qk3ubLmw0OUB5WPTq
         eVKVGWKcnhaflts7Cbq0wBv3kUiFyi8cQca5vJLxMEdamv4UCTAP9/LB0EtrmQJb5qkb
         6BqxjmXwvcY3Qqcxqmmq0DepdnshiPMXzKz6OLMtkNZG5TtsT0Xrv39548SbG/nrv9vD
         9+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049687; x=1688641687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVSJj1sRiRvqAoJoUbfYZTV6sidf/krCZCWHmgJCGhk=;
        b=ggmVUrDfXK9vd0JxKBvl4oVEEFWpli8UKmhAXUYWzKaWv5fMzlwSLMHfWw0IXZU6uF
         9DC6A+QLYwyp/oXf8o0NQETe0uTpG7AgnKljJH/wYjF8KRJH9rBEq+gR6yZSeZE+kV9w
         QVGoaZ3mLr2fMWhAr5jojPernwx8qEYTxgiCt+7W5GHZkoFdXOXT0yGCCzGhafwoQxBc
         El+sEj6SlsDPxvHWZks8HohvQo+ZgIYOJsgIOQ0A+hHUj4J0Zre4tkyi8xYI/nhfhmEm
         tFIZE+ACYvrJaKkWbDQLpVvmGSBggtmSXxj54w3o7dwg59GKwZA/8/n04T0MF8sCgZnV
         hO+g==
X-Gm-Message-State: AC+VfDxG4n4v6aNM2iQj8hkJLY22tWt4jJ4XmYWboTg9fydu2l0FXFvf
        0NjS6UMOOfm7MQOc1LGOcfIFmQ==
X-Google-Smtp-Source: ACHHUZ6mVC+QRBEFN/QISRGq+0SEodzIsqkq5FhAjV/IBoQmblkm6QfiIf/q/U5ysSZwmO7ec2umTg==
X-Received: by 2002:a17:902:da8c:b0:1b0:5ca0:41a8 with SMTP id j12-20020a170902da8c00b001b05ca041a8mr609279plx.39.1686049687471;
        Tue, 06 Jun 2023 04:08:07 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b0019c13d032d8sm8229012plp.253.2023.06.06.04.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:08:06 -0700 (PDT)
Date:   Tue, 6 Jun 2023 16:38:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mason Huo <mason.huo@starfivetech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Message-ID: <20230606110804.qns4rolrrj2gku6w@vireshk-i7>
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
 <20230606105656.124355-3-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606105656.124355-3-mason.huo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-23, 18:56, Mason Huo wrote:
> Add the compatible strings for supporting the generic
> cpufreq driver on the StarFive JH7110 SoC.
> 
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 338cf6cc6596..14aa8281c7f4 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -85,6 +85,8 @@ static const struct of_device_id allowlist[] __initconst = {
>  	{ .compatible = "st-ericsson,u9500", },
>  	{ .compatible = "st-ericsson,u9540", },
>  
> +	{ .compatible = "starfive,jh7110", },
> +
>  	{ .compatible = "ti,omap2", },
>  	{ .compatible = "ti,omap4", },
>  	{ .compatible = "ti,omap5", },

I thought I already merged it ?

-- 
viresh
