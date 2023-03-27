Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4154F6CA9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC0QAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjC0QAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:00:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFD2688
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b8-20020aa78708000000b005eaa50faa35so4605309pfo.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679932807;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAmapc1h2/zUGtfRb73ywDzpB2MYvKSxif+WSZz20gk=;
        b=jLWDoZbwHwB4mTozuWWzTVJsgQ++DRHbDKBRAmJ2Ye4/tqeZ8WRBqLPqDeOyJB/Vl9
         KmABEnph4x/Xb5iRvoY7agFFgTAAH7xBmcuTD6w8hh3QHWB44qDuI4SdFCEDwJ89zxo5
         jtb+rQGoFdQGL6dgQeWs4DZZPNBGMA2yLWwqw/4dyr08EmBt6XC5exK5kN4AT2DjWBVy
         FSYBfU/JarBoPXimnInHhSy6cdkX90HZXaAm89/TfbKHz8faGM8wveg71HI7B8MZci7c
         NvFu+DzBwbFRRA4griTQMpFO5av6mdAY77pZuJ7bYRWurmpvtc12i/EXtRo6CD02kvF/
         mA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932807;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mAmapc1h2/zUGtfRb73ywDzpB2MYvKSxif+WSZz20gk=;
        b=lnn2WGV0OhW4aZlrEex2Pit4pksiQtbA/Zjmp0Lj4UvPOdQSwd790S/d3kkobIAW1n
         mxLZ8F4+KtnKLt+d4HuvTg6USGYQegYmwjg8eOIZWIlKpnMB5hcdbXVSeR5qmhsh69HF
         V+5RSazPbJLPtr1nlRRucG6hup93SginrF25/m5hKFEmw5mPE/aymjUPTMjuvUA//Ks3
         qBWZgap+ZX96mNV2yofaPf3zDP1bwh5YWxW6znSz/e8SjLhfa1/xoGXdTn94OwmDsuH9
         oV9WSZe52OAl0xpDo+2PNwwkLZww7FAQKZbV8jdzlJILQgj94CIwc9J1ho6Db6y1v5dT
         SO8g==
X-Gm-Message-State: AAQBX9dd0jUEm2yhDpLFe5Fw/Pe3RkpIEJCq3XK9EWvuKwoo7x/MBfJL
        a1gbo3s7ZB6M+0Y0C0wnuPEfdMUmvak=
X-Google-Smtp-Source: AKy350aK3wtIhiuEt9gpavh2VO+xVZy1A/To5g+BMkE7l/9OE7xspwBeQampekX7o68R3A5B/gBJEZkfQ0g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7892:b0:1a1:f9f7:b752 with SMTP id
 q18-20020a170902789200b001a1f9f7b752mr4074759pll.0.1679932806751; Mon, 27 Mar
 2023 09:00:06 -0700 (PDT)
Date:   Mon, 27 Mar 2023 09:00:05 -0700
In-Reply-To: <CALMp9eTEG5o2jQ457BTAL=srPYFbFi2Jx1YLp+a3NW3tQ19wDQ@mail.gmail.com>
Mime-Version: 1.0
References: <20230322011440.2195485-1-seanjc@google.com> <20230322011440.2195485-6-seanjc@google.com>
 <373823f7-00ba-070c-53c7-384d29889e40@intel.com> <CALMp9eTEG5o2jQ457BTAL=srPYFbFi2Jx1YLp+a3NW3tQ19wDQ@mail.gmail.com>
Message-ID: <ZCG9hdSHvM56z/FZ@google.com>
Subject: Re: [PATCH 5/6] KVM: x86: Virtualize FLUSH_L1D and passthrough MSR_IA32_FLUSH_CMD
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023, Jim Mattson wrote:
> On Sun, Mar 26, 2023 at 8:33=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com>=
 wrote:
> >
> > On 3/22/2023 9:14 AM, Sean Christopherson wrote:
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index c83ec88da043..3c58dbae7b4c 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -3628,6 +3628,18 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
> > >
> > >               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> > >               break;
> > > +     case MSR_IA32_FLUSH_CMD:
> > > +             if (!msr_info->host_initiated &&
> > > +                 !guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D))
> > > +                     return 1;
> > > +
> > > +             if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D) || (data & ~L1=
D_FLUSH))
> > > +                     return 1;
> > > +             if (!data)
> > > +                     break;
> > > +
> > > +             wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> > > +             break;
> >
> > Then KVM provides the ability to flush the L1 data cache of host to
> > userspace. Can it be exploited to degrade the host performance if
> > userspace VMM keeps flushing the L1 data cache?
>=20
> The L1D$ isn't very big. A guest could always flush out any previously
> cached data simply by referencing its own data. Is the ability to
> flush the L1D$ by WRMSR that egregious?

Yeah, AFAIK RDT and the like only provide QoS controls for L3, so L1 is fai=
r game.
