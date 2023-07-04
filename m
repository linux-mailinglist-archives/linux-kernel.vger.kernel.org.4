Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9B746E06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGDJ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjGDJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:56:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B704CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE6kCOqrzodY8dlD9siKVIBNN/f6YzjBZNbLn/XboCco9L5fewePJLEVO2/wMQJDsrT2UlIwm4NS/tDcn/SxxUTXal5R7Kp4lDzAfb+VtppEJPAkiqhnWpLR8p6/thAEx+xgcNlzfcPUfkS19Dd5A8Rfof6JfU52HOKnU13bK7hQPZR/AETq37JwpWhJyoAxZkW3Z3oKp5L3vx3/sa+EyzWBJwatcMQ1BYXfxkIz0uXrAoR4E1zHJ1USPVjJ2RepgWAReA8iqgHAs1tmZwKJGDXTjzeeZFpX3sRHNLPCZomTOHJDTtvfkxuNqNC0SQdu9YsupyzwRl2Ea2Jfhk/gVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SarSRGBEYnoGJT7x3BvGrkEtGT19Z7rJn+uy4YlL89Y=;
 b=k8FLqE1eEV6kYD8hY6af1oE9eM+3lBCCZ64xX2yi49gBqNWkfU4mbmyqSkHCCL0liImG8xNAHTiovlzygH9s1JmLPhp1/hxWzfBlga5DSftiyqB67KF+1DtExg6JPj8aMAXhvz+ZcfdZivPlOxhcEbQe5buFTekDVkJRb8EBbKzfq0WyCHCzxup/1hTKTEDsGziqX5SdxS1kPzH778PyKLfWLT5baPY7jIqWklIfzlYN+82yuy6dhu8IYSqJCgRJ8FdvEDbZEQjmm2Nwah4yCmak/gObQcwa+6cYx/AQWFB+4x0pEEN4hJaPeQk1Id8W1KxtOC9NrltUSn8B7ObY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SarSRGBEYnoGJT7x3BvGrkEtGT19Z7rJn+uy4YlL89Y=;
 b=OrCFihxuGJ2I8pJLh5RAsUlGZn0ruEuybxiosF1sfbByeYKaEGtKLMyjXRvC+6Fi3K0EMazgRuImGTORzR82+Dya7N3/N+HzXD2acd4x+kY+G/8lQ/xR/cnkGVcZx2FBaO1/nvfvrE03DvM5MIU0ar04kAKXtVa/UyXlPG0qn+z7pMI21P3f+EY5TRUkyYAZyvPlKM5owpCLICC+Lg9fWNuA9khIKPScx+u6yQ0Bwna28rFut1blIqryMaiMthDEQtfd3BybdRRg/ZbwoBe9EHkmJp3qlncZ8LUzPkxMcTZlOX7MfhvK7cWIw70/jBOTfqxqBLaevzwMKtuWP6YDeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4240.apcprd06.prod.outlook.com (2603:1096:400:65::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:55:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:55:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 17:55:43 +0800
Message-Id: <20230704095543.32812-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: dab97e07-3626-4a50-b592-08db7c74dd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JF/G5gKpj9Jhcv5izpT/zpdOsBe/FvEPya+F5jEOj6ri2YneZFPs+6Q/B/uA7i2p2PiQ5F1bg/CibYJyjMwBvdKd8oX/B9bSATMD6NQ2FCj1TkmbBKVRbkyrfNNDW7MGtZCBUDkGwGPdXvyBoY6SEG/MP+2FZL5wizAHyTbXd3FIupaayU/BhuXhkwNtdvxSIyK/ZWozJXUNyu21M1MmoseLfECxRkSj+eKK/ZgHRxU6BfhnQ/O2dWmSYt9uSr41QFD47QAPiztcccFD0olm0lm4BvtausG0JmBsIDzoH9oFOqtGVsL7wj/sfRSgBfcQftnokuPr5V7ROa4uKeCwiRWNapcr79Rgii1AJogIMbnMGL8MPMEqap6MmQXi+FGN9v4PQkHPPG4TwITvSez6W/j71xuTuCv6JpP8TESk2onR7va5Z7/ZNI5OzS82A8YSa37Iffv8KBGvsZqjSv+JwMzR0EgmTkYiq2bA2p0uI5qMGL7R6EcowOBdSP3hT97UXLlsMgLwocRT8Bc+WGEdEwCbDLeXZginA13vfzM/5gJDDwJHgPzdCgrO9llDZaKQtdu1QhB/zoekjsssv9zO/Mv5R47sPfy/MLQbIbtbxdYSMyEbPT9z6XhwCgKkbpT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39850400004)(366004)(396003)(451199021)(478600001)(6666004)(5660300002)(8676002)(2906002)(8936002)(36756003)(86362001)(38350700002)(38100700002)(66556008)(66476007)(66946007)(6916009)(4326008)(316002)(41300700001)(83380400001)(1076003)(6506007)(26005)(2616005)(186003)(6512007)(6486002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oaPwxxHYcOWhg2EIKCn33RUMuippXqu1uqtS4YY+fCxn1bZZBCc5DQoZQDVT?=
 =?us-ascii?Q?he4v8A4W81fkczuJjk3fvzKuQ0PdRG0Amiy5rzlqjK8SCZ2wAp/FlecqH3lB?=
 =?us-ascii?Q?E8/oN0f2WjYbaRhIaMUial6eVD7PVD4ai5/cdqGAYYPjXbD68fTxKjrUZcMq?=
 =?us-ascii?Q?mTZNgULR4jKWtkaFjAgbxd1mOJq8zhjbvIkm6b42ARdwmKY82VuJVnKexMSB?=
 =?us-ascii?Q?n0lmwLjnaN+ihdXq8RiGOOCHy0nSQIE1ZRGGvIkxeh+G9hQ1IqIAPwtKjLVV?=
 =?us-ascii?Q?iFv4n2FdTvHWonUZ43n1iGudxM5134HVZgBKpy1Hm/k9p3iTKthAuEEDEQ/t?=
 =?us-ascii?Q?+0R7VWSK0xhA8fnUgI2OiU41ZFgbF6L2FjA2AloHEVV3XTEOuk+2p6iW5GD3?=
 =?us-ascii?Q?x3Wc0G7pyVyWaQzgw7pYqbNg+Y24mlK8jCN0NciXdVwAN6ZdGZ0+4r8iYMlH?=
 =?us-ascii?Q?Q0fELjrInztDyprwDMKLwY1n8z6M6Qra/haLHFgz7V9RYDamxK/Hp26ej9T+?=
 =?us-ascii?Q?2rPoPNjrRHjpbz9HnTq2HLqYn9RZliVgRDr19YuL8o1cqEfp6GyON9lWE4dW?=
 =?us-ascii?Q?9bHR/3JmlH5cWdP1ZejT+EqlhjVmd1pzbGHkQ1zQtsg3TMnBHxgGahzM4NP0?=
 =?us-ascii?Q?FkH5tPI7rROPsiImwt3hA6qy6+yIh957i/O9F5Rdt5WgVE9Gs241/YvzyFSA?=
 =?us-ascii?Q?8x7O2KfAthIe+iZsXIKPFC6nPn4KtQ6G2pCZz7dsss9vCezoLgqtcJw+ZTGr?=
 =?us-ascii?Q?g7kBDiviiI947Dw5zNKK0XO15k/rocDCuRDnanm7wCk3llUkibpXkoNNz6UR?=
 =?us-ascii?Q?KYLzSl039MlrPhR+WlmhJQBARgYaa4KLZLfgGImyIown+J0nzTmicOigRFQH?=
 =?us-ascii?Q?4blPgND4T+kDu0zW4MlbBcUvAjELINUYVKgRaySnlkFQPgHqAtD3cJwpWIlD?=
 =?us-ascii?Q?BtmbVm0Lcp4L2RItIWYc7c9v+1ApueK3Vob2KzeyVpcnmO6lxNDlej87jiFd?=
 =?us-ascii?Q?u3cpiIUYeinnfbC2KkAMEZcZ4kHMfotYb4B4hyPOgi8AuzIiodx7Z9DLqWMj?=
 =?us-ascii?Q?GLEo45TrnfXtr00r+SPhG+rrvjKi9PdX8G6yUXFRRJvpLe+r2cU72St0AwEU?=
 =?us-ascii?Q?wjqpEDz/bZZ6toGt5GjZqsvpnVP81LJDIie+++o1QhB+76BWe5WY301Grwh7?=
 =?us-ascii?Q?8Nt821O3Su6pLxCCv0X4w/hZ1gCmb0GZIUmBXJl9JpoizQUb5jhpwnByLIZr?=
 =?us-ascii?Q?JwlQEVW0nP9jaYxtK0H5VPelOJDqGE1u+jMhpnlSYh/hJArAk6jMgjA9xiQw?=
 =?us-ascii?Q?jJ2aS54xAuuFQ+BOLrnkH922BFaEizDUNtOfGG2EOD+NFLMFx9QUeGiE827D?=
 =?us-ascii?Q?X2f40wOFqVtfJNxELjMMu3nBx+YrpQ/PEwXuV/kh+HnIEuOrr43sHZcvbXDM?=
 =?us-ascii?Q?Dwk6+6eesxLhfHVli4iVfC9fS29No0OqzqgJrK8q2/rlDWaV7NEaNRN3fG8r?=
 =?us-ascii?Q?hAk0DMcsYHZY0DF9ueUEYITlz9l058eZxmn6uxX/DGyHENuze7AvkCyxcWuZ?=
 =?us-ascii?Q?ropmXRN4afMy/TXKkBqIV2k8A0Se2gqPSx+IiX1C?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab97e07-3626-4a50-b592-08db7c74dd42
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:55:57.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k44UwIEu+4qhKZtB65F02CQ5za9DbwZ602HW61amxABQdT3k8sW9w4DMb65klcUBeeud3EjqHukKBCf42M6ygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/staging/axis-fifo/axis-fifo.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 98db47cb4fa4..0bfe272ba819 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -839,16 +839,8 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 * ----------------------------
 	 */
 
-	/* get iospace for the device */
-	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r_mem) {
-		dev_err(fifo->dt_device, "invalid address\n");
-		rc = -ENODEV;
-		goto err_initial;
-	}
-
-	/* request physical memory */
-	fifo->base_addr = devm_ioremap_resource(fifo->dt_device, r_mem);
+	/* get iospace for the device and request physical memory */
+	fifo->base_addr = devm_platform_get_and_ioremap_resource(pdev, 0, &r_mem);
 	if (IS_ERR(fifo->base_addr)) {
 		rc = PTR_ERR(fifo->base_addr);
 		goto err_initial;
-- 
2.39.0

