Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77173A5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjFVQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFVQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:17:40 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9451BD8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G762HZ/+Id5rxxfMLTugcntanCrNxIpER5uPcIb/5cZlG+N5wm9xwB7gABM/MtcpTcQmYm/uIyYXe2GU/iS2AwYHPGRpJ0VdYr/coJAm/pH5ovBZZfZJKfTrANVLiUFi1nznRBzly+4XjbdDiGTW1+lJmeczx5BMS9lO2NjZgPrQJN57QDhuB5YE0tGjkkNPjqS0Az/gLL16kQ4wKdsV0a+A1Eur5pkPaxqai1TMwI3zoo2gxgIOtObaEqA7afo2AJ3/pnqcZOXCPyiXxfhQgwxuV51waPjqlRvXrgWGwugGUIdeHL8+qOKKp+v3auVkT4gaVQpKafjnsoLNkOBQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SUgRU4Lh+anYyhlpU8OjM7HlytBsIPlTH83+HRomeE=;
 b=mv8Diu3JV/WPT6gdYxowAKpglssKt7pGSq6PCxIqDp4wvHdWVzg9cbHlLjrqfg9JzdR2ZHpgxLyTWthfur4SCCziu2GQWfNaUFkGoC/gFt+pB2Ss5uAftGBsRREgth5O3oMzbA90mMnqwKQ3GNQezGrKpwPR1JnYWDe6R5/fJr+LCfT6boUDhysuGWkFK8FTAku2bdJoZj1HiL2uQXrOBTwMD2HG7to3yCI2newsnlhkRvXBZ4bSTUyG5RZVZrF0tbFL/4uJ3OFZzJPyFixg/D/BQ7zzo/5NhiEasYEsMsx62/BNtB04F86/2Ap7v57Mw/OsEe6QrYWdofiRDAAbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SUgRU4Lh+anYyhlpU8OjM7HlytBsIPlTH83+HRomeE=;
 b=tcYEI77D8qnqnsapdSNTebCZU1/JuJ0vf4Xa9CfVtPL2HTo+If4KFg9QiFNNwadR/R0yj8yPKbJkaX27ltulNNZAo8H+LLk6uOgXNt8gqlUpptRub/cmTUrSrgbjPU8+MHiDZNWCkBrZ8zmLS3XE1zTnGKoRUh3NKBStKSOLcJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
 by KL1PR02MB6189.apcprd02.prod.outlook.com (2603:1096:820:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 16:17:34 +0000
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb]) by TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb%4]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 16:17:33 +0000
From:   Yunlei He <heyunlei@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yunlei He <heyunlei@oppo.com>
Subject: [f2fs-dev][PATCH 2/2]  f2fs: truncate pages if move file range success
Date:   Fri, 23 Jun 2023 00:16:47 +0800
Message-Id: <20230622161647.742012-2-heyunlei@oppo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622161647.742012-1-heyunlei@oppo.com>
References: <20230622161647.742012-1-heyunlei@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To TY2PR02MB4479.apcprd02.prod.outlook.com
 (2603:1096:404:800e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR02MB4479:EE_|KL1PR02MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b25d98d-1dd3-41ea-acb8-08db733c2f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjRuVNIbwUEhO5cbC1NuHcUuqeHE4woNXZT4umuyYUfuDIGk+RY5PV0hQnIECEfrRiSYqtrokGat+cf0qZ5Clh7LLeanfNfe2BXEqzNP2flmUR8wprGy0rhgC4v3eNhVpKGRD/I9MnlyisiWS6ZfdusimipcQnE0KMLC8/yKBCzluTFfmd/Ctn/e5KlktnDMp43gtOCKGbDxcofAFMzgVO3l+d/1jMk7ZwktS/h6/vW8p+2+l6+kWaqd03MyFW7Nruo2X3AlB43vISJk6CiJaMIowhMea+fRD9K8sCWI4YrZQfMd3BizNdUgVUtBF17puKimBJbVMraI2Qxb6XQSJ9PK726/oVlV+H/l5npZaXBp70P6Y6Mz/MySWzf5xr9WdgGLuxxTbtaRL1Xkeo0OmsjkAGcMCz1KkBsKXQZOe+1HVh2Cl6jFtmZCR+gkuSbme+WK8PAZD7lATitVGsgBFVcE2oYdURVrcBHtrMqDqi3UWvI4eRDW/qYDu7Wda0x3Pl7vxJ40Awppxf/ZicbFs6YwiMqdeQQB6BJ2nM6FKF3lXO0Z0ji9G1ty4ePXBWqOD1TXPObDc884Wmo2ZZb/0ilge7mpRKfv7zRdOeaGIyTYpe3flJpTl4YpXUhSKMEG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4479.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(5660300002)(478600001)(66476007)(66556008)(66946007)(52116002)(4326008)(6666004)(6486002)(316002)(36756003)(86362001)(2616005)(83380400001)(1076003)(26005)(6512007)(6506007)(186003)(38100700002)(107886003)(4744005)(8936002)(2906002)(8676002)(41300700001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkKgDOJOSAUwcdbUe7E7P5J8iWm4KCdyCtkqA/Ncb4XTeuGzqHOkoZl/PIhG?=
 =?us-ascii?Q?0XqoeQsHhvu3Lt1tiZAlxmikshemhQMeKTV2rmBEHbl54MggHiSZcAGdsmr0?=
 =?us-ascii?Q?mWg7k3WQaXDOuFoPtqlX2k4xkJ0VBADv6G1F7rnpIzQkZYyZ9LAGdWqkkINj?=
 =?us-ascii?Q?MvL2RTWgRdCfbhNhWOX21oSJO7AZoYewHba1CIHanqt586botp2lCoMDRdTB?=
 =?us-ascii?Q?QqQC2ym6jwzxzfeXnYZT7wSr4cFX3z7a4dUcy/sElYFp30PcLWGay/LonIQ7?=
 =?us-ascii?Q?xXt0A8JLN1w+H788hbLVsnAP9km+Ehz8kbn0MuTs2YyHQpdQ5nm8j/wesbom?=
 =?us-ascii?Q?rdSmvcBEtqDzofReZw9Fp6gqnFHcomXwqOcle1+4DRnuLeRFvQvxohMC6YLU?=
 =?us-ascii?Q?2ErH85sVS5wtJ3F+DxBvrrZGCo1ZuwRxkyS2z3jFLlb5yFNzK5emg5/qdK4B?=
 =?us-ascii?Q?My+o3zGjivO3PVs2q1V9EMyw+dhOKTXDMCbQ3uxDmBH0NFxPVb9iL9kXhpx3?=
 =?us-ascii?Q?qVozFuh+ZKOcuvt8GBSmEl+kOEqQzLzcjI5jCS/xo7y610b+ujtYARmCBipE?=
 =?us-ascii?Q?Z+8qB9hKnkSiGeoYT9JWpr+5xr8ZJUYtSD2yslqfovlRk6oIVwaAR1jckRw+?=
 =?us-ascii?Q?YF1vlMvkDBsCAaikA6ducF0zAVc+tbyqnugMeIoBFmbuwPdxOQqe0AqXk9FH?=
 =?us-ascii?Q?0M8sM4S55IBRiksAUZJQho5fM3Y4PJDB0Itk7VZjrTzhe0kC9m50udS73WqQ?=
 =?us-ascii?Q?u/f4oagdv8LKdIdbDvBY8A/guDjzliMkbOYZQtcNDVCBppzmKgWxTUqZhIEj?=
 =?us-ascii?Q?qOWSeM3nIO8W2pEF0PNH/YAuBJDaenhJLRgPOZXaCTC2M3R4OProFOVRIre1?=
 =?us-ascii?Q?jUKdF4Bkq6OaCO0dsKwOaiyqFP2pT4eqJYVgxWWuGXFArOauUqe0eHre9C13?=
 =?us-ascii?Q?27C8mddZJLpoqYC3+3l7Flh4tZ5K4m3XMN7pmXMOFTscAxXuE3Dw18Z3rD4t?=
 =?us-ascii?Q?+i3SADjGD5osRE1UyfKlcjsXQxmu/yXMAq5GckYHaWd2ODFzoHHFQi4h77k0?=
 =?us-ascii?Q?T2cuXW8SAydrxQc2+tGcZvdNp0atr6KCS1CR7w0jzJj+jf3E7FVcuaewTago?=
 =?us-ascii?Q?kR0/iCps22r2OVEhWYTgV95rD/voYqHQ7CapeWi1xd12TSeW72GYi0h2+GG1?=
 =?us-ascii?Q?ilNav7P2O5YW0wgRB7VSyp8v213Svwrgy6dT1xc0SrtI/u9aEMICEG5FjzLj?=
 =?us-ascii?Q?LdJaXv6wcFMH4mF/WWpaTYrHvefzwZAJktqLgFV0Sat1vcHhv1etWUXor89R?=
 =?us-ascii?Q?lCI301H6UM6m8xQCTZlxzsfsJtBejaQASzeFLKauQCF7zXRj4dJ4CvFuwVHc?=
 =?us-ascii?Q?rBNNQSjW8bMIORd364/BoOP8cmW8yyWoIjV482k7XTfu0Ba9z4AUTjxUypqP?=
 =?us-ascii?Q?tujHibW8D2x8+5jEpJB0hVmeEUGLnTRdgE45S6iDSCbrXXk8qWsGum2ukhMK?=
 =?us-ascii?Q?jyvjhe3qwNrnp6n33KrDyJ/jcfHp35YtesTWQeE03b4czmPL++P3stWBF7NR?=
 =?us-ascii?Q?CL/2bSbnXSiWkYF5pNjG/BymMncLFkP92yEfEeYV?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b25d98d-1dd3-41ea-acb8-08db733c2f66
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4479.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 16:17:33.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkIoWyPlhfTrHhdg9pQaPNBPSuWA4phTy0Pr3W2UJ7lWC+q2wtEl+xlZyzA0Jw1U8fY2C1CElipPgD7NyTd0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If move file range success, it should remove old data from
src and dst page cache.

Signed-off-by: Yunlei He <heyunlei@oppo.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e59fc8faa035..4bece7c56656 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2896,6 +2896,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			f2fs_mark_inode_dirty_sync(dst, false);
 		}
 
+		truncate_pagecache_range(src, pos_in, pos_in + len - 1);
+		truncate_pagecache_range(dst, pos_out, pos_out + len - 1);
+
 		f2fs_update_time(sbi, REQ_TIME);
 	}
 
-- 
2.40.1

