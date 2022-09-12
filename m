Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4824B5B53B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiILF7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILF7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:59:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DD864CC;
        Sun, 11 Sep 2022 22:59:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQwsp4bqkz4xDK;
        Mon, 12 Sep 2022 15:59:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662962384;
        bh=4Cy88NTKj6+UEtZEhvAHYVxnMHG/azrPKm7tLgF+5EE=;
        h=Date:From:To:Cc:Subject:From;
        b=asOWi269Sh07w5zA/qMXS1WBPQoeAVujGdi3k07K02A0k2615ZIt4HZB3atdrV1s+
         uwF8TcxY+BxQIld4wj4WBcXdosbAeIcRhYhrvKWFpoiEvKKIhk0d8jmWThB1NKOxA5
         IU3CAhjOhiRXOxWuGNO2r7ZkE560j5MQT9nov+/9OEgEkOloxewopHBht5IgS6jc88
         gLJXsCKlHwhu7vLjQZABPsFOMiczy+zoQKkXMkz0KN5aHangnzG5rbFmTgpBXxgrlV
         ltFPRCit3ZcaN4ugB8TIaWjVjZfdCvdBuzbso0DpxIHr6jxFGMlHHl0xUN6I/+uWjl
         XtvIbDB2wIX1A==
Date:   Mon, 12 Sep 2022 15:59:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the cgroup tree with the tip tree
Message-ID: <20220912155941.530e4318@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vYbzmSrv_qwdyivZZwlUxFV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vYbzmSrv_qwdyivZZwlUxFV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cgroup tree got a conflict in:

  kernel/cgroup/cgroup.c

between commit:

  34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable int=
erface")

from the tip tree and commit:

  8a693f7766f9 ("cgroup: Remove CFTYPE_PRESSURE")

from the cgroup tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/cgroup/cgroup.c
index 3dcd2a0041b3,e24015877d3c..000000000000
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@@ -5222,8 -5159,6 +5247,7 @@@ static struct cftype cgroup_psi_files[
  #ifdef CONFIG_PSI
  	{
  		.name =3D "io.pressure",
- 		.flags =3D CFTYPE_PRESSURE,
 +		.file_offset =3D offsetof(struct cgroup, psi_files[PSI_IO]),
  		.seq_show =3D cgroup_io_pressure_show,
  		.write =3D cgroup_io_pressure_write,
  		.poll =3D cgroup_pressure_poll,
@@@ -5231,8 -5166,6 +5255,7 @@@
  	},
  	{
  		.name =3D "memory.pressure",
- 		.flags =3D CFTYPE_PRESSURE,
 +		.file_offset =3D offsetof(struct cgroup, psi_files[PSI_MEM]),
  		.seq_show =3D cgroup_memory_pressure_show,
  		.write =3D cgroup_memory_pressure_write,
  		.poll =3D cgroup_pressure_poll,
@@@ -5240,8 -5173,6 +5263,7 @@@
  	},
  	{
  		.name =3D "cpu.pressure",
- 		.flags =3D CFTYPE_PRESSURE,
 +		.file_offset =3D offsetof(struct cgroup, psi_files[PSI_CPU]),
  		.seq_show =3D cgroup_cpu_pressure_show,
  		.write =3D cgroup_cpu_pressure_write,
  		.poll =3D cgroup_pressure_poll,

--Sig_/vYbzmSrv_qwdyivZZwlUxFV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMeys0ACgkQAVBC80lX
0GxaGQf/dF3GoCD3OTuYEJfb1oX2c3U109+wd9g3m/cUP/OwiEnjS8jd+9YNHJUx
AlmcypkV/l+eem8tYYrGJXwZT4VcnH6t1vRTcW8OGBSRAj9T+FPhcbHJuRVX+Tp8
B4d146uQCpM5xMJ6B5dwZ3nwysPqxQ0wCf9WvhaZR4/IeuHkfeiEqcHkndz4JbFQ
omFEqhCEejKpKSD5mO2ab0BMhl2EtkT0xj574FSIYSJWtVOaOf+o3i/indBiaceO
tKTj5okd+yV9OjwL2yxyoai+1ZpceKVOEF7dLw31yIvEI4fAzKlEoV8D9TuinWK8
QJ2f2syfOQDYBt3UV3PFsTxbOvgpHQ==
=4yjz
-----END PGP SIGNATURE-----

--Sig_/vYbzmSrv_qwdyivZZwlUxFV--
