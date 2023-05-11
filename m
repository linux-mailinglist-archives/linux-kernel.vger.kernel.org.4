Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ADD6FF869
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbjEKRab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbjEKRa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:30:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B192840D7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:30:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f22908a082so7011815e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683826223; x=1686418223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fg8PRT8lkm3NPG8eSAKVMEE5ErkK9HmIXAxn27oczZs=;
        b=VTN9N0z2GsuFCm4SJGRZ/zR2tPa24eBCC8JF2Hft6EJmkWPX/s3vIUK4nuG5n5nWJ/
         nE/e05S270+8cRS2tYdJs2Oq8VIqYR15aXaig9dVHs/hRxEYwBrYUfy1bKvdJlthMIgP
         nHUCLIrXHx9Fuyug8KFKu9/7cfowMEhPOmw0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683826223; x=1686418223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fg8PRT8lkm3NPG8eSAKVMEE5ErkK9HmIXAxn27oczZs=;
        b=e0j7DnEj5/ezkEdWUl3OekP5HmD81oEzLvFLwyKujuMe8PsIcjZrVD6QYxHURp4yQf
         u+672YbY1FA+54yChLT+llj2d/hnj2iWVkfZQIoHlf2cAYeW3egvfbAFPXFxTGtIQ2A3
         x+NLyMjG5j45H1o4ciCac/iEHEsRrIGN298L/Qq0XaJ825dDeGhHBupUFEPSTD9rf6VE
         N0f96hBZkt5yex05I1kawo3107x7N9DQsMChhI+78sdCt7OrhHfp2FsdFAa98YX6jNsN
         IKZK4uhCVbnLoOEc5JMJabj5AEVchTy9GxxMHDNHYy8/dkvUzfxY/moFljYmketHMSDE
         5/Sw==
X-Gm-Message-State: AC+VfDzujRNEnR7yuE050a/2YnuZaCl0kmfVmTD4ZmgVaV7V2KdDhIsj
        XHidwGzC+6HlYxKttSmaRinOYEE3tXHDsgTkQNOORg==
X-Google-Smtp-Source: ACHHUZ7+DsiBLVL+G+PyPSCvDv2Rf18Jgj9RceQGNCWvdyWZ2Go6iibCk0Ty1ltmNZIOPyj9kaUmS6Hr2h/EYJZZLAM=
X-Received: by 2002:ac2:4302:0:b0:4f1:26f5:780c with SMTP id
 l2-20020ac24302000000b004f126f5780cmr2687173lfh.13.1683826222788; Thu, 11 May
 2023 10:30:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 May 2023 10:30:22 -0700
MIME-Version: 1.0
In-Reply-To: <CAEXTbpcWfYV_58pw_VupjhAFZsUU3pkLRN_8JoASyLLBmgTYqQ@mail.gmail.com>
References: <20230331091145.737305-1-treapking@chromium.org>
 <20230331091145.737305-5-treapking@chromium.org> <CAE-0n51E5foFWQAsA73662_5e6XP426wuUCVVmcS5UWwiYpDmw@mail.gmail.com>
 <CAEXTbpdcbB_z4ZGCGzc-cM74ECKyxekbroKCWFnhH8eR=4HmvA@mail.gmail.com>
 <CAE-0n50atfmr-bFh5XtTCm4WpSijJGSe0B5JP8ni7CCYk7Bs5A@mail.gmail.com>
 <CAE-0n51Qy-KDGHOCr4Smpebq1fCURqvJ2RJz6KAtVpv5e+DSGA@mail.gmail.com>
 <CAEXTbpeKe1dVHp9cauMN-9nQb35oJ-ZhdFV-8BiWzjjhWAy0Zg@mail.gmail.com>
 <CAE-0n50bj303jou==v6eMabrZ3EL6Cq7tPJmCj9vM_B7FA8s2g@mail.gmail.com> <CAEXTbpcWfYV_58pw_VupjhAFZsUU3pkLRN_8JoASyLLBmgTYqQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 11 May 2023 10:30:22 -0700
Message-ID: <CAE-0n51i0kzSKYeUtzLV93miq2GcN1APDYh18p4wr9XxWGrfWA@mail.gmail.com>
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
        Chen-Yu Tsai <wenst@chromium.org>, jagan@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pin-yen Lin (2023-05-09 20:41:54)
> On Sat, Apr 29, 2023 at 12:47=E2=80=AFPM Stephen Boyd <swboyd@chromium.or=
g> wrote:
> >
> > Good point. I'm suggesting to make the drm bridge chain into a tree. We
> > need to teach drm_bridge core about a mux, and have some logic to
> > navigate atomically switching from one output to another. I was talking
> > with dianders@ and he was suggesting to use bridge attach/detach for
> > this. I'm not sure that will work though because that hook is only
> > called when the encoder is attached to the bridge.
> >
> > It may also turn out that this helps with DP multi-stream transport
> > (MST). As far as I can recall DP MST doesn't mesh well with drm_bridge
> > designs because it wants to operate on a drm_connector and
> > drm_bridge_connector_init() wants to make only one drm_connector for a
> > chain of bridges. If you squint, the anx7625 could be an MST "branch"
> > that only supports one drm_connector being enabled at a time. Maybe tha=
t
> > is what we should do here, make drm_bridge support creating more than
> > one drm_connector and when there is a mux in the tree it walks both
> > sides and runs a callback similar to struct
> > drm_dp_mst_topology_cbs::add_connector() to tell the encoder that
> > there's another possible drm_connector here.
>
> I have been surveying the approaches to change the bridge chain in
> runtime, and I found this thread[1]. Quoting from Daniel:

I find the lore links easier to read.

> "... exchanging the bridge chain isn't supported, there's no locking
> for that since it's assumed to be invariant over the lifetime of the
> drm_device instance. The simplest way to make that happen right now is to
> have 2 drm_encoder instances, one with the lvds bridge chain, the other
> with the hdmi bridge chain, and select the right encoder/bridge chain
> depending upon which output userspace picks.
> ...
> I wouldn't try to make bridge chains exchangeable instead, that's
> headaches - e.g. with dp mst we've also opted for a bunch of fake
> drm_encoders to model that kind of switching."
>
> I'm not sure how we register two encoders properly, though. Do we make
> the encoder driver check all the downstream bridges and register two
> drm_encoder when a bridge is acting as a mux?

I honestly don't know because I'm not a DRM expert. Maybe Jagan or DRM
bridge maintainers can add to the thread here.

I kept reading the thread[2] and I think they settled on 2 drm_encoders
because they're different display formats (LVDS vs. HDMI) and 2
drm_connector structures. But then I watched the youtube video from this
thread[3] and it seems like 1 drm_encoder is actually what should be
done because there is really only DSI at the root. There's at least
three people working on this topic of muxing displays though. Good news?

The analogy between their gpio controlled mux and this anx part with a
crosspoint switch is that the gpio is like the crosspoint switch, but
the gpio is like a virtual mux? If the gpio is asserted for them, one
display bridge is enabled (HDMI) and the other one is not (LVDS).

In this case, the type-c cables may be connected to both
usb-c-connectors and HPD may be asserted on both, but only one
drm_connector will be able to attach to the 1 drm_encoder at a time. If
we had 2 drm_encoders it would be possible to attach both encoders to
both drm_connectors at the same time, which is impossible because it's a
mux. Indicating that each connector is connected is OK when HPD is high
on both usb-c-connectors. Userspace will have to attach an encoder to
the drm_connector it wants to use, and the drm_connector will indicate
which drm_encoders are possible for it, so all the information will be
provided to userspace in this design.

I think it really comes down to implementing the tree walking logic in
the drm bridge APIs. The problem is things like
drm_bridge_get_next_bridge(), drm_bridge_get_prev_bridge(), and
drm_for_each_bridge_in_chain() which will have to operate on a tree
instead of a list. There's also drm_bridge_chain_get_first_bridge() and
drm_bridge_attach(). The good news is most of these APIs are used
sparingly.

Maybe the simplest way to handle this is to maintain a tree of bridges
and generate bridge chains when an encoder is attached to a connector in
the tree. Presumably there is only one connector possible for a leaf of
the bridge tree, and one encoder at the root of the bridge chain. From
the drm_bridge structure, you'll only be able to iterate over the bridge
chain that is currently configured. Same for the encoder, you'll only be
able to walk the currently configured bridge chain from struct
drm_encoder::bridge_chain.

This hinges on the idea that the bridge_chain is a list, not a tree, and
that it only needs to exist when an encoder is attached to a connector.
When an encoder isn't attached to a connector the bridges will be in the
tree, and probably that tree structure will be maintained in the bridge
driver itself knowing that there is one input side bridge and two output
side bridges. When the input bridge is attached, it should be able to
query the output side bridges for the connector that the encoder is
attaching to and configure the mux and hook the input bridge to the
correct output bridge.

[2] https://lore.kernel.org/all/CAPj87rO7a=3DNbarOyZp1pE=3D19Lf2aGjWu7sru-e=
HwGjX0fpN+-A@mail.gmail.com/
[3] https://lore.kernel.org/all/CAMty3ZAQyADGLVcB13qJdEy_BiZEKpyDfCr9QrM-uc=
FLFPZLcw@mail.gmail.com/
