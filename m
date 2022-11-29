Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA863CB12
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiK2W32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiK2W3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:29:18 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F36F819
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:29:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ho10so37261256ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zLpCy3698Bc23bcTbA/ZXvSN9t0RpVO+Zbfm9nGrSiQ=;
        b=k2drZtEJBQIQoPR/xGtfnQRDFEFcN0kLvOBnFCVQEMz95pKx1E4a4hbRKLApx+IkEf
         JGfd6zOp4IkKQzXt5/Ou4pqNzf9f+90PafF2m+3MYiGyG9nncqHP4u8DrPnmyo6U9qGL
         +5VwJoq3+DaBLcVeb0ozJQWwt4Z6OjHrqFRe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLpCy3698Bc23bcTbA/ZXvSN9t0RpVO+Zbfm9nGrSiQ=;
        b=fFUs9hOLsy5moNydknFGgW9Qo4P6HV8a/5fzNG2yAKbVaI4vnEqSdQ4agFTMGMXz71
         ZQnik/PxpgLZXN+GZWW+hxzOSyI5lKtarHHpi2P5e6xTR5NefsVLMA6odwCaQ/H8+cjo
         U6WJRV/gDkQV9JgdqOcZrvVbEiNzSWdziwwuols804WwbXeKeWQaH2bbu68VXtSSh1/d
         BMCtX+v19gryJN2Cas1p7/D5aNwEPnEIvT6jNAQPzlP6klPAroJ3/uv8m8OGAjPDm6m9
         DgcGtvRtb7vUcObszedx0US6Tf+pBYq2KMAEobS4iAtpwFgoLrQ83yJJ5pWQg5iK8C5K
         I4jQ==
X-Gm-Message-State: ANoB5pluTzazjKRJJ3EnbmbYgoeKnQ4wjUKmY8nNfKXOSeXHNuZEv9rG
        CEAfrjsNsBYNm/dhFH5myI5frJ2ErforWlR7
X-Google-Smtp-Source: AA0mqf79WP4HizBQwG+8aSy/Nt7AOrzTK3KzK20JP4KB4vdCJBNAn6RNmY9aSx/3KhmV5284wCkIAg==
X-Received: by 2002:a17:906:4a8d:b0:78d:a4ca:32df with SMTP id x13-20020a1709064a8d00b0078da4ca32dfmr47786051eju.686.1669760948661;
        Tue, 29 Nov 2022 14:29:08 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id k1-20020aa7c041000000b0046ba536ce52sm411947edo.95.2022.11.29.14.29.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 14:29:07 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id r4-20020a1c4404000000b003d070274a61so76587wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:29:06 -0800 (PST)
X-Received: by 2002:a1c:cc04:0:b0:3cf:7716:8954 with SMTP id
 h4-20020a1ccc04000000b003cf77168954mr43045048wmb.57.1669760946142; Tue, 29
 Nov 2022 14:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <20221117133655.4.If6153da69ec4bc9e83d5f095ef6e6b07283940a5@changeid> <CAD=FV=VvhzEgjQidvF3DVokNyiQ1hRkqGShCoNbM5ytma3gZYQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VvhzEgjQidvF3DVokNyiQ1hRkqGShCoNbM5ytma3gZYQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Nov 2022 14:28:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X-jPz=8z2eXr4mOd6p=qtPSWJmxRvxvmVnOzURN31mHA@mail.gmail.com>
Message-ID: <CAD=FV=X-jPz=8z2eXr4mOd6p=qtPSWJmxRvxvmVnOzURN31mHA@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/bridge/parade-ps8640: Extend autosuspend
To:     Drew Davenport <ddavenport@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 17, 2022 at 1:14 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
> >
> > Same change as done for panel-samsung-atna33xc20. Extend the autosuspend
> > delay to avoid oscillating between power status during boot.
> >
> > Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> This seems fine to me. Not 100% sure what changed in the probing /
> booting to make it need 2 seconds now, but this really shouldn't cause
> any issues and it's nice to avoid those slow power cycles.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

b1d2751c2f23 drm/bridge/parade-ps8640: Extend autosuspend
