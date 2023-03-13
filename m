Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F16B6DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCMDKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCMDJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:09:59 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FAC28856
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:09:57 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id d20so9789380vsf.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678676997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+psd8R+vmD5RvwTYlxJi1wP8fKpHP1Zmc7TIxsJKEsY=;
        b=N53/ggGiWuPqPDdRDrleVmQHpqQDjdpIzClBdpOvnrvQCwLuZaZKJ+rhC0c2rVybLY
         tbzZgnnkJoKcVeHk7Lzixl0Bug8WOYjc1nbrgHt8BDumgI8aUN00G38xUUo7O9MGXQ4d
         Y/LnnhrXgdv0XCwEhGgzvxX5Y1E+22diMyFyV9nxpWiV8qWSUQgAc2SzSEw9EqrMt0mo
         p/eLJ01lDu5Gcpgv+efW2pkArDOJJe1lncaTHJqauycAbQJG1BtQixYkYgJTknm/tTpE
         v7UFcQmW9bmd1QO5Ouj/iZNYQ/rdkugE/68wW+fOFkI2D9Tuyc6kCgykGK3IBwlrRQEh
         aWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678676997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+psd8R+vmD5RvwTYlxJi1wP8fKpHP1Zmc7TIxsJKEsY=;
        b=fOwpnCaM9ot40tSOjpRBqH233FR0hbsTnWspUv6rWAWIJYTvhPjTIEE0Fhw0a1Mwy1
         YD+PS4N8+lgbkYHkn5XP+CElSXKGdT4mFAPSjuyEC8Io+a4IyUN5EBSMXENUAoItVKjH
         i6piNEha755/MgPkz3Pi057AXGv9K+8YhfTzfBmWzGwB2/Fb0CJg/n8qDFtIoh57a5oB
         1skIT/AXRXkS0KE2PltjqD73d4sV2BaFQzZzphKJSxdwjrC9IDs9NjrIqFsyN5WJrO77
         cZjY6Xg04bDucAKeE5ol486100bjX1hKsP+7zEo7Fpido4hhUvNo/96Qq/SZjmx3J3kG
         sEhw==
X-Gm-Message-State: AO0yUKWUyar3hZhd8TKkJ+iVmWUZKVXuxmy1AAvKPOmEq18edelc/Ys9
        UKwmB8Wqgz/8yFAMUGzkJ+/3QSGIArkJn7NkMe8=
X-Google-Smtp-Source: AK7set+Mgs0Wzj9y04plk97b2hXgIXMfAcRVkPbSLMt3jPbr/TY3cmzFA9SDaxnbZoHhfZwO5l3ePrcLDSxwAToxsfA=
X-Received: by 2002:a67:fe54:0:b0:412:2d80:b0a3 with SMTP id
 m20-20020a67fe54000000b004122d80b0a3mr21468291vsr.4.1678676996739; Sun, 12
 Mar 2023 20:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230312233052.21095-1-nunes.erico@gmail.com>
In-Reply-To: <20230312233052.21095-1-nunes.erico@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 13 Mar 2023 11:09:45 +0800
Message-ID: <CAKGbVbs2ZRGyYOy9yYUMJ+apQm=NaXXb58C-97CaoTe5KPNqgw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/lima: expose usage statistics via fdinfo
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch set is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Looks like drm-misc-next does not contain "df622729ddbf drm/scheduler:
track GPU active time per entity" yet.
Will apply later.

Regards,
Qiang

On Mon, Mar 13, 2023 at 7:31=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> Expose lima gp and pp usage stats through fdinfo, following
> Documentation/gpu/drm-usage-stats.rst.
> Borrowed from these previous implementations:
>
> "df622729ddbf drm/scheduler: track GPU active time per entity" added
> usage time accounting to drm scheduler, which is where the data used
> here comes from.
>
> Then the main implementation is based on these etnaviv commits:
> "d306788b6e1b drm/etnaviv: allocate unique ID per drm_file" and
> "97804a133c68 drm/etnaviv: export client GPU usage statistics via
> fdinfo"
>
> Also "874442541133 drm/amdgpu: Add show_fdinfo() interface" since lima
> has a context manager very similar to amdgpu and all contexts created
> (and released) at the ctx_mgr level need to be accounted for.
>
> Tested with the generic "gputop" tool currently available as patches to
> igt, a sample run with this patchset looks like this:
>
> DRM minor 128
>     PID               NAME             gp                        pp
>     4322   glmark2-es2-way |=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=8A                  ||=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88      |
>     3561            weston |=E2=96=8E                       ||=E2=96=88=
=E2=96=88=E2=96=88=E2=96=8C                    |
>     4159          Xwayland |=E2=96=8F                       ||=E2=96=89  =
                     |
>     4154          glxgears |=E2=96=8F                       ||=E2=96=8E  =
                     |
>     3661           firefox |=E2=96=8F                       ||=E2=96=8F  =
                     |
>
>
> Erico Nunes (3):
>   drm/lima: add usage counting method to ctx_mgr
>   drm/lima: allocate unique id per drm_file
>   drm/lima: add show_fdinfo for drm usage stats
>
>  drivers/gpu/drm/lima/lima_ctx.c    | 30 ++++++++++++++++++++-
>  drivers/gpu/drm/lima/lima_ctx.h    |  3 +++
>  drivers/gpu/drm/lima/lima_device.h |  3 +++
>  drivers/gpu/drm/lima/lima_drv.c    | 43 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/lima/lima_drv.h    |  1 +
>  5 files changed, 78 insertions(+), 2 deletions(-)
>
> --
> 2.39.2
>
