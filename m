Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBE70FE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjEXTUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXTUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:20:11 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F109F12F;
        Wed, 24 May 2023 12:20:07 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (unknown [IPv6:2a04:ee41:1:104e:5095:4ae:12ec:a72f])
        by mail11.truemail.it (Postfix) with ESMTPA id E8997206F6;
        Wed, 24 May 2023 21:20:05 +0200 (CEST)
Date:   Wed, 24 May 2023 21:20:01 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrew Davis <afd@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et
 al.
Message-ID: <ZG5jYV/NfGJvYkma@francesco-nb.int.toradex.com>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-2-francesco@dolcini.it>
 <a87d493a-0f16-0096-0a01-5bbeddf4cfee@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87d493a-0f16-0096-0a01-5bbeddf4cfee@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Wed, May 24, 2023 at 12:48:34PM -0500, Andrew Davis wrote:
> On 5/24/23 9:36 AM, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
> > nonwifi and wifi variants and the carrier boards (Dahlia,
> > Verdin Development Board and Yavia) they may be mated in.
> > 
> > Link: https://developer.toradex.com/hardware/verdin-som-family/modules/verdin-am62/
> > Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >   .../devicetree/bindings/arm/ti/k3.yaml        | 20 +++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > index e1183f90bb06..e3aee191d403 100644
> > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > @@ -33,6 +33,26 @@ properties:
> >                 - ti,am62-lp-sk
> >             - const: ti,am625
> > +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards
> > +        items:
> > +          - enum:
> > +              - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module on Dahlia
> > +              - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module on Verdin Development Board
> > +              - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module on Yavia
> > +          - const: toradex,verdin-am62-nonwifi     # Verdin AM62 Module without Wi-Fi / BT
> 
> Does this add anything? Not sure we need to split compatibles based on this, things
> like wifi vs nowifi can be described in DT, same for different memory size models, etc..
>
> In fact I'm not sure we get much value at all out of top level whole-SoC compatible
> strings. Maybe we did when there was matching in kernel to do device specific fixups,
> but that isn't really used much in ARM64.

This is useful, as an example, once you add DT overlays to the mix and
you use the compatible to match for "compatibility". An overlay could be
compatible with the SoC, with the SoM (module + SoC) or with the
complete board (Soc + SoM + carrier board).

Our system is modular and this is described with this multiple layer of
DT compatibles and with a similar layering of dtsi includes.

On the wifi vs non-wifi topic, that is IMO the most conflicting one, the
main reason is that the SoM has different assembly options, and this
affects the pinmux and the functionality available to the carrier, up to
the SoM edge connector (this could make an overlay compatible only with
a board with/without-wifi). As an example there is a SDIO interface
that is used for the on-SoM Wi-Fi in the Wi-Fi/BT variant, or available
on the edge connector otherwise. An overlay using this SDIO interface
would be compatible only with the non-wifi variant. Additional GPIOs or
other signals might have the exact same situations.

On this last variant (wifi vs non-wifi) I am not sure how often is used,
we have the exact same approach with multiple NXP i.MX based boards and it
proved itself to work fine.

Francesco

