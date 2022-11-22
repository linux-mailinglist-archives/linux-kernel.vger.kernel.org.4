Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21846336B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiKVIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKVIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:10:25 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B6522BE7;
        Tue, 22 Nov 2022 00:10:21 -0800 (PST)
Received: from [192.168.10.46] (unknown [130.180.211.218])
        (Authenticated sender: daniel.lezcano@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id A0B24B0055A;
        Tue, 22 Nov 2022 09:09:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1669104619;
        bh=QqT0gBw0xLVZALCHaBpNFHcCmr+fibAnqkfvXhxig94=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YWx0Y5rMecZm8dj2aaa9zKoRmXYW5RDTj3g3ZoslU9YoIxwdmfC5fpn3uPG9kMJd0
         mDCTXhUrqMfDCOKwrRh1D4dnnYENzRfbDZVY39jUVIUGGhPkphxJ2s5WfvP0PuY7x1
         lZc/rYX6wVO4lgWIZuuWcI/Rl3BUT+wRqqhFSEEjXHZNLYsv0+MXPIB4HONnnZm1z/
         DUpYtzOwj91El8w3ugBL/7+i/3VCa8PEQRrjQhjY9GJr69DDaSIjhqJ7BBx+Gdp3rp
         rM8Y8eXL1FgKO/4MSrdRa0Ps/X0QDB5esiDpeurpx66fWzo5hIXDoMnRq0YiZgqb6M
         jljMVQkHGOdpQ==
Message-ID: <69a959d4-6058-de70-e1c7-15d81b33373c@free.fr>
Date:   Tue, 22 Nov 2022 09:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/6] Nuvoton WPCM450 clock and reset driver
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Patrick Venture <venture@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomer Maimon <tmaimon77@gmail.com>
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
 <CACPK8XdXrAPMdnn0T6GQiYEK3R4MvwprOZu_Yvmv=WVOfivROg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@free.fr>
In-Reply-To: <CACPK8XdXrAPMdnn0T6GQiYEK3R4MvwprOZu_Yvmv=WVOfivROg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 02:40, Joel Stanley wrote:
> On Fri, 4 Nov 2022 at 16:21, Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:
>>
>> This series adds support for the clock and reset controller in the Nuvoton
>> WPCM450 SoC. This means that the clock rates for peripherals will be calculated
>> automatically based on the clock tree as it was preconfigured by the bootloader.
>> The 24 MHz dummy clock, that is currently in the devicetree, is no longer needed.
>> Somewhat unfortunately, this also means that there is a breaking change once
>> the devicetree starts relying on the clock driver, but I find it acceptable in
>> this case, because WPCM450 is still at a somewhat early stage.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
>>
>>
>> Upstreaming plan (although other suggestions are welcome):
>>
>> Once reviewed,
>>
>> - The ARM/dts changes should go through Joel Stanley's bmc tree
> 
> I've picked up the standalone patch ("Add clock controller node").
> 
>> - The clocksource/timer changes should probably go via Daniel Lezcano and TIP

I picked the timer change along with the binding
