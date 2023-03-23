Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E99F6C63A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjCWJbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCWJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:30:33 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFCA3B0DC;
        Thu, 23 Mar 2023 02:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0QK2GUhFDXulqDnlUGbXx2IaVpcwn7yAdBK6UjgnzgDFqkZwaXqq7CUoCOITKsJASHQKK+OcI8vFzM+ugbmSnQ5R8I5bsRy08sXmzNlr5H9N7icED+rSxxF0PmhhzbbFn1reByhB7359PHGcdatoaZwVIt3F+BXGwFiSEvzJapfD0JduOodO0YVQpQ8xaUzh0zpK+52Qau03L4sljUPiybRh5Y4FyvSWLKuPrz99ZR66bmb9N30984hBHuH0gaQJVZVQRKhNgJZSA+x4qjbbTgXuSFPaaRVBJonkXFyqr4imfgEjPBaD74/kRJK/+WP88jKeCCVhDg74gRBIWS5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNqfyKCgdVd66995CTm9Q6VbVxxWeEAGCFI+VWWSogk=;
 b=R5mjDh8Ao8pnq6cFlpvUArDLoh92Erm5wcgmd/VfwfzeuCGXUE2Hpn+UYfF4MTD+3ITfP2c+bwMsqXECYKlt9xTqNjCwGNM/b6CLL6aAJvS8VGugM6PWg7mXw/bbneEnWI2as3At48bo1lWGdmamyIxT8AfVOJ58HLauUrcyp3A0vz6pTG9Sd1TooNcOWBIPY+Tx8wbeQvZ11Jc3TDN8jhqf/6O3x99m+jy1yBKZT2MPU1o2SwFpXPiTOlYOFkbkxjyGFPT7EgtnzfsTlmNKznpZ3/WzYP4dtSUeeiSvc/IOYX8FG3ISduD7MA1VnXnLD6mlNMn0ArK8hTj6RpknNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNqfyKCgdVd66995CTm9Q6VbVxxWeEAGCFI+VWWSogk=;
 b=E7t6JsJ4/m3GqnEsahMh1S5MONkwSbMMPfUXgSelJdRDG0Y/LOObSadXmbiNxtRoijj+37RniHn219vFt5jGFKt8fhrJ2RLUiQaenGo76hfgfCMzjoq5YhmPQA31KNN4Iz1v0Ew+4m/Vv2Kq7xHZ86LQcLn/at6RkfrG4g7geSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:26:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:26:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, aisheng.dong@nxp.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] input: imx_sc_key: add wakeup support
Date:   Thu, 23 Mar 2023 17:31:41 +0800
Message-Id: <20230323093141.4070840-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230323093141.4070840-1-peng.fan@oss.nxp.com>
References: <20230323093141.4070840-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: d6269582-5155-4955-8302-08db2b80b6fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dG5StSBvl+IwP2I6YBRMtZQvToL5qOqQffZNHxMBuSV5jJvYGIF3mRa1eoVBxk703V27rgCrh+UsPLk5VhFsp3LBMoaPDJz9TVWyUy5ReRiWET1xmJHWTUTOx0fOaiJd9LPLlgESd8WODTNSNHJ987rEvR/RMjjGZ6WkpS6luKbVy37RU+7ytJAc2r5yz0iWt4i51Tla9vMTUxaC3wnrXbDooRp29mDuE2gkHmynvsFyRitcNIBm5hiaHJOF6ky0a2ulFv85sg9ZMHnLZEGxyw1hFv/I0Yb2V42Picq+KPbxMcRzVsKaoa9kZMz8dEmyUYMbJGLmEF+h+SvoSRO0MueehPTjcqW4+Cd13eyfXCbktQdagyzkAKu56+kZkaX9CLf8qkpqqu9+X7KMEkcSQMKD4SCl2IAifv07TB2dvKBNqiOsK9MbqZQlNwTWqXbYorS0IkhQ8ZWZpj5IkERv98BR2x0FrX0hk4dxr+VVXUspXa/kplZE9ZfrFnsbShoXbYEF2FKNFHH1Etl+K3XbZhVemsNxFJCEckofTXnxg37qPyCg2SrR2U6FVIlWhTilDV2eRnmIyOZTS7YrAhEPSqYIP1miUzkHrZOsSxby9Yel2axfWTb0EHeVFRjnNnQG8a0GGQopiSXcsRVzhxng4ORqr70hjVnLc+Ya22k7GC/wZmlp4sxtE08BdBR9joGWvFbbNOWgoG8qx02/mvlJiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(86362001)(38350700002)(38100700002)(2906002)(4744005)(41300700001)(66476007)(8676002)(4326008)(5660300002)(7416002)(8936002)(66556008)(66946007)(2616005)(186003)(6512007)(83380400001)(6506007)(1076003)(478600001)(316002)(26005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nXcvYXEciiV8jQqG6sDGFWSMmrl7GpRjtqF1XPffPmXkN4ypdIwjD1Aq5al/?=
 =?us-ascii?Q?qlYA6vZBh2Zo9sTzoOrhGAcQFjbRRme3vOb9bqPGO7892BAQd7kf24FBqOOk?=
 =?us-ascii?Q?bbhepo9iFhetv2WihlVGFMEM4oVs+t2BKDwOhoEEwQVSX+vGOOMWNUo6h5iK?=
 =?us-ascii?Q?krMFiN+73aJrFEVHJPXqKpoZzAHk6t/kxWx7kh5iTDrgBVHd5FpzmG0WfRYK?=
 =?us-ascii?Q?5b4V6UDtLPVn6Xi7XXd9ScstZ0NWJMjofwOT/c2EPX/vasAoSaSLMVQ15fGj?=
 =?us-ascii?Q?xTF2sosJk5wU3NkA/b3MYLftuRhDNEF/vcWK0SGZNBRr44JMuVv93S5BXeUB?=
 =?us-ascii?Q?RlK7Nva8UZoNxS0pxtnowA6vn5OlVkhDtB8qcsgIsJQnjqANdaZB78eszfZa?=
 =?us-ascii?Q?yRpNcVbvua5D67NcTE//5tKYx/YVjrz1baLrSOk9Wj5L/4TFWO7vDhCACSar?=
 =?us-ascii?Q?G3mfdD20GAvXu+fBl3JUzqawTMy3uR7ZjNdLoNS8QtbDu7SFEWaBS5yQjSXQ?=
 =?us-ascii?Q?aSF6wASYz8VaHr1LsQm2WkgeyDSTkAdnrWZ2i11dYTNRcb6AhxrzJFdpjbDL?=
 =?us-ascii?Q?IRdnSbUbZaGZS8zHw8s86Ma8+pAfkuFep+1KWvqvUPxYhvFO0e+XkysQG20/?=
 =?us-ascii?Q?zwWWNla4fmCFM/h5ctfNinStLr01npb/Q9+BDU01HqjasBtlJH0dga2+OYqu?=
 =?us-ascii?Q?XeNHpMtFRon0G3j0QcyP3VM2mnw0Hg8tqilXXXoyX9svg2NesXmMOn2gyyy2?=
 =?us-ascii?Q?N5rclhKJLz5tE/jSqXVbUHaZXYXWDRD3X8fXlwF6pb9Yuh1zgWwDpb11bcPY?=
 =?us-ascii?Q?tm8Xg9cmC5FVuuSQVzQn8fwQrCYis9jcVH3+rab81OhV/yXll6DJx/1yc8LC?=
 =?us-ascii?Q?ChOV/KiMqJsDx3eJPNBqFUZDhEUaWf3zP2vr/FBSS9ft3Ry4SgeQtf0p4yo4?=
 =?us-ascii?Q?TdkAa7A8SKh71hHqrNitkf4gKIFWwlM2MSJRFTRB4uUco7OUEqGAol5BhtqO?=
 =?us-ascii?Q?zjPHEXxdmB498+Tq7rhX+YeuDEaBwfQ9whNv9wuVWWbFPWxfk4+zzg9OXBhc?=
 =?us-ascii?Q?IPC+ubW88ImM40n2P4lyQRcfHVxifoNAyPjyU9W9g/hqOPvjyJwbHfn5eGLw?=
 =?us-ascii?Q?X5Ansz3NPDPMCD19rL8Q3XVv1vJBPjTOi585wwyG3rn/MjBe6FthlCI7p/WL?=
 =?us-ascii?Q?fx8X+5/yt+wTUUo/7e+xr0DRMqM02zfrYEWdr5rgXJscLz7nbmo63a/WmwVu?=
 =?us-ascii?Q?5BmYHGq44mx8nfq8dZohIUNcrmcOLHg/GX2JM/HlJnoNjcZXgl/A+eSUuUCv?=
 =?us-ascii?Q?uokYZ9cJVn3wxO6DISvXP+rEpWStaRP8gP1ZYPNwbERoIdW3M+TxRLA9QsX1?=
 =?us-ascii?Q?lx0lrOz8/40kWDaT6U8iK/CBlvl5zTllXtEaHLfQCbgjOYRxlk+3xJE2cWHp?=
 =?us-ascii?Q?tjoMTP4uIfEsGc4YPUMEcu/iYDP7mbr7MeD42e+uUVRatpZOcQ6ryH4Huh/F?=
 =?us-ascii?Q?PhPzSUU0BKskxbwwwohIRHDAjrj4qQnp+RLZWieTEp5TVvc2GB8+vgPMuvRR?=
 =?us-ascii?Q?XkHo3z9o1J4wqNeAcjvFdl+k0Ez28+3cIN2YCeja?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6269582-5155-4955-8302-08db2b80b6fc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:26:43.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxDBghMnInHJDvjwHWV6QedlYGzhwH66wbQS91uEF7cagPtmtkPrx1sm30PardpBXXXx0f1HPyI1dF9uYzbayQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8603
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add support for waking up from system wide suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/keyboard/imx_sc_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/imx_sc_key.c b/drivers/input/keyboard/imx_sc_key.c
index d18839f1f4f6..234f23cf9990 100644
--- a/drivers/input/keyboard/imx_sc_key.c
+++ b/drivers/input/keyboard/imx_sc_key.c
@@ -151,6 +151,8 @@ static int imx_sc_key_probe(struct platform_device *pdev)
 	priv->input = input;
 	platform_set_drvdata(pdev, priv);
 
+	device_init_wakeup(&pdev->dev, device_property_read_bool(&pdev->dev, "wakeup-source"));
+
 	error = imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE, SC_IRQ_BUTTON,
 					 true);
 	if (error) {
-- 
2.37.1

