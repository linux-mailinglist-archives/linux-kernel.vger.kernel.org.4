Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54A61575A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKBCLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKBCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291CC1DA58
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667355011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKtiJAznjl4o7tzKpvXz+33cgiY1FnbaLSS2bZTJyzw=;
        b=fxMlFBtO4SkYB72/XJ3rV92WgJykKZ48CysemJZx8tRMC/HsjOheZy7sDg7DbA4iGZWfSQ
        tf/oe2/48CO8HbvNxRLhah3FFX4EBBltrmETkgSg9RGZvgpoqJ7dihRBZAbRnsXwy1LR8/
        xvXJEQKVTi0QMj1DJ3vGv6e/XtNFp9s=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-Gw5TEJH_NbG3AwfkIEdzCQ-1; Tue, 01 Nov 2022 22:10:10 -0400
X-MC-Unique: Gw5TEJH_NbG3AwfkIEdzCQ-1
Received: by mail-yb1-f199.google.com with SMTP id 129-20020a250087000000b006ca5c621bacso14791656yba.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKtiJAznjl4o7tzKpvXz+33cgiY1FnbaLSS2bZTJyzw=;
        b=p1r1muqtyFQyUn0HL7jeqIAe9EECr+A8P+wJSJtr6qfDTG3hsrhztzumOazNnXlVwf
         xrkH3aeqSbGbdsWnAub41yqeR5ixejL0363LkDWVy3L9uyYK8GtJ+DFa5LaHrkhmaY0N
         47PvNsp9E1HCsAh4q1LQtW0n5JTtDrBVpcJ+zMuJ7QKvXRpCOCWISxcdZBVbTVVpVa4z
         c+1843aOoEfLJRDDBRTktDF7LudxCggkSBuhLBQaKgvSkVEEyzUqKxQ8utUQCi1wF4pr
         mUbr6e9oHjyALIm/pJ3ZkgQNd4JRvypw/aNdGFSgY4QbhRa3yZg/9uxxvf5QjsZItImk
         Opfg==
X-Gm-Message-State: ACrzQf1MZTKQpXi5iBbLr8XrxiDPSzG9gjW19uyAe4B3kuL0aALm0E7t
        3xAXqms4wfF6v9I81r076dvwVoNy+a0k4CAsNHjIkhF9bEp/WT4CGd8wKx4eE4e+ZftLmvD/oIG
        oV148f7nyzW5vSy8SyltFV/T4SnpBDX4A/Ln1XhEN
X-Received: by 2002:a25:606:0:b0:6cc:8667:75ec with SMTP id 6-20020a250606000000b006cc866775ecmr13652759ybg.268.1667355009509;
        Tue, 01 Nov 2022 19:10:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM73ykhN4g5SK97bzLZnQyCGja6CdJI4IqdqvI/6omJoTDlnfs2LfIHf4QnlA3lnPocfKx8f2qL54ZlwbgyHqX0=
X-Received: by 2002:a25:606:0:b0:6cc:8667:75ec with SMTP id
 6-20020a250606000000b006cc866775ecmr13652754ybg.268.1667355009284; Tue, 01
 Nov 2022 19:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221004062536.280712-1-leobras@redhat.com> <Yz1/TVUV+KnLvodg@fuller.cnet>
 <b23b08274ccff99fb341ea272e968f72c2e289ce.camel@redhat.com>
 <3d6d47035f8897542a4786eef5a6b8885f4caaf0.camel@redhat.com> <Y2FY8fOVsYCXmg+8@fuller.cnet>
In-Reply-To: <Y2FY8fOVsYCXmg+8@fuller.cnet>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Tue, 1 Nov 2022 23:09:58 -0300
Message-ID: <CAJ6HWG4FsGcgujRAL6ejD7GzNB_af5+dp-v2iV8Wm4y+dFrmrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] crypto/pcrypt: Do not use isolated CPUs for callback
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 2:42 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Tue, Oct 11, 2022 at 03:20:39PM -0300, Leonardo Br=C3=A1s wrote:
> > On Fri, 2022-10-07 at 18:42 -0300, Leonardo Br=C3=A1s wrote:
> > > On Wed, 2022-10-05 at 09:57 -0300, Marcelo Tosatti wrote:
> > > > On Tue, Oct 04, 2022 at 03:25:37AM -0300, Leonardo Bras wrote:
> > > > > Currently pcrypt_aead_init_tfm() will pick callback cpus (ctx->cb=
_cpu)
> > > > > from any online cpus. Later padata_reorder() will queue_work_on()=
 the
> > > > > chosen cb_cpu.
> > > > >
> > > > > This is undesired if the chosen cb_cpu is listed as isolated (i.e=
. using
> > > > > isolcpus=3D... kernel parameter), since the work queued will inte=
rfere with
> > > > > the workload on the isolated cpu.
> > > > >
> > > > > Make sure isolated cpus are not used for pcrypt.
> > > > >
> > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > > ---
> > > > >  crypto/pcrypt.c | 10 +++++++---
> > > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> > > > > index 9d10b846ccf73..9017d08c91a8d 100644
> > > > > --- a/crypto/pcrypt.c
> > > > > +++ b/crypto/pcrypt.c
> > > > > @@ -16,6 +16,7 @@
> > > > >  #include <linux/kobject.h>
> > > > >  #include <linux/cpu.h>
> > > > >  #include <crypto/pcrypt.h>
> > > > > +#include <linux/sched/isolation.h>
> > > > >
> > > > >  static struct padata_instance *pencrypt;
> > > > >  static struct padata_instance *pdecrypt;
> > > > > @@ -175,13 +176,16 @@ static int pcrypt_aead_init_tfm(struct cryp=
to_aead *tfm)
> > > > >         struct pcrypt_instance_ctx *ictx =3D aead_instance_ctx(in=
st);
> > > > >         struct pcrypt_aead_ctx *ctx =3D crypto_aead_ctx(tfm);
> > > > >         struct crypto_aead *cipher;
> > > > > +       struct cpumask non_isolated;
> > > > > +
> > > > > +       cpumask_and(&non_isolated, cpu_online_mask, housekeeping_=
cpumask(HK_TYPE_DOMAIN));
> > > >
> > > > Since certain systems do not use isolcpus=3Ddomain, so please use a=
 flag
> > > > that is setup by nohz_full=3D, for example HK_FLAG_MISC:
> > > >
> > > > static int __init housekeeping_nohz_full_setup(char *str)
> > > > {
> > > >         unsigned long flags;
> > > >
> > > >         flags =3D HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FL=
AG_RCU |
> > > >                 HK_FLAG_MISC | HK_FLAG_KTHREAD;
> > > >
> > > >         return housekeeping_setup(str, flags);
> > > > }
> > > > __setup("nohz_full=3D", housekeeping_nohz_full_setup);
> > >
> > > Oh, sure.
> > > Since we are talking about WorkQueues, I think it makes sense to pick
> > > HK_FLAG_WQ.
> > >
> > > >
> > > > Also, shouldnt you use cpumask_t ?/
> > >
> > > Yeah, I think so.
> > > I was quick to choose the 'struct cpumask' because all functions woul=
d operate
> > > in this variable type, but yeah, I think it makes sense to have this =
variable
> > > being opaque here.
> >
> > In fact, it seems neither 'struct cpumask' nor 'cpumask_t' are recommen=
ded to be
> > used allocated in the stack, due to the large size it can get (up to 1k=
B).
> >
> > At include/linux/cpumask.h we have:
> > 'cpumask_var_t: struct cpumask for stack usage'
> > which should work better at least for init functions like this.
> >
> > In other cases, I see 'static cpumask_t' being used to avoid the alloca=
tion
> > overhead, but it's probably due to the functions being called in very s=
pecific
> > scenarios. It could mean trouble if multiple cpus try to use it at once=
.
> >
> > What do you recommend on it?
>
> Sorry for the delay. I suppose allocating and freeing is OK in this conte=
xt, since
> its initialization time and not a hot path?

Yeah, it makes sense this way. I will allocate as suggested!
(Unless my other change gets in, so this new variable and a lot of
overhead can be avoided.)

Thanks Marcelo!

