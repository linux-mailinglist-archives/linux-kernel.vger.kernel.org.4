Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC49719016
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjFABiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFABiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:38:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79EEA3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 18:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpq4UpBY3i+TzfzeWcBGMtfLeHmi8IryazdDhxgwI4irb5i1ZG5ZxyZiHBBvoqVDEaKosQBpAdLfGkwez4cbM39RKT7lV6pU2XBGlIqvq/X2GbXGeVT6U4Cz1KODiObEFyOETbwTn2LK3gTAWUiOL+kWYfH4ZIWO9NlklFgtq5H2Xdvs4pBn4f2EQ0zHPDKSw/sNskrnxoXOvslNR40b03379zn+o8thn0lxXhau92j6E9kXRuXczI1s9FkObJq1nk1Pk3iB7csuFeIshh1LCotn4kcr1TK8G63hzsRN1+k3JrYPH8SlkGpYI624vfZiv3tBwZB1bm76HM5XOJgBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+xDjwK/G5Ell5goJsjITLwZleVeL666IQ0nhhzjTmQ=;
 b=DIQ+ENCbypw29sqxDV2RJjpoFlwt7QlVmqFDgosu6TipsHNNQhp+wWiVBFRVemLHYSM83SRIoEIIEaKVTIT+iEibKW2q9EZeZcI3bAx4z6+G8x2K1cI3M08JdkXCBVztbd4Db3SJdfwtBn6aSKcsfV7GWPSzeFHdxEbUtAM19NXK/6NEBaWzoQZFPkkjksS86RYoCRlOAxAJxjyaDQnHW9q5NmPsm02zuFtQEnsmLh/6S5+nvQX9RnEmHLhYC0Z1ggz+GOCK12x+rlWtZSIOAllL2lkn9mzhL25u/AFhgvffcStUIInmFWvslP9uYY9G2SR9hgERNkM6srQi6DNa+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+xDjwK/G5Ell5goJsjITLwZleVeL666IQ0nhhzjTmQ=;
 b=Fu+vJnmJmD3TAoOKATuLT9ZlRq7/JUdmbLQC53ASYUqkBTmOGP4F52v2mnFd3DxOXCp7k8cgKFdxVQd2a5PPQAOLnZZIIQjODfx5WNDN8+fhNRVnE6LjvWpTNj53DxU6nzp6jhPGmB09QV8Dd3Lw/V240yq/mAmnMX7n+cwtfPwRoVTHV6XBpe3vhK6EWNdNY4kB/ytWHb+zv03rvrm/+MJZ3ehSExgNe42yMtQLVHyDw+QQhptH/JWIapsvz5OM5FTJi6jRrTQyW6LZ/JCZNoqz3M/h6vky92cZYAJhFCF9D/jd7sSR6kOLmQsTD+yeAk7h4GhwXsHa9XtbRJDsdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by SEYPR06MB5645.apcprd06.prod.outlook.com (2603:1096:101:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 01:38:11 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::a9b5:e147:e85a:96d5]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::a9b5:e147:e85a:96d5%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 01:38:11 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com,
        Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v3 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Date:   Thu,  1 Jun 2023 09:37:59 +0800
Message-Id: <20230601013759.75500-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3017:EE_|SEYPR06MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: d28b7ccc-e8b5-4bba-dd88-08db6240db36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D38IGCYG+B52zXqu0AC487yO5ibeY6sFqcDs7oW/MuSn9bqgEWiRtnttBZsEMVPx1EEdDyLMTpPLEryiz67E9oc79zq2bW/DZqamOQLqoiu6ykdpxqA0lYhacctqAWSK7T4zvHfz7vuuzEhar1Y/KLYAtdYlfOtq4+bYaEzUShg18dYj1jcsxoTmUrzA0p6UcrmhuiYie/Ep8MeTlsVVrP6xWZSpPCKz5+GIv7YvojOhRKEzuvAglYSk1AuOoy4CcydfK+e2CLmN7ez3K1gKeNJqVfHlbrUN2J9i3H0Jcq+CRXE0Y3BzLVGOXxmQhbrgb+IIWQFdMfIlWdX019laSqSoXYXY1oK36XC7aDwHOXGWBAQxRl/nIqmJ8pRKW7h/7kdNQqe60QiUIgpF1gBYhY17Cm0m5l+emnoI7TPLg0yHKRpXG3Ej/w1rpB4gpD7l4GJEDoMxDtkAjZ5IUiQ1k912apUM+kJ75975Ju/dlpaY/UR2EFh6kgUXMclnK0eLttsuOsKlyrc+cVStrbNTBBnoJxiDa9vhwUESLwl31iwlcMTwwRkxBQM3nbjpD0P4LMGeNovZHhxhJfbtoyC0Grg8nINpO4vXl4ZwfPidzJDLW7XUaGwPUJ4O3+TzXye9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(8936002)(8676002)(5660300002)(186003)(478600001)(110136005)(52116002)(6486002)(41300700001)(6666004)(316002)(6512007)(6506007)(4326008)(1076003)(26005)(107886003)(66476007)(66946007)(66556008)(2616005)(2906002)(83380400001)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HDo9W5zc6mJt5ud6KufUcGEr9YlSckh+p8/Boaq4zVG2smMAO9Lh3TsyVLo+?=
 =?us-ascii?Q?6aMLB5Zuz1PLpJaN36xLFzfILDqaY5QjPfNO8ns/WkXF8jF61dLNY7hx8aHp?=
 =?us-ascii?Q?keOd5hxYURnHOJdCUUjhoraFS3veRVK9e264eTZVs7DV7oroBHVQeZc+0SZK?=
 =?us-ascii?Q?UU9/xw0+sgn0l7MegBsieem6CeRbQn9yVKNSQ/ArLmMwkT/qIyhKQyJ93XuC?=
 =?us-ascii?Q?eqobDfk1mGyj9GuIzyrq6IV7f9+WLPL83iN60LM8e8RfnJTHWWlPSIV1VBNR?=
 =?us-ascii?Q?GMJud4oO0gRSm7BXdc7kV5jGvH82DepDCCxaXnAkQHaCq2AlQchc+IK0s4C8?=
 =?us-ascii?Q?aqEsMlEJlEC9Z6Y8+znNTBgr9AoGE3CDy6aI3KYV1rt/IrFtEPik8yY3GATs?=
 =?us-ascii?Q?tO0WzrPJkz5KeQyubin8bp5lhFIqAImtnqUIYzMjWW+H8XzurnFvRu+T8jrV?=
 =?us-ascii?Q?TZeksT0LPwEMpAmguAg2FhkUNtJ/eeSZrC6FzSGqPg6pVMAAX1heh/vxOOCw?=
 =?us-ascii?Q?xwZ/gMFXM5olhEE07O+8977M5wzFFnu0gnLkKv/e09jfM7j8NilI6umwJBF6?=
 =?us-ascii?Q?gW9Lltl+PnA6GegDriMvv1q9tfE6vGMBzrTCQwlyL0mvjetDC/9hSupXnxca?=
 =?us-ascii?Q?KxY4k6aZ7ZP+pFVODH/PkH0jkbbat9ALU27DY/DNxP+D/AdAOUgJfedQtE5O?=
 =?us-ascii?Q?fV1bP5P0SQR7gyWipQYHf1sAk2TpQ12xR0BCBRni5De4fZCQmjTXL3iWn+1J?=
 =?us-ascii?Q?LizuYtFOPaAoQ+Qk93Gx2/u4nI+dE3gOPxZDYFmJ2nOVBEyww2/vkSGD9O9g?=
 =?us-ascii?Q?8dWzaUV6NO6R5mkZSdRaPHjjIDTOV7/OX+Qn9EVBJxDOHrk1gbqwDYQeKtNn?=
 =?us-ascii?Q?nNTf0hfXclzEVn8llGuqHHgsg36sozNsIGULFLUMGzdzPMJQ6Fu6gdYmCkmD?=
 =?us-ascii?Q?tWkqmhrAJf5/qKhOoLhZKJQ9WDtKn7YGIEp+38NcmO+mfNYCqJmHkBPrjA8R?=
 =?us-ascii?Q?JjLeb1dh1MNOe+9Tvten44vvU0/XQ45XCc2MKKFDj1xQ0g4PSMiAPpevLAV0?=
 =?us-ascii?Q?I9+I9ISygHRTMXidDpN2El1c2wMfVE0AHmGPDc0BDTWoTW0Z2IH75P7ZYehY?=
 =?us-ascii?Q?CXWuU3dVQpGJwIwVkSUhuIi/wDck/x6CK+OeeR1wl+DKwR+gL/X/w2XF1H6O?=
 =?us-ascii?Q?cSQfpS54Mkg98nU7Q0N+vlg+ICT5Xl3eftwk0roP/7ntKPmH7TUReJlJt28j?=
 =?us-ascii?Q?a6rKAPt60F3UOPbCEopHkGvuYjhWjBXTbzsjfFG1SES1LUUOn5RRW2c68UT7?=
 =?us-ascii?Q?je8xzfI65NqGIcgnQhLpna3/tpMOfHgY9q58saHL7Vi4K9GXoskMw1BfLBuQ?=
 =?us-ascii?Q?DloZ9XI4w3W9amjgCt//H+0BQNKPKz9nRRQ8C/vSaUYpuIRNMkS8S1+ANAnM?=
 =?us-ascii?Q?fx1cn4LzJQ/2NqPmyi2LkwzVASiKxC8ViEMVcdyXVZCM1U1DD64so7jtxdsk?=
 =?us-ascii?Q?wbB7nQ9jVISU4S2TUWPGk7kNRz7KWm9uhEraw1WijCtz1Sa1BDmiERRH0+AR?=
 =?us-ascii?Q?lrzrn0dZqg3JMI6PWe28aHEsLm1MLDDBAuI8jcua?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28b7ccc-e8b5-4bba-dd88-08db6240db36
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 01:38:10.5433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T5eeC7vEkX34E+cMzWptOQowqg+p+a8Zu7DGec4tWXwkI5qSH5pZ5y4PsGIO9n9fqTE6lhKEoNzUdkI7mHpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NULL return of 'd_splice_alias' dosen't mean error. Thus the
successful case will also return NULL, which makes the tracepoint always
print 'err=-ENOENT'.

And the different cases of 'new' & 'err' are list as following:
1) dentry exists: err(0) with new(NULL) --> dentry, err=0
2) dentry exists: err(0) with new(VALID) --> new, err=0
3) dentry exists: err(0) with new(ERR) --> dentry, err=ERR
4) no dentry exists: err(-ENOENT) with new(NULL) --> dentry, err=-ENOENT
5) no dentry exists: err(-ENOENT) with new(VALID) --> new, err=-ENOENT
6) no dentry exists: err(-ENOENT) with new(ERR) --> dentry, err=ERR

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 77a71276ecb1..3e35eb7dbb8f 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -576,8 +576,8 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 #endif
 	new = d_splice_alias(inode, dentry);
-	err = PTR_ERR_OR_ZERO(new);
-	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
+	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
+				ino, IS_ERR(new) ? PTR_ERR(new) : err);
 	return new;
 out_iput:
 	iput(inode);
-- 
2.35.3

