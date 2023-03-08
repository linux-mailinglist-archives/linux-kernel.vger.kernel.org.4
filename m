Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6066B11EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCHTUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCHTUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:20:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF775CB051
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:20:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d185-20020a25e6c2000000b008fa1d22bd55so18834813ybh.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 11:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678303229;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXztXyvrvN9bsakbPlodS5GFLpkk++yypcbAWFMSHmY=;
        b=p8FeuFkAu3sszD5MFXuoYTac3YpRSaOdjg3pD9dnMlJ3DlQ4pasDn5FQFWks3+M8zc
         H7fNbl88cgGbcYqrVBsH2ZkYQ6okotRXciGWra8YMOw1ssL4XEO+CHzFZ3nWwWqNYKLq
         DIBR0q10OXZCUIfMkyi11/dFqwLlhaLjlLpn0yJWZDOA5v1UnLt2yZoC0Q3N6sWns1Vz
         cgMRilljVCp4kmAsSRdmwkFZjvCV42m+Z8GIwP6DDirdJ2OdHS6At1eEf+5mrHetOvSX
         3tK5eCn7ObP6jxwvuhoOXo74MHsCSINzUeSIdQyid3FMolBWYaKz28st3vp9wIxpvq0F
         dDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303229;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXztXyvrvN9bsakbPlodS5GFLpkk++yypcbAWFMSHmY=;
        b=1hgyK8xse2kmibs7aOxYMJChiFDfB9qwPbjIUL/jDkPZTd79iKwCGP0csJBOopAlXM
         7IMeNcqxlMVLXOnj/Q6XKmiB2kSyjRoWLUicQ+pi3dpFfKYZAtT8jVIkr+WGCc8I5ZTL
         AVGw4ubd3dQ1NCuovszIgeVzSTMxvdMPzvAaZA9Z2P5qozRC7KJ8FhpCi1jbULbEM7l1
         MKYoGU1Gk5K8+fkExRtzz+SaXGRBaI6gsJDwJkg6t+9QYGx8nLb29JyqwdN0nPajJlIb
         mVHSrfNyDxk80gMai9eQ1+4FOnITHeNqgembHQ1Lpk9tyb3Y5d7pRcNx86Kl/dwHT9j4
         YKtg==
X-Gm-Message-State: AO0yUKVkImL+PKwrKkRR9wOEOQKgK3GKDaDwPqCFiNlYSVyq3ZyjwgC+
        uTLzpW6vDINIjKIe9ctv2dfqcaSEzDQ=
X-Google-Smtp-Source: AK7set+932HDdiP+gklWVGvRUySVpn3/TrBoNZcPqjk1lCBt9IoujaL82YBg5Exc/4XVOLmvfAyJCzdF85g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:208:b0:9fe:195a:ce0d with SMTP id
 j8-20020a056902020800b009fe195ace0dmr9258740ybs.10.1678303229120; Wed, 08 Mar
 2023 11:20:29 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:20:27 -0800
In-Reply-To: <c940389f-c086-9d0e-7150-f57b3866ae82@linux.microsoft.com>
Mime-Version: 1.0
References: <20230227171751.1211786-1-jpiotrowski@linux.microsoft.com>
 <ZAd2MRNLw1JAXmOf@google.com> <CABgObfa1578yKuw3sqnCeLXpyyKmMPgNaftP9HCdgHNM9Tztjw@mail.gmail.com>
 <ZAfZPA5Ed7STUT2B@google.com> <fb088e26-8c9c-bcac-6083-5945d2d9c16e@linux.microsoft.com>
 <c940389f-c086-9d0e-7150-f57b3866ae82@linux.microsoft.com>
Message-ID: <ZAjf+8D5/HhZxGyR@google.com>
Subject: Re: [PATCH] KVM: SVM: Disable TDP MMU when running on Hyper-V
From:   Sean Christopherson <seanjc@google.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023, Jeremi Piotrowski wrote:
> On 08/03/2023 16:55, Jeremi Piotrowski wrote:
> >=20
> >=20
> > On 08/03/2023 01:39, Sean Christopherson wrote:
> >> On Wed, Mar 08, 2023, Paolo Bonzini wrote:
> >>> On Tue, Mar 7, 2023 at 6:36=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> >>>> Thinking about this more, I would rather revert commit 1e0c7d40758b =
("KVM: SVM:
> >>>> hyper-v: Remote TLB flush for SVM") or fix the thing properly strait=
away.  KVM
> >>>> doesn't magically handle the flushes correctly for the shadow/legacy=
 MMU, KVM just
> >>>> happens to get lucky and not run afoul of the underlying bugs.
> >>>
> >>> I don't think it's about luck---the legacy MMU's zapping/invalidation
> >>> seems to invoke the flush hypercall correctly:
> >>
> >> ...for the paths that Jeremi has exercised, and for which a stale TLB =
entry is
> >> fatal to L2.  E.g. kvm_unmap_gfn_range() does not have a range-based T=
LB flush
> >> in its path and fully relies on the buggy kvm_flush_remote_tlbs().
> >>
> >=20
> > Why do you say "buggy kvm_flush_remote_tlbs"? kvm_flush_remote_tlbs cal=
ls the hypercall
> > that is needed, I don't see how this might be an issue of a missing "ra=
nge-based TLB flush".
> >=20
> > kvm_unmap_gfn_range is called from kvm_mmu_notifier_invalidate_range_st=
art and 'flush_on_ret=3Dtrue'
> > is set, so it is followed by kvm_flush_remote_tlbs which calls hv_remot=
e_flush_tlb.
> >=20
> >> In other words, KVM is getting lucky :-)
> >>
> >>> Jeremi, did you ever track the call stack where
> >>> hyperv_nested_flush_guest_mapping is triggered?
> >>
> >> I don't think it matters.  As above, it only takes one path where KVM =
is fully
> >> relying on kvm_flush_remote_tlbs() for the whole thing to fall apart
>=20
> Slowly I'm starting to understand what we've been talking about, thank yo=
u :)
>=20
> Paolo/Sean, what do you think about smth like the following, except I wou=
ld make
> it SVM only, and I'd need to think about what to do with the return.
> I believe this accurately reflects what the optimization is about. hv_tra=
ck_root_tdp
> is called from kvm_mmu_load_pgd, which covers both kvm_mmu_load and kvm_m=
mu_new_pgd
> (which requests KVM_REQ_LOAD_MMU_PGD).

It's close, but KVM doesn't *always* need to flush when loading a root.  KV=
M needs
to flush when loading a brand spanking new root, which is the kvm_mmu_load(=
) path.
But when KVM loads a root via KVM_REQ_LOAD_MMU_PGD/kvm_mmu_new_pgd(), a flu=
sh may
or may not be necessary, e.g. if KVM reuses an old, but still valid, root (=
each
vCPU has a 3-entry root cache) and a TLB flush isn't architecturally requir=
ed, then
there is no need to flush.

And as mentioned in the other tendril of this thread, I'd really like to fi=
x
svm_flush_tlb_current() since it's technically broken, even though it's hig=
hly
unlikely (maybe even impossible?) to cause issues in practice.

> diff --git a/arch/x86/kvm/kvm_onhyperv.c b/arch/x86/kvm/kvm_onhyperv.c
> index 482d6639ef88..6a5bd3cbace8 100644
> --- a/arch/x86/kvm/kvm_onhyperv.c
> +++ b/arch/x86/kvm/kvm_onhyperv.c
> @@ -29,6 +29,18 @@ static inline int hv_remote_flush_root_tdp(hpa_t root_=
tdp,
>  		return hyperv_flush_guest_mapping(root_tdp);
>  }
> =20
> +static int hv_vcpu_flush_tlb_current(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_arch *kvm_arch =3D &vcpu->kvm->arch;
> +	hpa_t root_tdp =3D vcpu->arch.hv_root_tdp;
> +	int ret;
> +
> +	ret =3D hyperv_flush_guest_mapping(root_tdp);
> +	if (!ret)
> +		kvm_arch->hv_root_tdp =3D root_tdp;
> +	return ret;
> +}
> +
>  int hv_remote_flush_tlb_with_range(struct kvm *kvm,
>  		struct kvm_tlb_range *range)
>  {
> @@ -101,8 +113,10 @@ void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t =
root_tdp)
>  	if (kvm_x86_ops.tlb_remote_flush =3D=3D hv_remote_flush_tlb) {
>  		spin_lock(&kvm_arch->hv_root_tdp_lock);
>  		vcpu->arch.hv_root_tdp =3D root_tdp;
> -		if (root_tdp !=3D kvm_arch->hv_root_tdp)
> +		if (root_tdp !=3D kvm_arch->hv_root_tdp) {
>  			kvm_arch->hv_root_tdp =3D INVALID_PAGE;
> +			hv_vcpu_flush_tlb_current(vcpu);
> +		}
>  		spin_unlock(&kvm_arch->hv_root_tdp_lock);
>  	}
>  }
>=20
