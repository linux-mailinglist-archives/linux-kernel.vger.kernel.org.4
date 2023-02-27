Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6496A4B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjB0TpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjB0Tog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:44:36 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7228D3B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9xoPejsjZV9zmW+Z7L1PlVdBncgn4qQP+Sh4PEAfsgSQHaxgS53tFptkALwGwtYHWl/M2zygL5e2s08Qj+JQDMQ1/VnibJyNZ4JiCzB14JABsdf8Up2zmnmvzr16M/woQsoUh1mqjOfDezSQM6T18OmmpJsEV55i/36t/4kKga4J0FCPkzoPPFNhjd3LOhdURWv1jcpQzMVgUkNC77eJ298qCwfPlXtlI6TWrnPBymRTJEYe3/heUS+NEbeIX9lUG8HYo7NTueanm+h+VSEydd5L/Q79AwTMpBWOhvjUj2q1tYxcKrd+RtCv9jTWjyAJ3Ws4YnVYNT5/4RTLgl5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej16Rk2ZUbbnYKYwfJUCDy5R+qjxOyL+tbe1wLrMFGo=;
 b=gHjWnc2xrUXvLYXR9WHot/rildFXprHr94AUQylWfh8obl4zPKwfvmSikeLI9G705P2+AURUQQEa0hqknS3FzNGFsNMy/cRByQuazlzhVE4ubCz71acoqOazop7sGGVuMjHfFcujj8bmZWfrmHBO/ZTnDBxaEZ7/ZomfoeVPTneesdtPVwnZNac8tyqNo3lmhjAnWT2O3UmHXr+92KYH+VBpphH2rz96k1QHhAiTUGakVw8APAmhNm11nPZ9Cjs5vu8yeiqBbTCPr+4K/GEwOHXxvgupUZTX8MbvDelpm91I2t2hNBv50i0++tieXFZ+fApduAjfGQSZOjaIeTewMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej16Rk2ZUbbnYKYwfJUCDy5R+qjxOyL+tbe1wLrMFGo=;
 b=kYLiA7QES70eMN9bc5LqD/Md/ihk7snQKbrRBjfy8jH6zf17qM0RJpDklqwAiThayeryXhlu1qJ7kPGRx6V6xeEoJhWz8JG9/E1UQfNOFvr7rNxbFSkVsWXZzmRPAps5rfyD9we8pXNnMVecLY9hBTsyV5w1GIPBWqrXT8pIgmo=
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com (2603:10a6:208:15a::12)
 by PA4PR02MB6717.eurprd02.prod.outlook.com (2603:10a6:102:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 19:44:06 +0000
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e]) by AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e%5]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 19:44:06 +0000
From:   Paul Geurts <paul.geurts@prodrive-technologies.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] net: dsa: b53: Add support for Broadcom BCM53134 managed
 Ethernet switch
Thread-Topic: [PATCH 1/4] net: dsa: b53: Add support for Broadcom BCM53134
 managed Ethernet switch
Thread-Index: AQHZDjG+y/J83afRnkeyvdq3RV1I767jqs7A
Date:   Mon, 27 Feb 2023 19:44:06 +0000
Message-ID: <AM0PR02MB5524C3FE38B82C480E2EC968BDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
References: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
 <20221212135640.3590545-2-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20221212135640.3590545-2-paul.geurts@prodrive-technologies.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5524:EE_|PA4PR02MB6717:EE_
x-ms-office365-filtering-correlation-id: 58774e73-e0b8-4f03-287f-08db18fafc91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MO4X/X5MFXCOQ3XCX9l50i+APsVOH0OH3Riwr/OOs65mQbZD2pZ9u4GBpXUm2KWWazxghJLFsM9/Z4aqYfNlrmj9hjwGIDyj2hexhjXRT9I8NonCq2c7q+6pKbivRvbitwZ2Xb2xu8KxA+RXyCbS0iLj7rJdDijuw9gSJCVfk7Hsoum2bXFp8KnDOm5PrWHD1X8MPhlLUzIhlOhLo3DUGMXSWmFo2gnVXWUUFlTOSU4XIsbMlavYvM9bBSzI0qr/vDuDby9kK+IBe+hhKZMSI7qLg8vP+2GAswnk5yIspubUWin6XLuNVW7yFTN4ghmrneRUhBgO08CsjRejKAmLHKhXCsSKjTQ6+/n2lSs374ysWjlw60xc6qkUkrOlaFOt8chRv6qrp5hmh9K9aK9qTHIaBqXSPTnET0L/WB85Kp4MzdzJ201z0JouzWEzse46i+FSLL86+s9e8XDr9NaAfJc4xhtVK7kjXwKVCW7Ico5yA23Si2/0xy5x85vRnyOAEmwkdEkDSIX/Jy6zg53kl4u1eFZBEmYcYbOY11fcCouNw/MXa5DvEIXELNtgvBTyNQ6HG4HY+yBhzHwimPABKhh5z5U7dxdhI9R5uCbmgOWVDmpgHjGUz6c7Aqs4762bWL+yXIzVZrPiuMyjXXLhvCIijV9IQwP4A56TUO34pB/mzqxojlnUycnl/m0fY7Cp+XYv6cKM5DHsBDSykC01g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5524.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39850400004)(376002)(396003)(451199018)(71200400001)(9686003)(186003)(26005)(6506007)(478600001)(38070700005)(83380400001)(86362001)(33656002)(122000001)(38100700002)(55016003)(41300700001)(66946007)(66476007)(66556008)(6916009)(64756008)(76116006)(66446008)(8676002)(44832011)(2906002)(8936002)(52536014)(5660300002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mPb1mIe6XN99bGLKSWtuTQotmeE9ddG/M5hBk1L5SyEyE/7MkGbBtNhVs6QL?=
 =?us-ascii?Q?4lsZvSsVIvpfi3vkt59kC3gHINa30XQBOXgBWVhpllVlkhZd/7f94P59c1zO?=
 =?us-ascii?Q?2ptGcbzF8GMsHlr3U+Sbdz69eRVHaExrB3HqPGgRRZV4wMrjw3YDnYjdAko5?=
 =?us-ascii?Q?NiGjx7n2y3tbVpO0NPsnlhyo58tGSqWIqwEdCO5BvP+AyL8fbmXdFiy64T37?=
 =?us-ascii?Q?YZvhsuGkLYXaa00zEZIeyFdsFI16NlA00rWIcmFTulds1Vm7UP/3QhU9RoaN?=
 =?us-ascii?Q?/LotxXmDE0OjPVcsRXudA4UMQOiK/zGhLr+q2UwAN62wOT2jffcw+EP+CeM1?=
 =?us-ascii?Q?pQNOd1wv9lWdIbYCHkkal3plnb5nN7WMcyBqatN8UC2kIfLb5jWfb6oQDFM8?=
 =?us-ascii?Q?d1Jp23Zy0Odeus3zRW2dTm6aozlGmDL3liIEmr0Q1Jmr/DP/FlIKswoLt2nO?=
 =?us-ascii?Q?5efjEvCGXpgO/50m0UFuEFfYlR6Mu39ghA1y++1hCYFSdG60/y/aLxapgu6M?=
 =?us-ascii?Q?1nJybq9qGEk18vCRm7fRVl3JjUgSjRhmw8UC0CVzh5x5H0FmashVQS5Vlj2G?=
 =?us-ascii?Q?irmke2/2PprYSO8uGesCGPt/lPK9kKm0MSRoP5S3dipe/lNq0GeXqVgZ2DwP?=
 =?us-ascii?Q?I8GhrXmgGbYGUjkMfI5iunAMilDcb1wHh3o4HeL3dTkVgioexuHszskO1SGM?=
 =?us-ascii?Q?KWV9XM6/T0tuqYLaetBbBZqP0tDVPmvMFYArgwx5z4ZHbKjrEHRoKlVRGG2z?=
 =?us-ascii?Q?iwu3Ji0C6/jbI0tFr/AT8pGmud8DGGh6Y475a2VytW7kHB2Ow13nE6kBjcgA?=
 =?us-ascii?Q?zJTuOzijggP5hBfgA/WAeIVh2h70yAk9N4TktgOA/paF1YfkJXzW9LFoDKgW?=
 =?us-ascii?Q?DokRp/gp1FNAiEYm3E/4pJcRS2kajczj/OdQi9c9mn07Tqf54h6bU9NvnKSl?=
 =?us-ascii?Q?piU6cNGoas2W1nil2ESbWvo0lxXUPym2pbSW+RD65KtJ6D2AeYJDj+qYELSW?=
 =?us-ascii?Q?4JCrwWFihWxfk4vqFZn8Wtt1LYee+f+qCu4e2jEaaNbkSvczhRNBa03BrURc?=
 =?us-ascii?Q?uh7g+tpYYHxBzgeoG1gJr4VZBgr/Vs3rdBfgCWG+EN0WZo6JdmTXlHswNeuZ?=
 =?us-ascii?Q?l53ElRZGGch1LNU7W5vDY2TkYSqD2YnKlHW+n7Qkg5DFSxvWj92QxFgbJgtg?=
 =?us-ascii?Q?YheDFSM6lQgLsMCqmO0asT4tLZHZ/7yWHfxPz/aVK5sz2pyVFs0k14sQfqOd?=
 =?us-ascii?Q?NOT4SxhhU4wVMzTBp7RRc7WwvuxEiels2EUYyKjb+OrjnhpjmsQgz80SciUj?=
 =?us-ascii?Q?BkvWl24NogA2UU3DNNABxW1mXYDQAPRnMRszlal2PZQ92Q7BoNCRdqBLX5vv?=
 =?us-ascii?Q?5CSr3J8q8PQaFoBjqUDB6BIQEANentQ0dO/EYzLVAstk5WqGMAS67sM97F0D?=
 =?us-ascii?Q?4bR2EtvkJnhi8CpvF9iYCe6Fz3SJ6mFbjJ8DTsTJCYXwuFpVByyEbLH41V3/?=
 =?us-ascii?Q?mxlF+NXM1XUC5jtEh3qhWoTu2udK1zjx2Pp7qH0dp4VXcp56OmeuUYrcAnE3?=
 =?us-ascii?Q?FpnRz1dWeY2EznWzxGHKiZwtkRwjW+zJXkJ1/tbSYoirObrBPFUfQ9NRZhuK?=
 =?us-ascii?Q?LiPtDb5Sko45l9IZRz5WSfk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58774e73-e0b8-4f03-287f-08db18fafc91
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 19:44:06.0694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYucSb22JuHacjPYX+cBYtIflq7SMrhjRxnPfIUymgRQMLr0nHIoTV61G+jx6lRgYOfNb1M+pcNxh0daYMMYH6dVUMHjlbP2FKUfN9phY4niXNZCCgvZtmWKXiSMVNx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BCM53134 Ethernet switch in the existing b53 dsa driver=
. This Ethernet switch supports MDIO and SPI interfacing.
This implementation only implements the MDIO interface of this device.
The device also features an SPI interface, which is not implemente in this =
patch.

The BCM53134 is very familiar to the BCM58XX series. Therefore is85xx() is =
also applicable to this device.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 drivers/net/dsa/b53/b53_common.c | 19 ++++++++++++++++++-
 drivers/net/dsa/b53/b53_mdio.c   |  5 ++++-
 drivers/net/dsa/b53/b53_priv.h   | 12 ++++++++++--
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_com=
mon.c
index 59cdfc51ce06..6aa76cb4f992 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1266,7 +1266,9 @@ static void b53_adjust_link(struct dsa_switch *ds, in=
t port,
 			rgmii_ctrl |=3D RGMII_CTRL_DLL_TXC;
 		if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII)
 			rgmii_ctrl |=3D RGMII_CTRL_DLL_TXC | RGMII_CTRL_DLL_RXC;
-		rgmii_ctrl |=3D RGMII_CTRL_TIMING_SEL;
+		/* BCM53134 does not support this bit */
+		if (!is53134(dev))
+			rgmii_ctrl |=3D RGMII_CTRL_TIMING_SEL;
 		b53_write8(dev, B53_CTRL_PAGE, off, rgmii_ctrl);
=20
 		dev_info(ds->dev, "Configured port %d for %s\n", port, @@ -2550,6 +2552,=
20 @@ static const struct b53_chip_data b53_switch_chips[] =3D {
 		.jumbo_pm_reg =3D B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg =3D B53_JUMBO_MAX_SIZE,
 	},
+	{
+		.chip_id =3D BCM53134_DEVICE_ID,
+		.dev_name =3D "BCM53134",
+		.vlans =3D 4096,
+		.enabled_ports =3D 0x12F,
+		.imp_port =3D 8,
+		.cpu_port =3D B53_CPU_PORT,
+		.vta_regs =3D B53_VTA_REGS,
+		.arl_bins =3D 4,
+		.arl_buckets =3D 1024,
+		.duplex_reg =3D B53_DUPLEX_STAT_GE,
+		.jumbo_pm_reg =3D B53_JUMBO_PORT_MASK,
+		.jumbo_size_reg =3D B53_JUMBO_MAX_SIZE,
+	},
 };
=20
 static int b53_switch_init(struct b53_device *dev) @@ -2727,6 +2743,7 @@ i=
nt b53_switch_detect(struct b53_device *dev)
 		case BCM53012_DEVICE_ID:
 		case BCM53018_DEVICE_ID:
 		case BCM53019_DEVICE_ID:
+		case BCM53134_DEVICE_ID:
 			dev->chip_id =3D id32;
 			break;
 		default:
diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.=
c index 6ddc03b58b28..8b422b298cd5 100644
--- a/drivers/net/dsa/b53/b53_mdio.c
+++ b/drivers/net/dsa/b53/b53_mdio.c
@@ -286,6 +286,7 @@ static const struct b53_io_ops b53_mdio_ops =3D {
 #define B53_BRCM_OUI_2	0x03625c00
 #define B53_BRCM_OUI_3	0x00406000
 #define B53_BRCM_OUI_4	0x01410c00
+#define B53_BRCM_OUI_5	0xae025000
=20
 static int b53_mdio_probe(struct mdio_device *mdiodev)  { @@ -313,7 +314,8=
 @@ static int b53_mdio_probe(struct mdio_device *mdiodev)
 	if ((phy_id & 0xfffffc00) !=3D B53_BRCM_OUI_1 &&
 	    (phy_id & 0xfffffc00) !=3D B53_BRCM_OUI_2 &&
 	    (phy_id & 0xfffffc00) !=3D B53_BRCM_OUI_3 &&
-	    (phy_id & 0xfffffc00) !=3D B53_BRCM_OUI_4) {
+	    (phy_id & 0xfffffc00) !=3D B53_BRCM_OUI_4 &&
+	    (phy_id & 0xfffffc00) !=3D B53_BRCM_OUI_5) {
 		dev_err(&mdiodev->dev, "Unsupported device: 0x%08x\n", phy_id);
 		return -ENODEV;
 	}
@@ -375,6 +377,7 @@ static const struct of_device_id b53_of_match[] =3D {
 	{ .compatible =3D "brcm,bcm53115" },
 	{ .compatible =3D "brcm,bcm53125" },
 	{ .compatible =3D "brcm,bcm53128" },
+	{ .compatible =3D "brcm,bcm53134" },
 	{ .compatible =3D "brcm,bcm5365" },
 	{ .compatible =3D "brcm,bcm5389" },
 	{ .compatible =3D "brcm,bcm5395" },
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.=
h index 795cbffd5c2b..0388193709a5 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -79,6 +79,7 @@ enum {
 	BCM583XX_DEVICE_ID =3D 0x58300,
 	BCM7445_DEVICE_ID =3D 0x7445,
 	BCM7278_DEVICE_ID =3D 0x7278,
+	BCM53134_DEVICE_ID =3D 0x5075,
 };
=20
 struct b53_pcs {
@@ -186,7 +187,13 @@ static inline int is531x5(struct b53_device *dev)  {
 	return dev->chip_id =3D=3D BCM53115_DEVICE_ID ||
 		dev->chip_id =3D=3D BCM53125_DEVICE_ID ||
-		dev->chip_id =3D=3D BCM53128_DEVICE_ID;
+		dev->chip_id =3D=3D BCM53128_DEVICE_ID ||
+		dev->chip_id =3D=3D BCM53134_DEVICE_ID;
+}
+
+static inline int is53134(struct b53_device *dev) {
+	return dev->chip_id =3D=3D BCM53134_DEVICE_ID;
 }
=20
 static inline int is63xx(struct b53_device *dev) @@ -208,7 +215,8 @@ stati=
c inline int is58xx(struct b53_device *dev)
 	return dev->chip_id =3D=3D BCM58XX_DEVICE_ID ||
 		dev->chip_id =3D=3D BCM583XX_DEVICE_ID ||
 		dev->chip_id =3D=3D BCM7445_DEVICE_ID ||
-		dev->chip_id =3D=3D BCM7278_DEVICE_ID;
+		dev->chip_id =3D=3D BCM7278_DEVICE_ID ||
+		dev->chip_id =3D=3D BCM53134_DEVICE_ID;
 }
=20
 #define B53_CPU_PORT_25	5
--
2.30.2

