Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AB070B2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjEVBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEVBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:45:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72365AF;
        Sun, 21 May 2023 18:45:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPgHh2Lqhz4x3x;
        Mon, 22 May 2023 11:45:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684719904;
        bh=L+YD1Ezs0C5v+60PQcDAlX8fBslJaqpGa0Z+MAhmVEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SxOuzyONkegw2MokXBgep1RlS4g10FGKCn1DXXHdSAIeDraox5hjUDNQeqM/RjDRp
         s9qgv0zzsbprb9oNmjgmLj66kBuIHINz6G50wBugjacrAyDweE3QL4Nq2eKdd1vuPj
         jFfRvJ92V3wjSfUKoyNf1XbYRfICgIwxpvG+m93mJ/nFTYLuWF+CxPAznxl+QarYvz
         HllKeuIS+aqRG3OheUFXAbkAtlo1QZ7W2MGx1lvknJPRmkEg4U4cf4iqwRe6dp8zz5
         L4R9jipYHsLgBIXizBZ6+NLJa9N054Y8VPAb9ZrH125qirVZpdck1mgzKLJp4crNaB
         j3O88hgXYuI1Q==
Date:   Mon, 22 May 2023 11:45:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <20230522114503.7404d59c@canb.auug.org.au>
In-Reply-To: <cc4ab028-cad3-413b-8360-ea34f6914ec7@paulmck-laptop>
References: <20230519105950.2d021e86@canb.auug.org.au>
        <cc4ab028-cad3-413b-8360-ea34f6914ec7@paulmck-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fFHjrGlBDbpnRwH_Au2RIoC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fFHjrGlBDbpnRwH_Au2RIoC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Thu, 18 May 2023 19:12:52 -0700 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>
> On Fri, May 19, 2023 at 10:59:50AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the rcu tree, today's linux-next build (x86_64 allmodconf=
ig)
> > failed like this:
> >=20
> > kernel/rcu/rcuscale.c:340:27: error: 'get_rcu_tasks_trace_gp_kthread' u=
ndeclared here (not in a function); did you mean 'show_rcu_tasks_trace_gp_k=
thread'?
> >   340 |         .rso_gp_kthread =3D get_rcu_tasks_trace_gp_kthread,
> >       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                           show_rcu_tasks_trace_gp_kthread
> >=20
> > Caused by commit
> >=20
> >   9bb839a83e1b ("rcuscale: Measure grace-period kthread CPU time")
> >=20
> > CONFIG_RCU_SCALE_TEST=3Dm
> >=20
> > I have used the rcu tree from next-20230518 for today. =20
>=20
> Huh.  Modules and #ifdefs trip me up again.  Will fix, and thank you
> for catching it!

This is now:

ERROR: modpost: "get_rcu_tasks_trace_gp_kthread" [kernel/rcu/rcuscale.ko] u=
ndefined!

I have used the rcu tree from next-20230518 again for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/fFHjrGlBDbpnRwH_Au2RIoC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRqyR8ACgkQAVBC80lX
0Gz7rAf/Zd9VNQKbS2JZ+nYo0w0HbjT1yFonbr0f/37EEKItZjWoPqSOVCfYfV52
9prgvhXlodLBIY9OxTwdoggeOMcoTW2EODEm3qy1bPbzU8Hg+71FgTwPH9GeR0Ht
lzSfjDB1paC68jnX8SeTYds9X1+mR8ZSu9qzTBz3FgQIct+KpShQVqu+Xc8w/6Be
D2Zakao790Yr9sFMUF8VGaobe9Gs8ZRx241pMdJiQrhf1kfwenWvQNFfpwI6ReTc
zLvK5wbhGsf+tA7E26A9kovSSz66VnDsx5zw3bNMU3ssH9UwiyWRH4kImAp9OTB/
mjkbnRjw3JD5XuE061HstBUXRjpwWQ==
=23Ct
-----END PGP SIGNATURE-----

--Sig_/fFHjrGlBDbpnRwH_Au2RIoC--
