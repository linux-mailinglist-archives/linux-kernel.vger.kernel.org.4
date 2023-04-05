Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8FA6D7FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbjDEOgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbjDEOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:36:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AC30CD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:36:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z4-20020a25bb04000000b00b392ae70300so35889402ybg.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680705405;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWivmQTSE7fXCajVfyJAnAM0Fpds1MOJIBUOFkpZKxM=;
        b=kggaAQUE346YPq4F5Egzxk9gnUAUBuyU9eRijnJTa16NS9m5MPPr5LYT8UaGGH/cdf
         IHQln9rwwqV9rdfN3kkWvwCBg1+p0+HxNriWaYcGxMslx9+/6ihwBOKb1B/jhjeZ6HZe
         /sIS9gFJqkscK3rkuWZSIqQfyLIexGTtiF9e/ggd469qc1hK0Wp4RXWB5FlXCUThTqsC
         ZnKRDMK97Fw9uxDXFCICbN88pk+oEtahhcJ595Xcp87qTpuVk9/ZxpEqx9T10Ownafuu
         xrAcPnUvWE9aWCA3bR9xOOEh2tYKOsjYy8zbE2z5I5dkFBT0zzNPdWJwMVA72gQ3bp1+
         bkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680705405;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RWivmQTSE7fXCajVfyJAnAM0Fpds1MOJIBUOFkpZKxM=;
        b=LbgnxlxxFg7mHcbIWAGmwfzC0/Cg37cnx4QP2xbvqJVicsEONtN5TPMD5lKQZJcuOD
         CwECeyZ5xZh0gf48iDqcAY8q7ytCPW0BBpNFBzFs0cCGDGNJHWtP6InHhMGRSYk1ztIE
         MQOSkwtE/k37ZCRQkKDxq1DTihkHlt6HeJoGTQA5ZnmmNT9Zz/r/56Vu9amRH4pZGzck
         7XxM3wqnhelNd14v/whOVmOlYFFFaowP/02Dry7ejHfgnA9bzwhmYSacBmcGl0XkQ+C2
         d7hRgZLhjwK3QTgZ68WrKMyZvQnd87hUUox4HdRRqtzyZSHuchNA5aQtRJyvYoElYMr9
         ri/w==
X-Gm-Message-State: AAQBX9d2fmlujmqOMfT8mqZC3EG1paR/gXg4wU4eBDpfRUt6DkiOqxIy
        gdWen0yCiu0aruo/QyYqk9KxZMwAvMc=
X-Google-Smtp-Source: AKy350Z1dNW+aToDyrzxNFqh4wc1xDAYoEZD2hNl0NzK1mj47aj/7EWCL/Y2XMuGzAaiEyKX1syzZjmJR+Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ccd3:0:b0:b31:34ab:5ca0 with SMTP id
 l202-20020a25ccd3000000b00b3134ab5ca0mr3705641ybf.11.1680705405554; Wed, 05
 Apr 2023 07:36:45 -0700 (PDT)
Date:   Wed, 5 Apr 2023 07:36:44 -0700
In-Reply-To: <a1ed2308-b521-14c0-a118-19c1afffd1d6@grsecurity.net>
Mime-Version: 1.0
References: <20230405002608.418442-1-seanjc@google.com> <a1ed2308-b521-14c0-a118-19c1afffd1d6@grsecurity.net>
Message-ID: <ZC2HfNLa7sLewJtl@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Refresh CR0.WP prior to checking for
 emulated permission faults
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Apr 05, 2023, Mathias Krause wrote:
> On 05.04.23 02:26, Sean Christopherson wrote:
> > +void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
> > +					struct kvm_mmu *mmu)
> > +{
> > +	const bool cr0_wp =3D kvm_is_cr0_bit_set(vcpu, X86_CR0_WP);
> > +
> > +	BUILD_BUG_ON((KVM_MMU_CR0_ROLE_BITS & KVM_POSSIBLE_CR0_GUEST_BITS) !=
=3D X86_CR0_WP);
>=20
> > +	BUILD_BUG_ON((KVM_MMU_CR4_ROLE_BITS & KVM_POSSIBLE_CR4_GUEST_BITS));
>=20
> Just curious, this should assert that we don't run into similar issues
> if we make more bits of CR4 guest owned?

Yes?  I'm not sure what you're asking.  BUILD_BUG_ON() is a just more flexi=
ble
version of stiatic_assert(); it only requires that the inputs be compile-ti=
me
constants, not purely "static".

he above throws an error at compile-time if there is new overlap between th=
e
CR{0,4} MMU role bits and the possible guest-owned bits.  E.g. adding SMEP =
to the
possible guest-owned CR4 bits yields:

arch/x86/kvm/mmu/mmu.c: In function =E2=80=98__kvm_mmu_refresh_passthrough_=
bits=E2=80=99:
include/linux/compiler_types.h:397:45: error: call to =E2=80=98__compiletim=
e_assert_1564=E2=80=99
 declared with attribute error: BUILD_BUG_ON failed: (KVM_MMU_CR4_ROLE_BITS=
 & KVM_POSSIBLE_CR4_GUEST_BITS)
  397 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:378:25: note: in definition of macro =E2=80=
=98__compiletime_assert=E2=80=99
  378 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:397:9: note: in expansion of macro =E2=80=98=
_compiletime_assert=E2=80=99
  397 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=98compi=
letime_assert=E2=80=99
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro =E2=80=98BUILD_=
BUG_ON_MSG=E2=80=99
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
arch/x86/kvm/mmu/mmu.c:5191:9: note: in expansion of macro =E2=80=98BUILD_B=
UG_ON=E2=80=99
 5191 |         BUILD_BUG_ON((KVM_MMU_CR4_ROLE_BITS & KVM_POSSIBLE_CR4_GUES=
T_BITS));
      |         ^~~~~~~~~~~~
scripts/Makefile.build:252: arch/x86/kvm/mmu/mmu.o] Error 1

