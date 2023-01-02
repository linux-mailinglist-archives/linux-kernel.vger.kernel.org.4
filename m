Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1530A65B370
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjABOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjABOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:40:12 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2068.outbound.protection.outlook.com [40.92.103.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9D300;
        Mon,  2 Jan 2023 06:40:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nffK1i+fHIvyLsJuQYpcuB+AyUK7cwaxAlbbkI1B0UuSdjf3LqynRIuOVUXECmdSL0JjYZot9kD2bNUmmUI7HzB4QATNVTattRKRuzR3c37+jAFIKtYP/TLTCLFNr/vSNj6/oktPmSQQApD/fRYvXN3PRNebmIOlyGb4xQYtJUsAVeia7Owk0mdtPBZauW/JVI//j0Ojn0zchXzY5B5JgssDIAtjzp+DvnLVGs/9+tjB+4W5ehsrUOiKjjjQ1hGrXJQryOE3lxBMAYBB3RSFHshdqHIWTma5wO7oOVbdW/oHbnH58VRTpXkWQhLHj3graBQLmrciyajWuHAClWW1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQUbrmMNNYrvHRXeGi9a9FXrDhRZ4NV7kKsuKyXQTAQ=;
 b=HkiWp1Ju7AER7fBtE7UozeObxCLEsCpmtOAug8GdNQW6UhGhnicE5jxrcsswqEEZ7ITM0WluHFqeygJ/zN13uyMyI2SPBrx/vffT0L4CqwjO7IAHvikkrOh2S09y+OCRYkssLzwjMBXis+lYxVx1t5kgr6ioXaHQN0H73jKT+XrvMPFvK6JvITgsNbl6K3yFz7rbNoRLErfQHXnCUcD7tPt+1sKa9XyxT/5X3wG0VGVs6HftaXeb6S+YH7EaYbwQYJP7rGGv+ygmSbwUiVHt32qMT7DmC2hDSRv+FBYLTdiWqS5svNYFwxoOuXPGl16d+kvMJg8z0np0Q3luVkFyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQUbrmMNNYrvHRXeGi9a9FXrDhRZ4NV7kKsuKyXQTAQ=;
 b=sGVFXaMQ+GC91FEuxLp2+toI2fopZhNBmWGbxEPFdSmF+rr0++hOaYAxF/PBBYSEMb5I2mDLZhJvzQFGAkQMJ7rtn6wuYuCJVV4Z6WkMedAqgOdpq3NobdEWSrJYuRzahT1WyvQg8WNklfOqbfkR4Zh5AEorli40E5zi01b79sSLqKX+37Pi1VQGbmguBM2qR5TST88+6XMyr8bzrV/fRatCiAv5iq0mzZ+JDehXTvJhTeiRmwKBXrSL8R7t2C/SgNMpCBv1x4sL9S65UiINEFwuB32pUIGs5Uu2Cc20zvILTPZJ2l2myPtEDzGQOQb6kD3Bb4ERZghIfmEHWeGQog==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB9277.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:117::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 14:40:03 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 14:40:03 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware names
 for Apple OTP chips
Thread-Topic: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
Thread-Index: AQHZHrgZDnaanKJG6k6Y1zElujNaAQ==
Date:   Mon, 2 Jan 2023 14:40:02 +0000
Message-ID: <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
In-Reply-To: <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/xxa1By3errEM3v4mna0krMW7j3tH3EX/bIjP5/cXzFzt4cAe5imbucn5S+tO96O]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB9277:EE_
x-ms-office365-filtering-correlation-id: a39661f7-856f-434f-0470-08daeccf3bb7
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+pUXhuBEfdRc4r0zzY4dwxTPwDXCIkULou9NNxz62gr852viBV0pTLZfj6/1YZ+9VayoWYDew5zS9BfQUxP8w7+cquRJUgRXLeaLS5jP1eHECUkULAINHhBkwaOXBaL4mzdON/SPaT5WU2H1IwNaWql0+BR/UfrvgVdAMGfxQk3iTbxKhPpdYSvedqUNgyjxk5lDG9iKRgw9xEAGk8lu9IaHSt6gBO+Gv5dRJh3Crxe8opJfT3kuF8eFOxSybDwbEOZ6f5HA5qXxaPztneUQIpxK/uF4zdQ/tuP7THTS8UKYiKtP/sL1FCIbnlNgaMXPYvS3NSOcVhpWjQ5eYnC8nPLMN94Z8EkEVvY8C4vxhpLM6AgJfKC2WrS1UHOqcSy6OmHmPt0owBJeLp6UTRpU4A3Qz/R0INdJDrj2WhteWaEGvqvWZkHKOfOqwQwM4YZY3m1lPPYG76ICgicJWzBYjZHmjHhoafmp8ZTYgWqTEE/PbnRY2oAZ8FCKZ7WKUa9pow+13FVxjps2G4ZOyurEAsFuBvbo0Eq3qybSiptOScpSUB7Ks+mS2VkPE9EPBUOvmSFtK9z+ikrCvRNyPWe7vDJfvL3Nd+W4+N2A/O7wu0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vh/Pp3B2gGcTEw+fpN8IqyzIkwtt9Lk2sdGPEWAI3jU9xxYykeA6UPsEUE6j?=
 =?us-ascii?Q?Urb+hNt1Tx9R2wkqk7bLGDIb+/nSyL45sxOBbiuH6s/lAgKg2x1egI2t1Ik7?=
 =?us-ascii?Q?cEB1YRLLrRjiI2PsN4rpLkCtQ1piycYlX/L0WOYPXYvheuClUc5JTa/F8GUq?=
 =?us-ascii?Q?Yca5CW4oEvIPlJW84n+3KoecglHvI1h3E+yIm647m60dOYZj65TIQ6sLOj51?=
 =?us-ascii?Q?PpiVarM0zG+z1KPxJqaPZwiwucmcNfLx83j6flHpxsrwJX3TwNJZduI4qQQx?=
 =?us-ascii?Q?3pSAsoZOolG9QexwikRoYp99PeX59As29lGfGOb5EGfx+rimFA0HOCFzfWwb?=
 =?us-ascii?Q?H24CgAHsdusaRB9gYphZYWDI6fJFJ5//YbAGjf9lJ2ntYNj5U8qVmCtmJpXo?=
 =?us-ascii?Q?DZVOUWTfkXh9310rpt8huVkeENRVlDpwO3TGhnSQVGYhhm9iqCNz2pl035aA?=
 =?us-ascii?Q?M8WIy8Ntky+NVasKyYFQwOhyd1sXcg3/9m+M3YfQjfHJrpAW74KvuDQHydi8?=
 =?us-ascii?Q?Pb2VbRrPIKY1yK6FU6Lk2fUBK1lYf9Aa0PHRCPy4FK/CKsFI1RLNNDEdkKGt?=
 =?us-ascii?Q?Y24geLVunuFv2SDQwfo0ESBQ6QChfq3Do6KKX/MPFyqPwvAtFcOJi812aNeY?=
 =?us-ascii?Q?BkTWNFKG3S+o788Xlai3ToWd0wuY1nGDbRpyYsz7WLp1BN7/Y0HqWpCtMzkd?=
 =?us-ascii?Q?7Zeqr3Geio8tct0mEJ1diiMIWNPXnUSTxZ+ftHHT3wNlh4RRBpxCIfkPBhtt?=
 =?us-ascii?Q?tuOQ6c8XRIi/gHf3FvxXV8nHD1PJHSQT7sNDgms1F49MK5BjASZeiUFC5zXX?=
 =?us-ascii?Q?TkHXSu2rqZJ9c7dO90IlyMDUt0euDHfhlEvRoLkuTC+aPMMUTnukZVahyLXw?=
 =?us-ascii?Q?xJOXcMvWlgtYFHfkmpUISS+Hv1t2i/IYQ++hmxbFA3zAB5mJ+scaK8f1MXAe?=
 =?us-ascii?Q?ZJOzbZf1//1GTn80zztY4fWIy6NdP1owXo2m+tQtwiSm3xQcwQe4XNQS7ApF?=
 =?us-ascii?Q?gn3VGD41bNdw+P5yDe0imFKR/uy3L1UwgyWsWJsQvLZQYox73C8qNv42p4iH?=
 =?us-ascii?Q?h8qHLn2n8G/io+bLmxtiT6il0lNZLxkfhTBBjNY5yzaeB/W7CY9J0sG4dfD+?=
 =?us-ascii?Q?d1oN47cO7kJsdDV4avbSqKvLcE5cBhVgbdz+GwfHUWl2SL1c/LLH+zQxZ8eF?=
 =?us-ascii?Q?0px0ElPXpr22ypcehZ5lTazV5ghQjyAgg/bJy50Vqt/+1HG1tL3E0Q4heVe2?=
 =?us-ascii?Q?J0LZ8kbrUhb7K0EM9KGrh3OJjxUtjxS3w7ydpjtPERL8ADCROISoWxUwcobT?=
 =?us-ascii?Q?u3Sk87R7SONRJ9NIVMpTtyZzVv00k7cIcRj1mpDea9tOxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <479D565AC9470C46B41E26623076DDA2@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a39661f7-856f-434f-0470-08daeccf3bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 14:40:03.0113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9277
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

Commit 'dce45ded7619' added support for 89459 chip pcie device. It uses the
BRCM4355 chip which is also found in Apple hardware. However this commit
causes conflicts in the firmware naming between Apple hardware, which
supports OTP and other non-Apple hardwares. So, this patch makes these
Apple chips use their own firmware table so as to avoid possible conflicts
like these in the future.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ae57a9a3a..ad7a780cd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -92,10 +92,13 @@ static const struct brcmf_firmware_mapping brcmf_pcie_f=
wnames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
-	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFFF, 4378B1), /* revision ID =
3 */
 	BRCMF_FW_ENTRY(CY_CC_89459_CHIP_ID, 0xFFFFFFFF, 4355),
 };
=20
+static const struct brcmf_firmware_mapping brcmf_pcie_otp_fwnames[] =3D {
+	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFFF, 4378B1), /* revision ID =
3 */
+};
+
 #define BRCMF_PCIE_FW_UP_TIMEOUT		5000 /* msec */
=20
 #define BRCMF_PCIE_REG_MAP_SIZE			(32 * 1024)
@@ -2165,10 +2168,16 @@ brcmf_pcie_prepare_fw_request(struct brcmf_pciedev_=
info *devinfo)
 		{ ".clm_blob", devinfo->clm_name },
 	};
=20
-	fwreq =3D brcmf_fw_alloc_request(devinfo->ci->chip, devinfo->ci->chiprev,
-				       brcmf_pcie_fwnames,
-				       ARRAY_SIZE(brcmf_pcie_fwnames),
-				       fwnames, ARRAY_SIZE(fwnames));
+	if (devinfo->otp.valid)
+		fwreq =3D brcmf_fw_alloc_request(devinfo->ci->chip, devinfo->ci->chiprev=
,
+					       brcmf_pcie_otp_fwnames,
+					       ARRAY_SIZE(brcmf_pcie_otp_fwnames),
+					       fwnames, ARRAY_SIZE(fwnames));
+	else
+		fwreq =3D brcmf_fw_alloc_request(devinfo->ci->chip, devinfo->ci->chiprev=
,
+					       brcmf_pcie_fwnames,
+					       ARRAY_SIZE(brcmf_pcie_fwnames),
+					       fwnames, ARRAY_SIZE(fwnames));
 	if (!fwreq)
 		return NULL;
=20
--=20
2.34.1

