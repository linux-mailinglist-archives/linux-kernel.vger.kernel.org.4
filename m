Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB13660D1C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 09:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjAGI5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 03:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGI5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:57:49 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3B16EC87
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:57:48 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p66so1935876iof.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 00:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UaNgvexmJZouLumz2Hx1He28hMYgrYY+xTAVH7s69FM=;
        b=USC/6TTWY3c9bq0vKbvX+VWUwpXRkXdBVEauttbI7B/ZQ1oIkIZNu1Yo09lwc7bODo
         QCeJkFoz0u3wjOvokRLMOJCuh0pQLovmrLZaJqZUkoGcDAXJjZuRBlsC/ypwOPYM3Np1
         JVnfVqUGM7cQv7XazXT4n7qSdn+bJ6ijtwrAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaNgvexmJZouLumz2Hx1He28hMYgrYY+xTAVH7s69FM=;
        b=RAcWM79ErHwTA4k7fu4nntG9/f01oUPnxVO6Gb3mVTr/S7AzPS7ZT4nSLLdSunEG55
         14IcX9OjOQO25TF+NrgLKkfLJOsEXqpRLWRyNTxNVFRDOF900htw4pxGEOYm2889ZU+Q
         c1pBsAAJ8PvR3KGh53T6ODvUPBnntbgFYeNTyLNcaHLSHw3sTn+jDdZqAgSaEQYnz8AS
         NrIDYZuLECRcgn1vHyehRuTvS0YxSHQABluV0OkiMGGsV2zGJ61QmijAFkaaXeDEzLja
         1EmZxDfdYBuQwvDrpM7quOI3jBNCILHmwIix1Za/RoaMb/A4tboUGor/I/5UVLZ8BDM0
         N7Vg==
X-Gm-Message-State: AFqh2ko0EOFUBwvSojj0MPLaYK+tV2RokIE078LutLNhV1ck/R4A++kl
        LNPGdzn0uCDKFxf0QguL7lW6XZAGRbGImEfSUIpMzQ==
X-Google-Smtp-Source: AMrXdXvTC4JQ09AhshynrLdlXh3M+Z6nMNmW5qrLRJOovdkW8noIBriyLLrx6Nomzovk/IWfzQDu/aOoojNHuYEKlrY=
X-Received: by 2002:a05:6638:58:b0:38a:9192:2ba6 with SMTP id
 a24-20020a056638005800b0038a91922ba6mr5151511jap.76.1673081867592; Sat, 07
 Jan 2023 00:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20230105132457.4125372-1-treapking@chromium.org>
 <20230105132457.4125372-3-treapking@chromium.org> <Y7btq4kLxrE4v3TL@smile.fi.intel.com>
In-Reply-To: <Y7btq4kLxrE4v3TL@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Sat, 7 Jan 2023 16:57:36 +0800
Message-ID: <CAEXTbpcwKnMQ1=D940bf2GUNdK3K+-bhnOs2r5fwuTW+ozQajA@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] platform/chrome: cros_ec_typec: Purge blocking
 switch devlinks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the review.

On Thu, Jan 5, 2023 at 11:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 05, 2023 at 09:24:50PM +0800, Pin-yen Lin wrote:
> > From: Prashant Malani <pmalani@chromium.org>
> >
> > When using OF graph, the fw_devlink code will create links between the
> > individual port driver (cros-ec-typec here) and the parent device for
> > a Type-C switch (like mode-switch). Since the mode-switch will in turn
> > have the usb-c-connector (i.e the child of the port driver) as a
> > supplier, fw_devlink will not be able to resolve the cyclic dependency
> > correctly.
> >
> > As a result, the mode-switch driver probe() never runs, so mode-switches
> > are never registered. Because of that, the port driver probe constantly
> > fails with -EPROBE_DEFER, because the Type-C connector class requires all
> > switch devices to be registered prior to port registration.
> >
> > To break this deadlock and allow the mode-switch registration to occur,
> > purge all the usb-c-connector nodes' absent suppliers. This eliminates
> > the connector as a supplier for a switch and allows it to be probed.
>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> Tag block mustn't have the blank line(s).
>
> ...
>
> > +     /*
> > +      * OF graph may have set up some device links with switches, since
> > +      * connectors have their own compatible. Purge these to avoid a deadlock
> > +      * in switch probe (the switch mistakenly assumes the connector is a
> > +      * supplier).
> > +      */
>
> Perhaps even
>
>         /*
>          * OF graph may have set up some device links with switches,
>          * since connectors have their own compatible. Purge these
>          * to avoid a deadlock in switch probe (the switch mistakenly
>          * assumes the connector is a supplier).
>          */
>
> ?
I can update this in v8, though I wonder why shorter comments are
preferred as they haven't exceeded the 80-character length
requirement.
>
> > +     if (dev->of_node)
>
> I would use if (dev_of_node(dev)), but it's up to you and maintainers.

dev_of_node looks a bit better as it checks the enabled config for us.
I'll update this in v8.

>
> > +             device_for_each_child_node(dev, fwnode)
> > +                     fw_devlink_purge_absent_suppliers(fwnode);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Best regards,
Pin-yen
