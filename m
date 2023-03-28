Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47396CB330
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjC1Bdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1Bdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:33:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1FD1BFB;
        Mon, 27 Mar 2023 18:33:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Plsdn4rnzz4wj7;
        Tue, 28 Mar 2023 12:33:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679967214;
        bh=t0lpS9FXUassEuzLmJw8ESyJHbSC3KamqfDxSt8zTqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FZI4HCHGwFUtThX/eq4ejOrz2CFB8z5GlA77LVZEOJY7MCkETaOolg47AEzo8zreU
         idugxYxbWu0+6yWjvPwXYsynbvJ6EYM9xG0HCNGGNtg9AujGz2aFmbW6K2OnKi6llP
         5LCNoft8VmVicQ7f332tHEqGtlxOTyyKfLA/fzSbX7vmWVIgvrpWe/ovbKJXoe1Kmu
         DTEuCnSYXPuOicozOkD6HssihWvL5XRQwo9FKKrnRfzNcJwevn+FfTib0fm+6zcO4w
         LO7mB0XbpfTgp9LFeWCfkyER8Vi06ySXT9M5zotPXRogJBV4GzfUhdyIfSyfLj3vLJ
         wpH/VJgIYt/Dw==
Date:   Tue, 28 Mar 2023 12:33:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20230328123332.0a3e2b6d@canb.auug.org.au>
In-Reply-To: <ZBxTyLqkIaoVhIXU@kernel.org>
References: <20230317095025.49aa34f9@canb.auug.org.au>
        <20230322083956.5c051777@canb.auug.org.au>
        <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
        <20230323095437.1ecccec1@canb.auug.org.au>
        <ZBxTyLqkIaoVhIXU@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8agte_UkCldEHOKp5iS.jQA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8agte_UkCldEHOKp5iS.jQA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

Just a few datapoints:

My build machine (Debian Testing PowerpcLE, not quite the latest
kernel):

On Thu, 23 Mar 2023 10:27:36 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>  Which improves a bit the situation.
>=20
> We could check if bpftool is available and if not, suggest installing
> it.

$ ls -l /usr/sbin/bpftool
-rwxr-xr-x 1 root root 790504 Mar  6 02:33 /usr/sbin/bpftool

> If it is available, we could check if /sys/kernel/bpf/ is available, if
> not suggest using a kernel with CONFIG_DEBUG_INFO_BTF=3Dy, as most distros
> have by now.

$ uname -a
Linux zz1 6.0.0-5-powerpc64le #1 SMP Debian 6.0.10-2 (2022-12-01) ppc64le G=
NU/Linux
$ ls -l /sys/kernel/bpf/
ls: cannot access '/sys/kernel/bpf/': No such file or directory
$ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.0.0-5-powerpc64le
# CONFIG_DEBUG_INFO_BTF is not set

And in the latest powerpc64le kernel:

$ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.1.0-5-powerpc64le
# CONFIG_DEBUG_INFO_BTF is not set

Debian Testing arm64, not quite the latest kernel:

$ uname -a
Linux oak 6.1.0-5-arm64 #1 SMP Debian 6.1.12-1 (2023-02-15) aarch64 GNU/Lin=
ux
$ ls -l /sys/kernel/bpf/
ls: cannot access '/sys/kernel/bpf/': No such file or directory
$ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.1.0-5-arm64
CONFIG_DEBUG_INFO_BTF=3Dy
CONFIG_DEBUG_INFO_BTF_MODULES=3Dy

Debian Testing amd64, the latest kernel:

$ uname -a
Linux pine 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.15-1 (2023-03-05=
) x86_64 GNU/Linux
$ ls -l /sys/kernel/bpf/
ls: cannot access '/sys/kernel/bpf/': No such file or directory
$ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.1.0-6-amd64
CONFIG_DEBUG_INFO_BTF=3Dy
CONFIG_DEBUG_INFO_BTF_MODULES=3Dy

Debian Stable amd64, the latest kernel:

$ uname -a
Linux gimli 5.10.0-21-cloud-amd64 #1 SMP Debian 5.10.162-1 (2023-01-21) x86=
_64 GNU/Linux
$ ls -l /sys/kernel/bpf/
ls: cannot access '/sys/kernel/bpf/': No such file or directory
$ grep CONFIG_DEBUG_INFO_BTF /boot/config-5.10.0-21-cloud-amd64
CONFIG_DEBUG_INFO_BTF=3Dy

--=20
Cheers,
Stephen Rothwell

--Sig_/8agte_UkCldEHOKp5iS.jQA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQiQ+wACgkQAVBC80lX
0GzPhQf+Ldop15C1ck90Lq132iop1M7jyCgZTGriS49jn2UfUzZMqXf7DREWvGi1
oEARIV067SyknUig0/XWzfs4v0oa7Q3fPubijmBBQMIUfYvKoJvUg83AOZRZxlAz
YebKK1HJw8GmazLXInHgFBy14Xd90sVPoGgBZQkbMXjnKlm/DUccv09h6MRXVFdZ
TTRGzrBWJp3tS7bhPFXNKGQSFahlQV82W3EK3N2uJGRlvbErOOBfMaQEj+Vv1sKa
xJrf9FhdYxbEN/uHdJBG4CFcyo7P6GfDCNXmAjYFi5RkH0ztF+/brXyuHew8CKGR
xbcSSUN+31EhfOyMsCPTQ5tD5SBKBQ==
=G2XS
-----END PGP SIGNATURE-----

--Sig_/8agte_UkCldEHOKp5iS.jQA--
