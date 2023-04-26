Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F4E6EEC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbjDZCee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDZCec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:34:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2081.outbound.protection.outlook.com [40.107.113.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5BB9000;
        Tue, 25 Apr 2023 19:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIlS2WY6uJq28HqHB60ZRM18uMIwY9sSD2CaZLx/6GwZLyMFTnHJVqFP5quFteryhjdPjIlJDoRcDP24qJpBO4w7Ozkq6LgqlnQX0XhFXihfDNFM2S4aTIFNOfa6eCtIgEEeqL8AsNdyMiCz19heccSGkzafMTVyUTgQ/U8d6FKS3ur7C15+DsmbrOl2ny6LPSYK27SsiRBFHGRKVQTkxFwXsN23kA3kvby8blTIDhbEz54ca4b3dGj2HaKhQOs3pAPTh+NuDdLY2vkRx12ElYzuN/ALkcRMEp8BkLynby4PtBXj4pLuFGSFO32ofYDZnyQlrBNb+nQkLJyovhDrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc1bbATl+zs2Byeb4Fxk+Zgr1hjEHFK4mLHP2ucJ42k=;
 b=OT+7qljqgOEVA5bih2rmCF5iExxiFFqDgRVDw5ZAh7Gdu4a4FXlJNphhe+EyI4fBNy6OUJ0D5gaBcOoWyNGJrU22EfaG9jpSMoRMNVvOgJ20FHPHCcTFErRmgYncc2YOnQlGy2s7N8RrPFyl9TW7wlpjZk2j29GWouB96ljhn2zHV0uWljUGlbDb8QF1mD1pZ+oxzA8aZxFTDE2pfTvbmFelh8SiLcmFCO7kgcJJ/PWZNbz5OoK1RoigfJzmEpMH/iXDf5FMIxgBepwPNBSbnjYpC6R7Bu7ljoHHQFPm59NjSVZVRv+U5lj1ArCmo4bDFxrmswwKSR36NS8EKdyHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc1bbATl+zs2Byeb4Fxk+Zgr1hjEHFK4mLHP2ucJ42k=;
 b=HsR+W7MmFH2ux4qaBST8G1rTguytISeMQ98Qkz8mEZHtaeiONUQv09W+SW2rQk8P8/aJ7NXlzUCY2H8zEPNBEJWAuu33aRkqrzW1B1qVbMrDWLyFippsLBCi+RkKZnsoIVRl/RY5TtgiWHbwd/QxsCUHBPNUspfY6UhSsCKn/Oc=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by TYWPR01MB11166.jpnprd01.prod.outlook.com (2603:1096:400:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 02:34:26 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 02:34:26 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Dhruva Gole <d-gole@ti.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        Mark Brown <broonie@kernel.org>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: RE: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Topic: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Index: AQHZMJVBHgHXafuso0ywMCCxmHrW5689ZDXg
Date:   Wed, 26 Apr 2023 02:34:26 +0000
Message-ID: <OSZPR01MB70048CE259A3D63C4179199A8B659@OSZPR01MB7004.jpnprd01.prod.outlook.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
 <20230125081023.1573712-5-d-gole@ti.com>
In-Reply-To: <20230125081023.1573712-5-d-gole@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7004:EE_|TYWPR01MB11166:EE_
x-ms-office365-filtering-correlation-id: 9c0a31ce-bd8a-4db6-465d-08db45fec10d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Acm5yRKa9FRmOPD58k0QZR0A+lUAgPN7AtGC/3sK66CjmibsPjvEFnrCbWtQNEoFjm94MXc1FICkeWHrg4mOuNXWliZGXu0LOKwGP2dhbIjW//jCTPyJmnHwINWjPINgXa9dhXjjSn3XaTKfzssqBK60ZsF+kVURqqPoQ1K3IxWPH+Is/tt9GABWwn90g7ObMd+CWk0tkY9GNhvNBWKEs+9Q3lN8PJazf3DE1ppWSwVFjSyslofr7v7vIDFUKj/8oxxWAf0EqggEXhE5uddmsa2vMq6Cs/i7ieUPi4iHCXkB5z7JKE+plz6m/TtP0PstghYg1ZFisl2GMcKchEPDzknOaNfDUAGFY/7NG7pfuwg6psIqnOqaDYsdcWWV0qJCA7Fh2zhOpTf3saP526TvEwJw6fqkODyCZKvfk2hB6KnfRSl8SGGBm7h5EGE6hudAmscqeNXriB+9jpOgMPXRh5MPQwIIsVLYcTXgWwBbzx5cfBRcPIn7WaDdz+mKmqLU6Dv2cWzIcql9Su/g8RPeExC8Xy3s3KIjae7pX63aUbZtaQveMl+jdQcg5M79B08UoX2UrojObZ5zUyeksoFsUF6amqe8NLf6QDGrNVfS8DM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39850400004)(396003)(366004)(376002)(136003)(451199021)(33656002)(86362001)(55016003)(54906003)(478600001)(7696005)(71200400001)(966005)(8936002)(38100700002)(8676002)(41300700001)(122000001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(83380400001)(186003)(107886003)(53546011)(26005)(9686003)(6506007)(2906002)(38070700005)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OiVFe7ds6b2DPe0t8rLqCpyZpqarP76RT376U2wR2BlEESHpH/PK2DPP4MUr?=
 =?us-ascii?Q?IaalnfEYxcgSX1JjG/PPwgU6xswesVVVd2CfOsV/QSdEmhe8icL9sa8OZs7Z?=
 =?us-ascii?Q?VcdkMYd8mPdER0RT7bA0hXyxxWQXNWQCvw1+s+u8IMPSHxyo+bWqkqdM1+c7?=
 =?us-ascii?Q?bFph0xzxn05XJ6ML7OOuB80bjAIha/wERhmueq4JPCByh8ms5JYYowcIBHHu?=
 =?us-ascii?Q?fAwooyoRu+LVsQn1YK9EoprOQEOyDQZDGvbZxA4m42P6evjzND1ddSH8YJ3m?=
 =?us-ascii?Q?Or6KolyHhwAKJTj/H1Hj2vYNw5VVpXQpDfM9Wyy3cVkcnCBF1k8DeZOgt1Qd?=
 =?us-ascii?Q?mx2N1WP4240gToSfTp1JWADw3XfygeyJFS0UTWZ46g5SG+uRVAXk8kputU0b?=
 =?us-ascii?Q?j2PgyGgpk8QXDmeKke5pdPCGt1GLwcBQmviv34VkTK/Pu6o9J2Ke/3G9GZDE?=
 =?us-ascii?Q?ssNHMzcJDQjF0nPTNlEc6KT1IT3yKLtGxWxx49hXmzpa9fynCg33BxFuGdtX?=
 =?us-ascii?Q?i4W9oI2cTYz6xFpBDwqMCHZCvpCeiVvTXy0S523/tEOsJLhNmzi7DaqamoTP?=
 =?us-ascii?Q?ME2OoTWilHd7gwlT0lIWHqtmzYEljKNIl+wpsitC3M5xHcn5RSxw3kmDbwM0?=
 =?us-ascii?Q?FtAWb9ZCvT950cWdzbpFrgtVeg1+ID5nZy2MbFPf20dnpVxLGN/AuLb+bvFT?=
 =?us-ascii?Q?hzQ8zzt6TT0G1yPV+6u8kdWAMRe18tV9NHnuWctO9VFytx5l4rnb8Izj+j4S?=
 =?us-ascii?Q?pHczC/cg570e7eC+6DYMKyYCATMUD52MnID+WE87cmHq6Rbvn9aLO0s9fyVx?=
 =?us-ascii?Q?9qf2Kl+i+n5t2CRl5Z1ZBR74RdgE3RwFvdqIN2PcKchnxTFAx8/Ow1uIHk2N?=
 =?us-ascii?Q?wj1Itwd96t1s5YcGBRXgbQSFz/aFO6/vC/miUQLkFR9iIhvUiAEMGgkbq8BY?=
 =?us-ascii?Q?ACNwhxvUICE0Zwjuj9DVQaj1v8ttrxX6JyuLqyYyN5g9B2fwu5nMfaeJk+u2?=
 =?us-ascii?Q?TTiQSjmJaXLJvq6u8HleochOEAglSQrVgxPwNkBQbdHKIJ4WaalCmnyIhTn+?=
 =?us-ascii?Q?2voXzmMrU3QhUmXqgQbhi+d64MJyKC+Com1bzmd4ZPmtyJ80MmidUPOL4jVA?=
 =?us-ascii?Q?74dpw3Fpy4x+SV4GAXKwcesCHpI+BLG5kuGKBL6YaDCRsEFsRTLbREuxupIY?=
 =?us-ascii?Q?AwCj9iQvVyFrnTIxKLP806G5z9BBvdHwkqTNlWtH+oSZBPS4mGjLWKxeN+ZT?=
 =?us-ascii?Q?5ochslOagfG2m48DBTThGo3Dlgg5eqnlYhN/plrBD5iQOdOEgSDRAqetjJ8Z?=
 =?us-ascii?Q?bocsQwASma1/motDugaiQQBBJb5p/7kD9H/dit5C4vIYkjN8uNWxUDcjngJG?=
 =?us-ascii?Q?vt2yYPAzQvcr8BkoVE0FskGQvIm5F3LHD/JR985rjyCUMu6nLm9UROXvXS79?=
 =?us-ascii?Q?c4DeHoe85Zu6q2AIYW8MgX3WPqypxHGkXuK9fGDQLxKiW1whuT3x/jluepir?=
 =?us-ascii?Q?jihn9LXZEvOY2YIRHNF0bKbM/aGrvky+UT7a7bENX+0P4PtP3f3bP4S4JPgH?=
 =?us-ascii?Q?fBWOl/eh+ijwoNtCkFhASTWIWrluspjty7wM0tI2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0a31ce-bd8a-4db6-465d-08db45fec10d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 02:34:26.5944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdcQOwxGE0CDT/FIw4EUoqpnnGjYsv6F6ek1yZ/sVJexntwBF0PNfsj20tM+K3yzRXrphhCGO3bWxGvpf1m9Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11166
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhruva,

An error occurred in the following environments where this patch was applie=
d, and the flash could not be accessed.
However, after reverting to this patch, it is possible to access it.

- Environment
  - OS : Linux 6.3
  - SoC : Cyclone V
  - Flash : MT25QL512A

- Error at startup
  - Kernel log
[ 0.980290] spi-nor spi0.0: found mt25ql512a, expected n25q512a
[ 1.485140] cadence-qspi ff705000.flash: Flash command execution timed out.
[ 1.490792] spi-nor spi0.0: operation failed with -110
[ 1.494654] spi-nor spi0.0: mt25ql512a (65536 Kbytes)

- Error at access
  - Access command and log
# hexdump -Cv /dev/mtdblock0
hexdump: /dev/mtdblock0: Input/output error

  - Kernel log
[ 2124.201193] cadence-qspi ff705000.flash: QSPI is still busy after 500ms =
timeout.
[ 2124.201229] spi-nor spi0.0: operation failed with -110
[ 2124.201256] I/O error, dev mtdblock0, sector 0 op 0x0:(READ) flags 0x807=
00 phys_seg 4 prio class 2
[ 2124.711241] cadence-qspi ff705000.flash: QSPI is still busy after 500ms =
timeout.
[ 2124.711276] spi-nor spi0.0: operation failed with -110
[ 2124.711302] I/O error, dev mtdblock0, sector 8 op 0x0:(READ) flags 0x807=
00 phys_seg 3 prio class 2
[ 2125.221193] cadence-qspi ff705000.flash: QSPI is still busy after 500ms =
timeout.
[ 2125.221230] spi-nor spi0.0: operation failed with -110
[ 2125.221256] I/O error, dev mtdblock0, sector 16 op 0x0:(READ) flags 0x80=
700 phys_seg 2 prio class 2
[ 2125.731237] cadence-qspi ff705000.flash:. QSPI is still busy after 500ms=
 timeout.
[ 2125.731270] spi-nor spi0.0: operation failed with -110
[ 2125.731296] I/O error, dev mtdblock0, sector 24 op 0x0:(READ) flags 0x80=
700 phys_seg 1 prio class 2
[ 2126.241190] cadence-qspi ff705000.flash:. QSPI is still busy after 500ms=
 timeout.
[ 2126.241224] spi-nor spi0.0: operation failed with -110
[ 2126.241251] I/O error, dev mtdblock0, sector 0 op 0x0:(READ) flags 0x0 p=
hys_seg 1 prio class 2
[ 2126.241274] Buffer I/O error on dev mtdblock0, logical block 0, async pa=
ge read


regards,
Yoshitaka Ikeda


-----Original Message-----
From: Dhruva Gole <d-gole@ti.com>=20
Sent: Wednesday, January 25, 2023 5:10 PM
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; Vignesh Raghav=
endra <vigneshr@ti.com>; Vaishnav Achath <vaishnav.a@ti.com>; Dhruva Gole <=
d-gole@ti.com>; linux-mtd@lists.infradead.org; linux-arm-kernel@lists.infra=
dead.org; Takahiro.Kuwano@infineon.com; Pratyush Yadav <ptyadav@amazon.de>
Subject: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small reads

Fix the issue where some flash chips like cypress S25HS256T return the valu=
e of the same register over and over in DAC mode.

For example in the TI K3-AM62x Processors refer [0] Technical Reference Man=
ual there is a layer of digital logic in front of the QSPI/OSPI Drive when =
used in DAC mode. This is part of the Flash Subsystem (FSS) which provides =
access to external Flash devices.

The FSS0_0_SYSCONFIG Register (Offset =3D 4h) has a BIT Field for OSPI_32B_=
DISABLE_MODE which has a Reset value =3D 0. This means, OSPI 32bit mode ena=
bled by default.

Thus, by default controller operates in 32 bit mode causing it to always al=
ign all data to 4 bytes from a 4byte aligned address. In some flash chips l=
ike cypress for example if we try to read some regs in DAC mode then it kee=
ps sending the value of the first register that was requested and inorder t=
o read the next reg, we have to stop and re-initiate a new transaction.

This causes wrong register values to be read than what is desired when regi=
sters are read in DAC mode. Hence if the data.nbytes is very less then pref=
er STIG mode for such small reads.

[0] https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index a6d0f1b0bb49..2954c06a7f57 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1359,7 +1359,13 @@ static int cqspi_mem_process(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 	cqspi_configure(f_pdata, mem->spi->max_speed_hz);

 	if (op->data.dir =3D=3D SPI_MEM_DATA_IN && op->data.buf.in) {
-		if (!op->addr.nbytes)
+	/*
+	 * Performing reads in DAC mode forces to read minimum 4 bytes
+	 * which is unsupported on some flash devices during register
+	 * reads, prefer STIG mode for such small reads.
+	 */
+		if (!op->addr.nbytes ||
+		    op->data.nbytes <=3D CQSPI_STIG_DATA_LEN_MAX)
 			return cqspi_command_read(f_pdata, op);

 		return cqspi_read(f_pdata, op);
--
2.25.1

