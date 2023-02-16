Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113EC699C77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBPSjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPSjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:39:39 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2110.outbound.protection.outlook.com [40.107.215.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D75036D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:39:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbqNyrGtNr9dpUsEsjEDZXEU4PkdIDamw9oheHca6Q0C1FyLrG0EFvf1AWL16MQ6cyWcWbm8DHI0wW9DvPcb9VJTHCnuWmwmY1zJ9jJ9VigW38m26tR2HCvxutfMyvFEAxVtnkTYUcKUvbY8tJzXqThvD5GDWLrv1K9DhoHDO+vvi9FKjvQYzZ4kBP56iRMiR5suu9nRqt2xVOJfj4J3zAyjna/m7tBc7t/I+Ed2es//eUzPkJrX1A9G3E/pMWrUhr1ZMvSu2vNEOfgbg4itYUS9sOqh1NeAiIAlBu/cKPq9uM9LPA5e3TFUcv/fLzCGkwyBOZ9OJmexpgJi47fQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFbjTKmo/pXL2nDjChjaX+2/rnMGgJB5qneLMNYpgrw=;
 b=FQb+NM9nYQ1JrqvyfX0uDPQ5y3JsVN0CMnG7BWi5+Pn7TlB/EVi5HjjQs/jD3cdffGhpUpxEn+3eBWiF2GP7sxU+cCmH/SxcgTqHhHrtg4jLKHh6M13nyIg2fdNeVBMmGYqAiXjiLYOkHxYIxBeEXMI1DpOK2vEVC/mJRW40+swrjpSEax6Sv9anXFNepPZcSe5sl0xY6JrwgAfQi1MU4gx/DBfOVb0uL2Htt0vF/SWJRI9tcHEknUBbTDazZQBbzsZTv/CEUQ9H+eTvRbtxQUqb1MYRhRPPdzGOjGDH97c9U33pI2+LoLBi01C8f55RdnchP+PjAqKsnsNdDTaGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFbjTKmo/pXL2nDjChjaX+2/rnMGgJB5qneLMNYpgrw=;
 b=QrNuFm3Z/Pdk2l7eThx8laIgCODXCDaFTBcLXCs+3dGLoNBkFQYXKORuHJHBqGMHwAo8s7UrYQUCjl4x6G+y6aX1Pgj0iRnfGI3drNMOAIURf1m90Wtco1orW6mefrhYQ8MAl9Hfw6WqTgh93fdnWSJmCN6Sr4R33WzzE3OCzywefJ78uHWFtoOmdKYFf4ZJTFCI4oFlVE6XobOmn+cgnHwa4+IPxqOzC2+cnob0op3YDx1irhfRzhgUhDNMcncEQG29uZBNnJxLuFi8s6TWjCutphfBRF8kujRmz56sqhEhCmRdoXLpxtkwqD0LJ2eO/wiYrkPFm+s35obyyOJq/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SEZPR06MB5389.apcprd06.prod.outlook.com (2603:1096:101:64::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 18:39:16 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%3]) with mapi id 15.20.6111.009; Thu, 16 Feb 2023
 18:39:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: bugon w/ SBI_NEED_FSCK when has CONFIG_F2FS_CHECK_FS
Date:   Fri, 17 Feb 2023 02:39:06 +0800
Message-Id: <20230216183906.54541-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SEZPR06MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 82059615-09be-4c13-8cd5-08db104d1b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zrlI9R+KI8sJ6QlFwClOiVqPrEsbxfW36f8cQY1Cq1ZTt/oP0HIAhLhGmWvK7119ZnSiwFju8iPNUtpGT7b0dRXuTEYHdxt7XMWjXGoi8ZmXpTOTXnNfjgwXjhuoNBIg6VWMqk7oSxbVnkP4kCemfCVDwz5QgbvcbDXZDn17BbV0VzlpPU9oNxggd2PThjuQu+kz7TqeAsrJQgzDl+F91W69mq+FSbjhedrGqU+9qLaTzNWqeovnExx3y6TJXvVBggMzA0Y9fI76vqUXUkH95QAIC/tlSC45NTODpfZSo+R2k9kzn00gEhzostyXnJJ3lVB5HyiRfyv0HASH8XTMiptLD/Kyjy7/ywEDKtz9B+ro5BiczmlnZgd/vZl0lIv61XWwe05AtwZzo5klj+AWBiwpRaEfEW5eDSQLd2b2owKE21gL7Qnt7souC0rdfB5YyJrYNDQD2y5PzjtGI92JiG1DqWntlNOcSd+eNZQnlURs3XAbQtpBXnqzwki4VUBtsAJDZFYgUXmmA5mHrI+a58YrTiFyV9BP5T/c021urQ/PMOpz6jfJBOrieEN//OBuNVZZakKWIHP5JO+TPfY2WucLpQx0UVTVQtulQh9plb2L/KPaVeKlmqlbavgeoD1VTto+Xjj6K4TbUrfsklJOLb97avNGItfnWHNCPFrkGlx+wZz7Ii3ocZVuf9sF2+nUS+1Ok8u6KPnYQqzmCNtzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199018)(36756003)(86362001)(4326008)(66476007)(66556008)(66946007)(8676002)(38100700002)(38350700002)(2616005)(186003)(52116002)(6486002)(478600001)(6512007)(26005)(6666004)(8936002)(6506007)(1076003)(4744005)(316002)(5660300002)(2906002)(107886003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0MfCrvn0wf6tQGrgiCiLiHRp8jQajnCFbFYxgrt/TsVpsBHBIP9DVRKJsFAt?=
 =?us-ascii?Q?5VlEWpnea+MzgZmFLf6zebc9FAG70mtWpAMDB0M6MJZNbZHuaApMx6fWwW7N?=
 =?us-ascii?Q?Nfvi1qE/DPEitr7lcAMKoUYHL8z62Kc0+73GHpWpCH2qP+ZJ+PqO4oxH5jKT?=
 =?us-ascii?Q?MKybwX1BdxZujPguSey/y8KID1lOWOMHfn3pN5MtizbO0L6s7Qv7psPQ8RKW?=
 =?us-ascii?Q?+TVbCUF6WdFif9o+P8nVcCkJXhSCTYumovEpo+I6xcnGgt9P1+yaP1k8Lkmv?=
 =?us-ascii?Q?8Oktx+jmGPXxWzD1mxP6n4R9Bl9l2h9JKSkef1dE7GCf6MD1Gp3I0YwP9dxW?=
 =?us-ascii?Q?aSdjCQQ+1A8ndP+34jd/DlaCdt4MVGVepBNFCcJbFgtQTo43Bw+1SDVAhptP?=
 =?us-ascii?Q?qxjHM41eCO48U16SJVLSEBByqjOO2798mSOW/KBI1RH+wyLBMt5yt42JlLVm?=
 =?us-ascii?Q?p6yMeFYHGFP/rs44HyBDovGrnjrO04AcR1Eg7wYc7BsRN9dvqmSNiM7oBc1Q?=
 =?us-ascii?Q?LGanC5GtsWaQfdOQypIXbWFfq+IPG4RorZra9s1axlX/MIAURuigbUmDk6KV?=
 =?us-ascii?Q?8EETD7WCkyHfIrqY+okBMzWNG7/UalctO2Cqmq/BBuzSdZGJp4SvHlpPef8X?=
 =?us-ascii?Q?9OwfliZCfWRkGbhhnID04QTxqJAqTGC8FbXjzR8UfM7e89x69Pof2pM6jul/?=
 =?us-ascii?Q?gZG7GgBMEEqKcQshIM4fHi/yA3qarfXz0469PGeXNziKsik8CWL+XcGIk1V/?=
 =?us-ascii?Q?stBEt69pTcNC9J6qAzc1hLpDzKeL0xiz84Ij9dLiu7db84wL0LfbZ12KkKrM?=
 =?us-ascii?Q?44CaqueAkG8s+Gqg7BRJlxm71fW829zBEMPq7yp5VQTHMfJwhE+4RRTvQYrZ?=
 =?us-ascii?Q?0HY0RUnzOKS/JPFkNIeRCZVXH9T6bV+CZrLToE9gnodQKV16aFTNs3j8/dhW?=
 =?us-ascii?Q?fTnmKNgnWsGj2NWJ6QUf/6HiSarnLJtXRsLEh+wTLPEP5Viqn4MVs17PKnXu?=
 =?us-ascii?Q?zYuktgMlkqrY/UDYf9uXK7aT4feO7BNDZBDxxpTcjuUh0NSRv8Nv0qgHdnCS?=
 =?us-ascii?Q?cuBy/kzOwcNEyQxU9VgvVV/0hKbcMsexYGM02zZ+i6Vx3zQedhBJ3kQmD/24?=
 =?us-ascii?Q?PV8u951hIM76qPqoiR3cMFRNXx8ZwWOXRobwa0O9wXliqAFMt5ifDQfzr6ko?=
 =?us-ascii?Q?Fcu5dDoWUwmTR4mIAocTciqbXO+fTSw+eoJPjBFMT3mLOUXoH0o7NH5tZ+gN?=
 =?us-ascii?Q?D6rLQAOS+UgCabcGzzBfUxrOY99qXRTrQ+SeRdQzkLO/Nt0flDK9PK59duY8?=
 =?us-ascii?Q?HAf8d1FiufsqCG9cnkBsWzoA06P8unM2TJHJ+dpiadSYbWGLVK3dH7NGmA9n?=
 =?us-ascii?Q?nZbRNvPT8uNDkO44EJo0Zv3I2aMaGzHgI+Jl57JwLgUAiDeiIgEln6fCP8Q3?=
 =?us-ascii?Q?35aor42cVh4q/x2VM30RX9uruL1c1uideamLLlxCptmdahcM/3qQJtFNOLhK?=
 =?us-ascii?Q?H1DR0L4akVoTa7+WEYKTRmPG9IJ2+LnIn5pVTnvRKvyhW6YuHzOfuzYY6qXq?=
 =?us-ascii?Q?pwIyOB3n4W0h/YIiADKgA4hkaF19s80WKibSTGt3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82059615-09be-4c13-8cd5-08db104d1b58
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 18:39:16.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnoAbyx4WbxFtkXtAjkffVerugHwfFnx1JMsvJ+DMvxB9Gv4dWHs+gdcgcbPcPTUWwIQ4dVMKCRuE4yQ7skz6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5389
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI_NEED_FSCK flag usually means that the data in the
file system is abnormal, and the fsck tool needs to be used.
When CONFIG_F2FS_CHECK_FS is enabled, let us trigger bug_on
at the first moment when SBI_NEED_FSCK is set, so as to
analyze the first scene.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 21596e0266ba..055bb7246a1f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2074,6 +2074,9 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 
 static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_bug_on(sbi, type == SBI_NEED_FSCK);
+#endif
 	set_bit(type, &sbi->s_flag);
 }
 
-- 
2.25.1

