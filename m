Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDC76B91DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCNLlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCNLln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF81F9B2F2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678794057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvUKdBCqtDsCDJokDequ8gIlKpdN3GQsgjjeCWrl9fk=;
        b=aP+Rm59KsZmWGz5QdK5lMgPF7PheTWjmSYOLFI1RIXHD+JJrbG11BO772yPlC8yTjjeW6p
        eIo/pcoRPjPEYo7bqmOwY9Vi/+tc4n7HjbKSdJtXc7wLMYzAaH96WMkZovvn5gx2kfF21m
        Q4bMxkEjOD/uzZyzqikEWcvI40lQ5Ok=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-DKUpdB2pPT2kvTuhFqHhtg-1; Tue, 14 Mar 2023 07:40:50 -0400
X-MC-Unique: DKUpdB2pPT2kvTuhFqHhtg-1
Received: by mail-ua1-f72.google.com with SMTP id z1-20020ab03881000000b0068feca4ad88so7519315uav.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678794050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvUKdBCqtDsCDJokDequ8gIlKpdN3GQsgjjeCWrl9fk=;
        b=IPGDsOgIELucwWIepf1a5tr+N5Rw1GRXDz4nFbXhuemb0mtaIlXHkHK67Kmef/+iwT
         rzrCaiwocOrkzl0Uf1RkO3F8oaAMPxlpGHmJjFE5yC6Mlwx6SM85rp/L3amhiPkLBf7k
         ATrWz+ueB52eVtonSdMR0PUc2TBXWS9APF05pbQrD5Lskfi/KHIgFGpJmcCPWEqlUva7
         YFfU4okRQ8h51xajVCRoZr6QpRny2QsSGMp/AAqasuyweEUGOFlmvtDmDPcrWo7ow693
         K2YnbKzdPBVi8VGlgV7fFQheGmCN4i2bJ0yRf1tzA+D3yGux8BdlBoY12Gy++AKsP1HO
         rmiQ==
X-Gm-Message-State: AO0yUKXcPGvAbX3QgTokvq17giBffH8fnCJ8KPXWQPfQYGZdn+Pu8xzL
        VVJ0HrRFdS3y9Xw0uMOqFUTqfV6UtBEOnXk4Nuq5AZzQeAGgoVBGVhkHYVYll+Fsr2q0bwgjTHq
        ACwUUZPbSmlKGHPa4OPQqraN441burCpWMjsBgS6qztHkcI6a7H8=
X-Received: by 2002:a67:d08c:0:b0:425:a3a9:a6e8 with SMTP id s12-20020a67d08c000000b00425a3a9a6e8mr1680163vsi.1.1678794050023;
        Tue, 14 Mar 2023 04:40:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set8m2YHyzZwKxEeDVZaI9vGT3421ek6caI5yO0ukBXyVOVG8nEWdZx1OXuEsVVYm6GXhA2bwA99fmZZJcza4we0=
X-Received: by 2002:a67:d08c:0:b0:425:a3a9:a6e8 with SMTP id
 s12-20020a67d08c000000b00425a3a9a6e8mr1680153vsi.1.1678794049787; Tue, 14 Mar
 2023 04:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230310234304.2908714-1-pbonzini@redhat.com> <ZAvGjCqfKgsSEQhZ@google.com>
In-Reply-To: <ZAvGjCqfKgsSEQhZ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 14 Mar 2023 12:40:38 +0100
Message-ID: <CABgObfbwAe3ut18bS2u05pAgDoUvix_N9LKMb1iBcx8xNd9dMQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: add missing consistency checks for CR0 and CR4
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Reima ISHII <ishiir@g.ecc.u-tokyo.ac.jp>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 1:17=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> > @@ -3047,6 +3047,19 @@ static int nested_vmx_check_guest_state(struct k=
vm_vcpu *vcpu,
> >                                          vmcs12->guest_ia32_perf_global=
_ctrl)))
> >               return -EINVAL;
> >
> > +     if (CC((vmcs12->guest_cr0 & (X86_CR0_PG | X86_CR0_PE)) =3D=3D X86=
_CR0_PG))
> > +             return -EINVAL;
> > +
> > +#ifdef CONFIG_X86_64
>
> The #ifdef isn't necessary, attempting to set for a 32-bit host should be=
 rejected
> by nested_vmx_check_controls() since nested_vmx_setup_ctls_msrs() clears =
the bit.
> Ditto for the host logic related to VM_EXIT_HOST_ADDR_SPACE_SIZE, which l=
ooks
> suspiciously similar ;-)

Yeah, I noticed that too and decided that the idea could have been to
allow some dead code elimination on 32-bit kernels, so I copied what
the host state checks were doing. But if you prefer the more compact
way I am absolutely not going to complain.

> > +     if (CC(ia32e &&
> > +            (!(vmcs12->guest_cr4 & X86_CR4_PAE) ||
> > +             !(vmcs12->guest_cr0 & X86_CR0_PG))))
> > +             return -EINVAL;
>
> This is a lot easier to read IMO, and has the advantage of more precisely
> identifying the failure in the tracepoint.
>
>         if (CC(ia32e && !(vmcs12->guest_cr4 & X86_CR4_PAE)) ||
>             CC(ia32e && !(vmcs12->guest_cr4 & X86_CR0_PG)))
>                 return -EINVAL;

Looks good.  I squashed everything in.

Paolo

