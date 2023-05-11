Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB406FEE68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbjEKJNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjEKJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:13:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2AFAF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYnq6kUfCl+QQIiVYluBtfVfKlc7OP6YtfB/t+b4yz317tv2RYH5kDN1eGR1/E7k0JyyN25W4Ukd7/ZbFQ2n5o67Fq0pD4zAXLpQUROWnoRzxo5XjSKNLzJRI9I9Du6IGqI532G2tXHJYjF0IaNL7hPom/ypw8zk16jL5PLwipRIJA29TOdvdZtjFSjzX3FreZSDw+JXfY0UejIFci/ZuqmUqq3RkAWreCooixrrXBZolRNZhKS/gKPQEy9SzCqdaCEjpbKs5pjPIql3EaHYxim2Eqa7WXBgMtWpeUNqTZUVXyG2zBRt1MQaZkgquVVJbzYhujaYNGegb8DUw7OYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyd01Gz0989Bi0WTGp7Or6Ye52CZFtSQKD8g4oqItE4=;
 b=nlhRa/Y7kXvXKrj+f4JhmsJl7UC0C4Yw+wtYj7lRjmcgs5G4nikASq3/UGYHMl2Mq4NABdGw2cQY7bIpw7JlcFdeNYSZlfotyI+KcTw1yCRn9t8ZZ4ZtMc82eyAe8qxwsS/JX4XBb5Hn1YnoVZeSH1Xz2n6TYdmESpfWzHSx8GARw6AeEqQoSOBpcM/r4QXq46TRWGNRkobj22ulKaZa6nvqIDTzJk5Y890TCc8wuROF1i+cCXvUmwmtX3R5GJGY2yiqBSdg/BXOCnpQRxa5zBb3SB1YIt21cQIEsT2koOoSXTSMHit/DteOqqEHtN4t5fom6Ci0xkSUg5dOEJBCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyd01Gz0989Bi0WTGp7Or6Ye52CZFtSQKD8g4oqItE4=;
 b=ROMZx3CvIU4DnpGtlyKLcLymz+P0m4yj9hmN78kzrH4UPZ1oX6c+VkKm1a9+u9gCWL3UUCkbYI0Y+s+02F7uqMTExppTl/VgphmU0lUYWmJ6P+85hs1iBdr97HGgYbDGx/lVDCpR76q5k8YxQxx+0+T1HcKnsYwWaQArDPhMsFG0WMTg3mA3IaFM0/VHVN3sT+yHPSJTV8N/reurhL7q/eK6WJr1RsdkpmoBWA5h5RePHtkwQh2a1lJ2FYxlClgo6nVuqI8rB+3kXgNiwoDZIrLNtoXV+TPQjl+Eul9tHNgRnan5f+EPoRC6aRn4iCZhAYY+D67No7uE89PcK1o5rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5059.apcprd06.prod.outlook.com (2603:1096:4:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 09:13:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 09:13:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: add fsnotify_sb_error() in f2fs_save_errors
Date:   Thu, 11 May 2023 17:13:07 +0800
Message-Id: <20230511091308.10509-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 399be76b-3a3c-4fc4-625c-08db51fff692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/OEu5ZDeKkm1dmg8xQamukUWhVOQgOkvdlX7Ea1GqCn3dvyvTuMVyZXTBwoNWfl2YF2nqYdBIj7ZomzeMHaDwniKqcscOa8tzp+db5CUjrmdwzPj/07t7snMpIulJBzyyjeP2ulMy87CAH+uWWi5NBGK9HH7gaDfT6XKy9qLpeI/L2ktFp7VBVuDEozT455X8iAJbE4mnkT4FvQH6rgo0A7p9lb4f0A2SMSo4qQsp+J1OJWAsxe71UmRmtpG6TAIMDClPiaf2voIUlfGLkk329VCVXxsKgMNvwLs/FzahSh4TZgOWdeOaT6Ki7QbjxdMylSvAcV7SQgATffrX2E3wYv3C+Cd59HrF5vtB9kQEKnzrM6OTeJeppXeDKvjSi9LQxuv7Hl8DPZ66qjlRjUOB7Ha2ecxCPqJu8dSTe4dIz/YpsJfuxG2zKC4miCWlDCBlxXg2oZ+wPiI8XH8bLdMp1mNYOU3uS+3ZoqqnB8xC46dm/q1Y49Tt5yo74gVYKMVzPsiT+mWYx7TLXUC99NMtUdQeLnT2xX3aXAvYbbPatsLasM+DeDcSO4Yn8D1miDkA109OFUyFkMrOIb+ij9djxCCKseElyU0i8rS8nNHctggTldJVcorzqwSuLqkOXN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(478600001)(8676002)(66556008)(66946007)(41300700001)(66476007)(6666004)(4326008)(110136005)(8936002)(6486002)(52116002)(316002)(86362001)(5660300002)(1076003)(38350700002)(186003)(6512007)(6506007)(38100700002)(4744005)(2906002)(26005)(83380400001)(2616005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i1/ie3MIU1/k/2BfBZuV4OtLrXQep2/XOEOd+qB4BSv5xEyfRryfA/Ac7GRd?=
 =?us-ascii?Q?4ZSaSWXfD3W9Bo/67SAetxZFKn71lCtWjVKLiKBUevu5RTTKrjh/OTa2G7p1?=
 =?us-ascii?Q?tXvZIGe4TWKxnjO4jr+BfXtYZR1LgZkucxvWJarPP1ggSZqEN9pbMaYLH4Jt?=
 =?us-ascii?Q?RwbbJGezz7rj8lql1Chl53ekOUpQllskaaQaIJERnHcUs9O4iKdE8cT2dZpe?=
 =?us-ascii?Q?O1yqZMnFkswsofAeA3Nblj0Qe0KVbKzhT/F/f3280UjIyahUi1GHFwLs/IdK?=
 =?us-ascii?Q?r4kKV9A7br38gC9HfcG0LDtwakk1gYqfKG2czhTmu6nO9dhM/SxbCs1nPdzb?=
 =?us-ascii?Q?c3dsNWKxxh7lAUrfyVnUrqFZcl/WTW7Yff5/hfMSD5bDHpfhCe5qJZ8Pvwzu?=
 =?us-ascii?Q?T6fkrafApZVTiCb9SrvA5ksi5PchbiMl0s7VKXowIYKGVWbYncfEOakrQEPS?=
 =?us-ascii?Q?PoObKg1L6GK00m8A80Bh1FmsvLtRE0AudlvHLgGWv3XnUdq7pzduFIkhMRza?=
 =?us-ascii?Q?IIwyyMuhILQZ+5sVx2HRxmtfbdIkyz7KTkthCujSttbItWPkLCPxvzFC9QuS?=
 =?us-ascii?Q?BFmWK0fGM1W/RyMzZBZcm3yKag9NMORm47YH0XWjtNKF4sxU6PTnr34IMB3W?=
 =?us-ascii?Q?q9RZnNJgzkPcZshq3ViRNUwGoRFCWlKai/1XDL9ilI64stdqQKyQH/RwWl31?=
 =?us-ascii?Q?zI0a9p1cSrY1sPoWj0cL1/U3fpzh4ZhiSbkTZNSMCJ0aysArh5TOIfKIOXn0?=
 =?us-ascii?Q?YtH0YyhrqPiBvggVfuw4dbnt0JMIm73+NBVsO6ehT2aYI//YZb1Lhxal+o8h?=
 =?us-ascii?Q?s2JDBLhYG8FjkeE0ByhaSd5oGNF5StoChTWFvDmvSIPby609jYPSwlaBJkv1?=
 =?us-ascii?Q?4kzWTwZJ3xVtfLK9M23AOktdzeV9Eh76PNz/LTgwhs+tuG5bwfGINvpj0T6F?=
 =?us-ascii?Q?9sMD2/UoQ+dJMO8yW2ho1ToklzVH/x3tpx3vDMTptDVAGIwk4weRBuR+m1vH?=
 =?us-ascii?Q?g7qLj/oS3/tT2q0AsYDICRH0tG47eQC6NDwUnNquNhTs7aU+KiLWGm2iZMLk?=
 =?us-ascii?Q?mfMdZBrChSUPWE+ereEtWyLO3Yegmwlz73oYQwntGubaNknDKUUnIDUcRD61?=
 =?us-ascii?Q?sbrbo2sls+zrsXcsHtx6GHbEJhcGu4g0wMsF8BmbcVkA2DFP8fy/Zf+kZNXw?=
 =?us-ascii?Q?i5hx01ohq+JpKnjTbSPiToDvDbv8kM0ufQ1RBG9DxHP/+KQUlyB1U8vEWZtd?=
 =?us-ascii?Q?mHD1Un6rbGMRlRlSy7Pwg4G6R4VQeOYoWOuc3U2956pkd3ek5SUSQePPP0tD?=
 =?us-ascii?Q?fVs5TUPb+xUbdvq3GmvWluWi0LY1NiXg9SP78xRVsItjvkrG7obCKEI3TUkX?=
 =?us-ascii?Q?vKqQwtPQX0d4SiqNDfzD35jXySSSs4LwlYpjaFz5axwluU3fw1Z0wCNCvssc?=
 =?us-ascii?Q?U9JV9HHJGlH+uBQiOrIv/Gesv8FxMvtpOuAWEwqbRitIH6mhqCNN1KRlQid4?=
 =?us-ascii?Q?r9Q3chpypO3pMZkmD42RPsJsYLIrQbeveVlVwcylNW2k3M1Rfm+c74FoYYBy?=
 =?us-ascii?Q?lSjrKWss2wje6hSoTDDmR6aS/r2O8PUKSR0i/uTi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399be76b-3a3c-4fc4-625c-08db51fff692
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:13:20.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2en42UKMFD6QFVxrmDQaSlhl3i/GvzJKu9ejhZ1eVgXJeEn8P86uoCUgy6olkNIoR99kAVX6Pu6RbHt8nPM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an EFSCORRUPTED error occurs in f2fs, report the error to
userspace monitoring tools.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 51812f459581..42d5aa504afe 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -28,6 +28,7 @@
 #include <linux/part_stat.h>
 #include <linux/zstd.h>
 #include <linux/lz4.h>
+#include <linux/fsnotify.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -4000,6 +4001,8 @@ void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
 		sbi->error_dirty = true;
 	}
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
+
+	fsnotify_sb_error(sbi->sb, NULL, EFSCORRUPTED);
 }
 
 static bool f2fs_update_errors(struct f2fs_sb_info *sbi)
-- 
2.39.0

