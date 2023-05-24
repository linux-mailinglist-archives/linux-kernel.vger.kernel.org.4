Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786570EC31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjEXDzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbjEXDyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:54:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5775BA3;
        Tue, 23 May 2023 20:54:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQy4T29Thz4wgv;
        Wed, 24 May 2023 13:54:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684900489;
        bh=ufTOQCYWmvctW2t/bzpFVthG9T5Pea4rH56eruBKQ00=;
        h=Date:From:To:Cc:Subject:From;
        b=IcVxGVE5CFjQAm1DQoE6IH1FWhQ3b6d9di7S9937VSk+qHFpWYrGVeXerri/1Jwal
         6zi34qW55zo0HhKKAqBbCugNQJT3jq90ox407trt4f8LvbsEk3Ljm7JySvqhrL2AOt
         bFqLP+Bxx6lzRu0uYUC2Nb8BqHaASqx5IXCAxz1ILFOHD0ZYYhXHMtRqyM1MkXv0Rw
         vEENRkSYHHd0/uy84+5rikRH14RhvWWMMwW7nyNtGYZSApDItyVSVRhHYdtO1OkyVG
         mWrbfm+gApnk9q1CgY91wkqKJHCCBEEBCN5ZLkjLvgQy2edL4iQmRsP5xLsJ9cXo1t
         hZOcEct6zU7PQ==
Date:   Wed, 24 May 2023 13:54:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound tree
Message-ID: <20230524135448.3ecad334@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/44FVtg0J.sp7ab2C_gAtk7/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/44FVtg0J.sp7ab2C_gAtk7/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from sound/core/seq/seq_ump_convert.c:11:
include/sound/ump_msg.h:196:13: error: duplicate member 'reserved'
  196 |         u32 reserved:8;
      |             ^~~~~~~~
include/sound/ump_msg.h:197:13: error: duplicate member 'program'
  197 |         u32 program:8;
      |             ^~~~~~~
include/sound/ump_msg.h:198:13: error: duplicate member 'channel'
  198 |         u32 channel:4;
      |             ^~~~~~~
include/sound/ump_msg.h:199:13: error: duplicate member 'status'
  199 |         u32 status:4;
      |             ^~~~~~
include/sound/ump_msg.h:200:13: error: duplicate member 'group'
  200 |         u32 group:4;
      |             ^~~~~
include/sound/ump_msg.h:201:13: error: duplicate member 'type'
  201 |         u32 type:4;
      |             ^~~~

Caused by commit

  0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")

I have applied the following fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 24 May 2023 13:39:38 +1000
Subject: [PATCH] fix up for "ALSA: ump: Add legacy raw MIDI support"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/sound/ump_msg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/ump_msg.h b/include/sound/ump_msg.h
index c76c39944a5f..a594ef951b54 100644
--- a/include/sound/ump_msg.h
+++ b/include/sound/ump_msg.h
@@ -192,13 +192,13 @@ struct snd_ump_midi1_msg_program {
 	u32 program:8;
 	u32 reserved:8;
 #else
-#endif
 	u32 reserved:8;
 	u32 program:8;
 	u32 channel:4;
 	u32 status:4;
 	u32 group:4;
 	u32 type:4;
+#endif
 } __packed;
=20
 /* MIDI 1.0 Channel Pressure (32bit) */
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/44FVtg0J.sp7ab2C_gAtk7/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtiogACgkQAVBC80lX
0GxkYwf/Zm8mQHXgVpOoGhCVzXRhonzQ6Cur4H/yDuP7dD2Ldc6ewsm2IrlDGQuD
GM4dyj8PUj260ffJZt/f/DrywKkowIcwm4ytDXmMRNzFOORTvdj/cMiSILT22dlO
6xTy5ZFHbW3NtiK8ew0dru3BauwQN2ahzTdCVJjjuXfvLK/rbGB+bZGx0CL0B1Q5
Ca82a5zSL/sBNt4yot1PCj9sECQUrZTrL4IPZYHUMy2tCMtAOMeotH8rW1kvMsbO
Z2O1LsWLRbHjMfFC6ojSGIbvLlHpbxe1+9U7CwlVf6zlHbaZuR22As4tpoveBIJI
LmEc4m3y5o7aPzJ6B5oRPsBq9eYyog==
=BQcw
-----END PGP SIGNATURE-----

--Sig_/44FVtg0J.sp7ab2C_gAtk7/--
