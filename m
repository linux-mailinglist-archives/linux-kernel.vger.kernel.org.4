Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE1681F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjA3XLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjA3XL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E04EE5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675120237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+K8e/zfLN4jZoxJoefnBbSYk/h9sMX4+P4UDlH6in4=;
        b=DQ2LJ2MiLsMltMQSt40LtFtsF5p5stsa8K9exOpXdmIq4rXSzeqrwF6acP+0Re1AjEycRT
        teQne9BNOILQygs1K16Ygw7TNEcxsce2iNksa/3OvXPKrZ0JK9q+mXQLpJOaSjozZ6VSiL
        aUCIxv3OhkHrHp7/huI2+4JNVy19xnc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359-sNuVavMqO1iiSJuUxQnCkw-1; Mon, 30 Jan 2023 18:10:36 -0500
X-MC-Unique: sNuVavMqO1iiSJuUxQnCkw-1
Received: by mail-qt1-f199.google.com with SMTP id c16-20020ac85190000000b003b841d1118aso2805873qtn.17
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+K8e/zfLN4jZoxJoefnBbSYk/h9sMX4+P4UDlH6in4=;
        b=W3L4oMsUris/PIZrTq2FeUhE2HaKLJZ8frgz1lFOzG3wQH81rakuDWofE1TgAEMTqk
         odkC1Ylc8tYIRfvqICJ8k9YrKqxs/ks4pBCgo61vCp48UuXs0alXOh0HrAdv7XxgDHPw
         P+tuENYEO8M4Zg6UWmNLV/nhWifX7UcxlxR70F3M+LVF5becIhRhGCNBLhfCSNZFZjPa
         Ba/XiW1J+eJSXoUiUKfHjM9/t/z0mghWWW6kgGAX1UnLyVjNY+ClMgA+2pNEPjTCTWQI
         OlA2rTwcr1vi7mkXxI1GtllU492VTNm/NJ9oMVdZXxJtidtxJdjcmAYI/r+H/q7CQf4E
         rWgA==
X-Gm-Message-State: AO0yUKX4xY7S+J5UiiTjdMORMLjECob8ZEjiNN+LK5f3sB5tJYLjOxXL
        iGrJwD0pxauCOAFjx4lvwXQLbSzGxC7ALuxnLn+qHDCO6/2654qlbRZmaf8HdZ47wVu5r392RqA
        8cYDzd7mHm977D2kIy+K2P9PC
X-Received: by 2002:a05:622a:180e:b0:3b4:2b61:da32 with SMTP id t14-20020a05622a180e00b003b42b61da32mr15365898qtc.59.1675120235945;
        Mon, 30 Jan 2023 15:10:35 -0800 (PST)
X-Google-Smtp-Source: AK7set89917aaMWXfx8H2M6z2jsMBTb17FVp8nR3WX9yHmkqkhPUzBHVr8SFkLh0Wpt7DzxdggBhnA==
X-Received: by 2002:a05:622a:180e:b0:3b4:2b61:da32 with SMTP id t14-20020a05622a180e00b003b42b61da32mr15365872qtc.59.1675120235657;
        Mon, 30 Jan 2023 15:10:35 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id k22-20020a05620a139600b0071f17af8733sm2954494qki.64.2023.01.30.15.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:10:35 -0800 (PST)
Message-ID: <e620862840bcac9dcd46dd63e247966424af060f.camel@redhat.com>
Subject: Re: [PATCH v9 0/9] Register Type-C mode-switch in DP bridge
 endpoints
From:   Lyude Paul <lyude@redhat.com>
To:     Pin-yen Lin <treapking@chromium.org>,
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
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xin Ji <xji@analogixsemi.com>, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Chen <allen.chen@ite.com.tw>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Date:   Mon, 30 Jan 2023 18:10:33 -0500
In-Reply-To: <20230109084101.265664-1-treapking@chromium.org>
References: <20230109084101.265664-1-treapking@chromium.org>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know if this still needs reviews from me (feel free to respond if it
does!), but I wanted to say nice work! This is something I've wanted to see
added to DRM for a while =E2=99=A5


On Mon, 2023-01-09 at 16:40 +0800, Pin-yen Lin wrote:
> This series introduces bindings for anx7625/it6505 to register Type-C
> mode-switch in their output endpoints, and use data-lanes property to
> describe the pin connections.
>=20
> The first two patch modifies fwnode_graph_devcon_matches and
> cros_typec_init_ports to enable the registration of the switches.
>=20
> Patch 4~6 introduce the bindings for anx7625 and the corresponding driver
> modifications.
>=20
> Patch 7~9 add similar bindings and driver changes for it6505.
>=20
> v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromi=
um.org/
> v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromiu=
m.org/
> v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@ch=
romium.org/
>=20
> Changes in v9:
> - Collected Reviewed-by tag
> - Fixed subject prefix again
> - Changed the naming of the example node for it6505
>=20
> Changes in v8:
> - Fixed the build issue when CONFIG_TYPEC=3Dm
> - Fixed some style issues
> - Fixed the subject prefixes for the bindings patch
> - Fixed the bindings for data-lanes properties
>=20
> Changes in v7:
> - Fix the long comment lines
> - Extracted the common codes to a helper function
> - Fixed style issues in anx7625 driver
> - Removed DT property validation in anx7625 driver.
> - Fixed style issues in it6505 driver
> - Removed the redundant sleep in it6505 driver
> - Removed DT property validation in it6505 driver
> - Rebased to drm-misc-next
> - Fixed indentations in bindings patches
> - Added a new patch to fix indentations in Kconfig
>=20
> Changes in v6:
> - Changed it6505_typec_mux_set callback function to accommodate with
>   the latest drm-misc patches
> - Changed the driver implementation to accommodate with the new binding
> - Dropped typec-switch binding and use endpoints and data-lanes propertie=
s
>   to describe the pin connections
> - Added new patches (patch 1,2,4) to fix probing issues
> - Changed the bindings of it6505/anx7625 and modified the drivers
>   accordingly
> - Merged it6505/anx7625 driver changes into a single patch
>=20
> Pin-yen Lin (7):
>   drm/display: Add Type-C switch helpers
>   dt-bindings: display: bridge: anx7625: Add mode-switch support
>   drm/bridge: anx7625: Check for Type-C during panel registration
>   drm/bridge: anx7625: Register Type C mode switches
>   dt-bindings: display: bridge: it6505: Add mode-switch support
>   drm/bridge: it6505: Fix Kconfig indentation
>   drm/bridge: it6505: Register Type C mode switches
>=20
> Prashant Malani (2):
>   device property: Add remote endpoint to devcon matcher
>   platform/chrome: cros_ec_typec: Purge blocking switch devlinks
>=20
>  .../display/bridge/analogix,anx7625.yaml      |  99 ++++++++++++-
>  .../bindings/display/bridge/ite,it6505.yaml   |  93 ++++++++++--
>  drivers/base/property.c                       |  15 ++
>  drivers/gpu/drm/bridge/Kconfig                |  21 +--
>  drivers/gpu/drm/bridge/analogix/Kconfig       |   1 +
>  drivers/gpu/drm/bridge/analogix/anx7625.c     | 101 +++++++++++++-
>  drivers/gpu/drm/bridge/analogix/anx7625.h     |  13 ++
>  drivers/gpu/drm/bridge/ite-it6505.c           | 119 +++++++++++++++-
>  drivers/gpu/drm/display/drm_dp_helper.c       | 132 ++++++++++++++++++
>  drivers/platform/chrome/cros_ec_typec.c       |  10 ++
>  include/drm/display/drm_dp_helper.h           |  16 +++
>  11 files changed, 591 insertions(+), 29 deletions(-)
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

