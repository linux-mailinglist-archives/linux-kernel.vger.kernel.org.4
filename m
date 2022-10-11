Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA55FBA30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJKSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJKSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A940BFB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665512446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OTQRN3juAPW8yoc48eb9FvOlYwsRSyxzmGbpR/0Igk=;
        b=MfsPePtvtZoPY5Ojs5hsZM+R+2D+T8BmA1FadvgH1wewtR+tMIH3/gvCSnLyQfitMPUY9d
        7NsKkEpddn6/h9kXw2d9P2s+lHaBTKIM4O8x7xlPD5SzWJImKb9JLBth/IrAF4AOUtYIYT
        i316zcgAJsYZqD+XVHexu7uIq1jlIpw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-CDNdcKfdMhawgBDy1pViZw-1; Tue, 11 Oct 2022 14:20:44 -0400
X-MC-Unique: CDNdcKfdMhawgBDy1pViZw-1
Received: by mail-oi1-f199.google.com with SMTP id o12-20020a056808124c00b00353f308fb4bso8326565oiv.22
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OTQRN3juAPW8yoc48eb9FvOlYwsRSyxzmGbpR/0Igk=;
        b=feGjaOmSOOSrs3aixEuQCpQvwTYxxQju6jQdnhfQqXvjMt7pGmVwNrBld3ckOH4++d
         su0IFOav5ko2mbijOMknf3kgVB19HFl9vEW7yAfYeq7LQjRQdykVpjZ2UukeXmZsfM4x
         ITsoR5U+GSmDunqf6RQ1D3zzJGEAU7Bz4hAcotCN4Q5E2jpqVYCYpOmWcYih5GHTzc7O
         WwenuHzKL+Ce8IXl8jsOC1iFR+cs4TS8gN4WrVnXk5gbjzum3FkffJ/gSy5i3F0JzJIf
         R4odNzrV++TXIfloCHZ1ZxM+CDtAuWzocaye8FW1SCGpib9em6UeXSbI2WOPjZjQnUQb
         wTyA==
X-Gm-Message-State: ACrzQf0f7FFH18HRpFGUPgSCMwdxILtqI9F527b5i6sP+pEdAJ5ecGdt
        fyhmpLBTXOk/mqHkVsTgtK6utA7lkAYxV1c89o7qrbECH5jSY4tGyZS1t0CMAuz3Q1ere0MGS8X
        9cu1lG0zO0ptRhPBbJkFhI9bO
X-Received: by 2002:a05:6870:15d4:b0:12b:8d8d:1001 with SMTP id k20-20020a05687015d400b0012b8d8d1001mr284818oad.137.1665512443596;
        Tue, 11 Oct 2022 11:20:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4YkT+TbXMLE0XB+SAOjd79C2564H5qmOYCwIn4lHaeaWlTipoc33/Rvo3NUpdBjRdA4Em3Qw==
X-Received: by 2002:a05:6870:15d4:b0:12b:8d8d:1001 with SMTP id k20-20020a05687015d400b0012b8d8d1001mr284809oad.137.1665512443355;
        Tue, 11 Oct 2022 11:20:43 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a801:9473:d360:c737:7c9c:d52b? ([2804:1b3:a801:9473:d360:c737:7c9c:d52b])
        by smtp.gmail.com with ESMTPSA id k16-20020a0568080e9000b003549db40f38sm1878229oil.46.2022.10.11.11.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:20:42 -0700 (PDT)
Message-ID: <3d6d47035f8897542a4786eef5a6b8885f4caaf0.camel@redhat.com>
Subject: Re: [PATCH v1 1/1] crypto/pcrypt: Do not use isolated CPUs for
 callback
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Oct 2022 15:20:39 -0300
In-Reply-To: <b23b08274ccff99fb341ea272e968f72c2e289ce.camel@redhat.com>
References: <20221004062536.280712-1-leobras@redhat.com>
         <Yz1/TVUV+KnLvodg@fuller.cnet>
         <b23b08274ccff99fb341ea272e968f72c2e289ce.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-07 at 18:42 -0300, Leonardo Br=C3=A1s wrote:
> On Wed, 2022-10-05 at 09:57 -0300, Marcelo Tosatti wrote:
> > On Tue, Oct 04, 2022 at 03:25:37AM -0300, Leonardo Bras wrote:
> > > Currently pcrypt_aead_init_tfm() will pick callback cpus (ctx->cb_cpu=
)
> > > from any online cpus. Later padata_reorder() will queue_work_on() the
> > > chosen cb_cpu.
> > >=20
> > > This is undesired if the chosen cb_cpu is listed as isolated (i.e. us=
ing
> > > isolcpus=3D... kernel parameter), since the work queued will interfer=
e with
> > > the workload on the isolated cpu.
> > >=20
> > > Make sure isolated cpus are not used for pcrypt.
> > >=20
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > ---
> > >  crypto/pcrypt.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> > > index 9d10b846ccf73..9017d08c91a8d 100644
> > > --- a/crypto/pcrypt.c
> > > +++ b/crypto/pcrypt.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/kobject.h>
> > >  #include <linux/cpu.h>
> > >  #include <crypto/pcrypt.h>
> > > +#include <linux/sched/isolation.h>
> > > =20
> > >  static struct padata_instance *pencrypt;
> > >  static struct padata_instance *pdecrypt;
> > > @@ -175,13 +176,16 @@ static int pcrypt_aead_init_tfm(struct crypto_a=
ead *tfm)
> > >  	struct pcrypt_instance_ctx *ictx =3D aead_instance_ctx(inst);
> > >  	struct pcrypt_aead_ctx *ctx =3D crypto_aead_ctx(tfm);
> > >  	struct crypto_aead *cipher;
> > > +	struct cpumask non_isolated;
> > > +
> > > +	cpumask_and(&non_isolated, cpu_online_mask, housekeeping_cpumask(HK=
_TYPE_DOMAIN));
> >=20
> > Since certain systems do not use isolcpus=3Ddomain, so please use a fla=
g
> > that is setup by nohz_full=3D, for example HK_FLAG_MISC:
> >=20
> > static int __init housekeeping_nohz_full_setup(char *str)
> > {
> >         unsigned long flags;
> >=20
> >         flags =3D HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_R=
CU |
> >                 HK_FLAG_MISC | HK_FLAG_KTHREAD;
> >=20
> >         return housekeeping_setup(str, flags);
> > }
> > __setup("nohz_full=3D", housekeeping_nohz_full_setup);
>=20
> Oh, sure.=C2=A0
> Since we are talking about WorkQueues, I think it makes sense to pick
> HK_FLAG_WQ.=20
>=20
> >=20
> > Also, shouldnt you use cpumask_t ?/
>=20
> Yeah, I think so.=C2=A0
> I was quick to choose the 'struct cpumask' because all functions would op=
erate
> in this variable type, but yeah, I think it makes sense to have this vari=
able
> being opaque here.

In fact, it seems neither 'struct cpumask' nor 'cpumask_t' are recommended =
to be
used allocated in the stack, due to the large size it can get (up to 1kB).=
=C2=A0

At include/linux/cpumask.h we have:
'cpumask_var_t: struct cpumask for stack usage'
which should work better at least for init functions like this.

In other cases, I see 'static cpumask_t' being used to avoid the allocation
overhead, but it's probably due to the functions being called in very speci=
fic
scenarios. It could mean trouble if multiple cpus try to use it at once.

What do you recommend on it?

Best regards,
Leo

>=20
> >=20
> > Looks good otherwise.
> >=20
> > Thanks!
>=20
> Thank you for reviewing!=20
>=20
> Leo
>=20
> >=20
> >=20
> > > =20
> > >  	cpu_index =3D (unsigned int)atomic_inc_return(&ictx->tfm_count) %
> > > -		    cpumask_weight(cpu_online_mask);
> > > +		    cpumask_weight(&non_isolated);
> > > =20
> > > -	ctx->cb_cpu =3D cpumask_first(cpu_online_mask);
> > > +	ctx->cb_cpu =3D cpumask_first(&non_isolated);
> > >  	for (cpu =3D 0; cpu < cpu_index; cpu++)
> > > -		ctx->cb_cpu =3D cpumask_next(ctx->cb_cpu, cpu_online_mask);
> > > +		ctx->cb_cpu =3D cpumask_next(ctx->cb_cpu, &non_isolated);
> > > =20
> > >  	cipher =3D crypto_spawn_aead(&ictx->spawn);
> > > =20
> > > --=20
> > > 2.37.3
> > >=20
> > >=20
> >=20
>=20

