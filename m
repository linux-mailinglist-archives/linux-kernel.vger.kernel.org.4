Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA267E89A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjA0Osx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjA0Osu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:48:50 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102F44BD;
        Fri, 27 Jan 2023 06:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674830915; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SuETC3WYxVE/ebnr7f/naVh81gf7DyOXptYDKgkVV0HnM7+2pp8ibBe5+heF4por0NzTD2hlWFbXhsFGEApgksdqMnm2MbqOAeojUxZsKx0rDWPms5OMxNKL9TvXYvCZBLNxbxks3VW2fXdx4jx/RBL6fP4YOPbYTjrFVyJkq8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674830915; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=W4NNmlj/sNeDOj4gqCv0xqPrJ6qfWueEIwUDFntChso=; 
        b=Ydc7vZIH3MzKJQNiE+BZP5E+9sp3R58Svgp4m8VRKOjSQ3peNWnu4qvYnLVzzQ2THQ4pr6gkhI9Zfae9h3ZDrpFBEPz+r/lFMvOfAcZz/p+1FZVgnEdhubUWkv+cjhfltoy2QvJBLqv/STXDNwxFeMycDZidezqclxjHmPwfggY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674830915;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=W4NNmlj/sNeDOj4gqCv0xqPrJ6qfWueEIwUDFntChso=;
        b=qxBYNW+1EHsrHXNMmNnU1IOzNeizNcRnfMrUZQ3upgF2f4uJfaG0ECpeL7sFuhLc
        PkKK+J9i+mmLx2Sx791fbnkEzwbz8W6tqyqPGFxSkWLb47rPaez+gThZDAm+6wcBSEI
        EoZqMZkPdVVwgOZo/m6KrtzWWW2Hy+LGb3PqSNsQ=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1674830914372441.42181399158926; Fri, 27 Jan 2023 06:48:34 -0800 (PST)
Date:   Fri, 27 Jan 2023 22:48:34 +0800
From:   Li Chen <me@linux.beauty>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "li chen" <lchen@ambarella.com>,
        "michael turquette" <mturquette@baylibre.com>,
        "stephen boyd" <sboyd@kernel.org>,
        "rob herring" <robh+dt@kernel.org>,
        "krzysztof kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:common clk framework" <linux-clk@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "arnd bergmann" <arnd@arndb.de>
Message-ID: <185f3b3a330.11c135c37327076.6300919877819761183@linux.beauty>
In-Reply-To: <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
 <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
 <87sffyhgvw.wl-me@linux.beauty> <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
 ---- On Thu, 26 Jan 2023 19:29:05 +0800  Krzysztof Kozlowski  wrote --- 
 > On 25/01/2023 14:40, Li Chen wrote:
 > > On Wed, 25 Jan 2023 20:14:16 +0800,
 > > 
 > > Hi Krzysztof,
 > > 
 > > Krzysztof Kozlowski wrote:
 > >>
 > >> On 25/01/2023 13:06, Li Chen wrote:
 > >>>>> Feel free to correct me if you think this
 > >>>>> is not a good idea.
 > >>>>
 > >>>> This is bad idea. Compatibles should be specific. Devices should not use
 > >>>> syscons to poke other registers, unless strictly necessary, but have
 > >>>> strictly defined MMIO address space and use it.
 > >>>
 > >>> Ok, I will convert syscon-based regmaps to SoC-specific compatibles and of_device_id->data.
 > >>>
 > >>> But I have three questions:
 > >>>
 > >>> 0. why syscon + offsets is a bad idea copared to specific compatibles?
 > >>
 > >> Specific compatibles are a requirement. They are needed to match device
 > >> in exact way, not some generic and unspecific. The same with every other
 > >> interface, it must be specific to allow only correct usage.
 > >>
 > >> It's of course different with generic fallbacks, but we do not talk
 > >> about them here...
 > >>
 > >>> 1. when would it be a good idea to use syscon in device tree?
 > >>
 > >> When your device needs to poke one or few registers from some
 > >> system-controller block.
 > >>
 > >>> 2. syscon VS reg, which is preferred in device tree?
 > >>
 > >> There is no such choice. Your DTS *must* describe the hardware. The
 > >> hardware description is for example clock controller which has its own
 > >> address space. If you now do not add clock controller's address space to
 > >> the clock controller, it is not a proper hardware description. The same
 > >> with every other property. If your device has interrupts, but you do not
 > >> add them, it is not correct description.
 > > 
 > > Got it. But Ambarella hardware design is kind of strange. I want to add mroe
 > > expalaination about why Ambarella's downstream kernel
 > > use so much syscon in device trees:
 > > 
 > > For most SoCs from other vendors, they have seperate address space regions
 > > for different peripherals, like
 > > axi address space A: ENET
 > > axi address space B: PCIe
 > > axi address space B: USB
 > > ...
 > > 
 > > Ambarella is somewhat **different**, its SoCs have two system controllers regions:
 > > RCT and scratchpad, take RCT for example:
 > > "The S6LM system software
 > > interacts with PLLs, PHYs and several other low-level hardware blocks using APB reset clock and test (RCT)
 > > registers with a system-layer application programming interface (API).
 > > This includes the setting of clock frequencies."
 > > 
 > > There are so many peripherals registers located inside RCT and scratchpad
 > > (like usb/phy, gpio, sd, dac, enet, rng), and some peripherals even have no their
 > > own modules for register definitions.
 > 
 > Then the syscon is the parent device of these peripherals and clocks.
 > You did not represent them as children but as siblings which does not
 > look correct.
 
Ok, I will these syscon(RCT  and scratchpad) as the parent node of our clocks and related peripherals.

 > > 
 > > So most time(for a peripheral driver), the only differences between different
 > > Ambarella SoCs are just the syscon(rct or scratchpad) offsets get changed.
 > > 
 > > I don't think such lazy hardware design is common in vendors other than ambarella.
 > > 
 > > If I switch to SoC-specific compatibles, 
 > 
 > This is independent topic. SoC-specific compatibles are a requirement
 > but it does not affect your device hierarchy.
 
Thanks, "requirement" makes things much more clear. So I will always use SoC-specific compatibles even
if different Amarella SoCs may share the same reg offset and setting.

 > > and remove these syscon from device tree,
 > > of_device_id->data may only contain system controller(rct or scratchpad) offset for many Ambarella drivers,
 > > and ioremap/devm_ioremap carefully.
 > 
 > I don't understand the problem. Neither the solution.
 > 
 > > 
 > > The question is: can upstream kernel accept such codes?
 > > 
 > > If yes, I will switch to SoC-specific compatibles and remove syscon without hesitation.
 > 
 > Sorry, none of your explanations here match your DTS. Your DTS clearly
 > models (for some reason there is no soc which makes even bigger confusion):
 > 
 > rct_syscon
 > clocks
 >  |-gclk-core
 >  |-gclk-ddr
 > 
 > but what you are saying is that there is no separate clock controller
 > device with its own IO address but these clocks are part of rct_syscon.
 > Then model it that way in DTS. The rct_syscon is then your clock
 > controller and all these fake gclk-core and gclk-ddr nodes should be gone.

Ok, I will remove these fake nodes, and model the hardware as:

rct_syscon node
| clock node(pll, div, mux, composite  clocks live in the same driver)
| other periphal nodes

Regards,
Li
