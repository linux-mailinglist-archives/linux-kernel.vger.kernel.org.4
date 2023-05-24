Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9417D70EBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbjEXC4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjEXC4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81752198;
        Tue, 23 May 2023 19:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EFD86381E;
        Wed, 24 May 2023 02:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C7BC433B0;
        Wed, 24 May 2023 02:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684896993;
        bh=E9N/sAfiWUA+ZElz5wXgXJ0URf+jkMc0VYEsIDumwIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uxo9Q6dlBJ19Ma0l5jISNnb0DCAgr8wVExorQUZeY9BHGIy/JoMjyFUBZcadP/QNz
         Dw8Mw8x67cCWCEr/84MM5RmLcu4DnSLmlOY75H/DSWFD/P7ydmT+HehVauNG4E3AU9
         J2g2500D3KT9/JOdJ+6pd9B6aXvF+KEhWWra88IrSyl71kA+KWhnsgGdz6RZd2OTOW
         9HqOJ9xhxHVmRCMqpHt99rTkHepRnaf0QY1oZD0KhxjCe0hRb6QM+EJoxVP1XPqofU
         0t1EZUklTeEaxkWgh3iVLdk5uXcJEZLI/nbN2NzBf+xR3RhFg+MNdGh/WQ33lmZr91
         hthznWcHiSEGQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-95fde138693so1135874366b.0;
        Tue, 23 May 2023 19:56:33 -0700 (PDT)
X-Gm-Message-State: AC+VfDxLCNt76MUxJVQzAVFcdTe+tWwgXKoqQ67Yxdm1bK4+LFRa8jQ/
        8Yu3wHc+89P9VzYr6dAmr5ELDAAWqZELYlDKVs4=
X-Google-Smtp-Source: ACHHUZ6i9KR0riGnMcQYXxLMBszSuF2aNO1/uSx3dwZ0hU2V8tO6jzLEGgXBjYfrHlAWi77UzA9fDJpaJtyeOq1i32A=
X-Received: by 2002:a17:907:1ca7:b0:96f:ddaa:c30d with SMTP id
 nb39-20020a1709071ca700b0096fddaac30dmr9621163ejc.26.1684896991695; Tue, 23
 May 2023 19:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230520105718.325819-1-15330273260@189.cn> <20230520105718.325819-2-15330273260@189.cn>
 <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name> <73447e35-f4df-9871-6210-b7bf1a3f04fc@189.cn>
 <97fe7af2-0a93-3f28-db6e-40a9b0798d49@xen0n.name>
In-Reply-To: <97fe7af2-0a93-3f28-db6e-40a9b0798d49@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 24 May 2023 10:56:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5iRHFUgWZb2HdE7RdAw-bYdn0-xJTdq=eQexabjmn5_w@mail.gmail.com>
Message-ID: <CAAhV-H5iRHFUgWZb2HdE7RdAw-bYdn0-xJTdq=eQexabjmn5_w@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display controller
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linaro-mm-sig@lists.linaro.org, Liu Peibao <liupeibao@loongson.cn>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 4:14=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 2023/5/22 16:02, Sui Jingfeng wrote:
> > Hi,
> >
> > On 2023/5/21 20:21, WANG Xuerui wrote:
> >>> --- /dev/null
> >>> +++ b/drivers/gpu/drm/loongson/Kconfig
> >>> @@ -0,0 +1,17 @@
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>> +
> >>> +config DRM_LOONGSON
> >>> +    tristate "DRM support for Loongson Graphics"
> >>> +    depends on DRM && PCI && MMU
> >>> +    select DRM_KMS_HELPER
> >>> +    select DRM_TTM
> >>> +    select I2C
> >>> +    select I2C_ALGOBIT
> >>> +    help
> >>> +      This is a DRM driver for Loongson Graphics, it may including
> >>
> >> Drop "it may"; "including" should be enough.
> >>
> > 'it may' is more *precise* here, because currently we don't ship with
> > the support for loongson 2K series SoC.
> >
> > I'm try to be precise as far as I can, we avoid made this driver too
> > large by ignore loongson 2K series SoC temporary.
>
> That's a good idea! For now the patch is so large that my review reply
> is said to be dropped by the lists. Focusing on one bunch of similar
> models first then adding support for the rest not-so-similar models is
> very friendly towards the reviewing process and will help code quality to=
o.
I suggest split the LS2K parts to a separate patch, but keep it in the
same series to get them upstreamed together.

Huacai
>
> >
> >>> +      LS7A2000, LS7A1000, LS2K2000 and LS2K1000 etc. Loongson LS7A
> >>> +      series are bridge chipset, while Loongson LS2K series are SoC.
> >>> +
> >>> +      If "M" is selected, the module will be called loongson.
> >>
> >> Just "loongson"?
> >
> > Yes,  when compile this driver as module,  loongson.ko will be generate=
d.
> >
> >   drm radeon is also doing so, See drm/radeon/Kconfig.
> >
> >> I know it's like this for ages (at least dating back to the MIPS days)
> >> but you really don't want to imply Loongson is mainly a GPU company.
> >> Something like "loongson_drm" or "lsdc" or "gsgpu" could be better.
> >
> > No, these name may have backward compatibility problems.
> >
> > Downstream driver already taken those name.
> >
> > userspace driver need to differentiate them who is who.
>
> IMO this shouldn't be a problem. Let me try explaining this: currently,
> upstream / the "new world" doesn't have any support for this driver at
> all, so any name will work; just use whatever is appropriate from an
> upstream's perspective, then make the userspace bits recognize both
> variants, and you'll be fine. And the "existing" userspace drivers can
> also carry the change, it'll just be a branch never taken in that setup.
>
> So, I'm still in favor of keeping the upstream "clean" without dubious
> names like this (bare "loongson"). What do you think about my suggestion
> above?
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
