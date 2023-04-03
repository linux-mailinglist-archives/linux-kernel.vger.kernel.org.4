Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6196D4456
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjDCMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjDCMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:25:22 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20D230CF;
        Mon,  3 Apr 2023 05:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv7mNiAk4AWB5xAKLoUkfaIF4z9Wv3oBJqyPoF2kaiWZc09g1/2SMNVXzWpZT8hbNGn87VKFjIuyG4Ucb7eLPN2kEDFa9qZEyqSe7KtDKbORqwCAX3B8ePAaXuBUcNcd9fCOQJgXuRkkfEOi8VlXx2i2odaDdp7Zpzn1B3hHsMz5UbiH0fhIj198NybCyFVRKmyETRF6s4NPyct0olRDsRPlhq5uyybdtQhp5kVqk1rdJGisy2gOCdkopWKFeLxDUB3ISJoQ3rZAwV7Fm9ADUVr0cKs2m5nU5Yjq8EJWCrDC2ETXUCQzrYFMpBDABV5JdrDqF/9VKBObiVCLLjufOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEdWfAhMW7OsGCoAr33LsU7jTLGAydbHKtYghRho4Tc=;
 b=C8RK8bg2Tr5M0BF/z2fr7VYamzgKF9Ed38sUzLK+8BlEiPKoa+DKSF9DpLsk3HPFCPMURzyDDyVK4swHOe/7ZhQJEmFxlew0xVGaMwVQIeLrIfHEYzKpuPpXHTJFqF7IEWzH2AsYbjzYOrs4DeRK0KoycR1Zjod5AYgpatQMQ0wihZAEtl5YpXT24TyfSV/t8Mb1sC58TmrEs4rxUj1XpDuU08tbvdSEwSlE49G25oQKr5RbBw2NNBjmmGgxFbBERBpw4DKkgJmC3bJbeLYUfojhUSe/mjzJbHdcjxOt8W/x/Y/pO56oy1sQy9O3KlKwIZ6TNjPhw33pPtsr1IK/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEdWfAhMW7OsGCoAr33LsU7jTLGAydbHKtYghRho4Tc=;
 b=eYWAdS94qzlN5+wt2QV82+seD06IlTRh7mkkiLaL7ym2Ow1jcQfbtNXGOJNG53YFuPS38enwqyQEXWI8ZXbABcYY7xGAN1Vh0srpKIcLXZbNr37yltIyUDf8fy8lNQaBbGbBD24AOIkj2gc06q4Ux56LwMb1OQY49kRpIFDKR8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 12:25:19 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::1013:5b17:fe68:d06b]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::1013:5b17:fe68:d06b%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 12:25:19 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Disable Power Save feature on startup
Date:   Mon,  3 Apr 2023 17:54:29 +0530
Message-Id: <20230403122430.1024235-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
References: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: f95b9fbb-10be-456e-af40-08db343e7ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGbqdRZCJV2OBZ8agA7Na171C37OnvYIE2+C8Nh3otdljXnDunOIMw55ut+HGmFwEDtCnKZRagTNLVlFNIDvz3eX+VQp3oXx7B7fBQSnxlrASVxwvehRPrv8Udb25QHk1qAI7m+fwbEror/0jNBu0zqAy4kqBg5pcbj+kblLe+JHPWM6wJPCbLaSdtdQz3Q9CDuwAhQRFIvVWg9+l/rGKG5Ajs9jDVi99/jc41wT51sepWMmdFowFv/5rvzSQe3gKbPxxly4+AyKR5ggM5O4koWUiyLxxo28w/ml3ujeu6m4FLs+j+Ng4Qnd0LbKIACIf1DRKw1kKX1Rcg7HLsBiexxHUx63CS3DhdkYvK5f4wsDDdzoiiXHpLoy7MiZiaQ+jFsdsfAhqFm7yrS7XGzXlUPnQ2HZDXLkEAPdnaKb1NQo0MGt9pExuDfIrSXGRKmvGvbiQFUnK04wYPQvPZviobHIhA9ioD3NeuBFrj++4GWq4mH0PMFAgovEnFNz40fDarxtYcbP19ancCAGYcp1sro0vbZVA1N56t+yObWFWJ+FL0c9h0DmYKH4jGbOZm66qvo9xb4ceH75AFnhFikDRzBqA0iegFBnMyUG3+N11jF69N6kR2EHOnxXyifBEhuU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(8676002)(66476007)(66556008)(478600001)(8936002)(66946007)(41300700001)(5660300002)(4744005)(316002)(186003)(6512007)(6486002)(4326008)(26005)(1076003)(6506007)(2906002)(83380400001)(2616005)(38100700002)(38350700002)(86362001)(36756003)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5fvl6GBOmds2IfiL1gsTbrrRua0LE3ljhabuQgQg6mnxKYv6Od1/MxF08Ag+?=
 =?us-ascii?Q?AIWwdQ9GeThmayJX8o12oPojU5+cDOV7VJkYP8DtNhZEwWAESmLWxg/naGh/?=
 =?us-ascii?Q?hsYIu4zXX0YWr8fAjmlsVAhwljUlqL6x0rR3OvLDotjBjpOphjSw5d/V/LbQ?=
 =?us-ascii?Q?tDopBOWioOQre/Ts9TwjDy6wOTk5LzkAr15NEFtIqy4kV4St2CU4gx7Xhikv?=
 =?us-ascii?Q?Bq8arKWRIsa2YslUuAimypBVJNIqIYvkVTtFxijn8wUeubviJwpa9w8eQB9T?=
 =?us-ascii?Q?qcLyP/cGZCq7h0t9+415IZNQy3faQ7nOX31uq1RkmfIabOB8OUO2UvmYeZmL?=
 =?us-ascii?Q?9qN6SMykxxMWuGaPNO5L2cD5o8yznM9KQzPpSPi+tvK4GAtIwXCpxp7zJtrp?=
 =?us-ascii?Q?/w27bxiZum5zGHPa7Q40peZNmWyicujmJjQfpx0QkJ4dl6mNziZnAn/54Z7/?=
 =?us-ascii?Q?NkzqOyvuhT+VhgimEdKmJg30jWFvH5YitevhilIoVvOt3wcm2OsU40Oi6KVH?=
 =?us-ascii?Q?4JQlfn9Mh+Z3QdtzJzZ1LbqSJ32rJfiuPKfIu57elODkLRL2Ns4sACEvYfX0?=
 =?us-ascii?Q?vkpBac3mG803MR34gtcSDaPPrS5ikNFWiEC3Tyi43oqV0FWHgkQeQAGjpoSa?=
 =?us-ascii?Q?sBc1LSZPPlnjEv9nEm40hek5RchKbREmS9RB5sqEqz61E0WAekUgZQ4hu7ua?=
 =?us-ascii?Q?JbTh+EodN148nXfw3UzfP34S2ElM9fzYlIY9+0t6qHNOfzbgYowU/ehL4mnL?=
 =?us-ascii?Q?dmiBxhCiPJ4ANeYZ1meG7Dg3xUtPskRM8OacGZsSvOMWdUcbBJJTyKVVJ/Y5?=
 =?us-ascii?Q?KfArdr/Tab4Rynby27B610JslDpwm1Yq/2my7q1zCOlEym8GrcGEjwWAgQu0?=
 =?us-ascii?Q?fznvRyq8uaIG7Q+0qiPROQe7dHG+UqTTQiG0tjGoLurMuoLWD+HyktzLiBAc?=
 =?us-ascii?Q?eatlzVG5dlF5voDamNU+eIqOoHDHh5IwLkZecJDzdT/SmPs5gcJyPBSg06RV?=
 =?us-ascii?Q?Lm3QXwsH9dobf27iJYxOv+BuZo+bcpO/yYXmwh+tDUQ2t5TQIaQBpHQjtxj5?=
 =?us-ascii?Q?VknyS3DozYxcbVF6ROvGpNZOUlgZIPx7/otGSCyqPvvt6oM/KOHdpuSIZDvq?=
 =?us-ascii?Q?42DZcR8vPcnh1GurWnETEYMDIosXTCqoXEtHHqcecym5WPLLovzXw3pQF7by?=
 =?us-ascii?Q?HPqu4aGPMY6qaY5m4fxZFlfgNYVOTOMKjJvSE5cXlGvRsm0ZUYOP/q+OjBOL?=
 =?us-ascii?Q?Af7WWkZgdHczLRgNIV838+fi3MIHbZL8jyY1jq46Lbf2TZooVssfSAHmaBnh?=
 =?us-ascii?Q?3bvQF2EMpcvE4wzLvR6aqaMHhexZAeyTTEvim80syG40zM9BxxCTbKdzni31?=
 =?us-ascii?Q?p4LCLD8s6d3/dJpM7JBle6NrBbH2dGnFQFRk6vL00UAXB4UsyxK6Opoz3fDU?=
 =?us-ascii?Q?+nz8vjgVOGMLYqbMhizKgensWwF9c+616vLFTQTF5a/qsNdSF5VGvPlocFI8?=
 =?us-ascii?Q?rc6j6QRYr++d9fawxLa+KOrkEIGfevV7y3KEpjdd3Abkb8rRdpBJTGMF18Kw?=
 =?us-ascii?Q?RsEQpGo291zSArKp6QzfnkY3FB96upPc9zJ7qje3WVTMcKr8CvsCmK2IN/Iy?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95b9fbb-10be-456e-af40-08db343e7ce1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 12:25:19.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiGVKgLkwgoGqR3VE4xfBJbuFolfr/r72XtZ5dIFpG5BPWvux+yX2akiYnFr+ySpxV4zDBN63eVXnJNuNfYjq9rLDodiavcSIat5IkcJqBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets the default power save mode setting to disabled.
With this setting, this driver will behave like a normal h4 driver.
If user needs to use the power save feature, it can be enabled
using the following vendor command:
hcitool cmd 3f 23 02 00 00 (HCI_NXP_AUTO_SLEEP_MODE)

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index ad9e25e0c350..93f3afc0c0c8 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -262,7 +262,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
 #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
-#define DEFAULT_PS_MODE		PS_MODE_ENABLE
+#define DEFAULT_PS_MODE		PS_MODE_DISABLE
 #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
-- 
2.34.1

