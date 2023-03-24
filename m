Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46156C7F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjCXOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjCXOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B8E1735
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCDF362B05
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492E0C433A4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679666734;
        bh=y4Farhu4V41tPk7JQCGgZn32PPH4qculJxU45vIj0EA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oXYPBUg1nrZIdTIcXAT6GL490fkUmTs72+6cEq3KJMtP+pppE2G7XwO1hIJTwRRwF
         1V3zAWBFdXCM8WXwu3wGGcOlUckEV+a43aIHc846S9tqo2szGwPpcNzel2NE+qZ70k
         xTRXNSjNQYu4S9P+VQGcPF+42ZC94Bc/IJbz2zh+/Ih9lUqM4D+QYS4kgT3QCy4g54
         OmdeVJQUEGopghqcqlzxN0tC9U0D/zSCRUx+mS5rJLG3rGd0cDTefE9T/iufnWzKhP
         V1ka4oBgW4Tu4zT1jyrYO+VFck+ez/ncN5wBiSdwPqpB7FCDrmXU6pZdOr7ZHorMk6
         fOZUc8f/MspNg==
Received: by mail-pj1-f44.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso5129790pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:05:34 -0700 (PDT)
X-Gm-Message-State: AAQBX9edozrXOkV1ba+Urpjk8MgOzA/LZJMSsKs59mN2PB9cl2M2Apwy
        5vHjfF/oT/CN5q/hWC31Ak8dd/bd/yXuiHMFjzH+Ug==
X-Google-Smtp-Source: AKy350Zt1S+2egsukDJYhSyZ+wRndmhs9uQGH1FbNc61cHTfeNcEamJuN1YaNwXiYwlu+nqVPKNVWcDWZPbCjzsWbBM=
X-Received: by 2002:a17:903:7c8:b0:19f:39f8:88c4 with SMTP id
 ko8-20020a17090307c800b0019f39f888c4mr3613623plb.2.1679666733789; Fri, 24 Mar
 2023 07:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230324035909.1727356-1-treapking@chromium.org>
In-Reply-To: <20230324035909.1727356-1-treapking@chromium.org>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 24 Mar 2023 15:05:22 +0100
X-Gmail-Original-Message-ID: <CAN6tsi7M26ijWT0hVOAoSFE6fhy-0TS-c7+5LUJpo-NJAG21Mw@mail.gmail.com>
Message-ID: <CAN6tsi7M26ijWT0hVOAoSFE6fhy-0TS-c7+5LUJpo-NJAG21Mw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Return NULL immediately when EDID
 read fail
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 4:59=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> drm_edid_read returns NULL on error, so feeding it directly into
> drm_edid_duplicate may lead to NULL pointer dereference. Add a check to
> guard this.
>
> Fixes: 6a17b4d1b52f ("drm/bridge: ps8640: Add a cache for EDID")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index cddbfe91f75e..b823e55650b1 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -543,6 +543,7 @@ static struct edid *ps8640_bridge_get_edid(struct drm=
_bridge *bridge,
>                                            struct drm_connector *connecto=
r)
>  {
>         struct ps8640 *ps_bridge =3D bridge_to_ps8640(bridge);
> +       struct device *dev =3D &ps_bridge->page[PAGE0_DP_CNTL]->dev;
>         bool poweroff =3D !ps_bridge->pre_enabled;
>
>         if (!ps_bridge->edid) {
> @@ -574,6 +575,11 @@ static struct edid *ps8640_bridge_get_edid(struct dr=
m_bridge *bridge,
>                                                              connector->s=
tate->state);
>         }
>
> +       if (!ps_bridge->edid) {
> +               dev_err(dev, "Failed to get EDID\n");
> +               return NULL;
> +       }
> +
>         return drm_edid_duplicate(ps_bridge->edid);
>  }
>
> --
> 2.40.0.348.gf938b09366-goog
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
