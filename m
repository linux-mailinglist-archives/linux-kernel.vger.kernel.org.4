Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8D66AA3B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjANIvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjANIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:51:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789AD5BA6;
        Sat, 14 Jan 2023 00:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673686260; bh=ZRXDOHGn9yZu57/DPz1iMB9OlkHhVNY+RiI8eWQZy7Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pLvDoi+UkLmHCYXsNyLYXYV53IObWoyJZafOBDM7/xWU9N2OdOERE+YWsiX9kr8QE
         21sD5GeM4fvtVk6H6wp4rQWv/rJhUhl9RsSVar35f6QYxod2K3jsgDJCTLQo6hAQrp
         G/U58GQ/193DUoulcnHyjjsIcWiqInNdAKuZ2dG061FCKGu9//lzxnRkPCrGoC1/w6
         L9Xy+Usbspusw79LnqU1iX8jN/Gu5IsepspIfmflkTIxSKr3d3lJ7d7H4OoO95znmd
         IYef5GOS8GZSdeJCd8FnWxUvZgxkYAlJmF91wH23ZjvhEvC60LPHv6baZVILvbnXSt
         taDtekps0eb7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MTzb8-1p7AIr3qJG-00R4ov; Sat, 14 Jan 2023 09:51:00 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ACPI: battery: Replace strncpy() with strscpy()
Date:   Sat, 14 Jan 2023 09:50:52 +0100
Message-Id: <20230114085053.72059-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230114085053.72059-1-W_Armin@gmx.de>
References: <20230114085053.72059-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nEZOIaBECnOJgOL0HPTpdVTEJLBlJu+3+2Qk7c4CHM64oEsNvM1
 MK0Qc6IY/nXmbWlmjtoA3YNvPu6SlIutDmjNGhyAgJkBBCnjS2QM3oAA41zn3pVqda0cl0X
 WalSa89lF1lXyN1vhpmY51SrfzKOBdQUWq29Nz9Za4mobsWriR1Wa1ghgzOMBQJexaP3pxI
 qSyVkUsUSAt0aQ/nXocvQ==
UI-OutboundReport: notjunk:1;M01:P0:GnJcBRdBtq4=;Ih+YY7KENBNCd2SSEcHJVwizecw
 8vH04p9rGNR7wfwwdEm7hVxG3LGtkwXvYI2ISa+hEassqfFELz/MvpMsm/RWhSTIXvebUBpZ0
 wpdiPxQGhP+QbOaLaXekf7xxXyLAk0yZ1U9X0e0M9LuxwzeblUZ8Oxqi3a5ixf8gTBonesvh1
 mfQY9PGjIzr1SW/zuGDxeZd//lFQvmD/Ybt9OuRAyWxexeE1B8XcEFA/QcvsodqAOpJ9vwtyE
 JANYGX+zhf3saM9AnWiNVGW74VXHV2NtVIjdgEPYaUJqJE4y56c9xXzkQQOPnm2awUWKX3nvU
 Iy0Ta2A1oi8HH/PNEYAHj0G8qVWlykOntQNJdt+I+pbI9CUf+0icaYx+vAR3HzIoN0iYvlZ5C
 AhKw+fYAMpDHhirhHDjhUw8/y332L/xRKkjp+Ex83xHuOsxjpLTYn7bmNNVflBL+F9D/3oUed
 MPcNYKkO8YH1xICNqkS8xj56RUMm3e8Hd/IWHGUZwK5UTs7mnIk0usmTzDjUd8dypX/rqkACt
 m+d5jnC7NvNFk1apjGHAols2Dt0LwkqtOEShsOK1Dje0SNxZAJTOoj26uVZGEHG1bB6+2nROT
 KalYmx4mwVOFJdeYw3259r3PmXB+OcN1sKOtYlIsGClSM/1mOq6PIlV0JZ61P7R/nf+KT1I6W
 gOUPJTTO6Iib0kSLJkWxXNRoyNsjRxgIRVbFP/S5iyFXZnjXRteqrAZSgv7jGOWFkfs5Zhkoq
 Nya1kljngMTHGQMW1ZT0CQrDe+z+mQju0oD1ehrKJyGo7n0QvNLUrVeY354GeHtakIn89w9Yy
 CnmJyQg6EHpEQIrm8sOuvacuHP5uu5YPMHs05GI+pL3uN9p9xvwlI4dxKo1Qbrl/2TMxRCkZ5
 qIXa7C54LuMA/pBLa03jlKCAX2Lmfg4tZUKJkXaDOj/x+7lc55qELSZLy2QpqTa72kATGk8hH
 JEsOV7fJW2zrZoFZkISpQqkHTak=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, strncpy() and manual NUL-termination is used
when copying integers. Switch to strscpy() which takes care
of NUL-terminating the result.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9f6daa9f2010..b39b84b8f3ae 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -449,8 +449,7 @@ static int extract_package(struct acpi_battery *batter=
y,

 				break;
 			case ACPI_TYPE_INTEGER:
-				strncpy(ptr, (u8 *)&element->integer.value, sizeof(u64));
-				ptr[sizeof(u64)] =3D 0;
+				strscpy(ptr, (u8 *)&element->integer.value, sizeof(u64) + 1);

 				break;
 			default:
=2D-
2.30.2

