Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF96649448
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiLKNDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiLKNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:03:23 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70653BC9A;
        Sun, 11 Dec 2022 05:03:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4AD5DEF93D;
        Sun, 11 Dec 2022 05:02:52 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aJhmIaotL3Ao; Sun, 11 Dec 2022 05:02:51 -0800 (PST)
Date:   Sun, 11 Dec 2022 14:02:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1670763771; bh=3siezGDNug+NuYJKLWyZorIF87F8xCDbpriaUUSAiBk=;
        h=Date:From:To:Subject:From;
        b=cdlbRuUZEcrw64buujadebEnzCUhNZMuvngo+xccAAqlRB1TaScK0UCEzbeZlbP2A
         paCjncf2/wOPEvW3dB4V9O5bb+XEEcz09ncxEE4A5cZUvqStXSp3o5bSQEexGlcwEM
         Wn66wq6doqq6VRLSTGxGBAeWYLKmC4CTs0jaV/2AxjT5GZQ9f6Xrg2iwsNYq2h482G
         W1pcxMu/CNeGtR5Yj1ShGGMpBeckRzpv3LNjg5AeQ7/IJdXD9Kd5V5W1AT12uQKaDe
         ivM3mtRZa81G/v2Vr8V0yNem0QfiH2cP7EPPp54igrrAGWlviv0Rvx52CNujudLx7a
         9lxzI10Dr6zxQ==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: [PATCHv3 1/2] doc/media api: Try to make enum usage clearer
Message-ID: <20221211125718.2815126-1-dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aWgLOzhGB3Wy1cXwxIIV1e8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aWgLOzhGB3Wy1cXwxIIV1e8
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


--Sig_/aWgLOzhGB3Wy1cXwxIIV1e8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmOV1OkACgkQADBpX4S8
Znc5Bg/+Kls6FhJSbsQfoqshG1TDkYXP0c2y19rBv/qdh9H+CrcXB9SuQ2CkHuDK
HBlcETNTyl1Nt8RUoU2+mWw8ARbjP3VEs7/w8WyCfcOxtG28qWPAAKwwoqk4QuC1
XmIwa1NkXCL68tvD34thgC5eu0NUaLUPpgPtiry5JL6mOvcfrSfEdsiYCvTc3sRg
oTP5sDxrgl0qlHfZ/vW6LpoU2f6CYJY2QwkOAd1UHuKgHPHWmcIaISSDgkrN3FSd
cv3zcC2fMC7EIwlsgLEXi5gvXSJXjgmbBEV2WOeZgF36dS42P121TLtALHFbh4Oy
rtqkAz1zt/mXNfthmMOTMVSy0mv2sj2eJHw5tGpen2uyy+SqFBmO9Z2XWc2gwOus
MEKiPSNtww7+WWxAiDnglEh99KW+8w7MbAJl35dNdJJAH+kg+uma0s9VmILZtCaf
chx4mDz720K0dHYBCXUWHDqk3WTF6W04Q7CW48wLD0r85mknMB65X7RQQn543Z9a
vxhazKGSMtXZXyQpOUlVNPtp+tCw4YhRwZwFNsus/U5xLq9TlJUXO+rnt6R6Hb+c
9GhcKKZp7dUGTZ8PfTieyoBh5bKte8mujbNr7P+2VrWcueAHJzyFQvjCyP0szI5H
vZxt2hs+YzzvuY19pCkFfi9l6XzIhxqwQWHZXdfUBvCYfTp6Yn4=
=5FBV
-----END PGP SIGNATURE-----

--Sig_/aWgLOzhGB3Wy1cXwxIIV1e8--
