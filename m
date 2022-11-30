Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABF63CECD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiK3FnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiK3FnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:43:11 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF7240A0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:43:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d18so4829435pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5ZuVSNXu5dNBIFu9aboWpOIhLYgTfI2KhViYMf8Wno=;
        b=hbYkzSlvgmiV0jOHzz8kR63yGr8+W95zQ7es2pHJVKzJ6DakPJl2Thq6zVYbLCyQgK
         YydKqbuXEq2T8Ibk9ckAbrDoXp2TXi9tj0kF3yMX0+z7YQ/xVFkKgp24R0vZn6hxelJE
         N5aiRdum17bOpI+/SYPrgsJ6eGEykg5SM2qlztLtVvId163M80ulVkSYhJK/qoeYg5rR
         h1A+t1HotzSIG6NQdFDbD3Z6ibkGxUZCPNUTSQoevm+7gw9n5sK4R2GlOadxWbbWs8dq
         M1CqlJzg9LL1EfUTlK2TGWxtRjRpM+rxl5lb+EyWbbmdWIbVQjnUrjPaODVO36RZlk3f
         YfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5ZuVSNXu5dNBIFu9aboWpOIhLYgTfI2KhViYMf8Wno=;
        b=zfJMsYKOdm31RXff8syy3SfOG6QiwcEYlzpTVza+1OhdVpttw43HA6yiCIf65EllVU
         4uXICV4MFGKDR3rP9423YSetH7KRmYwndfEsnTGMhfPgUlWbZxxc9Jy5QLof6FZoeV6C
         wn5ds1EX3vTr+/GvjVPiGtX7Biv77nANghFt/UNEDbx2XscHU64IhTeSrZ04zCe6p4nz
         IjHLQHnDEJzMwXtcBmcKMLS3Id5dj2JIp1lfcYWOu1iRGFUGuyagpTeQPwcqJLAckM9A
         pZGsBlE/3ZIPKA9ZH5DsSl35XNFHvqohKpPKJLT9WQzi9R08VZ4laEaLdmL4nSNJ37qa
         9rfg==
X-Gm-Message-State: ANoB5pnuWfOLoovcq0Z+UUbxiNrymOVrSDB+EjDNz38MjYiG2mv19S4k
        ol0Zj3c0W04o0YR3aeika1QySQ==
X-Google-Smtp-Source: AA0mqf79rVuoW+aeNhb/sXSPJiqJ4dWDIWgpBk0H875f/t1m0PFjg2YguQ4/IIVTxIrgDTNJjgi3WQ==
X-Received: by 2002:a17:90a:5c85:b0:20a:92d2:226a with SMTP id r5-20020a17090a5c8500b0020a92d2226amr52199943pji.155.1669786989559;
        Tue, 29 Nov 2022 21:43:09 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b0017da2798025sm298512plb.295.2022.11.29.21.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 21:43:08 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:13:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
Message-ID: <20221130054306.3tjbf6spbtknpmyq@vireshk-i7>
References: <20221128142912.16022-1-marcan@marcan.st>
 <20221128142912.16022-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128142912.16022-4-marcan@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-11-22, 23:29, Hector Martin wrote:
> This driver implements CPU frequency scaling for Apple Silicon SoCs,
> including M1 (t8103), M1 Max/Pro/Ultra (t600x), and M2 (t8112).
> 
> Each CPU cluster has its own register set, and frequency management is
> fully automated by the hardware; the driver only has to write one
> register. There is boost frequency support, but the hardware will only
> allow their use if only a subset of cores in a cluster are in
> non-deep-idle. Since we don't support deep idle yet, these frequencies
> are not achievable, but the driver supports them. They will remain
> disabled in the device tree until deep idle is implemented, to avoid
> confusing users.
> 
> This driver does not yet implement the memory controller performance
> state tuning that usually accompanies higher CPU p-states. This will be
> done in a future patch.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/cpufreq/Kconfig.arm          |   9 +
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/apple-soc-cpufreq.c  | 352 +++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  4 files changed, 364 insertions(+)
>  create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c

Applied. Thanks.

-- 
viresh
