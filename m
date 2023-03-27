Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CED6CA927
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjC0Phn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjC0Phl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:37:41 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F3C2738
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:37:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y184so6651774oiy.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679931460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2scqCpn+SlvwNwMyXAR1S8e8r39frvTEmZWmCdUynfo=;
        b=rFuTXmnSGmSvQSqlTCwOwfje4dNunkyQvBQO1B0OEvIHKkhsQfByRaQcSeSdkocF5F
         yX5bCRDLIxqpm38oYlhRVTBZnKZZyCzAT3tmFdduJnJIWAB4dNqYrmwMuqy5p0BI3sSD
         mhkrQ8TcipD6vcrzyVkebrs0a3r308DuqctCTsGHROhou/kEUIj8jvRKfVIzu6Q9HPLw
         dFjRG+qM+HSJhcNuO1bncPlwqbiI0YzErn7+H1mTYkhwIol9FFPfJ8h3ieDG/VxCH+LK
         hhNfznLzq/+I9QjUSBuPCbtWWn5xvv1gxYSFnb+/aIijxkOshfIyTFx4YYYC/r4rYjmu
         VRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2scqCpn+SlvwNwMyXAR1S8e8r39frvTEmZWmCdUynfo=;
        b=sToLXqI1D/T+K5PCF5z7+Yp327PAMOaVV5WSivGtQadGx/EclYa7x7yKAwa6ohbw2P
         OzisbpVQetItIDiZukgmF5zzkKRbdo5HWz3fIeexK0KbTmZjFtZ9JGvuMSKPy/lb+U+I
         9IojbI9sMFP8bOVLJkDGE/prZLHKjpvGNUTgnGZG2oqU7LYAwCKGUAhIZCRtkD0UGayX
         rFRiN9k1ZAqhYT5esq6r84fKjZntOHqMTV809cgkoGKC7G0ltD5g8ikdv8QuAJ2hoRup
         ZAqP/qHuEatwqPUHWSYkzqiDwXpJfYKYSxFySafm7818KQYf4wbesHCdufm3UtTIAR6Z
         pKDQ==
X-Gm-Message-State: AO0yUKVV6qJ0SoO//wveD7daPc0pb+S0I0l+Dwdg08xLVwDYMx7GQZXR
        0PWgqBSn0emrR2UiUGUjJCmDrNZY1v0OHiIadHeSvg==
X-Google-Smtp-Source: AK7set+yYWM5lvMs9lQ15RVaYTAVVUaZW7sK+M1vnndSyDeraV8KLjlOca7p039jDbWxUJ7HlCk9vl5058ikbPt7n3g=
X-Received: by 2002:a54:4710:0:b0:384:4e2d:81ea with SMTP id
 k16-20020a544710000000b003844e2d81eamr3381518oik.9.1679931459915; Mon, 27 Mar
 2023 08:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230322011440.2195485-1-seanjc@google.com> <20230322011440.2195485-6-seanjc@google.com>
 <373823f7-00ba-070c-53c7-384d29889e40@intel.com>
In-Reply-To: <373823f7-00ba-070c-53c7-384d29889e40@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 27 Mar 2023 08:37:28 -0700
Message-ID: <CALMp9eTEG5o2jQ457BTAL=srPYFbFi2Jx1YLp+a3NW3tQ19wDQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] KVM: x86: Virtualize FLUSH_L1D and passthrough MSR_IA32_FLUSH_CMD
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 8:33=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 3/22/2023 9:14 AM, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index c83ec88da043..3c58dbae7b4c 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -3628,6 +3628,18 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, st=
ruct msr_data *msr_info)
> >
> >               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> >               break;
> > +     case MSR_IA32_FLUSH_CMD:
> > +             if (!msr_info->host_initiated &&
> > +                 !guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D))
> > +                     return 1;
> > +
> > +             if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D) || (data & ~L1D_=
FLUSH))
> > +                     return 1;
> > +             if (!data)
> > +                     break;
> > +
> > +             wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> > +             break;
>
> Then KVM provides the ability to flush the L1 data cache of host to
> userspace. Can it be exploited to degrade the host performance if
> userspace VMM keeps flushing the L1 data cache?

The L1D$ isn't very big. A guest could always flush out any previously
cached data simply by referencing its own data. Is the ability to
flush the L1D$ by WRMSR that egregious?
