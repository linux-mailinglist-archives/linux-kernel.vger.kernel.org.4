Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746AA60C244
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJYDcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJYDcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:32:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66ED8F276
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMGBG+k0sVOH3aBpjAjS+Tlq5PHcqXaXiMjWnLr2mDJPrzT31Soe0CA9OaLt8M6oUP5rRDfPaj+fmrDeg27zFZidj8ufZ+T1ymjoDotp+BvsAchGRK/xnBAYhXQNlgvOJmmyW7/gO11jqdmYhShTJR1s7yi+cjXI7dQPjLjN9+BwBIOUjcRDXOa8Cpacv0oMml7DBXnKxluaWHs91Eh50lImBPCc/WMfCOXv/D0PHSTbTBuo6P5S0FZdBUF6Ok8i3du2eNsj/VO7stxs+MPN7H1xI5nXhzfvI12tw55S+Gf9FOSkjcmXreN4o99SjrVovVdjbOGSIwE+3b0N6Ha9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj4zTZ3macccWiiLacYAjItM7uG6VtYsyYX9GCHIlfA=;
 b=ajE5z5ZF9fmU87Bsjx1zcvEG59r7NePndK9nK/XQ/xO2NuJhuoqVZVa7QwlDLd/GZHi8ZVA/HWef3JQ6dwm+SFApRpJSg+xpsMgWE/55XxVcHqAu5gpsQBMs6y9hotf3D34fee4t2Pbk7O1RrIChH4lBYA5hJcVkMGSjMKQLRn5xd+nKf/8N4EadmK7fX2QmyiVl04Jhb6FzmQJXOnbrdXmaqZkLzQhtrh+Qcm8jbdO8Mko9eM4IcgbFI63MZyBWXpVoXrv83vK1WgyQIbJAB4bXgKML9N4EusHBF8paUIXifnHzcPQuCmtMEq6lAvqQy8VUcBsnnc84k1TfpvUOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj4zTZ3macccWiiLacYAjItM7uG6VtYsyYX9GCHIlfA=;
 b=SHuHbSu3owuYn2srCGEVacQ4HZcajEfBO6uWse7Ynu8ob2AseGq++MUljO+I5ai8ojXXMjnFljWPYg9hJafOjT1eApgkeH7nEU0ixU+RhdlnnzOKce10BYdLXwuYvhKQ2mqPRkV4CJcCinjT+EnNifqBBE6WE4TBA4Lu7k4j8pnrLZTyn2GfDYdyvoK6yX10izY1VtkZH/qAqR3Q9y5QqBAf0GPElJxy9TA5pg8t2wgBIMqWy+sa0M/wbEOv4vOc3+D167cOQlQIgRjP1U8LWi9ZbXylT9I/V3q7gHD00T7D52tD3ZImeA+GgP5rq8GxZLbDwFEJg7Xmg320QheBuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4079.apcprd06.prod.outlook.com (2603:1096:400:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 03:32:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 03:32:28 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/2] f2fs: Revert "f2fs: make gc_urgent and gc_segment_mode sysfs node readable"
Date:   Tue, 25 Oct 2022 11:32:16 +0800
Message-Id: <20221025033217.14840-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e34aa0-944c-411c-a7bd-08dab6398ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wF79c9ctwh2U5WXi6fKLvbUvNOKuhYHAIvRo/VXnWWc0zXO/ayucqvks4EIntLkxqsc7Sh5fZDckgRhUAalzu6j/tKLSD83lIkbeHHhGBgU/lb8CwM1rc/Aacdi/l0uSRQzNTNqglcMV4r8iJAMi3jhP+CuiDOnHglej8PZMkws2/4ke2DlwGa/hA4JOX68oeD93QwFoeopPFWwRhkmDcw+u1T2tzVrFKVlyTCF9RpDUD3uzS00UQDFBoLZkjKBWEhQTRgOlyBz5iJhnXIEIU2quEtV+z1Z+H8S89KTpC/B4Y2nHynWCZ8vEG2t56x28mTvvtmbKzb759fTNIZFRDuQFCN1L8Z1jslpFTkvaA2TYIJPryaLxv3euG3wsh2fm2SKnOVMpDLfNYoRZIcC8Pz/xNYrJ49e/43tgDp4bBn9ld4Pcn0K/WRuZmay/6PmOIySZGPAfmUbsf2mscOM+6xUZ0sNhviH/9twZnDjScYGGKFyDM3cpo1+MmWpw9p0IpzF+htIn6MYPqaswglaBVlPj08hDpbtSa/TRFW9qs1FRGdZWDgCSm9ioekPtRi+B9lSjXfiFvhSbzVLrWWGgQTwk1c2n4rUSkHXEVdHuDl+awlvwssnVxW1SPB1dtwmMby7qsu9OHG1/xTI3bmgM7DNrtnlkopyd6pk3ZYaOBuSblsxxCu5gGpetIOunEbtnX1aAfe5l3zM+82XPxJzqDq6uvjYYJEMlKELsAjVUotRdeb661N4airc5R5z0GXE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(2906002)(8936002)(4326008)(8676002)(86362001)(66476007)(66556008)(186003)(2616005)(316002)(1076003)(5660300002)(36756003)(66946007)(41300700001)(52116002)(6506007)(38350700002)(6512007)(6666004)(38100700002)(26005)(107886003)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3OQ3L+5R514tXhAlKWEjGiKd/hs/MMB3cktmAvL4NYf1kgFaLfWiMXQnS58E?=
 =?us-ascii?Q?mt7Pl3Fj46kvxY47lTf4fG4eE5f4SEgpUIEqfl0/suAX7vvK2aLKJUIUAOCu?=
 =?us-ascii?Q?fMa9sTOGlziLssnJWX+i1ejzTJsCPKAijS76ZnWmg/ZxH36SwRv5Xt2Bo7h+?=
 =?us-ascii?Q?rV/nNk35vGby0mRRhSpjjrM4Ivt6bHkCvuUdwUOg/pT3y3Y2slpe3tKJIXfa?=
 =?us-ascii?Q?XZRMvxPqPxsfyn0OW4raPQUW9OIGhL1rn9sZxJ1UeMOG8a45uVu1Wt6iiFhv?=
 =?us-ascii?Q?8NZMBuRb95CiniyCpLhidhv/xnvR0jIs7lkmGYSUidKQy0r0Uk5R9sUviXNI?=
 =?us-ascii?Q?K6OAdRXrIXMj23WBstBMQkQOFH0Z8//XgIwAronI0Gl0tBrLv4sQwnWu95c5?=
 =?us-ascii?Q?OYce9tK3FdjZwC3IJya8pduwaukLWLEZM+XZsZfdpYa8EYnWsqX28zGf/IR/?=
 =?us-ascii?Q?bVOqUF1qzmxa+wUNqyMepbZhwkfsDgCbtzXz4Vwv0KVfqcsHFDaBxSyu8ROR?=
 =?us-ascii?Q?uQ/p/P/33UskTJIHDvc1oJs54w4pBh3fZF9lpZ90URL7laTqUApiAoQyV8js?=
 =?us-ascii?Q?63I6gm1IY33iuEnZIVpIG/r48czuGm+wSzAtxlVc1WjBhkAPvjsZEU39yFFp?=
 =?us-ascii?Q?7kJiySWtvKkZDLLmudxB8DtPCMlyv8Wu4zzA2JSveNmW6HOfXjMPD356dPlT?=
 =?us-ascii?Q?5pMNHhjwZ3W5zIoQE8tLnd5O1GNvIS4/cGtKJKZU1TLcbRKijZtPt+AlXhcZ?=
 =?us-ascii?Q?C9+hv1tdKNFfh6QQ9a0RbVhFwtTnPkVP4mnGE7jpR1zNvhgvtfP3zM7XbIBk?=
 =?us-ascii?Q?eaMaxhEAaum+8CwgXMuuI5IvR3FHYYYcNCyXF1tG60VYx6p9O6jK10hK/efT?=
 =?us-ascii?Q?xIfH6x8xTMK3OZCumkn5r0mbsaq6NKcapqbqKdLmMLFkNKYpZzBRtuLFsYWc?=
 =?us-ascii?Q?UtMAdGICWbFLEi+cRQwCmopkEBWidpf39tEfFeFC0fLKP+sj1tnGPIIpMqfk?=
 =?us-ascii?Q?oSXLo5tjkfKhPb1de41e31axIPnj51n6V06gE2kEVWjjogq01QNIF8yBS9jN?=
 =?us-ascii?Q?cTA2BiGn5JwUfHoLUHQijEOLkpf05myenMeiGN0ZsFZkCS5Neq36dWrOqUYV?=
 =?us-ascii?Q?avBv9x4BAYlNh2+8jqd8f27XlSnBIJsPyT0MENDHudBqyjn9IFZsinVdj4+L?=
 =?us-ascii?Q?UWnXEKlyJGrRULpAkUlFkKjTJSVzgC/BQMT04z+8sQ247e9TY6VBzD4yDune?=
 =?us-ascii?Q?WqmNHeryxVCcqRM4W8OQLmcT2sQjPsfjFvXyJGWyNKRcYd4ornvor0Wfuv5c?=
 =?us-ascii?Q?imUx/M/mQn7smFu4rue/ZGc60m8AV/owouCPyrhZY05prg6iM0AhrJboE6PR?=
 =?us-ascii?Q?Yr8wYPgOavnfRfA/Qwlnq19Se14PvSmNrVFRIpvfxh7V91iGGG0CDTtO93Q5?=
 =?us-ascii?Q?cHQds5lJqqMVtaw0pwxAYfqVIUlHY1sQ0gqqdnD/1xOAEOn3vSQqla9vixuQ?=
 =?us-ascii?Q?ayz6Fsib2dRjtz3O0fjGmvlIFPGEOcpDW+ThdpN0ulC0bz8mfFASPlA+zrTv?=
 =?us-ascii?Q?Muu1aIlv5c76bqgCNs8JwxDyAY2sXXyacsyrB/zg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e34aa0-944c-411c-a7bd-08dab6398ad2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 03:32:28.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/H03IGL8vAKhECHHvl/Zu9CiQBUM8T2rKMmPyzfyEGhxK5xTOED7/e1qVu+Er1shKTUA9R3mhhC3BOJ791dgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change breaks forward compatibility of gc_idle interface,
so reverts commit it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/sysfs.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..49898a7243ba 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -41,16 +41,6 @@ enum {
 	ATGC_INFO,	/* struct atgc_management */
 };
 
-static const char *gc_mode_names[MAX_GC_MODE] = {
-	"GC_NORMAL",
-	"GC_IDLE_CB",
-	"GC_IDLE_GREEDY",
-	"GC_IDLE_AT",
-	"GC_URGENT_HIGH",
-	"GC_URGENT_LOW",
-	"GC_URGENT_MID"
-};
-
 struct f2fs_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
@@ -332,13 +322,8 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
 #endif
 
-	if (!strcmp(a->attr.name, "gc_urgent"))
-		return sysfs_emit(buf, "%s\n",
-				gc_mode_names[sbi->gc_mode]);
-
 	if (!strcmp(a->attr.name, "gc_segment_mode"))
-		return sysfs_emit(buf, "%s\n",
-				gc_mode_names[sbi->gc_segment_mode]);
+		return sysfs_emit(buf, "%u\n", sbi->gc_segment_mode);
 
 	if (!strcmp(a->attr.name, "gc_reclaimed_segments")) {
 		return sysfs_emit(buf, "%u\n",
-- 
2.25.1

