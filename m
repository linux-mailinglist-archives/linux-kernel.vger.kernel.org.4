Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037E709EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjESR5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjESR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:56:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC87139
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:56:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae763f9c0bso13307165ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684519017; x=1687111017;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lt+R66SZsjACqQLQDsP1T/1PH804jTRmZ4JzbbwpO0U=;
        b=f8+SMr3t2qPVQOmEi/6pwbqCUOu+FC7kgupDjZbbgRp/Bju1XiEyEROvnrzIeAPIcP
         ptNQFmQF4OEsozJNoUP8LqyhLYk1oGQlOlbBPofaDerSBfIUBnO6R5Jd83TmqVtWTv47
         aIptasIq4EtXD3ibEpGgZXhzXlDc0usDHTBzB7QygCySo1+puz1Ju9yhtlRHSax8YyEU
         PAZGU05VOZGzPtVu861CMp2L16Pnfn7JMNmlk+yxoV1pxiZhiFkDlSYGbAJGGPOK3KQp
         BvlFnFqJEgL8s31SpQyhgf/w4bGuatySyK6UHtRDBALdkPUn5B8TKVN5Hr5jTL9ZBuol
         odzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684519017; x=1687111017;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lt+R66SZsjACqQLQDsP1T/1PH804jTRmZ4JzbbwpO0U=;
        b=VeXHcZndrwfLs+EkNo2Rbspx9sdUFVGS+MVTWQeh/zDxdQbHhFDPiVZgLbec02dDRN
         4KYg+qAuMdyDGE3sIcWBRrwdmTydcs3jrlpVytBvm7Rth3O8Uaxvwl82xoDzyH37H8Um
         fB2NVwsJ+9IwA3D2Pbn3/YcKPvntHWKTF6b0I6RTLVIqYgMw4EuhmYQGnWbO2aaBf4VK
         HMexZp05TIbMmthfOpC3nrVXrlPMtrNUf4EF/YglIcpxvKOryXyk034UcsWBuMJvQwql
         brHyQrKvXuYFJUhjQ4F8mAov5hq5S9F/8Rw1gGB5R6yce/GRskJ0IizV92d2VAEZpckd
         Bpjw==
X-Gm-Message-State: AC+VfDxCALki0alWw1X+vXcjYcaOIxLmayjSkj+gccgP2t/bz8BDvram
        NT73ZT/St/TfoBNvvxi4lq9gjg==
X-Google-Smtp-Source: ACHHUZ5XErCDTH4azEKBxRjdnDnNN3sfrlswrYkchau1PsP2au5OzmCr1ocMI4VOVLvqOHd0cSpp4w==
X-Received: by 2002:a17:903:2287:b0:1ad:b5f4:dfd5 with SMTP id b7-20020a170903228700b001adb5f4dfd5mr3851080plh.32.1684519016686;
        Fri, 19 May 2023 10:56:56 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id ft24-20020a17090b0f9800b0024e268985b1sm1763401pjb.9.2023.05.19.10.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:56:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Prathu Baronia <quic_pbaronia@quicinc.com>,
        Kevin Hilman <khilman@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Prathu Baronia <quic_pbaronia@quicinc.com>
Subject: Re: [PATCH] arm: omap1: replace printk() with pr_err macro
In-Reply-To: <20230518103324.881394-1-quic_pbaronia@quicinc.com>
References: <20230518103324.881394-1-quic_pbaronia@quicinc.com>
Date:   Fri, 19 May 2023 10:56:55 -0700
Message-ID: <7ho7mgyzko.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prathu Baronia <quic_pbaronia@quicinc.com> writes:

> Use pr_err() macro instead of printk(KERN_ERR "...").
>
> Signed-off-by: Prathu Baronia <quic_pbaronia@quicinc.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  arch/arm/mach-omap1/pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index 9761d8404949..6a5815aa05e6 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -632,7 +632,7 @@ static int __init omap_pm_init(void)
>  
>  	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
>  	if (error)
> -		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
> +		pr_err("sysfs_create_file failed: %d\n", error);
>  
>  	if (cpu_is_omap16xx()) {
>  		/* configure LOW_PWR pin */
> -- 
> 2.25.1
