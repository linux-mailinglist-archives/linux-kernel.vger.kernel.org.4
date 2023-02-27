Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1376A4B73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjB0TqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjB0Tp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:45:59 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B78B25E14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:45:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ61R+DJtINCB/ojSRjVSUCTDHLqpk7fxw7Tl8WoS5JQ0HZ0DX5m/uR+3l9uMSAbMCEfVAfWheAiTmO4x8hPawimi3pNrfopYevFBBpaNm4K+WXy2DGvuIx1POeOihzgQXxqoRalJ54fUvyxc7RgLlwBLJAbZS4BRuYnlTSjSxXWLQtU3nMaRmn6wK3m35SmMXFR7kQXCjRKcxrgOXh3EsSoeslLB6ay5zwrfxT/0z5yjCS4XDpuspWy4RfQUjPjhNCt51Oypc2A7UYD6f7uNN1QU56FXQyFpMLY18Y9JV7NbOXAPRs1DayrXRgCOyzf9SxvI8q9C/D7PrDkex+iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOYksg8G9UBofC0LYE1tilWGyIs0osZU9zZMgAvWOMg=;
 b=jiCApp0ZCccDQuUB1Y8CrczyMmzwKodoz0GxQr98p4hp8lTYF8QdfhJyIvotkEu7/3OW3w0CM/Mr/7sfPxNvbNlRhjrrBdhxWpYNAY/PP8Sqt6sl/xdCe/GpF2HE36l8nmdQNvePbtzlhUW/fFdlYg0BboGMG9Xxpn/wVg5fN1arxl6bT56+f8IAYWFWMdyRVDmDn1IAdhrAs9+UZKpMtJ2Nb3R4UqB4GbxOSsJDujjFyJfwzyUvRXpe4TSSUQbyTC8quzzl/VHx5sdfvuDeR1Tim4fnZdBhOgjAkuZ+EtABYpWhyAx1bPL1eTRbjv08xvu5PTxKJz6Bf4fwtWxggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOYksg8G9UBofC0LYE1tilWGyIs0osZU9zZMgAvWOMg=;
 b=QjVEDmfC2BIwryVvg509bKQF7e2gPUGvHOO4gSAM7JgUN3mgWikTqpy8yFKUDYDcz2QADB5QTULAD+OdVamV9pPGZjazDWtjJh/6WUvGJdedv6CewVNSPPdm31BWTOD6I9qtcMawmu4XJakXxkDmS6MjzZPpzI1YedjAA4uIMgU=
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com (2603:10a6:208:15a::12)
 by PA4PR02MB6717.eurprd02.prod.outlook.com (2603:10a6:102:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 19:44:09 +0000
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e]) by AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e%5]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 19:44:09 +0000
From:   Paul Geurts <paul.geurts@prodrive-technologies.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] net: dsa: b53: mdio: Add optional reset gpio
Thread-Topic: [PATCH 4/4] net: dsa: b53: mdio: Add optional reset gpio
Thread-Index: AQHZDjG/116kGLNgfUeKCLc5uHksgq7jqygQ
Date:   Mon, 27 Feb 2023 19:44:09 +0000
Message-ID: <AM0PR02MB5524BDEBE80C82BC689C3DD6BDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
References: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
 <20221212135640.3590545-5-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20221212135640.3590545-5-paul.geurts@prodrive-technologies.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5524:EE_|PA4PR02MB6717:EE_
x-ms-office365-filtering-correlation-id: 1076bffe-aa8c-458c-c902-08db18fafec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HvmkXP2LdXUKWGlk6zox5z+ouPdcBxErbjP+vR+YsWHrVqER0kLeMmxwK6jT30bAgWnUyKeZbdxIrXd1UOSEHNp6c8D2rODqBqbvKY8MPtJEBfPsxXmEwgaecFotOVXLRDW7Uh+kmXz94w68fJrrUIr9axvpXZEnnrOTW5M9wH6FRpn/l6IglB28PV0OGxHTzDH+K7drRvJJdJdxyzXtUBL9RSwCN4yeE5PnkUFACdN/v4T7NaKdzk0fXqhq3DJxOw1Jmm6SVWVqzW6Pdo11vTOGdTC2VZte53yDKtvt6uNbgKmmWxRxk73mC3x9NWKCIdUz1pAb7ct4rbAC0/VI7y/yQKcxVQSctFEaRQgt0uHWA/WBAvbZTqrHChojw1DeYARodb/ssGGe7ftQliYOEDuxe/1oFH9oASwj1e1A0x6SV5uVaDN42eHgGnxkAbnZbMn9XqDYepWg98/0dyvFVH8BidxuBDfUFsfPmcg2hTlH5vfdavq+ikkydKWZrrIhsLItgXZ1ZNx96sLa14NkwK4eNuXJQfVVBLD5DHcGmNx+2xJNhoY7nWO83johMLx2inD0zhfqYY9nF8ubtXV1FU1lu1mGXkQAegTJinBw3YtJtl4oCunOm9FIfqG9p3KgmbOad3HT+hDpyLt6AJK8+63H+PCwDi4HmWNG1AfTS5XQcma3pbXoJbVMrxXEF6L51qaAKbzMOnGLuXggXcZHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5524.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39850400004)(376002)(396003)(451199018)(71200400001)(9686003)(186003)(26005)(6506007)(478600001)(38070700005)(86362001)(33656002)(122000001)(38100700002)(55016003)(41300700001)(66946007)(66476007)(66556008)(6916009)(64756008)(76116006)(66446008)(8676002)(44832011)(2906002)(8936002)(52536014)(5660300002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w5n/i6M7N9reu6ZYoMr+SElo1v5d7g04MX+kewGqU1K3LHqP6LbLXup3w2mq?=
 =?us-ascii?Q?S90A0xG3TqbY8t0qz7Lemc7kg4JC8CYUd2JHF4XWattPWcUrznVjvjx1XtXx?=
 =?us-ascii?Q?WQVYMC3VyxQ3dOrVlp3cuUhbVYPjZdR7zucl5BcCBbIW3MmN7MRGcXC/qk51?=
 =?us-ascii?Q?XJYoa6Gghmkyn0LC8IVHeu402ZBKvr075zN6PzbjT0IqZN2n5b2EcIQ/eMU+?=
 =?us-ascii?Q?KoxRpD/qzkE59NqVIMS3WNjfUfUqoqgR5ZZHahpu19MQapR/DpqY99d6o+pX?=
 =?us-ascii?Q?iiQy/IYMABlHZ+RAfWQ/KVF9nuFDDJfC8XMfPyzRSOIb7srnKAffcRQ+E+Cy?=
 =?us-ascii?Q?dpDOjyPP/xO/l2SpcV1YMl8f8iRvFm4w5iytAFXtBDwbInjHj+hXwqguL2ZB?=
 =?us-ascii?Q?cBotYL9qczgPlbdFl0Yc4AIr8ckpUHbhYv9msabfizbFWS50Lrx2gfza9zhN?=
 =?us-ascii?Q?hefNgDPojLV0uFKe7javJgS0J+UOI8UHeMk0LRrZO8To5XIQvO0el1fq886w?=
 =?us-ascii?Q?BjckMOupRy/qpdgprJP4B4vWEWGVsdZb5emhMKNUbXMQCmD1B3N9jj3QPYyY?=
 =?us-ascii?Q?m12xsEfvH0hunNeQhJwNm6YK92FIYhKcolCzTNn0Vcc/o2WarxCc4HkNugGN?=
 =?us-ascii?Q?Mnxo89YFAQWXblWFAVLs5GOVeUnkxG3ISFKMlbRF+9nAdioKxk5uwtULlon3?=
 =?us-ascii?Q?DxAIgTaatRf8ymNQQKsUrQTmcICXY5LI3Dg0Hoqb8t1prBivhZzPZQb+jJXe?=
 =?us-ascii?Q?/mUvo/LEUn6Tniah6FXwsH89Fz/RAEZCV+v0sLw7P1u/AcdJ/fPigWWB1ec4?=
 =?us-ascii?Q?R10HSHrE5ITerCeOXyGcod+JkktrpXESYQ4D/OqdNz7hHQ0Og7hAgu9WCbxZ?=
 =?us-ascii?Q?lNx9gAOpRSYKMYGfiQJBsxFGzHBOkryoHwfUuVD0B10Vx3HzRInZMBdLOG+v?=
 =?us-ascii?Q?uMDAl0psswejHXUcYhjPBVJY3Cw2/mvakQqDLWWsBDBACXQlaPaJsuULkspe?=
 =?us-ascii?Q?s7hmZmc16KaFHBDQC430Awq4vgpiGqpLhjOdK4R0yb2pA9FquR2cWGAsupkJ?=
 =?us-ascii?Q?jAI9UrZG5vjaCbJkKjxORVq73SN4DPy2gPu2i4l1g+gSBjmQuD9ofCiTQ6LA?=
 =?us-ascii?Q?WY0JypUOFHSpKEZTU7JvjiCu6rUd4491kuZR55YpYnbxB8rtLjZTrNLyNVPV?=
 =?us-ascii?Q?gmq9e+gEz8wfume97mL5n+qnlQaQN8P/5tI+iwMjbeqxf6Htrgo/oXQgBCxI?=
 =?us-ascii?Q?f6ukcTaBqjGkJSsxwg766bNRvgH3U36fU/Ntpxna1CtFOKbMsIxE647PO5Zo?=
 =?us-ascii?Q?/JaLpkBhDDTZ4cXPo8zfsmic3h0Kst2Mt0+kE8SqYXWACGkwl52ZpuSsMUmW?=
 =?us-ascii?Q?zy+NbB6xQR93N0OUp/jHEkU1K9eKy0lVZvZoQ68kRnxvGqKgE51M2LDb36v0?=
 =?us-ascii?Q?vCuO5Meo5XGFC4ZG/GWAQ9sgUPmg1105TLpWD+wRyx6WLSEongGQuMrK5MvV?=
 =?us-ascii?Q?Iy4V632SX4bfESo+TE7oyADbsCNQavxtRhCpeiF0rL9kaTlhoH1hoslMU6Me?=
 =?us-ascii?Q?yDe6/A1SlDf29HHzutaLdwIpcNV8WNeodg299be5XrwlmLbGyNdo4FKL+kC3?=
 =?us-ascii?Q?DDADiILqH7ojKbx68Y4absA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1076bffe-aa8c-458c-c902-08db18fafec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 19:44:09.7879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Go+vJBJOgkR8c+fAbcCM2ctDIjLiH6aT4mD5Zj1oZwbIzWEFEvNpXqdpFyq25uNxr0wTt4HnLTUGvkdHefQzhV7eA83vr9zKEEzhLVfqCyCJeuo+wCCGiG8ZiqGGIKIX
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

Some Broadcom Ethernet switch devices feature a reset pin driven by GPIO.
Provide the option to specify a reset gpio.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 drivers/net/dsa/b53/b53_mdio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.=
c index 8b422b298cd5..32af5881834c 100644
--- a/drivers/net/dsa/b53/b53_mdio.c
+++ b/drivers/net/dsa/b53/b53_mdio.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/brcmphy.h>
 #include <linux/rtnetlink.h>
+#include <linux/gpio/consumer.h>
 #include <net/dsa.h>
=20
 #include "b53_priv.h"
@@ -303,6 +304,14 @@ static int b53_mdio_probe(struct mdio_device *mdiodev)
 		return -ENODEV;
 	}
=20
+	/* Try to get a reset GPIO and get the switch out of reset when its there=
 */
+	mdiodev->reset_gpio =3D devm_gpiod_get_optional(&mdiodev->dev, "reset", G=
PIOD_OUT_HIGH);
+	if (mdiodev->reset_gpio) {
+		mdelay(50);
+		gpiod_set_value(mdiodev->reset_gpio, 0);
+		mdelay(50);
+	}
+
 	/* read the first port's id */
 	phy_id =3D mdiobus_read(mdiodev->bus, 0, 2) << 16;
 	phy_id |=3D mdiobus_read(mdiodev->bus, 0, 3);
--
2.30.2

