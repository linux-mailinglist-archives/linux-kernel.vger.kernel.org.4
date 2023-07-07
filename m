Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7A74B67B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjGGSkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGGSkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:40:51 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AB2682
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 11:40:50 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-565f2567422so1592688eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688755248; x=1691347248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4khBbbMzZOqVO6sgwUxA/mR93/pguaqzC86olg1A9Q=;
        b=IvQs+5Bd72VtYmZOzs/keL4rEe6Y8ERi9NcvH2dfxSHBEMFJJ6pesO1qYZq+WULb0m
         oFOmtgCN/xYyC5sMwYMccXqQB4os0XJ6F89YGhE0eTXcEAu/9VkCcAR+/1bgwD4HXDFu
         bBl/BhlBskGskIaCo8xb5oMpTjG0/CxuiN12IvRNlqcwF6NOiFduaCNxiY049aekB+WS
         a54E4faLUUVXMETTTcDzjETJPFQAfqUCb3KMPe6X/8yaLGTkNwoy8De8Pawf3lbOnoDp
         z+Td1wmDer6ni86YAw0IRlvdF6MjPuex4CW7+872FFhhpgnxfvpT625MrwgsFhWg2nJz
         518g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688755248; x=1691347248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4khBbbMzZOqVO6sgwUxA/mR93/pguaqzC86olg1A9Q=;
        b=LAXArnRObFqXQH33dscHxrV/4sn+77e3sy7RFSisR7lz7jaUln5a5cJevAaHZd/Wyu
         b4AR2Kqu7/E5wdUF45aZrJ47lALBmO3bQPBpp5zsGa0ES1N0IVxyizncZqxbyxTezfgv
         oR1N/rbo1mgPKn2uyPTset82pE+dHvg63LyKwh2AWKGTecPXbXmvDabio/+wI3wurvEn
         VM/RRDySgTpmYHWTBd8Dl7M9raVCL2JPTVXVPESzNJUA2Lr+KC9/5lJmV/B6ebeZcCYT
         traoEY+FXMZW+psQsm4P/1s4+QkIvQIFY1XGpmAXsQDYBXInWafDFb1TDVVAxLN1OnZb
         PdzQ==
X-Gm-Message-State: ABy/qLYmqhciV49n69mo62nJH3ypB8k0cCKIZU//XoJ7C9w7ELGeHTQx
        jO3AjSweputmMHnctPLinUUa1hCALdJOeQ9AA4+Qy3wh
X-Google-Smtp-Source: APBJJlEuci3uJQdI2So5qxh1kJtVbYtHUhBLmgc2t5ZV0Tj7CtsJuQGY5emu9lGlC2mgfen19d52vWR1A1pTHvNJGvg=
X-Received: by 2002:a4a:641:0:b0:558:b482:c3b3 with SMTP id
 62-20020a4a0641000000b00558b482c3b3mr3874548ooj.1.1688755248313; Fri, 07 Jul
 2023 11:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230707111157.209432-1-arnd@kernel.org> <f32098e2-d680-d02e-8181-cad76daf2416@amd.com>
In-Reply-To: <f32098e2-d680-d02e-8181-cad76daf2416@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 7 Jul 2023 14:40:37 -0400
Message-ID: <CADnq5_M5KE_woBVfsmVhQPzc4YJon_5mKKuQ72mCnKqU-SdumQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        dri-devel@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
        linux-kernel@vger.kernel.org, Shiwu Zhang <shiwu.zhang@amd.com>,
        Le Ma <le.ma@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

On Fri, Jul 7, 2023 at 7:47=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 07.07.23 um 13:11 schrieb Arnd Bergmann:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > On 32-bit architectures comparing a resource against a value larger tha=
n
> > U32_MAX can cause a warning:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1344:18: error: result of co=
mparison of constant 4294967296 with expression of type 'resource_size_t' (=
aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of=
-range-compare]
> >                      res->start > 0x100000000ull)
> >                      ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
> >
> > As gcc does not warn about this in dead code, add an IS_ENABLED() check=
 at
> > the start of the function. This will always return success but not actu=
ally resize
> > the BAR on 32-bit architectures without high memory, which is exactly w=
hat
> > we want here, as the driver can fall back to bank switching the VRAM
> > access.
> >
> > Fixes: 31b8adab3247e ("drm/amdgpu: require a root bus window above 4GB =
for BAR resize")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > v2: return early instead of shutting up the warning with a cast and
> > running into a failure
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 7f069e1731fee..fcf5f07c47751 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1325,6 +1325,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_dev=
ice *adev)
> >       u16 cmd;
> >       int r;
> >
> > +     if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
> > +             return 0;
> > +
> >       /* Bypass for VF */
> >       if (amdgpu_sriov_vf(adev))
> >               return 0;
>
