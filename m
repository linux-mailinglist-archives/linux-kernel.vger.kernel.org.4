Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC06DD09D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDKEBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDKEBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:01:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F01BF7;
        Mon, 10 Apr 2023 21:00:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwXFP1f1mz4xDh;
        Tue, 11 Apr 2023 14:00:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681185657;
        bh=A4xtdtTFZHDa5jhDkwr5zZ0PTsE0F+cWAuO7NEPKLLc=;
        h=Date:From:To:Cc:Subject:From;
        b=WQVv+GC8XX3wIlgW6dPN0KX4qzcdyIffSXdT5HBA2Eq/apOqRBnO6vGeZfOz39uq/
         tnWXFu1VfOm8zLVNihHV3bhEIqiqO8JOf6mN26VlKx8cV4YSD5spsN57ezvA/HNm6c
         XbKEJoabwn4lzQzrtWmOl6IEMfvDoz5TTY3B5/9OGQSvfrOTq4k0nYtQ1it7B0GQis
         MSUvshrS0YHs/t91yQMyKt8jTJObBsuTfJXMEJXn6tV4UpJxR2FOwpyN+mJHWTfzLS
         VWoD7TklslDazmzbl2vYjWhPC0ym8CO2aAGrGeCTto37vr8bv25IuOu2s7aV5qGu24
         HiucDb09Z+rbg==
Date:   Tue, 11 Apr 2023 14:00:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kvm-x86 tree
Message-ID: <20230411140055.648cda0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4a2Dc2WgUDXKT0Z8P1oEAeG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4a2Dc2WgUDXKT0Z8P1oEAeG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm-x86 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

arch/x86/kvm/svm/svm.c: In function 'svm_flush_tlb_all':
arch/x86/kvm/svm/svm.c:3852:17: error: implicit declaration of function 'hv=
_remote_flush_tlb' [-Werror=3Dimplicit-function-declaration]
 3852 |                 hv_remote_flush_tlb(vcpu->kvm);
      |                 ^~~~~~~~~~~~~~~~~~~

Caused by commit

  8a1300ff9518 ("KVM: x86: Rename Hyper-V remote TLB hooks to match establi=
shed scheme")

interacting with commit

  e5c972c1fada ("KVM: SVM: Flush Hyper-V TLB when required")

from Linus' tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 11 Apr 2023 13:21:46 +1000
Subject: [PATCH] fixup for "KVM: x86: Rename Hyper-V remote TLB hooks to ma=
tch established scheme"

interacting with "KVM: SVM: Flush Hyper-V TLB when required"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/kvm/kvm_onhyperv.h | 2 +-
 arch/x86/kvm/svm/svm.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/kvm_onhyperv.h b/arch/x86/kvm/kvm_onhyperv.h
index 2d5f669c1ea1..f9ca3e7432b2 100644
--- a/arch/x86/kvm/kvm_onhyperv.h
+++ b/arch/x86/kvm/kvm_onhyperv.h
@@ -11,7 +11,7 @@ int hv_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn=
, gfn_t nr_pages);
 int hv_flush_remote_tlbs(struct kvm *kvm);
 void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root_tdp);
 #else /* !CONFIG_HYPERV */
-static inline int hv_remote_flush_tlb(struct kvm *kvm)
+static inline int hv_flush_remote_tlbs(struct kvm *kvm)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a9c940a31f3a..ca32389f3c36 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3843,13 +3843,13 @@ static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * When running on Hyper-V with EnlightenedNptTlb enabled, remote TLB
-	 * flushes should be routed to hv_remote_flush_tlb() without requesting
+	 * flushes should be routed to hv_flush_remote_tlbs() without requesting
 	 * a "regular" remote flush.  Reaching this point means either there's
-	 * a KVM bug or a prior hv_remote_flush_tlb() call failed, both of
+	 * a KVM bug or a prior hv_flush_remote_tlbs() call failed, both of
 	 * which might be fatal to the guest.  Yell, but try to recover.
 	 */
 	if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
-		hv_remote_flush_tlb(vcpu->kvm);
+		hv_flush_remote_tlbs(vcpu->kvm);
=20
 	svm_flush_tlb_asid(vcpu);
 }
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/4a2Dc2WgUDXKT0Z8P1oEAeG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ023cACgkQAVBC80lX
0GzeyQgAoTo2eTjTSqA6cPuYq+4MoLa+595YDoAa7db9U5D0fhNgyoocsed908Rw
P+iPw5VP+9CXNIZKXOdvOEax0WocrOKvjHzKf7SsAjTU7SGvuJxz0vMZcjS1J3N9
R+tndyUOvBm5TQyfiVVgeX/NabtLkFTRz3mlcaMESwybPGiUseyT8JDjtYYWPNKc
RHgpb6353oKBZtMkozWg+oWnAzYefYEJJNPcDY3oSnprxzvkOFRpM0VDF2wFJg6W
aCmYr3B1GyBG1Uap+8ePrxjs4uvyz83EsKC+V/W0aYYWHKS2c/phgKZT7XC3TnNF
GOY1F17tTnBxi0Cw/Z0zZ3+hpjbrBQ==
=Wgqd
-----END PGP SIGNATURE-----

--Sig_/4a2Dc2WgUDXKT0Z8P1oEAeG--
