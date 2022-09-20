Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF45BE5C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiITM3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiITM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:28:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92CC53021
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:28:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a41so3605971edf.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=x/dpCo5isvN6L6y4460xJDzd0mKTKQeLQI6ROjAtcPE=;
        b=o+8/eyHIZ+W+h8BCccsh2J61rtQyvRmlSe79hoETQtKbpuUQvaCWb5bN+xiCpIvBT/
         eRw/3UuHBSkh86ua/Y2jMZBQOOBoUBqV5nbJjzuOvvy+7fggrggQkhUmHMEaActfSM7l
         UlsBqnZ6AAj87rXx3XSv5+i1vlEz8Werunkp1xMIFYbCRWQwHWk1ULUqKqBC90VRwkI7
         XdxPuNPwTSD6rpqBx3I19vo7nBhNCEf+amTGk/dvBqyXZhZMgxZ5X9cP3Sq4IBS/42kj
         P4p8BanWS656h/FsN6Ki75rYosSS8YiNRgV5Bh7tZI86ByOx5ADzfkqAhvD9qhAZKAIf
         l4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=x/dpCo5isvN6L6y4460xJDzd0mKTKQeLQI6ROjAtcPE=;
        b=tl0TvBvQigI7NkIumfE/EayPsSeERTXUhBcv/cu35AScvTmmj5dwaK/TQn28PvslOg
         +r4ayBi7aFO24Z2v37lcJo4VliRsLJrkUmxLj9v2yO1/feCUMcumPWb0oAoLw24vLJ9V
         1ecTQ3HGCcjAPORN6fMEkxgJZLV7ZRUNl2Toc3Wa9y73tybmFcami/hvGsWmwTpG99lV
         miccBLHJjcGbmuXLlyLEy3gDXUcyI3LMKWyTnHCq6gkMxzGpYjYo3ODC9zpXNVoIsyXO
         75zmWhMzBidwq5Ds/y+xfGTvM2HrlD3Dbl4TFcxcztMq11n0fMPKGuBBMhovkrf7Y00Y
         ONEw==
X-Gm-Message-State: ACrzQf3/HjmVA9KfWFD2YOZsCXNW8upfgB5H7PZswL/vQ50d1e9Nfydk
        Z+Xc0jUQzbL1OGH8siWeNTQBJ8O6uHy5ayMMFVqqNA==
X-Google-Smtp-Source: AMsMyM6deT5Ir8Df8O9B2ZIl1h+f0n+Olh1trvgdRVrwDAscZAsjxlbnUHR1QrUKKfohPTx4n3QFQhC8cY4TrEmARbU=
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id
 k16-20020aa7c050000000b004534427a947mr18822439edo.172.1663676936357; Tue, 20
 Sep 2022 05:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220909145942.844102-1-horatiu.vultur@microchip.com> <20220920120642.690340-1-michael@walle.cc>
In-Reply-To: <20220920120642.690340-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Sep 2022 14:28:44 +0200
Message-ID: <CACRpkdb70zawWDSxUM=hJYkOEbG5a5guZWBytqUmRG2FZLiXsQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
To:     Michael Walle <michael@walle.cc>
Cc:     horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
        andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 2:06 PM Michael Walle <michael@walle.cc> wrote:

> Our board has a shared active low interrupt line, connected to a quad PHY
> LAN8814 and two GPY215 PHYs. I've gave this a try but it doesn't seem to
> work. It seems the interrupt fires multiple times. If I plug a cable in
> one of the LAN8814 ports, I see that the interrupt count in
> /proc/interrupts has increased by two. If I use a GPY215 port, I see about
> 40 interrupts firing.

A lot of interrupts firing is very typical for level IRQs.

So I assume these are wire-OR, i.e. exploiting open drain with
a pull-up resistor.

Just checking: since these drivers obviously must pass pass
IRQF_SHARED, have you also made sure that each driver also
will properly return IRQ_HANDLED if the interrupt was for them
(triggered by "their" hardware) but IRQ_NONE if the interrupt was
not for them (triggered by something else)?

The IRQ core relies on all drivers to do the right thing here.

Otherwise the IRQ will just re-fire until someone/something
manages to properly handle it and drive the line high again.

A typical case would be the LAN8814 driver having been probed
first, thus its IRQ handler will be visited first, and always returning
IRQ_HANDLED thereby "stealing" the irq from everyone else.

Another possible problem is if you don't have an external pull-up
resistor and you need some pin config to enable pull-up on the
SoC input line. This will generate a lot of IRQs.

A third problem would be that the line need time to rise.
But that should be uncommon.

Yours,
Linus Walleij
