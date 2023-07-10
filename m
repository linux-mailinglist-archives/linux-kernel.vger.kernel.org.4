Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8674CA0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGJCrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGJCri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:47:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B239E48;
        Sun,  9 Jul 2023 19:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEaHVHxxxmNBr9ONKUqTr65+y0rVjdRJE2/2r07fK/6D2kSV4TmLPzZiaNbylFIr71lFOx6c1uGGFKl8yT+2lOengRw2u+ga2cPozjMT1lQI3SfMCVumgbMhuaZNJx4w3LCC3AbXsY2OxL2bGoGB/J//NXT0C+uwVmW15SvTDeTN3rnVbIOJds/0xiE9cRqmtG6Xhfsd/Fg3NAQuyTvBXyTzFPPdmao/kWCZqE8mk/R1jbLWEpDusAVP+yDMe8yqIJxSLWDgCg8jr2liSpY6+C9uOfYm+VtA04UzEl2qjuG0mu8unZZPsjtkE1mLC4KzDEmdcUAECmz4f8XjyKKJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I/mwc09ffvaDEMugdzolQ1SUKOTSVAVCt8sK8ABcJk=;
 b=oVZ61gKBCZ9BSKV+P6huiCkP/GWItxPgpC7Ap3tBPCl8uOejLE1vQ2XwnlQp/AO27r0gJDHoI+w5TqrjHG2KU+E+GYLjzU0f1LfHSwsRHzhIWe5Ox3/ddy5RQ9GNm6nqffeL0EX7Vy4W8l0Vqpy6PCJxTRa1KB1Iy6PNjDnIzxDEYpGz80KpqjPajeMVk9DX169Q80xzHNogb7PVD79JbUx7SvTV5VTj0fDr6EKIqvPb6QdyYhxHxjKIcF4Hw5keoImeqY02G8yCSjenvbkhhOguCh0rqRxNw9Gm6Lw6K+9p8sLON9moTa8/667QYfJPQwMY3BI7x6m3t94i2WbFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I/mwc09ffvaDEMugdzolQ1SUKOTSVAVCt8sK8ABcJk=;
 b=Yj6BTk7jO4UUZ1SBwrjqa0jSE/4T/N1l39zppIoGwsJdE0/MFiwrtFZTqOxIvPvVWqL5hUsd0C8kwgZh9hr8n0QS/alXZ1BeXSnAbNT31Ur40kOfXQBYJU/XQ6JA5m1vUPliiiwlHzrd/T+YVaIQBAcQM0RwAcDK2OzTZbogaiiMUAM36ue/PopvPkfY3+ga1jcFsL+l5IjEdfm1OpZBG198Bnmfej60gWtuONMROAb4bNVdL3k8fRGzJJUEleQ7KRhJhEOt1gXbJ/BlnW9jFPiTE8Ao2eD/nSZOsnN+B2W+Gi0gS8x4sA3bG04l7B0eVkICbdMlJlmBtu5DguutAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4273.apcprd06.prod.outlook.com (2603:1096:820:64::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] ata: pata_ftide010: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 10 Jul 2023 10:45:49 +0800
Message-Id: <20230710024550.59544-10-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710024550.59544-1-frank.li@vivo.com>
References: <20230710024550.59544-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: b57c2a51-70c6-4482-7900-08db80efd8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hw/MPZGwlIIcRyUm6jVw4j2JV7wBl9z+FD5fadjQyn9x8iGUs27zsrIML5y+RLjNv0vtfgyI3hY/Sw41uNE0esxrhB3zZoSIUwKOOlS8Sm6nb6yOL8/uLg7G/lMI5r0/3rkoswVXW4aVOZW1gZ0L9U8SZuxNYJln/Ae6vncR7t4Iw8/ngM+w1a7OHpg9rpRSS4CogYs1JQgzzZSZ5bYXq7COEevTcVT5MrYDqN1zXJGnI2XNmOkbXpeyPzILaAQeEeSotJx3bCSodKWEHwq3Bq3FfTETmB+wBImmQ9Hjx0jUzkEVKzVkrnMQyeX6wFLnxnH9mwHAxwZcQZNY353TWKvyD5/uUAgYcb9RtYxbvYl58Ke68109/jX+NJXk6EPjG2bcxT7GI5ydCu9UNiIe74MH9FZor4kQ6rT4URVsyF+11ynVk7/w4GL2uh3LI6G60KuH50BWUSAV7yhmhvlzbgIIWTBozJo6znb03OViy0Emygv0IOQjUPOI+q+LbD6NHMZgKzWnBsFZvkP5nXttGF+DrkHqaJUza3TRVFbF18cP/3HIEYBXAS3x85pl1VUcrkvqXQghPBtd2ofKUNGZk34CSy83B48+jJC8RSSsTaWcTSHi/flOIFvMwIze5xoO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzKzTxcF7ttAOrcdvphLDBIMcYvX48+ZeRl8FDLPEfW8/qYi42+Ptfcjhe+y?=
 =?us-ascii?Q?q56WTZhLoW1AHRktsIXxpH6rLcZn4LON0RpuHztJ5a/cwP9WLr6a5lfTI15y?=
 =?us-ascii?Q?KFyDAH6E8A70oY0Mrt6f/WQG3t3Tgt6vm/rL0FbxYOcKBL91rAhMfHKF3HIf?=
 =?us-ascii?Q?0UajHGEMO0VQqhoz05HUqcjs7HKWSINsw5AuzwHR5KxAdgcLu5bob8ZK+P9y?=
 =?us-ascii?Q?Umcd2w4kXXSxf90WnA3nX0TEM2VU2xT8J5LsNuJbM5sm684pyO5PjfJR3FUO?=
 =?us-ascii?Q?0l6T+EgURU8smUnSbDuCyfujP/a9uqoortFS3PP8pEBLQO8Ju+iLMN5HcXjf?=
 =?us-ascii?Q?Gf3nfKy5QXlOPA1rgFzA5Y167UDizVOV5QSYwiAl1etAKj8O8JTzgo49BN4f?=
 =?us-ascii?Q?/u/cbvuyP762Bsw5rPjer2LedCwrfnoPW/9NZ6+lbSRkmYuPUQqxm22ZmPjr?=
 =?us-ascii?Q?/1LQ4aH5K9qNRLfmvtGiX8T9Wwqf1V3P/aqhAWj049Q44fY0IXEcQK0mYUuw?=
 =?us-ascii?Q?8Rgc7FkVNIj7vv4zzgzGJFZY6Dp+/Mw6K7AHBl8qy09IKcZMppRqILB/iq7f?=
 =?us-ascii?Q?HQ+HgLdJa4RwV5BoUyi0DFy9osswe3op4bOHiyrwotNA1vlNayS5R0cU9ecc?=
 =?us-ascii?Q?64/oJ8JAlaeHNCGsAjBf/67DWwiW7W5N7mbdTCznpKfFx1w5W9XfEhf1smGJ?=
 =?us-ascii?Q?8od0Iuf0zOsDJ8NU1v1OzCbvmgvNsr9hIlsK6iAlBlMFY159skxZRb8D0edp?=
 =?us-ascii?Q?Gsb5NY5ff2/pkSijnyTUiEpu4TBsPXFuMNAtqbu5yiVSUbQzPOrqheD4UFF1?=
 =?us-ascii?Q?UC8nfhJ3m2VtIOAGUrIX380imcHWWvzY+H77+wvw+aJToqUhSVgCqKlQpng1?=
 =?us-ascii?Q?l3yUP1ZRuQN2pNZVe1ZJPQ6AN2q8frQX9duveNHbGxnYAJi9GbhDLSD+YR6y?=
 =?us-ascii?Q?v6LvFp0sa4aBk4qvjqytwxfnd3g3q6e+8AQuR0J+tSM78X5OzSY3cAC5ZWl+?=
 =?us-ascii?Q?f2bs43N5bgFbdgOG2iMGp69sJqdWkeZbgAnB8wR46+COzSzzJB23LNEdvfTr?=
 =?us-ascii?Q?JbNfUhgNAGbvktkbZySedLIcAMd8OK5eCZ4rIG3x8E1az+JA0+7WeJs/bphg?=
 =?us-ascii?Q?S/bn7dDIsX1vMrjCb7rMIJrk3BtM3HjDbCXRB7YXzsM/zwOQO2X8IyyZlEZn?=
 =?us-ascii?Q?HLXM7EeOSYfzX9B9RtAqyfuxwzrAA2yFhzkx3PUK14P6TEusLn0QCV5iuh5k?=
 =?us-ascii?Q?xc9TJT2rVQRQI8TUtHQMUPGltNIGf2UQfn86TLDGxaW8nMiIw2DMN2dy6gM6?=
 =?us-ascii?Q?PeCkaPt+pAZBF5dtIZJt+9Dl7lme5mkUNhzoELO/R5W9mHnGBjNXW1Ai/WfP?=
 =?us-ascii?Q?5eNyvTKSHtSQejqZu3hQ4FyG9TtEfYSVihphb0Al3A3s1F3gnQmk8tJWOC48?=
 =?us-ascii?Q?V5ffoeoeb244Gc3CGVMrVNFTQmNMlTQUGjluFiJjIIj2A2U4kBStsshESc6u?=
 =?us-ascii?Q?cz35/Q6E3Zy97/6AoZvAYuu08YVgubqRYDf7uEaC5OXnm8lD4oPF1gRBmqL1?=
 =?us-ascii?Q?pAjLPIZBhkgZZ1WlHNB50aq6vIMXlg2pubDCrbAK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57c2a51-70c6-4482-7900-08db80efd8f5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:23.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MwSnWeMNi8lvcjG28nuAKgPsj3rY/ybTRhOozHg2oHfRu1g4fLtL+8P3DqgEjBUGtskldJ17MRc8A82u63P2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_ftide010.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 6f6734c09b11..c6f60f1a908f 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -470,11 +470,7 @@ static int pata_ftide010_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	ftide->base = devm_ioremap_resource(dev, res);
+	ftide->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ftide->base))
 		return PTR_ERR(ftide->base);
 
-- 
2.39.0

