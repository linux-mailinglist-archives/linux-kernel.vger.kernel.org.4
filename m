Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB34B6E6161
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjDRMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjDRMZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:25:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2066.outbound.protection.outlook.com [40.107.255.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E59EDB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO2TH96f+JXLWnO+SirBJqDfxbAPDz39MiOM1jwWOhrDZ+dVaemiS9Vj6wflXh2qgzpk07FknhZnc025R1/VLpIX4Wh6Y89XcLZRcxFwfeXMdpjZtFO6oCMZzK029q0WbqGCv6ivnZOmEYlatb66lhAAAWKcLJn0yMyuDJTy7Q9g7NTrZq88FEqSlAaHDbO+9HjNPheMaT+tUXLjnQ/zdKsYLQEgEMKNoZstuQnMbF5AJNRoMOWWawrwV5/D1lqFiPHKTc254DsBS64zKrKWBvbdAXQwwBdulJ2bkNxzVqciGOiOhI/skch5Gmw0adbn5nSYVaTjQvE1Mo4SUSB+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEisxQoRcX3yVPay1NcG10bQM0s1abDshxaVOjQV20U=;
 b=irXesd0WgKVpYscGrFqfoEZt56MTjfxgo/5VZqo93lFxxKEy9frwThQvWgil5pKcb0mFkt7c9Rd6uiw0y1KLGQg8q8rLV4PzthJb/S3iKKoqZzNVMC3Jop+BQeydiTCK2M53d22Okfvup8yeHLMxrwTgLwbhDKbFFPAABikbkcUvCgbbgsOt3FLR2WNPhJzebWoyWL88NGgp6Hxr1tP5ysneF7CKTdvq1g1/CIMolsnXkJsmA12mP0jPgQOgC4IObt7WiTFWt+CjTSlPV3sLwJ5ke/wVGvah0Ohnm33arQwAWQxvM7TuZ/cOYOEgV0FL6lUNvmysy52Jcu/ToDahgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEisxQoRcX3yVPay1NcG10bQM0s1abDshxaVOjQV20U=;
 b=KtIfhuMBW082a0Wjhq9Kcm+VOfWzVrJJ34ABZvTr0px+88ZGYO5plvxgAqesIWgxyQudEkNB7jcybIAyABxgMGPpr1Ik8UQBYoyow0WViOPyFO36MVcmX4UB6anNTePaQhuYns6yvefXifhLbAg7Tfvi7grLEDkHP8KMLmWAm9LeMBWq8CkTS39n+D/YqOodjPyBp9cjhi4NIFUU0JSaUpFKw0Nm2TEyGqdhykZBxAWly8JY2fQO4IXRBHF+1xNrsI4JNqgaXt01xc270khJTzNWloh1y/9RdVTMt+3Va2uIVI/Op9PbndbKdSOMmEeG38ZWJcLCShEjy81BmQaSVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by PSAPR06MB4423.apcprd06.prod.outlook.com (2603:1096:301:82::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 12:24:29 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 12:24:29 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] driver core: auxiliary bus: No need to get auxdev->dev again
Date:   Tue, 18 Apr 2023 20:24:06 +0800
Message-Id: <20230418122406.1338-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|PSAPR06MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f32d4d-d7ef-45c9-188a-08db4007db25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkt/FI/9w4Ik1vJQxIlR8KEE5REtWuXlsRJhijzufthMive1Y0wXk3ZFS+zdbO6vi5yLiaEGJQi5kkr2F07Fd5sy0TpFbDuVKeuMU3XfPSFbhlr1uklSA8rGkFHQoj1Tfg4wSsjsZ2rvgcGT7aT6/93DbeZfsN++cRp0hy4u72e/jYurCJOIdUv+B1g45BOnAdSFxnjSkoNPCtN+WqiNSOAysd2D9aw6Kfi+/Jqn5nBaGf0xAaeXs0R2UXHYCxW0b5xms5fxwtUoE0nBpzDxlhF0UxmELiViGFtC88kyjzdbzNB8535Dq16VzZbAigBFWkOsf87spA8GqpJKPC0s01v2OJuu8jvum9OWOwf2m41Zb5Li36l0PU78sKwRC1stp2tHoQhnRRdB6Gt8fU6BDmo7H4gY8bhbhr9deuuS7t4jcWmir1J0hMvAgraEzgMOh/tr+N2alnX2RORZtYO6+wEXaUVTrkQmXKdzEmTAtbGEVMTTUXSQrKIFFKMORcdcZdKgUdHC4LYHb0uYXiDFDCJRvOF0OQDasr2SduC5HtIAjxaeUFp0wNAziIhCv4RGbVQLHU0fPKmnXSsQA0eK2K7nqIOqmdIALwTs/Z9MRdg3o2lKpwg7BRP7MHMca9/G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(396003)(366004)(136003)(346002)(376002)(451199021)(5660300002)(44832011)(2616005)(83380400001)(86362001)(186003)(26005)(6512007)(107886003)(1076003)(6506007)(38100700002)(38350700002)(8936002)(8676002)(478600001)(6486002)(6666004)(52116002)(41300700001)(316002)(36756003)(66556008)(66476007)(4326008)(66946007)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hxzv+CMD5setTXyCh358W9ZLtqeVZf9KzWkbcOIZs6FqkBlcmsruacq00BZg?=
 =?us-ascii?Q?/DGMjE/4kOOj0G6jWhGaOoCOuK/JwKawfUMvxbsK/7t4btXNnLy+IOIGSDU3?=
 =?us-ascii?Q?CE4fFf/+oYYo3X5NLcawRyZCpB9QHHvjarkg2835sFtQA4eFivtIY3Q4cyBr?=
 =?us-ascii?Q?r/fW7N73w/2tgt6pQwTF+1XhTM7j5G711jlUBXG07BuFUL58zVCFMeTyDsCl?=
 =?us-ascii?Q?NEqvrIvqdbQ9FcvQBt/bVuW7rUzuZS5/6GkDJRK0Vex4d4Cepj1g2Fn6bMpv?=
 =?us-ascii?Q?wjqc54WUMXcBDUE/H5VNvuS5Qb6kW9bDQ0WMwMpeVHzAN0VIpy4D7yohC08V?=
 =?us-ascii?Q?B/125CpW7je5TdxYCvlorEzqBTUkzRgJS1+6m6zAPS0bUXfkxG0oN/hMK+dk?=
 =?us-ascii?Q?J/IXk4WODJJah03lU1WNANP8mRwCwrwK32Q1cvXgRDYWvxDmZriofd6pE0vD?=
 =?us-ascii?Q?fb8urc3ccZzAsWwLT/KEjjuusr7aOF8YQ8TGb6olQ3O1jInHxuwYEPL52pd0?=
 =?us-ascii?Q?gN1BFp9dCwLdkgmrzBxnmCfNWtw/8/n7vpoWFgwiAtdtATJaKhk1ryuRoqma?=
 =?us-ascii?Q?7beFMDex54GbkYRTHxZJOwaE4bwoWM9rwgbvWHUhFUfbjw0hePCT3jnxJ8dc?=
 =?us-ascii?Q?MEHGbJioztEk+zwYDqa5rWXdblUAlOneFrxDFldtI/axoyR8V6cAV3MREJoe?=
 =?us-ascii?Q?E9ESFulL8ILkMefLt+m/cOBdcxoFFeCsosES+AxSVXC8hhFIvSi1bDDJk9tZ?=
 =?us-ascii?Q?G2qvEcSCvtfgqW3Kko+qJ6chvYYNlvHaor+z8wOYzB7vGeS6kmJqx7V8it0u?=
 =?us-ascii?Q?pg2Ki/YgB9o5sGtH1fAmkgQWnlPMpvv8QuQY73pF/Lwo6qmAKjPNUIMdG3Pb?=
 =?us-ascii?Q?23HU1D+9rAkVUOQyldEY2wbnZp0OTxz3TStVddMpsqeeI/NCDQTCHQbaqH3i?=
 =?us-ascii?Q?dj9b1oItgo8kLu3IMzQRP1xKWimgeUnXRrQ+e2fALncSD/V4V3G7yretaDvR?=
 =?us-ascii?Q?g3wc+t+CtcTU9MmXCe+5fvh+BA/PASc0gb9efLR0rOtZdzhuPA0h6/VkCGRo?=
 =?us-ascii?Q?s+ojsKw/xpVLzaWBymA6SYbZW8+c4Jk2f3To7wSrid+hUimSb1UJX91S6lcC?=
 =?us-ascii?Q?g9TNQGazB7VmwdEvD5NMJDFKgeNFpINOwz/Q4JSt2GwrGU7GEm1bN2Gmx0Fn?=
 =?us-ascii?Q?sNRrYcXVRXFRNTXo9hg10ghH3wXonyX8gFj8wzDzsFblSY0w35WcZQbtYE2y?=
 =?us-ascii?Q?Z3S9QSn3A5tarTf9fl5fGM43x9DfVWQ78/JcJ7ugUXG9NGr+BLZ698A6Tm6q?=
 =?us-ascii?Q?pzeof6zFcCnrPrSMolQYOuVEyTqJ/V2HLwdHcrQ/xOkSu+vouRVoGkYtA86x?=
 =?us-ascii?Q?J2CJNCpOQ1JmKGH9XxCzMiDCLIndZYV4CPxFeaebXPSzOtOT/2iNOq7T501N?=
 =?us-ascii?Q?2Gtwi8mYwhbktNfyxpSP0x5z5TcsrNoDItCsCRtXLeHWhBBWQG9Qn9IHw6dU?=
 =?us-ascii?Q?jZzhOmmcCLVIfwIHjeweC+7JSjhXQZS06jYrMhjtZMdmRgN10znm5a1x6X0w?=
 =?us-ascii?Q?/d4uaQ9ExSGeqtYJ7dndpILm7iBmm9loaOSfL5BL/Cc6wQl6892Th/4c01Bm?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f32d4d-d7ef-45c9-188a-08db4007db25
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 12:24:29.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVq8K9/MhAcIQJMV0F+5DQ5N57dYCmnvtESxqsFe1c67xAW4Vun8Ar2VOfXTJaz14O/raZ5I83jyezc116+mC1y4t95z947yWnEnhlg7xrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev variable directly.
No functional change intended.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/base/auxiliary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 4d4c2c8d26c4..ca1d044ff738 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -286,7 +286,7 @@ int auxiliary_device_init(struct auxiliary_device *auxdev)
 	}
 
 	dev->bus = &auxiliary_bus_type;
-	device_initialize(&auxdev->dev);
+	device_initialize(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(auxiliary_device_init);
-- 
2.25.1

