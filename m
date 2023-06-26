Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091F273D94A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjFZIMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFZIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:12:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D63E76;
        Mon, 26 Jun 2023 01:12:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqLDc5xCyz4wZr;
        Mon, 26 Jun 2023 18:12:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687767154;
        bh=YL4WtG8LHm8HUihCvX1m65X1iguc/Lla+C+qJnkgHSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l/0v/jqK+E4RhCKLhMKi2A2cfLf7MEG/IjT47KrFbvNwUcc/ak2DcL4RwaSXDX5HU
         32GcpNT4wkfyYrOboPEi/MBWW99W9Hs4wuyupj1wBRh9zSyX1B4QhqA96VXrhyfuG9
         wZANibg/LWtdko5+N4iG4gJ8/GrLEK186mgGG4z3akt2rQTtTq5Xw3tUOGoIsuO+Ub
         4JIZZmUIHPUjc4KZoHW2y8iin8mA5M4WHvkRIW0+vcWGxPxQOqKrG37PR8lxBH/Mq7
         DpOn27+D47aUPU6eNxX6RONJ2cLF8/RpY47ESCplSGpmtbCldGCdPLzG+wWdHUteUZ
         tqaKUnDV2rudw==
Date:   Mon, 26 Jun 2023 18:12:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20230626181231.70405c1f@canb.auug.org.au>
In-Reply-To: <2947430.1687765706@warthog.procyon.org.uk>
References: <20230626112847.2ef3d422@canb.auug.org.au>
        <2947430.1687765706@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1Ge+Wr0ku4FcBxMax3jOKWi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1Ge+Wr0ku4FcBxMax3jOKWi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 26 Jun 2023 08:48:26 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > After merging the net-next tree, today's linux-next build (native perf)
> > failed like this:
> >=20
> > In file included from builtin-trace.c:907:
> > trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags=
':
> > trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (f=
irst use in this function) =20
>=20
> I tried applying the attached patch, but it doesn't make any difference.

I wonder if it is using the system headers?  Or depends on "make headers-in=
stall"?

--=20
Cheers,
Stephen Rothwell

--Sig_/1Ge+Wr0ku4FcBxMax3jOKWi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSZSG8ACgkQAVBC80lX
0Gxg/ggAkTZ+/82QjJe4wJrDgQ+zyJhq4vhN3TFH56b9I64FB9blMUZicISKfQte
O/y63r6wPVD5Tsjc8v81egJO+i4/jXd/jp4i+ce7xSNDk0uSIjeRoXr8wMD3R793
Z0925rEhClPbyGwjhNZulvAOEcNZOyN/2A8z+zFSN/3ie6bTNxWNrVXkN1P25RTd
FAQYiT+YtY5taSmAnmO+O7ckJl69o3K8xUPct4a0oeEWxgNnjrXfKlhAUyFZzLzv
TjYK7Vk3KfGKJ2rGrLEw2RlgaIMMJ5/3NupwFqbpa6UMHtyMfv+5Z2EzHVs8BqFJ
G9IHURBU29V9G16Lrjo2uPr0UBOIaw==
=IP/A
-----END PGP SIGNATURE-----

--Sig_/1Ge+Wr0ku4FcBxMax3jOKWi--
