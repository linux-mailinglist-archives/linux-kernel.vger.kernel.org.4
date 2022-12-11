Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB0649446
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiLKNDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLKNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:02:58 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD6B494;
        Sun, 11 Dec 2022 05:02:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9309CEF95D;
        Sun, 11 Dec 2022 05:02:54 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LLMKInvpj9o2; Sun, 11 Dec 2022 05:02:53 -0800 (PST)
Date:   Sun, 11 Dec 2022 14:02:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1670763773; bh=i0g+3oryYH+bTrIcDnrXvCPR8IHUH6ivXegwOUCTJr8=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=R1h3ppXnvqwH42II/jPs2ZonYRC/ueCjjTydIr5+A1IGl3KCDSKZSDLlC2qunK9Zt
         XLy/Po5QR46esOiiwtLbInNzJ+ATqHc7Rpf6Bw9PcHNCNT+nxPuDB8++phKpm+oWar
         Cn8lvBziyw5Ma+xDVkXu1rEB0pnbzZ4EsOuZrTmAyevgZBXXCegxVi8bI8SACw2fO2
         0h19hqAwm7NC6o4Jn0l9Kv9YMChlRXFq7T10/sxT18YKDpt4ZlqLYrRq7u7gjzcbsN
         9kaKjRmdXCtwSSC0kIhoSs3WQzZMiWIY/2yDqx7eQX4xAjCZ3qbOZ44R3T61rCDX/Q
         lBFtyiGCRdXJg==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: [PATCHv3 2/2] media api: Try to make enum usage clearer
Message-ID: <20221211125718.2815126-2-dorota.czaplejewicz@puri.sm>
In-Reply-To: <20221211125718.2815126-1-dorota.czaplejewicz@puri.sm>
References: <20221211125718.2815126-1-dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.sImXqZfT50grP0_PGGp8hG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.sImXqZfT50grP0_PGGp8hG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This clarifies which side of the calls is responsible for doing what to whi=
ch parts of the struct.
It also expands the terse description of the access algorithm into more pro=
se-like, active voice description, which trades conciseness for ease of com=
prehension.

Fixed: typo "format" -> "frame size" in enum-frame-size
Added: no holes in the enumeration
Added: enumerations per what?
Added: who fills in what in calls
Changed: "given" -> "specified"

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
---
 .../v4l/vidioc-subdev-enum-frame-size.rst     | 44 ++++++++++++-------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame=
-size.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-=
size.rst
index c25a9896df0e..82b5d2538fa9 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.r=
st
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.r=
st
@@ -31,18 +31,30 @@ Arguments
 Description
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-This ioctl allows applications to enumerate all frame sizes supported by
-a sub-device on the given pad for the given media bus format. Supported
-formats can be retrieved with the
+This ioctl allows applications to access the enumeration of frame sizes
+supported by a sub-device on the specified pad
+for the specified media bus format.
+Supported formats can be retrieved with the
 :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE`
 ioctl.
=20
-To enumerate frame sizes applications initialize the ``pad``, ``which``
-, ``code`` and ``index`` fields of the struct
-:c:type:`v4l2_subdev_mbus_code_enum` and
-call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to the
-structure. Drivers fill the minimum and maximum frame sizes or return an
-EINVAL error code if one of the input parameters is invalid.
+The enumerations are defined by the driver, and indexed using the ``index`=
` field
+of the struct :c:type:`v4l2_subdev_mbus_code_enum`.
+Each pair of ``pad`` and ``code`` correspond to a separate enumeration.
+Each enumeration starts with the ``index`` of 0, and
+the lowest invalid index marks the end of the enumeration.
+
+Therefore, to enumerate frame sizes allowed on the specified pad
+and using the specified mbus format, initialize the
+``pad``, ``which``, and ``code`` fields to desired values,
+and set ``index`` to 0.
+Then call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to=
 the
+structure.
+
+A successful call will return with minimum and maximum frame sizes filled =
in.
+Repeat with increasing ``index`` until ``EINVAL`` is received.
+``EINVAL`` means that either no more entries are available in the enumerat=
ion,
+or that an input parameter was invalid.
=20
 Sub-devices that only support discrete frame sizes (such as most
 sensors) will return one or more frame sizes with identical minimum and
@@ -72,26 +84,28 @@ information about try formats.
=20
     * - __u32
       - ``index``
-      - Number of the format in the enumeration, set by the application.
+      - Index of the frame size in the enumeration belonging to the given =
pad and format.
+	Filled in by the application.
     * - __u32
       - ``pad``
       - Pad number as reported by the media controller API.
+	Filled in by the application.
     * - __u32
       - ``code``
       - The media bus format code, as defined in
-	:ref:`v4l2-mbus-format`.
+	:ref:`v4l2-mbus-format`. Filled in by the application.
     * - __u32
       - ``min_width``
-      - Minimum frame width, in pixels.
+      - Minimum frame width, in pixels. Filled in by the driver.
     * - __u32
       - ``max_width``
-      - Maximum frame width, in pixels.
+      - Maximum frame width, in pixels. Filled in by the driver.
     * - __u32
       - ``min_height``
-      - Minimum frame height, in pixels.
+      - Minimum frame height, in pixels. Filled in by the driver.
     * - __u32
       - ``max_height``
-      - Maximum frame height, in pixels.
+      - Maximum frame height, in pixels. Filled in by the driver.
     * - __u32
       - ``which``
       - Frame sizes to be enumerated, from enum
--=20
2.38.1


--Sig_/.sImXqZfT50grP0_PGGp8hG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmOV1O8ACgkQADBpX4S8
ZndWrg/+ICE/fK0SrMOV9BqatDcSIxomz8zoyXZya+OYQWRTRFosJLtZ4PYG5keB
FOOddKdX66pHi3r3qz5rTtaENgLStIxT+43N4LDdDCmfK/bJK5aI+4wsaedKsfSi
UqN7EJr28jpc/g4mfyZeMzj/bo0yEv6WVSsVxvOZME7NHlhUNyw/whbeYwE6A9/9
W+bID39V4QOlE8AK0rip0dYyYKlxsu0HLdQkq1hXIm9FeeNXJwBn5oPE80VKb/RJ
ReN/5iZwoNAx/eqGpg0oTq5fZwTReJ0HbDT/ntHCDEbjXsUAA+JqKo1g+yDa2PX4
8ILBIAVq/JLfIwbXUge88YEpI8DYB3/6thK2XdFlX5QDAXWyS4bgrKG/8xLZgtGc
KgileQuMKQyDjCqyqR5h2FhWXug6LCII3FIvKQwuBGzQXGLqwSErRu3oT/qFjSdg
Dp56U/QUzZROhxc3/Ea32dz4HqbPw4PAqqRtqMDVbI/XeKnbyQL1S4Y7TylfM4LL
P4o2E5x/9tomgZliVnRVLcA//uOI8V/nsn4gImOi/QYihYx8f5JzuC79D+ZSRqpc
f36HM47CeCUP3hWQquIUrohvp21deidc1pEnauLLeKujwJakmy+aff6JY+XFMANq
KUe4iBrDYddHbWrEG/El0HbfLDVCi87bG3wwuPn8gP7b8s5yQeY=
=PWR3
-----END PGP SIGNATURE-----

--Sig_/.sImXqZfT50grP0_PGGp8hG--
