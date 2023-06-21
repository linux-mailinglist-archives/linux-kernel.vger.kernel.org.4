Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D182B737A02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFUEAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFUEAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:00:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2079.outbound.protection.outlook.com [40.92.74.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFFA10F0;
        Tue, 20 Jun 2023 21:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl4zF0Bibv7oR2hoo5X4PADVwAIdAkBr/ZVrzBhj8E7BdSUVgMgyqpCiqBdpWiewg58oRNvHU4qscP42+hRFfaZQggv3KmaD7DjDL/8xCLbq5ZS8WXcm7f3eBAX7NotSd9BBYdhe11oxdECRVWONNFDMMrOfSx7U3V1nl0fqrhNI6XbNirV9uRHyYhh7K4U26MHo8C1xshFkMaO4yJgrbUY4sYCGvVgpM0KCXdLmMobHQ+xR6I+05WEy40INlH3YRifV7L00Nld0QxQcnw7EMystYCsOiWHnq3I6OgTPrBpTgAqR2Lhq/2tIeqQgiMDHO5jE0BGbHTYb0nkDx/w15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cItG1AFjXtrdojmWbMUoT879VHkL7SL6rqYrgl34xdg=;
 b=EyxFemMYAzR/RSL0Ey9dCvyFbE8Pkx0R62S8vmn3ySo0mxGgJ0SH8p2aoWwTWTiV5fXArNU3yvHKO9we0I+SmrjdmL1Ore+P+Xkno49KXmIrmGSN8MF3D8avWS4KsdlG2D1To169E3VdfijETzascfBpea71m3dG3EnQR91cCype5q2MdsLJZJUUpriwekXy5NgH+fo5Q4VnffPtk/rqFaRfqV3KDm98eAPbFNiQdPT6JaKJ5ZaOK4tCpIHwfs4NVRLt+l8gIej6cq3ZAA/hxvr98Uq/jXQFdKZbbxZ2LN83YdKi6mcxZ/Ojo9l1gNfvFkX7qxypO1P+BmQZK/RfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cItG1AFjXtrdojmWbMUoT879VHkL7SL6rqYrgl34xdg=;
 b=J97nUboySRcBYAp3Vowh3Q+KavYBBsc0i3d76QdSXNNfm98vraa6/Yk+Y1ygquxkpnB9HGJLlIsxDPGNTTnqJRRtjkMo7ztjNl2r0CjG41Yu6Wv6duyxK5rgwKyCXM8xVDcdkJ2lk/ZdvwJKFkairL6zgdYWsfuygf87j/wtPsmS/fN3MwL5sE+VdmIlTBHVBtGfSOhXvFgvxqQD6gx0cOw8H7w3euINsshsUF7IN98xWTRYP0UR+lYsvIfxCHC0ulySpMUld9wnsAHhgUUs8fjk7cGD6Kbh1mGcSiue4fQ0m/oE4pnybhAQMpphhqReIDjKacvyi3dc3DPQX23ZCg==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB5652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 04:00:16 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 04:00:16 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [RFC PATCH 2/2] hwmon: (sht3x) add device-tree support
Date:   Wed, 21 Jun 2023 11:59:37 +0800
Message-ID: <DB4PR10MB62611629FD3764FB7FF61D24925DA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621035937.58721-1-JuenKit_Yip@hotmail.com>
References: <20230621035937.58721-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1X9BksokKZ03cF5ejWD9xVDlZWoP4EkM]
X-ClientProxiedBy: TY2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:404:e2::32) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230621035937.58721-2-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: dd79e4f6-4613-4970-c387-08db720c0576
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmpXYlgiiriwpiw8n8pZtYyvhHaZ+ikyytccZrudNB8sPMgiTaOEzXL0zRgllRSAXVOhUXXPpiH5c3gaGrW+MHbyO7fgLiylR8+0xYYNMBgFrHz8QinC3h/io04IOekCnsN3W+VbcI1QE0J/65qwjon2+mJAqFpM8ziT2zKV2ngzZzo/6in+uosVMvFj65Y4hK58eHltjOKpkPEiJSXwVreiItldiz2egcrjVoA+s7vFrJvgjzWj4CgubPzj8tszduhE8+6Z2faKoyZsGmV9kGrRRM9d1izipb0G9Ad4OvtcBUjnXW4/kY5PIzVfxKWWlAUw0auFDYOqbYkcJIxsyrr7RJVfkdR+MgoNj+1hD8smsMylpoX5hkJ4NBvw4qY/8PNT7lVcuPkWbLEAThj1MmbTfIko0fMLEE+2cClIVaLRAoN9KAicIRv6dGSPzPbGjc4J9cK4Wqzgzin+snEdRB5CcIV7YqEZEirmr/t2ArSrSi2v08+gB8EHjv6RMizK2sFjldvYAp/32HAH2CE4892Cy7Ce6BGLb/2c1ObHZWdo4j3GdpMWZOx6/tbWDti/YBurObQUDBNLMXzDhmjElmSISxA7jzIgD9Kk4apYH3d3Ymj3wm0XcGU5eu49gTOk77jamjh+O3u6jOWxqR3FUg2SEVr8xLBlTVApZkTQwvaVa6G9i2RplLroF9uRRi56j7Z51i+mUPrfTnWDtzkATX4nReT6FYbKsONRmhkKLxWGDaAO2Hrj5+xUDmVY46sGJec=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IJWV2hZ6/rN97dB/h2Lv1HYeM0Gjoj+txGDvj5ET7l1fmz6P/ORZid/Jk6gldgIucDmgbApdtIWR0zXbHw152DzRb/z8ofxtx+IyNTRWJ+BgRBNnjxTJBJx2/4lha0T4AS87xGopaBJH14irdTq7w8jcQzY0svt1xAryx8+WIOfih8TduSHDPYmBv99UFItOcMlonqy4pLNmXh7xt4ZXz6hmXHP5oJvD/Y33wE91YVsT4O7bCdQEr0J1CjodXAOUuZd5xxKQUuDlh4VVrJEE5CH2dN5F1mgOI3uq2WLssl9h4loOYvz8pn49jwUSSCZELEDcLoc9RD4O6z9sOktqrrGSrKkWLmGAnp0qFNyJ16R4ofXWq50FbQeRu3KiL/C0hkVJ0oOX0NNpEp2tfaHnBgdr20gb68bCHhaERFH/JSoCySEQN8sNxdph+KDRWnU40tbvEW5ylzz13y/RTd+7KcqNz6z0ueGbXgmHTPsK8LVwVwcT7MvMLyYWGbv7xBJD+qTUX6DwIDsyW+bNXNiic7K3W1EFuL+VCk9avOnBKvzTsbuV3yQwqEtdpcoSi5Alhu4TQfVIy/FZkxoBXRCFMTMATGIclO2o1ehdjBVh7OmO/xSRK4/aGtV7hxwp9Pc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSVoAphxIUliUVz2vZIF5fm0k478i0AHUklxV5ZuHDKP/pa2LsVYFvjfGcGy?=
 =?us-ascii?Q?r1ir9qTQSEhW45UVunIEkCD4NUN/cz70J4uu68Iudfj0yfOcfX+y6W3VuDsT?=
 =?us-ascii?Q?6aGC0z6q5qKtJm7TiGvCCegvn5DNjmORbssZV2w6jc+FYo0Oi+c5ygKAauoM?=
 =?us-ascii?Q?u3NfbglKi9QGXDJFSgFVBkKSh5uPiI6N8E7LAhTVPUt6upSXT9thzOd9WSnm?=
 =?us-ascii?Q?88Vejwdo/EwGIycvylogAVcro0Nz+T0C0cP0jn2LTymQpaktT829uYBP403V?=
 =?us-ascii?Q?fWzfoHFYf8gU/IX92eD+pT0DzVwU8JBAOpa0g+zON44P/ZKUF73enIoLG46b?=
 =?us-ascii?Q?xXxSuXKhzePfXUVkgqVG3LGe9UWryGfu5ZQZSiBo1D1iuHuJoQv7W/nGcAKG?=
 =?us-ascii?Q?TtjY5pJ6w/1ucVAtyPQBGQonkhOn3D1IltmQKm6fTHoIRqNRtAtN3pbc9G8A?=
 =?us-ascii?Q?R2yJ4laML6LotR5PEc5xARP/sIFRQRVOIrEsSFFn9L1S7fRSS6mI+vNrobSU?=
 =?us-ascii?Q?O0gfg1LlnW/HRLbgtujv0wFc+daF9WRrhoWLoNpNXAw0L2PR1l6XyBIHGqBt?=
 =?us-ascii?Q?ViaoNQucFTkKaZ/XA3aZCdqZ6PQ12PgYzdLRAD8Txjj9Em09Pl70bvNRgPxi?=
 =?us-ascii?Q?3LSOB8O8gAZw/UzTM+vnIjMdNaPbGxrp1wuutiKo+mPEc9q9Q0fUmd6dtzcR?=
 =?us-ascii?Q?zxYXwf8QgsJUnuRpz28CHqoOrobOCSSkLE5EppLDqiTOJ54nBfz8pj03R0Qj?=
 =?us-ascii?Q?XartlOXuO0H5eGf5GjHxyoPNJPgmLpZQYnGIUYHvKuA2OaBjUsJf+T/tFdIv?=
 =?us-ascii?Q?HKLOaFug/wvwEXPkVbhHnQLPCtOlm60pKzeJglFLBmXuM9oWt+Yxte7AyeH2?=
 =?us-ascii?Q?uOPqwwM7aAt0Qn34ufbSquhWr7gKFmN0OjadnTQQa3d+dHJb7I0DRvVwnwRj?=
 =?us-ascii?Q?zjUbIVH1OINpEPJN40Y/E/udoEaDTK2NnZxktG7pdJRC12UWCuBf1zz9/Jtn?=
 =?us-ascii?Q?rSZb41SJpXKlBoHABUeX+ig783bMFvGhGB02oh18sSI19LJHlmB8WLH5471q?=
 =?us-ascii?Q?8oOpRpZ5rtXXjvDj9WXspvvqLsWCx+Bh/zElivOS0wDhrifRT5pKMYx7ytCy?=
 =?us-ascii?Q?WUsH/6l5VcpPKgtIupuFWt+NEcxZHAem1yIH9aHr/bi2pcGlohANWdQzCQBQ?=
 =?us-ascii?Q?HfvcRzcFDy6wKUT0zxxLyP0BoZRR821v394Ak5ZA5V96V9brq91eTGqOhAY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dd79e4f6-4613-4970-c387-08db720c0576
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 04:00:16.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5652
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add "compatible" property for supporting device-tree

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 drivers/hwmon/sht3x.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 31013b5b6..edcf6820c 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -923,8 +923,18 @@ static const struct i2c_device_id sht3x_ids[] = {
 
 MODULE_DEVICE_TABLE(i2c, sht3x_ids);
 
+/* devicetree ID table */
+static const struct of_device_id sht3x_of_match[] = {
+	{ .compatible = "sensirion,sht3x" },
+	{ .compatible = "sensirion,sts3x" },
+	{},
+};
+
 static struct i2c_driver sht3x_i2c_driver = {
-	.driver.name = "sht3x",
+	.driver = {
+		.name = "sht3x",
+		.of_match_table = of_match_ptr(sht3x_of_match),
+	},
 	.probe       = sht3x_probe,
 	.id_table    = sht3x_ids,
 };
-- 
2.30.2

