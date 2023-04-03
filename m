Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54866D3DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjDCHJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjDCHJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:09:37 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20A71040D;
        Mon,  3 Apr 2023 00:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqMGPtNN0MtCRn+ZoTWX5LtyMtgcBhnPgezXEWgjY1f92KSO1ffMc6ofIsLlkYzMdxCMmXvSTN39q348R6BC4tqraaIP3pLJEB7iU3um108EG4w7jhck6HLNeclYbZQrFHXw5LqO6rjJ+PDjwmMwWVwG/o4WvWtz7u0/REf11+aBlkvZkVAdj8Bh4j+n8fLjEiTivVSfM19huf5MQIcJx/qO/SwqMh8+NwPvPIN9TU4VUKw4UQtzO+acN6b3bZ3N2n/2o4V93aGSKRs6u3K2HtrZKA3xo3CDWV6eUUYQJfA9BAfcRC51KMNEm86C2Y4mF9qKQRk6imapxSnnthv50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ82eJSqbsMwdwdcVQ1YRbVTFOf4x2bv6//OwnUJ1ag=;
 b=iC5nD8IkWQbXs/t1uwXNoEqAOvMTp/gUN6QXUKS1wmCgw7HHtsbbAKFWuK79ryDQ14jJCeW7lsVNwTsoPId1YaZGHBHBUsr3hiMA2k+agk474XPxxKDDsfKXvcinqjaSn3+f1Sr/V659x7cFqIA6d7Zo8O92Eockzi2qpfHpEmxWcQVy+3m+t9kEQ6+olkEadN+tG43V7GCTxVzn7aHH2ZcIjbm0diGUE0YY/I0OP8zRcMHfMwrzjCojEKvwhX+4JqxLZpMg214whfkxKBfJKlre9tTo+8H9scx2VmC+pqITEeCeIsk86jYAvZX29CPUjfd4AO/qbl+5kYWfXctDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ82eJSqbsMwdwdcVQ1YRbVTFOf4x2bv6//OwnUJ1ag=;
 b=fMfXBZSomAym2yzIdXstT2EuDonUGx0/Wka89a22ypqzHYJCwm37/6HfGPTdnXevsQXmuzi0HFSUoPwRmezt65/JBuaTseCIENW617Gw9hkOpAHtXoECiQXVKoy5OuVJ72t5dtNJ7syhxG6dlzDDRGpE3PfpNikCxgL9BitUtkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9457.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 07:08:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:08:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/7] dt-binding: clock: imx93: add NIC, A55 and ARM PLL CLK
Date:   Mon,  3 Apr 2023 15:13:08 +0800
Message-Id: <20230403071309.3113513-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
References: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: df95a8d8-9356-40ce-782c-08db34123da0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHPq2Pb1ThYNlAW6sJ3umyGUsVhWmbUdZfudKQQoJ8f6iLQ6y/e63reHU4qmNA5m8JSGeA8SAytk+AIc2Dw7Q86BLL1+7iQ/Qj3Dr3ZGvRRiweo9A2cGPVTfDwpPbdVQvKBmTgTWYQRJRW8ifYtEn4raOcQpadAVIpbXJ8AnZCVVXuhewQ3oTy1UvglmM0iPk8VgVIj4ij/8cosvF2jo3YAWKrjrw2QYkREJ10BpinQyP5Dyu/aGD4We+yYQCkRFQeMzEVxl+3289Y0Pz4yPXBCdRXZi3epbkxuKGO+zpOSIzRCXxQY6Vv8GfimZULh7zntyjBJIEOF5UyoDlRqRvXQgGAA6L+pBcwnuBmrJjzKbtUtnr2XGcBzzpwptzcR2CVR0jocAMd4zlEv/hrlRrB+j5DrBU/CL9wISGvKPeBjHBbT1r7166CAvbQKrxzlAm/FzUFyo9fclvdKKk255vwqUo2KKkHWRrmlJm8oO94AhL7t/2abi3VLWm2RnUFJGmgtpzzDHshqQctRZRzd2LC3wcEAB4tGdyiBTJv9P+q6iG/bjlwAB2254VD5fymbStKdAy6Lk09odFwFeio8xxPXSFDKoufrlaverT9C0Z+Q/kpGozYMhc6nZEfpVacGc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(8676002)(66476007)(6486002)(4326008)(316002)(66556008)(66946007)(52116002)(5660300002)(478600001)(8936002)(41300700001)(7416002)(2906002)(4744005)(86362001)(38350700002)(2616005)(186003)(6666004)(26005)(6506007)(6512007)(1076003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMs5WBXJfUpEId9gyptyMZpnIq97yauhN7rS/s8UG3JH9P61Cb+j/Jy3phGH?=
 =?us-ascii?Q?HjRJLCOn/7jtHRKbWEOB5/G388JoHOmZGhsYd6XbEc4eyui8iOV3S6fGN1FG?=
 =?us-ascii?Q?0a0cmOJxg1XZaQFogYCQBsnMsihI/GiNh9g2QcrKryfpe/cR986FFXk8o/Io?=
 =?us-ascii?Q?nK5bE8+LMvSLUMg49Y0fscj1pHOEvgwvXdRxFNL0St9hG+BewxzUg09X32FS?=
 =?us-ascii?Q?GVMpB3k4PzoB1yRs8gIALo7bf+4HIsaHCJ1WzJq87ixdS9pZts56WF7n1hmW?=
 =?us-ascii?Q?JtkSseRL2pxYq+Bl7TWq3AV+pNkdE46c7encHBOvqiNKbGQzU+h9DmjcdTmI?=
 =?us-ascii?Q?0vBla4tmdIPJeeHm+w88/fS3A/OdHBIn9wAm0tEAW2TVOLKgxUAgH649UsyC?=
 =?us-ascii?Q?/8r62RFUxoz2gFdpRGimI+3n6OLCIF06S2RClnRkDMFpdXLwvGzl71MgVOMg?=
 =?us-ascii?Q?tQK87OwdlW8Pd2VB4kgJFPZGosDTyx+f3N5fJA6iGDGN7GISSKWzTkbMO7rR?=
 =?us-ascii?Q?tOisctX2McnZFEl2h5obdAcf/+Pyz/SOqHLnIdHZJsHtDsIpDp8mSN0S8EsC?=
 =?us-ascii?Q?6r6h6zgvGLhBXOp3DP1W7utnCN6w/vxHJzWNO1y9UL2YHEdnAkQvaFeBwBGY?=
 =?us-ascii?Q?MIIWRO+Z0iPBX0SCMpdJTlhiBBaHHHIlzS17dZ4eSZ/fNk2MStNSnVXjDpaa?=
 =?us-ascii?Q?puuoJN8fBSWFBTiOCs+Pj6xmrBl+NCY6PqUMc8qvQTUsacxKXfkWUFw9bdYJ?=
 =?us-ascii?Q?iNkpMkoXKmIr5u2OPQUlGdZXzxyzpg41wgM5igRTuOz7Mfgp5qdqoOJZD7GS?=
 =?us-ascii?Q?FBF7Hq1KaD5oBrysoXhBphpRsE+lhGJP9aNyEfK3dUsgMmNOUuqWgnifszns?=
 =?us-ascii?Q?bEwFGbiqJWICxJQDdW4zwXNhgzz0roBJcSBMN7JXdr06Z34Q1GRLyzqrUOzc?=
 =?us-ascii?Q?MVcjo+/OH5U3Xci0w+trFApA0PfllbrwAZBcixnea2H3Gfi1NbXea2OMLefJ?=
 =?us-ascii?Q?FdDOSdCOdX/LhGtVOp5KS8dZATSZ94jAAoz1D/rG2LBR2KOW9Rorf0kZytvJ?=
 =?us-ascii?Q?Ub5j47zuyEqo3+4KbIbwoO0VkedxZXOzTdq1YlWSZibUCUsJq7CzC4IOV2oS?=
 =?us-ascii?Q?wgRpoBwCnbaHAF3sDWO1BosM4l+e3kdqNNrA1l+DYuBNXcqtKxDWF+f+2BLj?=
 =?us-ascii?Q?oCwovOyUEnfplcHnlnrwVGzMqn6uAp6MzR6DTn0lJDHBGXB2pgg2zi0WqDaS?=
 =?us-ascii?Q?ZaL9X/v4mDh8ypVLVKtq1/mQgpetcVJwNcSVwHbtaTzfdvpAIPDRhD1Ij8Jt?=
 =?us-ascii?Q?E9iAJ0wfL5Fp9916ZzxeJIK6YARw1dQtGZac75SbzDveSSXlxmHY60oxvF7O?=
 =?us-ascii?Q?9zQ26iZeSDGJTc4gjEI/VQZR6CtcaV9uOU5e9IjzmL4+GiR24syyJOsw6yl5?=
 =?us-ascii?Q?Am9iVgA2ckyamlWjeuput4RaXEjkvpXnEtkAswDKfjUFDa3Z/sFLJkePXWwp?=
 =?us-ascii?Q?860Zf4ecIen+uz1mMyBHvA0VkPxiAXNX2T4a2RJQnpfqYdJdlVOxuxGrig7q?=
 =?us-ascii?Q?o1yZcfWH+Q5irL0V5tyXM21DQ/hfmH5FtqbPV0us?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df95a8d8-9356-40ce-782c-08db34123da0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:08:35.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmykFWAM+bdG+vjyzpJKi+joWAONDMX0km/E7yMgPpFLgveGqmfqWkPGoO/12o0QTP/Z8rQQRt4uN6v6wZ45fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9457
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 NIC, A55 and ARM PLL CLK.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 8e02859d8ce2..35a1f62053a5 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -199,6 +199,10 @@
 #define IMX93_CLK_MU1_B_GATE		194
 #define IMX93_CLK_MU2_A_GATE		195
 #define IMX93_CLK_MU2_B_GATE		196
-#define IMX93_CLK_END			197
+#define IMX93_CLK_NIC_AXI		197
+#define IMX93_CLK_ARM_PLL		198
+#define IMX93_CLK_A55_SEL		199
+#define IMX93_CLK_A55_CORE		200
+#define IMX93_CLK_END			201
 
 #endif
-- 
2.37.1

