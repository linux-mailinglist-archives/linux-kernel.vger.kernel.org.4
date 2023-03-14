Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549896B9C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCNRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjCNRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:12:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40692F23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:12:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b16so6684806iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678813936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WErv31ByjL+Y5MoYqCnIOK9sNV/kGFFl+v+OJaK+Hw=;
        b=fwgtKfujDZT03JfvBhH17H4E0WnKpCSqvzpMWw1Ay+iJ6bNTu8osC4fSHj0EikKZNi
         l+Rzl4glwPW0WoKXYxbrJjW8ciXPh+hcwug3ovIs+RRrJp1PcmnRtVTsMD0qNDju+hxN
         Wt+PmOe3hD88G3VZZ2ABBbVDG2Hnj+6pCYS6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678813936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WErv31ByjL+Y5MoYqCnIOK9sNV/kGFFl+v+OJaK+Hw=;
        b=hsV7t1PXacmGpXBz3FVCm7n/l6Xa4fhbf9QqSGajg1589q0/DRqOYlOxp8ID0dWZGP
         8NseLcY9uNKUTk3SHrold0SfCKM7LpghydiFvPbpT94YsASKdWhVGHfGeMaiQ6p4wtrs
         2XKHOQTJMdMYb04Zvu5eZhitKi7A/XnRFQRHPOF6y+mP+wka8IaZkMcurxlntzxpf6m/
         4OfA0DknmRsi+FRfhTzstepW5h9+9VoeaAjOJ3D2KyOSLmn6at+B1PxHM9iUakze4OrI
         cebuGbm8carUU2GAVpWbR6Sg74QzoSAEWyWBnsV/SdD83zIpWrGnoI5jvO0wOLnRSyib
         qftQ==
X-Gm-Message-State: AO0yUKUPLOVIsUGBwQzLkGwt0c7X/kAq1SmfFgxrVuR8T3RMZQ2yD612
        lezy3tMEfe7wgFcjUrOEjBtrTqnhYa4nMUFLMQ4=
X-Google-Smtp-Source: AK7set/fCrBNGeYicfcu7e9QjuenWC1/5RjmitL3Ldov6Nh18ay504+shXBixZtSDcrSLTtTAXA1ZA==
X-Received: by 2002:a6b:d601:0:b0:74f:a1c6:762 with SMTP id w1-20020a6bd601000000b0074fa1c60762mr2329805ioa.11.1678813935763;
        Tue, 14 Mar 2023 10:12:15 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id s1-20020a02c501000000b00401cf1d52d6sm928905jam.49.2023.03.14.10.12.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 10:12:15 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id g6so6685416iov.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:12:14 -0700 (PDT)
X-Received: by 2002:a05:6638:3489:b0:404:140b:55e3 with SMTP id
 t9-20020a056638348900b00404140b55e3mr4999457jal.0.1678813934494; Tue, 14 Mar
 2023 10:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230314114451.8872-1-lujianhua000@gmail.com>
In-Reply-To: <20230314114451.8872-1-lujianhua000@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Mar 2023 10:12:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7K2KQoRCsr17kj-DWiPs7h_zfcYxK_cdBVnC0wR1NwA@mail.gmail.com>
Message-ID: <CAD=FV=X7K2KQoRCsr17kj-DWiPs7h_zfcYxK_cdBVnC0wR1NwA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Fix panel mode type setting logic
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 14, 2023 at 4:45=E2=80=AFAM Jianhua Lu <lujianhua000@gmail.com>=
 wrote:
>
> Some panels set mode type to DRM_MODE_TYPE_PREFERRED by the number
> of modes. It isn't reasonable, so set the first mode type to
> DRM_MODE_TYPE_PREFERRED. This should be more reasonable.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-abt-y030xx067a.c     | 2 +-
>  drivers/gpu/drm/panel/panel-auo-a030jtn01.c      | 2 +-
>  drivers/gpu/drm/panel/panel-edp.c                | 4 ++--
>  drivers/gpu/drm/panel/panel-innolux-ej030na.c    | 2 +-
>  drivers/gpu/drm/panel/panel-newvision-nv3051d.c  | 2 +-
>  drivers/gpu/drm/panel/panel-newvision-nv3052c.c  | 2 +-
>  drivers/gpu/drm/panel/panel-novatek-nt35950.c    | 2 +-
>  drivers/gpu/drm/panel/panel-novatek-nt39016.c    | 2 +-
>  drivers/gpu/drm/panel/panel-orisetech-ota5601a.c | 2 +-
>  drivers/gpu/drm/panel/panel-seiko-43wvf1g.c      | 4 ++--
>  drivers/gpu/drm/panel/panel-simple.c             | 4 ++--
>  11 files changed, 14 insertions(+), 14 deletions(-)

Can you explain more about your motivation here? At least for
panel-edp and panel-simple it seems like it would be better to leave
the logic alone and manually add DRM_MODE_TYPE_PREFERRED to the right
mode for the rare panel that actually has more than one mode listed.
That feels more explicit to me.

-Doug
