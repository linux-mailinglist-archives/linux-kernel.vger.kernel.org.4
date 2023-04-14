Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89B6E1E96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDNInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDNInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:43:03 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B008E7EC5;
        Fri, 14 Apr 2023 01:42:51 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 81CE020B6B;
        Fri, 14 Apr 2023 10:42:45 +0200 (CEST)
Date:   Fri, 14 Apr 2023 10:42:42 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: bridge: toshiba,tc358768:
 add parallel input mode
Message-ID: <ZDkSAsdijlL7YzzV@francesco-nb.int.toradex.com>
References: <20230330095941.428122-1-francesco@dolcini.it>
 <20230330095941.428122-4-francesco@dolcini.it>
 <a924186c-31d3-b7f0-085f-97b849a4d751@linaro.org>
 <ZCaqcaq02VDsqCPJ@francesco-nb.int.toradex.com>
 <20230403210117.GA1722054-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403210117.GA1722054-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob and Krzysztof

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
> > tc358768 is a parallel RGB to DSI bridge, it has 24 bit parallel input
> > line.
> > 
> > The way this lines are connected is configurable with this parameter, if you
> > look at mode 0 and 1 they all allow to have a RGB888 or a RGB666 or a
> > RGB565 mapping. This just configure some internal mux, it's not strictly
> > about the RGB mode.
> 
> This is the same as other cases. There's a need for describing the 
> interface. It keeps coming up and I keep saying to go create something 
> common.

Rob, Krzysztof: you both had concerns on this change and I am not sure how
to progress. Let me summarize my current understanding.

1. I do not think that this change is related to the media bus format
   topic, this is more like the internal bridge RGB pins mux
   configuration. This `input-rgb-mode` field I am proposing here is
   orthogonal to the bus format (e.g. linux media-bus-format.h). I can
   change the name, if we think this is the reason of the confusion, I
   just used something similar to the words used in the datasheet.
   
   Do we have agreement on that or not?

2. Rob asked for a generic solution, since according to him this is a
   recurring need. I would appreciate some pointer where to look at so I
   can propose something more generic.

Thanks,
Francesco

