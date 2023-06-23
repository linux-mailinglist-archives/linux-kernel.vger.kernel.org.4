Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA373B1DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFWHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjFWHln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:41:43 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E119BF;
        Fri, 23 Jun 2023 00:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTIISaH1CHbUwThT8in8XQislr80e5NhMg4kgsapbtN2Ig7YvLsiP15s0/M7Y8hB9+XbLAewvhbtCxoa8UkpGGGlp9UfGb9gtA1Jxd9oa0hsNOuV3gUM4ab4ZQvWiAMF8lae8uBfIFxzYNHJkZwMVJYVxDSY5wEFSJ/QBxXEVjcnPmRPKLi5z2hv5BX+1qQbk5nJaHn7NYDzOuM96xwBQICIYUXRmSOQJScX5dvZZuF9oHXkvTkZVN4UGY1L2MhzNnBtPLNbKtMwQtxZA5HRQNkFPpLoiDa52W/71YVF79SKmZfFgrgtWNJgSIaYG5oEawynebsdR/MKXw4cy9hnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhDoQ7jQsD4pw67xQEHZTzXm9xr/5MFlTRacrnjRljM=;
 b=oFNDTm2pNL484wmxSknGElEupoonHbp1IUBKnoRKJANsJKeRqkS6si/zkLNmNSGcJdxuMU+jV5Zw4baW6Xxv3uRiD/AuDWNi2b/DmkmqctyAvfWsV8J3w1y1anHnxzUYJZZe62eDU5OCegzKZ5u133PKVQj5aGgXITPvpZzN4i5jvK0WZPAKJ+LTuOXDtlLwda89Tpt6KeOKgS+IMRHzfyfj27CI+hVUt6UdptMm3B1G270V7mxajXKz72nR/Bkx+ym7MSHzn5WZKkHkuVc7Q0+s96SbzHDfovjRyQJE3c2kOZcLSe72X19ziJSoBgylwJA4FG0ij8TOCZurYVyNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhDoQ7jQsD4pw67xQEHZTzXm9xr/5MFlTRacrnjRljM=;
 b=F0Bo00h1idsPW2105usZcwlVeXUlolZFuYx3tKlaZPzRSIJ4esYK5EFrEUUAoKg3CAckw9wvOAEOUT4tUt7LEdLHRcDJUejtF+ikhDFPiC7ZCV6K+uFL1hLGDL9QaQU7fAmaiUZGNJ1pkJ+7brlUuRtVb7EgqfvYXsbow6UUKsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 07:41:39 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:39 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 02/13] net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
Date:   Fri, 23 Jun 2023 10:41:12 +0300
Message-Id: <20230623074123.152931-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfb6a44-7f6b-4159-a12a-08db73bd47d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0JMhL5nDoYvP8WrB9QkblfD96WWxRaMqFZEeUDgSK7MOhD7l2vDx05Y/x8NL/R8XCzw4LkX5y8W6tK2VhGafOrC3jJMjEfx9718IaKk/FZtLxuuduw29mroL74fECpE0wxWHMI7DIsWfgVC2rqP+TwBHI7V7SqxfzjJpwux4ZG2vJzcS+xj+RYq+VaQ3zkgWVKMRcCMxQ85cRReogGOIq3sNKi4fb+9hDJc4M3YFwTBeyffturwydL388QUZgH2H6XwfCaGurIrXfPsXsUHKr8Sz8x3IckRHDoQu39NT1Y3o9lMiWLv/yAMF3W629s1CamaiZ5Ka6a5TY9QEL69Tqruj/f7UwWWs0Hb3aDNXk58dQ6T3g+rUB3nmZcXnWmrIjy9Dmbr7x7uOgKY1Y0a57z+I9NoLCPfJNPP5Cf1BArGVAySfJ14kYBAKoNuii/iXBZP3SyoTA9tqLBkBxyWQniEXw91ec37kI7uBQZwulZ4LRKgl4Tl/8WoYnKOd9cCaQ6HccULv+oWatYWtLbdlRydh1XZijuWFL81DpPONKaSEdIuUCUwFdZBdVGNbfvmjMITYenpSBZb+nRumuaTsyzXeWGcXUjBQFItfSN8Dk1wkVbTCQUosZRkSvrN3MVh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(41300700001)(8676002)(316002)(8936002)(6486002)(52116002)(66556008)(66946007)(4326008)(66476007)(86362001)(6666004)(478600001)(186003)(26005)(6512007)(6506007)(1076003)(83380400001)(2616005)(5660300002)(2906002)(7416002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7/xTrLGy/C0aKVIvv3vrOFMGaeoK3a4HrZxkWAFtXybvvBdZ0w9myFZaAF6?=
 =?us-ascii?Q?tU3cC91AK69MMaiHhn4pBv7w1wvYhJ9V18Ps8SSdRQA+2Eog7osu5s7E8RjP?=
 =?us-ascii?Q?DJ82UGlleM4s8KGAzp59RSGDyfo9ChayR9zg5bM0qUPXx3sOvHPnjWPkM5RA?=
 =?us-ascii?Q?OSuDRJ00cvFCmFVJQkkwNc9drye/8CLoFUAW2wB6pjX4zOCntAq7NrJZEMph?=
 =?us-ascii?Q?dUiuL8dpkJh7Ryx6jxhOaie94Bn5SPFdAWMfYhfhrZehZMM+AVEQN8NUlfvl?=
 =?us-ascii?Q?MJ2/OkoYAx+s6nmlx00RroSuGRh+p8OrKKjUvJnrzbzhMlWRe/KyGEbSMXm9?=
 =?us-ascii?Q?CAog2B4McObxS6kLSWEPYZL99HU5cMYnA58byvb71PIGzpeAZot232uBtp6W?=
 =?us-ascii?Q?wKS51Ltzm0DQK3GBQir6xkXZd04i57CkqSkpvUnPmRb/dbaSA6lZhPJY7uni?=
 =?us-ascii?Q?fPGuSkCGvi8qWMh/ucqhptPdvHnX3o/gF8AK3pMToBfIKUP8VQVtnNZfrN38?=
 =?us-ascii?Q?OoG5ws03Wtqlyq3+t7lFYDfrWgOvpIK+0Ckmqr+t6H+PF0pggSbfIxbC3mOT?=
 =?us-ascii?Q?h3EHk5BVJnLG2qfrvxj7Ng8u3NcN6xjHhOw9B99w1JR930JBdxUhHlK7gszu?=
 =?us-ascii?Q?g+sxOlnk9o7AKq4GtYCZiPwzAL2XTRSGSA8y5ihyVVCsBQDIufm4CLNwRujH?=
 =?us-ascii?Q?b9Ag481hROfgLVWzVCALwSpIbxDcl+cyLLIY3qWIZy9NtUiJ8/eeAW4Q7tno?=
 =?us-ascii?Q?12nkpKy9bOHu/PdtATuv8jf6AlpoeckE+CuGOYcCz14ylvL9ofaKbmKNdU0y?=
 =?us-ascii?Q?vG54GFR8AZ2S6bR9Je9g/PkvNYexR+b2gkJ0Xz/P8plfE8qy0xR4v162ZbkH?=
 =?us-ascii?Q?A0+h7u10NEYdbJm88k65F2LIv6Ocfod+PPFTsyVgWtJqw61FnqoXJ4P6PdPO?=
 =?us-ascii?Q?qIQbe9KLkNBxGSziETgVUsGaDezpnuUtGLYB2Q+AI/Fa2q09dkUO673aQI8v?=
 =?us-ascii?Q?wimmz15ewdu9vepphnbaTb2K2ugpODhoXLTKCwKx7hJxNBh6bFUUgAH1JNyP?=
 =?us-ascii?Q?ZxzSUXNiRVtD9yXkHVWQa5r13ldvzDzgI/hpyzVdTY7SSscVQ4Y5rg8znJK6?=
 =?us-ascii?Q?mvoYwuCTAOzAUR4D+D7xavg69yAxb9AHAlWboAaDozSxIlQvzGKz7Rdrj7DA?=
 =?us-ascii?Q?ELVOK6nzuwWwPvpGHRo0MN91HxAEdyvI7zVMqJg/HodKwdKJw0kyuS9UPGOz?=
 =?us-ascii?Q?8+ERLAOznbbH+XU6yR8+uj3/ObU0M4Vdp/rbfPDKT6SA6Yogma/XsI+osYHb?=
 =?us-ascii?Q?SLTnpcAaBhzdP4RvmqBknHZNUe+1zHBcPRIilCeKG4cYruSMA+vxAta3ehu+?=
 =?us-ascii?Q?EnF4+UASwJ1yKjPqcd8YOe9cAAj7I/UsbD/Jv8bqadBblbvBo80SSmG9lawA?=
 =?us-ascii?Q?k543SZN5h41gfYfUXi7/9elsHWgaL2wvGvK+SIfDyNmwJlc3OxY+3iRV81Xr?=
 =?us-ascii?Q?8xIjFKe2Jbe99UareaBZ2PDGxli8PpEddpzW01pQU1rRC4HCA8p7igIWI3Ln?=
 =?us-ascii?Q?l4ZI/15zYG4hJneQ6Iob2izQxT+N/wSTi+79Pb1O6bF0erpNCXhNRpeuqdUq?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfb6a44-7f6b-4159-a12a-08db73bd47d8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:39.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu+I2Hz0ItBP8TJWNWZ4pjqmKyn9E7heP8MdA7ZmPM0t+IBX5XgUU7C3BnroYnMhzmElFzlBP7ueaNi+54KqCdfyCGOURaaQZJURZPxZQRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RX BIST frame counters can be used only when the PHY is in test mode. In
production mode, the counters will be always read as 0. So, they don't
provide any useful information and are removed from the statistics.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 41b8af0547e4..f1f15a1b6cfc 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -81,9 +81,6 @@
 #define VEND1_SYMBOL_ERROR_COUNTER	0x8350
 #define VEND1_LINK_DROP_COUNTER		0x8352
 #define VEND1_LINK_LOSSES_AND_FAILURES	0x8353
-#define VEND1_R_GOOD_FRAME_CNT		0xA950
-#define VEND1_R_BAD_FRAME_CNT		0xA952
-#define VEND1_R_RXER_FRAME_CNT		0xA954
 #define VEND1_RX_PREAMBLE_COUNT		0xAFCE
 #define VEND1_TX_PREAMBLE_COUNT		0xAFCF
 #define VEND1_RX_IPG_LENGTH		0xAFD0
@@ -809,12 +806,6 @@ static const struct nxp_c45_phy_stats nxp_c45_hw_stats[] = {
 		VEND1_LINK_LOSSES_AND_FAILURES, 10, GENMASK(15, 10) },
 	{ "phy_link_failure_cnt", MDIO_MMD_VEND1,
 		VEND1_LINK_LOSSES_AND_FAILURES, 0, GENMASK(9, 0) },
-	{ "r_good_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_GOOD_FRAME_CNT, 0, GENMASK(15, 0) },
-	{ "r_bad_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_BAD_FRAME_CNT, 0, GENMASK(15, 0) },
-	{ "r_rxer_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_RXER_FRAME_CNT, 0, GENMASK(15, 0) },
 	{ "rx_preamble_count", MDIO_MMD_VEND1,
 		VEND1_RX_PREAMBLE_COUNT, 0, GENMASK(5, 0) },
 	{ "tx_preamble_count", MDIO_MMD_VEND1,
-- 
2.34.1

