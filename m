Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52156C7206
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCWU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjCWU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:58:46 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9532E53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:58:31 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-53d277c1834so416526557b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679605109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXG2m3AhU8tFazET94PFq/bMhgtfxarcttWvDXsnJsI=;
        b=NpUUIM1JGopohZ2thu3r504DXU6g6dF0rDoiLjw1E/OsjkZBca2tfGJnJoZz9RjnTF
         AFg2eAYkqmAXQm5QsdBPniI1HaomOESb5Sau8496tnOHthVbUngL+g10l7IPesfHwHe5
         Im/eofIkFz1HbzpvmbPWzq1LznRxw4R5NouCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXG2m3AhU8tFazET94PFq/bMhgtfxarcttWvDXsnJsI=;
        b=A33bsrfCn29OTJbi+H15dh4NcN+opqTYTgHM642SAB26tzvZSl/bwibA94LarGV3RU
         YAvOO4iMjY5lvhO2zH+Dpx3Np69D/JllJciQLfmn+wQXupUXWRWG1jU8bo+l6YA/3ce/
         zpbEJu/Oa9vHJ0Q3QUFBSswia2BlwDUAWWweMNFE2qKBjrDRSUfgI5UOBb8PWhvxVNlM
         jdzqE7D0TiScLuL5msDnqPbZP07pHD47CMmtGt86dGW6DgLDrNNBq1Yx4MpqFbW3xH0r
         cco6iLxKkaYfRuNisGf/GTEQyRT8rEYewjww2SF4rPMbgpf0+9Lz79IQ6tEWwTlbkinO
         /QLA==
X-Gm-Message-State: AAQBX9eu8Ruwws4O+IDXq3xAl1FHSY/fX2vaOgQvUYuqcBkiCjVIEGt+
        YbZCnPKTJPVoPQ6yPMROHfKB9CPTvrV6Fv0/wuE=
X-Google-Smtp-Source: AKy350aAC8NwPtk19mVrAD6XazIhXTISUQmhTljQ4VoiO/yRNDZ3qRt9m2NkcU6MJDTOkjLT9rqHfA==
X-Received: by 2002:a81:8416:0:b0:53c:5b6f:f5e6 with SMTP id u22-20020a818416000000b0053c5b6ff5e6mr5140557ywf.12.1679605108787;
        Thu, 23 Mar 2023 13:58:28 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id o19-20020a81ef13000000b00545a0818500sm38546ywm.144.2023.03.23.13.58.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 13:58:26 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5418d54d77bso416101177b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:58:26 -0700 (PDT)
X-Received: by 2002:a81:b149:0:b0:544:b7ff:b0df with SMTP id
 p70-20020a81b149000000b00544b7ffb0dfmr2598921ywh.2.1679605105763; Thu, 23 Mar
 2023 13:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230315035508.2874915-1-treapking@chromium.org>
In-Reply-To: <20230315035508.2874915-1-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Mar 2023 13:58:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VxKO6y38nDUmppRseC7kP1cJCUEMkbUPMY1d8LzKe4ZA@mail.gmail.com>
Message-ID: <CAD=FV=VxKO6y38nDUmppRseC7kP1cJCUEMkbUPMY1d8LzKe4ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: ps8640: Skip redundant bridge enable
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
> Skip the drm_bridge_chain_pre_enable call when the bridge is already
> pre_enabled. This make pre_enable and post_disable (thus
> pm_runtime_get/put) symmetric.
>
> Fixes: 46f206304db0 ("drm/bridge: ps8640: Rework power state handling")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Even though this could go in drm-misc-fixes, doing so would cause a
conflict with patch #2 in this series which is not a fix. Since I
don't believe this is massively urgent, I've landed both in
drm-misc-next to avoid needing to involve more senior folks to do
fancy stuff:

845e730eaf36 drm/bridge: ps8640: Skip redundant bridge enable
