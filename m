Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685316D5360
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjDCVUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjDCVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:20:50 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826EF46A8;
        Mon,  3 Apr 2023 14:20:22 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (unknown [IPv6:2a04:ee41:1:104e:5a23:1854:3475:1ad6])
        by mail11.truemail.it (Postfix) with ESMTPA id BBBAA20B6B;
        Mon,  3 Apr 2023 23:20:11 +0200 (CEST)
Date:   Mon, 3 Apr 2023 23:20:10 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: bridge: toshiba,tc358768:
 add parallel input mode
Message-ID: <ZCtDCu7CgsPKiMJh@francesco-nb.int.toradex.com>
References: <20230330095941.428122-1-francesco@dolcini.it>
 <20230330095941.428122-4-francesco@dolcini.it>
 <a924186c-31d3-b7f0-085f-97b849a4d751@linaro.org>
 <ZCaqcaq02VDsqCPJ@francesco-nb.int.toradex.com>
 <20230403210117.GA1722054-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403210117.GA1722054-robh@kernel.org>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 04:01:17PM -0500, Rob Herring wrote:
> On Fri, Mar 31, 2023 at 11:40:01AM +0200, Francesco Dolcini wrote:
> > On Fri, Mar 31, 2023 at 10:48:15AM +0200, Krzysztof Kozlowski wrote:
> > > On 30/03/2023 11:59, Francesco Dolcini wrote:
> > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > 
> > > > Add new toshiba,input-rgb-mode property to describe the actual signal
> > > > connection on the parallel RGB input interface.
> > > > 
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > >  .../bindings/display/bridge/toshiba,tc358768.yaml | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > > > index 8f22093b61ae..2638121a2223 100644
> > > > --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > > > @@ -42,6 +42,21 @@ properties:
> > > >    clock-names:
> > > >      const: refclk
> > > >  
> > > > +  toshiba,input-rgb-mode:
> > > > +    description: |
> > > > +      Parallel Input (RGB) Mode.
> > > > +
> > > > +      RGB inputs (PD[23:0]) color arrangement as documented in the datasheet
> > > > +      and in the table below.
> > > > +
> > > > +      0 = R[7:0], G[7:0], B[7:0]
> > > 
> > > RGB888?
> > 
> > Or anything else - like a RGB666 - just connecting to GND the unused
> > pins.
> 
> If the bridge is configured for RGB666, then that's fine. If not, the 
> unused pins should be driven with either the MSB of each component. 
> Otherwise, you'd can't fully saturate the colors.

maybe a detail and maybe not really relevant, but this specific bridge
has no know-how on the actual RGB inputs width. While I understand what
you are saying here, in the end this is about the actual hardware design
that can be in any way, including having pins to gnd and have the issue
you just described.

Francesco

