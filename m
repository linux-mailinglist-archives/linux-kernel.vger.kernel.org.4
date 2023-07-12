Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0479675061B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGLLcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:32:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF08F;
        Wed, 12 Jul 2023 04:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsXH+T92anmjtpnv9jRWFS1dOwaKBXYC5GIdOAi10Tq+ERSEM/Eil6yFM9Hd5jTP2DOMm6Ahc3D1AtkBaUQG9VLVKQkXlwmujDxjnTKdedfyCrxVgfDgyAdXCHXDqAULP82+AAZfCRxXw88kw4rptFPMZVeURtohlVX3o0hRzxKT3c7DqVjbwQ/EOrDnOZfWdCKMmuO1REJkWDStoqUmfSZelqGoWwfsPABiG2+jjEkU/4C/xKqgR2UIA/mlm8qTI1/jfMomcUrQF8h/bhNSAtwdxFIVN7SamGAgM9nCP/3fdtx3vauskKomFXdMRy+RRyIiEcHcJkaXXSqQE8i29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc8j56sUGkfPswGy/Gm5aR0K32tGNTq3bRxZXF+Mvek=;
 b=dL1p7SHXKQTcMkmmDLfJTgqtsyxrt2KeUpmNoJFz43StJeNsoYefCSjEV0N0SfJ9DFcqtsdA6lgaQROj6ojyS5cFFlsJioKBPxKa1FHmqtSW2KyC7YLNUrxIe6UbPoxi/vp8xB8OEBnizqiwKYtZy/ssTsKMiPTFC2fvJDaE4w7VuQ2sBHCY8MfsI0F8dH+HVDSCMuUURjSV8kVpvR56KkPfm0TT3FtnH+qp1mmeDwZQRyqOpudTDSOGedtGMzD+iv9w71zpXFu2E9DK8A2FSAvQhkFnJgBngoW4w/sG97uXHdiR7lv7FXgzxs1kGL/P0RB72+VC0wDbBejtmzfi6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc8j56sUGkfPswGy/Gm5aR0K32tGNTq3bRxZXF+Mvek=;
 b=Kg0DAj/8A9Nkxj4Qez1gassI5mMAx+b0UBoHnOOU4/66czXeuaiXgeJWadsYXC464VFAEz6hO1nAL2duuvSVhqLP3dh6weY7dI+RzaMv1dlLOSJBqelzPtY4Qr0Phf4gH0CD7A4ikvJ4Jrk3ddS6BPYmrDypCbu1Bt4vv71U5SvhGDyilfr2UsY9E52pvRe5+fTepUvayJNC3EncKYAhMcvOiEL19rxeQ6yu9lCFE1JFLqirHdC+Cm8Ce4BWPMM/o2fiZgKmHGCl3rDBiUhlReUc/yb3r0H3eLomeYA4RNZR7PhiS0RnMD6oI3kqE9Tzwzsh9KqpXWb66e5H+vboDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYSPR06MB6713.apcprd06.prod.outlook.com (2603:1096:400:479::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 11:32:01 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 11:32:01 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA IOMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] iommu: fix parameter check in tegra_smmu_debugfs_init()
Date:   Wed, 12 Jul 2023 19:31:45 +0800
Message-Id: <20230712113145.12888-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYSPR06MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: dab15e1e-12c8-4f7a-11bd-08db82cb9c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkGzr3nF4trhn7saiBfBlU+RlpjomYZzPzo66aCnqkirJdONDim6M9fhHm/EJ6ac0tFPQEz+FZswBBGTbdSgqa0m+L4bUyl5lnk56l+Ims0zI1tVoxhMrivRffpGTrkX7Spk8BQV8eM9qm9yx1ewnjoH0JRkpQZkaPYQKFgvp42u0dz5+l/BMPUWbZg5+531KSW5fMN9zCXirHbw9/M3I5XpDgVkuInxL177OXZcHAkbA4yyNB2PopWjszJUANJwAz7s82vCQiNn4J7VQkHJaIpvVCAzR3imyt80f/nw71oTj7PUdDF97J1YA4VEEW0hNaTbYzHyR//MMYObjkiULOXg2mXeQrny1uhG8ts0DOG6Ow7HmHNNAn/td/sQx2tNtuzzHzMCyOatyCOA+SIvkLbs5ZuSa00bAs0vKCpC5dwU2+BKM6+5HPqHVDUGS1OAJR6tozfg0XPh5X0JtlVoemoxo3TV6SfCc+ZYF5jLtDVTYSNYDFJi9fEDUzGIChRv8HcLOLkX/rAgFfvOWtCUzd3QYFzAZUdW/YYVGEM7dOyarh75wcdYYI1UMXAUcnSZO3KBxb7wxEvY9C2xxgJjJTcxghVeL0XSNWzgF5T96LUzI6x6b7frKw3MU2zMxbGi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(6666004)(186003)(6512007)(478600001)(52116002)(316002)(110136005)(66946007)(66476007)(66556008)(6486002)(4326008)(41300700001)(107886003)(8676002)(8936002)(6506007)(86362001)(1076003)(26005)(5660300002)(83380400001)(36756003)(2906002)(4744005)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ncvss9A4qvmX/xUDRmEVNQ4w0v5eL0q/PlxAjgxFk0RVBw6E28HDc1+HqGyb?=
 =?us-ascii?Q?vtt084FiR43KyhDO9zartL2wyh81DMLNewOClYrskQSHAjB7gs1smvwvhI3f?=
 =?us-ascii?Q?TaTuGOEvd8QLNfdNnAZ/uArXJaQszw9QXgeD/q7/+ui7u8ikJ6QWfMxe5Pee?=
 =?us-ascii?Q?hh3hoeZBwmCzM1SSE7qkAq+y2Ga7x7y0sO0rfqCOCERSNwEZnPeJ2JFccqdV?=
 =?us-ascii?Q?dE7/TMBOPdOQ7/ZyoTMYO1BJsRc9GVVelWHTqWDY5nL/T4O9vZEntaFSA2TV?=
 =?us-ascii?Q?GDJXjeHmUcTK+dBWDfTYnyaGTtLh9yPd5PYxWQtUvQBNuKI5AKrNoZsiNuXs?=
 =?us-ascii?Q?1bS17BmbP7kvtyfGdBK+KyumbMMcM6+6jKwBwEzdWaGe9sBKXFoDoXkp3beE?=
 =?us-ascii?Q?dzwDZ601N+Bdkw672o0VsymgDvXWZBOOgQM6/wctIr2o5mG7IFn/p71QtM5h?=
 =?us-ascii?Q?uulyBxfNzD5nQPRsfmU34o3ooJAkQy9T/1pPM7sNO2r8Li9xFlpEOM/ah0rk?=
 =?us-ascii?Q?Bj6hWOvi8DEBBWYyjCacKRhAPkjdKgb/JvF++i4bVF5UYTdYU5/vdhI9SmOQ?=
 =?us-ascii?Q?AA3hter0uc0rSTc/XWzSQV0IAdPDWTdWI6D9VphaN2rrJ+v2Dx0acBFGyM3n?=
 =?us-ascii?Q?2IY1a3hg2L3qVbKY+NtSZmrwYRzyjcBnnSt21bnufUxBCvnH9v4LZXIWJnH6?=
 =?us-ascii?Q?i6uMQSx/f3dGClIoJqh868dtYp50rG/6yokhWvNDZ5sUxAGFKxbzXuoNGgMA?=
 =?us-ascii?Q?JdJ3ZOkoNcSiKloVzBlvDBxvyqzxDyJF9DAfjhvEAxPFqZdBRwatl8ARyy0h?=
 =?us-ascii?Q?s0dAj4AOJmeA6ptr8X6K207ZaEmqac0A9ZnRECZarjos13X8QQrsCTt+8Xef?=
 =?us-ascii?Q?dwSZt74syWx4Zdboi0pVPR/LHAZ1fN6pngpD0jRBsWM1rCRfTxg7ghKaep1a?=
 =?us-ascii?Q?OPTnXafKoaXpwgbxfrxGr9Nou6QZIe3/ZSVcSDe68X+WGTCOICAcaKkZyPNH?=
 =?us-ascii?Q?07oGPsf0F5GWEN08lJJekE1Y8rOujXz0KOfX45MFjF7ZeibrrMzpOyB4RDeB?=
 =?us-ascii?Q?wdYTfi0jiMTsAN5SjbKUayjHevKMCB6z7O+t82wtMtiGGkX8wUuqsCS5yeoZ?=
 =?us-ascii?Q?bpuSwvLBA2dByCE3/6yLkROMa9BX5xgXi4NaKH7OO/blztyrwP+f15GL1Fcu?=
 =?us-ascii?Q?ipQ2TrBLVLmdJe02siyFDc1eh3sTx8qDP6xUs8n1MviZipVoYIiDYP3cwMw0?=
 =?us-ascii?Q?t+Er3CbjX8WdjrW+VP41W5LMMgMpEbu785UjZ2wVY+wS4RatwbeKAxd6iw9s?=
 =?us-ascii?Q?YN7R0NnIjsR/sm5uL5Qe4Kr/eWiDjwyHhsrgXhe6oInO4v4FIJbYPM17g9TK?=
 =?us-ascii?Q?nO1BSRzapqsfNlKlgiDjI2NuyRkJRYYJdm/r4D7daF1rGb6QPeh2UcY8BIk3?=
 =?us-ascii?Q?0MtdfiXqCwN3a+sHceVlrQ1+NEBzFIEPlyCimBmm8Pd1YuPCjyWI4Tx/u04P?=
 =?us-ascii?Q?pkzTJ//W1jsdT7nQYOtQmqOXU270Hgv/vmaSan0Yb8feXJYY6NcUaTTOKQ9u?=
 =?us-ascii?Q?580FAFgSNphBgTdbu3atRDHj7I1Jh/qQkAm9fjaE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab15e1e-12c8-4f7a-11bd-08db82cb9c0a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:32:01.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYLAf17oVOlCRXfT+oiXVD/FBAGS3mIUHBlE7cnJ2ag9u+QLF0RiQDeDTaV2jrA2S8y3IMqH3cd6fNMw8j6hbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in tegra_smmu_debugfs_init()

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1cbf063cc..841e14cce 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
-	if (!smmu->debugfs)
+	if (IS_ERR(smmu->debugfs))
 		return;
 
 	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
-- 
2.39.0

