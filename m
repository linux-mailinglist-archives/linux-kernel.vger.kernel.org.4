Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5E6FA213
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjEHIXR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 04:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjEHIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:23:14 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AAE1A10A;
        Mon,  8 May 2023 01:23:10 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pvw99-0003K2-5u; Mon, 08 May 2023 10:23:03 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Date:   Mon, 08 May 2023 10:23:02 +0200
Message-ID: <7518428.EvYhyI6sBW@diego>
In-Reply-To: <394696a52bf1d767044e3f990cebfbaf69dabe70.camel@icenowy.me>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507-calamari-gentleman-bbe62af06f92@spud>
 <394696a52bf1d767044e3f990cebfbaf69dabe70.camel@icenowy.me>
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

Am Montag, 8. Mai 2023, 05:32:17 CEST schrieb Icenowy Zheng:
> 在 2023-05-07星期日的 22:35 +0100，Conor Dooley写道：
> > Hey Jisheng,
> > 
> > On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> > 
> > > +               c910_0: cpu@0 {
> > > +                       compatible = "thead,c910", "riscv";
> > > +                       device_type = "cpu";
> > > +                       riscv,isa = "rv64imafdc";
> > 
> > Does this support more than "rv64imafdc"?
> > I assume there's some _xtheadfoo extensions that it does support,
> > although I am not sure how we are proceeding with those - Heiko might
> > have a more nuanced take.

I guess the interesting question still is, are these part of the isa
string or more of an errata?

The binding currently says
      Identifies the specific RISC-V instruction set architecture
      supported by the hart.  These are documented in the RISC-V
      User-Level ISA document, available from
      https://riscv.org/specifications/


I guess if we decide to make them part of the isa-string the binding
then should get a paragraph mention _xfoo vendor-extensions too.

Personally, making these part of the ISA string definitly sounds like
the best solution though :-) .


> > > +               reset: reset-sample {
> > > +                       compatible = "thead,reset-sample";
> > 
> > What is a "reset-sample"?
> > 
> > > +                       entry-reg = <0xff 0xff019050>;
> > > +                       entry-cnt = <4>;
> > > +                       control-reg = <0xff 0xff015004>;
> > > +                       control-val = <0x1c>;
> > > +                       csr-copy = <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3
> > > 0x7c5 0x7cc>;
> > > +               };
> > > +
> > > +               plic: interrupt-controller@ffd8000000 {
> > > +                       compatible = "thead,c910-plic";
> > > +                       reg = <0xff 0xd8000000 0x0 0x01000000>;
> > > +                       interrupts-extended = <&cpu0_intc 11>,
> > > <&cpu0_intc 9>,
> > > +                                             <&cpu1_intc 11>,
> > > <&cpu1_intc 9>,
> > > +                                             <&cpu2_intc 11>,
> > > <&cpu2_intc 9>,
> > > +                                             <&cpu3_intc 11>,
> > > <&cpu3_intc 9>;
> > > +                       interrupt-controller;
> > > +                       #interrupt-cells = <1>;
> > > +                       riscv,ndev = <240>;
> > > +               };
> > > +
> > > +               clint: timer@ffdc000000 {
> > > +                       compatible = "thead,c900-clint";
> > 
> > "c900"? That a typo or intentional. Hard to tell since this
> > compatible
> > is undocumented ;)
> 
> Intentional, for supporting both C906 and C910.
> 
> However, as we discussed in some binding patches, there should be a DT
> binding string per chip.
> 
> So here should be "thead,light-clint", "thead,c900-clint".
> 
> (Or use th1520, the marketing name, instead of light, the codename)

I'm definitly confused now :-)

c900 as well as something like c9xx should not be part of dt-bindings.
Binding-names should always denote _actual_ component names.

So you can do
	"thead,c906-clint"
and for example
	"thead,c910-clint", "thead,c906-clint"

to describe that the clint in the c910 is compatible with the one in c906


I don't think there should be a "thead,light-clint" ... the clint is part
of the cpu core itself so the soc itself shouldn't introduce any changes?


Heiko


