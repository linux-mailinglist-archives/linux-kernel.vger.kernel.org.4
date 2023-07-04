Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207B47473D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGDOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGDOPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:15:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9CB10D3;
        Tue,  4 Jul 2023 07:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMqUNyvnf48g3wEizlhr8x02x87sVrQnHGei59fFigPA9V9ptFcbNy5vGoyg6TXlq7vMXAZJr69N9ZRJYldyrc0MYKS0FowEvhGoLIS1Qwhr6fbDzOS1L6pKXZ7bHeNmpzhAvGkb6RP7Zhdent5hF4Wc8+BSBkTa/nRmKPNUD2tyAg7r9ckWtsjf8nK8gh9inbGhT4uf5YIazh8CXctSpOAVGkE1UpvJ9rOyNu81Bga2Jy+eN1b+NzMDdrUc63fVo2P7u9PNj37GtzF9y7LQb6yR4orFXEQzBWgRpqKZGQkANzaTOag2JPNQDH0jwupVmhuEFDF7tm7U69/fI2mjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h1tp1AY3NqGS04yt6SldZtzLsJxnEukrlGFBGYdCww=;
 b=BTZtc22Lc35eOALW/7GwyXXUJU1lCA0hJyrvhx804GCzMThjDmg/DCIBXSXNSHvie5OXwm+pmXNuyvo8AzsmV2+qXIpz2NeQEHCQKBcpdUSUnXTNXLEDddRNcppKXD1LAEYl54GbuMi/iDXQ7JgMKoPVxaenFAf3vsQwpgpP6JkQ6EA8F0E8VLRt1ZN7/dS0XfBg8caFVJ8ir/+jAt1mUKXNEcHorksca4LI6WtnbciDhQV0PI5sQaUYDHaXqWaH2eeCvQqb6pf9OIaCO+EycRiFJ5rOmmnbn5TPoq2dNR8I2Pou9BcBVac0c6uzKAdjXHV7Y3djc3VQ8jIA6riBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h1tp1AY3NqGS04yt6SldZtzLsJxnEukrlGFBGYdCww=;
 b=IdfffuhWq8Nu/PKhb0R9eqwuoRwtrcOaxSnPpxMeUlIeplbzeiim8d7nDehBgpjqiUego6A9OMQxpson4SwWjIUPIeP0OeYPqiw8X/VGQWHPELOZGxPkULKqTtF1TCAn7KwXjqtMil0wiT4/IFdMdUwrbR2K4MSHKARXHGxOUwk/T7xRumRNtN4edr+04M25AcPYrLAp9j9/pjDtkpg993uZFm00SJeTaK/fBwwpKMaDxJE9FFnBhiegbWXFszgahaFVjUZWop04ogxz16e7S4/QguRy2A9o+wtqdw4my8u3FI4EeWN4Bd98WSaxEYkp+Y+QdIwkAhV+kKOt/8yRyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYSPR06MB6527.apcprd06.prod.outlook.com (2603:1096:400:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 14:15:11 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 14:15:11 +0000
From:   Wang Ming <machel@vivo.com>
To:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] net:thunder_bgx:Fix resource leaks in device_for_each_child_node() loops
Date:   Tue,  4 Jul 2023 22:14:47 +0800
Message-Id: <20230704141457.4844-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYSPR06MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2d2e9b-5d2b-4d1c-0555-08db7c9913cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4lIL+GGZykyvdoRJQCQJDwXpIpVd4vK0Q/INmKDSRcR9ZJ4UbhS4x8llyiXv4EOVvE+iTHFRR2FZU+SIwzoWz9IOH1Se8Iik+2w/SwnasTEx0ntoj6lPY36MptT3dNaOCB4Xts7fGOFNJyQDA01TLZDtaG3zF/xBCNvXi0riXT4JfuAsEMRAKAEan0lXdnog8oOqWiX9gRHe05Q/FCJbTxdrE8IdRL6/T6dIX8Dse1Xgln0YvfjOOsEZg0UH6xv7bkvg4fqBv/a9ND9Hc03LuKDQWj+IPGoMB7MJAUch2F008QGNq+9btNM9GyxDJ+vQyFr/7WxXilV7MxhURL0sdy2SBHoi77Elgc7xO+LPxDi/LjEc1q+gqXtCoUqgCrnw/DUCxoO/HHx0ZXO11Pe0SON7N096X3O+IAKJ19mxPryu0CSeeh11WKeQ5sP3wyCyK27jvy8bHAI9B5yyA4ReN2Q2deijBBGLGSylrBoasYXZrun2SA/VedEHwmvNMq1qC7Oz2FI9ZI+Ivdpeqxpi7uUV+IvnwhvmwGDgH003yvlAkY64v9QfAHFdVKYhrNOcsHNG/QDBWlWFMIgoCbpOerKOamJGgkl54sq4M98S8/zB49z/TYW2N5GMBq5we8v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(107886003)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38350700002)(38100700002)(66476007)(66556008)(4326008)(66946007)(110136005)(83380400001)(52116002)(6486002)(316002)(8676002)(8936002)(41300700001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YCjC9m7BE31g3tIBUFwBMAlJ0RZ3YrSMkHjwQd1DHo401e3cEekYjhzJOdZO?=
 =?us-ascii?Q?vAS8QRoib+MM82ZSNYakGgSkzc4WUJBxrumcvQ1aB0mqTC2Q5UxepT69nz7/?=
 =?us-ascii?Q?Do+u9IUFbEChj98xFqsBfWDp9YXW/DSMjjjFuyGp2q269ausI8Z/95VKc1Ko?=
 =?us-ascii?Q?umAdbwaH8vPthSya6BmCKU0BUYuQOkK3isCXfNGv1nKjzF2SmEPv1B6dCM8O?=
 =?us-ascii?Q?N+LPLt3HDPDPuj25s50xbVpYWw0v8T1DtZvky5+pkJHwh1/yM09apetvCw4l?=
 =?us-ascii?Q?mF25VYQQGOV2dpDrdpNi414zH6Wt0fPHw/SwYL/fXs+FXkxq2TxKGuwESfSV?=
 =?us-ascii?Q?PQuox3ow+7FZyqKMmSRp1+84jk6kGR16PJPts/RA8EBmhVOm9FXN+sNbi932?=
 =?us-ascii?Q?xA8wSPh0EbItdSqlbxg9QqBFUkvXHnqwPO3z9K+5hOJt+vlUuRXcBjOjpxKz?=
 =?us-ascii?Q?Kecnop3ijVqjlkoo7rMI9HUGB5P3n0HX0g6+mpLbOFoUtvb0kRBUGujXMn2Y?=
 =?us-ascii?Q?5shWTWFwGW06qAONATQJBG7kYiS/3j4nxmEXZkcvyEgn7QHuGYZgJJo75uTi?=
 =?us-ascii?Q?PmjrgJgKygi+XMVtU7QFReX9BSR4AOMy/PGDR/ATzjUSvMkO4ka2pAYi0RM4?=
 =?us-ascii?Q?zjY2W/Km+57myMZ4YDt7v1H0OHh6NO0N9qAYbUTAOHpjP6QaO0+J/5ke6R+3?=
 =?us-ascii?Q?ctuZCHu4xZkZp7vrPiZNNf2oGcvHv2QcxfFA80rwuEPEewOh39FV096eIoq0?=
 =?us-ascii?Q?mH30l0Pk9K1PJypn7fo0zhN2J6o3KFCbdvjXdRQ7kKPWHT+xWNw/XMFVYWcc?=
 =?us-ascii?Q?U10kHgbBPi7GaJ/7K7N67BlMD8y3/2FmC28bUney7OTMxXdsdtKNQg6/B8nR?=
 =?us-ascii?Q?s+tpaIm7uvEcEqrlX3YLmWoL8X3bs/uJWrCfecE6sbeXjcrkSmrPDuPW+M5A?=
 =?us-ascii?Q?DCqSO9/fbnNRgDJXfLYITT51u8zjCpKsojgDP9pGFtyTzK7mwvADbFohMm9G?=
 =?us-ascii?Q?kalnc5aO23wV5q+rgMi5FHTuV5ztRXKhf+LWVgDHWjsWf0P8zelwoxPtvlMi?=
 =?us-ascii?Q?LtRmNTutvTZCKJ7DyiIGY78+p8CtTYvj1gCebaGV0BigK4kLj6eJ2CyquiwR?=
 =?us-ascii?Q?sZjfiR8w/aaRAPMmDEbBHrfSjda3KdqKyN7Z3hu7326if8dujPefdEG0mAKp?=
 =?us-ascii?Q?lEaADNv8onY/NauxAAyk7J/vvv8lSUPPKbV4Emb54W9vfttVwRer/KqnYo+d?=
 =?us-ascii?Q?bF9/WyI/n/Bqjh7Czs3A/AawxnhEoCcomWi6SUqti7jveTCGRFdU9aNxSOHr?=
 =?us-ascii?Q?l93dbjyKHFyihBnoaGyVrNkMwmM9nrOk4h2Li9IhAwLXVKosDTziv19wrPAx?=
 =?us-ascii?Q?n4wVOR4WufQWKlXn1H3HUHzqg7f6u0S6P7JHYYV6vWhKszbplEarC1UahlwW?=
 =?us-ascii?Q?AXCCpUyk3DPU1VRmFFsGZmohgA+QDT3CWrDvTwpv8woVYq0Efw0JQzINWuhh?=
 =?us-ascii?Q?tAT/G0v1Q/XiFn2yZrGMwzXHh2IxT4u9RPzL3VuFWQTvkC485vYBo4+NSPbK?=
 =?us-ascii?Q?0RO82RR6MM9Xtgz47wIfnehEt0Dtxr1FhxnccakZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2d2e9b-5d2b-4d1c-0555-08db7c9913cf
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 14:15:10.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnqzQmSPnlNU0+dDJWrpdiRmP/z7mtfB8yg5w2jAu9z5YhK/LXHHtqNfVQ3cT3bbzdLLjCDK9ddhGYPDHc90Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_for_each_child_node() loop in
bgx_init_of_phy() function should have
fwnode_handle_put() before break which could
avoid resource leaks. 
This patch could fix this bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a317feb8d..dad32d36a 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1478,8 +1478,10 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 * cannot handle it, so exit the loop.
 		 */
 		node = to_of_node(fwn);
-		if (!node)
+		if (!node) {
+			fwnode_handle_put(fwn);
 			break;
+		}
 
 		of_get_mac_address(node, bgx->lmac[lmac].mac);
 
@@ -1503,6 +1505,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		lmac++;
 		if (lmac == bgx->max_lmac) {
 			of_node_put(node);
+			fwnode_handle_put(fwn);
 			break;
 		}
 	}
-- 
2.25.1

