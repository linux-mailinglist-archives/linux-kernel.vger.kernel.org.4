Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3B60F6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiJ0MIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiJ0MIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:08:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2125.outbound.protection.outlook.com [40.107.215.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7D5DCE80
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMtRq0ZJU7tsgcm4mR+v9IIIo9kXrabIT1QxfoIGxMUhqODEPaIeo5BfRUa+GjsXQWzQqdNxCUY72Tsrjcl8s9tJJqUVl/RXKZxwV6Z1XCggStmjIblv7/n56+ua1VgPTsk8GzAJ2mwXAz3XobgLn518U+dLy5f0VGWisHi2Si6lEDfNu+UjgwVtH2e6X6Exp0sWkOXxE/CfHrKFCrX4Cn8crUA4R91uHrSpuINyze+790oY4DsT5LN5mJlrB/lveZdGq5i2NEDreK3AxRcbfsx76hzI9ZOx92Wydm1qvofikQkc/P9hlIXJWCQemQEvL26GsIfnvQylup6bGU3uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BXG8Fp97L6EsHvAXor2ZVALxWwWblT4dH7op06AhfQ=;
 b=AAJnpTuRNPXyNSo5zuVldXDSMI1jvtSVIcv0mTmxl1RBUO3DC6eFX4m3Y0tsQEeY+gT0dCIRTA4RJuGnWK7A+ssv+dcbwsISN0LaduYhCh8o4lu1w+dIbPkBMzpqukaX6I+ca8udyubyE8yocw4seOQYjaZgLLPK8DtAOWtUj28kxV6fWefJrQutLQiS/3GFnS81RXz0IkS/dy3ndpf22HizCe3R6Epp0HMNeSEiEMzRxA4hPOCajUB/fNDx76XIy47ACuEscH+g4Qs+dqndUUNZaCYOyeG3Fteks3D0Rhk2fSE75Z3WFPqaMK6cI4RJ9CNJP8FNwq0lA20GQ7e7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BXG8Fp97L6EsHvAXor2ZVALxWwWblT4dH7op06AhfQ=;
 b=PCk/cZImjbtP3lU2EIc7XJK4CsyJFBG9IiIv1BsIHBAd9i56lmnbWvqm44R6wAPz+VAMZqnVy4VgWE0m1bA/PMvZh8ETFWY+fRajSdNASO9nnmdlW1vE1JBOiEeVwnBouRsEbxwVyXw/N0QU9eAB4cCpRoLBvn/lrPSX2Yvpy6v5cLwuvrOdxinQubTMa37DmT33dJxO6Kjt533k7QjjYZ2hAG5MD9hKEFg+KcLIjt7R3rkTcpdNF9wakaqSGsr0UVh+Cya1VSHRPRpGBrO9sroNiCX2WN505PRs6Bv8SFvyPWt3GcrLxtEfOv00Kg2fzb021rQh+NQMvFCc0zBf5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4468.apcprd06.prod.outlook.com (2603:1096:820:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 12:08:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Thu, 27 Oct 2022
 12:08:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error when errors=remount-ro
Date:   Thu, 27 Oct 2022 20:08:07 +0800
Message-Id: <20221027120807.6337-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221027120807.6337-1-frank.li@vivo.com>
References: <20221027120807.6337-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 037dc5a4-6192-4f99-7af1-08dab813f118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tC9Hroagrlvp5OYzDb51PDnJ+90dX4w8hc/UCsXzwUcukok+LS7DfZAKWYMEH7ptG6IcND3pc2pFDwPHOWBTGF9AYSxbrhnLKPrpw86307CV5mq3q09i1bZfGrm+jKpWVUMAIz7asDHoXbRUhpC+YQFkT9sa7lGHBgOY3DTzc3F/94nVg0F7HSyXVUeZQgP/b6h1fVp6l53Uct+Z9KhMHGztJgQN+E5zNzqSRTcYByvi7cq48ESBsaH5ni50LF63mGBbXe6XzXF7aiZPoLdgIYWggrJqaxuim+mgwQPabn7C6dEiX6YmfW6xu2pFCQzHDoG8VjJHBaI0M9jJICY90zpudDD0hHXtR1PJC1gZBxv9h75PsBx1uaSPxgfU6bxkoO1fQmBvhgQxDcFci7goDBcgTcr1VPTc+0PsCLbPjMqiCCpJNTzcije+A1Zu9oKb2npwMqya5+CJUTi+EqM60hBwEWAzLU3IZFCssLtjmHZFXc7Ty9YjYz8USn9TsI4r0wdeX6ROXgRAqg8+4YA/5qKPYSjqAJtsXCVTnC8ag3CkzuquXdp5t0viYv9aY9j8kmkVtaVQYNCaHyewWxtEYPlqG1bGBOju+MNm7gg0/QxadxJhFY6uRuY844YfIVzMvGQGPu89cpdxTA9+V2/rGJeNiWnNz2X/PjVJ/su6QStQ7L2T49+9/y7BeoSnRX8D2ub9xB1hsufwSrpGlcUa3jmIt7TQkIdi7WnUKhKUZcxoxlKatQX50P8+tAD31BTWqslmOj2PBFjUyGfOup5xSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(36756003)(186003)(1076003)(6486002)(52116002)(6506007)(6666004)(478600001)(107886003)(2616005)(5660300002)(8936002)(66556008)(4326008)(26005)(38350700002)(38100700002)(316002)(6512007)(4744005)(41300700001)(2906002)(66476007)(8676002)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8JA+e06gWdkMLKaROAVxUPg1dhGS97eX00KPEa7XCTe2A2V0EfXQb+KGJQa?=
 =?us-ascii?Q?4yUWVC3qBAyugmIj80lKuVfUSz6fJudlb7v84t/gDKhP3YxUq4vOvF1ObWAX?=
 =?us-ascii?Q?3gbEHwfXRRFgpz81LD8NITQ4NGLKlsJB6ZZCdexeoDgT1zcsUbJO8vO0+ns0?=
 =?us-ascii?Q?iCTaKRe/URUcGKVM/w1cPgSFU1rkR32S9eNxWugnO39/3eqxHI+QFas6x7ND?=
 =?us-ascii?Q?poI+c7YLon9loZCUgW+nPJ72OXOO+4tt3coyZ8T1b59QPwfw5EndfvojLSMm?=
 =?us-ascii?Q?W5ZHSxKzhohPM/xNe9HQhBVPUONd9/P/Q2nxkaLSF2eH0PAII+9RtPXCBhW0?=
 =?us-ascii?Q?GOZGjFgcAJtKg1t1hPqrYTNifqTUZuE9w7WWmtUYeLrk0a7HZ7Fy6E10EGig?=
 =?us-ascii?Q?srVVcd0YNsyhM7I3NkszVe4v66geut3I6iniQYc0VXqhN8U+Q2fUmrW3c51T?=
 =?us-ascii?Q?rMqo8Tznray0moapooUayOQ0Q7gaLhKKEO/6TSmOFF2IFNMkF63Um24ODind?=
 =?us-ascii?Q?E9bdz2Ta/DIEESWg8rEpi2AdksBDDf3yveVU+2+Q3nsrw9HycXijSBfgmNls?=
 =?us-ascii?Q?m3pemIPxYjaEy4uk7fWi9nz4/EPRu90X6scfy+LysG3fNGJtejUqZhawJwkb?=
 =?us-ascii?Q?eG9QUsUg4y2CXOaF+xwAHpF0xNUiCJTVuZCsf7VCizXH8sAjgR4A1dYrlVTY?=
 =?us-ascii?Q?qdzVaGpYftSTa6dKY2RcCtpEf9uqD+jVmfKEhk+bDLyt5wFFYsRenE6X1WYt?=
 =?us-ascii?Q?dgslrc61oLfnG1pQ0t/aNjpuoJglNRBQjzopz/dZgYTmWpg1ZXcfP5rOT7pf?=
 =?us-ascii?Q?fmPm7TLhErfTXFXf0/vCYadEnUx56KxbSsofvhnrrIE97cR0xc3yYO4z+nQo?=
 =?us-ascii?Q?rCIH2YIUZf7yZ9xwrogMo5Nt8Odd6NIxEl0Q+qhWHzh/qIsIHXNboFAyjRT5?=
 =?us-ascii?Q?cNWzJmRpqoqm0Agsoj1n4lsMV0f45sHFJQfdsKj3kxvhZREUQyePAgT4Q1mX?=
 =?us-ascii?Q?ZMAt1Bcd7bZGdss/Boug3oKLjPZBUjHJ9/VmPyMXV+7jDA9CtbS5rbHvcWUl?=
 =?us-ascii?Q?+h7Ud+H+3GWwwhHGIFHrb/xh6ASEcz9tGcRol1B0/XgV8IKMGdcfajoajWdR?=
 =?us-ascii?Q?/F8MBMNZqqIcaGTumkiEaD7xcPeQfx/JnzVIUeRBVwunyoHnGAqQE79sTSCv?=
 =?us-ascii?Q?R6JsW5vrlkiKNh6RZMSYddS926VsQyOLUIuXyBlDMwd4aaxPAnYd3iZNuy7E?=
 =?us-ascii?Q?czPv8bVWY2Fk5zek1nyEGDFfcU7dXQENiE0aK3WhvHptVi7+4IaBcCCE+KoX?=
 =?us-ascii?Q?CoPrT37HOHzQMfSsgOU3lDbo0jiuQP2UjAShW090k1RNGyV+zYijRRH4Lpsq?=
 =?us-ascii?Q?j0MaQB1mnvkNwHkDY9QKHJA4h28Fb+W0dFm9Z6mmoNKduNwNG+mg/gugvg4E?=
 =?us-ascii?Q?2JyDhdWlmKfKhewuCYD5z5/hukRIkR79qlgwoBGufgrpEiWoSWxnlTCHBNK9?=
 =?us-ascii?Q?y/ponBF3HQ8jWXLt9pzh78wMPrGlgBFwR5omVr431VdMo8taFpX/GN/BM/mc?=
 =?us-ascii?Q?ABDnoosr9/Dw2u0FwCZJLY9qdWvDX3T6Txy6QxW+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037dc5a4-6192-4f99-7af1-08dab813f118
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 12:08:21.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUR49QDZdILOY62IeIja6H/3EcYwTX/q4uLhOAF6zrTK5egMQsHJJ7E4AQ9cBEVY9VDOsHuloqdhEceEHw1gQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a fatal error occurs in the file system and it is
remounted to ro mode, the flush thread needs to be stopped.

Fixes: d81ab30e85a5 ("f2fs: support errors=remount-ro|continue|panic mountoption")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fc220b5c5599..3a1238a82dc9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4017,6 +4017,7 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 
 	f2fs_stop_gc_thread(sbi);
 	f2fs_stop_discard_thread(sbi);
+	f2fs_stop_flush_thread(sbi);
 }
 
 static void f2fs_record_error_work(struct work_struct *work)
-- 
2.25.1

