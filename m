Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D355B6EE60A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjDYQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjDYQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:47:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D727CC12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWRhC4Xi/gfMttPAoYCpCwIRRtIr8wls16dbrOBCqGJCn/5dX8sWODJffQUAWnUv6s7UKd6Q0dMZeTIdlmyJX76cymDGD5R5BN53ZcyB/ChI7GI0tgjBVPDEnxWl51pnHtn1Wa87+uSyct/0Ob6scZvtz/CZZPfGHwxRWRh8LNaD7XWY6XzPqga2HgOw+VfjhRyLJ2ujGEvmuCo7uzxwhXPXOZ7mQy9oHsiLiuF+EBojAEs+Vw6joH7g9mmo1dYdYrjzg1iQFI6dc+3VobRKwoYQKVMSjm3nArlB5My6jPnERTuoxCtSJyE1br2C3g/sK3gW3jK3cR4mXVWOvgGylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOEMYFpnUf1+8VTxWdcAC6BmtS5NSP2nCuDrMYfzKiU=;
 b=QClBNZ6Q3XlA719Xwp+UhKObYNQLfpZ81MiB6huBLDfjvLV/QDWXTrzzFAgCRZgndrZc5OQczrMadtNcmGDlnx43Ewlk4atG6GkJpQlP+LpZ+GzOzntJV5Ss8QqYUjCt2HM9xUG9G+I+GKLK7BSccNtkpbcvQKfO+hJJ/PphSdCf0R5WumAs1+/UB6xiPSkVTw34IN4mAIFc/BMyyYFwh3ArQfa4mS15+CAiZ6fryNXMSPUz9iUw+a3uK6H9VoIjKG1pMvUzW8JrWUqI6i5wqkxC1VUb2tNqB+EDS6gKKxsU7QFaNUj6v5ub9Oaih6O594RxJ4NSzMSfTCRsxlLfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOEMYFpnUf1+8VTxWdcAC6BmtS5NSP2nCuDrMYfzKiU=;
 b=CcIfinkFJh6M1jrTwhzCuR1H9qn7/cUAkSzho9E2miSih7hwVaj4qGfFDT8XzkFKU6Efy4X8Cv6HG5RvRBRHEKIToKPcvAu6BxkHc1Y+zESHKg/hMN7Y25Sm8i3KkcEtM4mDecXyHBl1NYLdhGi4D0SboyruAo3a2tRdTNSMNBksyU2h6RihLIdUDsv/fNSuH4WRLzrqJLUr+dApoQDxpRSFqDAwPscM2JF1jZM+ednVGF0f3RG2RdnLjnB3VeLUjRGQRRG3Xd+KLwAh6OnSpdhplx4jZ+77klbvb3vjDRP+AaVn8CW+a6FlDVsOQbCJroAcvzr8kIp8pHKw90TSLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5522.apcprd06.prod.outlook.com (2603:1096:101:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 16:47:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 16:47:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Cc:     Yangtao Li <frank.li@vivo.com>, Qi Han <hanqi@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: do not allow to defragment files have FI_COMPRESS_RELEASED
Date:   Wed, 26 Apr 2023 00:47:11 +0800
Message-Id: <20230425164711.19826-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4a933a-0435-4eb7-d493-08db45acbeee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLdg9D/6OK4+4QO2jKiucpan2N798vfnF8aJ3ZVq/DvOSidcL6HWnNXqvk4odJpv3yUNHf+FXwZrJ1d+55+wC+hFK3+YPu0I5DGOHy7FXeTMeTeAJYd6yyxhs2pWjLVpOyxUROz8XYfEKE5qt+azGg82nrT7cKFIlZnY55MQM6bZfaVg+LosdSF0gb78NYk+JmZgGcQHPqb3XqPD2avamrt2AqhdZLvBcuwWcsXwcEJICAHcmDSMabam6sDnay5JGflyIvpM5rc6cyCK7i3C/zjgwPYOBki78EXbZn/LcxGoTJlmoLFBIxPzXjqJLBklWe+d4k+W+aIZ6l+DFr+GUKaj+BkGCDJ0TODp23I1HJfPVus3B7JfOe4ChuiVzwzKAYvRbiEKGc8QQEs3eHXgyG18XGNO7Ol34n9YsOrlVaAt/7LcZAMW9kVtbKhi0fgItLz8HhSlWXv4gclBNhwfVgtMEPHDzq/OfJ8lJMheD9XKXaJCAnH0RXxEfPLM7Qz2Z+ywOdyRYrEwEk87sOKVZl+pCWdndF0RNBsCLSZ9hZZGuCobGnYJ7QEz73ospDq4jNkDYBjioSOChhaFH9RwATfJzRicknd+A/7mImsW34g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(52116002)(4744005)(2906002)(6486002)(83380400001)(86362001)(36756003)(2616005)(8676002)(41300700001)(66946007)(66556008)(66476007)(478600001)(4326008)(6666004)(6512007)(26005)(1076003)(6506007)(186003)(8936002)(38350700002)(38100700002)(316002)(110136005)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lFjotm+2Ru7E6UfUrAw++kVH4ZRRiFNbBc/eQ2kiHLvYl74ls1yklMAU/HCh?=
 =?us-ascii?Q?Rr8B96yAB2uZdWjT8lmxFJLbQfsavXhfPoifL7V9DyPtDlQpWztvXCnCQOFF?=
 =?us-ascii?Q?XoOsqjqqIOlbJI5x0T8zqVBMxZmRrYY441rAzD4IilGklB0Yed/d0pnc9jFQ?=
 =?us-ascii?Q?EdaOvmOPzupvFoawXPs6x4gPzX/FZZvZKrLxO9gsXk4DRjWqP9ZNRsJM9y/6?=
 =?us-ascii?Q?1sUk/H3ki6s1qQSBusmbi67wIPQPP/oEp+Bnuqqd5/Jd2pmsRjFlE39qj3SI?=
 =?us-ascii?Q?SJBNEB7D67JZX5gjjGdUl5bS8YyZnKJtpYEdgyvEEammBf06CLnHTxoyxhS4?=
 =?us-ascii?Q?CPKs71pta6Zw0sG2uuRbhhf8TeX3bgx6a891gCv5486Y0gwAG83Rzh5VbmPi?=
 =?us-ascii?Q?yW4VoAW/U0KpaiDtbX7qQOezT+xqin/ZsFpKKRCwCu0sGUcS3C+iPpW0RTXT?=
 =?us-ascii?Q?CXsvNCaaPYrX7HycK1cnRarjhYh3j+n7pAjmkhr2OvJEqj8/aGJ5ARF14L9C?=
 =?us-ascii?Q?/t7QbnN6NMsWKkv73H9U38I+jd+1yT+s80T3kNN6uAZnFtmo9QRg1vQ3+arv?=
 =?us-ascii?Q?bw3azDiTb52aDP23OVawvIV9EfCEcc0lMloMXrbRIwp37hJZXOhepPtCV4+E?=
 =?us-ascii?Q?vQ6EHnSIhyhYyAgGXe1LYsPVrk8olZZq1qCR9Opkk6hv2UcfVq1dhvlRbDnL?=
 =?us-ascii?Q?Chetx18H1r90GvVz6TCLz3Sya2+tHj2YlniWdEQtP1tTrPFYds3gqtiSZirS?=
 =?us-ascii?Q?WtWaAlTe1BgObjJIkCV1wxP2KpeXXrtMVEEQ3jDOL76j5TTCwcugLm0t7dFD?=
 =?us-ascii?Q?vqIWI/UDOkxvpNdg5S1V1Da4fc3B7B2APqeh1R1UhBccSsQdUfhU1TbsQQyf?=
 =?us-ascii?Q?lwWRuHInaX7Qq1Ijg4+gfHjGV+P5RVIT79hXBszqIPPpJZFMiqMHhxLiyUTU?=
 =?us-ascii?Q?875StjODHXcUE3pinJ/izCOpZPDz1eQK2Mv8K1jVuU92sdUMm4znkaoKlFmA?=
 =?us-ascii?Q?v+zxSDra+RFNWrdVHsfwO+R24vbreJQIphBuCKWSbycGrdvoh62JV0+9qsfI?=
 =?us-ascii?Q?nLE4WyADssYwbuWKaD5o+KAi5a0+rYIbeITiuYlPdCeFCQfVJ0cytafWphxr?=
 =?us-ascii?Q?fY7Recre0NfeIBHDD8q+dy0DMu7NcEeDlMYgeDdesJR9TcOT44cg5Ev64jY9?=
 =?us-ascii?Q?sfLS1IijyuzdRvQQ/6VPIhEaAmEY19Bc6t2AM6fC/6CGIWjNH+OFxHUNnDWR?=
 =?us-ascii?Q?PlHpKUt25GqsCFyzJ0lU2QcgMcI6LlD3J29Wl1BtYmjIZGncZJ+dnCXrbjRH?=
 =?us-ascii?Q?B3oB5Qlf29i8IWdv4Ugu/EZrB92E8ZbtVSaSNnkUcN8eb3AdJhixL9Z8Ene4?=
 =?us-ascii?Q?Dytu0XIXbcR8zd1ykTfiXDqw2nEzl64RDDLTrK70zxxBm7iVjmGBLCROgTcL?=
 =?us-ascii?Q?E9wF99m8jJvm+Pt3KLlm5NzstGoDNoPrl8q/S5wjfraTJVSrFbVvVuKtzt35?=
 =?us-ascii?Q?I1CLt2eJIqvrxHjiyYF90jfru/u8Qai6FgUTMAPWWw80Hkvxgx8wSqxo1bRD?=
 =?us-ascii?Q?54wRQnTkGJUTcJp/jfQTrMaEzaZ5CKhM3InxAdra?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4a933a-0435-4eb7-d493-08db45acbeee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:47:24.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4UR6Yut3mm83b1nmLujefW8dBERvxQv6bE4JvoiwuJZJU0TleTAHN09uANFfc581X6gKaH8eGQYf+7k36+/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a file has FI_COMPRESS_RELEASED, all writes for it should not be
allowed.

Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
Signed-off-by: Qi Han <hanqi@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5ac53d2627d2..46c62923f096 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2593,6 +2593,11 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	inode_lock(inode);
 
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+		inode_unlock(inode);
+		return -EINVAL;
+	}
+
 	/* if in-place-update policy is enabled, don't waste time here */
 	set_inode_flag(inode, FI_OPU_WRITE);
 	if (f2fs_should_update_inplace(inode, NULL)) {
-- 
2.39.0

