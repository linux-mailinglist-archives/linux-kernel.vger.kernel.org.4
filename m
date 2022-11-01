Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64BC6150FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKARnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKARnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0AF1CB04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667324555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfX3RG8Twuc3X+jO0Ti+FSX1066Oauf6YVFak+lwBIQ=;
        b=LnKzdMy1KGKrTD+JHgQNDQ0etSG2DXyeRzkJkwh3aJ+ASWRs1fngalNHYCSiRaH88QpXx8
        XrCi9sOY0wlYFS6zqOUP632b/iJ4ehl2T4bk8Ax2dn/y894fh9BCuq6vmEQKCj1JzeZG/j
        Efw2q3tHo8MCkZidBY9SZ/PppFGm9Fo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-7QcEFs5CNU-CR68jW92niQ-1; Tue, 01 Nov 2022 13:42:32 -0400
X-MC-Unique: 7QcEFs5CNU-CR68jW92niQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6B24382F652;
        Tue,  1 Nov 2022 17:42:31 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5537D40C94D1;
        Tue,  1 Nov 2022 17:42:31 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 41228416CE48; Tue,  1 Nov 2022 14:35:45 -0300 (-03)
Date:   Tue, 1 Nov 2022 14:35:45 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] crypto/pcrypt: Do not use isolated CPUs for
 callback
Message-ID: <Y2FY8fOVsYCXmg+8@fuller.cnet>
References: <20221004062536.280712-1-leobras@redhat.com>
 <Yz1/TVUV+KnLvodg@fuller.cnet>
 <b23b08274ccff99fb341ea272e968f72c2e289ce.camel@redhat.com>
 <3d6d47035f8897542a4786eef5a6b8885f4caaf0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d6d47035f8897542a4786eef5a6b8885f4caaf0.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:20:39PM -0300, Leonardo Brás wrote:
> On Fri, 2022-10-07 at 18:42 -0300, Leonardo Brás wrote:
> > On Wed, 2022-10-05 at 09:57 -0300, Marcelo Tosatti wrote:
> > > On Tue, Oct 04, 2022 at 03:25:37AM -0300, Leonardo Bras wrote:
> > > > Currently pcrypt_aead_init_tfm() will pick callback cpus (ctx->cb_cpu)
> > > > from any online cpus. Later padata_reorder() will queue_work_on() the
> > > > chosen cb_cpu.
> > > > 
> > > > This is undesired if the chosen cb_cpu is listed as isolated (i.e. using
> > > > isolcpus=... kernel parameter), since the work queued will interfere with
> > > > the workload on the isolated cpu.
> > > > 
> > > > Make sure isolated cpus are not used for pcrypt.
> > > > 
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > ---
> > > >  crypto/pcrypt.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> > > > index 9d10b846ccf73..9017d08c91a8d 100644
> > > > --- a/crypto/pcrypt.c
> > > > +++ b/crypto/pcrypt.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <linux/kobject.h>
> > > >  #include <linux/cpu.h>
> > > >  #include <crypto/pcrypt.h>
> > > > +#include <linux/sched/isolation.h>
> > > >  
> > > >  static struct padata_instance *pencrypt;
> > > >  static struct padata_instance *pdecrypt;
> > > > @@ -175,13 +176,16 @@ static int pcrypt_aead_init_tfm(struct crypto_aead *tfm)
> > > >  	struct pcrypt_instance_ctx *ictx = aead_instance_ctx(inst);
> > > >  	struct pcrypt_aead_ctx *ctx = crypto_aead_ctx(tfm);
> > > >  	struct crypto_aead *cipher;
> > > > +	struct cpumask non_isolated;
> > > > +
> > > > +	cpumask_and(&non_isolated, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
> > > 
> > > Since certain systems do not use isolcpus=domain, so please use a flag
> > > that is setup by nohz_full=, for example HK_FLAG_MISC:
> > > 
> > > static int __init housekeeping_nohz_full_setup(char *str)
> > > {
> > >         unsigned long flags;
> > > 
> > >         flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> > >                 HK_FLAG_MISC | HK_FLAG_KTHREAD;
> > > 
> > >         return housekeeping_setup(str, flags);
> > > }
> > > __setup("nohz_full=", housekeeping_nohz_full_setup);
> > 
> > Oh, sure. 
> > Since we are talking about WorkQueues, I think it makes sense to pick
> > HK_FLAG_WQ. 
> > 
> > > 
> > > Also, shouldnt you use cpumask_t ?/
> > 
> > Yeah, I think so. 
> > I was quick to choose the 'struct cpumask' because all functions would operate
> > in this variable type, but yeah, I think it makes sense to have this variable
> > being opaque here.
> 
> In fact, it seems neither 'struct cpumask' nor 'cpumask_t' are recommended to be
> used allocated in the stack, due to the large size it can get (up to 1kB). 
> 
> At include/linux/cpumask.h we have:
> 'cpumask_var_t: struct cpumask for stack usage'
> which should work better at least for init functions like this.
> 
> In other cases, I see 'static cpumask_t' being used to avoid the allocation
> overhead, but it's probably due to the functions being called in very specific
> scenarios. It could mean trouble if multiple cpus try to use it at once.
> 
> What do you recommend on it?

Sorry for the delay. I suppose allocating and freeing is OK in this context, since
its initialization time and not a hot path?

