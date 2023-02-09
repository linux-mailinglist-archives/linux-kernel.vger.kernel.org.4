Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA60B68FEC1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjBIEaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBIE3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:29:53 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934283E081
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 20:29:25 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id v15so390990ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 20:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bescMjn7FtyPXif9z42K5Kti4WQibJgEOUCofteOlbU=;
        b=efbpqpZ8ruVdXCPyxPr8jDefM3U8oaOj3EXWBJQevNTETQvcO2dE/qtmWax943hsRR
         hXvF9OSBw1p+PC27CXPrMC2rOofIy441d7jZSKzpR3sOkGqwzMVORaVIxNJkydQm7TzH
         8ViDfzFimT4EAz6hz5X1Yn6/9z/6vbonm+MDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bescMjn7FtyPXif9z42K5Kti4WQibJgEOUCofteOlbU=;
        b=uwn4asUN0Smvv8GIbBigYCfiO1rzqX6Yet6YeAG2fO7h6S622MOC3CCUKKH38/lkEI
         QYcAbviEGIQnhjgVS7tgud0G6GOR9HGUQBeSkDvjSJ1Qjqdy43faZ/JpZ+pic/Tz9+8t
         beKKmkCXpv7V1Fok3EvniXf4XUZ7yNblmgo01Xwfm6JoLI8X3DG0Vc1No/lRYgpmvGvD
         QnebhwJ4ZH5i2T6eBIGVSjm91xz4ZKeunzovNbub10RPpAKnlGdOBckigK5MO57A5E1+
         Os9M3+csAnnrDN5vCQQoeNeX9PhzjS5DLAbbDIDtQ0SNr6lPMM3JarnqczOhfz1Np3ye
         /1cQ==
X-Gm-Message-State: AO0yUKVu5i8JF8BAl6Hnqo04OSfJTh3yGFoJUA9lEK1jXka8NfWMqRCk
        1E9CSgBVsMXoGpGtByVr0hNDQWLY4if6OdjSApzVfA==
X-Google-Smtp-Source: AK7set+YCKJbelSZgHy/neopyqons0VAhG7SjB9chuOXUmdoUIbOQBP9AdNx/HVfzI+OikZm7IrbjJahfEHqdtFqiQw=
X-Received: by 2002:a92:4412:0:b0:310:fd95:6d81 with SMTP id
 r18-20020a924412000000b00310fd956d81mr5201921ila.42.1675916924769; Wed, 08
 Feb 2023 20:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-2-treapking@chromium.org> <Y+AbhnfJvScvHTGY@kekkonen.localdomain>
In-Reply-To: <Y+AbhnfJvScvHTGY@kekkonen.localdomain>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 9 Feb 2023 12:28:33 +0800
Message-ID: <CAEXTbpf-s8NQKwSxhe=cO-KO=TTSXFznm=1J-ikhc558M6brdQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/9] device property: Add remote endpoint to devcon matcher
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thanks for the review.

On Mon, Feb 6, 2023 at 5:11 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Pin-yen,
>
> On Sat, Feb 04, 2023 at 09:30:32PM +0800, Pin-yen Lin wrote:
> > From: Prashant Malani <pmalani@chromium.org>
> >
> > When searching the device graph for device matches, check the
> > remote-endpoint itself for a match.
> >
> > Some drivers register devices for individual endpoints. This allows
> > the matcher code to evaluate those for a match too, instead
> > of only looking at the remote parent devices. This is required when a
> > device supports two mode switches in its endpoints, so we can't simply
> > register the mode switch with the parent node.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Thanks for the update.
>
> I intended to give my Reviewed-by: but there's something still needs to be
> addressed. See below.
>
> >
> > ---
> >
> > Changes in v11:
> > - Added missing fwnode_handle_put in drivers/base/property.c
> >
> > Changes in v10:
> > - Collected Reviewed-by and Tested-by tags
> >
> > Changes in v6:
> > - New in v6
> >
> >  drivers/base/property.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 2a5a37fcd998..e6f915b72eb7 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -1223,6 +1223,22 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> >                       break;
> >               }
> >
> > +             /*
> > +              * Some drivers may register devices for endpoints. Check
> > +              * the remote-endpoints for matches in addition to the remote
> > +              * port parent.
> > +              */
> > +             node = fwnode_graph_get_remote_endpoint(ep);
>
> Here fwnode_graph_get_remote_endpoint() returns an endpoint...
>
> > +             if (fwnode_device_is_available(node)) {
>
> and you're calling fwnode_device_is_available() on the endpoint node, which
> always returns true.
>
> Shouldn't you call this on the device node instead? What about match()
> below?

Yes we should have checked the availability on the device node itself
instead of the endpoint node. But regarding the match() call, we need
to call it with the endpoint node because that's where we put the
"mode-switch" properties and register the mode switches on. We can't
use the device node because we want to register two mode switches for
the same device node.

Regards,
Pin-yen
>
> > +                     ret = match(node, con_id, data);
> > +                     if (ret) {
> > +                             if (matches)
> > +                                     matches[count] = ret;
> > +                             count++;
> > +                     }
> > +             }
> > +             fwnode_handle_put(node);
> > +
> >               node = fwnode_graph_get_remote_port_parent(ep);
> >               if (!fwnode_device_is_available(node)) {
> >                       fwnode_handle_put(node);
>
> --
> Kind regards,
>
> Sakari Ailus
