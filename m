Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9A5BE5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiITMeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiITMeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:34:12 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972825F110;
        Tue, 20 Sep 2022 05:34:11 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 990341CAC;
        Tue, 20 Sep 2022 14:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663677249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vy3394MDBwTyDF5riRpGQ1bWI/Uxx+v9aoRpfwrtVw8=;
        b=KLIiwldTgLh6waIO/BXq7aQ3yTMHLFx/Y1z74gAe+OaI4pMml15WCZgkgZrCdsP6u5vQNx
        OeS2VehbPnUXgzy91fu27zngDuZrZxgAytYqDtkFhEL7G2kfsddRuiqFVRIv2eTwkIJgbS
        RvHNJz5HVTyPvHZJfQ55X7I2D8sEwsf8J4YkPZUtPzMZvQkTy7opNbd9C0SZ5lnlSbUbE+
        5uRydG3+vo6VmB4dkIKBjMySCmNpcTtOkaGa1J2FmV89ufEl25Z9bT3U88Q/gOSmTFa9CJ
        oon5pzB/dsvYF3ZWfvvWfwBrsFlY0PiQuAOwiieyHUrlSFlStg36lrMvKwqFwA==
MIME-Version: 1.0
Date:   Tue, 20 Sep 2022 14:34:09 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
        andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
In-Reply-To: <CACRpkdb70zawWDSxUM=hJYkOEbG5a5guZWBytqUmRG2FZLiXsQ@mail.gmail.com>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <20220920120642.690340-1-michael@walle.cc>
 <CACRpkdb70zawWDSxUM=hJYkOEbG5a5guZWBytqUmRG2FZLiXsQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <faa173ddc1d55d2e3931246453e5e953@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-20 14:28, schrieb Linus Walleij:
> On Tue, Sep 20, 2022 at 2:06 PM Michael Walle <michael@walle.cc> wrote:
> 
>> Our board has a shared active low interrupt line, connected to a quad 
>> PHY
>> LAN8814 and two GPY215 PHYs. I've gave this a try but it doesn't seem 
>> to
>> work. It seems the interrupt fires multiple times. If I plug a cable 
>> in
>> one of the LAN8814 ports, I see that the interrupt count in
>> /proc/interrupts has increased by two. If I use a GPY215 port, I see 
>> about
>> 40 interrupts firing.
> 
> A lot of interrupts firing is very typical for level IRQs.

Common but wrong? Except in the error case, /proc/interrupts
was always reliable on our boards :)

> So I assume these are wire-OR, i.e. exploiting open drain with
> a pull-up resistor.

Yes, the usual shared line interrupts.

> Just checking: since these drivers obviously must pass pass
> IRQF_SHARED, have you also made sure that each driver also
> will properly return IRQ_HANDLED if the interrupt was for them
> (triggered by "their" hardware) but IRQ_NONE if the interrupt was
> not for them (triggered by something else)?

Thanks, I'll check it.

> The IRQ core relies on all drivers to do the right thing here.
> 
> Otherwise the IRQ will just re-fire until someone/something
> manages to properly handle it and drive the line high again.
> 
> A typical case would be the LAN8814 driver having been probed
> first, thus its IRQ handler will be visited first, and always returning
> IRQ_HANDLED thereby "stealing" the irq from everyone else.
> 
> Another possible problem is if you don't have an external pull-up
> resistor and you need some pin config to enable pull-up on the
> SoC input line. This will generate a lot of IRQs.

I've checked with a scope, the levels and edges look good.

> A third problem would be that the line need time to rise.
> But that should be uncommon.

I haven't looked at the code of this patch, but obiously it
is emulating the level triggered behavior with just a pin change
interrupt. There might also be something wrong there, too.

-michael
