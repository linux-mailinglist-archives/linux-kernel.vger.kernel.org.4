Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56606E9EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjDTWWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjDTWWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D992689
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682029324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CwNkw2ycLGQmhwLhAefmqq6d6MQy3Uydc9I/GhaHJ7U=;
        b=Cu0ikFf1vtTn6lPFuO0wgmOU2x5yEzObmcUAzeiu/1yScmTcgAM3hsqYfmwys7S0uuh40f
        GoIYaHM3AFgRMSQsjeik8Dr+5cy+Q11cpFnw9aVrWpf2PTpK5gNYwWTDPYQ7YPezyuoexC
        0Ja2XghjL/0bnOm8rmsz7kb7/RNYeTw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-FXErhNLdON2w_xkEwFAncQ-1; Thu, 20 Apr 2023 18:22:02 -0400
X-MC-Unique: FXErhNLdON2w_xkEwFAncQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5ef510c0f4dso8013756d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029322; x=1684621322;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwNkw2ycLGQmhwLhAefmqq6d6MQy3Uydc9I/GhaHJ7U=;
        b=Io7jW8UlkPI9iJ5ipLGJJ0+iI2O6pPwmwtSSiD+fbOyyl4AcIqPW+Hz50JVEQFvPaH
         ksGP36ANoomqUBCEQq7zYcvpXuSLbAKXPvdXCVeoxY2e+MHkj5vi/RylCCQdHlFbvwu3
         urRiWJ6Ism1p09pRcUrLAtEVOxj9Qwt3elaEfK8pdqp83gW6wfSnPPdpKF+Dva7JpK00
         6P61eOUibTJP8ATPJFS64X016G7ZmSYgNwmLMSX1Y1HN2FFQFHBHhU9B0OmVgcMZidUv
         qSx8ld7ljHAvQDLtZJQ9d2e28B9rmeAhBaDqXDfXeNwjW80ZVOaGGwEMmKiueYPs07pe
         cBWQ==
X-Gm-Message-State: AAQBX9eD0n5xV26WvS8QvbIj9ph9udWrzIwzgYw0OlSxpIB31ur0wSSt
        yxeA1yIs8pk6IzXYGrUdF2HEttMVr+dHozHNmTEk3Jyne3JTE4Ls1+IhAmJ7GLRo3+hI/B8Ki0N
        lHRYVelJKuMFpbkYwXriKgnt6
X-Received: by 2002:a05:6214:3018:b0:5f1:62d9:3378 with SMTP id ke24-20020a056214301800b005f162d93378mr3893107qvb.52.1682029322159;
        Thu, 20 Apr 2023 15:22:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350aiiysCZoC7YVt1pwyGAXdgusvWPkAnO2C6w1DWdNIydLiyFuVXwTNTt+2ci8o3PvkCXAr1ug==
X-Received: by 2002:a05:6214:3018:b0:5f1:62d9:3378 with SMTP id ke24-20020a056214301800b005f162d93378mr3893088qvb.52.1682029321910;
        Thu, 20 Apr 2023 15:22:01 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id f23-20020a0caa97000000b005dd8b9345absm690431qvb.67.2023.04.20.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:22:01 -0700 (PDT)
Message-ID: <5d033158358b441696c72ebb87548e0ff3beba4a.camel@redhat.com>
Subject: Re: irqdomain API: how to set affinity of parent irq of chained
 irqs?
From:   Radu Rendec <rrendec@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        pali@kernel.org, Brian Masney <bmasney@redhat.com>
Date:   Thu, 20 Apr 2023 18:22:00 -0400
In-Reply-To: <86lej4uk2r.wl-maz@kernel.org>
References: <20220502102137.764606ee@thinkpad>
         <87mtg0i8m8.wl-maz@kernel.org> <20220502174559.78f5cbc0@dellmb>
         <87fslr7ygl.wl-maz@kernel.org>
         <d1166229fdead30fcbf3c2bd88ca1bd4ebffbce9.camel@redhat.com>
         <86lej4uk2r.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Fri, 2023-04-07 at 10:18 +0100, Marc Zyngier wrote:
> On Fri, 07 Apr 2023 00:56:40 +0100, Radu Rendec <rrendec@redhat.com> wrot=
e:
> > Are you aware of any work being done (or having been done) in this
> > area? Thanks in advance!
> >=20
> > My colleagues and I are looking into picking this up and implementing
> > the new sysfs interface and the related irqbalance changes, and we are
> > currently evaluating the level of effort. Obviously, we would like to
> > avoid any effort duplication.
>=20
> I don't think anyone ever tried it (it's far easier to just moan about
> it than to do anything useful). But if you want to start looking into
> that, that'd be great.

Thanks for the feedback and sorry for the late reply. It looks like I
already started. I have been working on a "sandbox" driver that
implements hierarchical/muxed interrupts and would allow me to test in
a generic environment, without requiring mux hardware or to mess with
real interrupts.

But first, I would like to clarify something, just to make sure I'm on
the right track. It looks to me like with the hierarchical IRQ domain
API, there is always a 1:1 end-to-end mapping between virqs and the
hwirqs near the CPU. IOW, there is a 1:1 mapping between a given virq
and the corresponding hwirq in each IRQ domain along the chain, and
there is no other virq in-between. I looked at many of the irqchip
drivers that implement the hierarchical API, and couldn't find a single
one that does muxed IRQs. Furthermore, the revmap in struct irq_domain
is clearly a 1:1 map, so when an IRQ vector is entered, there is no way
to map multiple virqs (and run the associated handlers). I tried it in
my test driver, and if the .alloc domain op implementation allocates
the same hwirq in the parent domain for two different (v)irqs, the
revmap slot in the parent domain is overwritten.

If my understanding is correct, muxed IRQs are not possible with the
hierarchical IRQ domain API. That means in this particular case you can
never indirectly change the affinity of a different IRQ because hwirqs
are never shared. So, this is just a matter of exposing the affinity
through the new sysfs API for every irqchip driver that opts-in.

On the other hand, muxed IRQs *are* possible with the legacy API, and
drivers/irqchip/irq-imx-intmux.c is a clear example of that. However,
in this case one (or multiple) additional virq(s) exist at the mux
level, and it is the virq handler that implements the logic to invoke
the appropriate downstream (child) virq handler(s). Then the virq(s) at
the mux level and all the corresponding downstream virqs share the same
affinity setting, because they also share the same hwirq in the root
domain (which is where affinity is really implemented). And yes, in
this case the relationship between these virqs is not tracked anywhere
currently. Is this what you had in mind when you mentioned below a "new
infrastructure to track muxed interrupts"?

> One of my concern is that allowing affinity changes for chained
> interrupt may uncover issues in existing drivers, so it would have to
> be an explicit buy-in for any chained irqchip. That's probably not too
> hard to achieve anyway given that you'll need some new infrastructure
> to track the muxed interrupts.

The first thing that comes to mind for the "explicit buy-in" is a new
function pointer in struct irq_chip to set the affinity in a mux-aware
manner. Something like irq_set_affinity_shared or _chained. I may not
see the whole picture yet but so far my thinking is that the existing
irq_set_affinity must remain unchanged in order to preserve
compatibility/behavior of the procfs interface.

> Hopefully this will result in something actually happening! ;-)

I really hope so. I am also excited to have the opportunity to work on
this. I will likely need your guidance along the way but I think it's
better to talk in advance than submit a huge patch series that makes no
sense :)

Thanks,
Radu

