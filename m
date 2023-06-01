Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D571F3EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjFAUf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjFAUfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:35:54 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1E107
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:35:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f6e19f814so586493a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685651752; x=1688243752;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQsmyQzEzHyUODjeF1Im8+Zrh4FhlDMcFejVWj5dlGY=;
        b=joxSX0p8ogxk67cCS7PFajwKHZzRYWC5NMM8qC7ZQdrctoQEQo6IVtrYyVUg9AhDyj
         itFopm/lq6NVXU575PkYvBBEXs0A8CJDsCgyvjUHy1Yw0423zgH8geusLAyFLOIT3IF6
         ewPOd9Q8rp0XyvdbrfbETxTD/D6+LiAxC8ArFNpHKyCz+jWX+krZhqaZHU83jGuv3OtT
         +HOZ6c9pHZh6htzGvgfZsHXruYI1hPotq+mnbGnpVX1MKY46id+UNHlJP4luwoRxELbk
         is3Zn+TfRfI1ZqU7TItm3VIhf6wiEWfwKuCV0BAq/7ZdKfiMrFW6B0AIIRxt9Cdee3ff
         Uz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685651752; x=1688243752;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BQsmyQzEzHyUODjeF1Im8+Zrh4FhlDMcFejVWj5dlGY=;
        b=EkPx4OsTD+AHD0/FovnNaJ44BkqDKPx9ciV/bXPgWaBfaLsT7RfmTV4OfqztSE1y/m
         fQUMyvTO3H/V+4NJd6Zoat89yz3v9/Vb6D9f965eAkprkqqOBgLrGEp54TgpNgKiz6lG
         slbJfc3TFPAeB3eFKRT1M2HHNEpuxy6latjoaACTfEhguaq4XKFEFT494BEY4Pj6sATv
         iQYOemsQcCLJjeZI3bFOcRWmWCb0mGc4hrP4Ng4elDJhEPY1SuSWwRxAO9QrBefOjX7N
         UTrbUSmX1U6DLbkY19irE0mOZrylKMVunvlM1jjLC4zxWQfgx7Z9amF2fdf5oaLCLva2
         F0Ug==
X-Gm-Message-State: AC+VfDzgd91OaRXIR/mS9xyDp9QRNvr5Xd4jdgE3RKPiXAZJTC4Vmfe5
        LJbYNo1hM9dRgDXWC21w+DYts2zcfok=
X-Google-Smtp-Source: ACHHUZ69pDPXzuIjV71lgfceFCUQY0VEO7bbEfEhdF5tcDPMpDyfDGGCaZeqHmNZ0XH1XXrUPwqKHCewFSc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:495f:0:b0:53f:7713:5e0e with SMTP id
 y31-20020a63495f000000b0053f77135e0emr1916195pgk.5.1685651752377; Thu, 01 Jun
 2023 13:35:52 -0700 (PDT)
Date:   Thu, 1 Jun 2023 13:35:51 -0700
In-Reply-To: <CALMp9eQ247GCxHnn3VwFatKEswWq9cMaoZCOivC-OQ_asvFHZQ@mail.gmail.com>
Mime-Version: 1.0
References: <9d37ab07-97c6-5245-6939-9c1090b4b3a9@redhat.com>
 <ECE9A3B4-2CF3-452A-838A-99BE075D5E68@nutanix.com> <3cb96907-0d58-ba60-ed0e-6c17c69bd0f8@redhat.com>
 <CALMp9eQNNCwUbPQGBfHzWnTAEJeRO-fjQAFxb9101SChe9F5rg@mail.gmail.com>
 <623EC08D-A755-4520-B9BF-42B0E72570C1@nutanix.com> <CALMp9eQ17+XRpxJjMnmvPnKOC1VP1P=mU-KykoOzYZsgtGN8sQ@mail.gmail.com>
 <658D3EF0-B2D3-4492-A2A1-FC84A58B201D@nutanix.com> <ZHjYsKVBFLsOmHcF@google.com>
 <BF7121B7-B2AE-4391-9D1B-D944B5BC44D0@nutanix.com> <CALMp9eQ247GCxHnn3VwFatKEswWq9cMaoZCOivC-OQ_asvFHZQ@mail.gmail.com>
Message-ID: <ZHkBJ+RdPYIZjolX@google.com>
Subject: Re: [PATCH v4] KVM: VMX: do not disable interception for
 MSR_IA32_SPEC_CTRL on eIBRS
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Jon Kohler <jon@nutanix.com>, Waiman Long <longman@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Thu, Jun 01, 2023, Jim Mattson wrote:
> On Thu, Jun 1, 2023 at 12:28=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrot=
e:
> > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > index c544602d07a3..454bcbf5b543 100644
> > > --- a/arch/x86/kvm/x86.h
> > > +++ b/arch/x86/kvm/x86.h
> > > @@ -492,7 +492,31 @@ static inline void kvm_machine_check(void)
> > >
> > > void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu);
> > > void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu);
> > > +
> > > int kvm_spec_ctrl_test_value(u64 value);
> > > +
> > > +static inline bool kvm_account_msr_spec_ctrl_write(struct kvm_vcpu *=
vcpu)
> > > +{
> > > +     if ((vcpu->stat.exits - vcpu->arch.spec_ctrl_nr_exits_snapshot)=
 < 20)
>=20
> I think you mean 200 here. If it's bad to have more than 1
> WRMSR(IA32_SPEC_CTRL) VM-exit in 20 VM-exits, then more than 10 such
> VM-exits in 200 VM-exits represents sustained badness.

No?  The snapshot is updated on every write, i.e. this check is whether or =
not
the last wrmsr(SPEC_CTRL) was less than 20 cycles ago. =20

       if ((vcpu->stat.exits - vcpu->arch.spec_ctrl_nr_exits_snapshot) < 20=
)
               vcpu->arch.nr_quick_spec_ctrl_writes++;
       else
               vcpu->arch.nr_quick_spec_ctrl_writes =3D 0;

       vcpu->arch.spec_ctrl_nr_exits_snapshot =3D vcpu->stat.exits;  <=3D n=
ew snapshot

       return vcpu->arch.nr_quick_spec_ctrl_writes >=3D 10;

> (Although, as Sean noted, these numbers are just placeholders.)

And the logic is very off-the-cuff, e.g. it may be better to have a rolling=
 200-exit
window instead of 10 somewhat independent 20-exit windows.
