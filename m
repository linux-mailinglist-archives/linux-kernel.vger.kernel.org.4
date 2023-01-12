Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCEB668702
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjALWc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjALWcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:32:03 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FCB3B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:31:58 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 203so20412969yby.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/C/ZRKjPzNTEZUCk+rnSkeE6htJTMyaRVi+BQ5BKJ+U=;
        b=JUPY63vtT6QcwqD9Ws2QE/pf7jC1/0su4w2j3d9Xn0NTdACzrFBjxjuFHWgpThUZws
         imdknTpaWEjV9uHtradW98A1u35lfMGg1dddhCwsBClQF94e0939KX7UTkXNgez4GIry
         JxaKGHbkQ7QWJVTYQ0VQgYI43iHND9qXIlcZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/C/ZRKjPzNTEZUCk+rnSkeE6htJTMyaRVi+BQ5BKJ+U=;
        b=AZ9V+4kW3UhXaFCecT+MTm35SeXySaRXP4feO98o87vwpuo3TsShFDRiDKFYOG5Dro
         WBYAY0zzocJcLmneMm9BHChXRc578cFc+VUZOi8CBbqNh1zztulmFhf1OY+Ig6UzdKwB
         qx0Pkr1HZHKRzUfVXOOsJO5jgk13yseDu0HbX8GMZxK1hCJzu6QPgJIMoyUowxty4+wc
         IDrpypqjtLNdpdDZwfl+gpc0GK0k5wqMAKFoG3woHxDLvF9vCjU83Sk5daHyuy8eA+YH
         aF6PhrctQ5fbEIFWY1tFsvnlaBQmr7RQaYJHUZJKOAwDWBfBgkCA53UsJgnxvuGeOpAY
         2T+Q==
X-Gm-Message-State: AFqh2kq0PK3OX7iz4RyThZ4Ym/W78Dy58BTfsakydHBHJjwoaKGVUj4V
        /oNu6+hGwwHOL0vnYvML8FRrzFxvSvm02RDvaccA5A==
X-Google-Smtp-Source: AMrXdXuznEwChU9VQQ72rYVGqmbsFrMqOVBPMbeBVwgDM2AWPc/3hytO7eUeE33HPvr9ax9Vk/LALEeTjlK/OvpNWf8=
X-Received: by 2002:a25:1083:0:b0:7ae:5e48:383b with SMTP id
 125-20020a251083000000b007ae5e48383bmr2843942ybq.223.1673562717561; Thu, 12
 Jan 2023 14:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-2-treapking@chromium.org> <Y8AL8nTcNcl6zX7H@paasikivi.fi.intel.com>
In-Reply-To: <Y8AL8nTcNcl6zX7H@paasikivi.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 12 Jan 2023 14:31:45 -0800
Message-ID: <CACeCKaeN7KBi30M1fRWhTPgMbxF6=B+KuAS7Ny7+i9qCx+=49Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Sakari,

On Thu, Jan 12, 2023 at 5:32 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Pin-yen,
>
> On Thu, Jan 12, 2023 at 12:20:56PM +0800, Pin-yen Lin wrote:
> > From: Prashant Malani <pmalani@chromium.org>
> > +             /*
> > +              * Some drivers may register devices for endpoints. Check
> > +              * the remote-endpoints for matches in addition to the remote
> > +              * port parent.
> > +              */
> > +             node = fwnode_graph_get_remote_endpoint(ep);
> > +             if (fwnode_device_is_available(node)) {
> > +                     ret = match(node, con_id, data);
> > +                     if (ret) {
> > +                             if (matches)
> > +                                     matches[count] = ret;
> > +                             count++;
> > +                     }
> > +             }
>
> Aren't you missing fwnode_handle-put(node) here??

It shouldn't be necessary. We aren't break-ing/continue-ing here,
and fwnode_handle_put(node) is called latter in the loop [1][2]

BR,

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/property.c#n1256
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/property.c#n1261
