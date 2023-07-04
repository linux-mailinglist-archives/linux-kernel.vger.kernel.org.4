Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081DF746E36
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjGDKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGDKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:03:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9107A101
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIoePlV9vtzOAUaU5erWpL730ryMYV6+PvCKOoJHXerG6fzePoyqkBnPowQix4ilvcaxYPwlJkoiTVJYMVk7CjWmX0NDvOyXigrFRB9QMdue9Vjdenulm70CtfMqy23URSrfw8cbZ1lMqEZIa3AqFiHDLBQv7gdzsnZn06ySkq9itJ5QAxXqgl9whqqWurCOhU1Uk+6TLqjz4bZJFumpPWFKIoykh70n+YSwfCHqPWRimco/NvwdGLb541kGNEIdgH0Wl4ywO4Ssiqd1NUIndJOT2QAF2PHhiNymahZFtR9q+iaXr/wnvgbzL87z3hVXoLRd/Cxm7sTH7VGURAr9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DPBRD+streW7SwJaKb7iWkU23xC6zCLR9zk6qh1oxQ=;
 b=BM9zrOh/Pk7Fe6Ont+dQ1r5wjPp1wt4BEZHl+806lrHg0NcdFkaGSFD9pCRuZ7RvX90ZQprYoJbm9kuqpfbXufnck+2wc+GRXXk3lZGOun4EGTOJVfGGA33p50MHNhG/+tTgCeKBVsNVbIipCjjmqgyRFWT8RlTH1oqSLvPIm8J+Ovax1fD3FznbwpSCwlUkr/cBWWLvOXFIBcA60Puo0mCxueY1H5nq7GAvIcyhG36ztrWO9+IJNFFRud0PV6W0PEye+H9k1NdQv5LVndztS2hI7YWI7Rzg1Ztkl+zPisvm2lxcfOq2cc5HkRdGotK6NiFVM3U9ZNmWHsmCK36/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DPBRD+streW7SwJaKb7iWkU23xC6zCLR9zk6qh1oxQ=;
 b=mNhO33rXCOKAyGzxH1T33eD4rc7iMYqvIPuWjj8Trrw5Vfj9inflwzzlsFcEEPIKTQ/Lu77g/azG1ZQy4wNVHwFcV+FI3e7xnX6WULHavOTn03rcgg9uFMJ5/ahlGk1W+Q5zA08mKK9iTXjhSsyBoH4V2hbdDoiNPiXKaIMI1G2pSQHHhqEvd1Kfp+bsrx7nYPj9f11qZh5d5xUBX0IL0ChjfLQAATt3xubJDmhjDMWVa38/u57As6wP3Gss6hWQC5nxxBUqXuI/7efy0xrcSeUptPYWKOib+i09q1+B95aTfoPsQcal3aLLwMaVtNnfhf1lVo3JWNwFwvnsrsF15Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5767.apcprd06.prod.outlook.com (2603:1096:101:b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:03:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:03:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] irqchip/irq-mvebu-sei: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 18:02:53 +0800
Message-Id: <20230704100253.36045-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704100253.36045-1-frank.li@vivo.com>
References: <20230704100253.36045-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 2407e07e-0f19-49b8-0fdb-08db7c75de49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azl3KPMc2F/FNbmjSiRAmT0vjdJkf+qSyH/Wz3ULMw+RbKBIzFF7lOXAZqAgFpUdySxhb9zKFjDDWKsWmmhigzG/HRHFsosFkK9JccG6O6uyGNyxbShFR6W6IldHxzNWz4+wcKLeKyoqo8ZDicUQt5vmu1nWzQmuHkPTPHDMlG2a8oO3XsVV0W+b0ZYCpP0rH5Utk9xF79oASxlLXiCI3jfd/PkAvx/F7Ld6zULnBXaW/1GEs1jjeoORfiqmfW/ZCib/FRjkBYjtiVRD+FScA4t8AAtkrHJfU2w5LxyziV9XlD32Lw7qFDSEh29TKF3srWcLDzk7VVQ2K09gfuskcQIq1/WJ3EUuj9WUTAC8X6KhgJBHPLJqW/0d9eDUXDXE+zFrRIOz+S7bAjet5niyV2bYx4sHqBbNgpBv9wt2U3qOiCj2TFQ5oPpkz7powUdCIgu6Q8iBvM1DiFdyAp1IDM/VeJnHmlQuq5VcbWObGd7aQ088hjFdp5EfIWceGwgezfzUieES+P68blYZJhKPQTbIyhZtmL79L36EBhFTnyzkdWBvNTRwZuyRhBqbFl0nyVerLjNNq76yQr2WvF/x2QwOIpst+3nNY/w8AOOU9lMpUWtcxnNJSqw2neYboDXl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38350700002)(38100700002)(66476007)(66556008)(4326008)(66946007)(110136005)(83380400001)(52116002)(6486002)(316002)(8676002)(8936002)(4744005)(41300700001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLYTUHXNm+5b2AAUZkkTiDU9JXHCglssF78jdyIgRA6H+xsK0w1oBax2Jevr?=
 =?us-ascii?Q?wLq51eoNZnQ2plzMsO9EYepZRKQ/8ZLmetSd6CM1gsJ545RjFYW9DnHhU2Ql?=
 =?us-ascii?Q?b4e2QrXsVP9eYGQQxqeTSb/e1PzOBDd9TmCyoxxV4PcbMKCuMmgyr8Kx5Sqm?=
 =?us-ascii?Q?UOMnpR5H1odG9a2BLtI3oJdcXNLwQSg4Z+8oreMK6rqBN2GcR60QcuG/Xi1w?=
 =?us-ascii?Q?6LorJktodtuHLGGhBKzGJTtTpRBxVQ5gU3BcTpvLA/o9OMpoEkOdYEWK9cmy?=
 =?us-ascii?Q?8M85gB5uFiY2qbBnXWTo0uNJre4/re/Wf6EDoeeYhiqijeZA5GMOPYTBrEaf?=
 =?us-ascii?Q?1OgdzsvMxMqbD2uCu7MdUZUkECfu3qpt//Gy/CR+b450/rUkmoJ+SLPPRR0z?=
 =?us-ascii?Q?uvu0G77us0jwsfXi/jz+QHFivqlNQEHLXkDhHX9Xg5OFBnpsLT0re/XyLTLU?=
 =?us-ascii?Q?weB3tH3UkkXiDXNEydd+pefhn6HjU5YrrEsvzNIXnaDtXbXWAXggROLdL6dg?=
 =?us-ascii?Q?VPcv/SmDYvMptDjX/wI3V6qNIKEPePiXXNAFBeEaWbX2Wy5l73rGuPXb0zj3?=
 =?us-ascii?Q?MpcpA32+Cv+/LlSjUQlk8ZdrQx4JnttWBtu0XFLWWuKvtCjElXP5WeF+aRIn?=
 =?us-ascii?Q?Jay0GvvXNiX+gbIZdESDWTQ83jB8MB0DxtU685vFvLuU/oRmUN4E21aADS3k?=
 =?us-ascii?Q?UrHFYe4Jg+wEUmhYIDFl8w0UraIQqQ7W6Km7OhYKriX12NXLDTmND2LwlHyu?=
 =?us-ascii?Q?QMFQjKBMaVi1fZOGswvLvcen+pldyNsTAYTr8MZPCS2Uji1uEQ1nx2GJI00e?=
 =?us-ascii?Q?HlLqKznAVtT1usNWwikYssLe9FEOONklSHY2VLIG8UosVzhKT0+khhIUHTNh?=
 =?us-ascii?Q?gYXsuFIICEma9IKAYXshZuKkGeUvIKSpbO+7/vPENk4XCxRobQ+dRmeIn1Aa?=
 =?us-ascii?Q?Vbba93TD5neLeDGrmHWKIjGobkMllcMvVl3EeN/XaDuy4IRtd5K618C0rNcP?=
 =?us-ascii?Q?o8uMt+kJ4B5/oaRa3aam0ui72BHP/1FE8rOkWOD3mLIYe+q1XNS32PdWzyCF?=
 =?us-ascii?Q?tf68L6MSkWu4LiU/49M3INexK4yz0dk8/1RTMDM5M/gRmj8bAJQWJkHlZ0Vl?=
 =?us-ascii?Q?JpydJjLj7SMpeSKAgqhoVfgEM/staVUYfdd8CzGE416O+deH875shg5CjiRr?=
 =?us-ascii?Q?OCQgCj8F1NPP3j8K9hS3npheIVNh/151gsYf48MakIIHwCo6Y/SGoTuL1Hsj?=
 =?us-ascii?Q?MndjmTgFkR3rynczAsPHRpd/85PJuYkBEu/rJ7H1UtFhsJfRo4pHQJLVHVU9?=
 =?us-ascii?Q?jmvh98iH47xrPZqxGGT8zs+ZuJdnb1KefJD5XqpfNsmZbHJlTIPzRy3mnwIq?=
 =?us-ascii?Q?ZPu2XVDD2i5LszenlixRne+vfNYUUXqhr40HH2Rntyal6k8kpkriugBr84MU?=
 =?us-ascii?Q?VHEP4AU5l+paUeKMRa4BSdfBycal5UoH9AGw14Bbt6H8mnCn3UOlOEa1Zewa?=
 =?us-ascii?Q?bzs0bj292UCmQQihiYzEXG3yyuvRVpLEFcqUlA443Cf/MOIstlU911PIwz/p?=
 =?us-ascii?Q?/9zgG+0KruzjPJE801k/T2nTVryVOAHRS2N3gYwo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2407e07e-0f19-49b8-0fdb-08db7c75de49
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:03:09.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW9iw5nwwDJ6mKbZphSPWqt8hEyx/iBJg71w6DokUB0X72eGDLWL+XwLul12YYoMDcDGLWJe5QL96t2rfBbmJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5767
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
 drivers/irqchip/irq-mvebu-sei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 4ecef6d83777..a48dbe91b036 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -377,8 +377,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	mutex_init(&sei->cp_msi_lock);
 	raw_spin_lock_init(&sei->mask_lock);
 
-	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sei->base = devm_ioremap_resource(sei->dev, sei->res);
+	sei->base = devm_platform_get_and_ioremap_resource(pdev, 0, &sei->res);
 	if (IS_ERR(sei->base))
 		return PTR_ERR(sei->base);
 
-- 
2.39.0

