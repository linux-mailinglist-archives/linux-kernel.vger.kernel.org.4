Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD266F5D1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjECRkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjECRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:39:58 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4A10F3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:39:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24e43240e9fso709836a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683135597; x=1685727597;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaNgUREymFs00Yb0mg7CK5SfoWbeJmned3OPDAQIihE=;
        b=fsYBHQWjLN1c2TAemudpJrNbjeVHqe7+5QQHkDQi6Z/0nBduOM1DUUrpIsMsFZGcLf
         NMpF3syzhVSx1vAOpx0fbLqAbosL4eI+dtlQi36iyccxfl6E6f+Po/vqB470Iul+FBlm
         F/M/eaAlClHy/c1D0atYjVen2fOKdL7B6UqbNpveqT7DfydQyM5h6SVr1KKhfejO8pmK
         Z88eJzWbSCgqwR5Mkcdy4bYH1xukJtlqbg6MKyFWL/9qMYkQz72IKUpwcaw/IBtLJi8a
         SyjTGe2unBzkFvf0wxrN+BW2BAPU2MvzDi48ZHHK9QIo/vWubYX4NKW5+LruoV9EB6ZA
         55Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135597; x=1685727597;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jaNgUREymFs00Yb0mg7CK5SfoWbeJmned3OPDAQIihE=;
        b=QhuACoT/N3PtcWiqe5atXB5X5GxlUnPbeUGXZhFGoVZlW1hN3Lgdev0pmqpyZ/3YDW
         WKr07f+Tdw2f9K0F5p8bGd0Uls/iZcUUmSN7/sbhID+fu23PpTHTsJ12TXkELFW27boy
         9oQgNEx8zO+dviagt7RnuXxU4dWRLw20Waw0wAXqVGflg7BRMz2E0erIxEXgiPfVPgDY
         fIgFZPMHfhm24zW3FiUswGoy9DeUn1An7H+CpkwV28P65GkcHbG0PLP6ISqLauOiXaZ4
         +XYhRkjGb0GJcYUX4MV+phw9QNt5wTtGF6nCraqB4jcyFKJsYK/vaYE2duzqBJW2dfvd
         isxQ==
X-Gm-Message-State: AC+VfDw6ED7tdQSq8dz6FBBe16aFns0AzLA2mfDHnxY2I4sq09B4ZSOV
        pP4CR7UJ2njHNc700DEGRFigU53OCTg=
X-Google-Smtp-Source: ACHHUZ5XjGSm7zCGuwEwfzGUlaSfDp04mSDPK5a311XubZ0+jqcjEKM5p3OevUqiAMIldDEYRLKxnOHDobs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:4d0a:b0:24d:fb1d:106d with SMTP id
 c10-20020a17090a4d0a00b0024dfb1d106dmr3029858pjg.2.1683135596770; Wed, 03 May
 2023 10:39:56 -0700 (PDT)
Date:   Wed, 3 May 2023 10:39:55 -0700
In-Reply-To: <CALMp9eTHsS2PwVu38QtOa7JkUvBuR7Znz5wjsNuWBfyjT1O8ow@mail.gmail.com>
Mime-Version: 1.0
References: <20230503041631.3368796-1-mizhang@google.com> <ZFKLB1C+v6HKcy0o@google.com>
 <CALMp9eTHsS2PwVu38QtOa7JkUvBuR7Znz5wjsNuWBfyjT1O8ow@mail.gmail.com>
Message-ID: <ZFKca+dKE+Gjl+IR@google.com>
Subject: Re: [PATCH] KVM: VMX: add MSR_IA32_TSX_CTRL into msrs_to_save
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023, Jim Mattson wrote:
> On Wed, May 3, 2023 at 9:25=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Wed, May 03, 2023, Mingwei Zhang wrote:
> > > Add MSR_IA32_TSX_CTRL into msrs_to_save[] to explicitly tell userspac=
e to
> > > save/restore the register value during migration. Missing this may ca=
use
> > > userspace that relies on KVM ioctl(KVM_GET_MSR_INDEX_LIST) fail to po=
rt the
> > > value to the target VM.
> > >
> > > Fixes: b07a5c53d42a ("KVM: vmx: use MSR_IA32_TSX_CTRL to hard-disable=
 TSX on guest that lack it")
> > > Reported-by: Jim Mattson <jmattson@google.com>
> > > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > > ---
> > >  arch/x86/kvm/x86.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 237c483b1230..2236cfee4b7a 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -1431,7 +1431,7 @@ static const u32 msrs_to_save_base[] =3D {
> > >  #endif
> > >       MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
> > >       MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
> > > -     MSR_IA32_SPEC_CTRL,
> > > +     MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
> > >       MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATC=
H,
> > >       MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
> > >       MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
> > > --
> >
> > Hmm, KVM shouldn't report the MSR if it can't be written by the guest. =
 Over-
>=20
> I think you mean to say that KVM shouldn't report the MSR if it can't
> be written by *any* guest. KVM_GET_MSR_INDEX_LIST is a device ioctl,
> so it isn't capable of filtering out MSRs that can't be written by
> *the* guest, for some occurrence of "the."

Doh, yes, "the guest" was a handwavy reference to any/all guests.
