Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF25FA6B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJJU7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiJJU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:58:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2837EFC5;
        Mon, 10 Oct 2022 13:58:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MmWTh0PNnz4x1D;
        Tue, 11 Oct 2022 07:58:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665435497;
        bh=d+P08bQm7lw1yI2lY2EcaHxG6OhotVqkVTSQ762CItU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J8OpcPdhboJJZyqYQSCK4f0knAqWpdbmUU6uOD0D14d2Cs4m5iPkyH6Zc3Zdz9Hep
         GDign9icoD8yaVwHl55sWeAx9bnvb0rAbSrmZQgYzstenfhCTdgNduP5qWIzOKped4
         fjgaVYCe54fGrRCi0r8P3knXo+eIQBHO+A6+9GA1CFMhdUdqcT9cBe5lIlspGwulT5
         3lsF1AI9j/0BKo67I5Iw7bE724pWJD9nOOYudD6NoA0ethoHBLZxVrs2Og84Rov0xN
         ub5t2oQoBJK6wj5Wixw6VJMh1+sxFC92Rl//WkjzAyeEive4XN+0QHtnWl44ztSgt4
         Uo5Po5BTf8/0A==
Date:   Tue, 11 Oct 2022 07:57:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cgroup tree
Message-ID: <20221011075748.3db42926@canb.auug.org.au>
In-Reply-To: <20220912161812.072aaa3b@canb.auug.org.au>
References: <20220912161812.072aaa3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6kl/oNG8V108UU=TVCV/Gag";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6kl/oNG8V108UU=TVCV/Gag
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 12 Sep 2022 16:18:12 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the cgroup tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> kernel/cgroup/cgroup.c:5275:26: error: 'CFTYPE_PRESSURE' undeclared here =
(not in a function)
>  5275 |                 .flags =3D CFTYPE_PRESSURE,
>       |                          ^~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   8a693f7766f9 ("cgroup: Remove CFTYPE_PRESSURE")
>=20
> inteacting with commits
>=20
>   52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")
>   34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable i=
nterface")
>=20
> from the tip tree.
>=20
> I have applied the following merge fix patch.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 12 Sep 2022 16:15:33 +1000
> Subject: [PATCH] sched/psi: fix up for "cgroup: Remove CFTYPE_PRESSURE"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  kernel/cgroup/cgroup.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 974ca46c6d7b..829aa42e773e 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5272,7 +5272,6 @@ static struct cftype cgroup_psi_files[] =3D {
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>  	{
>  		.name =3D "irq.pressure",
> -		.flags =3D CFTYPE_PRESSURE,
>  		.file_offset =3D offsetof(struct cgroup, psi_files[PSI_IRQ]),
>  		.seq_show =3D cgroup_irq_pressure_show,
>  		.write =3D cgroup_irq_pressure_write,
> @@ -5282,7 +5281,6 @@ static struct cftype cgroup_psi_files[] =3D {
>  #endif
>  	{
>  		.name =3D "cgroup.pressure",
> -		.flags =3D CFTYPE_PRESSURE,
>  		.seq_show =3D cgroup_pressure_show,
>  		.write =3D cgroup_pressure_write,
>  	},
> --=20
> 2.35.1

This is now a conflict between the tip tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/6kl/oNG8V108UU=TVCV/Gag
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNEh0wACgkQAVBC80lX
0GzVfgf/T4fr7DVteETpQN9rKT8kRx8msuYeKOuo797mybS1bV/vkU6eow0Z3nt9
B20Sq0ZT4qaLQJ6gx+xehEFHR3mZi5RK+jtakzh4tk8L8RJLM/SuVZ7DkYqRcnCz
YQ7uGUwoL9XkAXn19AM4+GgAfTcyx5gArX3nIwiF/iYed8igNavDrIjlIzS5Ve4m
2otSwIWjswZMvc1b5zG3ZFMtz2N+Qf+vUP+Q7X2hCTsLMj4UqQNtu+eLAt6Lxm6m
usOueRVumo8H6onChRlsjL3uZ+B2iL41+FbK+m5E1Iv5OQ52R/TLZr/jhD1xvwLT
BjYP/3Bm1kbhUNJ9upRFVov74NXnLw==
=gAW3
-----END PGP SIGNATURE-----

--Sig_/6kl/oNG8V108UU=TVCV/Gag--
