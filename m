Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73088749C19
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGFMnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGFMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:43:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012B5171D;
        Thu,  6 Jul 2023 05:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEAPb7ynb5rH3lYdDc1OF9ArInsmpVkSDL+GHf09VGmBE3D16XajBshieffXFPzCQEHuIKV8e1IQsNLx2+3CvvHVhmgHFK40EDVVtSnu7V2sOHVkFb5fZM3roEnne1qh2hu51I5fr//Uav8z9dxIf1KmugUbif4X5UFJ2eUivXV/TCHrFdz/fyjriff1QbGDBdsZpf7ZL5eDpmW6g+ewdcLAe8TDkUQAhcv0BFYcZGc/4YB+CCbNV0JSUh4FLat0cdoFq6d3G4cU/BHpjjmdk9l/7seJC5upVIwSdCSMGuWjVw/l1a+g2XO+SMXrTJ+u6XmrTO1SXiorUGaXISOXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsBaBcCLU6Dj27gwHjzD8seU8IaFnv36frgHmn3O0BY=;
 b=G2HPFZwj9vykyap1s4J3jbangWyNnqzJ8sXt0HmM81KWn9CgtQZfWz5ANA8RYnwzRkWPhHWf+J5caTLN4vAKXqZhKD/gdiYteXYqWrkRpYZ9a97kxSbCjzlflJhtPTMWot76OYPN2r2jOdNvnUWyyOXX09HkhaAYNle21PWhyyoXILVityJQUlRfBGcH3we/4Ns5VKKNk35L7i0CAB+3hcpOP7pcN6mdptsRBXkFiibAcmRHtBX2O+H7wyhTnU1PuiNTGlBZ/uzwTSpWMsz1O+9W6AUoL7IFLFxjULeXsChmFYuovefdpGqZeEASWUZUjnPRSlELT2hTGzvLgVz0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsBaBcCLU6Dj27gwHjzD8seU8IaFnv36frgHmn3O0BY=;
 b=Cm/RN3Uye2tIbj0WjVj67WvGir1qMd/dsCPURhwF6yECwWZFSQN7WN+HZ5rGCRZaqM/9NsTYffXWfL1GumJ5mm2zigg89LsVfJcllZ72AKl4HM1bGC7kdGhCCoNn+PbUA99Gi9L8kHASKtYXvef2z9Pd45xx8opDbbVhBwsJXE+cOW95dhU/jDVb5UazUP+hyVcLPkkEqaQehaz6piZlu25zu8Ec+1+MuoGGuZPHUqYqhQNshWG8dLVVPXRk7y9ljW56QN8JRxKouhApEGAB5gxCUxDmcvcUtv3IO7QybSjHnJoGFuFJQdqUF/wXT8YFRofr8dg3zq0z50w9WuMQTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:42:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:42:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] ahci: tegra: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:42:34 +0800
Message-Id: <20230706124239.23366-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706124239.23366-1-frank.li@vivo.com>
References: <20230706124239.23366-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f332aa5-b760-4cf4-22fd-08db7e1e84e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: an4nptCVga+4uTgGrnfeZFDr1tZz/bxJycUwYo11/GuN4+x5cm4bI1nZfFs37DMzUcAUCLkSrCybGKq95FvHCWDzW9E2BcnHU2F/miaCUpnHNXPfSd7xGOvBWduwLSdhhJNs1LLJO0tOw4dg+yV5J22PQTDd4HGcrN4kbXu+BOfpVkmj1bblZlI6BLewwQGzxbJhhcM45ew3moBDpZWBbbI8ecG9MzIIvdM/rAoFrFT97540LQrIqcZFyQ+ylqZPPX25DiBZ2Mm7egN5JmCRUCPuVcSYNMbs0eGsJaRqwkNUjS84MSyLkGG+MhylhgCGEYbpcWFGBFtE02QbbCxWZ6Yzg1S9x7rggeZspzTRlRCzOWWM1foSNRNQ+88Iv61QhsQ0Cm80wgTIushKRVEQ2YlyRSLLiVm2rBXihAy8xyeqU3bBtEp41p9GO5NLKH3GStyVW4D1Y9DART4w89PDoD6S2hXY+0ql3zg8RNtbN5CNlVwuExFbOt1DWwegQFudESrYHdpXxbsZvWuZ7VIJoWrw8pqF99vS8hur7HMR+DfPIihekMLJMdpz+INxKAvFOUyB0ACaMIJPUQvpmRzlHKUzZuMpERxAvYpOtby6/G5DcX45n1+hC0WMK54TBB9t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(4744005)(5660300002)(41300700001)(8936002)(8676002)(2906002)(316002)(83380400001)(2616005)(66476007)(38100700002)(66556008)(66946007)(4326008)(38350700002)(6506007)(86362001)(186003)(1076003)(478600001)(26005)(110136005)(52116002)(6486002)(6512007)(6666004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?raj6jdD1fFCif8YkHV5BvaAHTJea8svQXL0qMxeerHk+XszrxKlc1qsQUm2V?=
 =?us-ascii?Q?PRnq/uLRMGk9P3O7HmUttg7DNiVQlKchZix1Ndb0zI5EeEYxnEGle2/I1dvI?=
 =?us-ascii?Q?CVDYda5faJos/e7+So+Y0ec8pmgcIfeHa0CLRRidJCtnYoetQDs2ttJl12Ol?=
 =?us-ascii?Q?pMyuP8hf4Jt9KHblwa2HAA8ZotU0+hSj6uTyzf37jmpeWkyC8WjXrFcawuCK?=
 =?us-ascii?Q?+MPi7y73ywA1RaLlkUzBnZ61wHauSSiwTVK7e4A6rF8vRzhhyVYvj7cjq5hD?=
 =?us-ascii?Q?xrglFV4iZX7jdl6f6up5yf7wntNTK5hhPAopZ/UeCVtUAXdWJcOl1CTCqYMD?=
 =?us-ascii?Q?kXv4pyhxTi1wIguh/+b8N1Q2Q/PUkJDuqrOEOnOgwffeD6j6BKlQ8EOmkPQp?=
 =?us-ascii?Q?2Nwlw0TIAnKTfjo+BHhncERitP6GPyqULOg3TGAp20s0Kj3zrqtBHEjFPNxW?=
 =?us-ascii?Q?CCCUQnsMzAiJQ+ZhhF6vqfjvY5Whw+QY2zdMI3Lm9yu38E7nK49XYWMrpguw?=
 =?us-ascii?Q?Sz45vc2crS0FqclwoxzEfgP40re76J3rr7j2rPLKvFb7kRF27p1JHH8M5Del?=
 =?us-ascii?Q?YTvqGu606Rx7fCeXuUz6fvbY3P6kKlKPdTkOn2mpnh4EW2tsw7GMnKo639vJ?=
 =?us-ascii?Q?mLQqNA9oz18OdpzcaqluQh9MlrDoCAQKuidPEuzN8WTxu3xvzuc6g+B3O+Zk?=
 =?us-ascii?Q?T3XdtgZpZLYl4XHnbNuD7tgn1G2VYBKvZL3ljnJOcpbMBcCqTTC2hhUDHm5b?=
 =?us-ascii?Q?IbF3820Qn4csFNHFnIMiTw8ZXHnZis6VzNb/snPeJM01h5lju0wFAI1wX0yR?=
 =?us-ascii?Q?yHxfYJJ8ki46yUU4K2yWz1BWGj8GKfoPE3X5f1I2iff9wLhH3GN4atiji+Rz?=
 =?us-ascii?Q?NH+Zh6C/0eU58zH2zA3NlyAdesniHT9BfjMGnZUVn69x8ZxrX1j+jeawBERQ?=
 =?us-ascii?Q?MIWFqwiJIFNKMIBqKe1adjtKC22kUqhvNvDPkfzECE0sPqCNkfQ7uKoGYxPg?=
 =?us-ascii?Q?eITuWoTP0RGuHQp81TqVEdkN+y4gORwskGDGuMn04EyYI3tlrR2ZAkvGtBea?=
 =?us-ascii?Q?lKojUfJE0ohhmRv/Q60Cbc5gwQjX5GFIs5TSQCSA4hJCP3DnaH/4IbxbGRrk?=
 =?us-ascii?Q?3/3SFi9V5id4LKSpg8QWfougJbjy84Ea0pUzT9jzs5ipWt03n2U+nwc/8Bqy?=
 =?us-ascii?Q?wwL2sM3XgdEd4Kp1niQyd57jXOssFkJQDwwSpHeDXaQkZ21kUzxNmZ1ST5HL?=
 =?us-ascii?Q?EtVks66Uh5qOwvjSX4nJdNz2naDl1V5Qijck0QH1YQAJOeQ/OW6+uKShQBJ5?=
 =?us-ascii?Q?xwJR7273qFKcjsD8RZ48m3CN5k5wPi2ob5Q8iuFQuHKpjTnJlI0iqX1S1ROm?=
 =?us-ascii?Q?jNTNyhWQy+rwYIxU7wzw2gPcnPflFZkhsVwdzD1Iz0osB1m3cqpHCM0PnVmr?=
 =?us-ascii?Q?pLx4bkm+T6Mp0iwNMq91qCVoiGCvRojtiUd44KjrSp2oXD4tJSGzNU0Ymoyv?=
 =?us-ascii?Q?Tr0rzAbjYzD4bP+X+TGARI6zf1uRjNXTiJ+rK+XKFPLYPUWjy0VLTRJqfWLf?=
 =?us-ascii?Q?4pNfyczY9Qe3faFOr0+4FzfRQ15vwi24hJksfl6g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f332aa5-b760-4cf4-22fd-08db7e1e84e3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:42:54.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: On5zjJfPEnrcnDW+D4KlQj9BsIIhy6ppzz9B11EHSOmWPcy/AJYQlh+OqRM0RZw591hOqMox15C8gUCITiJOAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/ahci_tegra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 21c20793e517..d1a35da7e824 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -530,8 +530,7 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	tegra->pdev = pdev;
 	tegra->soc = of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(tegra->sata_regs))
 		return PTR_ERR(tegra->sata_regs);
 
-- 
2.39.0

