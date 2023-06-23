Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA09573C186
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjFWUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:53:40 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE02962
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 13:52:00 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-66870d541b7so494033b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687553520; x=1690145520;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uspspMky8TikfcgO17xdnQdY4tVzQxlzD9UOFv5URqQ=;
        b=YiXMks3MPNFsB1OT+0qqYJ2rxlkMClQoWTKh3D6Hj/XNrDus7X4XwKxKHtpDZW3x4y
         TGJf0Y8Nq66k/FYNBQfJsnjeU37M2PcXSZwVtSuwJeDoQFBXwzEelHIHopnh/p/LFsdj
         MgloQtCba5KbDah8HuDUyyok5SopLpg3ubLkKILx1AEFrHutuJNaW0Bcg1CT/K7CMaBR
         D+0Enn2INIjbmX9KxXfr1d1B1LrOUGrBC6zaoWWqWjdOVZpPtbMjj9qBMYKs/8i0hANy
         C5Gknim/JFnVx13T/lo8FG5/hmU8AxGyVyJD31S8bBw8LzBapR2bAKxjcOLlKakiJFb2
         cYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687553520; x=1690145520;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uspspMky8TikfcgO17xdnQdY4tVzQxlzD9UOFv5URqQ=;
        b=RCaMUbrz82/u96iyAb1vD7HxQhsIebri/5fkjs7AVfpXPkThiz9HNoF+f56KzpfDtq
         ktbGTOObTHTGqa3I7swtbdVHqjQh3TMiKt3Ndp9CXhUV44jz6af6CcPLWQrHDSiLMYWK
         SMrA4eAikA3MX1n7kbEsj/SmTE9TzGXh26Vwtna+veepTOdZxTC9GhdGLQm/JrYU3dNV
         wkQhkkAMpLUsLy7IpompNczP+kGzZem83noU7Q1Cg6LwF457poVVQOM4+6r9ObcOj2sA
         QYx4qxLRMYhLoEc50ZRutVsJ8Q/v5cRkaUcuFz+H2BA5TTH/QbfOl3GT8Ay8yq1URjex
         SugA==
X-Gm-Message-State: AC+VfDy2qFJRlMQkOV7bNa8Um0+1yoFT6T5CjiIAebX1gOVF2Q8553yV
        hke2ZJ55yTpLvUkc83aBrJ5vv6LeKdY=
X-Google-Smtp-Source: ACHHUZ5tDD9Xnl2ftoPkz9hATloNCrnffXyV8YLuv9q99SkzEIZoBQw7GrDngn3qIdQ4xx8AcJqHEmFzyjw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3a0c:b0:668:69fa:f795 with SMTP id
 fj12-20020a056a003a0c00b0066869faf795mr4918321pfb.2.1687553520213; Fri, 23
 Jun 2023 13:52:00 -0700 (PDT)
Date:   Fri, 23 Jun 2023 13:51:58 -0700
In-Reply-To: <c438b5b1-b34d-3e77-d374-37053f4c14fa@intel.com>
Mime-Version: 1.0
References: <20230511040857.6094-1-weijiang.yang@intel.com>
 <ZIufL7p/ZvxjXwK5@google.com> <147246fc-79a2-3bb5-f51f-93dfc1cffcc0@intel.com>
 <ZIyiWr4sR+MqwmAo@google.com> <c438b5b1-b34d-3e77-d374-37053f4c14fa@intel.com>
Message-ID: <ZJYF7haMNRCbtLIh@google.com>
Subject: Re: [PATCH v3 00/21] Enable CET Virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     Weijiang Yang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rppt@kernel.org, binbin.wu@linux.intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023, Weijiang Yang wrote:
>=20
> On 6/17/2023 1:56 AM, Sean Christopherson wrote:
> > On Fri, Jun 16, 2023, Weijiang Yang wrote:
> > > On 6/16/2023 7:30 AM, Sean Christopherson wrote:
> > > > On Thu, May 11, 2023, Yang Weijiang wrote:
> > > > > The last patch is introduced to support supervisor SHSTK but the =
feature is
> > > > > not enabled on Intel platform for now, the main purpose of this p=
atch is to
> > > > > facilitate AMD folks to enable the feature.
> > > > I am beyond confused by the SDM's wording of CET_SSS.
> > > >=20
> > > > First, it says that CET_SSS says the CPU isn't buggy (or maybe "les=
s buggy" is
> > > > more appropriate phrasing).
> > > >=20
> > > >     Bit 18: CET_SSS. If 1, indicates that an operating system can e=
nable supervisor
> > > >     shadow stacks as long as it ensures that certain supervisor sha=
dow-stack pushes
> > > >     will not cause page faults (see Section 17.2.3 of the Intel=C2=
=AE 64 and IA-32
> > > >     Architectures Software Developer=E2=80=99s Manual, Volume 1).
> > > >=20
> > > > But then it says says VMMs shouldn't set the bit.
> > > >=20
> > > >     When emulating the CPUID instruction, a virtual-machine monitor=
 should return
> > > >     this bit as 0 if those pushes can cause VM exits.
> > > >=20
> > > > Based on the Xen code (which is sadly a far better source of inform=
ation than the
> > > > SDM), I *think* that what the SDM is trying to say is that VMMs sho=
uld not set
> > > > CET_SS if VM-Exits can occur ***and*** the bit is not set in the ho=
st CPU.  Because
> > > > if the SDM really means "VMMs should never set the bit", then what =
on earth is the
> > > > point of the bit.
> > > I need to double check for the vague description.
> > >=20
> > >  From my understanding, on bare metal side, if the bit is 1, OS can e=
nable
> > > SSS if pushes won't cause page fault. But for VM case, it's not recom=
mended
> > > (regardless of the bit state) to set the bit as vm-exits caused by gu=
est SSS
> > > pushes cannot be fully excluded.
> > >=20
> > > In other word, the bit is mainly for bare metal guidance now.
> > >=20
> > > > > In summary, this new series enables CET user SHSTK/IBT and kernel=
 IBT, but
> > > > > doesn't fully support CET supervisor SHSTK, the enabling work is =
left for
> > > > > the future.
> > > > Why?  If my interpretation of the SDM is correct, then all the piec=
es are there.
> > ...
> >=20
> > > And also based on above SDM description, I don't want to add the supp=
ort
> > > blindly now.
> > *sigh*
> >=20
> > I got filled in on the details offlist.
> >=20
> > 1) In the next version of this series, please rework it to reincorporat=
e Supervisor
> >     Shadow Stack support into the main series, i.e. pretend Intel's imp=
lemenation
> >     isn't horribly flawed.
>=20
> Let me make it clear, you want me to do two things:
>=20
> 1)Add Supervisor Shadow Stack=C2=A0 state support(i.e., XSS.bit12(CET_S))=
 into
> kernel so that host can support guest Supervisor Shadow Stack MSRs in g/h=
 FPU
> context switch.

If that's necessary for correct functionality, yes.

> 2) Add Supervisor Shadow stack support into KVM part so that guest OS is
> able to use SSS with risk.

Yes.  Architecturally, if KVM advertises X86_FEATURE_SHSTK, then KVM needs =
to
provide both User and Supervisor support.  CET_SSS doesn't change the archi=
tecture,
it's little more than a hint.  And even if the guest follows SDM's recommen=
dation
to not enable shadow stacks, a clever kernel can still utilize SSS assets, =
e.g. use
the MSRs as scratch registers.
