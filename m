Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E13A63EBF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLAJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLAJG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:06:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88462C1;
        Thu,  1 Dec 2022 01:06:55 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED43B33F;
        Thu,  1 Dec 2022 10:06:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669885612;
        bh=ND7XGuKlUkPBHeU5Bp0ctgaJsNefKn67OU0NpJ8J3JA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pwHcQVuCQf27Lg+oqOF9F3quGy4Gc2wMv385LqQ7RhEHRD3DbmsGHjHg/McZSh0vS
         uv6mDgZUkwkVrlsmmdp0NpHybsU95O2w7YMCZIVzoXtoB7sxZF70v6arYNoY8oO++G
         2gZr5UF8lbu+ikaZ4hTd+g3xc589sDlUgYSy1sJE=
Message-ID: <cb85e1f4-2292-19d4-2b7e-f16c1b43d29f@ideasonboard.com>
Date:   Thu, 1 Dec 2022 11:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/7] clk: renesas: r8a779g0: Add display related clocks
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
 <20221123065946.40415-4-tomi.valkeinen+renesas@ideasonboard.com>
 <CAMuHMdUjCS6q44XmTanu=R68GyuVECLa0B-1AFg1CUD_oV4DuA@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <CAMuHMdUjCS6q44XmTanu=R68GyuVECLa0B-1AFg1CUD_oV4DuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/11/2022 21:18, Geert Uytterhoeven wrote:
> Hi Tomi,
> 
> On Wed, Nov 23, 2022 at 8:00 AM Tomi Valkeinen
> <tomi.valkeinen+renesas@ideasonboard.com> wrote:
>> Add clocks related to display which are needed to get the DSI output
>> working.
>>
>> Extracted from Renesas BSP tree.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
>> +++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
>> @@ -145,6 +145,8 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
>>          DEF_FIXED("viobusd2",   R8A779G0_CLK_VIOBUSD2,  CLK_VIO,        2, 1),
>>          DEF_FIXED("vcbus",      R8A779G0_CLK_VCBUS,     CLK_VC,         1, 1),
>>          DEF_FIXED("vcbusd2",    R8A779G0_CLK_VCBUSD2,   CLK_VC,         2, 1),
>> +       DEF_FIXED("dsiref",     R8A779G0_CLK_DSIREF,    CLK_PLL5_DIV4,  48, 1),
>> +       DEF_DIV6P1("dsiext",    R8A779G0_CLK_DSIEXT,    CLK_PLL5_DIV4,  0x884),
>>
>>          DEF_GEN4_SDH("sd0h",    R8A779G0_CLK_SD0H,      CLK_SDSRC,         0x870),
>>          DEF_GEN4_SD("sd0",      R8A779G0_CLK_SD0,       R8A779G0_CLK_SD0H, 0x870),
>> @@ -161,6 +163,14 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
>>          DEF_MOD("avb0",         211,    R8A779G0_CLK_S0D4_HSC),
>>          DEF_MOD("avb1",         212,    R8A779G0_CLK_S0D4_HSC),
>>          DEF_MOD("avb2",         213,    R8A779G0_CLK_S0D4_HSC),
>> +
> 
> Weird horizontal and vertical spacing below...

Yep. I added those to keep the lines more visible for me while working 
on this, but forgot to remove.

> 
>> +       DEF_MOD("dis0",                 411,    R8A779G0_CLK_S0D3),
> 
> I doubt this parent clock is correct.
> Based on Table 8.1.4e ("Lists of CPG clocks generated from PLL5"),
> this should be one of the VIOBUS clocks.
> VIOBUSD2 has the same rate as S0D3, so I'd use that one.

I'm pretty clueless about Renesas clocks, and I can't find a nice 
clock-tree picture from the docs, but looking at the table, what you say 
makes sense.

Both VIOBUS and VIOBUSD2 are marked to go to the video IPs, but with a 
bit of browsing, I can't find any more info about the clocking. Afaik, 
we don't care about the dis0 rate in the driver, so... Basically any 
clock will work here =). I'll pick VIOBUSD2 as you suggest (why would 
there be a /2 clock if it's not used...).

>> +       DEF_MOD("dsitxlink0",           415,    R8A779G0_CLK_DSIREF),
>> +       DEF_MOD("dsitxlink1",           416,    R8A779G0_CLK_DSIREF),
>> +
>> +       DEF_MOD("fcpvd0",               508,    R8A779G0_CLK_S0D3),
>> +       DEF_MOD("fcpvd1",               509,    R8A779G0_CLK_S0D3),
> 
> Likewise.

Ack.

>> +
>>          DEF_MOD("hscif0",       514,    R8A779G0_CLK_SASYNCPERD1),
>>          DEF_MOD("hscif1",       515,    R8A779G0_CLK_SASYNCPERD1),
>>          DEF_MOD("hscif2",       516,    R8A779G0_CLK_SASYNCPERD1),
>> @@ -193,6 +203,10 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
>>          DEF_MOD("tmu3",         716,    R8A779G0_CLK_SASYNCPERD2),
>>          DEF_MOD("tmu4",         717,    R8A779G0_CLK_SASYNCPERD2),
>>          DEF_MOD("tpu0",         718,    R8A779G0_CLK_SASYNCPERD4),
>> +
>> +       DEF_MOD("vspd0",                830,    R8A779G0_CLK_S0D1_VIO),
>> +       DEF_MOD("vspd1",                831,    R8A779G0_CLK_S0D1_VIO),
> 
> While S0D1_VIO is a VIO clock, it is clocked from PLL1, which supports
> spread-spectrum, unlike PLL5.
> Again, based on Table 8.1.4e ("Lists of CPG clocks generated from
> PLL5"), this should be one of the VIOBUS clocks.

Yep.

> Not that all of this matters a lot: all of these parents are always-on,
> and I think "dis0" is the only clock where we care about the actual
> clock rate?
No, of the clocks added above, in the drivers we only care about the 
dsiref rate. That's used for the DSI PLL, and that PLL is used as the 
DU's pclk.

  Tomi

