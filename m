Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CE741E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjF2Clf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjF2Cld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:41:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B52682;
        Wed, 28 Jun 2023 19:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688006485;
        bh=DOTiWuRdS6j3Ik12nAEtdLMioHxNbY4GxWaOWz72ozM=;
        h=Date:From:To:Cc:Subject:From;
        b=AsqolizoW2carOyzzDEJs87sAMvC2KWOSB2rXlw/J0SIyJLVrBkvcZysoEVtYQU4U
         Cp5s8hoKRoD8eEAMAu2QtnPd+q/CfCwcc3RLihcTuQl/gJq2d7/znc2ByuGBXsHkCy
         LUjpsiwGGw/YJDy1kr63yb5iIRGYWwPhZi0yXCowx04ttC7veGLJRoKmlT+2BgLt6s
         scGJC6BGBrrab/AwXkRU0AXJjO6YnZAVdpx6u6Y9tQqYeteAqpOYD4eqlywKJ+N1Bf
         GAk5BQ3o3zTIC8DvcNB+UsaItX+JkSF+N5nSSzJKBtOYfZPFLct4Zh4wjRakIPq8DN
         5+usmoRiz1hKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qs2l85wzpz4wbP;
        Thu, 29 Jun 2023 12:41:24 +1000 (AEST)
Date:   Thu, 29 Jun 2023 12:40:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the seccomp tree
Message-ID: <20230629124055.7edf4493@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u3i+xUXvWO/3h02EueDp+bQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u3i+xUXvWO/3h02EueDp+bQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the seccomp tree, today's linux-next build (native perf)
failed like this:

make[3]: *** No rule to make target '/home/sfr/next/perf/bench/sched-seccom=
p-notify.o', needed by '/home/sfr/next/perf/bench/perf-in.o'.  Stop.
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [/home/sfr/next/next/tools/build/Makefile.build:140: bench] Er=
ror 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:682: /home/sfr/next/perf/perf-in.o] Error 2
make: *** [Makefile.perf:242: sub-make] Error 2
Command exited with non-zero status 2

Presumably caused by commit

  df614e369b5c ("perf/benchmark: add a new benchmark for seccom_unotify")

This is a native build of perf on a PowerPC 46 bit LE host.

I have used the seccomp tree from next-20230628 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/u3i+xUXvWO/3h02EueDp+bQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSc7zgACgkQAVBC80lX
0Gw/aggAlBqaKB9WQSwfiLjxofutJP39cwOvc+pFP3canGhsUQZk27+dR/J398zH
fJC5WbShUDpIuS8Uz93EHPg7gcvetAldGBj6wAJk/8mo97oazbpb+BKC6xv3MZsJ
tmeuOPwK+GlHU2Mia61XWR/KnTikK9owU73Fn8C2CbPjMmJ0KiYqm5Guk6TYuRVf
3V4B26e1Rwx5uzdyhNy4+5wzHDUkDNjp/RoczVUvunjh4Yk98T354mM0rZKFsWAX
PD0kZ4NkO/TTdD5enVe4/d1/peLyxpdHcdVvkfyEB4AsjHbbrTha2/v61MlbUg6/
xYicVLb3kHTtlot6NIEQ5D+7CtE9tQ==
=nBb2
-----END PGP SIGNATURE-----

--Sig_/u3i+xUXvWO/3h02EueDp+bQ--
