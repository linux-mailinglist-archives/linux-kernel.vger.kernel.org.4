Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D1E72AE4B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFJTGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFJTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:06:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E991988;
        Sat, 10 Jun 2023 12:06:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30e56fc9fd2so2770800f8f.0;
        Sat, 10 Jun 2023 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686424004; x=1689016004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLmWexq6F1fpCfKHIaE10IRWiqCed7zDFT7GaTdKHRo=;
        b=IP3kaBlO+DW4oxuj+GWhC2vXnxRfDfZQpETl+JHJYyR0oesjS9GWJvz0w7Hsf+PcFP
         eOq5kTAqpoIN6gV64ARWRDTstNnW/jDLoCgDLrmBIzGGPLHHDewvzOWcTt/gkSrxQ9KZ
         bD0H2/atZHUtRflcoAhgn/IiaY7k2jRF0+BFTqw0ozLkG8vgk9+8tW1J8VKEA8So3JbB
         DCwZkZDvChhicoFE/I4SpQHaeKtrIKRac4/L4QhIP2LhwRSPq7W2x+uKCk0MxsfdizIp
         Wz4lKhnGtjF5GGsogQp0S9IPdpwD71IVlNzbhiDOEa9phf8e2Ps9w8B2ZRhV6sGwsaQQ
         v8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686424004; x=1689016004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLmWexq6F1fpCfKHIaE10IRWiqCed7zDFT7GaTdKHRo=;
        b=cnaiwBsV7ECwXqGhsTi9v0tvgik6iunNbbREu5JCHz5QggqWJ+1MGKfpJAo4DNB3nt
         c54po98mVLxTP3YJ3nmmb3JW1dBaNCoMRjk5Lj5P6GVYo9zBVIJRsL7iWO0hFjr5UhFh
         QeG3gdnAb+ShryRGGaB2KTKlyMYewO8+Yc3eFh3FDxyaU7LJpX8xz2fAy4aEcaxIUL2D
         lm88RWRVjD8FDcVJElQ90dgG8B9q556Uv6p3fMnSHkumOFkManUMq9EhpML7nRp6AC03
         JY+X3Modr8gZSgMU7Z2lS83/dzARB+bvz0B5ZV6JDvQwN3es/FduqdDBf1vhzoC4tory
         WvKw==
X-Gm-Message-State: AC+VfDzrJHLhlVpolHHGYhAti6XYAKAkwSnGua1fiVnpsjr/O0a29Om9
        TjgNCvANqffwjV/TpjveGbMnZKHXckaTuIfY
X-Google-Smtp-Source: ACHHUZ7CIYvfhWjHA/EvyWexJGoYAIZjQeK0hazJ2nkWKdj9AUYLYe+9efJ0EHpIF4fE1f2Q50xXSw==
X-Received: by 2002:adf:f347:0:b0:30a:f17e:e02e with SMTP id e7-20020adff347000000b0030af17ee02emr1642740wrp.12.1686424003802;
        Sat, 10 Jun 2023 12:06:43 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5089000000b0030ae973c2e7sm7739586wrt.83.2023.06.10.12.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:06:43 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leonard =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
Date:   Sat, 10 Jun 2023 21:06:41 +0200
Message-ID: <3563678.R56niFO833@jernej-laptop>
In-Reply-To: <20230610191204.007c0159@jic23-huawei>
References: <20230610122934.953106-1-bigunclemax@gmail.com>
 <20230610122934.953106-2-bigunclemax@gmail.com>
 <20230610191204.007c0159@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 10. junij 2023 ob 20:12:04 CEST je Jonathan Cameron napisal(a):
> On Sat, 10 Jun 2023 15:29:07 +0300
> Maksim Kiselev <bigunclemax@gmail.com> wrote:
> 
> > From: Maxim Kiselev <bigunclemax@gmail.com>
> > 
> > The General Purpose ADC (GPADC) can convert the external signal into
> > a certain proportion of digital value, to realize the measurement of
> > analog signal, which can be applied to power detection and key detection.
> > 
> > Theoretically, this ADC can support up to 16 channels. All SoCs below
> > contain this GPADC IP. The only difference between them is the number
> > of available channels:
> > 
> >  T113 - 1 channel
> >  D1   - 2 channels
> >  R329 - 4 channels
> >  T507 - 4 channels
> > 
> > Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Looks good to me. Just the issue Connor pointed out in the DT binding to resolve.
> Note that this will be cutting it fine for this cycle, but 'might'
> make it in if the stars align.  If not it will need to wait for next cycle.

Cutoff for sunxi DT changes is at -rc6, so I would say at least that part will
land in 6.6 for sure.

Best regards,
Jernej



