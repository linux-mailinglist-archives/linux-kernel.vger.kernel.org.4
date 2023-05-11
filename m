Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850386FFAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbjEKT4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKT4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9DFF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683834922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JYVf0yQuvSL/8oOL5wX92puQoC8nO6fQcEm9yPPEp0=;
        b=ZkRq1sLY2n1ei3B5xt7qURBhF4pFlTY4dMInVmd7kwNwoPeTU/sCYUX+qZTsIBDzsPSKAP
        ZgR/RB75hPrKNI7cTjM72ZUex+XBUFcwC5/8FqrKMVIrmkGjl/LUzNDxRry+oC9fHQWQXv
        oTTpRUY2T6kVzUU2QqpuE21U7svo3R0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-iG-68r9ANTGbka4rQlQ0Dg-1; Thu, 11 May 2023 15:55:21 -0400
X-MC-Unique: iG-68r9ANTGbka4rQlQ0Dg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61b5f526a79so123462176d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834920; x=1686426920;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JYVf0yQuvSL/8oOL5wX92puQoC8nO6fQcEm9yPPEp0=;
        b=BFnUVGQNSu4s6MFYGqfVvV5bO+TFgWZfOE0gscu/42yT7BBsSIoLfbs3P0KR82yfXs
         wQHWcuYv3MlQCdnjYparrBeMJ2qx3fuQWYLRdgvey4mUZEfQ8L2F8ALIcjkEnzoTy2/t
         ekqamIeNbPeLvllxUdUfB24E+Okbc5PYITSjlr539DQ0gV2awG/EcCcMhf8GVvgq9OFk
         D9n67CbRruGhOa3kR9GM7x4LIokrf+Dyr3bs9b+oLGfqj6zv5R9vlAQqKpSj1K7KOMbs
         6LckQGplE454XdwwgYSOz6HKBczxrnlrtSgIQ9B9zLKY2b/VrZEHyRwG/UCwcAPu7nKV
         Jg4A==
X-Gm-Message-State: AC+VfDziLotMJcrlL5Yhm+tB/4s/7vcUbbvj+j4C9cHjChSD43r7PCIX
        P04rMXuvJ40NOcHqJXAAKTuhDjGZ/FrZsNG6sB8fdsa9a1iqbQ4N88DC+f+sLLzOgrQnZmqDD4/
        FFg9yGTkeJLG8/J3BggjvE8wz
X-Received: by 2002:a05:6214:2306:b0:5ef:77c4:4540 with SMTP id gc6-20020a056214230600b005ef77c44540mr31094745qvb.27.1683834920631;
        Thu, 11 May 2023 12:55:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LovVsCiLdSusEA7IosAAFmAl0xWyvScUGWNLOBi0Pwvv+5hcU4ycr2Uwuas6gm5WNVlzCQQ==
X-Received: by 2002:a05:6214:2306:b0:5ef:77c4:4540 with SMTP id gc6-20020a056214230600b005ef77c44540mr31094726qvb.27.1683834920365;
        Thu, 11 May 2023 12:55:20 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w18-20020a0cb552000000b006216ff88b27sm299737qvd.79.2023.05.11.12.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:55:19 -0700 (PDT)
Message-ID: <9020807789b70db0d84d142cbfed2bd8868f366a.camel@redhat.com>
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
Date:   Thu, 11 May 2023 15:55:18 -0400
In-Reply-To: <20230511000058.GD18514@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
         <20230412185759.755408-2-rrendec@redhat.com>
         <20230510191207.GA18514@ranerica-svr.sc.intel.com>
         <b49e241d3ea8c679b81134e22c908ca64aeca18c.camel@redhat.com>
         <20230511000058.GD18514@ranerica-svr.sc.intel.com>
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

On Wed, 2023-05-10 at 17:00 -0700, Ricardo Neri wrote:
> On Wed, May 10, 2023 at 04:44:49PM -0400, Radu Rendec wrote:
> > On Wed, 2023-05-10 at 12:12 -0700, Ricardo Neri wrote:
> > > On Wed, Apr 12, 2023 at 02:57:57PM -0400, Radu Rendec wrote:
> > > > This patch gives architecture specific code the ability to initiali=
ze
> > > > the cache level and allocate cacheinfo memory early, when cache lev=
el
> > > > initialization runs on the primary CPU for all possible CPUs.
> > [cut]
> > > > -int detect_cache_attributes(unsigned int cpu)
> > > > +static inline int init_level_allocate_ci(unsigned int cpu)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int early_leave=
s =3D cache_leaves(cpu);
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Since early init=
ialization/allocation of the cacheinfo is allowed
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * via fetch_cache_=
info() and this also gets called as CPU hotplug
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * callbacks via ca=
cheinfo_cpu_online, the init/alloc can be skipped
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as it will happe=
n only once (the cacheinfo memory is never freed).
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Just populate the cac=
heinfo.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Just populate the cac=
heinfo. However, if the cacheinfo has been
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * allocated early throu=
gh the arch-specific early_cache_level() call,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * there is a chance the=
 info is wrong (this can happen on arm64). In
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that case, call init_=
cache_level() anyway to give the arch-specific
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * code a chance to make=
 things right.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (per_cpu_cacheinfo(cp=
u))
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto populate_leaves;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (per_cpu_cacheinfo(cp=
u) && !ci_cacheinfo(cpu)->early_ci_levels)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (init_cache_leve=
l(cpu) || !cache_leaves(cpu))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOENT;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D allocate_cache_i=
nfo(cpu);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Now that we have prop=
erly initialized the cache level info, make
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sure we don't try to =
do that again the next time we are called
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (e.g. as CPU hotplug =
callbacks).
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ci_cacheinfo(cpu)->early=
_ci_levels =3D false;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cache_leaves(cpu) <=
=3D early_leaves)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > +
> > >=20
> > > I had posted a patchset[1] for x86 that initializes
> > > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> > >=20
> > > This means that early_leaves and a late cache_leaves() are equal but
> > > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not us=
e
> > > fetch_cache_info().
> > >=20
> > > I think that we should check here that per_cpu_cacheinfo() has been a=
llocated to
> > > take care of the case in which early and late cache leaves remain the=
 same:
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache_leaves(cpu) <=3D earl=
y_leaves)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache_leaves(cpu) <=3D earl=
y_leaves && per_cpu_cacheinfo(cpu))
> > >=20
> > > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference fro=
m
> > > last_level_cache_is_valid().
> > >=20
> > > I can post a patch with this fix if it makes sense.
> > >=20
> > > [1]. https://lore.kernel.org/all/20230424001956.21434-3-ricardo.neri-=
calderon@linux.intel.com/
> >=20
> > Thanks for bringing this to my attention. I need to run some tests on
> > x86 (I did all that work/testing on arm64) and wrap my head around it.
> >=20
> > While I don't see any problem with the fix you're proposing, I'm afraid
> > it may circle back to the other problem I tried to fix initially. Have
> > you tested this on an RT kernel by any chance?
>=20
> That is a good point. I did not test on an RT kernel. I'll try that.

It looks like the flow is much simpler on x86: detect_cache_attributes()
is called only once for each CPU, and it's called in kthread context.

I haven't tested on an RT kernel but I think it should be fine. I put a
msleep() there and saw no issues, which means kmalloc() on RT should be
fine as well.

> > I'm thinking that if we end up in init_level_allocate_ci() without the
> > cacheinfo memory having been allocated earlier, we're up for a "BUG"
> > splat on RT kernels.
> >=20
> > If early_leaves has the right value at that point, the cacheinfo memory
> > should be allocated early (on the primary CPU), so perhaps there's a
> > different problem somewhere else.
>=20
> That can work for x86, IMO. Not sure about other archs. As you mention,
> other archs still want the chance to correct the early cache info.

You're right. I got confused for a moment because I was used to the
arm64 flow. On x86, there is no "early" cache info per se because, as I
already mentioned, detect_cache_attributes() is called only once for
each CPU.

I was intrigued about how this worked without your changes, and I
looked closer. Between the initialization of the early_leaves variable
at the beginning of init_level_allocate_ci() and the comparison of
cache_leaves(cpu) and early_leaves, init_cache_level() gets called.
Before your changes, (struct cpu_cacheinfo).num_leaves was initialized
to 0 and then changed in init_cache_level(). That way, early_leaves
ended up as 0, which made the comparison evaluate to false.

At this point I think the patch you proposed is the right way to fix
this. I don't see any reason why it would interfere with other archs
that really use early allocation. This new patch should probably be
added to your series, since otherwise your other patches would
basically "introduce" a null-pointer deref.

My only suggestion would be to add a short comment before the
comparison, to explain that on x86 detect_cache_attributes() is called
only once for each CPU and so early allocation is not possible but
(struct cpu_cacheinfo).num_leaves is already initialized by the time
detect_cache_attributes() is called.

Regards,
Radu

