Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA56B041C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCHKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCHKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:25:18 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEEEB4829
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:25:12 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f14so6589735iow.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678271111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk4eRG0LrzbHDKK00dsD4iBuyY/4ZAQyp3TpAqYJX3Q=;
        b=EftcY01/oCV/raNvODG0Gy7CAtfgmEemBydzNyAQ/5Z8JDAjqoXLq8pFoIQpGEcWYn
         nu75sxupN/sQVT1eTmTNkYDC4NGXFqPitKQCL4odiDhzr0iZEhGrzCytxWkP57LBugz1
         ovgS6RvevaA0mF6dPaeC7GeF5zW7+oi9/DjqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk4eRG0LrzbHDKK00dsD4iBuyY/4ZAQyp3TpAqYJX3Q=;
        b=1kfWmxUbiVejgVh7DQTsPFPy3ZmR5/S5ETJGlgOEwT9T7ofJFWpx3ZchpSbJrvAFEr
         yDlX86HW8vjuvDDChqgYt0yvAI53uzG9PPxoBAR6z+4bK7PZLyAG4hQcnAyb9eyHlMM3
         0gySZ+A9uDG9Md9v4Ae56SxJfSBH90dhG9gCh0PVsXICmC75uN5BdeyzT3eS/Xtas0HS
         3MNeNPb0J4JSye+0xVrr0P5lrplbTT0IztM8vgQeqU4eaBS3a/CrpdGDdE/tY9187IZQ
         NhieMCgNvoyp7Vb+tmXyawotEKnNypn1DnnsLPRvpLBjsTOwOpZ4+mLM31sosvjwJigJ
         rh4g==
X-Gm-Message-State: AO0yUKWq74Qh+SrPbaTjEiuXvgUL2UgCuX2/ihJSyjNRA0QsXXmV4TgQ
        fFZm00yzs+WP6ry8dmzZT1ed+KFIQMkOHVLs+v8l2A==
X-Google-Smtp-Source: AK7set+QhdrKShMQqdGse4Hq6359ifcnSCbtiqiWfe6LuBFF3HsmSOEUtWdcF89t709UweFPbwi9ZG1akiBqjkVk2co=
X-Received: by 2002:a05:6602:154:b0:74c:8243:9290 with SMTP id
 v20-20020a056602015400b0074c82439290mr8204213iot.4.1678271111488; Wed, 08 Mar
 2023 02:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-6-treapking@chromium.org> <ZAXT0JFjERb8Q36f@smile.fi.intel.com>
In-Reply-To: <ZAXT0JFjERb8Q36f@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 8 Mar 2023 18:25:00 +0800
Message-ID: <CAEXTbpecGhEDrffDobb4NgLw8+vMK2_yVmJw8JGUDruTALm4-w@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] drm/bridge: anx7625: Check for Type-C during
 panel registration
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
        Xin Ji <xji@analogixsemi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-acpi@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Andy,

On Mon, Mar 6, 2023 at 7:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 03, 2023 at 10:33:45PM +0800, Pin-yen Lin wrote:
> > The output port endpoints can be connected to USB-C connectors.
> > Running drm_of_find_panel_or_bridge() with such endpoints leads to
> > a continuous return value of -EPROBE_DEFER, even though there is
> > no panel present.
> >
> > To avoid this, check for the existence of a "mode-switch" property in
> > the port endpoint, and skip panel registration completely if so.
>
> ...
>
> > +     port_node =3D of_graph_get_port_by_id(np, 1);
> > +     count =3D typec_mode_switch_node_count(&port_node->fwnode);
>
> Do you need to drop reference count here?
> (I don't know myself, so, please check this)
>
> If no, patch LGTM.

The helper completes the for-loop of fwnode_for_each_child_node, which
drops the reference count whenever the next node is get. So we don't
need drop the reference count here.
>
> > +     if (count)
> > +             return 0;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Best regards,
Pin-yen
