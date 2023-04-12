Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E776DF75B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDLNhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551071703
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681306583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ewXy379Ae29fQc/OJYG3QVSYdaG46iuKGeWsmru53A=;
        b=U+syPHqQ4QIl1735h+1kBN77nMAgk7l4pJgHv2+9WC6sN2RR/BTSDZpGG4iPxGyTN1nVNn
        GapgtaPJ3UINTIphtBxmtNH0PofOgYDn4IwEHAenVZNyilTfPuV1q+he95cPDF7hVhFemD
        Zg3oBgzOmSIcCxIoliDSmnZOlB51hOo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-UhsBAvYFNDmYRysHut8OmQ-1; Wed, 12 Apr 2023 09:36:22 -0400
X-MC-Unique: UhsBAvYFNDmYRysHut8OmQ-1
Received: by mail-qt1-f200.google.com with SMTP id x9-20020ac85f09000000b003e4ecb5f613so2994794qta.21
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681306582; x=1683898582;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ewXy379Ae29fQc/OJYG3QVSYdaG46iuKGeWsmru53A=;
        b=Cz4PtZjnHTukwE/Frx0v6c7gIY7dUknJOBm6s6S2BrFktIVqx4i0KYleG13pyQJ5RT
         QJMUav8hZBkfSoNJB7CYch1jvOu0RmGfWaO9QRgL3fc49KnFkpzxbv5RmgkYJnhDjk7/
         WtP20v2HRHqZFy+fEs2YWgel/1ULqvsVwgVWlkV9JmvfuyZdXOqZkNOhpZIWLtfNJ1Rs
         HFl6F6kwOqaA1KpzYt0aZ2sNXFyQWSyrqmVeQ2rX8reQBiBCtqO64SCF0jZ8kgcSUNlH
         SI7hC3Ycf3Z8Q8nJ0n+zdMaCQ3UMsCmGvSeUSD+Mo2BmV1Rw2kltcH2y+aD5lwwIonSU
         GOsA==
X-Gm-Message-State: AAQBX9fGZZX+Q8nUfTwrhKD7pZB/3V2iCfc+fYwx+DBsreLSsWeakDrS
        rvXjTemQVKGlV2YGAXJ10bQ+cVxgyY9i/zY7WvBdhUGLFrz4pA9r7yWNcgO6HO0STljbCAX7AJE
        TNaDnr2IGGx755fyHXAqnynYY
X-Received: by 2002:ac8:5c05:0:b0:3e4:f002:2b6e with SMTP id i5-20020ac85c05000000b003e4f0022b6emr28307300qti.32.1681306582010;
        Wed, 12 Apr 2023 06:36:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350YyZakv16OmdCaib4fyStvbl02JokYTyFrIjcpCov1kK+TXwjvTomfRXeP9cHOs285MySvRIA==
X-Received: by 2002:ac8:5c05:0:b0:3e4:f002:2b6e with SMTP id i5-20020ac85c05000000b003e4f0022b6emr28307277qti.32.1681306581718;
        Wed, 12 Apr 2023 06:36:21 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w25-20020ac843d9000000b003e693d92781sm3263730qtn.70.2023.04.12.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:36:21 -0700 (PDT)
Message-ID: <e0ee22ee5a60f45b39fe420c517db68cb83b850d.camel@redhat.com>
Subject: Re: [PATCH v3 2/2] cacheinfo: Add arm64 early level initializer
 implementation
From:   Radu Rendec <rrendec@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 12 Apr 2023 09:36:19 -0400
In-Reply-To: <20230412114011.4gexyfnl6hu236kp@bogus>
References: <20230406233926.1670094-1-rrendec@redhat.com>
         <20230406233926.1670094-3-rrendec@redhat.com>
         <20230412114011.4gexyfnl6hu236kp@bogus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-12 at 12:40 +0100, Sudeep Holla wrote:
> On Thu, Apr 06, 2023 at 07:39:26PM -0400, Radu Rendec wrote:
> > This patch adds an architecture specific early cache level detection
> > handler for arm64. This is basically the CLIDR_EL1 based detection that
> > was previously done (only) in init_cache_level().
> >=20
> > This is part of a patch series that attempts to further the work in
> > commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")=
.
> > Previously, in the absence of any DT/ACPI cache info, architecture
> > specific cache detection and info allocation for secondary CPUs would
> > happen in non-preemptible context during early CPU initialization and
> > trigger a "BUG: sleeping function called from invalid context" splat on
> > an RT kernel.
> >=20
> > This patch does not solve the problem completely for RT kernels. It
> > relies on the assumption that on most systems, the CPUs are symmetrical
> > and therefore have the same number of cache leaves. The cacheinfo memor=
y
> > is allocated early (on the primary CPU), relying on the new handler. If
> > later (when CLIDR_EL1 based detection runs again on the secondary CPU)
> > the initial assumption proves to be wrong and the CPU has in fact more
> > leaves, the cacheinfo memory is reallocated, and that still triggers a
> > splat on an RT kernel.
> >=20
> > In other words, asymmetrical CPU systems *must* still provide cacheinfo
> > data in DT/ACPI to avoid the splat on RT kernels (unless secondary CPUs
> > happen to have less leaves than the primary CPU). But symmetrical CPU
> > systems (the majority) can now get away without the additional DT/ACPI
> > data and rely on CLIDR_EL1 based detection.
> >=20
> > Signed-off-by: Radu Rendec <rrendec@redhat.com>
> > ---
> > =C2=A0arch/arm64/kernel/cacheinfo.c | 32 ++++++++++++++++++++++++------=
--
> > =C2=A01 file changed, 24 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinf=
o.c
> > index c307f69e9b55..520d17e4ebe9 100644
> > --- a/arch/arm64/kernel/cacheinfo.c
> > +++ b/arch/arm64/kernel/cacheinfo.c
> > @@ -38,21 +38,37 @@ static void ci_leaf_init(struct cacheinfo *this_lea=
f,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0this_leaf->type =3D typ=
e;
> > =C2=A0}
> > =C2=A0
> > -int init_cache_level(unsigned int cpu)
> > +static void detect_cache_level(unsigned int *level, unsigned int *leav=
es)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int ctype, level, l=
eaves;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int fw_level, ret;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cpu_cacheinfo *this_c=
pu_ci =3D get_cpu_cacheinfo(cpu);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int ctype;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (level =3D 1, leaves =3D=
 0; level <=3D MAX_CACHE_LEVEL; level++) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ctype =3D get_cache_type(level);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (*level =3D 1, *leaves =
=3D 0; *level <=3D MAX_CACHE_LEVEL; (*level)++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ctype =3D get_cache_type(*level);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ctype =3D=3D CACHE_TYPE_NOCACHE) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0level-=
-;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(*leve=
l)--;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
break;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Separate instruction and data caches */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0leaves +=3D (ctype =3D=3D CACHE_TYPE_SEPARATE) ? 2 : 1=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0*leaves +=3D (ctype =3D=3D CACHE_TYPE_SEPARATE) ? 2 : =
1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +}
>=20
> I prefer to use locals and assign the value to keep it simple/easy to fol=
low.
> Compiler can/will optimise this anyway. But I am fine either way.

To be honest, I was on the fence about this and decided to go with the
pointers, but now that you brought it up, I changed my mind :)

If I keep the original names for the locals and use something else for
the arguments, the patch will look cleaner and it will be obvious for
anyone looking at it that the algorithm for counting the levels/leaves
is unchanged.

Best regards,
Radu

> I need Will's(or Catalin's)=C2=A0 ack if I have to take the changes via
> Greg's tree.
>=20

