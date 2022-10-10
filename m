Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8D5FA6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJJVCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiJJVBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:01:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8611EEF5;
        Mon, 10 Oct 2022 14:00:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MmWX531g7z4wgr;
        Tue, 11 Oct 2022 08:00:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665435621;
        bh=8FYTgBw2jbX8StIjEoIcfpwPlI72ucF15+bhrFkMISs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gQuVN2BZ+AGJBHD2Ys1jixNtbwfxmMLj8F3ttJr8IxGuF+Bi5t471Ay84eVFIA7Gi
         Xc7HLLylbV3PKkDuXQHstxs6v+ugtQSDQ4GE9guPiTC1vO1WgxPipxHJdCj5Mm3fmT
         qlTpE8BMvMLdqr+Qd5iETQt+r47DiW/DR0uWQGBbyQhCMtPA4SINIy1QrTjQagTVgV
         lPuxa//v7hwq8gE4pJp4sLFZdtnzgKrp+okSc4lsDuQKGwDD90po5Gw7tZxS8PJnQ1
         HosJjahXIPy23NmSz2tur21WSJXNd5indDiS5shK7RApW4xU42fJezjiUvbiOhP/h2
         JX49Ywan8al3g==
Date:   Tue, 11 Oct 2022 08:00:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the cgroup tree with the tip tree
Message-ID: <20221011080019.684aa624@canb.auug.org.au>
In-Reply-To: <20220912155941.530e4318@canb.auug.org.au>
References: <20220912155941.530e4318@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W3T1o6m.05KZVJYak6HMHY0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W3T1o6m.05KZVJYak6HMHY0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 12 Sep 2022 15:59:41 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>

> Today's linux-next merge of the cgroup tree got a conflict in:
>=20
>   kernel/cgroup/cgroup.c
>=20
> between commit:
>=20
>   34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable i=
nterface")
>=20
> from the tip tree and commit:
>=20
>   8a693f7766f9 ("cgroup: Remove CFTYPE_PRESSURE")
>=20
> from the cgroup tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc kernel/cgroup/cgroup.c
> index 3dcd2a0041b3,e24015877d3c..000000000000
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@@ -5222,8 -5159,6 +5247,7 @@@ static struct cftype cgroup_psi_files[
>   #ifdef CONFIG_PSI
>   	{
>   		.name =3D "io.pressure",
> - 		.flags =3D CFTYPE_PRESSURE,
>  +		.file_offset =3D offsetof(struct cgroup, psi_files[PSI_IO]),
>   		.seq_show =3D cgroup_io_pressure_show,
>   		.write =3D cgroup_io_pressure_write,
>   		.poll =3D cgroup_pressure_poll,
> @@@ -5231,8 -5166,6 +5255,7 @@@
>   	},
>   	{
>   		.name =3D "memory.pressure",
> - 		.flags =3D CFTYPE_PRESSURE,
>  +		.file_offset =3D offsetof(struct cgroup, psi_files[PSI_MEM]),
>   		.seq_show =3D cgroup_memory_pressure_show,
>   		.write =3D cgroup_memory_pressure_write,
>   		.poll =3D cgroup_pressure_poll,
> @@@ -5240,8 -5173,6 +5263,7 @@@
>   	},
>   	{
>   		.name =3D "cpu.pressure",
> - 		.flags =3D CFTYPE_PRESSURE,
>  +		.file_offset =3D offsetof(struct cgroup, psi_files[PSI_CPU]),
>   		.seq_show =3D cgroup_cpu_pressure_show,
>   		.write =3D cgroup_cpu_pressure_write,
>   		.poll =3D cgroup_pressure_poll,

This is now a conflict between the tip tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/W3T1o6m.05KZVJYak6HMHY0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNEh+MACgkQAVBC80lX
0GzLDgf+Lq1TidXFXdZlDSva0FHPaZhC2es7wW6EG74DTa+7X/U+7ipVD7KUghH7
IUg25BMZ+qxXqIlEFis0Na+NObVIf0NeJ8yj2McZVVu0n7REv2qgQxE0pw6t6zzS
hLFNLlkEhWiaZzMFcCo6VeAf7Wy/NOGnzy4m2E7++YqxZK9TBZS1z38uHtpFQ9vq
cBzz1DjlSAx44J6ykNLFNlnS2T5uiEx3vU70N8YwIRCYaQT4VFott7tPzwVOLDB6
OP0CGFNf2K1WjZVH2xzQWt/J8CoQGXWrUivFIumlw7uOSmCavOnc7qMxBYEXUm8c
cZNWGZbpO93gqM7srbcZzn5KG8PyPA==
=lbLE
-----END PGP SIGNATURE-----

--Sig_/W3T1o6m.05KZVJYak6HMHY0--
