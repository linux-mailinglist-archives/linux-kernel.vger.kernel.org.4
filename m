Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E80697340
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjBOBKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjBOBKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:10:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4C932534;
        Tue, 14 Feb 2023 17:10:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGg1m5Rn3z4x5Y;
        Wed, 15 Feb 2023 12:08:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676423310;
        bh=ZKbXdOdmE6f7w60ZaJODhhxN1ctwJAr53AJUudQVy20=;
        h=Date:From:To:Cc:Subject:From;
        b=unj+ltyhrNicgXv2hCgQJB7RnCjfEPKS30w13ftlk6f5JrNaj1Nk4nGpK6IpxakSm
         F+w8HWJQikhrFOHFWAD6CptphkWf5g/UwMYRL993a5jdeS0+EWYyR2aeenS6glOyXX
         8+5zawmbCx3NFAQwy7iC9aa3bIQfEUV8w8MYxaID8j2zY4iwXctKMsRB3sfJdnp3CD
         bZVzepTHWozfRHv3q/vOOQqHmFFpZmz1aI9EjKEgfF4QiOGro5Jfyspqg/sXJMqS+1
         hX4ExPqxHqJ82c0BUXuATRiCMyL7PL5CY6rIlKPz16C22jtwuidwq83QJa0jWcpGcR
         41yY1YG9c/aSA==
Date:   Wed, 15 Feb 2023 12:08:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kim Phillips <kim.phillips@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20230215120827.4780b588@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/feiPFhMjDpNOFpg_tOwxHa_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/feiPFhMjDpNOFpg_tOwxHa_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/kernel/cpu/common.c

between commit:

  be8de49bea50 ("x86/speculation: Identify processors vulnerable to SMT RSB=
 predictions")

from Linus' tree and commit:

  e7862eda309e ("x86/cpu: Support AMD Automatic IBRS")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kernel/cpu/common.c
index f3cc7699e1e1,38646f1b5f14..000000000000
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@@ -1403,14 -1412,6 +1414,9 @@@ static void __init cpu_set_bug_bits(str
  			setup_force_cpu_bug(X86_BUG_RETBLEED);
  	}
 =20
- 	if (cpu_has(c, X86_FEATURE_IBRS_ENHANCED) &&
- 	    !cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
- 	    !(ia32_cap & ARCH_CAP_PBRSB_NO))
- 		setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
-=20
 +	if (cpu_matches(cpu_vuln_blacklist, SMT_RSB))
 +		setup_force_cpu_bug(X86_BUG_SMT_RSB);
 +
  	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
  		return;
 =20

--Sig_/feiPFhMjDpNOFpg_tOwxHa_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPsMIsACgkQAVBC80lX
0GypOwgAjr2kaRvkBEEcVar0hl3gdHJHpjKAb7Yb8E/YYZgt/L2vgNJ9cDld99Ma
2IGzLcW7n0UspOEs7KNw9C7ECm10xKMCZ1B5nty1cu3931GBf7rS1a9HvtbG6zJS
m98efkQSKhR4/RLtg4xoQjEnsq+nerOiygh9TM6KBCvesuDWbx1I30AQ1WeAM3O+
3bFg8hYodgOFAUHkJYes0k7Ag5MD9Gb7bhRHPhtJP14R+6C6G9aJSFzVESz/evlH
NL2r+e5m7azzpa1aFSyLsnc7cmDNGDMYiisgamOwIjGEfJ2lkDLqv9kzB8m1b5ZZ
7UF51pb4Zie5OftJkodN2s9UKhCpFQ==
=uR2J
-----END PGP SIGNATURE-----

--Sig_/feiPFhMjDpNOFpg_tOwxHa_--
