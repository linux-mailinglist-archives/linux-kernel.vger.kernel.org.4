Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5789A6CB29F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjC0Xrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0Xrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:47:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86C1B8;
        Mon, 27 Mar 2023 16:47:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlqHZ0nKXz4wj7;
        Tue, 28 Mar 2023 10:47:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679960859;
        bh=mE6ZWZFMqxR2adS0ArGXuJsCZc7MucNRR2NBIDM+e4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDUqV0yH1bNMJJDXyqMMAgT7xqc7WcIEXBdW0VFNfzU6MGA3JdOwyRdi+kKl8RkZy
         L9UmQCF4AaF8VxEkEjzpHAEzR7sNvhLIeiZ1QoVcYk7BB5CUdy1pBvWKEbuDIUHKEX
         UiecRk+1i7tNmOvHJSt3CF4nE3kaT4zgniXeaPFgkCYuWl1ezi7Hwaj8rqLWM4pP2X
         us+AUQzPLducBuFpLMB6kV9RQFDsyHNrqGvy3iWX+quUO78BI9YSAM9AhINxvh+ytj
         /hHdz3dUuH1BStWygTMsMUMg7kMvPnd/9Su3ZFwNzQsH6a7k2yZ7alQMWobZMYY9Y7
         xiK2G9qScjyjA==
Date:   Tue, 28 Mar 2023 10:47:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230328104719.65133586@canb.auug.org.au>
In-Reply-To: <20230327162630.wmxpycxhllt4clpt@treble>
References: <20230327120017.6bb826d7@canb.auug.org.au>
        <20230327162630.wmxpycxhllt4clpt@treble>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iL.VgJZERbHq89f.1B7mz_K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iL.VgJZERbHq89f.1B7mz_K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Mon, 27 Mar 2023 09:26:30 -0700 Josh Poimboeuf <jpoimboe@kernel.org> wro=
te:
>
> On Mon, Mar 27, 2023 at 12:00:17PM +1100, Stephen Rothwell wrote:
> >=20
> > After merging the block tree, today's linux-next build (x86_64
> > allnoconfig) produced these warnings:
> >=20
> > lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant =
UACCESS d
> > isable
> > lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to =
copy_comp
> > at_iovec_from_user.part.0() with UACCESS enabled
> > lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_co=
mpat_iovec_from_user.part.0() with UACCESS enabled
> >=20
> > Presumably introduced by commit
> >=20
> >   6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF") =
=20
>=20
> I'm not able to recreate.  What's your compiler version?

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0

--=20
Cheers,
Stephen Rothwell

--Sig_/iL.VgJZERbHq89f.1B7mz_K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQiKwcACgkQAVBC80lX
0GzHMwf/XCukPnOhDu0//9VDm+QTIKR53e2mG83gWn6dopOLQyVUVyuaD79T1Neo
OW6JBElqRA1exIuhnrFXpI8GRn03svU7yZ3pbEy5zar6hKzqz+8vNepjyxlOmk5o
lvUjJAzPUQjknqyAa7s+GIKhi1X/UuNEyR4Jzq1UzSD0vBXVu19Z1fkLqethK5Eu
4niAxahxoERRnKP997iCIrDfG+6bQ54KWrJ0FK2+WhV8DuhTZVSg7agU4bW22/lx
NdzG5Mwt+XdAjtsFaqrI67MXhFfE7zKDuLBYb75z8LME1rou/LeGWECGutZ8CMtw
6DO298jputtXpFi1AUC14h09zJyFZQ==
=s1DJ
-----END PGP SIGNATURE-----

--Sig_/iL.VgJZERbHq89f.1B7mz_K--
