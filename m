Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988366F82F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjEEMaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjEEMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:30:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E61A614;
        Fri,  5 May 2023 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683289849; x=1714825849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XweA9V5HDK7utS7/TPunyp7LYfGFUrdjDqzcDo9MXNU=;
  b=fXMERubuWER2rQhyEN+ty1aACtUoyeBzVq0Ef/t0H5DvnZk5x3iUyJFO
   8ADq6bSnfRpkgW1WllwEcLDVH9C4fgSkGjAHPlz3NyU91ffI1UWCa6Vai
   e14QzOH+ABE9yH75Pek9WCqlpDeh4obimsfhCxGAjVn52EQWdzCgH23yu
   Fc+928q+t7zeKh6v/E9qGg9b3VSXJ8jNomj4Rziy6nEG1oIpabipIk3dt
   kio0iVMTRFilLG1tT7Ao+jvsy9a/J6dymu3IQYLSExNs3+P9RAPjbm0a3
   N52/FOl8HP+ua6WlqP0EH93dsToENd6fAvyOIRR3MVZVkayDF/gMdlDbt
   g==;
X-IronPort-AV: E=Sophos;i="5.99,252,1677567600"; 
   d="asc'?scan'208";a="150539472"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 05:30:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 05:30:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 5 May 2023 05:30:34 -0700
Date:   Fri, 5 May 2023 13:30:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
CC:     Conor Dooley <conor@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <llvm@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
Message-ID: <20230505-subsidy-shininess-46a8be31b267@wendy>
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
 <20230501-cottage-overjoyed-1aeb9d72d309@spud>
 <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HCjo7mmLcFsfwCMI"
Content-Disposition: inline
In-Reply-To: <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HCjo7mmLcFsfwCMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2023 at 09:54:43PM +0200, Ricardo Ribalda wrote:
> On Mon, 1 May 2023 at 19:41, Conor Dooley <conor@kernel.org> wrote:
> > On Mon, May 01, 2023 at 02:38:22PM +0200, Ricardo Ribalda wrote:
> > > If PGO is enabled, the purgatory ends up with multiple .text sections.
> > > This is not supported by kexec and crashes the system.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_pura=
gory")
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  arch/riscv/purgatory/Makefile | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Mak=
efile
> > > index 5730797a6b40..cf3a44121a90 100644
> > > --- a/arch/riscv/purgatory/Makefile
> > > +++ b/arch/riscv/purgatory/Makefile
> > > @@ -35,6 +35,11 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
> > >  CFLAGS_string.o :=3D -D__DISABLE_EXPORTS
> > >  CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS
> > >
> > > +# When profile optimization is enabled, llvm emits two different ove=
rlapping
> > > +# text sections, which is not supported by kexec. Remove profile opt=
imization
> > > +# flags.
> > > +KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-u=
se=3D%,$(KBUILD_CFLAGS))
> >
> > With the caveat of not being au fait with the workings of either PGO or
> > of purgatory, how come you modify KBUILD_CFLAGS here rather than the
> > purgatory specific PURGATORY_CFLAGS that are used later in the file?
>=20
> Definitely, not a Makefile expert here, but when I tried this:
>=20
> @@ -35,6 +40,7 @@ PURGATORY_CFLAGS_REMOVE :=3D -mcmodel=3Dkernel
>  PURGATORY_CFLAGS :=3D -mcmodel=3Dlarge -ffreestanding
> -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS +=3D $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFI=
LING
>  PURGATORY_CFLAGS +=3D -fno-stack-protector
> +PURGATORY_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D%
> -fprofile-use=3D%,$(KBUILD_CFLAGS))
>=20
> It did not work.

Unfortunately I am oh-so-far from an expert on this kind of thing, but I
had thought that PURGATORY_CFLAGS_REMOVE was intended for this sort of
purpose.

> Fixes: bde971a83bbf ("KVM: arm64: nvhe: Fix build with profile optimizati=
on")
>=20
> does this approach, so this is what I tried and worked.

That doesn't have a specific CFLAGS though afaict.
Perhaps Nick etc have a more informed opinion here than I do, sorry.

Thanks,
Conor.

> > > +
> > >  # When linking purgatory.ro with -r unresolved symbols are not check=
ed,
> > >  # also link a purgatory.chk binary without -r to check for unresolve=
d symbols.
> > >  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
> > >
> > > --
> > > 2.40.1.495.gc816e09b53d-goog
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
>=20
>=20
> --=20
> Ricardo Ribalda

--HCjo7mmLcFsfwCMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFT21wAKCRB4tDGHoIJi
0vY1AP9RxvKzAScY63Nnz9Vp/3U8917fwYnV71pbtJgtzZt3WAEA8S2SNODAX7Qy
Vn7vxaBudJDiNoZ4dz80u4gzoYd3SwE=
=X4se
-----END PGP SIGNATURE-----

--HCjo7mmLcFsfwCMI--
