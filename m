Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7977675F84
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjATVPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:15:44 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A108A4C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:15:42 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4ff07dae50dso44926407b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NcIIC1O7Zs3rEuEM0nyGO+WgzZl8Vikm1z2RFIGcKb0=;
        b=fhs5Iuj4i9tYiLtWZSoxdZ7lQeEEve400Bj1Vri0BU6rTFbqMbm9zOTpruHHGJiSv+
         45iwza4m7m6J/UZxVCr4lOZWhgR3egS25OP/hJ5DF5TxBJPR6a3YEs64lCSotn3bkRIl
         EpmHRQpEh50uuJCoQCzB/3vOLGZVErgkFlHxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcIIC1O7Zs3rEuEM0nyGO+WgzZl8Vikm1z2RFIGcKb0=;
        b=3OSd2YmrLvvT+0J5wLNlhkS+28UgHrLTViRQYIRCO9jGMGntylgyVAuXYvTrGog9n2
         Jq9IVjfJ4JJ6B9uuznqakwX0MxBTxOlZdEY9UfPn6ExnHOU4hKJNn3QiirtKSK4kTVIJ
         5cDXE6XElQ0U7Bua8iV9g9WlNKIZVBVNp4kmMREgp9eVhV3laJXqKwx4LAgJijKKetDv
         F4ATlBaTy6Mli8/wv1pZoZy/fNHq8KReBPWGLys9inwgiW5bq33lwqM8TPC8LVpaPljS
         fZ+1r1ZG24Sh+++2dWvVOOsJQ13m75ot/J6FXoUTWmffRNd/MoV83ozwPmdV6jr9dpm4
         wa/Q==
X-Gm-Message-State: AFqh2krYUdfKr3EGw/3usovHKWO3DUeMXOmZSp8bweAap6YwOFI7G0CL
        +2U98AGMnsL6oXmMSesKaFBJRKbK9shexSAwydbi4Q==
X-Google-Smtp-Source: AMrXdXuzhv476FXH02ilyJSYLORoSx3+kBVAKevbSIn6Qmw3KTvOzqgdIKhThap2Fmmuhb9Bgf50pSjtYaxEVyXLlAg=
X-Received: by 2002:a0d:e8c9:0:b0:4e0:7220:22fd with SMTP id
 r192-20020a0de8c9000000b004e0722022fdmr2086808ywe.272.1674249341272; Fri, 20
 Jan 2023 13:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-2-treapking@chromium.org> <Y8AL8nTcNcl6zX7H@paasikivi.fi.intel.com>
 <CACeCKaeN7KBi30M1fRWhTPgMbxF6=B+KuAS7Ny7+i9qCx+=49Q@mail.gmail.com> <Y8VL/+My+s/PkG9L@paasikivi.fi.intel.com>
In-Reply-To: <Y8VL/+My+s/PkG9L@paasikivi.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 20 Jan 2023 13:15:30 -0800
Message-ID: <CACeCKaeaQ+LHsnwdqtTA=O3Q=0dWz8_uNjXoNu5J_u4+HQLMsg@mail.gmail.com>
Subject: Re: [PATCH v10 1/9] device property: Add remote endpoint to devcon matcher
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
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

On Mon, Jan 16, 2023 at 5:07 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prashant,
>
> On Thu, Jan 12, 2023 at 02:31:45PM -0800, Prashant Malani wrote:
> > HI Sakari,
> >
> > On Thu, Jan 12, 2023 at 5:32 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Pin-yen,
> > >
> > > On Thu, Jan 12, 2023 at 12:20:56PM +0800, Pin-yen Lin wrote:
> > > > From: Prashant Malani <pmalani@chromium.org>
> > > > +             /*
> > > > +              * Some drivers may register devices for endpoints. Check
> > > > +              * the remote-endpoints for matches in addition to the remote
> > > > +              * port parent.
> > > > +              */
> > > > +             node = fwnode_graph_get_remote_endpoint(ep);
> > > > +             if (fwnode_device_is_available(node)) {
> > > > +                     ret = match(node, con_id, data);
> > > > +                     if (ret) {
> > > > +                             if (matches)
> > > > +                                     matches[count] = ret;
> > > > +                             count++;
> > > > +                     }
> > > > +             }
> > >
> > > Aren't you missing fwnode_handle-put(node) here??
> >
> > It shouldn't be necessary. We aren't break-ing/continue-ing here,
> > and fwnode_handle_put(node) is called latter in the loop [1][2]
>
> It is, but node is overwritten just below this chunk --- before
> fwnode_handle_put() is called on it.

Ack. Thanks for pointing that out. My bad!

Pin-yen, please make this update when you send out a v11.

BR,

-Prashant
