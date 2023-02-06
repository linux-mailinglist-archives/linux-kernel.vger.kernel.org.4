Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5618268C05F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjBFOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjBFOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:43:28 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B416AF2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:43:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTghQcWySFgmiXEi2GInAoqiESTb8R1l8/wJ8TxNu2V1696+g2ettDOnSFkee63Ed/2kcRqDhjRN6ZMdV7wFoS34FdF6BRbcZBtL/dtpCu3XCZr7p3qiNX9S8UJ38NdpZqMpuTwO3Q1sSVaRtXrdiQ9HCVca2HppTJtCmHZfmufLikgowOeGVj6W3qZ+4rT5ZoV7keqeirlOCOiOwEOPg+jAV+khNnNG3LHy3rFEUMPua/+mR9OzanigHX3iSgEX2IV2llLyYEadETjMQyfwlAXSMmx4UHvfnNLpmJdKsLNJu47U21P/2mN6L8xLrPUZjTL/x+3SP1IF6JPURp6jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=677DgX9T9ucQdvZBk24jzXG9QZcn+e1Vom4MGRh5xlA=;
 b=Y5bRXzWj3TE5ZhKrPAaNTYnEFV/kmQfNzpyMktTZOucxqesC+nDkmwtLzulRsqSqXVWcO9phJhNzB5hD6OVjfHNQ79xHdB/9j5rIlS/Ja80fiUhn+wNPRkTFo8NAFJWGairs4M7E1tfzqjxLLReVUpfJT2dAZXdLz6y+s3eeshMmnynLdlu3x5lj+j8xmbXaAvulX8RbjoJT9Va2uj+9KisGNNi24ApH5tm8fAxm7CP7LUVFMXjlMNtxnF3ZhGfMjHhRz04n0ttoJGZzPJcKDOBKKEzslC/GrhtUpKDLd10Sd16UeTQs9RauFj5pP+SfVAGgfNBjTt4hKytvNvr/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=677DgX9T9ucQdvZBk24jzXG9QZcn+e1Vom4MGRh5xlA=;
 b=bMW2C74vtOVafYhpSOH9u057N0zPf6+7/4JNjbAXI5SYtnvIASvPHltUcVXUY57wJJWIB3PjL4N13ZVZnuyQ8Ay+8l8YFFViXEaDfzW5H9sEuZjn0fcsmBLWsAHYkcG1r9wmUzkZw7Iji3uu4UzANoSPyolw1PTH1qgESUAf7YNoNlkd91n/0BVnzssGW50XvzpS5Dhhqp0V4k+abC4gqVRrofKAbT2BqRIgpoH19ms5lq1xh4dyz9Ero+IAx+sVvtTqqmuMG4pAyYKKBKfphwJnHbDhN9bTByEgCmCa7vSk5A5ESnbBvauwTSgDAfbzToQfruDyR3gCtP4M7n2Q9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5765.apcprd06.prod.outlook.com (2603:1096:101:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Mon, 6 Feb
 2023 14:43:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 14:43:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 2/3] f2fs: add missing description for ipu_policy node
Date:   Mon,  6 Feb 2023 22:43:09 +0800
Message-Id: <20230206144310.2344-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230206144310.2344-1-frank.li@vivo.com>
References: <20230206144310.2344-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f41012-c6cc-4651-6612-08db08507f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3E76/MGJvXeTE4tfPj0wuBs2lldMIL4ivSCet+UcjEveUdxNR4Uae6veknlb2GFjtYf2osDVVaYYd4gA1jjvyvPHe/6NqPLKG81uIc4xACpHereLIotKxNDk4TIDJpW5bT3wouXxlJCOTo/iEgaaTV3RyLc/tJuL4RUsb6UnqYwWsE6XeVBFoLe4CRWjUEx7AxhssFJy+0rot67wo6jUcUf11hTQt1N51JCWCH95+KIMatOdN/m71yqHWoGg0M12iRWKnUSqOrI4WhA+dHbsYJKdUJNlUJxYw+5QWIqfPnD+TdpHx5BiyQ68Gz+C4mg4Zu+HtgtKS6mPHNafzP1oaysixv2CNtE5r/btijI+rhFkJk2VEBxTPE5Wc/h+TDAmqiuo/4FqydO8OJzyn2D6loshzg9cHAszULkGOTDni5vB6QWAG2g6WioddoTPikes21UnQd/gMCCwOj/nI8bgSr7wo/1dQm43ZlkZvPLoJyYJIOtGiS5Uj19i/1hi37qn8ctoujo17UU9avt+mAgD+W/Tb9QnHiAeCorQYuf/UBTA0C17zFBjkDYT0FR3RuPQjAiG/qz2lkUBW4pBaT8g9fALulev1Dy5wUD/rTOOv0i/dbG7Fuqr8wvNl8u7zO0m5arIOJEZelxBORWnAOw95/H9o+ZQFdYNlKj8slPGLqXKaiSMPUhqnHFpqOjPHswGNCPCk67TzQiEaOpRmngig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199018)(38100700002)(8936002)(86362001)(107886003)(6666004)(36756003)(2616005)(38350700002)(19627235002)(6486002)(2906002)(478600001)(52116002)(66946007)(66476007)(316002)(6512007)(41300700001)(4326008)(83380400001)(186003)(5660300002)(26005)(6506007)(1076003)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJzwUF8imPOoSS96JnJ8q0lU69cHYWh//35/8u0mDqcroi3WN8NknJEMS3yE?=
 =?us-ascii?Q?vlaIMTs0J33B7Xaypa8sAuAIOst9oZN78+ggTel2Xi2G31OpvUefy5W/wmAR?=
 =?us-ascii?Q?phsEIWqz56DDBhwMxHL7EG9vSedKz/u0SkdmgpRnedk69mM0oFSX7B0ze/5Q?=
 =?us-ascii?Q?YKQUipaNUJcPwU1ymlsrI1a8DqtwtHO/UGACO6EsFIqX3uS2yyHgfTYMoZG4?=
 =?us-ascii?Q?fss6qQSzDzQE6A+lcUwQYGSiQD3MIHp5wBYKTfdWAP1C52Sc9wjMu2z58pEU?=
 =?us-ascii?Q?ddiAzEdkfu8meq4kohb0QOKELYisw0+CbFVk8fKszjOgd/Hetp9JIcdh+4ij?=
 =?us-ascii?Q?bLulzHm049uqB1AhTFfoMs1333GDTZp8iaR6mGz4WfeRqCFYZX0sbQaQEzg2?=
 =?us-ascii?Q?83xWq+JEx9xUkcoKgNVkwTEIuMZ2s1dGadwIm2ZzBVutuy+U6tkWiPGTE4be?=
 =?us-ascii?Q?2CGqP1znlcU9YJ+urt5Xo6m8GwIcKteORLxrJUVSV9ZwC7/5PHH1ogeJW62V?=
 =?us-ascii?Q?iGu3Xq4tBcLjRiCA2cvSb5tkIk8XFbJnEq5LhS4mjk8W2zeBwem2z+ITFKei?=
 =?us-ascii?Q?IhHNHAHp7LBp4tR39LeQMqK3v43qPvy4bs0oHYCOsA0cFICEBNBgKL+ZE8IT?=
 =?us-ascii?Q?Gzhw44y23dnmJ2o4nDm1n+KQRkn7jakwh8KwnYotL/QyEz5Uids9MyYit/V8?=
 =?us-ascii?Q?+brcYSsQcgxYUNJieDAdiapbLWQiP3ZFpJaXzzoAl+LugHe2d/XLepmGQtCB?=
 =?us-ascii?Q?LXldFX6lQCm3PUbwGuozeKjlCxf8v2HpEYbpgFL9qjfDgKxouTfBbE6gJlEG?=
 =?us-ascii?Q?P6WobFwpITxKXPWlkmqlw78Pe5fT5NcVPkOSaM7BXRSydbZju2jmfM8IH/nh?=
 =?us-ascii?Q?D+G6mzj34qX3MSIbv0OXCWur8y1Cd/vqwWmnyMAn+6Im/72lz90QtUYTNEhC?=
 =?us-ascii?Q?w/vEgIafpaHRKhdk7ez83wJDuTv0vF8jDaQG0tVUG9YhcCo90hQezrwyG+vW?=
 =?us-ascii?Q?q3zpBJYWFyD1pvcNSxMv/LIj5i1PhCZ4s635S76BFawMS9PclpQzow/3xeOs?=
 =?us-ascii?Q?3A9WfRGQXI1C4jRoXcs2LHpFlFgMU4wxOjcoC9c1OXJVeSkWzhITfkB1/7Oz?=
 =?us-ascii?Q?Ehm19RammnnXAU+QZ4dOH9Ql8xbLIk0fpEAxcYyGyQaLT1g06rJTI1NZldxh?=
 =?us-ascii?Q?+dXMtjZNF/2bIxCkmxo8S/sihVmF5pOTnlwJdk015G0kzOQfljuzNJg/56Ih?=
 =?us-ascii?Q?jeoP9/TAAbpjYV+iICJifH+139YwBBDhJgME1b4rHMtaK8NkQ1oVzYkptWKy?=
 =?us-ascii?Q?MG8M990XjE59qHI1z4ULzW+93CMxC8DHLo4ZSesLvVeOx5eHOpAfOFqMv/jA?=
 =?us-ascii?Q?gwYHChD21l1iA/PMHmm4856uMOfDUC798BbT/nSUU2Ghpcqqx1tqcIbD+fvI?=
 =?us-ascii?Q?l1lf8ikRvUQ2XXocF9EUUE98OQX8BhlDn8TCzDSz2ALXTyDapcixFnAfVS3F?=
 =?us-ascii?Q?YHNC0rQhbipdOveETK13K6OGZylpHkNlQK/tx5hfKwUp+fX25X0iB1Vm+Sg+?=
 =?us-ascii?Q?cGMtvS8Bu7Bu8IpcKwGN/tPr4POvcdHO2M3APkAX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f41012-c6cc-4651-6612-08db08507f19
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 14:43:22.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4++sl523c4ohZCLxbBVrBZX9WiBw1b2LJ2kojei4rwPxz4dGG46mlxcP11tEKGdtxzi0I1vv83jMwcfFbFILVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPU policy can be disabled, let's add description for it and other policy.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
v4:
-add Reviewed-by tag
 Documentation/ABI/testing/sysfs-fs-f2fs | 27 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0f17adc80488..94132745ecbe 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -49,16 +49,23 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
 Description:	Controls the in-place-update policy.
 		updates in f2fs. User can set:
 
-		====  =================
-		0x01  F2FS_IPU_FORCE
-		0x02  F2FS_IPU_SSR
-		0x04  F2FS_IPU_UTIL
-		0x08  F2FS_IPU_SSR_UTIL
-		0x10  F2FS_IPU_FSYNC
-		0x20  F2FS_IPU_ASYNC
-		0x40  F2FS_IPU_NOCACHE
-		0x80  F2FS_IPU_HONOR_OPU_WRITE
-		====  =================
+		===== =============== ===================================================
+		value policy          description
+		0x00  DISABLE         disable IPU(=default option in LFS mode)
+		0x01  FORCE           all the time
+		0x02  SSR             if SSR mode is activated
+		0x04  UTIL            if FS utilization is over threashold
+		0x08  SSR_UTIL        if SSR mode is activated and FS utilization is over
+		                      threashold
+		0x10  FSYNC           activated in fsync path only for high performance
+		                      flash storages. IPU will be triggered only if the
+		                      # of dirty pages over min_fsync_blocks.
+		                      (=default option)
+		0x20  ASYNC           do IPU given by asynchronous write requests
+		0x40  NOCACHE         disable IPU bio cache
+		0x80  HONOR_OPU_WRITE use OPU write prior to IPU write if inode has
+		                      FI_OPU_WRITE flag
+		===== =============== ===================================================
 
 		Refer segment.h for details.
 
-- 
2.25.1

