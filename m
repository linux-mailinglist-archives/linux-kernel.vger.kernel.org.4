Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5B5F803C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJGVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGVnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D411C6EB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665178986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G87IKnTFlRlP5ZA/YM0aUFdTmppoFiXpaMJaSdjq7DA=;
        b=R9YpyDXgKO0uyYFSK896e9TTvTFXAap/SIXcJwBuGm/jx9xfFx7XnychZeGzCV7cgddM9g
        vkW85k/G6dYsYlK4ImqgJSShnmXQdowRTRhJn1e8hb4at6UapTv9Z+UbkwsDobXFh+tPYC
        Zze645NZVCP3lC6HMuSJITew/xAtTMc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-yBi09M3KP623ifsK0am8BA-1; Fri, 07 Oct 2022 17:43:04 -0400
X-MC-Unique: yBi09M3KP623ifsK0am8BA-1
Received: by mail-oo1-f70.google.com with SMTP id u27-20020a4a6c5b000000b0047f91b7b4bfso3101315oof.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 14:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G87IKnTFlRlP5ZA/YM0aUFdTmppoFiXpaMJaSdjq7DA=;
        b=HbaG0PNsXB+w+Lt2S80Ju9I/nG2SsLzUHiRBW0NWvnmRErpAie4AwsbphggUbWhSv9
         s+uL7iqfDGMEwCGFNkWiLHNHeMQA1ezXOsi3PAWNeaP5R0uO0IdMq/Lla33qrLC9uWya
         Fe+5KLHedWFTHEdQNhGAYII/0VgFlmNZAfa4d1O39pGyEZJNyfrwREN0RgLQnBefTHdV
         hzPnEBjEpanABjs9a4gH04XtqbJxHOsNVwKt383zyHOOC8XtcEYfrWq3JtW82gaBsM8E
         wJ36hpP3hIWgkH+7q+djjl64gI/Gcp0NAl+HGkABxpf7mZnpqaCZDuVHdmiENDgOogDv
         4vSg==
X-Gm-Message-State: ACrzQf3S71XXw6gIP5/Y+/Li4qAQha1Xvhnq8blc5tQURl9yE0woYkiX
        oL6ViZtQhwTOa9VnexDSHlw5WWYgvboswSh9rYq261hxuORPSTlMt5t6t96jhrQqUi9g7wZwFlT
        wfZtQSG/EqorlQIcbXP2NBuA6
X-Received: by 2002:a05:6870:9107:b0:132:b47e:2c76 with SMTP id o7-20020a056870910700b00132b47e2c76mr9271731oae.203.1665178982294;
        Fri, 07 Oct 2022 14:43:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7T1AloyETxY3BAZyZfMe6U/mXW2p2VpMBIVV621kKpq04eX/S6hmYsylQdmGFWsqrPrhuWaQ==
X-Received: by 2002:a05:6870:9107:b0:132:b47e:2c76 with SMTP id o7-20020a056870910700b00132b47e2c76mr9271682oae.203.1665178980604;
        Fri, 07 Oct 2022 14:43:00 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a801:9473:d360:c737:7c9c:d52b? ([2804:1b3:a801:9473:d360:c737:7c9c:d52b])
        by smtp.gmail.com with ESMTPSA id f13-20020a056830204d00b006594674d4ddsm1768654otp.44.2022.10.07.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 14:43:00 -0700 (PDT)
Message-ID: <b23b08274ccff99fb341ea272e968f72c2e289ce.camel@redhat.com>
Subject: Re: [PATCH v1 1/1] crypto/pcrypt: Do not use isolated CPUs for
 callback
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 18:42:57 -0300
In-Reply-To: <Yz1/TVUV+KnLvodg@fuller.cnet>
References: <20221004062536.280712-1-leobras@redhat.com>
         <Yz1/TVUV+KnLvodg@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-05 at 09:57 -0300, Marcelo Tosatti wrote:
> On Tue, Oct 04, 2022 at 03:25:37AM -0300, Leonardo Bras wrote:
> > Currently pcrypt_aead_init_tfm() will pick callback cpus (ctx->cb_cpu)
> > from any online cpus. Later padata_reorder() will queue_work_on() the
> > chosen cb_cpu.
> >=20
> > This is undesired if the chosen cb_cpu is listed as isolated (i.e. usin=
g
> > isolcpus=3D... kernel parameter), since the work queued will interfere =
with
> > the workload on the isolated cpu.
> >=20
> > Make sure isolated cpus are not used for pcrypt.
> >=20
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  crypto/pcrypt.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> > index 9d10b846ccf73..9017d08c91a8d 100644
> > --- a/crypto/pcrypt.c
> > +++ b/crypto/pcrypt.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kobject.h>
> >  #include <linux/cpu.h>
> >  #include <crypto/pcrypt.h>
> > +#include <linux/sched/isolation.h>
> > =20
> >  static struct padata_instance *pencrypt;
> >  static struct padata_instance *pdecrypt;
> > @@ -175,13 +176,16 @@ static int pcrypt_aead_init_tfm(struct crypto_aea=
d *tfm)
> >  	struct pcrypt_instance_ctx *ictx =3D aead_instance_ctx(inst);
> >  	struct pcrypt_aead_ctx *ctx =3D crypto_aead_ctx(tfm);
> >  	struct crypto_aead *cipher;
> > +	struct cpumask non_isolated;
> > +
> > +	cpumask_and(&non_isolated, cpu_online_mask, housekeeping_cpumask(HK_T=
YPE_DOMAIN));
>=20
> Since certain systems do not use isolcpus=3Ddomain, so please use a flag
> that is setup by nohz_full=3D, for example HK_FLAG_MISC:
>=20
> static int __init housekeeping_nohz_full_setup(char *str)
> {
>         unsigned long flags;
>=20
>         flags =3D HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU=
 |
>                 HK_FLAG_MISC | HK_FLAG_KTHREAD;
>=20
>         return housekeeping_setup(str, flags);
> }
> __setup("nohz_full=3D", housekeeping_nohz_full_setup);

Oh, sure.=C2=A0
Since we are talking about WorkQueues, I think it makes sense to pick
HK_FLAG_WQ.=20

>=20
> Also, shouldnt you use cpumask_t ?/

Yeah, I think so.=C2=A0
I was quick to choose the 'struct cpumask' because all functions would oper=
ate
in this variable type, but yeah, I think it makes sense to have this variab=
le
being opaque here.

>=20
> Looks good otherwise.
>=20
> Thanks!

Thank you for reviewing!=20

Leo

>=20
>=20
> > =20
> >  	cpu_index =3D (unsigned int)atomic_inc_return(&ictx->tfm_count) %
> > -		    cpumask_weight(cpu_online_mask);
> > +		    cpumask_weight(&non_isolated);
> > =20
> > -	ctx->cb_cpu =3D cpumask_first(cpu_online_mask);
> > +	ctx->cb_cpu =3D cpumask_first(&non_isolated);
> >  	for (cpu =3D 0; cpu < cpu_index; cpu++)
> > -		ctx->cb_cpu =3D cpumask_next(ctx->cb_cpu, cpu_online_mask);
> > +		ctx->cb_cpu =3D cpumask_next(ctx->cb_cpu, &non_isolated);
> > =20
> >  	cipher =3D crypto_spawn_aead(&ictx->spawn);
> > =20
> > --=20
> > 2.37.3
> >=20
> >=20
>=20

