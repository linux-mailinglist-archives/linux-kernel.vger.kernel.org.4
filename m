Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F776E7179
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjDSDOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSDOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:14:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3095A7297;
        Tue, 18 Apr 2023 20:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h85dMtpdK0l6t7rLaA3m1yaFEbaqJug54MdkM/WHZ3leMbfrWzeq7W9LjarqB/c+cTcH7Qi+5TTCOf6fh8v3AFd4D19+92T07KdRcN6ukSkl3937TH4/cxuxV1I4D6pnPtKpJNKtLcW7AdEf6FL1wH8MMgNJqOHur5Izblm83khv4T4apYsOrqpEei0LjrZ9J5/9RoRITzCEJVfAI6uduZG4qWinOCnG3IEmsxdvOsdu++s/IqVhmRdtXa0hYSab7RIKibMTrwOYg8jZiS+Alu8RFOKGtGsQo86q6tbPGFoCe0VguX2SVuF3tcEigyI+K5+jcsXBuskb8vjDFyE8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsuXSgBSbuNd/qGMJzWDO+rk4EMBGySItL7HnhsAn5c=;
 b=fk6b5VY1EHbL80BsRRz4fBoctmxMEyp4YgQNVOl+3YiZXTCEW0oF/3ubs8406Z39IOCcVcBFwWAQ5K4wY4rWoCEAjKN1nKUTr/zjIcjAPggoLIZWFv6+Jp55zaf7p9sUXPSeAhA/upg2ndPZXQaGcAh0u0IOQZahmqtQcdGDjyoAqVAMkI64xyK0d0I+/uHf0JvWkmvsEd85HOrixg2pTLfjiD8+XM3QRD7lqKZIIjdlueV0sMxp6UzsN0jRoXe+JYsHKFojxiijRfPGb4Be7hZgFeHtuwSEX41w2NVJ7uXdtD/g9U3aCQ3vTWJt/3xT2hzuQOzhCM+ORZxTtvHKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsuXSgBSbuNd/qGMJzWDO+rk4EMBGySItL7HnhsAn5c=;
 b=Kmiw4vqxxOM0USCAYSD61qSX2WkrIbB2nXr36czv16KRybqklVub/8xpijeodROVKXxf8PcpFFkUZMSD8odZKl5IPk6nUZRetc7dYu5ASXWxPyrsnP/OoOFyHYWx2nDXERzS4Y6BtzpezFkIdituJpUjzNfw10MQcgKe458kti1cO1jXVtQy4aCvqkHVZ/X1ZMRQnKSzuwmMvRrriPlMxM84SF+VgnvxdhpFsHDyrJ2LsdbfssRqk/vs92RuqFDFMhzYznMlADGUJDWPoFOBmLXy3KcrABqSCZN0PmGW7hbpnOnKeqeBQuIns3SdojugGovQf5Znq/W9662yXNbhxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4164.apcprd06.prod.outlook.com (2603:1096:820:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 03:14:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 03:14:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: f2fs: update noinline_data mount opt description
Date:   Wed, 19 Apr 2023 11:14:08 +0800
Message-Id: <20230419031408.5775-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230419031408.5775-1-frank.li@vivo.com>
References: <20230419031408.5775-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: eda9173d-138f-4b16-d4e7-08db40843474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgAzYijBgkJwvJ8I08RmR6exYPMgxrhyoA9kforLOpWPPXei1SkvYi0oI/RH/BmfbOgnqm1NerGE2BNeiKvxLNGOArEpx/1oiG7oFEuNwvIFeBKSrA/jdccvj9JNsrYS4YQBgf2EFH3dWIgY5Yw1Te+4IccXQKqJXIF0EArDQcHQuyMYb096ctaQUb1Ge3WDzNVWQFw+IxWsiy2Is4TVwhdS1NQdAxYhyrBPBeVLkmnL3SDnwLoZi2uYcCFGyzcxjH4lFp49IhM2CUoyxU0W6R/tqtbNv0VA3orTDpj4h6ocojtAIJzutzKAbUxobSw2LfNC0HxX0UNkdctL3C/nTskC3c4ittUu1mpqNEFJ0Ls8SXjbqptaL7u5L+PgFxYoaurL8jVHFiL+6ZAFJ/v0I2crzzO/XBZoQ6v82MJoexo85El3sfuAWxm5o79sDBiUW1GmYigOQyJ5dZSzfPxlSPgR/1oK85P4CD4nyGu+2TTwmSoiz1oLpPd/8wwZr/d/Mdr1WlzvPU8L8LIgjAbXLnNPj4xblhM5gjHbTEFvwLYjkJ5qznSrNQWDW+qnAULe/iPe3DZFmEpex2hhKEknJZBpQAtUl3ww0zRGG/oT0QZHhaOOU0zpFuRxAdMEpJ9R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(186003)(4326008)(110136005)(54906003)(316002)(66946007)(66476007)(66556008)(52116002)(478600001)(6486002)(8676002)(8936002)(6666004)(41300700001)(5660300002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(26005)(6506007)(1076003)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCUCMyhy6aMjDkKqt41BnVedu3YMKzXDBuKgWOcc+oRazPQy0Xd6R39LQlDW?=
 =?us-ascii?Q?HwGfBtOT2yNfQPxpNdFIaIf2qmJuuNecFwn1rxAWMt5fJzzyxDFkWDL2f4Tn?=
 =?us-ascii?Q?J/Zcxs5HPC9XUvLePhbt9brv5UQA9YiyWFkw67bDEwoDNYK1w4B04ogsQwi3?=
 =?us-ascii?Q?yqDNZtwUXzNB0rlVRSe8WpHhWFBu5jWZT1caEQPXe9EBw8DrJtoZvuy4A1C0?=
 =?us-ascii?Q?iDFwH2LJftf34PPZIIhTjMJQgAGs7th1v04Gw1XWdBNibvU/FQZZ05ldKck+?=
 =?us-ascii?Q?6ljMTLeyRV/Y0hAUCcsySff3Wgh0N65VCorYzcBQnuULGViWnrTaEueynJSD?=
 =?us-ascii?Q?BBxPThOa2VgE1AtEnp+SQu9bLBojnh4bFTrJNTBhyDsL+myTx9ufrhQajWvn?=
 =?us-ascii?Q?HEdbDno/3v+YtgEIeQwghCWNtHN4syyCQWMViukTY9ca4+2KJQJMrWrF/Fix?=
 =?us-ascii?Q?Toe03uoI38uPbKYq9cZ5xYVtbkr1TIDV6JRFHG5T0hf8sasCxYVQi47wWPMV?=
 =?us-ascii?Q?c4V5Mj73cvFcCnG8ULezxyhwT9xVV0rlHR+XSqgbYLTD1tSYX/EPvNSYDrop?=
 =?us-ascii?Q?PiRzaTm4MnJddl6eiCIXPWGBgf8pzE1YZ8ME7r9rlHOPDMI+hy0HzOe5UnNn?=
 =?us-ascii?Q?nlE+4irKHsyKBk6qr6T4Cu27+suBHDIZX+8s5YvYueNKMCf9oZ/TV2FfrXvg?=
 =?us-ascii?Q?fQR50u58JGF2IP5uhYqs9JHrPBr5NfZPE4QRYBwDukXBU71qFmBDhmEyLc0d?=
 =?us-ascii?Q?7wr+M9yVOoRHACzBI9fs2IlR2qTFfCUxV5uuXmLAUMLf7m40BG6aeAARiwfC?=
 =?us-ascii?Q?VundD7AxF79jCySaD561MtJYCS/V6B3Um8eBcRPrHKTMmHb911mnavpimL5M?=
 =?us-ascii?Q?9DteJ7S90n5HvwV9efHBnZJT6ShMp6iDJdYZdxhbXb9e/XgmdpW+ySJ3g7iY?=
 =?us-ascii?Q?oNFVgKwaCONaDjajbe4gTOaQbsEAkhrfPq6XDst8/IusEqVHEFMgF6/GOw9e?=
 =?us-ascii?Q?6l0WawDo8PMNjPGzdTn0W8IQOFMGAJAccGB8wC49Fsc7JMbbczCwREKeAH37?=
 =?us-ascii?Q?XQFXqwlgbIX8DOsIwPyCI7FrH3eZsuVBmDplA6VkgYsM9lBVQjJl05huL7fE?=
 =?us-ascii?Q?1n2NvS3SX04wCoKoiy84j1TYoB8Wi8jbKOKUiSimxy3jAWlGlRbHdH2zEsZC?=
 =?us-ascii?Q?T4d+Z5c6ePKjA5Go0LJxACpiuXa1GD7nbzbyPwSTRqDccOCM7xgSY0LgUZRA?=
 =?us-ascii?Q?Nw6jeCanewpIKaXaBgaEf8Wiln8G8NA7FD3N+rk5yzlZrCenEOAoBOWn4XSB?=
 =?us-ascii?Q?nv4djqU2X9IqfMZxruoB/fFR+lTY8B3nxX8E0n2tTNYJnD1LdVrGNay054fB?=
 =?us-ascii?Q?nZkslWnzpm3uo6t99jF8zkXZTOLWU4kpSYL8MM4YkCgTF1RsCCy1qP3C4ixZ?=
 =?us-ascii?Q?jk7X10l1kxUORooxrBeiE5onk+LRtL8OW3I3AMP4oqmNmgVjSemkQc+EYjbd?=
 =?us-ascii?Q?EzzB2el0RRnb/DVq1RVNQ+AUtArEbodO5M+stOt7lcbTfiFD5z8NELeA204C?=
 =?us-ascii?Q?fnmuNWdsTC7wDEUko5FZpL91dr8mAa4ELa1O96gD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda9173d-138f-4b16-d4e7-08db40843474
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 03:14:36.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCpUiVkBqraAda7bSxMA+gShJO9cPQG5LF9gpgb8xAztfrXT6PSs4+R3qAX+6CQKe+wiIE05kT7EuMZ/UXwU4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly modify the description of noinline_data and move it near
the description of inline_data.

Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/filesystems/f2fs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 6db21ae0136a..87436ce5d2b5 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -144,6 +144,8 @@ inline_xattr_size=%u	 Support configuring inline xattr size, it depends on
 			 flexible inline xattr feature.
 inline_data		 Enable the inline data feature: Newly created small (<~3.4k)
 			 files can be written into inode block.
+noinline_data		 Disable inline data feature, for which the feature is
+			 enabled by default.
 inline_dentry		 Enable the inline dir feature: data in newly created
 			 directory entries can be written into inode block. The
 			 space of inode block which is used to store inline
@@ -169,8 +171,6 @@ extent_cache		 Enable a read extent cache based on rb-tree. It can cache
 			 increasing the cache hit ratio. Set by default.
 noextent_cache		 Disable a read extent cache based on rb-tree explicitly, see
 			 the above extent_cache mount option.
-noinline_data		 Disable the inline data feature, inline data feature is
-			 enabled by default.
 data_flush		 Enable data flushing before checkpoint in order to
 			 persist data of regular and symlink.
 reserve_root=%d		 Support configuring reserved space which is used for
-- 
2.39.0

