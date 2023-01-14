Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3F66AA39
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjANIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjANIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:51:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC215B99;
        Sat, 14 Jan 2023 00:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673686258; bh=jB33Q3jeI0y5s9Ce2m9M9FDF30UYlvKOmlqfrMJD11U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ugaENJWeI55eqyyb5bGIF1NEu5kzlI89qmpp2KE2QC+lKlPvEezcMeLvQRj7NOkl7
         lxN/YZyg7EPhKnzVg58fjuCxiNmamVd8v71NuczHfHGNt+RnC/2/Qlr8ctC07dLBj0
         +UoECYUpv6BtOu4dhaWOhAEhS7AIv3iixJUqGvu2nBcRgu1o1NLLRqG92QyVsiFFcR
         hzaSKxUCAnDUW4PXKSs45e9ZZrWLrV+ZscZUZcj6R1ApdinTAi1JSY4ZfWLEVlQrjI
         cNzQsQQVm6vni5nKNfb7pkV0JidnGLTOwdA1OMszI+khx8LNfPwCz/WS3PGdhkEdAA
         OFJDuOdj83uQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MnJhU-1orPq22NYS-00jIKm; Sat, 14 Jan 2023 09:50:58 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ACPI: battery: Fix buffer overread if not NUL-terminated
Date:   Sat, 14 Jan 2023 09:50:51 +0100
Message-Id: <20230114085053.72059-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230114085053.72059-1-W_Armin@gmx.de>
References: <20230114085053.72059-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z5GgtgT7CSW+fcGI445TpQI8PlZHp7xc332KAN0bgoMYytypbq2
 1UkqHJbkKuy4aDiYLowSkXz3+/FcoXqcfR8Olxu+tiaeMW/qSMGtfXNUA8Bq10urn80MU4f
 GGm7zFMPLOZKOF2HIcP6ecnoCTe1+yR43IQ1f/ot3IRmSRYYYkZhW8CFmSS5zGEJiB6Mjfj
 yWQ6kjPj2nIJULk/2/R7A==
UI-OutboundReport: notjunk:1;M01:P0:2wWbPeptUL0=;XKsWl8tIy9Pm/1RdATWuPhINH6T
 U667nRTbh292keZ+vmvZRyrTovxs5qOA6nR5PnrURzFDKWU7E+qlxFm+f86M0SW5J1IRqB4MV
 PnUbD5LBLKxpOOXtygJPCXJZBDYF47O02ifsXlsNYX4uWmbGu5Gs1WIAey3hwKgjXFUH1mYAs
 zi3084Lhy8+If7Ydzr3Xgvpgr+7LB+sJ+4HM9Jeuq/gCMxLFhgIDB8xS9C6vYoX+ufp9cwVvH
 Y0nDvwVnyrlCNIQO822s+ZMr/H2gGTPrutSLDyU8xmbibb4Sf25ac2JTqutzemz4Rjei0z2zt
 7f+/AyA5VH+WlH8yAfQUMUNDNBYlu8xo2PHflmMDR3pd11adBZU/RetK39ELZLKK+M77OiGxt
 SDEehWz3UKvDszA51UsYx0gPQ9BJj+7uyIWvAg0fnXg9vNqBQAMm9qFbB6+NnMBXPd9+XjS8k
 tGlB4gYymWWfK+Vts0SEwuNwqnCwhXEPl5sWWnE8IHTQ2MxZgM6AdWzyG/BIYB5GVS5Mfos+t
 O8sXmLefYlSXUhSBmRQ4Ejtokbb0H27hoZlRog/wV7b9dY1ZsX98TAkzbx61BpLwNQUBrZoUY
 AFmAWNVe9aaxxcpXK9K3VKpClAEj3dEohVu2lNAtDRuD+bCunYE0fLAknDi5bMewLoR6SUJBX
 PbAHjjxQUVmt0wPtx5RCEm8hyO8t7JjgNiMh7aH3Urod3ufmDfv0z7WpVWNyMoqEqCDhqtYVH
 X8d+RgR/gxzKrnnQeziWIPaKhMenfEFdeExdia6wxrQfo90WSBZjAY9rzC0Jj2YtSdnm0To2Y
 sVyX3Kxo5CpetP5P+FjreA4sJc2W3rzFC71rD6n796dh9eJL4K7tMoFCABv/zRHS3OSDXnUoO
 yDbeXfaYsj1dToaYkUfWOA8YDUhbHzP0fRwBhIz0fcbRel1IjaHtdBGIADvGXGbVeI/fw7Q98
 VkoVTu0iVgM9/XyN89vCvJXkAC4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the buffer containing string data is not NUL-terminated
(which is perfectly legal according to the ACPI specification),
the acpi battery driver might not honor its length.
Fix this by limiting the amount of data to be copied to
the buffer length while also using strscpy() to make sure
that the resulting string is always NUL-terminated.
Also use '\0' instead of a plain 0.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fb64bd217d82..9f6daa9f2010 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -438,15 +438,24 @@ static int extract_package(struct acpi_battery *batt=
ery,
 		if (offsets[i].mode) {
 			u8 *ptr =3D (u8 *)battery + offsets[i].offset;

-			if (element->type =3D=3D ACPI_TYPE_STRING ||
-			    element->type =3D=3D ACPI_TYPE_BUFFER)
+			switch (element->type) {
+			case ACPI_TYPE_STRING:
 				strscpy(ptr, element->string.pointer, 32);
-			else if (element->type =3D=3D ACPI_TYPE_INTEGER) {
-				strncpy(ptr, (u8 *)&element->integer.value,
-					sizeof(u64));
+
+				break;
+			case ACPI_TYPE_BUFFER:
+				strscpy(ptr, element->buffer.pointer,
+					min_t(u32, element->buffer.length + 1, 32));
+
+				break;
+			case ACPI_TYPE_INTEGER:
+				strncpy(ptr, (u8 *)&element->integer.value, sizeof(u64));
 				ptr[sizeof(u64)] =3D 0;
-			} else
-				*ptr =3D 0; /* don't have value */
+
+				break;
+			default:
+				*ptr =3D '\0'; /* don't have value */
+			}
 		} else {
 			int *x =3D (int *)((u8 *)battery + offsets[i].offset);
 			*x =3D (element->type =3D=3D ACPI_TYPE_INTEGER) ?
=2D-
2.30.2

