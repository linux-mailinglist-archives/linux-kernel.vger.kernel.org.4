Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A7067366A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjASLMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjASLLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:11:41 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B670C41
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:11:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so3302241wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=H1DHSYmKlnbvlId2ArSd5HfoZBbatA4dYyTE/SLPQPM=;
        b=LerjjIhkW4lzTCAjS2rrm+CVF2nmhr5Wd8fG2N1D9RjM6WttZDzQ+z4FJutV2R1WO1
         Cv3plnsyu8NYVg7k8FLvMszQRs6Rcu8Mmz5GDWb7sZgRJ6lTbFHjvyN0dzZF69smKweA
         bRrOarwCkzqtN3/QTwZ1xS1wukuckZbei343TEOecl+0CSI33kBog2R+xsK26r6mrlzj
         y34co7UX3a279t4NcansMs0PLANKghluUFcHD9XDuHywS1EceBxoEg4m7OU1vKqg91OW
         w2sWTICaLKctybSb0eiiN0gJiUa0Ed6+YHIRzVG3/7KD6vvy4x1ZYL8vXbKOhCwkN0KX
         K1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1DHSYmKlnbvlId2ArSd5HfoZBbatA4dYyTE/SLPQPM=;
        b=QvZ+UwWN9XuUOcLAai7f/jWeWCbfrQX917ziMyNRFfEUl+cml1G+xSqS/Kdi5/H8xw
         1CwuhUMsskvm+c5Wjnj8FP61ra8HzimIWBenIFgq34fWrRiAzfYeK7ZugHp0/dW17Owy
         O4xco4UHpwVXLYvoEh8+huGxiY5Fe2wV6fzrO+Y6o6lgRTY0G1dVtXsB7lUxIhwyNjqA
         S6SFkT2V5vphLdJKaNm4ptDU7Tc8Ej/6/9IGyLG9KZf/iKADIO0va816IsN0roznD4S8
         q4TgLHlot4KaEQZTAtpviG7hCAG2RgUe/JNaydJXSYHT9Q6D4EzmqmgpW6miGcOGwqq1
         JP/Q==
X-Gm-Message-State: AFqh2kqKVqndsBfL3DA+u30IQuOQdUWQGpZNbXs9HZPvkbmJFupUdpjP
        SRZFfrh5Bo6bQO0scchagwKhzQ==
X-Google-Smtp-Source: AMrXdXt1zQpCw8WZi7Lxm6C8UaUKMMnt+X0n9fU4drQQnlkAQ/TXFuYihRAggoNtPa5rO9XKkb4loA==
X-Received: by 2002:a7b:cbcb:0:b0:3db:2ad:e330 with SMTP id n11-20020a7bcbcb000000b003db02ade330mr9828136wmi.5.1674126697544;
        Thu, 19 Jan 2023 03:11:37 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d684f000000b002bddac15b3dsm17722757wrw.33.2023.01.19.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 03:11:36 -0800 (PST)
References: <20230116091637.272923-1-jbrunet@baylibre.com>
 <20230116091637.272923-3-jbrunet@baylibre.com> <Y8dhUwIMb4tTeqWN@lunn.ch>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: mdio: add amlogic gxl mdio mux support
Date:   Thu, 19 Jan 2023 11:55:29 +0100
In-reply-to: <Y8dhUwIMb4tTeqWN@lunn.ch>
Message-ID: <1jmt6eye1m.fsf@starbuckisacylon.baylibre.com>
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


On Wed 18 Jan 2023 at 04:02, Andrew Lunn <andrew@lunn.ch> wrote:

>> +static int gxl_enable_internal_mdio(struct gxl_mdio_mux *priv)
>> +{
>> +	u32 val;
>> +
>> + 	/* Setup the internal phy */
>> +	val = (REG3_ENH |
>> +	       FIELD_PREP(REG3_CFGMODE, 0x7) |
>> +	       REG3_AUTOMDIX |
>> +	       FIELD_PREP(REG3_PHYADDR, 8) |
>> +	       REG3_LEDPOL |
>> +	       REG3_PHYMDI |
>> +	       REG3_CLKINEN |
>> +	       REG3_PHYIP);
>> +
>> +	writel_relaxed(REG4_PWRUPRSTSIG, priv->regs + ETH_REG4);
>> +	writel_relaxed(val, priv->regs + ETH_REG3);
>> +	mdelay(10);
>
> Probably the second _relaxed() should not be. You want it guaranteed
> to be written out before you do the mdelay().

Good point, I'll have a look

>
>> +
>> +	/* Set the internal phy id */
>> +	writel_relaxed(FIELD_PREP(REG2_PHYID, 0x110181),
>> +		       priv->regs + ETH_REG2);
>
> So how does this play with what Heiner has been reporting recently?

What Heiner reported recently is related to the g12 family, not the gxl
which this driver address.

That being said, the g12 does things in a similar way - the glue
is just a bit different:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/mdio/mdio-mux-meson-g12a.c?h=v6.2-rc4#n165

> What is the reset default? Who determined this value?

It's the problem, the reset value is 0. That is why GXL does work with the
internal PHY if the bootloader has not initialized it before the kernel
comes up ... and there is no guarantee that it will.

The phy id value is arbitrary, same as the address. They match what AML
is using internally.

They have been kept to avoid making a mess if a vendor bootloader is
used with the mainline kernel, I guess.

I suppose any value could be used here, as long as it matches the value
in the PHY driver:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/meson-gxl.c?h=v6.2-rc4#n253

>
>> +	/* Enable the internal phy */
>> +	val |= REG3_PHYEN;
>> +	writel_relaxed(val, priv->regs + ETH_REG3);
>> +	writel_relaxed(0, priv->regs + ETH_REG4);
>> +
>> +	/* The phy needs a bit of time to come up */
>> +	mdelay(10);
>
> What do you mean by 'come up'? Not link up i assume. But maybe it will
> not respond to MDIO requests?

Yes this MDIO multiplexer is also the glue that provides power and
clocks to the internal PHY. Once the internal PHY is selected, it needs
a bit a of time before it is usuable. 

>
>     Andrew

