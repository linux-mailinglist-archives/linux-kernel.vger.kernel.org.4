Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D87369AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjFTKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFTKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:44:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2051.outbound.protection.outlook.com [40.92.99.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CDE42;
        Tue, 20 Jun 2023 03:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml14MtGrjWnOLiLstIeiqGLAvxPMEfCC/nCbKzI3gzNfooNWwsawHD3OCs6oBnC4uvU/dTC1kielLbsNGJVSqaKQ9Gvpi+HwzBoz3yJY2R4wrSKt5wXxfXQ4pEmMkGhaH2JA1zNJOYbo4m50OucnUFohF3l7mKQfkb/1Z2N3/RSdPu/MMgfG6NfzJ+757Tx11Wb7xapdq/pVVdbT77brKzH67xrvZsUxxyftisZTznAOgSxQaH6nLwPPL2ug511by8zbi9T0NVN74yEg5RPmQlIBBFRX7/5iSUQE7XJ2IcTdzZ6uJEL0IJ5fj5zwzkG5v4B4JGuFeJkl97JWrr5hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X+kg+AgOfUBuS2OBbJ/rYQUt9Gb8ePdeQMUcUwcewk=;
 b=BYt1BwpEv7T3Gh3ba9JVCC+f2tPMwu/DXsn9BsiuIdRPSzavFiDDUQulQ6HdPnTgVQnpgFzUhicWSitETd3Gf1ZdJFunLfU81cjcLhgNEZE0CDKdM6A5NRuIAcvJck317vKCdAS+KMeS6LDT4WOv39GNBQW69t4EWgZd785+3ljj3Qynu2Nyibgc5TUd7c3eUuvpv3lrqvy/SFQphK1+642X5pCSiTdwhaZGGdX4NHHzyZ0j5qK1kNSXMHmk0Rb0SbPo4V9+14LDVv0BV5L2br1GtGZEXNmeEirIFpYpkPhXSxw+XHCZvbtf/uCR9vSn3oUq0SFvhKBelV12O8DrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X+kg+AgOfUBuS2OBbJ/rYQUt9Gb8ePdeQMUcUwcewk=;
 b=SDfgIvORk0MKGArLtsF4mTzOvvaCvkRAVyAljWSmaiI7iJCA83dy4sJDToUcQjhPG2vCMhjjRWr1cnvRcXLTvbdG85dJGuaT7xf5IYrK1X9EgD+tIKf3erVmTd0IKuPvGIO2UbD2Badr11JE9gv0rLN7bhN1TRSNlcbnIWW5Yyk48H850ffJUJcCPr4ufa23vprnVgaksF3a/eloGEREPkbss9XvTk/IIa+tO7Ei0GtCKJPMZswmMt/hx4y/NkasPFcaJ91/AKu/x4/EbBclocK7g/7mslL98Wqnzk7e8dOePbdCHVgb3ZbpycUotV/uPyYk80HUQfhVgVsV0CgwcA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1546.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 10:44:06 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 10:44:06 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 1/2] mips: pci-mt7620: do not print NFTS register value as error log
Date:   Tue, 20 Jun 2023 18:43:22 +0800
Message-ID: <TYAP286MB031506B0D172B4EB943E4C18BC5CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230620104323.1736-1-yangshiji66@outlook.com>
References: <20230620104323.1736-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [LDe8uqoVX3fEtYvsMupMhNIvx5Yxr9wd]
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230620104323.1736-2-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1546:EE_
X-MS-Office365-Filtering-Correlation-Id: 0289eeed-250a-40cd-8985-08db717b44f8
X-MS-Exchange-SLBlob-MailProps: 02NmSoc12DcenbC5w/UaZkbuHE2qqzIUWZk6EQ8qKIMhKITUW12DuVKppOMqtnzjj7B/gAsUIbRmMCn65TUnZeZWt13q3v0kSifaR0kdNHbtAWdNd+uyHRRNeOdndsbU87fujVdQrxDp5m814UnD7lqsDrb20kNiLrRvjaJwqhyoMEFRNaP5RkMaclL+RHaWyUbLrgvDBxuKQHWn0vQBX75gdYOUpU4N5HJulbPaGozt/eBX0WFtqE2OWGyBfPHBM8ADy4dRo/N85Brzv0T8on+edKAAJKq/TLSiE3FG7FpfmOgVgb/26l8u6Yo5TOu8uMS4I8pgT1uDp6AfcB3dL3CGZ2wb1KHDtkFaRR7vbH2bDrReuFeReNF3NbXAebwpmW28HW8NIh8+J4dKFWDHS9yUcVOMADUJDvdD3ZXmO81MgD4M293kbj6PaPVbATkeBqLrXhlwhSiQiPKsRgkwXYZtxplUt/YNXm7pavbhjLNqfyMg3YNiTB8yFhbCcxnjN+/+CmfvAfrTEK01v4lfQIwEz1/PS9HYEc6p3s7CkWJw015FJNQh0ydYzcLT5KSPCtIxoQ3W5AMhL9vA/y9rHlFKwav/Cp4p0DFl1nktdOXUSIG2SkBvbqeAxU7wB4eWGdMnILwUfHEURNGFK/qwX8lzAiCiZEuan77n3l03hOxxtZu/pXvvcNInOVLHjTT9Pp+IwZt1I48F6Z86QmmMlRpjy8B3rS1G4HRkedH6Lvf7a6sQ0IZ35CK3hcHLRoXI
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQd+cI/EqUf5qbAifMG5PUDfu8S3YmTi9Khp7xWf4AzWZfboXmqPwy+1fhpuA3WwcHzr2PJ0oPXRZrBn+GyuPR6jhmdx/k+rCY8pvcbNRj6ocgvC03SOr4pgCJOoi0mC1jJpBrdM6m5nKMvy+g3xSxU0LwUHTwrqGTYV3EbeMQwGzolc7xW3VpUP1BW/nO/sOe58VMAPMRMK0PnGFXTrq/1/FVnl3Y71pnEC5sMHNfVJ+Jy5GH6aLgNRhRcSrhRoP15TU+yVzu48xSRc5dwyq4gK7Nj9AZTYdQk/XjH0fZ9YU1byX9xcTH/Ls8viHMbPcgB0TY4e8eZqbAzAJVnPMjBtgdmuer8Fpct1Tn6jRfQmlaxSlGSpozrKIUGlrbYHVrA9EYzyM7v4wSN6/OquyCyb7vNNCTTqfIqQX9PH9itOJXqTumjKBlpNNPX1FoV3Jb7pQV325H5WTDjbU05uXBOFRSoz8vAgUo9eXe2gtIq7sWkgfWf8fQY2VgC3ZEb94xQNEVJ+J088eLkX8Ed2wEgg41f1UOlUtrpRZ/57e1onYLPG3n+qytN362zNXTuvlGwfw9spX14/ihlFQgPH8nICIjHVbNKlduN8YP0/OIzTfAJRjMNUGfJAPqwhQ3NK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iT2uXbHv9f95mrjD2q/HE81UXqppw03gNONUi/+OQEnjO/A5n85ZH1o0czu7?=
 =?us-ascii?Q?/ombYnHlf6jqjaGPsy46uwhzPNk3HK4FZsBXRL3qABJe2Z0ftgnNrHejc7+t?=
 =?us-ascii?Q?0eVtij6UzClI5zAVv/rNCUbuZ7N3WBgv/AkHdmmqnjvLKq3lqZ0numgkKRmN?=
 =?us-ascii?Q?Q4cxzF6Oy+u+Qy9TEVrKVFVlar/wVuY/iX5BjqgxLC+0mRE3AEZ6QvzeKM/P?=
 =?us-ascii?Q?+Vda3l7BotCt1yDglZ2DKbGOs0e2ZNTWowBcpIWDUsJFmunBE4agWRhPHl/7?=
 =?us-ascii?Q?p1D9dPAwd2kaOEiwT9t57Gw7cpWgowWEL12XpY28Kx4NVjtz6gdo03OiCkwf?=
 =?us-ascii?Q?P/XEYhB0xoGG6fQZxv3I55YwAyh/AE3cj4bz9QmlSRS8iT4Y6RucEDLrjH4B?=
 =?us-ascii?Q?oPKEfgH15tRdBt6SAbtYxPIXypW3oLEImpTvTBeg3x9YZ8AbKN8LkHiXAMMh?=
 =?us-ascii?Q?XqQtFaIzuv5LF1FKo8Mfpd20mX3pncVsZUTQclChDjRi0YR7smdbpcu/P5/A?=
 =?us-ascii?Q?2Y77E1ZGKpm0ykf8ZWkNGTk3BCzJg0429oLB28hKNtvMZpfObQawpkd1AQr/?=
 =?us-ascii?Q?l+6UVTT1arj1t21qODGoHNAdO6IGoE8CJrcpoZuVwbUTOQ4ITFKrFs05Zze7?=
 =?us-ascii?Q?GBaDvZCzTjEtAiE4Wi5QgQY73J6L1ddnd9QRRGA7wSevt2gT8bvoO+3vd2nu?=
 =?us-ascii?Q?Cc5zpG+iJhJu4dzdb4B0QkWX4OavW8AUmMIuG30atMVhaGsfkf6XCT9eRgQX?=
 =?us-ascii?Q?lHuvTatLsEz1ueXgIJ/crJbUJyEZ6qUD6ztQSeAdDbRLn6hW0dOwXfcTgs8U?=
 =?us-ascii?Q?coEPEDIcmTb0wUXVW8WhIgLB5TcXjmzDr/APQqXEzEDc/6CFpz6j4IjSgHgj?=
 =?us-ascii?Q?LhhBPD+FK08vy1R0SAO2hxFJnDCHBSBWTmM/ws07jD1Rov8pT7lZJ/zK8TSq?=
 =?us-ascii?Q?YJInJNfzUArcM1wm2vKw/5nORT+tCGM5UkaQzVdXi3RTeJJMimlql/1E2uFL?=
 =?us-ascii?Q?2J/9dSz4Vu+aCyENI1zl6PgzDX57i7AvIer82uMxthPLM7UatALrRorRLqnv?=
 =?us-ascii?Q?lFIz0OrrAhPLqp52LjpPbad9SiS3XIN4drN0nwNlzeofyhAXU2key88c/l2b?=
 =?us-ascii?Q?5xVoTdZDHcCb2gqQlyeOe8J5bCpKDPuUW6hvlHwJHBdyzpODiWOmvA0bgIEk?=
 =?us-ascii?Q?iB/baV5yUaZ64J1v48CxqUyl4eMvteiU/1PKZ9BOLTK/AbWZa1eNBbLjbs8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0289eeed-250a-40cd-8985-08db717b44f8
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:44:06.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These codes are used to read NFTS_TIMEOUT_DELAY register value and
write it into kernel log after writing the register. they are only
used for debugging during driver development, so there is no need
to keep them now.

Tested on MT7628AN router Motorola MWR03.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/pci/pci-mt7620.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index 2700d75d4..df3347643 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -274,9 +274,6 @@ static int mt7628_pci_hw_init(struct platform_device *pdev)
 	val |= 0x50 << 8;
 	pci_config_write(NULL, 0, 0x70c, 4, val);
 
-	pci_config_read(NULL, 0, 0x70c, 4, &val);
-	dev_err(&pdev->dev, "Port 0 N_FTS = %x\n", (unsigned int) val);
-
 	return 0;
 }
 
-- 
2.30.2

