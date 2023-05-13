Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4D7019AF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjEMUhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEMUha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:37:30 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBAB2D48;
        Sat, 13 May 2023 13:37:29 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxvzZ-0008Qd-19; Sat, 13 May 2023 22:37:25 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxvzY-007dj4-1N;
        Sat, 13 May 2023 22:37:24 +0200
Date:   Sat, 13 May 2023 22:37:24 +0200
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2 1/2] perf doc: Define man page date when using asciidoctor
Message-ID: <ZF/1BOahN/i6xbBx@decadent.org.uk>
References: <ZF/0jJkAOXxzGAMc@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GQDwKrGXSBPfpPFg"
Content-Disposition: inline
In-Reply-To: <ZF/0jJkAOXxzGAMc@decadent.org.uk>
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GQDwKrGXSBPfpPFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Ben Hutchings <benh@debian.org>

When building perf documentation with asciidoc, we use "git log" to
find the last commit date of each doc source and pass that to asciidoc
to use as the man page date.

When using asciidoctor, however, the current date is always used
instead.  Defining perf_date like we do for asciidoc also doesn't
work because we're not using DocBook as an intermediate format.
The asciidoctor man page backend looks for the variable "docdate",
so set that instead.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/perf/Documentation/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/M=
akefile
index ba5d942e4c6a..8a7d7078e386 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -250,11 +250,16 @@ $(MAN_HTML): $(OUTPUT)%.html : %.txt
 		$(ASCIIDOC_EXTRA) -aperf_version=3D$(PERF_VERSION) -o $@+ $< && \
 	mv $@+ $@
=20
+# Generate date from git log of the doc input file
+PERF_DATE =3D $(shell git log -1 --pretty=3D"format:%cd" \
+                --date=3Dshort --no-show-signature $<)
+
 ifdef USE_ASCIIDOCTOR
 $(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b manpage -d manpage \
-		$(ASCIIDOC_EXTRA) -aperf_version=3D$(PERF_VERSION) -o $@+ $< && \
+		$(ASCIIDOC_EXTRA) -aperf_version=3D$(PERF_VERSION) \
+		-adocdate=3D$(PERF_DATE) -o $@+ $< && \
 	mv $@+ $@
 endif
=20
@@ -266,9 +271,7 @@ $(OUTPUT)%.xml : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b docbook -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=3D$(PERF_VERSION) \
-		-aperf_date=3D$(shell git log -1 --pretty=3D"format:%cd" \
-				--date=3Dshort --no-show-signature $<) \
-		-o $@+ $< && \
+		-aperf_date=3D$(PERF_DATE) -o $@+ $< && \
 	mv $@+ $@
=20
 XSLT =3D docbook.xsl


--GQDwKrGXSBPfpPFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmRf9QQACgkQ57/I7JWG
EQlFgw/9FpCiJxb7vvzCjpbR1D3CBp5rfos5ZP7YIqNVLRWyQXjTLpjOFMvDO0C9
mvHzGVkZneDYA8cEoyI5PqhINwbJGqz30uI5dLTjI6dDdm72Jj885gs93OUUpWun
h7hJ1iFxUvuylBrjTb0YV5bMJdJKhSUcRh63B2RU/LRK6kodz2kJ8le0eK2WW1qe
9LA23rN8t0WCizLHsCggmNfZv0rthKmCSlhxVwdgC3OYfALRfQpajj2q5ps7/UoN
e+zd5WcA8N2prLj0cnoy0UAh6I446+dwPClpph+0tReAe37Bzh2a96ZOLQ2MrlxK
smvCr5ZtMtgyoHpCDjNRcpXyoQxyNejNZSMMzC/EjaXyuW68r63OdPFEopKS6O5C
tAXAlEydxn/saAFmtsh1lhQKS09tKZVUgjm4yPyWIsWM/zVLEgA/iG2AUaieD4lv
Mc1OHtoLv64nIbe4yJwMsEsho6Md+wTxGk1U6yteCayXRVU3RbbWYcCYflJObyTm
GkS9PaXyuEu0YAsaxysbvICGpaVHbwebFrvHpd9HQckavu83LPwunDzJncodnxWE
pfxdcxuFrKvt8dKQPPA2/w/Yr9yAJPqEzCx5wR5LORs3UnO2b3HMKuuCTqXQSn3O
O/wexisu8SA4saDaJk8/OSn8pUTwBzgaYBPyKtTlsg/r4mGu0nk=
=D6XO
-----END PGP SIGNATURE-----

--GQDwKrGXSBPfpPFg--
