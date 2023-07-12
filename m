Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC974FF50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGLGbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGLGaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:30:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B3213C;
        Tue, 11 Jul 2023 23:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxpFbsDcoLu9hA6RI8jFs2Xp/UBX6MAk8B+Mjr4gyC6WXyvnWrrW1RFg/aCJgtbacqfe1SP3kOYiZzQKXrrZTXNhrhW6eVmfaaqss+00mdG6LXmXo7o0s8muaHGA7XyVCg9Y2fCcCZzoS7MOaEseurV5FE+6tPkBHrhamWra5BA38dk5lJrG6l0LiBOYlT3t/hHOrVlVH66DDtufkjxHCCb3jf1zrdzMEv2/5789d0K8JNvus775a/zJL+lfkz06J9pVrvNKGrrq+uzCaVfiGb0R9fwmDv2EMrvPovInlW6MPgXzhBYSZ8ZtJBvepx+Sba0kFLiRgAyI6b3hSkoTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK7c8U7rWYHq9gw3kMiTCYQLfVUX1637X2xHaESdYLE=;
 b=b1gBIlBXKQ2g+KnEfgGQShvQJKtYsbV+yn/VMO7QzkmN2fNgKDONY9+SUJz2DwFeKMHr8MxQntEC94Q6Q31H8SNLO67asJRkGhuL8VHmnVo9B6XnQg3SWUqzu560bcDP2VVKBfb4LG2NGtcCFPcoSn3AJarSx63u32XoMt43NhBSoxxIbpMR9PdJ2oNnRkghDfyAQmOh5dZD+S2Pnu3SFMnPzCh6cvPp/7ALaEO/N25+G0FA0ugF9ZOkiy5oYkEx8acRcbbAmzqePqEnkYDqJHXnFjIv4lZmn2aiDGTb+4xgRxZdyVMb3HQ+FT6I5T7hctUGib1VxUSXuIq00eNJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK7c8U7rWYHq9gw3kMiTCYQLfVUX1637X2xHaESdYLE=;
 b=BHZ/MzBCaUJmH1w93NS7ta1WBtPwNL+SJYOVkk5vWQOLOoG+YsqBKVIIqmd0Ymxk8CCyd6H17lFKu2PXoqUZ/5xPNmmLZ8H5uinV0kD0XwaRzcJld/h2DQCHDbIlxKGdwyMX6x4EUbC3oZ1KCSWQwpZOsvPZtCudCUIt2U74iN8Yt7tiOLEyeCNwgSzpRnY+fez8NfUq2ZBbvnLN1Nfw3oeCTvmRrk849X5QL3MsJrz8wwFkSYreOtynyZ6oEg5zg2k6qXKOvd4FB8L2I43r2Blj8Edvn8yYmiST7R7dNIGqGJ8aj1PH9c5Cqc/yxwx+/solBMKvk99krI6/GAqqdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] serial: mps2-uart: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:47 +0800
Message-Id: <20230712062853.11007-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: cae0a071-8afa-4202-f06f-08db82a15627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2n94d0yeiv8Sv4AmLPWctXhHV7CwLOUbrjZOpWuNZZ/fwijeNojtSD+DynYvXZBODuHgUsToBdybjAuO210auwWBxzjgu3xNvf51SxYqwZ27DoKmwZBz5uCOGvFmKJHtCxpBDqPu6ncXKplT8bOrC3ew1niN+jbADduq+OHj2lWv1VH+ejnMf591bPCMkA45qv8Xr+ttG4t3lKKNLjgy1ySCBcTfo3Y0KUjmgFTPpxmXbyLLQIUDX/eLdGbzz+wfrN3UMzSPdZ2lZFRCCT2rYRD9xu5WdJ76dDRWbEHOsjWRh16CD3LOlk/GRybjBfsC3ZQrG/oux+EBdIiFHbfHdrkHhWCxYYDUkYtTBjMSvj9WwPrkNkQH8wg7nNMQb2icDWlwGksDvFmoxjabLNYRUnSBXdqTCk+jsKGla0hA+B6SCRR31PCI9F85vL7Kf3PFYuzLcbImo1qhoBZVIaiYvIZQEC2R7WmuxV6v9Z1Vn65Ldx3X2nCdMNeQRcjl0vlfBD68kTeQQMNnGNpi/PQfFMr6EybT41e8IawwIfPn6ai0/L5HFoW3Qbp6icvuqrXh23YYXgNV+nckOq6CcENIm2TmhpRZ9lLZCtcChagWWY1u+CPVH4A5g8Zre64IHKB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yh8NIS1nWsSNYLUyIo3ajwrSVIkZTyaikhXXCrUpoQ1x065Gj2o2CJiIwti7?=
 =?us-ascii?Q?aD1XY+4wPuRII/7DNNdXEyxBTOWJskWLwWTYoZyTjjj8w1EXV4AM7Yb/H5Qe?=
 =?us-ascii?Q?nQ8xzet/HmKboAOkJsCLDAzqbrnOuieHnP4u+EAn2ew1tU2R8JZFkwcF9Dgh?=
 =?us-ascii?Q?lT508rMvucvOPRt7dkBA55oedMKFl0hgNEu2SCOpokzyIafgaMUwWDPHEMMm?=
 =?us-ascii?Q?G7nhW+TwaPVkqDLye4hACmAh63jq9zKr7lZdd2TsJ+ZYMSlaNuI3UzmicxUU?=
 =?us-ascii?Q?2uBGjJIwDVbGSqoQJBcBphPEozqdg/DeWV+yJtYQNYa8M8ydCpQaGsChVrw6?=
 =?us-ascii?Q?tz/kPjp6LdQNjEGlxMOqwYftkVZC/Kwn9CgEXWG9WgUUks2DZy9NX168c6z/?=
 =?us-ascii?Q?8TbdFIBeTpxwW4W4jMwwpNoij/+Gi3Z+9PZ4oq2SxkdCLXdiALxM3vLFcimq?=
 =?us-ascii?Q?tPKiAVFSbOCLp9Yi2wsSfF2xNnJ0gInJHXOPX9ZpSIa/eYDNvisle1Pf4tc2?=
 =?us-ascii?Q?wGT12nS2Y4rlQH9b9qgWn4ydVNa9mL4BRE6NGbriC+KYgfqzAE28Qvlmw2uO?=
 =?us-ascii?Q?lYeF48fwHvHrtiICPGGWqVZg73IQ0FR6YpsuvgeHu22CrYyZ4QuefvtT3J/D?=
 =?us-ascii?Q?8zcrY9zFX2Yhu9kBm0OVt+suM3eL9dcHY5tMFekKHxRKHSHDcK9n1lpb4zEW?=
 =?us-ascii?Q?T+MnY7VH8WwgY2mG1qVi5Yk8HP8PrmhhanSnM0e4/M11JcE/jQPcldwykBDg?=
 =?us-ascii?Q?LMmEADwPAGbFVef7K+E7ADovVJeAmMNs6IENeW5B9n/yvy9DRLCSGodgLiTO?=
 =?us-ascii?Q?U3PLfHTXMwMZncV5PaThcKeb1VK0LX+pXiYT/0i34admIX+CqcbhcBOH8rBE?=
 =?us-ascii?Q?TTjRpM2lByPT56bjAjhUS2kysVHLLIhzEDtRrggkLDdfeV9LCv7+Q+2LmuqU?=
 =?us-ascii?Q?pURdbkhEVhdMzWDYO8uO4QWTRqnDedrMjbyMj9bfZtdLlHYDzLN/4pTp/2De?=
 =?us-ascii?Q?VNLrzOdUGj5dsy3/i7xASXyO9gik+QD1NbVjHQknSe7CSZ1cXCc/Sd0uAWST?=
 =?us-ascii?Q?+rN+Vpm7sMnDp62dXSJ7X5hbnzgxmUDWNeZcbay/Hy+04j8lMbax1vLrO6rP?=
 =?us-ascii?Q?9UuWhDRVYEUUpUNkO9LkkcUiX+bfeCHeFnjnUsdu94pS2unvNSVpK1a5vGha?=
 =?us-ascii?Q?wKD7BXYhdKsW2wfkc7CGtK4UUq3EucZlkmoKotZC3bnwvSjJB9ifSdqrxUCu?=
 =?us-ascii?Q?C8KFsupU0Fbr6fV6hkNKWQsggHPW+S5Thsnu5tEH3flFN/gydTPfQtiHx7QU?=
 =?us-ascii?Q?VafImvPtviDdaiMG5x0WMD1DzmeEMcVZ4nZuigaifZbRxwxBspRXjy/k+MZ5?=
 =?us-ascii?Q?S4Qa0fFQ2aH67EUlqyIWfIfBUPZwnz7miskV07OvVUda6MVavlfuCv0S8h8d?=
 =?us-ascii?Q?zgNjDjoH+91OqrfGUL3mqnOgTSUGQkZJw7bICpyW04KMxFHrwLwGDwWda8Q4?=
 =?us-ascii?Q?PW1+x9kdlTXOGp3x/PRST9whhm0zJXtWOpCfGFS/0QQotZ1896Q+lH2u5Vzl?=
 =?us-ascii?Q?6MrY9qFbNMfHRtX5fEQkdirMdyz4kcch+tbig3tS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae0a071-8afa-4202-f06f-08db82a15627
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:25.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntBr9e9jVL9ZMt1f3b+iGO8+Grrei1dQONMH4eOVahStlieWbQyJZO60sS3UB+IgqRdh3O+GFgwXMyg3D67WhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/tty/serial/mps2-uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 860d161fa594..8ca62e7b7ab6 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -539,8 +539,7 @@ static int mps2_init_port(struct platform_device *pdev,
 	struct resource *res;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mps_port->port.membase = devm_ioremap_resource(&pdev->dev, res);
+	mps_port->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(mps_port->port.membase))
 		return PTR_ERR(mps_port->port.membase);
 
-- 
2.39.0

