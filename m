Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDE66776E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbjALOnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbjALOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:42:30 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DA13DBEE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImdcQjMiB7rcIapSZ7DiG4XKE0+pvj8zupB4y3fwE67WG9fPa4nsAXVoEyKOVl9fNC4e8uvSlTJ7fhDm4hp4+p35spU3qL6bN3333JABqeOpsSX7hpNAQk/9FsoBP2pvsfKJjmQQCGh+G5ZYF6IaeNQ55cpiom96D2974HeZs8nNjhJ2uAxMNLe2/3J4+qixKIqWccjKcVr400btws9wL2lOGd8B6W54lXU7SovGQLGWdFSEhAfAzc855IYKsDYi/PEQzfcE4OcoP1ACitCPOh2e+1kekw6zQhQzoJfx+RXPjnSIVDPlrs3eB6QOw69nqs1sT1b24oDoQI4f0SIKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INLsxzsun77vNOJLo3z1BB4rt0b4lFF14YrvJ1qIRFU=;
 b=B4aBFXoYYK8ZYArUhi4pr5012ioUABbLYG+sqflPBKh0U5ATlYoBtFr2XNbwYQkPey7pV1xe+GNhRieVobb83sl9HCXAEn9GtwnJ5HGh8cS07mi++xvJMVjoQA7G4SLegFrvFCPqVQ3hg5QyQVJdZmCTa+YTgujc9U1K7tjTbr8Shi5o3hZCmF2tYQq5uC9qs83Wl+eQX1lRwprfXP+JoSiNiEUe06X1jFMXn/WyMg3WRhcI4znW8cV0JUbxP2/IEMRl9bQdVpkvLAuSlWtOZcsyC0MRGz7K/nj/WS87d2lo7sd63AYl73IOZu49arMvHTMyL0xy238/muFRWZ/VUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INLsxzsun77vNOJLo3z1BB4rt0b4lFF14YrvJ1qIRFU=;
 b=hT27lxBbMT+hjuRAoj3r39GJooH/NwNrMK0YQzIOJ2A5b0EGsS2dG72jOhCmuRHeAiGl0/Kf0TLuen8VA1fiWvURKUAf2spuHdXFr8tPccYWTISdq6taw6m133vi4Cws2mc1hF32bTUfL/sYTPPKBJI+zT3k1lSBatJoKcXhWaN01sl9H4cfMDhwyIeRLswdIN7U+DzKP4yqfZBdJ6mABw48pleSd379QkJHjU9Ff7BeXz5qUsZZNda6zATAFduoJQ6oZ3JWMCWSs3T4WH5GFyOq1rHUCdqFfaL4IGEOVpQsWzJ/bVc7DcjFppDcE639Vn2QHUNLmDF+SoqnykS+Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5324.apcprd06.prod.outlook.com (2603:1096:400:1f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 14:32:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 14:32:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: convert is_extension_exist() to return bool type
Date:   Thu, 12 Jan 2023 22:31:51 +0800
Message-Id: <20230112143151.23921-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c95e13-d87f-4fb4-8fd7-08daf4a9c3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChG1Rsh4jeEvgHQh+Ua2+1F16mxFVxe59X0feqt4yJMheSx3ya2P7uD54Wg9V/9CnUmHTj1CCuDRsEsG9cSu8xoy5GcKzJkgdzp+vrT27muE3adBgATHHwGgIXRwhhpxHAWRQdy5CLJ064/4ImPUOhBBazR4oMaSis/DFRuGyFy+iiemA0pVuplMwv//V8GN0WakACEbA5rKcnUarM5oAiAZ2x0hNv4GFrm0p5QoJK49yqqd5QHYTZpFikOHDX8/E14u+YVgJ0V5q+OketoUTOgcRBvlEyJ5mXOLtOFKha96VbPqqT5/9FG7A1vVdrosz3nniOksBdEo/j5jlWKGjA1JUCkDmc1JrYbs9eRoo7lAWvEXNtMb+kXHbiwv+l9lBYdlJ9a/Xr7ozpfmnbRW1aMavrikhTnxhI24bO9KrVmXCghu5MNIhmCbOWhWrHPYECgBrkFKAEgkZ10b9wOTT4jbfQSGB9d3VgJzYI74PpgcZinp+UWQht8oqsevY2f9YSCttL9ec+4FvQ4M7AQfKwoXJWmAigWWRdk++YJmhkCvvs1gK8PjQLAzGkpeAaoTvrfpR6QpHtLffjeiKtUPgf6QT4fysRhfuSLr8qVWXuB7DjTuh5GuxyywGseDwaY3RbX4pAaSG5HvqaGG2jjmQbv3sGs83IoeD3ZsiyLBJ2SXQfkQc+JbWi4LB4+XHdHDppwGtHvKTWWfvKR06+/j1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(6486002)(8936002)(26005)(186003)(5660300002)(2616005)(38350700002)(38100700002)(8676002)(4326008)(316002)(1076003)(66556008)(66476007)(41300700001)(6512007)(36756003)(66946007)(478600001)(52116002)(86362001)(2906002)(83380400001)(107886003)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOhRegzZDOMQTOeCkZxCK4PUZro4ZNFqemZ6ceyTT4eomO2k4s6D2VdUZbpB?=
 =?us-ascii?Q?wgpK8zffXRNwCdh18SoEXrOjyVV/EFH2tHPu16S9AkCquR0EG/cm9SbwXYAi?=
 =?us-ascii?Q?tI2B7kFIwvkAyAoQS34hwQlXUJp56RkvAjg8a4HqtEbHor6jWtjZIZhUIoin?=
 =?us-ascii?Q?Uo3lD+pjn+hSBxfL+Cd14RR9cDR6hJOWh0G2S46eHLGv5RlYdVPaB2v1J5yv?=
 =?us-ascii?Q?QZU65j5fE79ZRc+1z6IzScCGdzVUr1G7fiV3xOjKP7erRrydBB3fH3IaOTDh?=
 =?us-ascii?Q?MeeamMUNUpXSxJZKnjd9DWG6X6okuW187rzLbmS2kk+ro1l43lULjdeWzzW4?=
 =?us-ascii?Q?F6jxg4qOTGZignEugCGtqW11sYnyZdYxkiBPZgaQ+D7SapakkK2qvl4In9O+?=
 =?us-ascii?Q?pxEPcC9s9ZjbYVrHyL1n9eGihXxcnfnPkxtaSPW4ZT33FJs9vCKQW9cR7Ozb?=
 =?us-ascii?Q?cU9EgxkK2Ddp4CbqW/tCFXM3LSzlMolM1AtZmD/+hYRD52X7/8vXOSA8RwWz?=
 =?us-ascii?Q?RlliMNJ6yd9tMuASjZtG7arONptrHa2wRveIUu4RdqiJ1E6lpiKv1CXkOIoN?=
 =?us-ascii?Q?8nJ0BFPQnQRID5CneJJa8D4jNV4PwXmdBCjGxy+QvbBzBZGz7LCzwuo47O2i?=
 =?us-ascii?Q?SGGmfPW2yJLNsOqddDVXPsCxup2zPpSQSH3o7ODIn9P/7TCufTF18sLPuVLo?=
 =?us-ascii?Q?FcAEpswPUh7rd+LfKAjynF5BE/wM/Oup+FoMxg6lw6lXDrgGzvTAPRkzYzJa?=
 =?us-ascii?Q?E+yREXeAI3lfUgwAcnyALj7MFZcDaY8GP2AiDrgGNvIfH0NSwfd64iYepY9Q?=
 =?us-ascii?Q?4ablHefi4W/BZoMrImNuxGn6XNbq/FdK911ZPif51oP/e0EYKhAgzNwNbI6N?=
 =?us-ascii?Q?1qsZ+w1v1XPPwgYG1BhW8R7H8kaS1buT8URaUAaPbCEHoazzk/J4ZmKxGbk4?=
 =?us-ascii?Q?2rwaIyrPkroVF6yjaZWUf8GMil7jy1kpzQvw4kjTOGoq5fs2ceqShdf1FB9k?=
 =?us-ascii?Q?YBI8mO1gm0T8AfGNCT3w6kmOM70EWAMSDncl/Pj66O+WZdBV2a42TZAYiduO?=
 =?us-ascii?Q?dyAX0jZypGX6izl2gZCQmO0CMlf/AmX1rydMFPwRcseZJjJhvDtdBrOKOQ0M?=
 =?us-ascii?Q?7PeCDekaIRBVABgNkc38UQFwNMc919rLUAN013SdSAGRHhz3whhxz8TfcA6V?=
 =?us-ascii?Q?aWntOSO20lcI9kVvV7l4xCthN+UsvWW35npGVeqwAj2ndJHlLHONyQSjvMmc?=
 =?us-ascii?Q?VppihGWp6tYfiYLTEPdmPWOyajkc0cK7LAM7nxw4fyAZa6Jacan9JqqdR50V?=
 =?us-ascii?Q?J4NxTToGwIoR0m2eLYJhw7+lGamVSeuXcnASVn9twya6BDCvGWoqUncs19MM?=
 =?us-ascii?Q?1vXh5WYCo5poBx9DUpoKzX+Zcvg0XGyAR0hBtPfTrHSBkPjcDKUXwiuDAtNB?=
 =?us-ascii?Q?JUCNnITQQSauxEqcWW5JS+H9qehBsAkWp7zVd/6mpXa16iLHq5Lv9JExx0N1?=
 =?us-ascii?Q?8A/rkRMFELhi47XMdhe4zB6HIxCIs8kPJmSnM/84tME8gEWiXFl9VGAWuo/n?=
 =?us-ascii?Q?Y6E3vrqV7vFDf7blmUT8yvAE/24bKwiS51/eQotZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c95e13-d87f-4fb4-8fd7-08daf4a9c3c6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 14:31:59.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TD7xsJYg808oUF/yP93d3nmdd4A6qTbiOdagpwLjnlPGsExdnAxVV+28/hRk0H4XmG21pk4tuoIkA1YeUUE0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5324
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_extension_exist() only return two values, 0 or 1.
So there is no need to use int type.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/namei.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6032589099ce..516968cbc6d6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -22,7 +22,7 @@
 #include "acl.h"
 #include <trace/events/f2fs.h>
 
-static inline int is_extension_exist(const unsigned char *s, const char *sub,
+static inline bool is_extension_exist(const unsigned char *s, const char *sub,
 						bool tmp_ext)
 {
 	size_t slen = strlen(s);
@@ -30,19 +30,19 @@ static inline int is_extension_exist(const unsigned char *s, const char *sub,
 	int i;
 
 	if (sublen == 1 && *sub == '*')
-		return 1;
+		return true;
 
 	/*
 	 * filename format of multimedia file should be defined as:
 	 * "filename + '.' + extension + (optional: '.' + temp extension)".
 	 */
 	if (slen < sublen + 2)
-		return 0;
+		return false;
 
 	if (!tmp_ext) {
 		/* file has no temp extension */
 		if (s[slen - sublen - 1] != '.')
-			return 0;
+			return false;
 		return !strncasecmp(s + slen - sublen, sub, sublen);
 	}
 
@@ -50,10 +50,10 @@ static inline int is_extension_exist(const unsigned char *s, const char *sub,
 		if (s[i] != '.')
 			continue;
 		if (!strncasecmp(s + i + 1, sub, sublen))
-			return 1;
+			return true;
 	}
 
-	return 0;
+	return false;
 }
 
 int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
-- 
2.25.1

