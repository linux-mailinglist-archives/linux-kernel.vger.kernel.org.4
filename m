Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771FE69C000
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 12:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBSLGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 06:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSLGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 06:06:53 -0500
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Feb 2023 03:06:51 PST
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3A4EB64;
        Sun, 19 Feb 2023 03:06:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 37C55EBA6C;
        Sun, 19 Feb 2023 03:01:17 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SsC8DmlStKXT; Sun, 19 Feb 2023 03:01:16 -0800 (PST)
Date:   Sun, 19 Feb 2023 12:00:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1676804476; bh=mbBNYPuhb2apsz5SvK8JsFBaH/EaefkZb9gM8EHx9Es=;
        h=Date:From:To:Subject:From;
        b=d5Nz9T4OG1OVB3vZY4On71vSHZKXwbaX+znvJnZfHCm0PvPfYKTyVv2Lyn0kwdiE/
         CPH5lHyb6n0iSoFnslQFcAPh2YlGml6+3GtCm4Wg8Eoqh7oxmxTTLqGdfN6ZO+VgoL
         58bh8YyWQH+nohltlgLw0KWqHbFLzCyVuRUcmtGgBKjcxMAUfvfFbID4yh9UY2a3vn
         kj8A82LHpcxI7Bm+M2qLlgYCTYTMQZoWYODFzxnwI9RwrtliCr4bez2KQ+obuJ4tvg
         wCxjvygkZFqp/npqvgCgqyJjC2P1DZeRarz8rPOXHBJK0RWpRyMUg5ykkHj8UwkYW5
         H3AXOytSn6SDA==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: [PATCHv3 1/2 RESEND] doc/media api: Try to make enum usage clearer
Message-ID: <20230219120034.5819b4ac.dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GD==Uz7p2DqMs8Sc4nMtOdN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GD==Uz7p2DqMs8Sc4nMtOdN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This clarifies which side of the calls is responsible for doing what to whi=
ch parts of the struct.
This also explicitly states that repeating values are disallowed.
It also expands the terse description of the access algorithm into more pro=
se-like, active voice description, which trades conciseness for ease of com=
prehension.

Added: mbus codes must not repeat
Added: no holes in the enumeration
Added: enumerations per what?
Added: who fills in what in calls
Changed: "zero" -> "0"
Changed: "given" -> "specified"

Still unclear how it works so didn't describe: "which". What is a "try form=
at" vs "active format"?

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
---
Hi,

I took those patches out of the freezer. I made sure they still apply (they=
 do), and corrected some errors pointed out by Jacopo in the previous round=
 of reviews.

Thanks,
Dorota

 .../v4l/vidioc-subdev-enum-mbus-code.rst      | 38 +++++++++++++------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-=
code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-co=
de.rst
index 417f1a19bcc4..63bff24d0520 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
@@ -31,15 +31,28 @@ Arguments
 Description
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-To enumerate media bus formats available at a given sub-device pad
-applications initialize the ``pad``, ``which`` and ``index`` fields of
-struct
-:c:type:`v4l2_subdev_mbus_code_enum` and
-call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this
-structure. Drivers fill the rest of the structure or return an ``EINVAL``
-error code if either the ``pad`` or ``index`` are invalid. All media bus
-formats are enumerable by beginning at index zero and incrementing by
-one until ``EINVAL`` is returned.
+This call is used by the application to access the enumeration
+of media bus formats for the selected pad.
+
+The enumerations are defined by the driver, and indexed using the ``index`=
` field
+of struct :c:type:`v4l2_subdev_mbus_code_enum`.
+Each enumeration starts with the ``index`` of 0, and
+the lowest invalid index marks the end of enumeration.
+
+Therefore, to enumerate media bus formats available at a given sub-device =
pad,
+initialize the ``pad``, and ``which`` fields to desired values,
+and set ``index`` to 0.
+Then call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl
+with a pointer to this structure.
+
+A successful call will return with the ``code`` field filled in
+with a mbus code value.
+Repeat with increasing ``index`` until ``EINVAL`` is received.
+``EINVAL`` means that either ``pad`` is invalid,
+or that there are no more codes available at this pad.
+
+The driver must not return the same value of ``code`` for different indices
+at the same pad.
=20
 Available media bus formats may depend on the current 'try' formats at
 other pads of the sub-device, as well as on the current active links.
@@ -57,14 +70,15 @@ information about the try formats.
=20
     * - __u32
       - ``pad``
-      - Pad number as reported by the media controller API.
+      - Pad number as reported by the media controller API. Filled in by t=
he application.
     * - __u32
       - ``index``
-      - Number of the format in the enumeration, set by the application.
+      - Index of the mbus code in the enumeration belonging to the given p=
ad.
+    Filled in by the application.
     * - __u32
       - ``code``
       - The media bus format code, as defined in
-	:ref:`v4l2-mbus-format`.
+	:ref:`v4l2-mbus-format`. Filled in by the driver.
     * - __u32
       - ``which``
       - Media bus format codes to be enumerated, from enum
--=20
2.38.1


--Sig_/GD==Uz7p2DqMs8Sc4nMtOdN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmPyAVIACgkQADBpX4S8
ZnemSQ/+OT7OpQcDqShYOGJhwnDYEXkFnWbDGFgi23aIoQcS25/QaFbP9TPkmp37
XEw1ArhmMybJrZXuhntKToRJeoz3nyfDN3S1r0ZgMAItbPVsVdJw4ma+5zqVlXc7
/Dz/rs/D4WxNrkbimEagj5B4ovj9QE58Km8EoSvjbGUgrkPqzsZADlFfiNOItax2
5qivhAHGQFjE5cuxruUbjs2/zAMaDOLlZeaoE9LW6AODNEr+UJ1G+U26XxQevSoG
LNWmzGmtglZzYFX3Hrb9KXwr7wQS9BSCjtA8wFk/6FlIvcti5G0ZPEr9uKZJDz3+
lFnOwTzib2Tjqe5/Uv9Q2Mtdpa62b4NkH8R5+y9SmfpQmaOrUBb6zZ8RgcUy5M/E
5i7Kb5tcca5kSQQztpj/GwUgK95nUbtHY2Y+6mYu9RLf3KGaeKY7DNEWi3oU6svh
ngTnnEONzS8eGvUyNwUnhMlb2EpCO9eVwxSCr1CsvXLH4WLtuQ+zUjxsI2LCalm5
6g7xtm3hP7NPrwgqeIzwN1M4T9nHowDbDfYScJMRC7rQ1Og3O7aLCNnnPtNFj3OY
1yDAZIcxfRO9JPDWmwdkJ3ujRmEu3Ff8yYv2F+UUVjyInGAB/eBLUkRaEnDa/VNb
EAHZzo/pLxjixoiYbQBVZeMpSpq4lN2bGG2GT+n22y3V9NRp89Q=
=aUN3
-----END PGP SIGNATURE-----

--Sig_/GD==Uz7p2DqMs8Sc4nMtOdN--
