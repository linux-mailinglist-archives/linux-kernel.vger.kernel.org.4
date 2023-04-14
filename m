Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75396E18EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDNAWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNAWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:22:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54330DE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:22:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q26so9173953lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681431767; x=1684023767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2h8UP2fVNir/mlJb3DtYQWU1BlBEr4flUsHs5kTkik=;
        b=UeHV34+++UD1xg4Mlnz2QEa2/bjfKP68RGlnUr7C7xNgytSHN3T3FvgzOQwMcqo81h
         76BoThWihKYvIUmE1QUOkyh0oXMuIYc+HVWBnKywHyeD+y71UgM6WUG1wdLGQsp9TpD0
         IZLT8g+HBT0ZLoOKPMl4NbTTPNZ3Icr8zNrwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431767; x=1684023767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D2h8UP2fVNir/mlJb3DtYQWU1BlBEr4flUsHs5kTkik=;
        b=DXdXeIO2/9vdcZdAnw1J+X4sbsoLU3biiaYdcrFssD6rMfpXm81UwRW0kgx4iXSeyG
         4z896nGXbHF4qmoqD2CRquJf/5nRQt9GZ5+obKtfD5SfnJHTlzWUbw7mIS74psjZDLrt
         ZiTawo3L/JdU4kW2a4RAokaLynscosLc5RUXhIqqRTbYAo8FkQdXfI/WIkc+llMg/dRI
         zYxWCTQsdzhjEnRVnUaD3S+Ked7GhlOdpXZQyJTAKjg2AdwvxNkKgmdX5F4i7sC41lpC
         3QMGV+TJx69rDK1gl97XNPIGjCkC5jTIM93vyoXimlhSA+LG/hORIgGz5XiTyOSTVLPK
         71Nw==
X-Gm-Message-State: AAQBX9dC1888jgqwKCx8xavUnf1wox2lXEVWouOXfnQsZWfziY+HpFrd
        lV0WKwUOQN2s/qkDIBXRcE5H9SZoyaAKXn/NNnbC4A==
X-Google-Smtp-Source: AKy350bprd5zOQguHUQVfLjG9BqP+VRKgX5ZrLRZgSRPaIYy3Xin3YAKbmJXG7K4WSxFpl7jSP2A64ZUzUOqixQQUgo=
X-Received: by 2002:ac2:5334:0:b0:4ec:8a46:d1e with SMTP id
 f20-20020ac25334000000b004ec8a460d1emr1312136lfh.4.1681431766845; Thu, 13 Apr
 2023 17:22:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Apr 2023 17:22:46 -0700
MIME-Version: 1.0
In-Reply-To: <CAEXTbpdcbB_z4ZGCGzc-cM74ECKyxekbroKCWFnhH8eR=4HmvA@mail.gmail.com>
References: <20230331091145.737305-1-treapking@chromium.org>
 <20230331091145.737305-5-treapking@chromium.org> <CAE-0n51E5foFWQAsA73662_5e6XP426wuUCVVmcS5UWwiYpDmw@mail.gmail.com>
 <CAEXTbpdcbB_z4ZGCGzc-cM74ECKyxekbroKCWFnhH8eR=4HmvA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 13 Apr 2023 17:22:46 -0700
Message-ID: <CAE-0n50atfmr-bFh5XtTCm4WpSijJGSe0B5JP8ni7CCYk7Bs5A@mail.gmail.com>
Subject: Re: [PATCH v15 04/10] dt-bindings: display: bridge: anx7625: Add
 mode-switch support
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Daniel Scally <djrscally@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Xin Ji <xji@analogixsemi.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lyude Paul <lyude@redhat.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pin-yen Lin (2023-04-13 02:50:44)
> Hi Stephen,
>
> On Wed, Apr 12, 2023 at 10:38=E2=80=AFAM Stephen Boyd <swboyd@chromium.or=
g> wrote:
> >
> > Quoting Pin-yen Lin (2023-03-31 02:11:39)
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogi=
x,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,=
anx7625.yaml
> > > index b42553ac505c..604c7391d74f 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx76=
25.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx76=
25.yaml
> > > @@ -12,7 +12,8 @@ maintainers:
> > >
> > >  description: |
> > >    The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> > > -  designed for portable devices.
> > > +  designed for portable devices. Product brief is available at
> > > +  https://www.analogix.com/en/system/files/AA-002291-PB-6-ANX7625_Pr=
oductBrief.pdf
> > >
> > >  properties:
> > >    compatible:
> > > @@ -112,9 +113,40 @@ properties:
> > >                data-lanes: true
> > >
> > >        port@1:
> > > -        $ref: /schemas/graph.yaml#/properties/port
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > >          description:
> > > -          Video port for panel or connector.
> > > +          Video port for panel or connector. Each endpoint connects =
to a video
> > > +          output downstream, and the "data-lanes" property is used t=
o describe
> > > +          the pin connections. 0, 1, 2, 3 in "data-lanes" maps to SS=
RX1, SSTX1,
> > > +          SSRX2, SSTX2, respectively.
> > > +
> > > +        patternProperties:
> > > +          "^endpoint@[01]$":
> > > +            $ref: /schemas/media/video-interfaces.yaml#
> > > +            properties:
> > > +              reg: true
> > > +
> > > +              remote-endpoint: true
> > > +
> > > +              data-lanes:
> > > +                oneOf:
> > > +                  - items:
> > > +                      - enum: [0, 1, 2, 3]
> > > +
> > > +                  - items:
> > > +                      - const: 0
> > > +                      - const: 1
> > > +
> > > +                  - items:
> > > +                      - const: 2
> > > +                      - const: 3
> > > +
> > > +              mode-switch:
> >
> > Is it possible to not have this property? Can we have the driver for
> > this anx device look at the remote-endpoint and if it sees that it is
> > not a drm_bridge or panel on the other end, or a DP connector, that it
> > should register a typec mode switch (or two depending on the number of
> > endpoints in port@1)? Is there any case where that doesn't hold true?
> >
> > I see these possible scenarios:
> >
> > 1. DPI to DP bridge steering DP to one of two usb-c-connectors
> >
> > In this case, endpoint@0 is connected to one usb-c-connector and
> > endpoint@1 is connected to another usb-c-connector. The input endpoint
> > is only connected to DPI. The USB endpoint is not present (although I
> > don't see this described in the binding either, so we would need a
> > port@2, entirely optional to describe USB3 input). The driver will
> > register two mode switches.
> >
> > 2. DPI to DP bridge with USB3 to one usb-c-connector
> >
> > In this case, endpoint@1 doesn't exist. The SSTX1/2 and SSRX1/2 pins ar=
e
> > all connected to a usb-c-connector node. The input ports (0 and 2) are
> > connected to both DPI and USB. The device acts as both a mode-switch an=
d
> > an orientation-switch. It registers both switches. I wonder if there is
> > any benefit to describing SBU connections or CC connections? Maybe we
> > don't register the orientation-switch if the SBU or CC connection isn't
> > described?
> >
> > 3. DPI to DP bridge connected to eDP panel
> >
> > In this case, endpoint@1 doesn't exist. The USB endpoint is not present
> > (port@2). Depending on how the crosspoint should be configured, we'll
> > need to use data-lanes in the port@1 endpoint to describe which SSTRX
> > pair to use (1 or 2). Or we'll have to use the endpoint's reg property
> > to describe which pair to drive DP on. Presumably the default
> > configuration is SSRX2/SSTX2 providing 2 lanes of DP to an eDP panel.
> > The endpoint@0 in port@1 will be connected to a drm_panel, and the
> > driver will be able to detect this properly by checking for the
> > existence of an aux-bus node or the return value of
> > of_dp_aux_populate_bus().
>
> Can we assume that the eDP panel always stays behind an `aux-bus`
> node? Can't the panel be connected to the bridge directly in the
> graph? Though this might not matter if we only register mode switches
> when there are usb-c-connectors connected.

The panel is connected to the bridge in the graph. I think we should
assume the eDP panel is on an aux-bus. Maybe another scenario is a
design that has a DP to HDMI bridge wired down on the device? In which
case the output port would be connected to the HDMI bridge.

> >
> > 4. DPI to DP bridge connected to DP connector
> >
> > This is similar to the eDP panel scenario #3. In this case, endpoint@1
> > doesn't exist. The USB endpoint is not present (port@2). Same story
> > about port@1 and lane configuration, but we don't have an aux-bus node.
> > In this case, the drivers/gpu/drm/bridge/display-connector.c driver wil=
l
> > probe for the dp-connector node and add a drm_bridge. This anx driver
> > will similarly add a drm_bridge, but it needs to look at the node
> > connected on port@1:endpoint@0 with drm_of_get_bridge() and check if it
> > is a drm_bridge (DP connector) or if it is some type-c thing (connector
> > or orientation-switch).
> >
> > I think having this mode-switch property here lets us avoid calling
> > drm_of_get_bridge() unconditionally in anx7625_parse_dt().
> > drm_of_get_bridge() will always return -EPROBE_DEFER when this is the
> > last drm_bridge in the chain and the other side of the endpoint is a
> > type-c thing (scenarios #1 and #2). Maybe we should teach
> > drm_of_get_bridge() that a drm_bridge might be connected to a type-c
> > device and have it not return -EPROBE_DEFER in that case. Or make some
> > new API like drm_of_get_bridge_typec() that checks if the typec
> > framework knows about the endpoint in question (as either a typec switc=
h
> > or a connector) and returns a NULL bridge pointer. If we had that then =
I
> > think this property is not necessary.
> >
> > Hopefully the usb-c-connector can always be registered with the typec
> > framework? I'm worried that the driver that registers the
> > usb-c-connector node may want to form a struct typec_port with
> > typec_register_port() and that will get stuck in a similar -EPROBE_DEFE=
R
> > loop waiting for this mode-switch to appear. So having this property
> > also avoids that problem by telling typec framework to wait until this
> > driver can register a mode-switch.
> >
> > TL;DR: Is this mode-switch property a workaround for probe defer? Can w=
e
> > figure out where the mode switch is in software and not have the
> > property in DT? If we can it would certainly improve things because
> > forgetting to add the property can lead to broken behavior, and we don'=
t
> > do anything like this for chains of drm_bridge devices. We just describ=
e
> > the display chain and let the kernel figure out which bridge should
> > handle hpd, edid reading, or mode detection, etc.
>
> Actually the `mode-switch` property here is mainly because
> `fwnode_typec_mux_get`[1] and `typec_mux_match`[2] only return matches
> when the property is present. I am not sure what side effects would be
> if I remove the ID-matching condition in `typec_mux_match`, so I added
> the property here.
>
> Is it feasible to remove the `mode-switch` property here given the
> existing implementation of the Type-C framework?

Omitting the mode-switch property would require changes to the type-c
framework.

I'm wondering if we can have this anx driver register mode switches for
however many endpoints exist in the output port all the time when the
aux-bus node doesn't exist. Then the type-c framework can walk from the
usb-c-connector to each connected node looking for a device that is both
a drm_bridge and a mode-switch. When it finds that combination, it knows
that the mode-switch has been found. This hinges on the idea that a
device that would have the mode-switch property is a drm_bridge and
would register a mode-switch with the type-c framework.

It may be a little complicated though, because we would only register
one drm_bridge for the input to this anx device. The type-c walking code
would need to look at the graph endpoint, and find the parent device to
see if it is a drm_bridge.
