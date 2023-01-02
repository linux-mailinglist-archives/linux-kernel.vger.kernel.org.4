Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4002C65B394
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjABOtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjABOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:48:18 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2084.outbound.protection.outlook.com [40.92.103.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E664C3;
        Mon,  2 Jan 2023 06:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0YoIITDLyrNGrj8xAKrfXESo+c6zwprN5HiuRIhI43ndH9VxkTxvDjzSO9rgZ3OXsmzsP4SBu1D1dZgxPfFEbKIGpbVMSpZ+f1u9JaWVyfm0UsXxL5UxjnRoM9C75Rk1RDq9VRCJnIdJZ363DFitxGEn/+vp4G6PwfHUzEz3KYwUs2pF7466WXE2fIyvViJ7943McAyHhNMGXvkfqNWkFSjq+lp4ldPXbB1B4DJR1PONsGmrFKefgEFDhKViHO7Od5hBR1awfr5NUP7msDUM6Vn1KJ03uNkps9kikCnI/zrKvf8Tn3p1/psuTkFrd+56hIlgcsRLKuZ10aui0FI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skyvdBEDYmt/Zi08JNadOVLtRCZvwbGI5nWOljrU7EM=;
 b=C7G4lMkXcEtd4FbuSdVtyceZuUiF9SxsiSle3c0C3vWrMkvEpoV28OK0JJr+e3bDRgW7eTva4VzLQcwGBWpRBbptpC/GRiQoTBX0QALssh0egX1b/uRoO5WU/FSaWhaE2/Cs03VMI+3h+QY6aruVebSEd3xUG1hWkG3unjIiF4CggCZygeny65uFoEzMpIhWcuyDAYgYYQc/orSKUV4QO0ynlXtOafo40DgosRwEe/pi91o5CojQT9oE+3WJdYiIxfRD5Ttk8DlIHjOCbuNIesvHweN7MAfh0MDNbnIwuG4yjiWEGGdUG2woEAdnKfr6jiIVZGCjldSi8/JBgLZKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skyvdBEDYmt/Zi08JNadOVLtRCZvwbGI5nWOljrU7EM=;
 b=TaPApGWDWvBrKIii0rm7qwJBZtMuuEM6we+5rO7plevG8YeLvw2YOsp95r9pV8dNK9Yp2MzRfaig3e/uF74UehjfiIawWHslcymznmr7F/vE2yLcHTvrbd/D3pQFszJVb3hSnCZGja6Qlx2De4dnO4TPfLNKIxPG/Rog9EVXWgXRwztPoIojyTIWYr0zfD+80fxQXlkEfYu9qJ6WwD73KjSt8B0gK8CIkhfWKKbYFxYE4TeF310kTlTszEOuc1KBDXzEwsdzES54zo8oN6m37rYQeSqEVJtghO6tkBG9oaPK0n1iPqQmwrhX3wsk0Q/uLSYbgS+PFyFdvPhkYK/iGw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB9277.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:117::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 14:48:10 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 14:48:10 +0000
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
Subject: [PATCH v2 2/2] brcmfmac: Add PCIe ID of BCM4355 chip found on T2 Macs
Thread-Topic: [PATCH v2 2/2] brcmfmac: Add PCIe ID of BCM4355 chip found on T2
 Macs
Thread-Index: AQHZHrk7yHCvvY2IKkSePRpXpxxfUA==
Date:   Mon, 2 Jan 2023 14:48:10 +0000
Message-ID: <276EA85B-22FF-4446-969D-11437AB28867@live.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
 <E376F3F1-CA88-47B3-B3D1-EEF0B283D25D@live.com>
In-Reply-To: <E376F3F1-CA88-47B3-B3D1-EEF0B283D25D@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+pHvtqqyl7QFG7YyyBcyJTGW7Jtif9kFEC2W0TId2Xrz1AR487/kxkEgiyFvsTbU]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB9277:EE_
x-ms-office365-filtering-correlation-id: aaa3c956-b433-4654-1e18-08daecd05e73
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4fTFGqE6NxmoAh7Kl6S6+xWCiPXUjeoZFqr6mm76eiJc0NbaVDWfljrE7aHcEDRIJ6MFOdInTXyC+YlB7e3IA16/XG2hucE6wpFIvhh8ge/tr8lGwTJbA3T0f1l2cnzvtzyhH6qJ5w4KnH5cluA5sRJyEIxlzrmSFFl3ni7DrJ8IJOvgVlxYd52pkqjfYxdxaU17IDSES5Kvcq8LjSHZGVHGTY1eGjpcd1DbNUluKOmSl78qbdLIGfXjbB/yOuK0nCRgB3GvO39diX9MixyaXlFkp9atMlyzlfqCRLcEc3NJ5XzF8s3UsKCCq6ye38u5GMAw05dtZ4Vxa+ZjoYRuP+8CtByekMtoqQ0RitPZtJMy2tYhbmnzsGNmJdSxYzXbHWdgcE0T0/SfBcCZKt1O845HBS2/2QyffJqzaBJgI+wcKwx0GZ49Cb9IoUny16jmExy/HdeII/Almh6KYTUR6lrxF+H+p6WwOcvy3B9NY98fOwNWzM+ze0prgT6q7kz/OSZAL7Xv/FTRJTp0HL6a42ZKdBa7W133y5y/tk8SFRw16emBABmbmex2Bpxwk3Tn9Lp6nQ0sxr+oOwQhwHUkmeekb+1ceIuTORw4AOmH1XE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vgU3CHkcQFiiOnq64+JL1TKbn6+fES1/GZk1WB9X0TPsBA/0upb08aWES4eq?=
 =?us-ascii?Q?enl2TSVvh/dgUj5TGqzccLrGbCfqe1wIroxVY+vtk5V/bCLMin6LCDImJMtY?=
 =?us-ascii?Q?h+sdS6n2I1bwLZlokXnSEt0CkLkKqbROCASBF0O7cQPIBNqpbsWzqkmoOc3J?=
 =?us-ascii?Q?RE3xikWQjEEuJWahLfIEpV5OEq8F04sq1yI2/FAx1CEu/piOzx7v8T6sgluG?=
 =?us-ascii?Q?g2v7fqrsms+U2JjTX2sU3fmdqrgl3eTOLWCaLyd1diw5edTX32rWR+n6LcC3?=
 =?us-ascii?Q?r2UyGckS89k9CZBTzooCWqh52tKef2w7/VGMkRoHzNT/zK/JpbuVqzDz3GmZ?=
 =?us-ascii?Q?O/7pvbvK1amu98yf5nCi/+K9p+y/fSIG1zqukQITZSPG6AyYKzfgL0wFeyW7?=
 =?us-ascii?Q?4mNeVohVCgy9BjgpWpaDAeXXi1gikPwo7RFLvRE8+MBduXz4B9Na2QePg3gQ?=
 =?us-ascii?Q?KnH+fvFXcUYUkdWx2RpHA85dLa5GWmtGYtjG4JRwjhoEx6U/e93/a7lirLtV?=
 =?us-ascii?Q?y964UXa7PVgKmCRuFx+UtIT9uloqQpz19MOfYrbSAMuIyU6JqanCocqXSrWX?=
 =?us-ascii?Q?ut7Zra6c7VdMvvLMFpe3YCETiF+UYCSwUAaWzP8SRE/WnrFsGNPgloG5jRkL?=
 =?us-ascii?Q?ijkWoQXBpSQuIkjiP2CzoIJnREXCS5Gw8Z6yCm6IV1syYexdm3bw4/mXRtTB?=
 =?us-ascii?Q?4if599f950OBETYx6NxQ1ejC2cB8agdlPD8w2iGuzEnkRP6c99BDQPKjLmgz?=
 =?us-ascii?Q?kGWjUtpw9XD0h3BwB5MpCPPeDGTb4TDUSGsUT9oy/gNP0SUhVVTKBrJSSaKi?=
 =?us-ascii?Q?Ph2FCZLoYNBmnULE2pIVyh9kcK+LWg2wGercTdR/ZCLPC+guLrzYb2pj1zJx?=
 =?us-ascii?Q?ZkNKNXQ9jE0a23+T8DhiyazwJAYVOQoUelF8+m1Vv7ADgDId5btIzWO7UyER?=
 =?us-ascii?Q?k8kLAhFChZdoJqgyIkrEz/9SbXGin9c+Y6WWDOVl6/ayRpZHly9iJgSgK/MQ?=
 =?us-ascii?Q?LNCAyP/oTBZggh1k+6zISUptKXS6Dv+dNxQYZ/eaHimUKvjWdWOL6lbnBv+6?=
 =?us-ascii?Q?KZKCNCyqgaDkeoBdh9WVfAkDamB0pBnQzhFlT2OF/2iqPoMErIv+R+GpNe2m?=
 =?us-ascii?Q?+4bAVcycRQzz80ejXqrZ61lkkGPvZzy/ZMhl1hVRzms/JN3fMVqWZn066YUN?=
 =?us-ascii?Q?YMBGZ9Oo1DMx2bl7Y/QVl3/rPmstH5lwtrnXoUViA+spYIu5hSH1txAite+h?=
 =?us-ascii?Q?KOpshpeJmj+OExQBvZwZQswb05IvHz3j00QwjYokVT7QP0kqZ7BdkC7dzmVa?=
 =?us-ascii?Q?7qkeQrt2edpAWQT/vY/1qYMwYzwqwciiCviyJ2ume7Ju9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9744C1DFC5CCED44A42AEFBDDD3D4E87@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa3c956-b433-4654-1e18-08daecd05e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 14:48:10.7676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9277
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

Commit 'dce45ded7619' added the BCM4355 chip support. This chip is also
found in MacBookAir8,1 and MacBookAir8,2. This patch adds necessary pcie
IDs to add support for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 3 ++-
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 121893bba..2f338c5d9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -735,7 +735,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_pri=
v *ci)
 		return 0x170000;
 	case BRCM_CC_4378_CHIP_ID:
 		return 0x352000;
-	case CY_CC_89459_CHIP_ID:
+	case BRCM_CC_4355_CHIP_ID:
 		return ((ci->pub.chiprev < 9) ? 0x180000 : 0x160000);
 	default:
 		brcmf_err("unknown chip: %s\n", ci->pub.name);
@@ -1427,7 +1427,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		reg =3D chip->ops->read32(chip->ctx, addr);
 		return reg !=3D 0;
 	case CY_CC_4373_CHIP_ID:
-	case CY_CC_89459_CHIP_ID:
+	case BRCM_CC_4355_CHIP_ID:
 		/* explicitly check SR engine enable bit */
 		addr =3D CORE_CC_REG(base, sr_control0);
 		reg =3D chip->ops->read32(chip->ctx, addr);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ad7a780cd..0a7410196 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -78,6 +78,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwn=
ames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0x000000FF, 4350C),
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
 	BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
+	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFFFFF, 4355),
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
 	BRCMF_FW_ENTRY(BRCM_CC_43569_CHIP_ID, 0xFFFFFFFF, 43570),
@@ -92,7 +93,6 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwn=
ames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
-	BRCMF_FW_ENTRY(CY_CC_89459_CHIP_ID, 0xFFFFFFFF, 4355),
 };
=20
 static const struct brcmf_firmware_mapping brcmf_pcie_otp_fwnames[] =3D {
@@ -2599,6 +2599,7 @@ static const struct pci_device_id brcmf_pcie_devid_ta=
ble[] =3D {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4355_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID, WCC),
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h =
b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index f4939cf62..fee1ff526 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -37,6 +37,7 @@
 #define BRCM_CC_4350_CHIP_ID		0x4350
 #define BRCM_CC_43525_CHIP_ID		43525
 #define BRCM_CC_4354_CHIP_ID		0x4354
+#define BRCM_CC_4355_CHIP_ID		0x4355
 #define BRCM_CC_4356_CHIP_ID		0x4356
 #define BRCM_CC_43566_CHIP_ID		43566
 #define BRCM_CC_43567_CHIP_ID		43567
@@ -56,7 +57,6 @@
 #define CY_CC_43012_CHIP_ID		43012
 #define CY_CC_43439_CHIP_ID		43439
 #define CY_CC_43752_CHIP_ID		43752
-#define CY_CC_89459_CHIP_ID		0x4355
=20
 /* USB Device IDs */
 #define BRCM_USB_43143_DEVICE_ID	0xbd1e
@@ -72,6 +72,7 @@
 #define BRCM_PCIE_4350_DEVICE_ID	0x43a3
 #define BRCM_PCIE_4354_DEVICE_ID	0x43df
 #define BRCM_PCIE_4354_RAW_DEVICE_ID	0x4354
+#define BRCM_PCIE_4355_DEVICE_ID	0x43dc
 #define BRCM_PCIE_4356_DEVICE_ID	0x43ec
 #define BRCM_PCIE_43567_DEVICE_ID	0x43d3
 #define BRCM_PCIE_43570_DEVICE_ID	0x43d9
--=20
2.34.1

