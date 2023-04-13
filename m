Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46C46E1279
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDMQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjDMQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:38:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E7A267
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leH90fjMMqm9rb3BYEw5WNElHQOAEswgfWqFbYqnta5xyVOLwXyvRAC5qZSXiv5ByNFMzzOnLqT3wGxm5PvZciq3jYOPG1c0kAe/bZ1Cnq7rlVYDLrfuUb2tzEywNrOCp+Znpt1W60Ymbl4xSNC+HGM5++l/WTBv5wZUgmuSQgGNnfMmYyTcbdmJoWpYZc8q01OuCw0p2Vbk32wW8D0zFDS3MNJGEDvTkuhK7GutYXXc/ptd7ltRNhGo+zE90gfXOXQzUVFEu+5v5uMU0oB7O48qfBAu4dlbfiZL47H+QmpuifY62SXpeQwwrSVOKmiSMZfZuoPPOLoxxw+i4KkoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3tiA9qXB/Us2pVu6X4TwdzaZhLfBjS+IeSQGuJPOkQ=;
 b=iJToKlODMmJYTyH2IgQOfKze0irE4XgcJpwA5AKVOXjE/VCRmPh22jIvaek4N0HyS5yPqDxmRFe8JbLjEkLcWFKa8EdYNiJn8kznxvQxAfvBzRwlZm0+AG66VnsCIgC71NxM+sFVAIP01E/PYNiexFztlj37HvaUQ4nzSgN6E/RvhmL2FcrPclRpaEWH0lSe0zUbXMCp6d3OPQRsZ24NakimoJggOiX4q+Qto/IF+ei9NwVRRFUdgmlhDWVYL3/uBvCALeHrRJUg3V/pqLMNm1StFahVryVtp1jQuKVjZE8lRh/rCFpdxIE6NMZ0A0zqlepyMXazoxePeFRzUY48bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3tiA9qXB/Us2pVu6X4TwdzaZhLfBjS+IeSQGuJPOkQ=;
 b=GQfQz2+J5YLQnLLmidO86EDp1yETIGyreBLPBrxKQt+IBMuzXyPRG2igLNQfeMxydpTujSCoK/JghN4+7KmiWawnf5/CpE5NwJdSduVGxEJ6jpCN5R1qPVuXUyIdR1LX25ra0puqBFDrN4xKbUN87Qa8qLPx3k8NeSiyFksGfmh49R+PZrfL0JYp293hruStX6mh4+/hkCf8Xfkge24eGh9UpJ9e4Qf3bVPi0HZe4/I+M+o4MBhQm0oLDAYtH2D73Y8mIU6sqIxl3/H+Mbo3sahkSTQEZE55y6Axe+gtRZHNAbZsHaPTKW+0jlyiVzgGsoeo+Zk9RjCqbqzGfTutUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4540.apcprd06.prod.outlook.com (2603:1096:4:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 16:38:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 16:38:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jan Kara <jack@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] quota: mark PRINT_QUOTA_WARNING as BROKEN
Date:   Fri, 14 Apr 2023 00:38:32 +0800
Message-Id: <20230413163833.43913-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 688348df-dcab-4bb8-302d-08db3c3d8a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ndmUywZlNUeIEE+l4HHrAnnC+zWKGtfmZwChDpWMDwzgpjXCAyhV22CE9rKEqeb+M1Y0S075punOz6AbnnlTlyiZUQ13/c/X2/iZlz6ZkVrXDulSu81Yvxa36jajsi+ul6lsP8mw8Mg0n6SmAHyy311rv8aFlWIBtRPF1/CYgWxTr5ZzwVI5JT2rpH5ZeiRs8RbXA7maOp4JrcRe1tj9JPvSSf/ekeBKzmegF+daUsIq3R86+peP3CjMo7685/7dxPKQDrhgtqr2jk5tg4Ffop4RCYv7OGIKgTbOYtWKbVD2BoSjMRlUpnhDN0DtCPqxsRLbY3iOhx9yIJ9RKNjGlvTyrmWp3wHlSu2P2LnmnzVmAFYaSkFb31gn8QwcuIQZnBVBQx8hGUFUPazXwoymr4d3HTrR+h9wviW6ANaf7mdpbsPXnGbLoc5il7DJji65+Ro0ImP64MUIx08DOmy29xKnT+2rWrPtDZ8leg6vFUt7kaLuUK0GjIt4FtXc053XZPfSsK04s3CdhAFb02IxNLtmSg5T8Phg3CEei5TwUnKrHqjMMP+Mqi65OjVQhCAdexjAyBohIGoK9DIA1XcfTTxYVtWHCrLmWDNeROUYQBScUy11Ss5hYlolGD8nV7q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(316002)(38100700002)(6916009)(4326008)(38350700002)(66556008)(66946007)(66476007)(2616005)(5660300002)(41300700001)(52116002)(6666004)(36756003)(86362001)(6486002)(6512007)(6506007)(26005)(186003)(1076003)(2906002)(83380400001)(8676002)(8936002)(4744005)(15650500001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hqvtY9xWLmkssELjMXB+iIEyD6K7wGCCzkFhk5NtqNNlS4ue3Ea2++JyqQHz?=
 =?us-ascii?Q?jPMSCGqSSLDfRThxk5FvbHwYNqxlPxlzFYAw6ZtTb9j/v8+gY3oWER0eScYD?=
 =?us-ascii?Q?rOrE/8Kx9kR50Q9SPQf+kWzxLkhMewPLiTEdpKhvEkFqMlmNCwSB0ZGSx7Lv?=
 =?us-ascii?Q?etw6Lu6rewYenldta8xiBB5q3bTUKPUBWc1/0xjY+q9m75gfITAjJG5eqY81?=
 =?us-ascii?Q?6XR5GiFvPSIQEXQzEwXBQCQn3jjIQJMMfNaaC6QEcMgCJcgzHQGOIZ0l6DqW?=
 =?us-ascii?Q?ayE0J3h+tUJuTsdD2eDXzBVSSAQYpnjodJH4Vc0T+4J6if6xoYFTE9H/RJX7?=
 =?us-ascii?Q?HYbHUdoO8oNWRTRqu3rnxOK4MkyulO4FbZD0/dwFmvZe/ck56NQOnhVrheSp?=
 =?us-ascii?Q?fuGn6IoLGgpgU9BE2iwl1fwaohpBL4IwTrwBN+x1FaXtP78zLT6X6WFU6ygV?=
 =?us-ascii?Q?lSTvavGwafe//xGKkgDscVwX3a8FxgLCSj/2wwnqR5Ct6DezFnYxbz1e3g5e?=
 =?us-ascii?Q?zVPGPWukMz6Yykklirrcxyc+g1STPD7Gjc5EAAwTRaatBd6ZTRFQ78fKrFdH?=
 =?us-ascii?Q?mlkcne2cnD6BacYuxehpkX+0TtMl4pVwVz6G83+ooaKMYHNgiLsAKG5ojl8E?=
 =?us-ascii?Q?HMOSqafJRyP43ZzCnMrXWflPSqH3DaZPHdPMQmcFyICB2xGOlWIk097W3wGZ?=
 =?us-ascii?Q?1TrTulzjcTKPyaYT1lCjfE2CIGSpITcpVxC5ZEowd/UUHVeZkLzlygR3Jpy8?=
 =?us-ascii?Q?W3eQyoN4/rXVmAeYPXLjJc8/TUDHyg/z99IhUtXcyBa4wP4LSVTVE15BGRGe?=
 =?us-ascii?Q?NVuB19W5uZYnyfq8kPXVrL8KZ0bhyIwdJVjUfGrFClDc1cvIlrIG8V/TzAyI?=
 =?us-ascii?Q?gRpr/PrPRoccbnjVtOBYYXhJ+hKYZe0mGv31Br03VSWB3QqcBEvSRLc5DLAh?=
 =?us-ascii?Q?QB+jEHO06jn5lwlv4UKpmcXYvNBLcUOmpje58J3IpwdBaS+ErM2pFugVpHi+?=
 =?us-ascii?Q?zfXKy2fSFSbTxtwLgAGSr6OrZ3AHyCS/BQlFD/ePwqnU/KUMsPljz2nV8Arg?=
 =?us-ascii?Q?db55N58peAdjzRrbOfTZiKfWwwlOrr3FPpggrY8A3Dn8qCYblEXCEKnLO1Ea?=
 =?us-ascii?Q?TeOEaW5/EakfOfGMXA79jbJdOC3X+41YxfAD6oxDpuKKsYBUbVfE68U5n5SG?=
 =?us-ascii?Q?7UtFSpuUzw9xyfBEY7FUFivfkmENLoD7VlLFfIzK8uk0jbYFuSyRUCi7/4rJ?=
 =?us-ascii?Q?p3AUbcO42eCO4MBqfLDsoSIAvtXVwWfob28DE2D6JKKCFzUgdXYZxcIrutVf?=
 =?us-ascii?Q?MSTgDkix0Bozvk2edjI+kOxjHD4Yzai5aPRw/6ZRzbgxBheM7JQFxaHHkhI5?=
 =?us-ascii?Q?+MBVWMM8hTc64Ez/sNM6s8Y8CScPYBMEjNTuJ31aIOYvw5LOghN1PVpEoTfb?=
 =?us-ascii?Q?G+TLJ0aJdnzlO6MSC+EilAvNkkVSPWaVwjF/5H4xGJINRw9KAlzCk/O7E29c?=
 =?us-ascii?Q?k0iCSe3uAE9TI7YwtWVIF3jjIFBXfGT/J1I1oVfP3jZMw+nP/1uDfzNR/oaM?=
 =?us-ascii?Q?Ned2Gukc3UxAm+eGZ4DMCK1MdJT6C0qaoBen8tfN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688348df-dcab-4bb8-302d-08db3c3d8a9c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 16:38:42.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2WH6mycGDEIO0eldG3cf6gWvM+9sBJyiBuPbE2jcFTH3N8FLE5TvDrbt/URKinOt6LV9HG/hS6rQD+uSB/Azw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User should use notification via netlink socket. PRINT_QUOTA_WARNING is
deprecated since commit 8e8934695dfd ("quota: send messages
via netlink"), so mark it as BROKEN.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index d5a85a8062d0..10e9a0efc6c2 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -28,7 +28,7 @@ config QUOTA_NETLINK_INTERFACE
 
 config PRINT_QUOTA_WARNING
 	bool "Print quota warnings to console (OBSOLETE)"
-	depends on QUOTA
+	depends on QUOTA && BROKEN
 	default y
 	help
 	  If you say Y here, quota warnings (about exceeding softlimit, reaching
-- 
2.35.1

