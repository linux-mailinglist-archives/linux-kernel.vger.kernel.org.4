Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB446A4B70
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjB0Tpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjB0Tpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:45:31 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD6227985
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFVIbjT10g6C30LOYJaEQ0DCw0I2N5VeKvqAr8VlftUMSTrEwUsd/UkIgpBJuX22u2pcLeEpzMH23zXP6omOg2F32edmnD5949dSyzak014fi7lgX+tnfGqfnUOdKxMYE3a1ASHo4jKhzr0jceRaXxgxmCNGqCUSmeVT2vGNC59+/7YV3IDCBiEP+/0jy/EDXoigx/l7wwaJqnyhM2u3+8ulfSg5+8fIqoj0nu46oESrCFKUfzfhVB2ZFh7NHZ88p3WUIdu1cqeRSe6rvq1SLGVRwnMVG6g2L9Snsu/c+PhcvdT+62Fk1HKRH/Zq7gaRN9JJiKRNnBJHjHdm10EpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phVMmw5yBtU0nZfoa/1pph0YODvjMPASHSh5RZIrhfY=;
 b=IxVrpAsVUcKp8VjRvh37n+CgzQ0Tp5AwCtSenJxq3non6yotDhCR+VnT01gwGlY8B1eQy9ZpLNQctRUZiwqxS9oWA3WIagvfjUhQxi1t1ojYDnlYtnXXSC1N7i7q4qsVMQy8kfHQlEcnX5WgPb9n7ocFdJrT5hgh9WjbBKNRwHRtd1KvwAzuXwyyIuYK0bxCAFE4ixlWU4T3ggcPv1aS9Tg4kaUETH78LyEXK72X5cBHpaM7fPvFpKuTKCEfb7rYkOkzaTv32QbqMYnfpTQw78eoZxFMy8pFubaqnm5rb2yYLtqCjrLtbTO4ce1zLQkWAdrAtAiIcGCXu8ljJD0NMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phVMmw5yBtU0nZfoa/1pph0YODvjMPASHSh5RZIrhfY=;
 b=qRQzG+e9LcZ3YBaEoOEdWS9ZRW+DSPC6E1IgJfRfHK0ez10XaLp8YLXbsSGiwybbj6Bz37xiZE2WTwN2rvAAMGDI0ggyivQyIuuxLrearaLaUC46PQYhrNg2LRc9FSbfVNnGazdqH9I1zKYTnc3awCUgGFUFbmNViErqZ5lj4LU=
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com (2603:10a6:208:15a::12)
 by PA4PR02MB6717.eurprd02.prod.outlook.com (2603:10a6:102:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 19:44:08 +0000
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e]) by AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e%5]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 19:44:08 +0000
From:   Paul Geurts <paul.geurts@prodrive-technologies.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] net: dsa: b53: fail switch initialization for unsupported
 switch types
Thread-Topic: [PATCH 3/4] net: dsa: b53: fail switch initialization for
 unsupported switch types
Thread-Index: AQHZDjHADSjl+tWBL0ee32YPeAQktK7jqxHw
Date:   Mon, 27 Feb 2023 19:44:08 +0000
Message-ID: <AM0PR02MB5524DDFDD40371F2546C2E77BDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
References: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
 <20221212135640.3590545-4-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20221212135640.3590545-4-paul.geurts@prodrive-technologies.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5524:EE_|PA4PR02MB6717:EE_
x-ms-office365-filtering-correlation-id: a3b87e4f-96a5-447f-be9a-08db18fafe34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w/XUvOJO928GAhpkEYjeIQKAnFq/1b2woGobVJ+tEsTYeacAAL+OgRJBANq2FnIbgkuuadeDTp7vKERWSHgU388ZARnKING/LYjgEs5a4mL/65p+a/TdfEcYCCqSqPk+nPbAkToL7jm7EM62uh08sQJJHLYSoWwBpFC0u/PPHqr3FtfG/Wgrvnt7GTUxdcXICavJnVJOU7dFeIpZBYqv6Q9sZjRHCtjcVjEpBo8/KCP/vuroyXMinP++99OGgMFk0hPCCKq04OmRtqoNqpi0Yvn7HcRaWOu0czNawqJcX7c+zAQqhX0GTkL3YakSXBIHsBZ1SqS21QW+yx9ciQMLwCSnklwdNJ1XqgGgN5b1XvZIGng55XlRYNRDa+R+SX2gyDlZ4XUztYo6wvO/ndhMFy8UCsLvkeutu5UubE/an8yZX8GKAHIypRBiAT2etk0Y/JLom3NLzniO2UsiOGVB5qc+QFufpZaVcwM56B9Fl/n9vrHTzc7pMbgeBP+jSr5iG1z33GlZHErwlClCNqfpy15kFBL+ITF6I6ljcDIKTx9eVGyCscVrS/v/cl+Ujl/myK5hmMS9Ah4CdThxP4KDHk9MG4gij+coNJ1bpNRkBRKjWS+k0//76mTcToIBZqGV1EhCbZA5gQ4qS3APaCu0tM43vXsn/kk5N7yZ7fmesWx4C8/2wJwVcIjcZyAnaWQcoCuyDbgFdHIJ0/xhSAhGxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5524.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39850400004)(376002)(396003)(451199018)(71200400001)(9686003)(186003)(26005)(6506007)(478600001)(38070700005)(83380400001)(86362001)(33656002)(122000001)(38100700002)(55016003)(41300700001)(66946007)(66476007)(66556008)(6916009)(64756008)(76116006)(66446008)(8676002)(44832011)(2906002)(8936002)(52536014)(5660300002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P7DN9xbe5sNYCalxWWT1fSUYpGhzccOV7t497oQYZsm+3dpDCUvF/+Hi4jxu?=
 =?us-ascii?Q?4JE59JhnFM7Brx+9UW4HlUpxZtHxHc305Wr0EVDheNnvdUMlnWhN/A2Q/7i3?=
 =?us-ascii?Q?V5seR3fNnm0YDzzAuLsWsMijG9kmfNJns48F/izk1vP0CYsxIQXw6EA+BLGd?=
 =?us-ascii?Q?+bcAMYEiZRwGg5QwkVUMNr7HqM6m2SUfxQCG8ev+QKY2Px05Rbjf1s+kUBFv?=
 =?us-ascii?Q?uhY7lSt0v1lBIeahtCjpK6DHYXY8d+ibZZ+rH9r89IbLiJWRq4iwahoaATWU?=
 =?us-ascii?Q?MvYJuy02SfM/P4KtPIC8MP/VrfqSzWN0GiN1BnYS+vazYFHqeEEnmI/BQnpW?=
 =?us-ascii?Q?/1VuubLkNIwFBS3vNAyO2Je9wmsjCHnYI0wHjVRXB7+I9RWWZoPMK1yAvEfc?=
 =?us-ascii?Q?g7JGJay+j713CqXoIoAwMyHkGrHuBbWGj8iNsnvZYgAiagqAkttbCA6xh9o1?=
 =?us-ascii?Q?TV4Xdi0wmOZ95JetMLv5yOPuW7NQE14m7GStDyeDZYj+3xmTHfQ9zinJTHfn?=
 =?us-ascii?Q?rrqSj4wuNB7v1MIqwd6q6b5fsxD+M8s2FOlFC1+8cKeEwax0/nKXxtjVf347?=
 =?us-ascii?Q?ztAk+A3GzMbnkmyZZX0CvO2MLVxDlTTXScWGfjUTKh9Fz2bevgm5A0o9rfVS?=
 =?us-ascii?Q?W6IJX688HUZfL0CihP4xtL9oXj2WT/CIEA86KJrmRb05LJ7vp+xM43NxFMNC?=
 =?us-ascii?Q?yhP5i7Dx9lt7hIrj+B/oiV2JKzaxxA2omJgVKyOFm4JoYhFUTDtGSXnI1aSs?=
 =?us-ascii?Q?cxk0jrWxQhWrqzzq+iFJTbyjfwtE4wboLD9Fct5tA2/UHqoC5tixV6fDjZ/H?=
 =?us-ascii?Q?01mMnSJ2ifiSxG8nvYO3CON3iPfevUhXAkvXNmk6GlkQurdchc05BnV+TG+e?=
 =?us-ascii?Q?DLlYiuyWvhYBVUrCXDm5AvA8S7YVYNRiwJkkpVb21/1i7X4wNIDSV5JUCn9f?=
 =?us-ascii?Q?VIcV3HhMfFHXUi3D0PiSzFZ/tJBfaONR8lXcxAZD9u5Q36eCf1rrZ5lj82Mw?=
 =?us-ascii?Q?RRgtjWafy6E6Z7ZhZi/X1OAgg0V1eelkRNHfAGE0gQI1H/jf/i3d0Uz4UMcE?=
 =?us-ascii?Q?UnhPvbPLkinzsfX6LCMwGQoUmb4g2GVhoTnDHWNYWwDul/gAYrvOyTwgFjKT?=
 =?us-ascii?Q?WOYLfxrsvMl4GVofbd/dXitOIt+Yhl5dX3crXJbzoAOi/E8jFqkEv4CBXI1v?=
 =?us-ascii?Q?HuaUG2EmPYyhlXTEu2Pli0BwZtlOnXN26cm+FG1+r4PU3x1XXp63xfoWKpiZ?=
 =?us-ascii?Q?vuzFQpuqMzvyVf1T8oY4GGbyiZXbvWL8f35U87qffCv0dkeeW0EZaIlPn0dL?=
 =?us-ascii?Q?OUCaw5SgMhPc0bsetbCfJOItj1vKNbvMMxD8Rg8Kfwi/FM8PgTdOUr4EtXWF?=
 =?us-ascii?Q?gEH1uPI6AE16aMMNDKK2NXgr3Dlu97dXSLYLixK3XFG0A2kgr7MEKcFhbnNm?=
 =?us-ascii?Q?dGRGezUjNuYcJvI9VlfVxj7UbFp5stmRMVAD3fMKya9CJigCFhKVQG6GX8hK?=
 =?us-ascii?Q?8cAZ43nHr4R6KsvenIJ9F4mi+CTjajMdZ7KveWLrWneItszAY8PeqzrUC8G4?=
 =?us-ascii?Q?w06rl75vT4aqpibR4U/aimmUyEe1Vz3ciksCGQTJe9zELyB3WfjxZf51FI/x?=
 =?us-ascii?Q?oyb84AjWXMsEN9eP+UZmIzs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b87e4f-96a5-447f-be9a-08db18fafe34
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 19:44:08.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rw+S+vE/1KI9kd8J1bk7199k+CAwPbIj2okmos4Eqz94ZOFMh1sOgjoWoTEbRyRptVxQPdL9qs9AobOlK3n/HDmpgrn70hKgZw9LHS81Dr99OvuU7m5GPgiRjaxA8yOw
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

When no supported switch device is found in the b53_switch_chips array is f=
ound, the driver continues to do a best effort initialization, wihch most l=
ikely results in an error and most definetely a non-functional Ethernet swi=
tch.

Now, the switch_init function just returns -EINVAL immediately when no vali=
d chip data is found.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 drivers/net/dsa/b53/b53_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_com=
mon.c
index 6aa76cb4f992..3aa0672f2ba9 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2572,11 +2572,13 @@ static int b53_switch_init(struct b53_device *dev) =
 {
 	unsigned int i;
 	int ret;
+	bool config_found =3D false;
=20
 	for (i =3D 0; i < ARRAY_SIZE(b53_switch_chips); i++) {
 		const struct b53_chip_data *chip =3D &b53_switch_chips[i];
=20
 		if (chip->chip_id =3D=3D dev->chip_id) {
+			config_found =3D true;
 			if (!dev->enabled_ports)
 				dev->enabled_ports =3D chip->enabled_ports;
 			dev->name =3D chip->dev_name;
@@ -2593,6 +2595,11 @@ static int b53_switch_init(struct b53_device *dev)
 		}
 	}
=20
+	if (!config_found) {
+		dev_err(dev->dev, "No configuration found for switch id 0x%X\n", dev->ch=
ip_id);
+		return -EINVAL;
+	}
+
 	/* check which BCM5325x version we have */
 	if (is5325(dev)) {
 		u8 vc4;
--
2.30.2

