Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2336A53FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjB1H7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjB1H7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:59:20 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7081E1C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muVK/67vHxU3rVWDjgUzGztjxSQMbm49EG/FlpITIx/WxGtltlGGh/LCrsot1vxOpMdOS8SxNvV930Yvro48m1q8EkxRcg4vAa2v0BXRYZPa+i4Vy5MA6ddraexgym5J9fJTG0FBlAd4T82jwVCrANUAXYp+JRrWBWO1C7RY0pOPtrZ153QlTwPKPUI2NLBOIn5cMboPjRS1DG7LioydYGFpe5m4EDgDA8PCEVf48LKbkVSCL+PIOhPtb57+fJs4wtQHJW5f2lY3fTebi9FDCbusEYxTPthPlR0d2w2JSFXgUmuACjOc1mttmB2/2ZaPHwRUgIpfbGno1dobQkfssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7nL3LImwhUeAzBKgTqzrf+WPZYDrSI+f+75y1+XHz0=;
 b=FIqnoEOXSJISnYIxoDqrgwBBNgIQVPbSAirOg+9WKjJ9vFJx6+2lcVOl36R3h5PK8s18v6A1w11uZGEGfOePNMGDBIZcIzM3BdcPmynez+m8nyWxCp/l7KZsHQOo8vLQUL6lmPIwQKwUoxjs7LJHa5AMVW9bC+VTisE18SQ0mgNiDnzangd3Mh7YkQmLReI8/Zaw8Y4jmXB07sspwMKuiJ31QxzELPYEYqlQIQTiKCYavKa/eKx/wwaQNr/06kM764/afJouPZqpGJPz9/Pni4nkW57TVm0rrriH2V79es/jxdZVhpWJ4RIxE+U4jFD4e8SYO4heI3HIgj829Su/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7nL3LImwhUeAzBKgTqzrf+WPZYDrSI+f+75y1+XHz0=;
 b=VL8syZCQwTqBOyW1Wk181pn5yiSdXjbha+JAjqIlBk6zdWwkpmWKv8JjOEWnL/ukP8RE6v0thMXb2symFJhuP95SX1yQY9OPApGfZhKPbn8p/qXNg25bth1S/iRvFaozITkv2a+m2Wb/69/AfaUc6mG3AJGmou4Qc30gLQZbAeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 07:59:14 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 07:59:14 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH 3/6] soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
Date:   Tue, 28 Feb 2023 16:05:29 +0800
Message-Id: <20230228080529.412669-4-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230228080529.412669-1-jindong.yue@nxp.com>
References: <20230228080529.412669-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 41092907-7556-47b6-a64d-08db1961aefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/nW47iM+gEoi3xqaZzMVf2JiKVJemZJYtR0EGmEOGFQ4yHgvNvF87RcBt1WNmiPHZPGA5ilLKm64C4/ANXtogqQYKr0aHT1WottJ+vMf75SrDAEzd2hNIQQpufLBBv/9nHWhxXotISFYbgTHWrekit0KmZXfi5Hnu4IT2oFD6i0dMaKE/+Nms5FX0chYxvehoCaBDaERevkhSUfy99sYa9Wj1Ld/PfpGOru2sX21rGvAzkIcqLlaGdczZ3KIP/vGHr2gy3EWhasXkFW0O/XDZyMt8AC2bvDXk3r9RVgf3g7h540Cy/765ZbuQNiP5kjCKSH2CkLoBfjuMJyfSYgaSeSSOmRvUtVe7fMS9GQ3myeK+bgznzc+Y/+D0bm+qNcjk5q3Bcv692gBXgpoVLt+oVm/BtsC4ylk9WLlscjEABO6m3jOHNEiSxDa51Np/o6IjR/s8Q9vQ0d0r4Km27fV3afG46H0lYg7Hn1EzNLRdIHl5NGNYlX71zNEfcZV5Kmq8aS/kMX4K3vkrqSiv9uJxYr4BY3eEIRPIOz/b2rSS783Q8T3oIXiqtwJxc2eVf9FMapy++8J5r+YX4NDc8IOPGhLXVyBc+S7ddIp/3OazaZdcevl0yAo+GuSC0WVR0iav/4uIiCZATMK9S3uiDKeahXxoOl0Zqbwx9xoqtj0LKoA0ONvJ7xtrrm5ELXnrqvuFFuCdrhEYIDfv1ZO4mo9jnGMxM2GRGhDbxHyPuIY3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199018)(316002)(36756003)(4326008)(8676002)(38100700002)(38350700002)(2906002)(6512007)(6506007)(1076003)(2616005)(478600001)(186003)(26005)(52116002)(6486002)(6666004)(5660300002)(66476007)(44832011)(66946007)(66556008)(4744005)(8936002)(86362001)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sqrqBKnSJVoc0y3Ekm4dXX3Stv8usAHh+iKBmPi52MR8gvb41QIKkM6wvQfO?=
 =?us-ascii?Q?1MDkUVSPED6DJjNLZiI9N4RQFdDay7HWlZ6cXi1XDrTOZiLu1NJeJ8GxmZ/B?=
 =?us-ascii?Q?Qwp60rPtzJteAf4WFR53IZ3tQR8EREf1L6m1iobTo5w3EnIqJIBP9bK35AKV?=
 =?us-ascii?Q?7lXCswYU8IRsVSD3G+Uf7wH4ErEHhzWDUWKkllEajfD9Eyo4KqXcG4wVXUhQ?=
 =?us-ascii?Q?JQCnMXjRTDCKXRDAo5oV+6FoQae8iT83Mjt6IUcmguiThQrE8VSf8q36xBwO?=
 =?us-ascii?Q?KQD2IgHy1YCmUEyr6NizekbTO10R3yFpizinNbMU2YOtUQ+9hK/UlRpd/Z8o?=
 =?us-ascii?Q?4RZH4xbxJ7NXtrSmdnCnDZMfdxRONxFV7mmCRugut8ecFK7wBNRA//BlICUw?=
 =?us-ascii?Q?/CgeyJzlwI0oSjaKPmf0VvPnYWp9T7tCPnn2uEIxlcCiasBN3GclnQ5X1j62?=
 =?us-ascii?Q?3hsR1uJrI+Q6LAzGNkl4Wg+Tzbr+sF8qeJx3mL2vAUWycKVmp48UippC/bNZ?=
 =?us-ascii?Q?Qw1Ejq3/fo5I432l8h24zBpXEUsxA0xbf4tEfEXUcodq894h0IWj9qkPr5lo?=
 =?us-ascii?Q?wcQNx+Ac4/S0/7+TjVNjaDvV5B5qbntNzhtR/bDQCfj2LzNZOILSkH59UWYX?=
 =?us-ascii?Q?G8r06cO0iVzFXNkjkqvYXx4laQZH71t+J3EjeWLSlnc3yS/kkIA52wzTOsJv?=
 =?us-ascii?Q?73H25G9T0aUPyjUXe5WtBFJdRchMszM9SxhxxmUqsJkAoUYS0J1wgIFYcWbi?=
 =?us-ascii?Q?ve91bNytTFKevHrEl0DrsjsZQjj/OB9ycMGNsJQGLILDRCN/YJbMkU7fdcqi?=
 =?us-ascii?Q?K0CWTuB9g5VHylsScbDu6sNMY5QovIxoaP471mOF+wcsjlqje+yBK3C2N82N?=
 =?us-ascii?Q?ELd/pbksuOkwxWpsLG2+Lava81KcQjtTZ2pKQELtnrRCe0fKKbiM2Rn3zA2F?=
 =?us-ascii?Q?fP73HPuXVwy1zHg2mx5fpaD3YSza+kdT6fZHSOvUqAxqw4kJ/e6Qo0lpmS7f?=
 =?us-ascii?Q?S2UtVqjwAT4SIFhpqxlFqy8CJvyk6i9EI11EMbKfZ1vH/Cat8c/q+/M9BTXm?=
 =?us-ascii?Q?f5bNXLpGc+l0GNeYwXlmMnuv8Gp9K7Rkj0W9OYnbF3uYBHZGOt3NU5h6oq2a?=
 =?us-ascii?Q?XqC2dZ+AvIPK+NZw8Cjrhc4QIP7NCG1ZLcabjdGz2WDC1jFAu9xpDUUe9Jeh?=
 =?us-ascii?Q?wgRqPD1frYABwolrqhVlryTd2uOio7siQ3j6afvJeO5f6HgCStwK4Ly6ZsNt?=
 =?us-ascii?Q?94Z/fuD72vBkOOmpyVCTAGwK42UTjsDJi949tT+kVNhuK+7P8ojK8O8hqqKt?=
 =?us-ascii?Q?XKuN5hLLJDBeIgs3wMjsC4X2g+SqwGxtS0cQqZE+a4vyA+juLnVpvwpFsStG?=
 =?us-ascii?Q?JG8Y+xp1F1JZOyT8aEXeOGgu8EbrwM5lHf8eQ9NRJQm1e6OXhuHURG/O20xa?=
 =?us-ascii?Q?K7j+ZNqOl0O8MyHoIvS+2LFLt2R/w1LrjRoVZ1e4mC4I8WlgOEQyFV5UGxFB?=
 =?us-ascii?Q?e2N0DfQWC+JHKTO785Oyqq9EGMQqBsLypxFtbUPYx0D9Zd50Ecb+q3WE66Aw?=
 =?us-ascii?Q?nhVo8oQw/srpsHFCwz5HI7b+tDXWSZ506ESiPPc9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41092907-7556-47b6-a64d-08db1961aefd
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 07:59:14.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewu48lk1sFEW3L12QDWcgthun7e4HedAfypftniaygxUwSnnVq0DAbIHYYvwkNcAXNJT+xpVEQbpo8xTJSG/uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as a module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index ddcf6be3d8b4..0fa342e9cfff 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -876,3 +876,4 @@ static struct platform_driver imx8m_blk_ctrl_driver = {
 	},
 };
 module_platform_driver(imx8m_blk_ctrl_driver);
+MODULE_LICENSE("GPL");
-- 
2.36.0

