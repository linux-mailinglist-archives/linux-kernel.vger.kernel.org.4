Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB3601D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJQX0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJQX0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:26:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41574CF8;
        Mon, 17 Oct 2022 16:26:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrtRf5X60z4x1F;
        Tue, 18 Oct 2022 10:26:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666049198;
        bh=Q7nXCQhjB1IpxG+8Qf+yPI3n4dEos455MaZCmj9V7oQ=;
        h=Date:From:To:Cc:Subject:From;
        b=e6YxvT6scnpsee9tRsX8yVdC+0tCCNuj1s5ZWXieMF+2PnRdKx8skQuvrmolrEQe/
         K/W0OkOVsxCLKziZMQgvkVYM7sRuqCGp8s3aGL8XEzseBU61dfmwR7oMJmB10+59j2
         tjkI+fKZIzaLKSUIfWBUiXme5OByZ49tdB1KWRHjPga5Y2JDCt+5nogJv7o5DZpTj0
         NN4zlFsAk5kfwjm0BUgB1aloCnlkv3Kcr0bvV8OYEZN+w57HC0tKZpbO8quL4TMp63
         yiJ2qqr0GLEDpbYub59zG7ITY6uz+RmVRQIWScWTSG6S/pwjQRi885BZUtPpvwHcmU
         ndl/TX68B5x2A==
Date:   Tue, 18 Oct 2022 10:26:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20221018102636.347615f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HvrBl1s7CCLVfo/kbWNZNf.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HvrBl1s7CCLVfo/kbWNZNf.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

ERROR: modpost: "srcu_check_nmi_safety" [arch/x86/kvm/kvm.ko] undefined!
ERROR: modpost: "srcu_check_nmi_safety" [arch/x86/kvm/kvm-intel.ko] undefin=
ed!
ERROR: modpost: "srcu_check_nmi_safety" [arch/x86/kvm/kvm-amd.ko] undefined!
ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefine=
d!
ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!
ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/refscale.ko] undefined!
ERROR: modpost: "srcu_check_nmi_safety" [fs/dlm/dlm.ko] undefined!
ERROR: modpost: "srcu_check_nmi_safety" [drivers/pci/controller/vmd.ko] und=
efined!
ERROR: modpost: "srcu_check_nmi_safety" [drivers/char/ipmi/ipmi_msghandler.=
ko] undefined!
ERROR: modpost: "srcu_check_nmi_safety" [drivers/gpu/drm/drm.ko] undefined!
WARNING: modpost: suppressed 10 unresolved symbol warnings because there we=
re too many)

Presumably caused by commit

  54a118fce487 ("srcu: Debug NMI safety even on archs that don't require it=
")

I have used the rcu tree from next-20221017 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/HvrBl1s7CCLVfo/kbWNZNf.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNN5K0ACgkQAVBC80lX
0GzVpggAokS5w7KaYALwMm8HRZbYBOpu5qy+FewQuSy7b1sR0Kwgwir8fYer+XWN
w8BTtXzx3Br+pq1h6uJefkiMq7HFLluiAwR3fDDslpKLObN+IYzChJ8aKy2hpoOj
HJUTGcCUFoLJCm2vIpA13ghZ602hxvvQ/60kMkkOvmSkAsHNlDpJjuF5k9+cGryy
HJVfjQ9owBuO6cg46MVdFJFBtcbYoj8XZJ1Y6H1aXm4nMan9El7JUR7pUgjMbxIL
mjYKzblm3yomhxz9n9pVnOEn+W9Jg6TK2kzdJc+OpUYMuvp0cbMnxUF9gqVbOqMh
PQ91NOb/zZ97TDOXkjT0O/9zuIzAsQ==
=ttdU
-----END PGP SIGNATURE-----

--Sig_/HvrBl1s7CCLVfo/kbWNZNf.--
