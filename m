Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7AC6DB080
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDGQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDGQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:23:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9475A9B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE9qUsr4W8Zn3onzpXNoWfB4zQVIEG38Qia3Hl5QUaQvwk2oaSCCJwYkQw4Sz9odAgqoV6LJs9frkCB3V1QQrA68D2m8Nb+PK2kzm0ivQ+94PQGbdqXtLBZslRM4+3rAV/D7BORG3sIADaRFrEc+LbNXzMjzd07GgV2qL+BTbNG6vFwzZjay/DNN+8hmsB7+YcqC33+KtJcWOMrfP2HqzbKz9mOtC54xOWb3txOqAtHcWCDXcMZ/Bb9DA2mingqDRZiXSMabtS05qb/1CWwXSW5UxqZo57fFFUmfL+kyZ8MlBudLndg4najKVzWq0gGTXBJKErMNW2GV0aHYOquN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssRQeSN/RV+5LNCaSA2qx7f8xAuqwhvJVkhPoQeewYw=;
 b=fCIvj1ZM3BtTPC1T3cNoJmXxPDwbsPjGSFLWLv2KUP8gCcGLepgVrLosAUJ/nvADAHQubRDy4809pgwxlyl618I9zqCAEma9Pr7GnimvbtqzNFG9Tm97DSpG6k+37pxoWCk8FSxi1fZ/l98Bnt0LwoPhF7Rvho9ogwBbk7SBAQb8VJ3ejerKYPpWG8lliwh5qMVERh5ZIumo45liOwQJayUK3Q62bxksawv1+VOiMxlmxfOapaaxOjtRP5u+S+C54z5WwpVYOdgsvNlVAhc9RH4FORcx43NcGOFw94csHkb12HhZ0uoJVAQp1cFHIP+jcxL1OUbn7Ho6bkfDvbvX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssRQeSN/RV+5LNCaSA2qx7f8xAuqwhvJVkhPoQeewYw=;
 b=D1xjCrerTJ1WMYTSVZk63/A33br2MWwmPxBQNtfqOVTh0AQvaesq1lYNTWp1FoDzAVVnZ6XBA0lRzYBYXV5L4Jx3I/D6Evl9wGAtz7dJS8R5Ah9yzNgLst4P2W7qr544+V1Kqib0m3EriYhPHZ2p3/PqLHD9b0yKPLz2xprUJ0iC4tsAHc/8CK/s/2DcYs9plLA+TJVlu2oc2gzU7+Uxt4wOakC9vIqSeS4XnAb3Zh01O/CTtHsJfFXK/+LFnXyBc5H8ahaOAAKTRdSQguN6rYKeV8XiDrAtkaYmFNVV95UJSh77JSmCOgAWbNJiPDOqTuaQMBGp1+hPwIHgtGJ3og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5571.apcprd06.prod.outlook.com (2603:1096:301:ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Fri, 7 Apr
 2023 16:23:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 16:23:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Cc:     Yangtao Li <frank.li@vivo.com>, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: fix error code in orangefs_sysfs_init()
Date:   Sat,  8 Apr 2023 00:22:57 +0800
Message-Id: <20230407162257.57163-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: b142cdfa-9313-4903-f97b-08db37846227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2yJQ35OH/uI/3jUW6IEnnAjSqwav4KjZX9JOioQK+x08MstqUDbt2SCZQPQka4UPmFb0I8ewlYLhEMDfOuHnWEf/KsUkiVaDBkhyLRkhEBZoGspH1bpV0lOdKahVWHVJjkYiFYpxaGxqjhtB11yNSb2JMCj5fu4TpJtGbhL0IfIwVl2rvdB+kehjfIKUbXe4EC+3nuFF1kS0yv9sGPHEWUnJpogBAvu2K/26/bDKrqaNiT/kcSBbuUzMopNHmaHUzPLMZRQtexIFbUsnGxGv9ruswAzJvb+emttXAu0U4MUJqaCNnqhIA1UX8oW0jFgS6ges9hELXGpZSedXmShY9Iub4CWnv/0IKNHK2rMJ0MgHDvGYNlcAyRdZb+4mPVDXb97sAQMkbUNaYwM64FnU2oGVEwgrqvm/OVX724jtcRJr8bOWUrEISTOv+wNIH5KdAy424+fnkVBqusGoO2ebtd+oMb0NTKakabZSDnSuYZvVixcwXw8ZXTLqKhC890CUrCcjEZ+DgRN3VSHFDWEGJnbc4Xj7jfXiOpCqDPG9SliRdlHlps537uTqZQP4QaWoHYQUn53Rv7J+jtBE7jyg8k7+KiQzEqcPiJu2OFGolSHOqqzYdY9kIVK+Mu1JZfy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(2616005)(83380400001)(316002)(26005)(6486002)(478600001)(52116002)(186003)(110136005)(6666004)(6506007)(6512007)(1076003)(5660300002)(66476007)(2906002)(38100700002)(41300700001)(66946007)(86362001)(66556008)(8936002)(8676002)(36756003)(4326008)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ill5NEVM3H0zEaH6vmWqxBW9f3CQ3WEiuQO612+W32SRyCe9Ljo7XMv8j1oT?=
 =?us-ascii?Q?V1eMxE43tT5PcpyKxVWxvaWJ51eNq2Qxgx8ObB1oYpVRLJaT4FhpRhX+vf+b?=
 =?us-ascii?Q?cPeiAqHg+zXyg6Fm7b4T5NuObg2Eopf6VHZnz6EqrKN9u17xWlVKvba4iI3q?=
 =?us-ascii?Q?EQadlc5BQh2jn9LauEuVlBtyykZnU0jIJjKzzTpASY4tGBOjozM6AEsaFsUV?=
 =?us-ascii?Q?Gm0jssLbm0RXa6Bj1nWJI34UuF8yjLlgo6+fPyE55dUT92KSMxWjRidZYVQC?=
 =?us-ascii?Q?sjphx16UPBqhPTUfR4ZrJJVQDQgbkGNqVSzt72nzqO6yOSbK2INeA2g2nGLw?=
 =?us-ascii?Q?uS4ElGxpDtBXCp03DWyBv6txGRvVVl79byIg8N5lVKNGciNWO4A1fFVBneed?=
 =?us-ascii?Q?neeeF3J6hCMoyp1R6Sw8rVypuVHBvjkutulfEQNk8a9ClVxeg0/6dB2aXOf+?=
 =?us-ascii?Q?d/F19qv6ikDOCHZfMUg7xwWO18xdqs5xyuyzaNrcd1SivxIQerjzoBPcxVA/?=
 =?us-ascii?Q?74NYeIQAlGdRCUNTmhWv5DPb0Zq490T8t5puU1AZgFztYXWqrpiEkqo8bbtD?=
 =?us-ascii?Q?cHU2hr+jALKUFU6he1TFPy2GALSRN93w8p98t8Xp+r4efAvmIjI3icc3Pbok?=
 =?us-ascii?Q?IjClYz4E8TY2p5w+Lndmx03y4Rw2tgbvLaPNQ41dRHhqoQryoAgkNCKkiBWP?=
 =?us-ascii?Q?Zy4NovZr0fDxg5FBuG+SaOQlMEE/+APZTeYScwe7G7sbOdeQpNJKBtTMY2/1?=
 =?us-ascii?Q?iiSr8GKqhPfl0FQwnZ6PekKBnkkb+IaMCg2XsVZcIXPxauyi7CTwihV+SbS7?=
 =?us-ascii?Q?l839eEo6RIfu7I5OEcb895TsPrIXQzkoctZ3y/0sZFsgz9lFpNUOn35K2kAS?=
 =?us-ascii?Q?/SUvNnvU+yI35MIgYab3GqZcba/wcNB4AMm1WIkGjIZ3kxgrKEhBXYU81BgH?=
 =?us-ascii?Q?951DD+lG+QdXEUaq3+sEz/7cpVueQtSegItzDwQN453TVYjnQxHmycerZODO?=
 =?us-ascii?Q?7AT1IWPzeduOMAbhvxYOZJLKTKqVRwZDKVDbPYeUdeKkdC64PQQA3bOCi99Y?=
 =?us-ascii?Q?ltPJgAILfI44KpSvT2uZj02t33EUrQy+/JMgMf9zus4NiCaTXy34UwyXSG1e?=
 =?us-ascii?Q?L/nEj0Z4Pyjh6Z7lBh+NSksXtZaQRGP7OEtLeVW/4uX6jdZD1Iu2/UBmsCQJ?=
 =?us-ascii?Q?BPgLwDkqCsAw2/k6uCPcoZ4Xym2fu6qJ4DqLoyXhxSh7kY79nhl8ye0G9JhP?=
 =?us-ascii?Q?x6WUncGoI7CfVPtzbpWIz1BuJ7cX+DWtAkcZFdA/xv+vI0rcMWILSq1fBoNg?=
 =?us-ascii?Q?AZvl3malAZSHAZBxejorX+cHv7ebmR4XMs9nwwfksEMe6rkbiZHip3y0pMut?=
 =?us-ascii?Q?CuYPr2VzqeoK5Kga/7uWnsXhZeM/4hPczYjmaSl+fn+uY5MgfjM9zsrqu7nY?=
 =?us-ascii?Q?+F/88Ctq5UefWwPeBVbm4Xh04gQ0WwS0bOfaMi3ZL3BL9h7kBY3k8tjYqNrf?=
 =?us-ascii?Q?cg0MiaK/jGV21regi9HhC7uWM11XX1qtpNfZ/9qUB8xIFwSl6rWSS2srVReo?=
 =?us-ascii?Q?R5ouiJBhiiB18QDTD4osiYKl6fDl9ezsH3V8aIQj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b142cdfa-9313-4903-f97b-08db37846227
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:23:12.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKIYyuDtIcUJUYfUQtgGms6/f+Ikv11a7SEkBC1PtSZE7i/9tLJcKOIBn1+0gw/FlLyvjMZFRTxGIqTqb0bp9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5571
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kzalloc() fails, error code should be ENOMEM.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/orangefs/orangefs-sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.c
index be4ba03a01a0..d349d8ea0593 100644
--- a/fs/orangefs/orangefs-sysfs.c
+++ b/fs/orangefs/orangefs-sysfs.c
@@ -1173,7 +1173,7 @@ static struct kobj_type stats_orangefs_ktype = {
 
 int orangefs_sysfs_init(void)
 {
-	int rc = -EINVAL;
+	int rc = -ENOMEM;
 
 	gossip_debug(GOSSIP_SYSFS_DEBUG, "orangefs_sysfs_init: start\n");
 
@@ -1195,7 +1195,7 @@ int orangefs_sysfs_init(void)
 	/* create /sys/fs/orangefs/acache. */
 	acache_orangefs_obj = kzalloc(sizeof(*acache_orangefs_obj), GFP_KERNEL);
 	if (!acache_orangefs_obj) {
-		rc = -EINVAL;
+		rc = -ENOMEM;
 		goto ofs_obj_bail;
 	}
 
@@ -1213,7 +1213,7 @@ int orangefs_sysfs_init(void)
 	capcache_orangefs_obj =
 		kzalloc(sizeof(*capcache_orangefs_obj), GFP_KERNEL);
 	if (!capcache_orangefs_obj) {
-		rc = -EINVAL;
+		rc = -ENOMEM;
 		goto acache_obj_bail;
 	}
 
@@ -1230,7 +1230,7 @@ int orangefs_sysfs_init(void)
 	ccache_orangefs_obj =
 		kzalloc(sizeof(*ccache_orangefs_obj), GFP_KERNEL);
 	if (!ccache_orangefs_obj) {
-		rc = -EINVAL;
+		rc = -ENOMEM;
 		goto capcache_obj_bail;
 	}
 
@@ -1246,7 +1246,7 @@ int orangefs_sysfs_init(void)
 	/* create /sys/fs/orangefs/ncache. */
 	ncache_orangefs_obj = kzalloc(sizeof(*ncache_orangefs_obj), GFP_KERNEL);
 	if (!ncache_orangefs_obj) {
-		rc = -EINVAL;
+		rc = -ENOMEM;
 		goto ccache_obj_bail;
 	}
 
@@ -1263,7 +1263,7 @@ int orangefs_sysfs_init(void)
 	/* create /sys/fs/orangefs/perf_counters. */
 	pc_orangefs_obj = kzalloc(sizeof(*pc_orangefs_obj), GFP_KERNEL);
 	if (!pc_orangefs_obj) {
-		rc = -EINVAL;
+		rc = -ENOMEM;
 		goto ncache_obj_bail;
 	}
 
@@ -1280,7 +1280,7 @@ int orangefs_sysfs_init(void)
 	/* create /sys/fs/orangefs/stats. */
 	stats_orangefs_obj = kzalloc(sizeof(*stats_orangefs_obj), GFP_KERNEL);
 	if (!stats_orangefs_obj) {
-		rc = -EINVAL;
+		rc = -ENOMEM;
 		goto pc_obj_bail;
 	}
 
-- 
2.35.1

