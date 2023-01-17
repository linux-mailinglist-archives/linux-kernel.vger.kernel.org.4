Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8263B66DA86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjAQKDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjAQKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:03:09 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DED2C669
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:03:08 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z9so3208910qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecFxr4zy/kGlIfPMvOikr3JXHHNtFXCcFgoP6dxCRqY=;
        b=S14QFWKiAi4/ZKsijjw8Kce1BE724BPRy75Czyw0golKbWRuTYc8C2KUt6i8mIxjIW
         eL87ATsnR6/DuoQ4wMt0AAQ3fIShNaY1OuacW4HrmT6VOhiKwnm5yDXNIMpEnh03wlyO
         hPYU9YPYSkYs2JQKZGQBg8xslwfu+VV0LYKCsRsns129pedrzUYUQMEup6FX/n7fGKLP
         fCkZZWsnGCpODpvmjR+Jzt9saIta/UGxEZoy5PwxfCbySFoH3aM2moa3AR0BNIWrmSry
         h/wVVzmOm1jt0XTqrWWceZ10zEFHAWQXIU483gZYe5oET+ryAzmR/FopI+nFXeVHS7fz
         9XUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecFxr4zy/kGlIfPMvOikr3JXHHNtFXCcFgoP6dxCRqY=;
        b=JkFFKSDpRnBcN4LiqrppL3eeu3YiZSQDXJmHWlR/pkoMgFG9MwZjH7tTkUPiMWfXTI
         AwPFhm+RqKt3JqDxSXnm+2VulCtAwK1CDign1KwGf99XyU63rjLVaRMsu+HHR0nz5JJq
         M74cwVST/8YspGigz4RwLogv/FIhbcyYoqExKcIJ9OrYjg9o3XgHCfzNd2BvHG4ibT2d
         idoClniEAtaIoEiwbG0O1P27XoXtODJraQsw22rJjIwvgx1ixpodwoBUMbIV3s0grAr7
         LG9JpmdPTHEmw0Pc4ZP3eBOEtXv4F4A4bJqM+WVSQ9WFMPvOOfQbtPnXsXCmXd1QLg+E
         WWNg==
X-Gm-Message-State: AFqh2krFl9PQnGVESpbasJlFzoEMQMUjtyRWvXUcHthK/ZTp3Dxx8E7F
        lKWR+dEhBvbpCwqk0sMglqN4EZHVHomasSXHhKMp3Q==
X-Google-Smtp-Source: AMrXdXv3CEmpdaBOSY+Nz+3NLqjaJd++9t8x97FKfVJgVDgg0XK9MPNaiLM0PhkG8wX6XSZ+3CEdrWsaHsXYo6wcZYs=
X-Received: by 2002:a37:a8c4:0:b0:706:5827:b775 with SMTP id
 r187-20020a37a8c4000000b007065827b775mr131477qke.208.1673949787557; Tue, 17
 Jan 2023 02:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20221228032419.1763-1-yongxuan.wang@sifive.com>
 <20221228032419.1763-2-yongxuan.wang@sifive.com> <20230104105939.vdiq77xbn45agj22@bogus>
In-Reply-To: <20230104105939.vdiq77xbn45agj22@bogus>
From:   Yong Xuan Wang <yongxuan.wang@sifive.com>
Date:   Tue, 17 Jan 2023 18:02:56 +0800
Message-ID: <CAMWQL2ivgNxTA73tmXeF9BEfJX1agQyWe1JqV6R8H8ksCF-csQ@mail.gmail.com>
Subject: Re: [PATCH -next v3] drivers: base: cacheinfo: fix shared_cpu_map
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> On Wed, Jan 4, 2023 at 6:59 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Dec 28, 2022 at 03:24:19AM +0000, Yong-Xuan Wang wrote:
> > The cacheinfo sets up the shared_cpu_map by checking whether the caches
> > with the same index are shared between CPUs. However, this will trigger
> > slab-out-of-bounds access if the CPUs do not have the same cache hierar=
chy.
> > Another problem is the mismatched shared_cpu_map when the shared cache =
does
> > not have the same index between CPUs.
> >
> > CPU0  I       D       L3
> > index 0       1       2       x
> >       ^       ^       ^       ^
> > index 0       1       2       3
> > CPU1  I       D       L2      L3
> >
> > This patch checks each cache is shared with all caches on other CPUs.
> >
>
> Just curious to know if this is just Qemu config or a real platform.
> I had intentionally not supported this to just to get to know when such
> h/w appears in the real world =F0=9F=98=81.
>

We are trying to build such kind of config in QEMU.

> > Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  drivers/base/cacheinfo.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> > index 950b22cdb5f7..dfa804bcf3cc 100644
> > --- a/drivers/base/cacheinfo.c
> > +++ b/drivers/base/cacheinfo.c
> > @@ -256,7 +256,7 @@ static int cache_shared_cpu_map_setup(unsigned int =
cpu)
> >  {
> >       struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> >       struct cacheinfo *this_leaf, *sib_leaf;
> > -     unsigned int index;
> > +     unsigned int index, sib_index;
> >       int ret =3D 0;
> >
> >       if (this_cpu_ci->cpu_map_populated)
> > @@ -284,11 +284,12 @@ static int cache_shared_cpu_map_setup(unsigned in=
t cpu)
> >
> >                       if (i =3D=3D cpu || !sib_cpu_ci->info_list)
> >                               continue;/* skip if itself or no cacheinf=
o */
> > -
> > -                     sib_leaf =3D per_cpu_cacheinfo_idx(i, index);
> > -                     if (cache_leaves_are_shared(this_leaf, sib_leaf))=
 {
> > -                             cpumask_set_cpu(cpu, &sib_leaf->shared_cp=
u_map);
> > -                             cpumask_set_cpu(i, &this_leaf->shared_cpu=
_map);
> > +                     for (sib_index =3D 0; sib_index < cache_leaves(i)=
; sib_index++) {
> > +                             sib_leaf =3D per_cpu_cacheinfo_idx(i, sib=
_index);
> > +                             if (cache_leaves_are_shared(this_leaf, si=
b_leaf)) {
> > +                                     cpumask_set_cpu(cpu, &sib_leaf->s=
hared_cpu_map);
> > +                                     cpumask_set_cpu(i, &this_leaf->sh=
ared_cpu_map);
>
> Does it make sense to break here once we match as it is unlikely to match
> with any other indices ?
>

Yeah. We can break here once we find the shared instance. I'll send a
new version to fix it.
Thank you!

> > +                             }
> >                       }
> >               }
> >               /* record the maximum cache line size */
> > @@ -302,7 +303,7 @@ static int cache_shared_cpu_map_setup(unsigned int =
cpu)
> >  static void cache_shared_cpu_map_remove(unsigned int cpu)
> >  {
> >       struct cacheinfo *this_leaf, *sib_leaf;
> > -     unsigned int sibling, index;
> > +     unsigned int sibling, index, sib_index;
> >
> >       for (index =3D 0; index < cache_leaves(cpu); index++) {
> >               this_leaf =3D per_cpu_cacheinfo_idx(cpu, index);
> > @@ -313,9 +314,13 @@ static void cache_shared_cpu_map_remove(unsigned i=
nt cpu)
> >                       if (sibling =3D=3D cpu || !sib_cpu_ci->info_list)
> >                               continue;/* skip if itself or no cacheinf=
o */
> >
> > -                     sib_leaf =3D per_cpu_cacheinfo_idx(sibling, index=
);
> > -                     cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map)=
;
> > -                     cpumask_clear_cpu(sibling, &this_leaf->shared_cpu=
_map);
> > +                     for (sib_index =3D 0; sib_index < cache_leaves(si=
bling); sib_index++) {
> > +                             sib_leaf =3D per_cpu_cacheinfo_idx(siblin=
g, sib_index);
> > +                             if (cache_leaves_are_shared(this_leaf, si=
b_leaf)) {
> > +                                     cpumask_clear_cpu(cpu, &sib_leaf-=
>shared_cpu_map);
> > +                                     cpumask_clear_cpu(sibling, &this_=
leaf->shared_cpu_map);
>
> Same comment as above.
>
> --
> Regards,
> Sudeep

Regards,
Yong-Xuan
