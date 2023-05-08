Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDEE6FB479
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjEHP4Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEHP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:56:14 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2C90;
        Mon,  8 May 2023 08:56:11 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pw3DW-00063i-N6; Mon, 08 May 2023 17:56:02 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
Date:   Mon, 08 May 2023 17:56:01 +0200
Message-ID: <3554468.R56niFO833@diego>
In-Reply-To: <20230508-refute-reliable-f50dafa6afbd@wendy>
References: <20230507182304.2934-1-jszhang@kernel.org> <7518428.EvYhyI6sBW@diego>
 <20230508-refute-reliable-f50dafa6afbd@wendy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 8. Mai 2023, 10:35:38 CEST schrieb Conor Dooley:
> On Mon, May 08, 2023 at 10:23:02AM +0200, Heiko Stübner wrote:
> > Am Montag, 8. Mai 2023, 05:32:17 CEST schrieb Icenowy Zheng:
> > > 在 2023-05-07星期日的 22:35 +0100，Conor Dooley写道：
> > > > Hey Jisheng,
> > > > 
> > > > On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> > > > 
> > > > > +               c910_0: cpu@0 {
> > > > > +                       compatible = "thead,c910", "riscv";
> > > > > +                       device_type = "cpu";
> > > > > +                       riscv,isa = "rv64imafdc";
> > > > 
> > > > Does this support more than "rv64imafdc"?
> > > > I assume there's some _xtheadfoo extensions that it does support,
> > > > although I am not sure how we are proceeding with those - Heiko might
> > > > have a more nuanced take.
> > 
> > I guess the interesting question still is, are these part of the isa
> > string or more of an errata?
> 
> Yeah, I dunno. That's possible a policy decision more than anything
> else. I don't remember if it was one of your patchsets or elsewhere, but
> I do recall a split between xtheadba etc and vector, where xtheadba was
> defined as a vendor extension, whereas vector is not. Their extension
> spec repo <https://github.com/T-head-Semi/thead-extension-spec> appears
> to be aligned with that view, apart from the CMOs that we have already
> called an erratum.

I think the CMO stuff came a bit before that repo actually existed ;-) .

I guess another argument for riscv,isa would be that we don't have to
trust MVENDORID, and especially values in MARCHID and MIMPID.

Somehow part of me doesn't have enough trust that these values will
always be suitably different when they are baked into the hardware ;-) .


I guess vector is somewhat special, with it implementing version 0.7.1
it's not a t-head invention but also not the real RISCV "v" .

So I _guess_ the jury might still be out on how to handle that everywhere.


> > The binding currently says
> >       Identifies the specific RISC-V instruction set architecture
> >       supported by the hart.  These are documented in the RISC-V
> >       User-Level ISA document, available from
> >       https://riscv.org/specifications/
> > 
> > 
> > I guess if we decide to make them part of the isa-string the binding
> > then should get a paragraph mention _xfoo vendor-extensions too.
> 
> I have an idea in the works that may allow dealing with this kind of
> thing, but it's a bit of a departure from the existing binding.
> I will hopefully post an early RFC of it later today.
> That said, the binding does currently allow you to put in _xfoo vendor
> extensions as-is.
> 
> > Personally, making these part of the ISA string definitly sounds like
> > the best solution though :-) .
> 
> You would say that wouldn't you! In general, I'd rather we filled in as
> much information as possible here, even if it is not currently in use,
> to avoid having to retrofit as support becomes available.

yep definitively.
Especially as switching to expecting _xfoo later on then causes of course
compatiblity issues. The fun part will be though to get vendors,
toolchains and friends to agree on the naming.


Heiko
 



