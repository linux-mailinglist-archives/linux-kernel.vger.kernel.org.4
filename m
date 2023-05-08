Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FFA6FB5BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjEHRJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:09:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48D83;
        Mon,  8 May 2023 10:09:25 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pw4MT-0006Oq-Gq; Mon, 08 May 2023 19:09:21 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>
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
Date:   Mon, 08 May 2023 19:09:20 +0200
Message-ID: <2344188.NG923GbCHz@diego>
In-Reply-To: <20230508-unmoved-unvocal-9a6c5fc0c629@spud>
References: <20230507182304.2934-1-jszhang@kernel.org> <ZFkiotPacIMUghDP@xhacker>
 <20230508-unmoved-unvocal-9a6c5fc0c629@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 8. Mai 2023, 18:44:04 CEST schrieb Conor Dooley:
> On Tue, May 09, 2023 at 12:26:10AM +0800, Jisheng Zhang wrote:
> > On Sun, May 07, 2023 at 10:35:12PM +0100, Conor Dooley wrote:
> > > On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> > > 
> > > > +		c910_0: cpu@0 {
> > > > +			compatible = "thead,c910", "riscv";
> > > > +			device_type = "cpu";
> > > > +			riscv,isa = "rv64imafdc";
> > > 
> > > Does this support more than "rv64imafdc"?
> > > I assume there's some _xtheadfoo extensions that it does support,
> > > although I am not sure how we are proceeding with those - Heiko might
> > > have a more nuanced take.
> > > 
> > > > +		reset: reset-sample {
> > > > +			compatible = "thead,reset-sample";
> > > 
> > > What is a "reset-sample"?
> > 
> > This node is only for opensbi. The compatible string is already in
> > opensbi. Do we also need to add dt-binding for it in linux?
> 
> If it's to be included in the kernel's dts, then yes, you do need a
> dt-binding. If you remove it, then you don't :)
> 
> That said, "thead,reset-sample" is a strangely named compatible, so if
> you do keep it it may end up needing a rename!

and you'll need to justify that this describes actual hardware
(dt-maintainers iterate all the time that dt is a hardware description, not
a configuration scheme).

The question also would be if this is part of upstream opensbi at all.


In general though, openSBI does something similar with their perf-counter
description. Describing the mapping and eventids usable in which counter
via a structure passed from u-boot to openSBI.

The difference here is, that openSBI then removes the relevant nodes from
the dt, so that the kernel never sees them [0] .

As you reset-sample seems to fall into a similar category, I guess
it would be better suited in an a foo-u-boot.dtsi ?


[0] https://github.com/riscv-software-src/opensbi/blob/master/lib/utils/fdt/fdt_pmu.c#L42


