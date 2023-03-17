Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26CD6BDD8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCQAYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCQAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:24:06 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9865551B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:24:03 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id t129so1591995iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679012642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFJTRUdrKAQbmJGCN+ld5AkqKv3yfsgaUc2fFe1xZBM=;
        b=nyHkeFF+vvf8xz4aDvAjMN1qF+ht9DiYaEVyzQ425/8YpAIamARYJ9/vJBgcUr5HwQ
         oca3ceBhpgVs+0NLYozznrwIp8IKLIhqntliqewo78Q6AuzXh0KcJ6f8UP2ODGcGBpnW
         oXzQ8AJa5gZug68ZJQ2+nmLiwCNXgJ4w5pwpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679012642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFJTRUdrKAQbmJGCN+ld5AkqKv3yfsgaUc2fFe1xZBM=;
        b=Su/pv9OwohCuZddZEBPfzH/sCwPvoX6h04k5znaQ43cJHfKUFGavJgvJjOsH0iYsUo
         aUgPOM78Ja9IWKJFP7DQyrcI2CbRJGuqa9/JewWnudGYrLVxpnbZlHKhnjJCnJY0BJYu
         b5pEeXNR9QMk8BxclPsre6PTeibV8rcNBukPZNC64BQjxUN5oNEWN2xaD2fsxbIyo/WG
         dy14xjIoyhMD+vNn24zIYi/1RtK0rga5xq4AIDpBZ0rud/d8iXlu9e3BvKjq58OUs/JW
         PZMDQvWzhM5WGNJ048n2w/0jDys/QOrLAip1+Um4fijyUY5NgBstLPaBzv8XyZiZAP61
         vVJg==
X-Gm-Message-State: AO0yUKUmUoCA544/RK3JcqV5qEc5VLINDpn1Qqb9UHYsuHCU4wP456yM
        rmBzSghLx9VuzOAPWKHWzsHxVRrzUPU03oBzYMM=
X-Google-Smtp-Source: AK7set+l6Im7lfRgIhUWq2o4Dwy8zJjvAzVzV98NU+/SWxCZDSr4bu+8EneD8+uKDGrwuw0ykcY7yQ==
X-Received: by 2002:a6b:660d:0:b0:753:18b9:8d43 with SMTP id a13-20020a6b660d000000b0075318b98d43mr500636ioc.16.1679012641750;
        Thu, 16 Mar 2023 17:24:01 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id q15-20020a6bf20f000000b00704608527d1sm161187ioh.37.2023.03.16.17.24.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 17:24:00 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id s4so1589599ioj.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:24:00 -0700 (PDT)
X-Received: by 2002:a02:b192:0:b0:3ad:65e:e489 with SMTP id
 t18-20020a02b192000000b003ad065ee489mr455541jah.1.1679012640151; Thu, 16 Mar
 2023 17:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230314114451.8872-1-lujianhua000@gmail.com> <CAD=FV=X7K2KQoRCsr17kj-DWiPs7h_zfcYxK_cdBVnC0wR1NwA@mail.gmail.com>
 <ZBEJdX6WVZ3Kqdo0@Gentoo>
In-Reply-To: <ZBEJdX6WVZ3Kqdo0@Gentoo>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Mar 2023 17:23:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgWSvrpCdi2pRr0JctHxcq1-qNJSMAxEVva6nEnv3e_g@mail.gmail.com>
Message-ID: <CAD=FV=VgWSvrpCdi2pRr0JctHxcq1-qNJSMAxEVva6nEnv3e_g@mail.gmail.com>
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


On Tue, Mar 14, 2023 at 4:55=E2=80=AFPM Jianhua Lu <lujianhua000@gmail.com>=
 wrote:
>
> On Tue, Mar 14, 2023 at 10:12:02AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Mar 14, 2023 at 4:45=E2=80=AFAM Jianhua Lu <lujianhua000@gmail.=
com> wrote:
> > >
> > > Some panels set mode type to DRM_MODE_TYPE_PREFERRED by the number
> > > of modes. It isn't reasonable, so set the first mode type to
> > > DRM_MODE_TYPE_PREFERRED. This should be more reasonable.
> > >
> > > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > > ---
> > >  drivers/gpu/drm/panel/panel-abt-y030xx067a.c     | 2 +-
> > >  drivers/gpu/drm/panel/panel-auo-a030jtn01.c      | 2 +-
> > >  drivers/gpu/drm/panel/panel-edp.c                | 4 ++--
> > >  drivers/gpu/drm/panel/panel-innolux-ej030na.c    | 2 +-
> > >  drivers/gpu/drm/panel/panel-newvision-nv3051d.c  | 2 +-
> > >  drivers/gpu/drm/panel/panel-newvision-nv3052c.c  | 2 +-
> > >  drivers/gpu/drm/panel/panel-novatek-nt35950.c    | 2 +-
> > >  drivers/gpu/drm/panel/panel-novatek-nt39016.c    | 2 +-
> > >  drivers/gpu/drm/panel/panel-orisetech-ota5601a.c | 2 +-
> > >  drivers/gpu/drm/panel/panel-seiko-43wvf1g.c      | 4 ++--
> > >  drivers/gpu/drm/panel/panel-simple.c             | 4 ++--
> > >  11 files changed, 14 insertions(+), 14 deletions(-)
> >
> > Can you explain more about your motivation here? At least for
> This demonstrates a bad way to set DRM_MODE_TYPE_PREFERRED for panels
> with more than one mode. It mislead the future contributors to send
> a patch with this piece of code. There is also a discussion for it.
> https://lore.kernel.org/lkml/904bc493-7160-32fd-9709-1dcb978ddbab@linaro.=
org/
> > panel-edp and panel-simple it seems like it would be better to leave
> > the logic alone and manually add DRM_MODE_TYPE_PREFERRED to the right
> > mode for the rare panel that actually has more than one mode listed.
> I think we can order it to the first mode if the mode type should be
> DRM_MODE_TYPE_PREFERRED, It's also same.

A pointer to the original discussion would have been super helpful to
be provided in your patch description.

Personally, I still stand by my assertion that I'd rather that
DRM_MODE_TYPE_PREFERRED be placed in the actual data instead of being
done like this in post-processing. To me the old check for "num_modes
=3D=3D 1" is basically saying that the people creating the "static const"
data in this file were lazy and didn't feel like they needed to set a
DRM_MODE_TYPE_PREFERRED when there was only one mode listed. Thus, we
can add it for them. When "num_modes" is more than 1 then we shouldn't
allow the people making the "static const" data to be lazy. We should
force them to set one of the modes to be PREFERRED rather than for
them to have to know about this magic rule.

Thus, for me, my order of preference would be these (note, I've mostly
looked at panel-edp and panel-simple):

1. Leave the check as "num_modes =3D=3D 1" and document that we're
basically allowing the people writing the "static const" structure to
be lazy if there's only one mode. Manually add the
DRM_MODE_TYPE_PREFERRED flag to the small number of cases where there
is more than one mode. Possibly add a warning printout if we end up
without a PREFERRED mode. I'd give a Reviewed-by for this.

2. Fully get rid of this logic and add DRM_MODE_TYPE_PREFERRED to all
of the "static const" data. I guess maybe we can't do that for the
"timings" in panel-edp and panel-simple. I guess for those I'd be OK
with just setting PREFERRED on the first timing like your patch is
doing. I'd give a Reviewed-by for this.

3. Your patch. I won't NAK it since it seems like this is what other
(more senior) DRM folks were suggesting. ...but I don't love it. I
won't give a Reviewed-by for this but won't object to someone else
doing so.

-Doug
