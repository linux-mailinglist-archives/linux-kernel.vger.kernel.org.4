Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3573747D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGEGyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjGEGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F141A172A;
        Tue,  4 Jul 2023 23:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSODXvgE16jECBuNQxNvlJ6IzLn/M2Ecw5JLoviLz4W5KX4vupcghYvSFbpqg12BwMIiu0o9lAo/ST8AMOxawLjZbPx68ObWb/q3+bDtdEpy6GauQgEo5gfk+I6xctbDYvPNiEmu1QYsx2F+4dXMUwBxGbBJiph75u9m4a3egAvL3Yjnv6JF9NyXdD1XgO8ZqSti5N8V+puAg7yglLIpPkIj+net4GcYgYCUrnp9luTcMRKp4kEvU1gGz59EgmQ//d/QdVy86o4FUDWwjVRWEBhNP+5ni01Gmx5TRwPHX8Hev75MRu20m3jRcFLKG3sGQH548H0V24bDwN4cjQU2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf8dpvwvqfrZzajiCc5RZs00ZJmeVYtXcalY4ODQMq8=;
 b=d8K45VbLhUpgLnY2sXE+Fk1cDwLkIK6AgRIFemO6M8VmCxe0CIWl5enX5t2d0lQry2r1p+S2ClVeL/MGVMPwApqzsrxy4X2b38z0Lxs9s2+JLMjaXlLemsc1obHySM+wCRT3kA2LjGeXOENT5LXtLukIwWTXr+Ei5VB62SRzdG4JqCcdT6GDOZEKDDvhuD1h5V46W83qrJQ6qalYTdTlBcmA4+TJrj72m2+jXpVQ/GYrf1PLml8KIozmdseB2pTl+PNnqSUvKFQQrPew2gFsj1fVypa5yBW3Q6EIjLbfNbJ8EnnP1RdBVfEw2KXXXzj5CyGAMS26DXCbcCVRtD4wkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf8dpvwvqfrZzajiCc5RZs00ZJmeVYtXcalY4ODQMq8=;
 b=CRXfqSgWtvNDo2nzAW27S9ikSgVf2hGmnFNIhcKttTGe9jn0BIEJGOxdNDMnwIStbV9/R6HyDkJ/xVEhJWXQgPYjFPpO0mcYf1AapSX+XLIjWBs0my9dhPLJ+QBLaSzfqTMCev951eIGiw4er1mdyWa76/p8LC3O6aHlPyYs59qz9qdVRbe1H6ekz6c8mczMohQlDsX9M8nAV+uaq3v5pclzZ52zRzOv6PDUvcIDI7EdyaXg/kRuEFn/3DYKLCjPWLOxebZR3pdDGCCTlD6z3PFqJrSYManBXQoZi/yZX4HRRjd6JSnKDnXOxRudIefu/Hz9VEDbDeeDSb4Mr9aGXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6087.apcprd06.prod.outlook.com (2603:1096:101:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:53:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] clk: actions: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:02 +0800
Message-Id: <20230705065313.67043-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 072dfb23-713a-43ac-722c-08db7d2488f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjyWjWlq5z2R/c0QkUJUQXAMydKcKiZt2X2SQWLl9qkuzmBefnlvSayxqgXDrY8KoJQTpv3PxkKqczolzAm2jWRWpU803SoUMMZ0iwXNqjBn5dHRlhU4eBlf3M400ef8W4Jl515pgmI1Ohv21+FDkBn7rmGbZ7vumD5T54CGYPWt6KclPLaPTzcw5N4iitjozT1zgplQkn+YvOrtltcYxBCi1aqqsw3GRWeWCj7Wb0PRFGvOxKUNc32gPaNl2X4XzaeDo+gqa535JB84BURpl8S+BTHGcVDR6V8AADVxdqoA0MKaJ74AjdZEjw4XV1G0An/pgznaWAu6re2uG8nEF7G7CosRD+MhSrTzwL32nCdNnZA6pjkoB3AhAy95yil815LvPRRbAhoT7WukP1E7U/v9jrklcxNq352bxJDG1MBDk/D8gCWviI4xUjYCiMHW58DSHOABUpnJgP2TJGdc9SEmJz+HiTNZ3iBqbmVUd6/p0CoQiojaLai1VHelXs/UakUDSGd1ysfExQlEpXT2MTNEsYkWeKWEAXUTX4XOrCovOJ9iYCKeT1p0+wmO4SEHf2Fm7onBRLuHVClovkq78N+N8s7UbYHv804omQ+9qcajHtJezrp+EKYBfxgAP6H7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(41300700001)(38100700002)(4744005)(6666004)(52116002)(38350700002)(83380400001)(2616005)(186003)(6506007)(1076003)(6512007)(86362001)(6486002)(110136005)(316002)(478600001)(66946007)(36756003)(66556008)(66476007)(4326008)(8936002)(8676002)(26005)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WullGIkrpb8lAIvTxQC3v1jdGrtWKYYxlBxC+XK4LF3jemWiTiHfIGvascbR?=
 =?us-ascii?Q?dJl+J+zeis7fQvH/hIr/Jpb4c7/lqfRAizaEhya0BZkiG8DA6y6J/ACXw8W5?=
 =?us-ascii?Q?m0G5lPehWMUNrLh+IPh6XKwu/OoXDbyBzNn1syH4IvS9KuOzldlOCGPDbfFY?=
 =?us-ascii?Q?m4IrcLppzgwZYcvxXLqmTIl/fZq9ERVBroD69wPYNDc7CM/bKFZx4WkP2Kin?=
 =?us-ascii?Q?BF6lrKt2Z6Dtro6q2FGdHZfulqVbvvSu0mXO6xTiSG1wC0K74hL56SO+3Jex?=
 =?us-ascii?Q?mEJCqV6gRAqIkIRZElxQmg9h8Z7D/mnlLKzEblXk+m5CU4e0PqEyxASr23pe?=
 =?us-ascii?Q?zQD/b+JEEsdI2zvM6buCxwL7FynLhadQpEa4X/u3YvoGNeD9g4uMllDxrFdd?=
 =?us-ascii?Q?t74fqyvsysZngg6chK7oYuge46YHfSDJ2vaB8iH1CxiIMBKkpovrxWzuPcO+?=
 =?us-ascii?Q?ffC0ZU664hoHacB6bL4M/EEpvnBGjkC2u82qtvwL0S4JbX48o1jRjyA9M8l/?=
 =?us-ascii?Q?N90okaDbhY10cmUGnx9MWpKub5l8RS3jCh29LuFudN3RzYWoV4Ed+KdnFkrh?=
 =?us-ascii?Q?3VXdUkaqRSakYn6tHK/r+4u97RvTGeK0UeY3hfOvd/i8Z2Tmei2FgYNe4VSi?=
 =?us-ascii?Q?UfvHtN8lAJbNf86lznYwq8fqtS1WywHccFudwvEnN8f74h26XAN7JAb+aG0U?=
 =?us-ascii?Q?qS7vfgZAFK7GwgG3JgQk+6hvD339gtVH7xv3R6NHE5Xv+bMbCMWjNCcE3IQz?=
 =?us-ascii?Q?QLa3bDoI294WWjKGUgmAeyqHOMXD7tLzhB6GG/FYS/9UvTPMoqxZXg3X+V65?=
 =?us-ascii?Q?bdIAXGRycP9yKaIdWGXuHiAhr79oXI+MfSU8nh/zGVn4RBCXh/WhCkvcxMBo?=
 =?us-ascii?Q?aWnA3MIDPgV6BAWeBRARQHdni+nJayu0PGLwfpqgL5tXo+JkYZAs+AJ1+9DH?=
 =?us-ascii?Q?5H0It6PrhN9pMzjHQK//+0ERU72y8MqyRwFpoqu8OLVAaUtcsoTM69d+1Xvq?=
 =?us-ascii?Q?qPmkHamSAe8qO77pz+5nP8qzI+BJXUrVllpdP0qYZCasntUXrnLenAkDNgC2?=
 =?us-ascii?Q?yX9Apiuxu4xoN0epVV47r3HRz376VBGAqWSecl9YeB38sura0n/0hYb8N5UO?=
 =?us-ascii?Q?i5cJRW13LDSZDLXlLPg87cS0GmPtSr/rlUZjChA0h7B59DllV3tEZrmL0SNd?=
 =?us-ascii?Q?4DUQ8gMTQIs91YOnLJpemmWw328CM8OZ9+sEpknfb86dgUMwlCZeToONPeB2?=
 =?us-ascii?Q?+Oa6p6A81qioLKmwy9sEPqWSRJ1iPKCrjIpsZybuATyoVcWXVbP5G5ZLEQJ3?=
 =?us-ascii?Q?HzggNS7EPQJl58rqHXm1bGeu4UDYWdMP7uTrOW+6jle8ie3hdl1YObXhivBu?=
 =?us-ascii?Q?NACS8QlI0KmB7uoKUZI+EJXp2vO6z5Z+bmGgLXUSyXPBY+O4MNxDgHeK3Iuj?=
 =?us-ascii?Q?TcPKdXoWU7wMFZudnsmODKr/bY618OuN1g86dr3Lmc2BpEQMquwIBLXHARvj?=
 =?us-ascii?Q?uyXQ6fy6+Gi+sb2WCiiqb74vTpNxTxK7E5pvK0kw8PsDsMA0a8WMMXrom8SE?=
 =?us-ascii?Q?gNpkh7G73S3wDH+TWJ6CyqBHsMhyoFyfs1YIe1Jv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072dfb23-713a-43ac-722c-08db7d2488f6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:27.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPFz8gzvpob9bAWwYK6+1ViG0WG4RfOceybdKfVXwLzJuM9KsF8EWauvdpIEG1PQHyEmYK0Nesvy7J/uenhkGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/clk/actions/owl-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
index 4de97cc7cb54..9e98e8a92ad7 100644
--- a/drivers/clk/actions/owl-common.c
+++ b/drivers/clk/actions/owl-common.c
@@ -43,10 +43,8 @@ int owl_clk_regmap_init(struct platform_device *pdev,
 {
 	void __iomem *base;
 	struct regmap *regmap;
-	struct resource *res;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

