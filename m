Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3131D70A2A0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjESWCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjESWCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EFC125
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684533726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Fz8oD8SeEi0X0FetXkpDXCUncDXsExXWOBUZVu30QA=;
        b=IfU8RJtogPJ5w8X2qHYTQ/i93afKb5azZpjY69XEsC2u3cOH5YOO4mXj4sn+P8n6JDFLWi
        KZsEGmABUEZtk3H1kx3cSMeGAyy2P4ozh/AhAcYOwTCxLlSzOADREvLDLreDlrTohA5lTI
        QHdS8pxngyYVE7sWGtAYxxdrmthgqMc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-vP_iopFnNPSM4QzMo_0Lyw-1; Fri, 19 May 2023 18:02:05 -0400
X-MC-Unique: vP_iopFnNPSM4QzMo_0Lyw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6239a184651so13324886d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684533724; x=1687125724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Fz8oD8SeEi0X0FetXkpDXCUncDXsExXWOBUZVu30QA=;
        b=YohZNesuoKeiCu+m3tbtsbCrp4u6/TZh8Hhh8Vcg6p+UzTMQlir+nq0y7nV5zyTEE6
         Fyng00qCUj3WOxq+89kLnNZhCpTjtaqMZgLdhJkiVQoa2bLVr2xtVKWfCx8OkGycS8r/
         eOq5rlGGuVZJZLgl1/EQxYYbox5wQahXgmuB5X7gJ7Mfh3kZznuNefwIwmQ8ggGJ5XYg
         8FEaDNh7SkWEdusztbN1FSOAHS6YLHKvxoFh/gd3ShhNmHwkA8b1Wb71DLBhr8H7J9H+
         Dkl5IPWr0zML3J6Vra462+woABoINunVVnDLOQYnAGUzQR7s6t6t8G0h4mTXcxzvzuBc
         oGsA==
X-Gm-Message-State: AC+VfDyocf2Xr64stJck6Rtb2eT8it4zQ1nZd3GjqkbqSLAkROJPQUZR
        G+K/zVxNBh8a4dZDU5ci+cxM9zpVJpXssflaMhNTn1bHCCP/WQBEXq5mcPA14JsCyBiEQdn0wLv
        nrbIoAJ6EYTC+2n9YaUt+p9SH4vysAiHa
X-Received: by 2002:a05:622a:354:b0:3f5:4292:4ce8 with SMTP id r20-20020a05622a035400b003f542924ce8mr5295819qtw.8.1684533724175;
        Fri, 19 May 2023 15:02:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Mt53H4iQwzI1D2lNsu2LLMAIoLcw8qn589H2uxtmd69AEaI+GNRnNJfxUNZFRD08CfKnRPg==
X-Received: by 2002:a05:622a:354:b0:3f5:4292:4ce8 with SMTP id r20-20020a05622a035400b003f542924ce8mr5295791qtw.8.1684533723908;
        Fri, 19 May 2023 15:02:03 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w19-20020ac843d3000000b003f4fa14decbsm159980qtn.52.2023.05.19.15.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:02:03 -0700 (PDT)
Message-ID: <d3a8ecce64a35c13dd60d942f2c4762e99775aef.camel@redhat.com>
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
Date:   Fri, 19 May 2023 18:02:02 -0400
In-Reply-To: <20230519214430.GA3116@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
         <20230412185759.755408-2-rrendec@redhat.com>
         <20230510191207.GA18514@ranerica-svr.sc.intel.com>
         <b49e241d3ea8c679b81134e22c908ca64aeca18c.camel@redhat.com>
         <20230511000058.GD18514@ranerica-svr.sc.intel.com>
         <9020807789b70db0d84d142cbfed2bd8868f366a.camel@redhat.com>
         <20230519214430.GA3116@ranerica-svr.sc.intel.com>
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

Hi Ricardo,

On Fri, 2023-05-19 at 14:44 -0700, Ricardo Neri wrote:
> On Thu, May 11, 2023 at 03:55:18PM -0400, Radu Rendec wrote:
> > On Wed, 2023-05-10 at 17:00 -0700, Ricardo Neri wrote:
> > > On Wed, May 10, 2023 at 04:44:49PM -0400, Radu Rendec wrote:
> > > > On Wed, 2023-05-10 at 12:12 -0700, Ricardo Neri wrote:
> > > > > On Wed, Apr 12, 2023 at 02:57:57PM -0400, Radu Rendec wrote:
> > > > > > This patch gives architecture specific code the ability to init=
ialize
> > > > > > the cache level and allocate cacheinfo memory early, when cache=
 level
> > > > > > initialization runs on the primary CPU for all possible CPUs.
> > > > [cut]
> > > > > > -int detect_cache_attributes(unsigned int cpu)
> > > > > > +static inline int init_level_allocate_ci(unsigned int cpu)
> > > > > > =C2=A0{
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int early_l=
eaves =3D cache_leaves(cpu);
> > > > > > =C2=A0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Since early =
initialization/allocation of the cacheinfo is allowed
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * via fetch_ca=
che_info() and this also gets called as CPU hotplug
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * callbacks vi=
a cacheinfo_cpu_online, the init/alloc can be skipped
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as it will h=
appen only once (the cacheinfo memory is never freed).
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Just populate the=
 cacheinfo.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Just populate the=
 cacheinfo. However, if the cacheinfo has been
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * allocated early t=
hrough the arch-specific early_cache_level() call,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * there is a chance=
 the info is wrong (this can happen on arm64). In
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that case, call i=
nit_cache_level() anyway to give the arch-specific
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * code a chance to =
make things right.
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (per_cpu_cacheinf=
o(cpu))
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto populate_leaves;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (per_cpu_cacheinf=
o(cpu) && !ci_cacheinfo(cpu)->early_ci_levels)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > > =C2=A0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (init_cache_=
level(cpu) || !cache_leaves(cpu))
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOENT;
> > > > > > =C2=A0
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D allocate_cac=
he_info(cpu);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Now that we have =
properly initialized the cache level info, make
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sure we don't try=
 to do that again the next time we are called
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (e.g. as CPU hotp=
lug callbacks).
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ci_cacheinfo(cpu)->e=
arly_ci_levels =3D false;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cache_leaves(cpu=
) <=3D early_leaves)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > > +
> > > > >=20
> > > > > I had posted a patchset[1] for x86 that initializes
> > > > > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> > > > >=20
> > > > > This means that early_leaves and a late cache_leaves() are equal =
but
> > > > > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does no=
t use
> > > > > fetch_cache_info().
> > > > >=20
> > > > > I think that we should check here that per_cpu_cacheinfo() has be=
en allocated to
> > > > > take care of the case in which early and late cache leaves remain=
 the same:
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache_leaves(cpu) <=3D =
early_leaves)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache_leaves(cpu) <=3D =
early_leaves && per_cpu_cacheinfo(cpu))
> > > > >=20
> > > > > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference=
 from
> > > > > last_level_cache_is_valid().
> > > > >=20
> > > > > I can post a patch with this fix if it makes sense.
> > > > >=20
> > > > > [1]. https://lore.kernel.org/all/20230424001956.21434-3-ricardo.n=
eri-calderon@linux.intel.com/
> > > >=20
> > > > Thanks for bringing this to my attention. I need to run some tests =
on
> > > > x86 (I did all that work/testing on arm64) and wrap my head around =
it.
> > > >=20
> > > > While I don't see any problem with the fix you're proposing, I'm af=
raid
> > > > it may circle back to the other problem I tried to fix initially. H=
ave
> > > > you tested this on an RT kernel by any chance?
> > >=20
> > > That is a good point. I did not test on an RT kernel. I'll try that.
> >=20
> > It looks like the flow is much simpler on x86: detect_cache_attributes(=
)
> > is called only once for each CPU, and it's called in kthread context.
> >=20
> > I haven't tested on an RT kernel but I think it should be fine. I put a
> > msleep() there and saw no issues, which means kmalloc() on RT should be
> > fine as well.
>=20
> I booted the realtime kernel [3] with CONFIG_PREEMPT_RT and did not obser=
ve
> the BUG splat. I tried before your patchset. Were you able to reproduce o=
n
> x86? Also, I was not able to reproduce the BUG splat after your changes +
> [1] + my earlier suggested patch in this thread.

Thanks for trying this out. I think the BUG splat cannot be reproduced
on x86, either with or without my fix because detect_cache_attributes()
is always called in kthread context, and that makes kmalloc() happy on
RT kernels.

At the time when I first asked you about the RT kernel, I hadn't looked
closely at the x86 code yet, and I was unaware of the (much simpler)
flow and the kthread context. Sorry for the confusion!

In any case, your test on the RT kernel validates the conclusion that
we already came to, and eliminates any trace of doubt. FWIW, I was
testing on arm64 when I found the bug and created the fix. Things are
much more complicated there, and detect_cache_attributes() is called
twice for each CPU (the second time with preemption disabled).

Best regards,
Radu

