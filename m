Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B56B917A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCNLUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjCNLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB1984DE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48F7B6171F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA1EC43322
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678792759;
        bh=L+ObPflwCpsjIlYvEFNRmXrxfJVM8OShBibqT6iMuMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ai2IZNgTd2odBKUo/ClyuF8lE6C+shMaZqx5sj9pKsBMjvHZNTqyq6kGnyZ19sPuC
         BEmh7PQrbZfn4gra1LVnVISlrg59MZ11s+vFCjaGwXIYcQQV0exQpwq6mLtDikzKPq
         ru2OvYWrrim1zu3fqc27wvhRGpmIWq5LwO9n5a5ZI+51R275MjFvEbVjWVXUyvgxti
         LaU+IR52e1T64u3KmtIttOOvw6IjkP2+tEP1rLewJMX2pEpROQlbFAg+4tCtRziGEH
         dnIEiXZV65hgyrW3vzhMqseEe8yvRejpQ/4XIfChbSfxAU8qxjhMTX5INk5/2dYNLf
         yPeYCttQoxtDQ==
Received: by mail-pj1-f54.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so5678046pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:19:19 -0700 (PDT)
X-Gm-Message-State: AO0yUKVTPWrhE5WbMe/V1xHijJg3LwckwAB/CKlcBSnsBo+ru1VxSgln
        5hYti9RehDodFvWJ6KCUHbTidt85mM0S6eRgt0xSoA==
X-Google-Smtp-Source: AK7set/H2AVJzooGw8hvHI3ZJk6UV/BOEaxFeZT4EnrNm3JVY67/vn/oQV+poWINfaKjkwWVNk1UoXGb2RJ/jetFBdk=
X-Received: by 2002:a17:90a:6804:b0:237:9cbe:22ad with SMTP id
 p4-20020a17090a680400b002379cbe22admr13500631pjj.5.1678792759012; Tue, 14 Mar
 2023 04:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230314110043.2139111-1-treapking@chromium.org>
In-Reply-To: <20230314110043.2139111-1-treapking@chromium.org>
From:   Robert Foss <rfoss@kernel.org>
Date:   Tue, 14 Mar 2023 12:19:08 +0100
X-Gmail-Original-Message-ID: <CAN6tsi7d9XPfQmp+uSjbsgS3YeLJF_Ozp4ZjoaVOF2oWJQgLtw@mail.gmail.com>
Message-ID: <CAN6tsi7d9XPfQmp+uSjbsgS3YeLJF_Ozp4ZjoaVOF2oWJQgLtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: ps8640: Skip redundant bridge enable
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:01=E2=80=AFPM Pin-yen Lin <treapking@chromium.or=
g> wrote:
>
> Skip the drm_bridge_chain_pre_enable call when the bridge is already
> pre_enabled. This make pre_enable and post_disable (thus
> pm_runtime_get/put) symmetric.
>
> Fixes: 46f206304db0 ("drm/bridge: ps8640: Rework power state handling")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 4b361d7d5e44..08de501c436e 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -557,7 +557,8 @@ static struct edid *ps8640_bridge_get_edid(struct drm=
_bridge *bridge,
>          * EDID, for this chip, we need to do a full poweron, otherwise i=
t will
>          * fail.
>          */
> -       drm_atomic_bridge_chain_pre_enable(bridge, connector->state->stat=
e);
> +       if (poweroff)
> +               drm_atomic_bridge_chain_pre_enable(bridge, connector->sta=
te->state);
>
>         edid =3D drm_get_edid(connector,
>                             ps_bridge->page[PAGE0_DP_CNTL]->adapter);
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
