Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE16C2D00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjCUIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCUIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FB9460B7;
        Tue, 21 Mar 2023 01:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYuWfS67JpX27+iNzIQJEaFYwKWoLKhZZbafg6w3DJM11dOxJviRvSJbINZv8dgelMTdyvR37NSZqI02rNRk4MHCm3+Ohtv6/q4j20kgnJgq5XocJYUUDDK6UqwszxS40Zr1cereEVKHQBIZ4ievVh6KtfAeYVw5OjCBgapCcwCffKYZMPS/c478ujD9QhzTFPoZVlfbOkcizzu8zIjcfCSUeUl7/0xJ/ERpm3CFNKabVFY5dy7p6Hi686/xclwEeqCHgxY2Dcll0TjrtR+2PmC7iPlnZyoR7J3/m7duAAe08rbguXmO2qTJ66N/KcfCld75L+cowiw+nkHITrZ1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Fy2pN1g1M1oJNPstkmDXn6kyCILSwdUxugTz3Lonpk=;
 b=j2O2jbZ86YTjwGax1QL1wP/7Rje//w4azgIE++InnkHCCS/6xN0DxX19lo1C/Dc1diEE0Pe+b/ZjW/0omOiMdLJ8Pj0j8ikrDg0r6XJf2/sx0DLuYZpMSugPW2YT4baMLrtUliCFM5IO4qYKw7aNKdkz+QWiicojtKT77CFw05YB1ICTITNKWciQSz//i7dpDF5I9LFpWlN/g5gHmlyLRmN5jAAes+M/B9CcieVDegpVnaqiT3/ZqQe1uO6rSrL2FFzvXWORxdXOBrAUt9GFjtuyMQgzC8jyuTtaOH7vr+j8iTOYXUN/C++de2l6oslvO9vfpFUdrfOKCEpj9J8c5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fy2pN1g1M1oJNPstkmDXn6kyCILSwdUxugTz3Lonpk=;
 b=l5pdTxx8eAwUKwkp2rEZz3JI+61xeYwAkK42iCD6HqOvzZHWAH2HEej8yRfEAgB6OGg/scBR4d9Lc6I37LtZoir5sQVeg4GA261+gcieJgO1EwGX/0D+NWSpHKxQz30Nj5f49uL5vgeF92PklOJfgAukN+LncF6IS8JDgNq2DhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V6 03/10] dt-bindings: usb: usb-nop-xceiv: add power-domains property
Date:   Tue, 21 Mar 2023 16:52:06 +0800
Message-Id: <20230321085213.1624216-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8670db-283b-4fe9-c923-08db29e8e513
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVtuUvbjPo54vTdIlN+MWtbmAfsRzOni5yUGkr3doaz4/vh0WT0a6XGas+MOQZDaQiC3t6t/1zjg02F8yw/21TPZEapdNYU2YCzHYTgd/GRkFaXN6TUMMkMXEJtLXnrKqpQYFN7ktYDSgvWI4qGRoxo+ZDwr5aCDp/nPjjxnAOhgSPDOFF2RyX5OB9p6y6ZVTg67LzWmf1NbGcpw67tOdS5R2qzDRdx/JlKFvwELIJkWTCIOIBXqQMf8RuSFYH9a98j8GDsDvU0GHQTnHw9wKagxZRWEXm2JgaXKDrT3Sdp1Dbwcx0/TKDKwBmhb/ZULU2dqWZ4yMQ/MNlTA5zlGexq+gkixo2Ax5E1bgcbU7DQUh/R+XHMqO+TxcIEZFxVJBJ1gX+BM66Xa50Y07u+2YxX6EOZRPT7Ap6jWA5qBut4OQRxgzNdn+P7E2KufXmjGHUvTAf2/YROz1T//l3Qxk4lxMzmcaq1cGEPWb3v1p0vg1z19GeOQxAC9/wAFBZ3EBOAPdHFbwgtlHLv4d8GGG2F0qehV6gebEADySsg5dqkL1CRNVD5EMeAHnbckVtcMI1iKpkRkae6JMQCbg2ULGMZb2qoVKTXmZpULjP7FKzE2F5brD5I6BR+bptZMBbW+Zh1I/OxoV4LvXB5wSpY+KQQiCbMg3OprOHBds3UKXTQwaa5eivm5tMnElqzjpbgN2Q2IxMBY8+aFqXudHotQMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(2616005)(6666004)(6486002)(6512007)(186003)(26005)(6506007)(1076003)(52116002)(38350700002)(38100700002)(478600001)(2906002)(86362001)(66946007)(316002)(54906003)(4744005)(7416002)(8676002)(4326008)(5660300002)(8936002)(41300700001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9AjtltWyMnVj5sgzy/jj747YB/Q2VwhRrWFFJUKbo1ssnLN4CWj3Yez8SJ0?=
 =?us-ascii?Q?tgmoI6T4AYNjNcby58Ctslhh5zmadZ+yTVdNzzD7EDbBuNZ+t+h5JjXlrzbU?=
 =?us-ascii?Q?+1yr8zlIFkCADXEky/iuItStIybmqpmgBK7U+bbO1IvyYzSVEBsPraoXY8W7?=
 =?us-ascii?Q?ClC3Vu8pWQFDppzmcrLptd0IXrqzr31z5rdvxiPsMDFsGkr/ejxbWzzIo95R?=
 =?us-ascii?Q?xCLSNTQq1JKlLF1588hYHYwA6e/7f3rRU3/5ZhTPVN/gYe8nDA4ru71VkMSZ?=
 =?us-ascii?Q?xfppz05SMhYwrcwPbmQpNTgIa77uxli1v6YUtwp8AgP/Oc2ZhOXOguilROyV?=
 =?us-ascii?Q?PEUiXheBbqN4nE2fYv8qIFNNtwGC/+y15U2pZCpFnJ2gTndYin0RJLoYeWhH?=
 =?us-ascii?Q?w/d3lwPEi83a/uuPCCp76Omlg9R9k/oCd62QiCm9FR3wxRhYZUr6vxY0OlAd?=
 =?us-ascii?Q?EQ3vHUV4BWR6ArUL9YMP+J5zcVmDQlIi2eQFTw4YpeGd9AQ4e6tk455LJ4jK?=
 =?us-ascii?Q?HKhVTKtsGLX7TKjMVxg4KVxFr6HyHbJ50uMRB4lIcEQuAbslIUatK9O+HbD/?=
 =?us-ascii?Q?5f1waUIP5H8w6sRbojj8knyHB3R4ab/4RKrueQ+R+6BzrVhdR2JOa7fhmlla?=
 =?us-ascii?Q?iwIH6myWSrMOgRfce0qP6LWojpBH6rh6pbd5079DDltsHse77xudF6ez8BvH?=
 =?us-ascii?Q?zLl6RuQf5SNu7kJWjspp+MhXrvwG/93VdcSF+oltvTGE2uivJ8KKGAvhkTXt?=
 =?us-ascii?Q?ZEXYvBErROfqvVAKuhu9uvzChrUhBzBqQqx8jx/xPVwuWoYUAY2qt4eaR+/n?=
 =?us-ascii?Q?LbY842HalqDCyVVS45fo3koZeZlUf3zFw6kBbqH70NRYwliGQocuEKnEQfEO?=
 =?us-ascii?Q?gyDYoOmvfrJAAwbo7g1E0NIf9lZtWxLejr/a3p23W4Rta/BhT6xS3ZNthRgd?=
 =?us-ascii?Q?QmSV5JxcZStKFGZ11yYXTlYK4Ha6JbmvRrDT9w+xoRkRQjRNMzBbfTbFdQGO?=
 =?us-ascii?Q?hsbGNClmFoKDAQKFwepejgAkQXn0I13HTPiT7lNAI4jSK/QSyOPGiQFbsw85?=
 =?us-ascii?Q?c6vbJOIUglzMeR1CVHNrfTkVxEbZuTVYfx6xQ+cT+4Aoc4j8785R9E5c87Y9?=
 =?us-ascii?Q?f5oS1mm+ZRcLedKXUCl3GGqcqso+69polNWCOuRZfqstPYHKtaXRMq5dJmgW?=
 =?us-ascii?Q?Y7v3iwQ9bt/sgtg+PXf7G2pHfmcnZh83jPogH6dtR3SG1zLSJ/v2KUhmxzv4?=
 =?us-ascii?Q?nUX48P8UUAyfwqz4JGUdacBwazNnRhQ7XKIMOzkhSpwU5zK5Si64+AAiEIrU?=
 =?us-ascii?Q?dSPZCSwJ8/mQiBHku1B/5tLTY5skTfXm95T6DCtu4CsG+nxiRZ3Q2W4OUk6Q?=
 =?us-ascii?Q?HL6/KgxP82xGLsE8/HHrAaueTIMrRPIP2luKRYolrMg13ml9Ab1j9Rd0SnvK?=
 =?us-ascii?Q?tDpBKiC2W3YVp2AJKPElmeV6Ee30IgY7BMgQ6FicdQxbQgsGyTSJWzOKVCiZ?=
 =?us-ascii?Q?QNWRHTFCI4J3kE3SXp3y8uMR7Hyl6ZU7NUehqHbacj/hcbTExGKoSGjtSicT?=
 =?us-ascii?Q?HZfAWgjg6nury4TxY/6pBT82XuHn+nWHHJIu2OiZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8670db-283b-4fe9-c923-08db29e8e513
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:25.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6F/47JtvARY9kdKhLlY/HBdAX9QX5e3drgtqFOTOIBQatsuUXsDFr1n+XgWvdZWOwsk7nNGT+snWt5iI9KfVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add power-domains optional property

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
index 921b986adc47..6734f4d3aa78 100644
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
@@ -27,6 +27,9 @@ properties:
   vcc-supply:
     description: phandle to the regulator that provides power to the PHY.
 
+  power-domains:
+    maxItems: 1
+
   reset-gpios:
     maxItems: 1
 
-- 
2.37.1

