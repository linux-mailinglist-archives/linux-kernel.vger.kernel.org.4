Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC85716A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjE3RRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjE3RRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:17:21 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4BD98;
        Tue, 30 May 2023 10:17:20 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id A3735207A3;
        Tue, 30 May 2023 19:17:18 +0200 (CEST)
Date:   Tue, 30 May 2023 19:17:17 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] arm64: dts: ti: add verdin am62
Message-ID: <ZHYvnSMSnzoaYvWm@francesco-nb.int.toradex.com>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-4-francesco@dolcini.it>
 <20230530121044.sjhv452b4hs4lyiy@flyer>
 <ZHYl8/8k4CTm/2LW@francesco-nb.int.toradex.com>
 <20230530165351.rqpu7go3kw6j3upc@storable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530165351.rqpu7go3kw6j3upc@storable>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:53:51AM -0500, Nishanth Menon wrote:
> On 18:36-20230530, Francesco Dolcini wrote:
> > On Tue, May 30, 2023 at 07:10:44AM -0500, Nishanth Menon wrote:
> > > On 16:36-20230524, Francesco Dolcini wrote:
> > > > +/* Verdin I2C_2_DSI */
> > > > +&main_i2c2 {
> > > > +	status = "okay";
> > > 
> > > Here and few other dtsis:
> > > you should set status along with pinmux.
> > This is already done in the SoM dtsi, same applies to the other comment
> > you have on this pinmux topic.
> > 
> > To rephrase what's hopefully is already written in the commit
> > message/series description, or at least it was in my intention.
> > 
> > The system is modular, with multiple SoM variant and multiple carrier
> > boards. Standard interfaces are defined at the family level, e.g.
> > already in the SoM, in the carrier board DT file peripherals are just
> > enabled, the pinmux is already defined in the common som.dtsi [1][2][3]
> > files and the carrier board just use those unless there is some kind of
> > non-standard deviation.
> > 
> > This prevents duplication and simplify writing device tree file for board
> > that use standard Verdin family interfaces. This should be visible
> > looking at this series in which 3 different boards (Dev, Yavia and
> > Dahlia) are added.
> 
> It helps clarity if the node is marked "okay" when all the necessary
> properties required for operation (in this case pinmux) is enabled. I
> don't see a big change as a result. Just stops people from hunting for
> where pinmux is actually done.

I would disagree here, I would prefer to keep this as it is.
Of course, doing the change you request here is trivial, just some copy
paste.

The pinctrl is not all the necessary properties, you still need go
hunting on the dtsi includes hierarchy to see that everything is there.
And I think this is just fine, we do this just to avoid duplicating
common stuff.

What you get for sure is information duplication, with all the
interfaces that are enabled getting the same pinctrl on
multiple files.

Just on this series you have 3 carrier boards, we have 1 more we should
just send and they all share mostly the same pinmux.
... And the Verdin AM62 is really a very brand new product.

From my point of view I would also lose some clarity, since the current
structure, at least to some extent, helps understanding when a carrier
board is deviating from the family specification.

I hope this explanation gives some more context.

Francesco


