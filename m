Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C7715235
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjE2XFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2XFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:05:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30DEAD;
        Mon, 29 May 2023 16:05:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVWMp6Qpxz4x3k;
        Tue, 30 May 2023 09:05:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685401527;
        bh=LhEz1UZxuXZl9yaiu0EdDsXlq1BIx9Y9rAunUJOYqao=;
        h=Date:From:To:Cc:Subject:From;
        b=RRVPjfjjynz+kWLVTxZLELNYEWcELEkqyp5OZzd+W+h1MWH9i3NPVBUuVcXGLOLIl
         vYeKy7pLtsAwvQbNN+MM7e8GaweieG2XYHjN9kvwpuhQ5kD5JWp/WPq39cmEP6ox/b
         KwyfcWqTqaEURirM9rMurCnoHg3RE/KLELeJWkAnMlgaVI4FnwSrr3Ff0wAlBgpRJi
         UCgjaMeJHrqxFNeuJqygneGEjBZpA9u+YyBVJO4AcTnT/ho4H4HSBr6sWFtQTA22GA
         9mG3AuKmGkdAuMjDIFoGr61k/UdN8bA2WvVPCc3bcM7z2PZvPwwIr83ZNrcybOMTDr
         LAUKg6M1j3FgQ==
Date:   Tue, 30 May 2023 09:05:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20230530090525.43a8d23e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d5kBq4VpS2o8LlmzmUNe8wk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d5kBq4VpS2o8LlmzmUNe8wk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (powerpc perf)
failed like this:

arch/powerpc/util/kvm-stat.c: In function 'kvm_add_default_arch_event':
arch/powerpc/util/kvm-stat.c:207:21: error: implicit declaration of functio=
n 'pmu_have_event'; did you mean 'perf_pmu__have_event'? [-Werror=3Dimplici=
t-function-declaration]
  207 |                 if (pmu_have_event("trace_imc", "trace_cycles")) {
      |                     ^~~~~~~~~~~~~~
      |                     perf_pmu__have_event

Caused by commit

  1eaf496ed386 ("perf pmu: Separate pmu and pmus")

I have used the perf tree from next-20230525 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/d5kBq4VpS2o8LlmzmUNe8wk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1L7UACgkQAVBC80lX
0GwE2QgApJPE/JAHqVjBMKn8FKN/oWc+wxmsV1PHxq323rxZ7E22SaNh7Xqb0cXk
q0FMV3dN8jojqeLLSJX0h3p9gaB5VflPY2fKvIt03gGIC/E+bZzhBlPcUC+7Oh7r
OexLI8glPoZ7X4NfSb5h4GchBe3XfcnANL1NbajEUAb9No6EL39hcBX4T5RxWr+M
PYKF/mYjy2nIWOjAMANzPs1LcrS4icBlD5ufca+jhKzmvJ1AKpcJv2SwrWjAJY0y
SQiVmLRxjmTAbetXPg9VImBssewA7PEOREraHA5K/jSEaEWf3UQ8o+nyM0A86b0P
0dJ3i00ALcBvjMiZM+SeFNxTtbg31w==
=oSh1
-----END PGP SIGNATURE-----

--Sig_/d5kBq4VpS2o8LlmzmUNe8wk--
