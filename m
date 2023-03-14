Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB46BA178
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCNVbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCNVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:31:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76E36466
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:31:11 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o12so1017840iow.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678829471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uY427W2KMisQvhtrsSNS8I4WCl3EbKmvvrlqEop4WI=;
        b=izMEd+OsxY4xxrDkxGN6U5fGkGDMOsNlJxa5OFwdjJTPS1dP4Atfw4uwvVdaA9RHm5
         ATVnZrjMSwMgzwUKBhZ9kRSDQ9IAnl+6ezxPK/+ie5xa7MlhcS+9Xl42SE5BSF5+ekab
         UY9CB/5orGFBubZbAmudNlLi3ntxXr6+h/Wy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678829471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uY427W2KMisQvhtrsSNS8I4WCl3EbKmvvrlqEop4WI=;
        b=aogenAAH9Tyl7No5nvbrKu6Kh869+syjOVr3Qx7RyBXk7DS4rfp8bA0zCe3pKalZXj
         NNSnz+nhIJ2roJDPspp4GA4kTpct6xL3o+Rar0cNXe6uznRsa0+W7BPlzwktzUXkZOe4
         sg2Qfzx6khFtl4IWuHbRmYJ3uZThtibYkOi/qEpgQuWck61LIoyBSmJlJzZNq+obHuC8
         pRHs99jU3qxl9S53zwgZ8C1k/wwKrgpxc/yr5YmPZAPxfSEt4x8+9r8KSP6wyYHjMQy+
         FmDCXwsGEiJWZQ/bZnvQeevzkQwoEylg5SZdTzPjTLYh+jXyK6AurlVZBZPlnXk3UlVz
         Q9VA==
X-Gm-Message-State: AO0yUKU8dF6mdtnPtB+f8hv1eqePYNz/n21gx6YNtHVUCgjKppSWX+xC
        zogAYjLIr5wxEl39pZWqfd4YmDLLPonWmG8Huos=
X-Google-Smtp-Source: AK7set9+MFFGdx1q7VF/NyWu1szDglX8YaWCTErT0+qoaARAmkexPOOLj0vuQKzckapKB645rSMqRQ==
X-Received: by 2002:a6b:5b08:0:b0:74c:822c:a6ac with SMTP id v8-20020a6b5b08000000b0074c822ca6acmr14920705ioh.15.1678829470790;
        Tue, 14 Mar 2023 14:31:10 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id y1-20020a5ec801000000b0074e6f2c584dsm1107152iol.12.2023.03.14.14.31.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 14:31:10 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id bf15so6997410iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:31:09 -0700 (PDT)
X-Received: by 2002:a02:a106:0:b0:406:122f:76ad with SMTP id
 f6-20020a02a106000000b00406122f76admr756559jag.1.1678829469489; Tue, 14 Mar
 2023 14:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230314110043.2139111-1-treapking@chromium.org>
In-Reply-To: <20230314110043.2139111-1-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Mar 2023 14:30:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=jVsvD620wWKfniRYQNJnb7goDUKb_HhL_qVxLYGZOA@mail.gmail.com>
Message-ID: <CAD=FV=W=jVsvD620wWKfniRYQNJnb7goDUKb_HhL_qVxLYGZOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: ps8640: Skip redundant bridge enable
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

Hi,

On Tue, Mar 14, 2023 at 4:00=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
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

It always seemed weird to me that this function was asymmetric, so I
like this change, thanks!

I also remember wondering before how this function was safe, though.
The callpath for getting here from the ioctl is documented in the
function and when I look at it I wonder if anything is preventing the
bridge from being enabled / disabled through normal means at the same
time your function is running. That could cause all sorts of badness
if it is indeed possible. Does anyone reading this know if that's
indeed a problem?

I suppose that, if this is unsafe, it's no more unsafe now than it was
before your patch, so I guess:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If there are no issues, I'll plan to land this patch and the next one
to drm-misc-next sometime late-ish next week.
