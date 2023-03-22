Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF266C5185
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCVRBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCVRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:00:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31A64AB3;
        Wed, 22 Mar 2023 10:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AijP9/6n0Sh4f71990eolgyE/Da8Ej4qTK27NEy3yu6070fVfSu6ZEyS6LUO6leDx2b87M9yjixiJWP13gdPlNala7OGazmzgQZa98Wyez2zouXvfe/RD+y1WPYNOX1CSqUQoUMZ7BQM3z6DWz9aCU5O6Qc3b0n1446YpfrsZOrR2HqGqpPSar6tf0+Tsh0f+zXPLu9t5XlzH4oqDZlHV6DSR7ZrPtATRjGIFfmCl5rTiAeJ/WTHuT2Ttg+9xi1MEA1q0iljwSKf99d7RbuNJUcjowSwHfliQ1UG4wcrkAKLIBAohUcPR2z/TON1iaRx5/wYSAVvkbcUK+1/9wCWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeSXbiSKn/Htu8RDFyUlihMaEwMnfwHjUTJcCENoL/A=;
 b=E1PmTaysZZN026cprB2n/gS5WhUNVRlVd8ftixWusp131km4RJonbsipxFyY0TQiG6j577H4sAmK+FhGST1EvI+68uU8VJHRNb6hNAIaYxZt206Es2TrKfM7E1oQ9g38UvlI5Z1HZw6AvZixj5VxU3pk9k4HQzLC5WjZ3mUBCoQXDSEYNV7emy9kLr7SM02+Kgu8Mcf3Z3ZspT1aX9Fpn5tIABKHEjtm27hH5VQtb94GswriQeQsYUBi3WaPJ7AekYQp2Qmq8EZDQRiAWIZ5GTvh6WX4m5wvpDHjOInfh4nR4/mOwWrEdSyx2RG3fOddLDvrhfO+JYaHLMdhpIt1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeSXbiSKn/Htu8RDFyUlihMaEwMnfwHjUTJcCENoL/A=;
 b=NuhvGdyeKkkSMp+Z62JFUScTXvDMRB9XyKUOpkU91HY/zlVSteoNvV684AqzMiT6PQ4kdwT8Sz3zn8K7avLMed9jhxUaNILeI46p3TFWJQxswV3B/cMgTN6AnSDGrjnkWuuS9RJhGfHCEjJhZf3LNIjVOKnykbmLdX6buFdN+qAmLG9Gi9xCQGozHfInbbgJk+5lKDajr1rxHF5+cw3YuS+YgYGGNYlXqn/pmliFzetvZhDRjxPlKu0N5RHGIbCaeXU5XUC1qaMvngMVB6yaqLY7h+nYxGkg+8LTHAVL4fHPIgnoFrPXEIMJWpN9g5wqkVk8CL4+r1qmh1VFhsNzcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4107.apcprd06.prod.outlook.com (2603:1096:4:f1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 17:00:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 17:00:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/10] nilfs2: convert to kobject_del_and_put()
Date:   Thu, 23 Mar 2023 00:59:05 +0800
Message-Id: <20230322165905.55389-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230322165905.55389-1-frank.li@vivo.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d1b65a-5fdf-4db2-c118-08db2af6dfce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AtLPt6UJCvLwVPA4XrSajMoeBeHt7ieaqSPVD/F9jnQ+igEtxMAGY1Uvhzj0Z9tTJbURXoaGAgdXbU3h66Sbw82DwIJ/kPJSvhALeTI2N2TshzpDD1h+SX7wbd5NMxu7/36yZQmikFCDqbuKDn48B/fcz+CWNceeZTVX6MSINVigXGzMVeaSg2UOSrGwZ9ZMZ5OfhmQg9BZvQF4BllzzsIhW+g3x5aEutwDWuF/15Wbz0ZNiC+3093yv2+i8jsUGeiWydLZcm5Vw4pemXkAa5mzf4dPQLQeOvuKc0UsJ2BgfmXudNtjrWRBLG6JZS+LGE7jcgpejGFNxDIaVAItpZMBfHZRe7/8gU8kOGUtrq+qngy/NhAFikU5vyZVXDwzMIHYb83oXERms0kV68//pL8OFrZAymN01PgZOUKtWEmc/yvKnrdtjnd7/IgpbHRge37YrN92owZA3QGILa9V9W+raofOJALJRTwbK9NOkZzG/bgpujsZIWDXbETHWlBlDBtUnrdS7ACf+Pop91qgnfKpdhb6UH+0D83Upjz7uhKI7Aa6IBMmars0+6xSXqNXjF8RHhwWAvVqkiDOwpy4aZCVn1c+3Jm4O4d8oY7yBQIgsQtZ8hm1U4259c8urVBSCirbIxdlp/NPYKi/IJKdyrw1aEJjYPdtNa62B47BFwxF9AqoqBZk1665xk3/J+Z6OHt3E1VevBdJphqBrnep6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(6512007)(2616005)(1076003)(52116002)(26005)(478600001)(5660300002)(186003)(6506007)(6486002)(83380400001)(316002)(38350700002)(38100700002)(86362001)(8676002)(66946007)(4744005)(54906003)(41300700001)(36756003)(8936002)(66476007)(66556008)(2906002)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NmUFVd3EVSrMCT62QQ+hjFuFvzqh9L4ERpJJnN2UcJBZYdamb/sgygGBFQOY?=
 =?us-ascii?Q?pJFzZ+kzdDM90OuiejhcvZwBm+pydRvwlTHr2RIyuEjoATV56Gbp+B3TSRdw?=
 =?us-ascii?Q?xhfbdMSOsuUzUzBrAfiK8eT4Uqdqvv3VHewvs3QbfAI3EYlNBMzR8HH9xPLM?=
 =?us-ascii?Q?nhtf3iwn91lsiYPwPIV3mFDdFJgJJqKPZ0b6IpIjONFjC9xfZI5WLnamWw4P?=
 =?us-ascii?Q?B+tW2VNuL0BbYlNhL0ybyM/bEc20SYydVrowLpSFMcGY/zSgb+seChKcptGF?=
 =?us-ascii?Q?ty3aOQpRh9W+60etwUQNPjwcHxNkOyIFKLMaIvtK1uQ5JCirWCSAYofiLq5J?=
 =?us-ascii?Q?Ct4PUVG3UpbiHyWHbVv+krpYOhc/DfnQRsJf+XfskXGxsovGeMzVe60tylp3?=
 =?us-ascii?Q?G6UzZu2TWmI5FDJNgtEtpyCVVowmJARP1F6AgXDZaRmXVSV8fE4ScR1QnqUk?=
 =?us-ascii?Q?Vfcpudq68UVAxhOJ6KowPlhAwKx/fY61F9sakEXK5/riIpHxfjvfm2CKDgca?=
 =?us-ascii?Q?wpqE/MMZ0SNpISvVgzJ0b741sKo8U4D6l9P4WEy7T705agwJRxGk6/Wex8N6?=
 =?us-ascii?Q?VOa70Ij9V1UR1uNjM7JqW+5OmgtxAMzayHd2WzwmkY7xP4fH19I142F8Oy71?=
 =?us-ascii?Q?7ZQo2GhdFAk9d8xk7yIfUVLRquH6lsstTqBaiQKH6Kl2osAGZ6m7rjZCzVVw?=
 =?us-ascii?Q?TXKaVm4VvRGXzx/QUXVRXX0TDDAHA3Yp8AvZBD8e0+87Tor/MXw0HZazTC0c?=
 =?us-ascii?Q?HqrtAWuJ3sdBKTj1nVwhWBu6jjPTMiXtKe/VCTOUE94QBr8MFxvWvdpjC6ZK?=
 =?us-ascii?Q?3/3bqUwCZU+E4kiN/3RtTacmNY7jhrb8NFxdqSYoKCw3DMKpu3LzAF+PJzKm?=
 =?us-ascii?Q?S9P0kpg6sbXYDtSPIL3mnwC3dnv7RLd7JCR17vpmIAH1MuEBxrE09TkDM11l?=
 =?us-ascii?Q?ojoHTVJsZIl3W6ERVbnl2q0/iagrUrZsR/F5NWRAu2SUKakD2kmIJma3Srvb?=
 =?us-ascii?Q?jcO8otu5h7GAGgLaTdt1/+dEPGME0NiOSJ7BTjQ7KbrO9tGVURjbc26Ph58d?=
 =?us-ascii?Q?qx8roAuD6DWyp6N1UyxSLlyTer7ugfe81/cXa3BHdAPBzmMV9UpKs8s3Dog0?=
 =?us-ascii?Q?yWqFjXH0WcV0398Tt6Y5drNTpVuN091y7+ZgnXCp8fdqRY2wFYhh2wEUq147?=
 =?us-ascii?Q?6rm8UcWXOkkkvdHfDVSTeAe7gkqhf44QSZF3DjyypEVRdic+gh/E8CMZibPH?=
 =?us-ascii?Q?B3T7fOzUATHjdke/zJiKoWH0/Uuf7fQ5RMg7O/YGHZX0W+Y1Fi20mWkLgNGY?=
 =?us-ascii?Q?/i17lbHRK7ix0IuUbPsaZxsUFzK9i+PhkihHgkh/l3ZUhh9wRkoosr/5jj10?=
 =?us-ascii?Q?qx5lm1zv0OXYDOplOGNytNRS9kdZIfcpNZfedbHA13xKYLJEsb9fR/eYACku?=
 =?us-ascii?Q?PRI4Hu0MEXh9v1zaO9lN0Z/YdLGU7Ff8zJhRvYtBMiz11Q1YlehX4Y6F33MY?=
 =?us-ascii?Q?O2gyo3Q0D7L4yUs+x5n9WDr1A7TOO0cvrImQbr17OjGm26VgNLm5ZS5CuZMq?=
 =?us-ascii?Q?jZmNh2onAS9hxuZznWFwA+F5ze1hQbc3Z2UU2VQS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d1b65a-5fdf-4db2-c118-08db2af6dfce
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 17:00:01.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuzlIMocUqG80V+U/PIFblVG0Ra7ILsk/1FGRvzUjM/M8HSkBq/kdaO9DkD5G6CE7U4G/+ydixbQB0Ik1JUG9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4107
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/nilfs2/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 379d22e28ed6..150965d58ca5 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1042,8 +1042,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 	nilfs_sysfs_delete_segments_group(nilfs);
 	nilfs_sysfs_delete_superblock_group(nilfs);
 	nilfs_sysfs_delete_segctor_group(nilfs);
-	kobject_del(&nilfs->ns_dev_kobj);
-	kobject_put(&nilfs->ns_dev_kobj);
+	kobject_del_and_put(&nilfs->ns_dev_kobj);
 	kfree(nilfs->ns_dev_subgroups);
 }
 
-- 
2.35.1

