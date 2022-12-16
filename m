Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3D64E728
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLPF7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLPF7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:59:31 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC74B396E2;
        Thu, 15 Dec 2022 21:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1t13Wg9daZf+XeLNzZcbTAnAVJiyVNkaqQarMhK/Yb9CG4t/IAP44PmtVUeIWUgGUaJygxCaaEHRrijqeZah4g2XoC9IO64hrIQTxbnQ/8cmmmKoa0nQftjOt453szvs5MTmGq9Ndpwu+LAYjuZY0+rRtgp4h7RgTp3oeTcRfMn8i/CnYtsx+mgCgLccBkdCTgdVdi4yxm6pMQb3W4f5HQlKijSiRkrkn8aKh/L8IZtTDIzJCjuZQJ6T18osaD4dixfoEibIbmfzzwjMskaFTqN/374gcDWhStdvvrUGmp8y2IIKbggMUknkukYNSVqnIp9g4BvPAiFpIUrqb/t/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cfG+LWsgth+JOhn8We/0dkK+SmKX0vt/aRGzQl7D3A=;
 b=fajdvpBWDNxNctMLDFhOXvaElef3Xq9EGjC3nKaPNqzuuL1r8kA2Cwjv46SqfD6LsZ/CnnKVAdb4D7g10ROXoUVE9ugWlcTL4HZ5RYnQD8L307yX/N0Nm39sdT93BHSne4RAyA9pHkZ5s/fkz76x3lx1TQzPnP44vFCp29rpU+VxzCftfXsNIxc7+mjinAGgQj9iOfsjNT3OnCSOXxxb7MKIfQFGdZgC1NmYTnmbaZiLO6GM6rq+zyOH+nUl+IIYCmsqjHxX0nRvdf8tqa5tJtCG0OhKpB5L07bYYQZ84mxYmkzUumbnma/WKsgYpv7/xFQ/EMuujZB5ikCEIgkHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cfG+LWsgth+JOhn8We/0dkK+SmKX0vt/aRGzQl7D3A=;
 b=OQRlSrS8LBKibuhWmqBei+gXlltwc7M63md1brQYntgTO3zfY2B4vPLVeTBsN6Jo8jq9Uvp5886ZpKaWJso2u5KyGzEVpZbd8M4Wl6OAJWRaQikimARyCV/Z18d3Ifl1/EinUZfcGssNL2rYjMqHTN5UUBn9SIHXYHlUNJrRXzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AM9PR04MB8148.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 05:59:27 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 05:59:27 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools: Add identifier for NXP UART BT devices
Date:   Fri, 16 Dec 2022 11:28:32 +0530
Message-Id: <20221216055832.741741-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AM9PR04MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: a626eb27-eb2d-4b3a-021b-08dadf2aaf8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCvMdlLvSwVGcUhPGJEKJoj776mcU4fKMYVMTGKpUtm8j3TZ9lT6DK2RRj/OTK/dY5kwiHOFoIDagyTa3D487rQAu4nwt9qnirdSpTmYQCDe4DByWbMospbg8IcgcEeae9LiylG8GfErh6ui7dYCycqzpCU2yLuHFqm3AuSDB1tm9UPeQDa4E80qlsrmNJo0wAetGnEpVYNHWOJKWpApr3mpwhUhWFfWGdN0Fl/xfWlX2bIFBHSwG8RylYCACnJgfxBRrZjqmsvNXjIxIlAkRtAuB6YPuYgsBy5rxFAsULeLlR0XV0FPZYykdJBJjhfjp/s0webwieK8G5ghfANwfnDD4CuUfDomEq+cqjtyl97CaS7twh2NnyZHnvrnFgtMGJXUMAqoE8uSGMGPM0lhsEwkuIABPQhMyCSsXHz0CIy5NNQhp6S9Ln6nyfhEdZVYFiLRXSRYdZ/bqTpN6lHetzxs6mmpXx2EKLyA9Vas5zOgUxOF6+geMN4NW+t3+C7+nVGP/wMpTDkPpXnbo14n3jxgpAZf/Evj/TM47pF/ZzbXYOZAmlG0MXONgO8BHtlpLTw5MFb2MvCGo2pdke6xPQjK/GKSQA3aoK56wGrxb+5bkAePIReMncz9IK6N0Uk9uEzogTZEGW18/kQeZEadgTLYPQPiYJB/og/cjMmFyDNjxD8BERdE5VSztH2Cuw9531CqbBNPjZP9KKo691V04w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(38350700002)(36756003)(38100700002)(86362001)(6666004)(316002)(66946007)(478600001)(186003)(26005)(6512007)(2616005)(52116002)(6486002)(6506007)(6636002)(66476007)(66556008)(2906002)(4326008)(8676002)(41300700001)(5660300002)(1076003)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tMtsxZRKZ8XhoH+xKqJAO2PT3J38UMCl4pK8ogmTELTVQZ35T9J1R/pfikO9?=
 =?us-ascii?Q?iCNTJLiTzyq6AvePUL/dovLPjygiQ4AZuCcNIntxPuWJqoThDz1yOpK6EZkX?=
 =?us-ascii?Q?MFpFwwsR2tLCROcUYUaWBfJAWJ30FmEabuPIMgUZ4n/Vf0pg61CGu/fM+TPq?=
 =?us-ascii?Q?JJ8FFrdq92ltJRuLpE6Px7nFSnTwz1ApJyRUFPexO3UHCVqsgQ7843yGzwRY?=
 =?us-ascii?Q?0IykiHn+sqrvZejcgyYOvCRX4AW0WYow/UtaakdTmDZY4TWqRey8xIX3KLuO?=
 =?us-ascii?Q?PFOiSdmb/k4MVdWBRq5ReXMHmabh39Y1QRQ5ot8Kq3zCZAs7sW6ONtueg7SE?=
 =?us-ascii?Q?xbFmok64S9txhEXSLP+JN/QZIUNLkYXre9YxN+s9PCZyhR8v3HYK8ibVNhSY?=
 =?us-ascii?Q?D3mQtUZ+QdLyfkmZkYipWHC9LJmqiJUdnYPvvpxITqFP22PPx6CQxg5fIbD3?=
 =?us-ascii?Q?4EIM5PTRrgrYaGCg8YWsDV4XhPVaHNBno+QBzj8fMsqUVsOdUOtGgKLn/Fzw?=
 =?us-ascii?Q?Xg23FyDreDV7NuoCZw7E5EL8lgqJfqnygmuLJ0nmcvaDc3F+J6xkBEkneHHS?=
 =?us-ascii?Q?K6Du7lNrVOo/kWEDbY9cMCDoazd+OFwPZGP1aAhDCaBcdXp55A1W9sBGsgg8?=
 =?us-ascii?Q?1GawvclEQ+R4T33suKF1JEExjb5rCZ93+FP/YWHcO6BZ4k4SOyNOiJRACeR5?=
 =?us-ascii?Q?RdMAowbKJEaI12PNwtCR20V5aVkYHJwEETM0y04hdoEQfk2+X4eCaY0BKa3g?=
 =?us-ascii?Q?OTv4Mr5CA10HIv5QHXzGDr7ruene8v3ru/St9k4Mo4ma7B9sGgcHImXniiLv?=
 =?us-ascii?Q?l5xaiBl1j7KH/7tj6JkkM4Br2SjSkr7F4N6orFnvbMvwiGJZLKMxWggI6EOE?=
 =?us-ascii?Q?+Rgky7TiRFsdADfoS4jUb1/p2y+4RO4VmgPT1mFHY7KBMABGd6PoPENPQNMt?=
 =?us-ascii?Q?yJ8D/tKrdicW6tvy17e5HTDr1YoE9s6tsiyQl/4H8Z4YlX27nZMzECzSA4Kt?=
 =?us-ascii?Q?MO8cRZ+oNHeyFCXt4uC84g+xUvJPrly3zwvPigHzJd/jiMyiUXE36Xge2bKK?=
 =?us-ascii?Q?SXQyEQGFowtStI8dxXfrokQOoKChHyF+2zlHubDmY5Ry2EKWvIk+10+unPqm?=
 =?us-ascii?Q?lErkgCacUdsxPSpfeUOtXNHuguql1R2KDTqWyFdtQcfsbikPCmX7nyd3gQUq?=
 =?us-ascii?Q?Hp5rZdgLSlyH5vuYz+vitZVyyadwBsKT8GLSBhRmemUG01nVVF2RmAkHqkGH?=
 =?us-ascii?Q?LfnsDkPBLJTy2McyXdxN+Qg0lYJfuDp134Hy8jRST+wFyTTzLC3vS5W9sumW?=
 =?us-ascii?Q?kZmHKbm+obUntitvm3y2kaYtq2a+wtOWn7/PM8LLxFF0MKXkJabZQKI/CLAQ?=
 =?us-ascii?Q?BFKHrTnWJ87XuK8JFo/iKimBRGxgNo1gg9Wh76BMq8KovpIWJfBfa+md+1y/?=
 =?us-ascii?Q?hzoTruL+CXz8n457LqookkdTeNmoZ1BNz93PGzhsOsPtwB+rcfyW9oRSBfJS?=
 =?us-ascii?Q?lHvMcb4Yl93Y1tyo109RzXrRyIxBaQXioLI1XhDxFUZtoiYyqfM+hedUvEf0?=
 =?us-ascii?Q?4rd1L55wnTbzBXfV9NrZ6yyvsGkGXOvE9E0c7n4TobO0705ZxiKD8QsuThPB?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a626eb27-eb2d-4b3a-021b-08dadf2aaf8d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 05:59:27.3991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVgNhVrPvGOOLMIcXS84rOrjgaE5jhU/0aesqGhLiqZZ7vMBM9e1tCBmIWrCBJXl+aYV+2yOl94EucetTTQAfjNFyu+f+oylV2WHzohYZNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add identifiers for hci_nxp to support NXP UART BT devices for btattach
---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index 4ce1be78d..8a30c5bd1 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -212,6 +212,7 @@ static const struct {
 	{ "ag6xx", HCI_UART_AG6XX },
 	{ "nokia", HCI_UART_NOKIA },
 	{ "mrvl",  HCI_UART_MRVL  },
+	{ "nxp",   HCI_UART_NXP   },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 26c0d5424..d62cabffe 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -32,6 +32,7 @@
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
+#define HCI_UART_NXP	12
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
2.34.1

