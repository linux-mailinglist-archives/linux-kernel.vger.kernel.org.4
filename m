Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5C673B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjASOVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjASOV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:21:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF0402DC;
        Thu, 19 Jan 2023 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674138082; bh=z+fQzZKHzfUH7NF/TUveCeidpfldeQForUuhTzrvsYk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CkjqS1nNHJjYaFwYSyXVLW+TPmEckCs8YKHS7oUwWpSzDNBtOikU76bAC+MvklKYD
         xbjOp6SE2333DyQ+lFh1NqwvI9BOmn5HsZwuOf/SJOtzNd3/Q8givTZYvdo1liio1D
         k5P6lwhLEc5rk4JmxektSrTR0852RL4EFIt3VevVOmPbs5s0/BK+uVyHtXfo/cuDIY
         iQ3nSSLYMz2yrZyJXc6CVtm9rNeOgcjhcZDvXTIljUm+eGBFmUqeStdwrwfLw1ktnX
         y6eBbnqjckR6bTaVLIXTRE4tytQb84ie4yJ9fUO8wjmpKtcFj8NI7q1BnXG6R+ixq2
         HRZVSlJQnOS+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N0oBx-1oWzgN1RED-00wmb0; Thu, 19 Jan 2023 15:21:22 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ACPI: battery: Fix buffer overread if not NUL-terminated
Date:   Thu, 19 Jan 2023 15:21:14 +0100
Message-Id: <20230119142115.38260-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230119142115.38260-1-W_Armin@gmx.de>
References: <20230119142115.38260-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dVU26JDgfTRY3TOQ06V2r83qaP9yA8G+jIxMPfP/xcgPS8mluVb
 LXOHmVWLGVDLEYeh4C76vXsl9e5uPRM3yQevfZ8EpzZeSa+VipnvIFR+vCmZo+ENZc/tCm+
 Z4Nh4QH/gJSnvTqGTS7qGMukZ/4QMYzUGymeCkigC/CDW1CyNUvwc6vohZ4/UjXIHITbViD
 OCSDthmX88J3lj6+ajYww==
UI-OutboundReport: notjunk:1;M01:P0:MY/5IUDF2LA=;IdqnLHL+AaMS4mgs+AscZnqUEIk
 hPMZQ9DamDtoQp6RJif8mimOOx56n+LhIUtgvNx5w/N2jvVKex8FLoIzjUsBIOowusLNwk6Fy
 M3jA+wOTODfzvS9jUeFkZfekPdmZCvToflJnSF1AHlM4e1jSU0c0zooDdoUDkRjIvTSZYrw/a
 PUS1fdEypxEfFWhYj/ggNI8ZT7gjbcg0zXa5sW0k0EdBZFd0qiSzag+DpzXJpOX7xeQWJczxn
 OpTt3ASt/rqQbrlLwqnN+FV/GO1oo3e+fEPP4zoFe+qtnoP9BsnnDWV14NTijVATUNbSTOk2x
 Yp+Zy826sxc06seXJd6ctUXmoEgyFSBmpzz3wNyckw70jdJPbohEx9P8Gx9+w6VIk920iuckH
 BFQGPiHnGZ9mI8YMEeHOTTsdPd/v6cqhvxxxUzY6AduipyHn2o2obQ5XoniZUqsNMX6cqPdGT
 1YlD7DIqt3IuFiXWp5CPkJhsBSthR2Fui7y8lpdcQ6hm5ZjFgiW/py9kRFVV1HCgXkHwtbKOJ
 clS8DRytzeRmU6hJNr/UjqgrDGo6VeWatirWszBxcCn8K1LAUmI7I/riFMYwHpX7LpTv0CeJt
 cr9ZOh77MzbXF5rFGi3BJRz1C9WcuXC1drD8kbniW8Inj19Xo0qEMwLX4Cua4mZAbhlFgg4hE
 pdK9SZCNPploDHsHuS7AJjEw0vFtuaMMXLu2ikWbbv/r0JHBceNIz0Po+/VZ7m5P2zI0kIlsb
 nnnrIZ4/SXTusPclwPjgt/s24qt8rlRQet9QV6y37VlIgMy+fbM6kPEMaABq5KqmOkDtVeukr
 O0gXvgo/sXXMwmB9dPFg8knJrQXlH4e7uFUjX7GKOmHXTsPQp73ADjavVvTlOIUF5kYlYn7JU
 wZducAU6ALkyuL1TFbuI2J9Jp2XSwwFvHoxbf1uHm5qbX2gqbzfCM7Fhsml2yemb6Mw2mur0v
 K5kMlPxbPP2hwMDjRHn7SyO3pZA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a buffer containing ASCII characters is not NUL-terminated
(which is perfectly legal according to the ACPI specification),
the ACPI battery driver might not honor its length.
Fix this by limiting the amount of data to be copied to
the buffer length while also using strscpy() to make sure
that the resulting string is always NUL-terminated.
Also replace strncpy() vs strscpy().

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fb64bd217d82..0ec12a7dbcca 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -437,16 +437,25 @@ static int extract_package(struct acpi_battery *batt=
ery,
 		element =3D &package->package.elements[i];
 		if (offsets[i].mode) {
 			u8 *ptr =3D (u8 *)battery + offsets[i].offset;
+			u32 len =3D 32;

-			if (element->type =3D=3D ACPI_TYPE_STRING ||
-			    element->type =3D=3D ACPI_TYPE_BUFFER)
-				strscpy(ptr, element->string.pointer, 32);
-			else if (element->type =3D=3D ACPI_TYPE_INTEGER) {
-				strncpy(ptr, (u8 *)&element->integer.value,
-					sizeof(u64));
-				ptr[sizeof(u64)] =3D 0;
-			} else
+			switch (element->type) {
+			case ACPI_TYPE_BUFFER:
+				if (len > element->buffer.length + 1)
+					len =3D element->buffer.length + 1;
+
+				fallthrough;
+			case ACPI_TYPE_STRING:
+				strscpy(ptr, element->string.pointer, len);
+
+				break;
+			case ACPI_TYPE_INTEGER:
+				strscpy(ptr, (u8 *)&element->integer.value, sizeof(u64) + 1);
+
+				break;
+			default:
 				*ptr =3D 0; /* don't have value */
+			}
 		} else {
 			int *x =3D (int *)((u8 *)battery + offsets[i].offset);
 			*x =3D (element->type =3D=3D ACPI_TYPE_INTEGER) ?
=2D-
2.30.2

