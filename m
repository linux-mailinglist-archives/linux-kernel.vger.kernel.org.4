Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CC263822D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKYBtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYBtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:49:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C1382;
        Thu, 24 Nov 2022 17:49:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJHq35b6sz4x1V;
        Fri, 25 Nov 2022 12:49:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669340975;
        bh=cFHjJHs2OCG5LMhL4SqQudruyuLLlXQZP0zM46EXko0=;
        h=Date:From:To:Cc:Subject:From;
        b=BU527dvAeq+la3m+Pl3ImiGot0C/BU7InulFHO+cMxW5erLjgflXNxlYtVR9eQASQ
         6qTKXFoJ73YnrselQM+Oml3gMFgl1i3k6u4ObxRe61dZNB7E1SrQ0DcUp9u1LRTkfV
         MomaK0Prro7Bdaw+wax5QFtkbL1f9U4UYPmHjf1wzfko2ulBimigqUPnSTn6lqldpe
         IgWQ9QzMvOxZm+fjZuH8XMVrRUuDWorZvxkbVPLpGxvAIy9Gu93/MMAymvuWSJZ/U4
         6peFPLDtChPFe3crXl5syybPSCVoBIwZhyct4cI2S3nzQNCeebnu2LRsPZ723unf/c
         iOLls6FKyKj4g==
Date:   Fri, 25 Nov 2022 12:49:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the slab tree
Message-ID: <20221125124934.462dc661@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xd18/g3M8xzGOLzq5EVK028";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xd18/g3M8xzGOLzq5EVK028
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the slab tree, today's linux-next build (x86_64
allmodconfig) failed like this:

mm/slub.c:965:13: error: 'freelist_corrupted' defined but not used [-Werror=
=3Dunused-function]
  965 | static bool freelist_corrupted(struct kmem_cache *s, struct slab *s=
lab,
      |             ^~~~~~~~~~~~~~~~~~

Caused by commit

  f6e94ad44e77 ("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")

I have used the slab tree from next-20221123 again.

--=20
Cheers,
Stephen Rothwell

--Sig_/xd18/g3M8xzGOLzq5EVK028
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOAHy4ACgkQAVBC80lX
0Gx1dwf/UkQ8IYj8cfPydpbywWxXghgB6k5MpSC562FouC1Sxx0AGLQvDZV7UGcq
nJlPiBtZwx/U8wh09Seyv7n7OIM2eJlmTxzeeX6jfMjJdyUDcOJqypw0FDl4WuoV
X4a2VWsXtDLyuK8wHU2s4cvD/UQ+1HCtmTqg1XN9iRUhPS4VRQb6/Ldv6OdYUf6o
t3M/FVMgkQ0hUYJ/HsQyuD4q5ozUS5rmh7fdXBNzCm3S7SuaJVH6Dg0KH5v2yw3O
+RCHghsUTJGMuQJehgoqSfG4WYO5Ca6aPajX9Gl8OCCw5VHiKOe6MleklnvSl4yn
TI26X9oylAgjNEVcVCWc5NDS+6WY1g==
=h9li
-----END PGP SIGNATURE-----

--Sig_/xd18/g3M8xzGOLzq5EVK028--
