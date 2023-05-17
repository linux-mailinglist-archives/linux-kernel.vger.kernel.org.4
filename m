Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD67705E20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjEQDad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjEQDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:30:23 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1679EC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnTWSVMgf2Ex+7AUSl1uBlJoXLoSvdp76hbyVRJA/12XbLeEiWmZatmHPcZt/Qy0cPF/IeKDedt0HILxW7E0z0FmqU1qT843fwlw5qdflq5cZnJl+7Hrd1WtQjHz/d8V4IVM7veos4JtM3kgnfOSrOp0WLfXrhpVEmuK1xE2TfkeEYWu7QmfrzB3oQ8FveCAVLNQaxKnC3DJQAm4k8yl9lZYCkTQPCWJDZKWB0pXvZhDx9DRsAWhFTmsYDaJXPUZNCaAjuEPIHhClw5egIuYSBeuKiWwHpiOHLl4p4rZLXCjJTn4S+Bv/c0sL5oqxRUHOCOikpvJRQPw4qBw8EeZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymrcujo1nlu5lKOjP/sGMh6/oxHbDQDwi2E6Y2R+TnQ=;
 b=SIgdmPaUdf0uxxU8Go9eo2nnfcqaq8k17GOuF5Pq7Xw9j7uRXjr2ttVYPQGPBTE0OpccsAPwZ6OCKsZ8q89hln/E1PVtTmpypgLz+TGsVBZMxIN8J4Xtc7aMoIo7ydm4jsU8e6hvW38CZwLvC92DQjUnKkBXswuZLAiAKoAi/McLpae0C1EKjd1jVc5h2wNfuV6ATCaWO8HaNtgNkZ31FUxy5fzCYQqEcg5BiCAg5G91wYYiF8T7ga/xkERGPQkCI7C2+HnYlAcFfTOFq+UV3YSaUZsmWS94aglm28UCPOftXIo3Tat3kvCEr5wslwUYhWD9g26A7L6m6T4UbHXJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymrcujo1nlu5lKOjP/sGMh6/oxHbDQDwi2E6Y2R+TnQ=;
 b=ACUE6z5xK1T6iag+LeXAes6y9T9RvnwqqecgXkftK/GBL1qXSgkaOBPSH7/ydlPitJo5SzGHESmBxgYrKUlvUgFkmNP7N/0iSEAt3g0+3U2kwbNcvihToYPtn7F8kHxXo7YJ6jKrcOXy0/FBcWqktvBsn9kSqXVEJ2GuMPuKza4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5089.eurprd04.prod.outlook.com (2603:10a6:208:c6::21)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 03:30:21 +0000
Received: from AM0PR04MB5089.eurprd04.prod.outlook.com
 ([fe80::da0c:329a:5bbf:71dd]) by AM0PR04MB5089.eurprd04.prod.outlook.com
 ([fe80::da0c:329a:5bbf:71dd%4]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 03:30:21 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: master: svc: add NACK check after start byte sent
Date:   Wed, 17 May 2023 11:30:30 +0800
Message-Id: <20230517033030.3068085-3-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
References: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To AM0PR04MB5089.eurprd04.prod.outlook.com
 (2603:10a6:208:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5089:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 304425a0-3908-40a5-018e-08db56870ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVsY6MkcsMnTb8Spxqm/d8ForT6D4bK7mj/km8nc0uS+q5mHoedc1W6P/Us8QOVoGCDY0WEyApxcloJt2h6GBuZd9oPNHRc495WjTuVoWxTSOv6uhnuBeoUnqIX44Z/rTRWuZ5YpoSXUtzUA3knPdldfpZ/W9HunVnd6ZuEKAZCORjcQNcD4RPgeHemZxUk867FAp0/vu1jmFH+lsIApCJxS6GwjphyQsCADSe232nDwPrhRRev5BduVsBW4gKQM0Eq65cvhifzGTbDHr49XRzSMVljQfdwkidyVxtuyAwOlpgSl0v8RU/GEI9wkR30IskOmdajgFWMUBdCFgFm2Rp0BrMCasyJqDSjj4AVKEbgb4kyizx1lkRxLYWMwOAbLxGl9wFJ05gIqWp/jUdRddQbbUJeVV+FAh57az7e6jfgDCWC2v2FBNPCHU53SVPThAHtSgeAunyz4N1VKKqGk65PFavMmmeeUYouk6d8GNqYEmMg772/CkZpVznzoBYgLWd0TDx2+38q0jU7bm2ipL4XeFQYTp+K9D7ubXvpAL18Y6m7WmvrRbMdyprUWObH6QzDaJzXCt5lYzto2tWnyw4zhUnebTC0m9xlbYWvQ8dbpIC2p8n0CUboellWFvR4q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(6512007)(66476007)(66556008)(4326008)(66946007)(478600001)(316002)(52116002)(6486002)(2906002)(6666004)(8936002)(8676002)(5660300002)(26005)(1076003)(41300700001)(86362001)(36756003)(38100700002)(38350700002)(83380400001)(2616005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldi+KQNd8XQAAEJSZ6LVyKrpLUEMezPtZg/GzyzpLoSS6y6N89Bez3Fp2vMM?=
 =?us-ascii?Q?p1FNPkG5WtJBW3soVJhytA2dNnplLWRE6rot6TbxxgZbYxxYrurk785vZMFC?=
 =?us-ascii?Q?dOKg6S3bSo5tf0gRtbZ9UZhPPPmKju5tH0IpRnlwsfhDnpjSNoPKPlITrsaK?=
 =?us-ascii?Q?UMB80yFzXhi+BzZ6uDUz7IF+qWeqkbqJeq8hoyOfF9pi755IIJAKXXi9bnRo?=
 =?us-ascii?Q?vEFATuuSvIDtdOBqsYwdlujR2x4dDMgbQslfmOhh6CWbmliObEbr6uKpwMYE?=
 =?us-ascii?Q?4SbmHyH/uDJHgN1qOl/tvB/vOPdo1Qcnz69KJF8bLP2D7TdgiNTFbgIdIgZV?=
 =?us-ascii?Q?lNXiyR80uyJAa8E4GtLV+o74UYvp995S2J6Flqe+xDW4ywH0R3xj8weJms2u?=
 =?us-ascii?Q?AUzCc4PWQsnyr4YTaBVCvN1AIScb74TkV4nv9Rk1NET53UjPS9DbguOoUD8x?=
 =?us-ascii?Q?wWYd1YohRH0I7qXTwVI9y+w1eyGKhp9J2YD9icUi0KSv8dFe8x4/54U6n7F/?=
 =?us-ascii?Q?LL5EuKIbHN8Te8FzUTEVKzKtdW0YIB+YpW7SnUGX2obCxvBKD8QlswAK+WVX?=
 =?us-ascii?Q?8brSLIYj4HuCpSBhpExU3xJm+5YH3exHSUfmAJv19vzHVdG+HYPoxc5HsTgP?=
 =?us-ascii?Q?hux0CC7lI469bNI+0D3oduLI54hzBnW3s2rwQApi7ub+ZfvahYcB2GShxXIo?=
 =?us-ascii?Q?0Ea4qSI9oBaPKF9a5IEuIexUeBhm4hDIm1zrCOiR+TuSNcSKeneV7CGuyUPN?=
 =?us-ascii?Q?geVpLx7I4vkNxHmq01z0PMsrnYTDZ+HVuhCh71BVT6TtxPSJk0OY7K93DKSi?=
 =?us-ascii?Q?TyTAOL8TJ/B0FEyr5MZ3KrAZtiUdMAJuF8jO4t7lqPxpSMJz3wNNRFCXx28l?=
 =?us-ascii?Q?YwXqcaWvKfgrywOVwbHR0Etvf0hYuHtxwam8U8TREyYoqgdvVjxmBA7gRnKV?=
 =?us-ascii?Q?edI101pZ8ZltTOYddyXuDkxLL67f8nhoIUfKewzBe5+vOMQqTFnh9A7MhRlq?=
 =?us-ascii?Q?lB75SGVlnp1QcY/uWJkAhe0P3zOQ1VLt7BPItoksyy6DPeEcQ/jdbA9jV2He?=
 =?us-ascii?Q?cwNbUVznProIIKCEB1CfBWzpZkjhlaL1638pP7may2s+4FCr3SY43yiw5f46?=
 =?us-ascii?Q?ZrlT8tVZWrW4Ju2Qk9v2Fj9sWSFC3UnESWhAXUZ4e6MDh5unVyFUdMkT9jFS?=
 =?us-ascii?Q?gxcKoBzeyr5eG39DbDj4RSxUxz6Vz1zTuG0/3gSqNY8xdVdCVAaoDgOsM2UK?=
 =?us-ascii?Q?irT1m69AWq7RJiVDCWjbEHFsg6S3OHPySAT+sj6kPtIwTuyxUSbfbu7GCGcj?=
 =?us-ascii?Q?2hmGzUhCL0pMli/eOL5dKrD0XBq1yTonJ64eyVGEP1YgiclL9Ff27Z6CHd54?=
 =?us-ascii?Q?QNrT4XVqfADaNJFjVByo1X4K1zotsDFbw9XB443ZPDWeaWu+sa9hEdvii0ms?=
 =?us-ascii?Q?+4kQHUH3Cw8SVJZNxPSqdRIHLEjjArIw/01m49OcYHgaKm/sRrhjz/kDePrj?=
 =?us-ascii?Q?EiWI6pn7G3oprHzAYzGNWawPIYfbCFKKkIU4Kbsk19GtI8hQAfDZs/TNsr+V?=
 =?us-ascii?Q?Wyhuh4wa1U2V6cPDY+quCoaUZUPhkPXthoj+K97e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304425a0-3908-40a5-018e-08db56870ae0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 03:30:20.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wGRzV0VnXr2Srtb/a+niKWW3VkJ/Nlf+GRBXSNlMAIBKADhoCiYsy9ykdrl6nUSi7Q55yfNWHbiMWv3GZb4Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NACK check after start byte is sent.
It is possible to detect early that a device is not on the bus
and avoid invalid transmissions thereafter.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 4edf33ed207d..0d63b732ef0c 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -92,6 +92,7 @@
 #define SVC_I3C_MINTCLR      0x094
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
+#define   SVC_I3C_MERRWARN_NACK BIT(2)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
 #define   SVC_I3C_MDATACTRL_FLUSHTB BIT(0)
@@ -1014,6 +1015,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (ret)
 		goto emit_stop;
 
+	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
-- 
2.34.1

