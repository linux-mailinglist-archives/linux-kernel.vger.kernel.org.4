Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0DD6ACF40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCFUeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:34:17 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D353A3646A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:34:15 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id h14-20020aa786ce000000b005a89856900eso6029312pfo.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678134855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO/IPOM+7z+TthmIwkyRbXTYScu6FAx2J2T5Y3exvW0=;
        b=iF099/KgN5YuGpSeUk8zAZ36CLRlI5owJ1YiAGxvYsitF/zw/RdlTK0222r1RQduoe
         dVAUIN4YY2F0gS8Ie1Z9r/UFZeBCecfDMfLY77tIbjF1HpymOu4PfOmIKQ35wPcB3AO/
         xuyn0SQF21B27j1YzZ8kQ4yZuKMLJrMaV809Nm+iCTfRTRemnsa3ZFBqF+diBUNmltWp
         rlopQtybj6FGXtiaLUggnCittXo77mj1racJ4kS+CIU3UeabGqVk5PwMvujkXVco8kNv
         yb3SjwH2l5kZwrTCtYQHY593J034W9WSa7gU+xselMY38dF6/SG2DiyBEsACsWjNeJzh
         lx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678134855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IO/IPOM+7z+TthmIwkyRbXTYScu6FAx2J2T5Y3exvW0=;
        b=AKI7yBd7cOCAPKyDWs00CQux3wih5VtBqAb4nDomkqQhoAgj6t5ZFulop+S/29QNWH
         NrEqHRlUxshMDa73Q7u3f4S5oGwc7t0500hRamk/iisfo/zvHdsd/ifnDmjkyUVJbh+X
         9G6Q4krG696TOO+jyQ47yFj+YSG3Cupt+9rWOdO9ul4XKaJWD8kE8G5frsiIqICPlFlN
         TWbYfRxmg6XixY7cTxhtxMYvjWNdk4d5/RW8gifcj4ab3lln3SEo4SljSy/xyU+pTl3m
         uhXIaQGFx8lXvZSWWiemevJx4LQakPI4wM0YX9ia3/LKoFc9pauCGAxtKLKRxssnhK2T
         43FQ==
X-Gm-Message-State: AO0yUKUWTmu//NL6iBdRfmxUfo/MYsXuEIN85zlxITb8rhM48rcf7w9i
        izjqJorueMKSRBW/hb0kAN2wUXLZjCU=
X-Google-Smtp-Source: AK7set/c+ryOkqfjCmpCf2GuTepFvKVkqw1Ws5fzt4IpHoAq1tAYwPgE2ls9KQCP0l0XQwooW+qh88JYhdo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:8645:0:b0:5a8:9872:2b9b with SMTP id
 x66-20020a628645000000b005a898722b9bmr5138153pfd.1.1678134855360; Mon, 06 Mar
 2023 12:34:15 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:34:13 -0800
In-Reply-To: <DS0PR11MB6373C317B71C7B1BABB9BED2DCB09@DS0PR11MB6373.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <20230301133841.18007-1-wei.w.wang@intel.com> <CALzav=eRYpnfg7bVQpVawAMraFdHu3OzqWr55Pg1SJC_Uh8t=Q@mail.gmail.com>
 <DS0PR11MB637348F1351260F8B7E97A15DCB29@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZAAsIBUuIIO1prZT@google.com> <DS0PR11MB6373DAA05CEF9AB8A83A6499DCB29@DS0PR11MB6373.namprd11.prod.outlook.com>
 <CAL715WLo90-JkJe6=GfX755t1jvaW-kqD_w++hv3Ed53fhLC3w@mail.gmail.com>
 <DS0PR11MB63735E9AC8F4636AF27DAA4ADCB39@DS0PR11MB6373.namprd11.prod.outlook.com>
 <CAL715WJsV3tPkMDK0exgHeuKOP9kJtc62Ra0jnRhT1Gd6AiEWg@mail.gmail.com>
 <ZAIwEZdYcrs5EcHE@google.com> <DS0PR11MB6373C317B71C7B1BABB9BED2DCB09@DS0PR11MB6373.namprd11.prod.outlook.com>
Message-ID: <ZAZM7z2O1vV5MZjn@google.com>
Subject: Re: [PATCH v1] KVM: allow KVM_BUG/KVM_BUG_ON to handle 64-bit cond
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023, Wang, Wei W wrote:
> On Saturday, March 4, 2023 1:36 AM, David Matlack wrote:
> > > > On Friday, March 3, 2023 2:12 AM, Mingwei Zhang wrote:
> > > > > > On Thursday, March 2, 2023 12:55 PM, Mingwei Zhang wrote:
> > > > > > > I don't get it. Why bothering the type if we just do this?
> > > > > > >
> > > > > > > diff --git a/include/linux/kvm_host.h
> > > > > > > b/include/linux/kvm_host.h index 4f26b244f6d0..10455253c6ea
> > > > > > > 100644
> > > > > > > --- a/include/linux/kvm_host.h
> > > > > > > +++ b/include/linux/kvm_host.h
> > > > > > > @@ -848,7 +848,7 @@ static inline void kvm_vm_bugged(struct
> > > > > > > kvm
> > > > > > > *kvm)
> > > > > > >
> > > > > > >  #define KVM_BUG(cond, kvm, fmt...)                           \
> > > > > > >  ({                                                           \
> > > > > > > -     int __ret = (cond);                                     \
> > > > > > > +     int __ret = !!(cond);                                   \
> > > > > >
> > > > > > This is essentially "bool __ret". No biggie to change it this way.
> > > > >
> > > > > !! will return an int, not a boolean, but it is used as a boolean.
> > > >
> > > > What's the point of defining it as an int when actually being used as a
> > Boolean?
> > > > Original returning of an 'int' is a bug in this sense. Either
> > > > returning a Boolean or the same type (length) as cond is good way to me.
> > >
> > > What's the point of using an integer? I think we need to ask the
> > > original author. But I think one of the reasons might be convenience
> > > as the return value. I am not sure if we can return a boolean in the
> > > function. But it should be fine here since it is a macro.
> > >
> > > Anyway, returning an 'int' is not a bug. The bug is the casting from
> > > 'cond' to the integer that may lose information and this is what you
> > > have captured.
> > 
> > typeof() won't work if cond is a bitfield. See commit 8d4fbcfbe0a4 ("Fix
> > WARN_ON() on bitfield ops") from Linus from back in 2007:
> 
> Yes, this seems to be a good reason for not going for typeof. Thanks for sharing.

Ya, just make __ret a bool.  I'm 99% certain I just loosely copied from WARN_ON(),
but missed the !!.
