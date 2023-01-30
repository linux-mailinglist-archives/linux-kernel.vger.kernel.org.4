Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA71680573
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjA3FOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA3FOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:14:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5D321943;
        Sun, 29 Jan 2023 21:14:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4xDm1nTBz4x1h;
        Mon, 30 Jan 2023 16:14:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675055656;
        bh=pTIsU8qmqRGy5BJELrtztF9nHTPffugyqjJ/xnBNj4Y=;
        h=Date:From:To:Cc:Subject:From;
        b=IjMWF7zkNfiqVexAyP1fLVOtNNtilTnF3Z7SZG+Hlg3g84r9tmqq76IvIYAoCm8Nh
         bK0UbgrWUZBiI3aCdPkcdZkWCPqiOvW6BmADphoqKq96aBab5gmiV8sEk4q+C54V4N
         S65zAFrqrzYINFP2MQGWwDbS1WVtwAeC7Flxl8aZdAw8ZKgSw433+8ewHKH3cOGR4Q
         uhXUheU7vHNmdLGdPYIkNf1KBHZae6/XOsdjSQ/zNQunASaDF+8IFFwpmM563I/AgP
         gW3cws1hb85h0CTWA/9UfZRURG+oCjV7HUEIuzyLt4OzKzBw5yGwe/B7QAtneRMZ1Y
         c+liKhKGzlxjg==
Date:   Mon, 30 Jan 2023 16:14:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230130161414.25a71a87@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P_7JtmDy/=A0YLuPMx+9eXf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P_7JtmDy/=A0YLuPMx+9eXf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

kernel/sys.c: In function '__do_sys_prctl':
kernel/sys.c:2664:9: error: duplicate case value
 2664 |         case PR_SET_HIDE_SELF_EXE:
      |         ^~~~
kernel/sys.c:2655:9: note: previously used here
 2655 |         case PR_SET_MDWE:
      |         ^~~~
kernel/sys.c:2669:9: error: duplicate case value
 2669 |         case PR_GET_HIDE_SELF_EXE:
      |         ^~~~
kernel/sys.c:2658:9: note: previously used here
 2658 |         case PR_GET_MDWE:
      |         ^~~~

Caused by commit

  ab30677b499c ("mm: implement memory-deny-write-execute as a prctl")

interacting with commit

  966eb1ba050d ("exec: add PR_HIDE_SELF_EXE prctl")

from the pidfd tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 30 Jan 2023 16:08:34 +1100
Subject: [PATCH] mm: fixup for "mm: implement memory-deny-write-execute as =
a prctl"

interacting with

  966eb1ba050d ("exec: add PR_HIDE_SELF_EXE prctl")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/uapi/linux/prctl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index ccc92b92037c..99b5592cf297 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -282,10 +282,10 @@ struct prctl_mm_map {
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
=20
 /* Memory deny write / execute */
-#define PR_SET_MDWE			65
+#define PR_SET_MDWE			67
 # define PR_MDWE_REFUSE_EXEC_GAIN	1
=20
-#define PR_GET_MDWE			66
+#define PR_GET_MDWE			68
=20
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/P_7JtmDy/=A0YLuPMx+9eXf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPXUiYACgkQAVBC80lX
0GzFWAf/bYwtNOF7FYQKoBYFNQuNkpBZX9225vmwfuzXZA7R3wcp3YAjyPhi5aDI
eCn+9y306IFzVqBiLIawP+z36IshFyVKJUn9ygQHQ0GvLeLNp+rx0VWny61pvUoD
74i4Rs9072wmBXF2jssP+10xkxSXhXL+IjY6IsnF7Z5Gr0nMDXmLA1fFqn8pMWqa
tTJ19zi6uit6RujuXHpQleQRBy9oFUU3PZQhI/kepiQML2xnqprqQwHYDj6hC3Oh
OXOyWPAuLca6E0WBdNd0l0mo+bkz3Y6oaHiBOZwhimCfbmsEWF+9O5ArZGTJx1k9
LXLxTfWpXEa0Vo0LKk8IIj3CAhpCgQ==
=6wEY
-----END PGP SIGNATURE-----

--Sig_/P_7JtmDy/=A0YLuPMx+9eXf--
