Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC26C7208
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCWU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjCWU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:59:25 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB21823669
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:58:59 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5456249756bso120987907b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679605138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siTlddsD9BwLsdvAOrWrUYDt/REtWPoX/LdY9MShx4A=;
        b=iHGPN+ikd54NOrXt+zRiYtHPOxzn3WEKtp4WBumXwJ/SJevgu7Ake2/NIqvA9mlTVp
         tMQGPi21Wq7PvzQMlCS3QLdAj53DCez7pZlBTnozDWnhvi0mGxkkh8+d/Paawqjh2V7r
         w4joz/X/Kt7AnRAivbWJu5QIy0wVrPk92jEVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siTlddsD9BwLsdvAOrWrUYDt/REtWPoX/LdY9MShx4A=;
        b=YE5gV99k7YX6DQz9rxuTS23x38fRqr2aFM3VpE/jp3Sbx+ZxPDDbVwLJNTTvOy6FM5
         2c1+mohY5+mtOELFkyA8gV19Y3LeEU3Wg6lEY9PPxeQzAZIDHKCJ2bXSBFWfLygW8uc6
         gTg39kdzPHTXbySOH+HAh9IB4fLsbaTdfa/zfiZ6HhTEdogNUdp/CswmL/CBWIjGAYtn
         NfWo4aPD2BzdCUBOK98AiffiormO10W1XGq3ZqK29dkcxNSsOkvMRe7o6S+UupaBG1Ch
         4e5CHaVxUhAX/nY1vapUPrOmQXZtavSBy5h4z/viFdgdRkoyMQLs6H1oP2lpBUjADYJ8
         QtaQ==
X-Gm-Message-State: AAQBX9cxhZvjLjqc1iGkWc72wHGApUcZlFWe9DmCGDj4Wezj3zXzdAwq
        +eQgw5FFCRnnmbOuLXAqj5Y0bIyDf9kokkbe8zM=
X-Google-Smtp-Source: AKy350bWuLWZxNZUirWCWbdYEhjalyX97gZPM4Rno+X+rSNXMPj8z92QyYb5gdGTlMBGG1PIART3nA==
X-Received: by 2002:a81:8144:0:b0:545:4df7:e6d8 with SMTP id r65-20020a818144000000b005454df7e6d8mr4692389ywf.37.1679605138317;
        Thu, 23 Mar 2023 13:58:58 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id m123-20020a0dca81000000b00545a08184d1sm39539ywd.97.2023.03.23.13.58.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 13:58:57 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id k17so15689483ybm.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:58:57 -0700 (PDT)
X-Received: by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with SMTP id
 k13-20020a056902070d00b00b455cbe48b3mr18602ybt.0.1679605137060; Thu, 23 Mar
 2023 13:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230315035508.2874915-1-treapking@chromium.org> <20230315035508.2874915-2-treapking@chromium.org>
In-Reply-To: <20230315035508.2874915-2-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Mar 2023 13:58:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vqw3x20YH5oBVQuNmNvbApE79kZw8U0J3tJ2cPgha1_Q@mail.gmail.com>
Message-ID: <CAD=FV=Vqw3x20YH5oBVQuNmNvbApE79kZw8U0J3tJ2cPgha1_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: ps8640: Add a cache for EDID
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 14, 2023 at 8:55=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> When there are multiple EDID reads, the bridge will be repeatedly
> enabled and disabled. Add a cache for EDID to speed this up.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Remove the NULL assignment in ps8640_remove
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 60 +++++++++++++++-----------
>  1 file changed, 36 insertions(+), 24 deletions(-)

Landed in drm-misc-next:

6a17b4d1b52f drm/bridge: ps8640: Add a cache for EDID
