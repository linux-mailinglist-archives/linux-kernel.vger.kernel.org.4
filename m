Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105606FE55D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjEJUpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbjEJUph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6CE7D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683751493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqNS8slh9zXI/94Esn441HFeCruKUo14umEn384fGFo=;
        b=ietRfEzt3tz0rAOfBYUYvhH5Y85uqLut8R2ekBIuPpig1CisMfwyp3Xk/mRc8GT9hk42r0
        gWjqvK8EuOokV9kKm9hTD9ynOmSQuz2DiLkt79qrqs6kS1Dt5A1a3fMqKS89cgM+oh9PpI
        OhNw02BUFBhXWev5vbCbiKC8jzbVlX4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Mx7YOkUCMo67Shvv7qDpKQ-1; Wed, 10 May 2023 16:44:52 -0400
X-MC-Unique: Mx7YOkUCMo67Shvv7qDpKQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7578369dff3so1434986185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751492; x=1686343492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqNS8slh9zXI/94Esn441HFeCruKUo14umEn384fGFo=;
        b=Y9M3dMEe8ge+TBtrOIPmUe/qjHgppreR2vXfEb9SwP1Abm5aP3J/nJat2F1P2zfXkV
         iWuxHz4BTWKsyhW+EXTs1H9aLOfeZhuV7CszWJL5+TgdB4IWR57CzeAa1LavnSnkhN0h
         wxn9PzM13epb7PX/kD8f1jbFrs3uHyIn3kaxUF5Kbti/lo8WLytK0zrJ1pTmWsVJxnt6
         JSK6wKoZ2EKlnyHwvLXX7jzuoBq7BW+ES//oI7AJTbFwIyLpL/5VHrEMyKfNXBijdCM7
         214J1Rg0N5yHViTW5x8dOLlyhj2BnAdqNeRvMCvRX9L3hToiJEiJbwiiDS9Wy/hTgKHM
         WBLw==
X-Gm-Message-State: AC+VfDxm9luu3B6mruOXLIoiwBFHqD7qoHd6UNroqmmkzuvYAlqnpf21
        fHNr0E2wyqO31MpyVrGH+D3IRofNKOUd43JGDmfIa7fiZMdLZk9HV0BhrF+xMblqh7V5bWyhag4
        beXT6dOEUb+vIuMYRvPfi7MYc
X-Received: by 2002:a05:622a:253:b0:3ef:57f8:8433 with SMTP id c19-20020a05622a025300b003ef57f88433mr37348670qtx.4.1683751491805;
        Wed, 10 May 2023 13:44:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+G4qBvDdJGQ+o0g+gtirEs6XX2CqYLLt4A22HkQ5V7jNrQtyZS1mgqIyW4hWoTwmGiJW//w==
X-Received: by 2002:a05:622a:253:b0:3ef:57f8:8433 with SMTP id c19-20020a05622a025300b003ef57f88433mr37348653qtx.4.1683751491524;
        Wed, 10 May 2023 13:44:51 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id fy26-20020a05622a5a1a00b003f0af201a2dsm1668558qtb.81.2023.05.10.13.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:44:51 -0700 (PDT)
Message-ID: <b49e241d3ea8c679b81134e22c908ca64aeca18c.camel@redhat.com>
Subject: Re: [PATCH v4 1/3] cacheinfo: Add arch specific early level
 initializer
From:   Radu Rendec <rrendec@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 10 May 2023 16:44:49 -0400
In-Reply-To: <20230510191207.GA18514@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
         <20230412185759.755408-2-rrendec@redhat.com>
         <20230510191207.GA18514@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-10 at 12:12 -0700, Ricardo Neri wrote:
> On Wed, Apr 12, 2023 at 02:57:57PM -0400, Radu Rendec wrote:
> > This patch gives architecture specific code the ability to initialize
> > the cache level and allocate cacheinfo memory early, when cache level
> > initialization runs on the primary CPU for all possible CPUs.
[cut]
> > -int detect_cache_attributes(unsigned int cpu)
> > +static inline int init_level_allocate_ci(unsigned int cpu)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int early_leaves =
=3D cache_leaves(cpu);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Since early initiali=
zation/allocation of the cacheinfo is allowed
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * via fetch_cache_info=
() and this also gets called as CPU hotplug
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * callbacks via cachei=
nfo_cpu_online, the init/alloc can be skipped
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as it will happen on=
ly once (the cacheinfo memory is never freed).
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Just populate the cachein=
fo.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Just populate the cachein=
fo. However, if the cacheinfo has been
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * allocated early through t=
he arch-specific early_cache_level() call,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * there is a chance the inf=
o is wrong (this can happen on arm64). In
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that case, call init_cach=
e_level() anyway to give the arch-specific
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * code a chance to make thi=
ngs right.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (per_cpu_cacheinfo(cpu))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto populate_leaves;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (per_cpu_cacheinfo(cpu) &=
& !ci_cacheinfo(cpu)->early_ci_levels)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (init_cache_level(cp=
u) || !cache_leaves(cpu))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOENT;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D allocate_cache_info(=
cpu);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Now that we have properly=
 initialized the cache level info, make
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sure we don't try to do t=
hat again the next time we are called
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (e.g. as CPU hotplug call=
backs).
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ci_cacheinfo(cpu)->early_ci_=
levels =3D false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cache_leaves(cpu) <=3D e=
arly_leaves)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return 0;
> > +
>=20
> I had posted a patchset[1] for x86 that initializes
> ci_cacheinfo(cpu)->num_leaves during SMP boot.
>=20
> This means that early_leaves and a late cache_leaves() are equal but
> per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
> fetch_cache_info().
>=20
> I think that we should check here that per_cpu_cacheinfo() has been alloc=
ated to
> take care of the case in which early and late cache leaves remain the sam=
e:
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache_leaves(cpu) <=3D early_le=
aves)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache_leaves(cpu) <=3D early_le=
aves && per_cpu_cacheinfo(cpu))
>=20
> Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
> last_level_cache_is_valid().
>=20
> I can post a patch with this fix if it makes sense.
>=20
> [1]. https://lore.kernel.org/all/20230424001956.21434-3-ricardo.neri-cald=
eron@linux.intel.com/

Hi Ricardo,

Thanks for bringing this to my attention. I need to run some tests on
x86 (I did all that work/testing on arm64) and wrap my head around it.

While I don't see any problem with the fix you're proposing, I'm afraid
it may circle back to the other problem I tried to fix initially. Have
you tested this on an RT kernel by any chance?

I'm thinking that if we end up in init_level_allocate_ci() without the
cacheinfo memory having been allocated earlier, we're up for a "BUG"
splat on RT kernels.

If early_leaves has the right value at that point, the cacheinfo memory
should be allocated early (on the primary CPU), so perhaps there's a
different problem somewhere else.

I'll get back to you as soon as I look at this in more detail but I
just wanted to give you a quick heads-up.

Regards,
Radu

