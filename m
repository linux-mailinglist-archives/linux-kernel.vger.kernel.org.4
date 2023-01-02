Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8375565B381
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjABOq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjABOqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:46:13 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2085.outbound.protection.outlook.com [40.92.103.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F925E5;
        Mon,  2 Jan 2023 06:46:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpDbr7oOHY9XskmTstbuKxNUea4sUVpgEyDm3cLjjRBeSUN+TN7Eub8EiFnxfd1BZqNltgc/jSPIZ7mNRTEyrZRwSv2874IUfmOAkUW6HY3VzKklneAzBYGJ3KZOFVSpB9ioYciAUl1VXA7lkbXkG/YuJvsKLn+Frlj1bAc6jKZFyssyxrAF2xpKB0c9crfVLlCALST3xZp3gESEy/PbH3mcH1ZLyFC+afvedbbYgU6DxJjWDCjkGbfOVdB46f+bNXtKuxe7BY/gsb7DJmeI+BYRMJC72dOADbwv7hp3BPPaVDt+BC0zGdvBmQKKHM6d+v0E/w2BSCn3e1Go3Wjz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2KTA13j1wx09IpGNKTNeH3QMXzvhmaWazlV0uUw21w=;
 b=jSdG6lrfR9qXYly6aF+3U2KnmmDFihX7SvjlmfJNf4Q8oZLPYGW/VvqP47TBZ7TRwuBDhhrRtsm6ugkupyFX8V46Cu5zpO1HLlNzkkUOjFE0+XACR1JUoPgo6F6a5klEtEaGFiIjCRcbUMLllsCkx00om8XdRrQdYSvG/5kTx+liWT168axUlDClhzAK+gvHzEqY/nE3Yft7TsGo5ty3xfKUC187XuEi99Rdo8X86wwOBJvSBTQx5j0S3/n9cYdDBRnmeQsLxtOVDyBZmiC+NaHs6RXHwu9jfFKfCSeV+b5Zmo/7W+FMovAfX9pZX2itH0UPKk5yOd/rGSoFEcGBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2KTA13j1wx09IpGNKTNeH3QMXzvhmaWazlV0uUw21w=;
 b=uMbKOU9jnjhGhhJ3vETODaB2xVl4VePuqK9XQAIu0UoOx1oLZ/Rs0hUByUFQrnLJinP9U8T8Mj2/pqLkU1GeI7MUD0C3Rfe9DBjxDUAwifxW7ELHUsfKetkcpYb8DZT2XcNwUYN6S/cW9keCssA2F5VijMX1ZXxorux35Z22et/NCOlSQuIpRLiMWDEVQbpFkFjZtITNlIMZQ4xGrlgqYhSzVIiBmNSufkuU8HVgeJnlMpqrY+kAhUabQsqd8qjJOZ7i2/+yMlnNXMwMyntCnyly0Kjvant4ZWcwp/yQtODj7xspgjjjHjuPT7Ze9vDsjD84RgWgWadse+ypbFGVyQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB9277.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:117::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 14:46:05 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 14:46:04 +0000
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
Subject: Re: [PATCH 2/2] brcmfmac: Add PCIe ID of BCM4355 chip found on T2
 Macs
Thread-Topic: [PATCH 2/2] brcmfmac: Add PCIe ID of BCM4355 chip found on T2
 Macs
Thread-Index: AQHZHrg8wozs5pKuJUyE/YYYsyymG66LNGIA
Date:   Mon, 2 Jan 2023 14:46:04 +0000
Message-ID: <3EDEFFF2-2C80-4832-9B05-A9C1027A49FE@live.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
 <B5647DBC-3D99-412F-BD04-071950D3CD48@live.com>
In-Reply-To: <B5647DBC-3D99-412F-BD04-071950D3CD48@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [rq/QoTcm59/1kYJaQq7QailcxTP+HAiuyBYiOAsApelpeRPeOVlCF4D9bNpWv7Ca]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB9277:EE_
x-ms-office365-filtering-correlation-id: 0c5eb8bc-2822-47eb-cf03-08daecd01342
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H0xzm2WVErkSqeKu6aHYlOfToGpNu+FRFlA0qQtTkGVY3/EM9pA+D90NSJ8WbmFooIwzKqpYgWph2tZjhQdLO7RfeiCieA7KQ7elobkeacz8OOLzWOZu3lH5PJGn2FupB9mtGnBfNtoaO9DGU3684vOexqZ4vIeukuT5cas8U35Qqbk1T2/6mbhrFDxD4O8oVjH7e95kdydQ7m2cmpxN4wJspIIFNoWdYbt7j3SKP5TwFzd/dpF/WNYi+EndP8izhw0fi9R0J3tuZNN4MzOLylO/b2w4ZJx8LnWSiGT26oq5qbye21Ip0nqSVX3zjQWUW5y786RbCfnPHpyF0cdVrxXvU6LVB9gpIuIleEJXovJpjBeLLG38D7XuOekySfXFJ5kxPpgsXd4bEst9mH2TVHXo/qJ+CQ2RZNOnpYGY7vMOffVTtxWYd/jhbozpz0QpC9DeQl/Pbaz6w4C7/VBfLw05XGBgy2MsbEs9QLslRwzujYWb3HtLJIePH3vlywJxL/KZKQl3LOkE6LF6cvbYdSoeVaJVmUXDlDPL4Tdi6KZCfPH5N9J9EN+3W+TGZqpU+EgrsVdbFp29VcqMbUQlZLXAKHwFhG1tr/wncwW5YLBWePhAT6/P8qyYksHSTu3VkphV0uIkTGZRAZA1KXuNrQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5y1E53wJseHbMvsIm8BBJVXB2Q8RfZ8sumgW99awRRVIyXR/hsyt5eC06yGw?=
 =?us-ascii?Q?EmXB+TAs8rEJuEKQYhcSSZv63uUlWIoOQMgKW+ncTodYjw5vzLOfjBtqe+XU?=
 =?us-ascii?Q?TYxiCRBXPb8dr2VuNmLvBZDRiP4TduXJzDj4uOa181xOtcoFCwTG2zeZfI0u?=
 =?us-ascii?Q?3qpLixzwnfUdEsSSyUwCYSW2P8mi5a+OaxN37m7ZzGe4Qt2Zb9VPLm1N7f4v?=
 =?us-ascii?Q?3L56J2UvqGcP0CGCqkkxKi1FMoC6C/b0T4MEsmkHLI5vlMasD4IbMp9GVPWD?=
 =?us-ascii?Q?HTeyMzIgtPsL68Cqzo+dwM4wc9y26X8u4atfeheyZWFT19ZuB4+ex9hSwAY2?=
 =?us-ascii?Q?IrDYBf3WkFFiF/BZ41UHjbRJNhhI7pMoUoJ82rKXzhd7l2r+QvVa/4JD6wsS?=
 =?us-ascii?Q?oUTg39xxiSdXz7ilJUtrJS35NADyhWCodHLQx+XAmYRqwjf2zOM6MOJ/qqNL?=
 =?us-ascii?Q?Qlh56r/vy98KXPuFVJgq+o4yy9UMvwvSCJWPkw7z7xk/I0ZOhF/6L0f4ld+f?=
 =?us-ascii?Q?M7sU9BEn1LjNo5FUcH8kN0T68rXEAJTLlMIFh5aavw7qcHZIRt1IBHbJZQP3?=
 =?us-ascii?Q?e/YSzIW0PXHwonlkk1ZsPBxYjEnMmj9eFphWascRKhvyNwbKTaOvzgED1Oy0?=
 =?us-ascii?Q?k3ZyDNjp+Xxor1krLbsLnnX9kL2p0xZTSn2LwqYKkG0IA9URgNQ7NLtBp1cE?=
 =?us-ascii?Q?RFrgnPbr/DwWV8BDxGrZxHNyXNtp6c0Uir63tdwdZu9HM4kkhm3THdhj2w2d?=
 =?us-ascii?Q?1i9Q/5IuymFPOB+morORhfYebdFG+5GYRNS9V88qx8rOED/FqOQxEcuu85me?=
 =?us-ascii?Q?s7UuDKu6BNMDg/zr6SfWU5PrDUtAC6JOeIN32Ampr8Z/jP1TrSnAlnRYmGRz?=
 =?us-ascii?Q?sd+2aQeT/lqnHOdymPOSmLgxKpv1DcpEXGsj71sLVVCGYq31AiyDn9NsfsqY?=
 =?us-ascii?Q?Yt0NzaVf0i5gzUuWQkuGQa6dB5rPZKy+3l95YLzCnvPocKRxCeRnzClVatnF?=
 =?us-ascii?Q?qrB3/5+Lc35ALxIErObx+14xlpS+kuvcV7yhZKSRd+5mKmqEkapeBCdOmIvR?=
 =?us-ascii?Q?2ZtRyQ+QmEod5/PbmngK8OSZzpBUaTul9VWLX7aukSCKt2GEn2hUg/newFeY?=
 =?us-ascii?Q?DScLj4hK2O25PFcnyxXzhlmg0H3fNDxsYg/hAZbrKl1b77uk03eDSTNpgg/5?=
 =?us-ascii?Q?BB74fpQJwv+4k3Gam+IBfslj9N3johSsnZ6ExW11hgTmS92MvpOSfaRmOobF?=
 =?us-ascii?Q?mYbcMDkIaiLPYkEcqOWaTsdE74qeGyfDja66sccPmZgzqNfdx5tlO0zmyk3L?=
 =?us-ascii?Q?Ox8+Ou9sDgSgHiRpPtYAjCJBPNCyUnmain1FUaGf9KxUbw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EF29D4BEF60CF47A19E0CBB2BB64445@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5eb8bc-2822-47eb-cf03-08daecd01342
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 14:46:04.6375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9277
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 02-Jan-2023, at 8:10 PM, Aditya Garg <gargaditya08@live.com> wrote:
>=20
> From: Aditya Garg <gargaditya08@live.com>
>=20
> Commit 'dce45ded7619' added the BCM4355 chip support. This chip is also
> found in MacBookAir8,1 and MacBookAir8,2. This patch adds necessary pcie
> IDs to add support for the same.
>=20
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 4 ++--
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 3 ++-
> drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 3 ++-
> 3 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> index 121893bba..2f338c5d9 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> @@ -735,7 +735,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_p=
riv *ci)
> return 0x170000;
> case BRCM_CC_4378_CHIP_ID:
> return 0x352000;
> - case CY_CC_89459_CHIP_ID:
> + case BRCM_CC_4355_CHIP_ID:
> return ((ci->pub.chiprev < 9) ? 0x180000 : 0x160000);
> default:
> brcmf_err("unknown chip: %s\n", ci->pub.name);
> @@ -1427,7 +1427,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
> reg =3D chip->ops->read32(chip->ctx, addr);
> return reg !=3D 0;
> case CY_CC_4373_CHIP_ID:
> - case CY_CC_89459_CHIP_ID:
> + case BRCM_CC_4355_CHIP_ID:
> /* explicitly check SR engine enable bit */
> addr =3D CORE_CC_REG(base, sr_control0);
> reg =3D chip->ops->read32(chip->ctx, addr);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index ad7a780cd..0a7410196 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -78,6 +78,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_f=
wnames[] =3D {
> BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0x000000FF, 4350C),
> BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
> BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
> + BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFFFFF, 4355)
Oops, forgot to add a comma here, sending a v2
> BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
> BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
> BRCMF_FW_ENTRY(BRCM_CC_43569_CHIP_ID, 0xFFFFFFFF, 43570),
> @@ -92,7 +93,6 @@ static const struct brcmf_firmware_mapping brcmf_pcie_f=
wnames[] =3D {
> BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
> BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
> BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
> - BRCMF_FW_ENTRY(CY_CC_89459_CHIP_ID, 0xFFFFFFFF, 4355),
> };
>=20
> static const struct brcmf_firmware_mapping brcmf_pcie_otp_fwnames[] =3D {
> @@ -2599,6 +2599,7 @@ static const struct pci_device_id brcmf_pcie_devid_=
table[] =3D {
> BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID, WCC),
> BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355, WCC),
> BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID, WCC),
> + BRCMF_PCIE_DEVICE(BRCM_PCIE_4355_DEVICE_ID, WCC),
> BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID, WCC),
> BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID, WCC),
> BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID, WCC),
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.=
h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index f4939cf62..fee1ff526 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -37,6 +37,7 @@
> #define BRCM_CC_4350_CHIP_ID 0x4350
> #define BRCM_CC_43525_CHIP_ID 43525
> #define BRCM_CC_4354_CHIP_ID 0x4354
> +#define BRCM_CC_4355_CHIP_ID 0x4355
> #define BRCM_CC_4356_CHIP_ID 0x4356
> #define BRCM_CC_43566_CHIP_ID 43566
> #define BRCM_CC_43567_CHIP_ID 43567
> @@ -56,7 +57,6 @@
> #define CY_CC_43012_CHIP_ID 43012
> #define CY_CC_43439_CHIP_ID 43439
> #define CY_CC_43752_CHIP_ID 43752
> -#define CY_CC_89459_CHIP_ID 0x4355
>=20
> /* USB Device IDs */
> #define BRCM_USB_43143_DEVICE_ID 0xbd1e
> @@ -72,6 +72,7 @@
> #define BRCM_PCIE_4350_DEVICE_ID 0x43a3
> #define BRCM_PCIE_4354_DEVICE_ID 0x43df
> #define BRCM_PCIE_4354_RAW_DEVICE_ID 0x4354
> +#define BRCM_PCIE_4355_DEVICE_ID 0x43dc
> #define BRCM_PCIE_4356_DEVICE_ID 0x43ec
> #define BRCM_PCIE_43567_DEVICE_ID 0x43d3
> #define BRCM_PCIE_43570_DEVICE_ID 0x43d9
> --=20
> 2.34.1
>=20

