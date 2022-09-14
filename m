Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00865B8123
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiINFz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiINFzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:55:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999255B7B9;
        Tue, 13 Sep 2022 22:55:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MS8h751hKz4xD1;
        Wed, 14 Sep 2022 15:55:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663134936;
        bh=NfEmZq6Sx6fDVfmEUSsnlkgd0Drx7kbKPxREj7cu23A=;
        h=Date:From:To:Cc:Subject:From;
        b=IoXztMp6nijyIXeFz+yu4shv7yVmgvKVHaQryeCyPOWhVOpY4ggK7Qjl5SMeAihZP
         jy3oGpDc2kVAhA9VWGtj1avdgeFeoklvlA7dpexVAAMv3NXD1DD/7B58m41V8iR/BO
         4i9sOyYdHTwOhDPo6A31I1piiLr+tf7fFX9cJp64DFUSfiDRAOtFb2HDVzFKmJBc+q
         j8oUXEo339Stf9QrEwXd3vojiQtsz2NzLsC/qyv7Nhr+8XHa5vQUvdjjC6zlA/MZq8
         p7aJQOnKAemQ/++YcHfTTnGpvYy+0AfcvEWUXtckbCGf5fiS1vt0i+HH5yZU5YbQ73
         6UDpxuDs2FY2w==
Date:   Wed, 14 Sep 2022 15:55:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with the execve tree
Message-ID: <20220914155533.70c10493@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p._F.fVWJ=gm4OzKmoZmt6Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p._F.fVWJ=gm4OzKmoZmt6Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  fs/exec.c

between commit:

  33a2d6bc3480 ("Revert "fs/exec: allow to unshare a time namespace on vfor=
k+exec"")

from the execve tree and commit:

  33a2d6bc3480 ("Revert "fs/exec: allow to unshare a time namespace on vfor=
k+exec"")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/exec.c
index 3f69e5c1a622,afe55d0c3bcf..000000000000
--- a/fs/exec.c
+++ b/fs/exec.c
@@@ -1023,9 -1029,12 +1026,9 @@@ static int exec_mmap(struct mm_struct *
  	activate_mm(active_mm, mm);
  	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
  		local_irq_enable();
- 	tsk->mm->vmacache_seqnum =3D 0;
- 	vmacache_flush(tsk);
  	task_unlock(tsk);
+ 	lru_gen_use_mm(mm);
+=20
 -	if (vfork)
 -		timens_on_fork(tsk->nsproxy, tsk);
 -
  	if (old_mm) {
  		mmap_read_unlock(old_mm);
  		BUG_ON(active_mm !=3D old_mm);

--Sig_/p._F.fVWJ=gm4OzKmoZmt6Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMhbNUACgkQAVBC80lX
0GzTAAf+JMjF0JAOaFmsc7XY38c81PJBCnKsganJrIS4B6tuqBRe34UTkF7flP4u
Ffd3E9tNRnKcovsczVcspnfhUagw7AevXy/xoZMZtmlxMkrDULUe7CftQSEhg09K
zLMxrxILtO+AVSyooche4131G/GtMItzUXLU7GnMtuMDMxMn1ZSUS8R/6FgXtxfv
GKh4EAT+ZEe+mg4uFRD0n1rwZwqetsk2MuHqM3rqxjY2GS0Ua4zUEFThc6Da6nID
2YXIa0mwfEiVsOsa6kRpQPJuTjjyFsokaRGTfcnoTPnUIM0Rk5ubMKsv438LogpV
LEIucL8uKGkSMxNsKr/mhwW2VddEow==
=DZx5
-----END PGP SIGNATURE-----

--Sig_/p._F.fVWJ=gm4OzKmoZmt6Y--
