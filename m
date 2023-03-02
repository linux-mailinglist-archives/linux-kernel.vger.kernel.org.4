Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0456A885D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCBSM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCBSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:12:55 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B000E4495
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:12:54 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id n18so4408704ybm.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 10:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677780774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLoyHNK1vziQhkEs+RUlvsDPEUYRvadH5i0VRyRqsjE=;
        b=FWUtR8Sx1lDO8zyv/3JVO8/sUNCn+1eEEbb3yyJk7vveX/HS2jRBRDyPTheGFJu1RH
         VJQfUyVe6WKrCzDnCz9wOWi0VJ3F4FB0/7PAVeKMDPA+edZaxLsGBZnnqzlwbzQw1OQN
         Wxq3XXtMKK4AjShLhhfFr71521O6/T6Xicm7p/RmsxTBN94q+r97PuMHd4h3fg449Nth
         NvaeHUrI7wGtm7qpfkVrYR31sOBnsNYjUbJPT9GOPoTKOQkOs2SQpZj3K8lHMEN/+ZYM
         89X3sEnDrVlufyeAIxPhWwA/CAGI/Pt0TIfkODDD+OPdL8WXUOg5kBtUuFjJuBaIIOne
         ZUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677780774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLoyHNK1vziQhkEs+RUlvsDPEUYRvadH5i0VRyRqsjE=;
        b=cRexLe6Z8kcYpjFIpNwObYGzMgxUG3lvDHpwz6SWp66iARv2cojbWcPvU8+t5CSxkJ
         zYoyZf/jhZ3G1arv1ret9Px7GWcIsQMBdajV+uFrr5MxPA63aGpZAECp3WNba+du4O6i
         cDS+kTEHx2GmiWU0m2PJ5Qy93UO4ESLBRMv/uauGZKAc609Tv2PJgeiONuiqU3pwO0iU
         tqOU0Vn2M4oImfeN1TPCrNdS13tlCX90+jaCgmoe2lPOLUcgkLqUzHJw2dYCtfq2+QTm
         HnMa7w3iWBDmiKRz15FYyX1xgbXBelauu7Y2hbZ9Yw13372jpK8oWlP6sxf7SCpbcMDT
         la5A==
X-Gm-Message-State: AO0yUKV/oOOyDam9r4GrOk6E/cTyF6T2LluHZQPYA5UIA5QZ4onEQfeT
        /R8X71w57kow+3RjoIP9JP1pn2RmtAnYhg/DKnLWAw==
X-Google-Smtp-Source: AK7set8ZA6ooiZktSnFTcb00/q54o0hRUdGDxWj/zbrfHift+7SwFKXkJ6dYkjCeL4c1nlpvbj6j87Gu684dGQ3h1q4=
X-Received: by 2002:a5b:dcd:0:b0:aa9:bd2e:373a with SMTP id
 t13-20020a5b0dcd000000b00aa9bd2e373amr4968921ybr.10.1677780773640; Thu, 02
 Mar 2023 10:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20230301133841.18007-1-wei.w.wang@intel.com> <CALzav=eRYpnfg7bVQpVawAMraFdHu3OzqWr55Pg1SJC_Uh8t=Q@mail.gmail.com>
 <DS0PR11MB637348F1351260F8B7E97A15DCB29@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZAAsIBUuIIO1prZT@google.com> <DS0PR11MB6373DAA05CEF9AB8A83A6499DCB29@DS0PR11MB6373.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB6373DAA05CEF9AB8A83A6499DCB29@DS0PR11MB6373.namprd11.prod.outlook.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Thu, 2 Mar 2023 10:12:17 -0800
Message-ID: <CAL715WLo90-JkJe6=GfX755t1jvaW-kqD_w++hv3Ed53fhLC3w@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: allow KVM_BUG/KVM_BUG_ON to handle 64-bit cond
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     David Matlack <dmatlack@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 2:26=E2=80=AFAM Wang, Wei W <wei.w.wang@intel.com> w=
rote:
>
> On Thursday, March 2, 2023 12:55 PM, Mingwei Zhang wrote:
> > I don't get it. Why bothering the type if we just do this?
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h index
> > 4f26b244f6d0..10455253c6ea 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -848,7 +848,7 @@ static inline void kvm_vm_bugged(struct kvm *kvm)
> >
> >  #define KVM_BUG(cond, kvm, fmt...)                           \
> >  ({                                                           \
> > -     int __ret =3D (cond);                                     \
> > +     int __ret =3D !!(cond);                                   \
>
> This is essentially "bool __ret". No biggie to change it this way.

!! will return an int, not a boolean, but it is used as a boolean.
This is consistent with the original code which _is_ returning an
integer.

> But I'm inclined to retain the original intention to have the macro retur=
n
> the value that was passed in:
> typeof(cond) __ret =3D (cond);

hmm, I think it is appropriate to retain the original type of 'cond'
especially since it may also involve other arithmetic operations. But
I doubt it will be very useful. For instance, who is going to write
this code?

......
if (KVM_BUG(cond, true) & some_mask)
  do_something()
......

>
> Let's what others vote for.

Please fix this bug first before introducing nice features.

Thanks.
-Mingwei


-Mingwei
