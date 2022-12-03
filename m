Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0796412EA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiLCBHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiLCBHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:07:35 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC3E02EA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:07:31 -0800 (PST)
Date:   Sat, 03 Dec 2022 01:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nereid.pl;
        s=protonmail; t=1670029649; x=1670288849;
        bh=JVHmBYchUr1KxB+Mt4xsuL7U1ILvPgm6Rr3YJ82DeAA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Q7JGx/OneIOjAHFwLBXKLL19kkqzNHrYnFsI0VplzYkBgivRJXEoVmD1TOpJGCHJP
         b4fEvGU08QuWCc8MbiXwdqt8zYnqiCwHLY66mnnCm5bcVW36svw3ZGvYrWJsK/Gqn6
         aWU8mi4tiyWvdlC2xeUYT/dPQg1uW2IWZDBNJ2bjftZYQKAjkMkF4ekcTEo2ZslZn6
         EqF8HH47ZDhaMjmMrVD1m76djkjF7hNPpH0DckvJ7EsziBgnCYo5dE+UpfgpytAlPA
         ij58xx7C8/OCW8Zk/msEHV08mvun7/TXxhpqkKXGJzWAZ375wRVwqhyXeQiTChx556
         9W4dMRJZteuVw==
To:     Jan Kara <jack@suse.com>
From:   Bartosz Taudul <wolf@nereid.pl>
Cc:     linux-kernel@vger.kernel.org, Bartosz Taudul <wolf@nereid.pl>
Subject: [PATCH] udf: Increase UDF_MAX_READ_VERSION to 0x0260
Message-ID: <20221203010658.247048-1-wolf@nereid.pl>
Feedback-ID: 31273341:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------9d048d0e0cb399a0645404c5cb1bce9a441fd0e2f0446c7feb16e2cc0383f481"; charset=utf-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9d048d0e0cb399a0645404c5cb1bce9a441fd0e2f0446c7feb16e2cc0383f481
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Bartosz Taudul <wolf@nereid.pl>
To: Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Taudul <wolf@nereid.pl>
Subject: [PATCH] udf: Increase UDF_MAX_READ_VERSION to 0x0260
Date: Sat,  3 Dec 2022 02:06:58 +0100
Message-Id: <20221203010658.247048-1-wolf@nereid.pl>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0

Some discs containing the UDF file system are unable to be mounted,
failing with the following message:

  UDF-fs: error (device sr0): udf_fill_super: minUDFReadRev=260
    (max is 250)

The UDF 2.60 specification [0] states in the section Basic Restrictions
& Requirements (page 10):

  The Minimum UDF Read Revision value shall be at most #0250 for all
  media with a UDF 2.60 file system. This indicates that a UDF 2.50
  implementation can read all UDF 2.60 media. Media that do not have a
  Metadata Partition may use a value lower than #250.

The conclusion is that the discs failing to mount were burned with a
faulty software, which didn't follow the specification. This can be
worked around by increasing UDF_MAX_READ_VERSION to 0x260, to match the
Minimum Read Revision. No other changes are required, as reading UDF
2.60 is backward compatible with UDF 2.50.

[0] http://www.osta.org/specs/pdf/udf260.pdf

Signed-off-by: Bartosz Taudul <wolf@nereid.pl>
---
 fs/udf/
udf_sb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 4fa620543d30..09d62bf1f5fb 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -6,7 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/magic.h>

-#define UDF_MAX_READ_VERSION		0x0250
+#define UDF_MAX_READ_VERSION		0x0260
 #define UDF_MAX_WRITE_VERSION		0x0201

 #define UDF_FLAG_USE_EXTENDED_FE	0
--
2.38.1


--------9d048d0e0cb399a0645404c5cb1bce9a441fd0e2f0446c7feb16e2cc0383f481
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmOKoUkJkLf+IAi3V13zFiEE74scJSwatDjGrwLOt/4gCLdX
XfMAABlcAQDpSRM4ItstpNQTJQlbvnTVurWBWiXOL6uxA7CGOqbJtAD7BXs+
edwluN4w9GwXxi915tUn08bFtOO20eMLHYWG2QA=
=wzwB
-----END PGP SIGNATURE-----


--------9d048d0e0cb399a0645404c5cb1bce9a441fd0e2f0446c7feb16e2cc0383f481--

