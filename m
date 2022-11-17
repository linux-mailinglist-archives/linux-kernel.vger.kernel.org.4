Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6782262DE61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiKQOht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiKQOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:37:21 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ACD8220C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:35:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjytyMugGyIPIxr+apUWEEpHp8z4PEDxvZHGiyLX040tERtTO6hjRqWMSZt0Zdx6g+3+bxLm8+AXpQe15GYGkYMbVK9hWynfA8MDljcjoCdqnWXnFgHKXtDCyDlbHWTWVDjCJU8h30RlCw2X5fYdORl901CzE8VpDVSnKCW9Rc7ZfdtKwnOHoudyNjDS+ZbW620KZySILxv3ljrhEcEk47LkVBYEfSkOvWplPIGNpqlw4arr8eHYy/JNcI3X82HXluuBQkYiplPJ8ajs5LagUOxGl57Dv6DAFOyNorR5SHV0i3cPkXzWSz2Gwq00ErfXlEPCO5jXeT+be2b6t/F80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0BKuEF8syyRgU4XzAFT6Af59SNVkq3BbSzf6j607pc=;
 b=oLygAO35MLcB8Tx9D1+RHC4gLH5D7M7JIG05Ud15/iMuVhIHwHrr8VXYIiJjNcbaXaF0tnV/7QcAacDomVn+PYS+ok3FWX8ZtRh6y8xuMJ2rzCyAEpqMvkKutC04P16Fmcy890AbgWPZfCeCVc7oC7TcS68QWhmRxqULUtbt5HWqV3teLCJLglDnsjXsaKiXqfb+YH2/W515MBjoEDyDOeDLPE5NZiDBckD65tQINby3hygpG6Cw0DYaMwr526XxbOKa8xtPT7VG9bOLJxn0PKhgB3KD5+JZi1E6SOYLBNdhAvGiLEq3OEp7zPWO7kkweMFHlNy4RZ+6PEgVcB3JuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0BKuEF8syyRgU4XzAFT6Af59SNVkq3BbSzf6j607pc=;
 b=j0l4cDh+ZaFmmfjLa5SEI1kolAu9CnxlRGrFskHeYo4838EofYf+UbWTpn/QLIWScEYCNLLNhvayWSzcAEYKdrXlVyz0oG+x+RK0l41ccPvtureybnR+0prOJlT7F7/bz7VHybSSEnd3lCGcFnNsv3p9xk+30/cCZrA/jydI0nRupnHQM6qehdFNq2SFDTOoswTJozTNblfIW3bqoN73Mqg20jymjD9+abrThM1yev3Vk9jeE/NvoiYGvw1eR+P9HaB+urY1Jp4KJS6VIdbqJGTL0e+fMUakzn5aJQvnMTKQwSNnew/CWzaZC7Kn9f7f20OjLSuxU+2kRsQcb6yulA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4311.apcprd06.prod.outlook.com (2603:1096:301:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 14:35:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%9]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 14:35:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: introduce discard_urgent_util sysfs node
Date:   Thu, 17 Nov 2022 22:35:09 +0800
Message-Id: <20221117143509.58913-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:404:14::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f2e7af-e06a-4802-f98c-08dac8a8f372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tGV2PCVO8D6hlBmJElz3zHyzxXzF3iqEH3DDhCu68nH2Vu9jlbqTnHwop4q1XUyCD83xtGIIeF3U76IfQSiaz4Ekj7s+VKRUEcb8nUX9mZARl1mIsRXiQrhzgbAaonp1Kqy7x5Md7TQ8kf3WcTyuujyFpfzdSqfh5r21czEJWcL3MFJoYOlyNm+KDV7BG5LVk3Fv4YA7MSjXfDv4rCkfXgmxioYyfAShJrW2D8VvNfcB/SvX+5C4ODOEUmFiDNzG5aCQUpDSfkf9ugqQnB1r5dsapIJtEnsIcCkt2reB0Z8XOm8RvQ1DoyNJ3hlvSutg5ofSDdEIgC8n2sO5YQ3L5OTU6qqUd0rh1J2PJfAgpGDTt7LmF2MXaN9TQNAXRbVVSv4cNk5/XwV1Yy2F9i775OdcN262a0F72qmUeYSbEsFx5ljw+7JhEl8BiW9Fkn9Ab5gYXeE2+6+uoiSYGh+m4b3zxsVaSTueMuoxCNCljBQQ7pl2nCJc7Ac1o2L1jkZTNpEZCknf+4RRkU00x4ZatIOaK5E7+MfPFqoL9T0tFFGeOTS5VA6eC8D54V3nbA+q7e33klgqq6W5Bnp8RlbUHSfrtYNfF1bEMlFPeRHG3dSa5pepjXzUA0VO3+OYVy4qwr+CcRZQ9d8a6RW3VxAnZ1cTsc+2HoSlgwJG+NgFjLmXdlwLqzmXAHR86cXKSG4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(2616005)(52116002)(6506007)(1076003)(26005)(186003)(6512007)(83380400001)(38100700002)(38350700002)(2906002)(5660300002)(6486002)(8936002)(107886003)(6666004)(478600001)(8676002)(316002)(66476007)(41300700001)(4326008)(66556008)(66946007)(19627235002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ocv0tYCLDAy6eUxc5HWWVexNptNxR8JJ1JVFMieE6L7GH8oHc4ovm/6V+5wW?=
 =?us-ascii?Q?8nEeYJjwq9/DOk3IpZ46igi+oJlqfvZ1jlRgO2IN1RZun29EA5EikaxAV74b?=
 =?us-ascii?Q?Xn/PjSvO12zFjJo94dlzhhIZpqacWE8AwYBJk3SNaMWpraMQrhdWChl2VPaY?=
 =?us-ascii?Q?siGT6UR0zaCvqMLdiT2pCLUIbKG4UVFDpgUs5ZsFEFXwIBLINAr2TV/q1/ly?=
 =?us-ascii?Q?kmPSqA9kfE0PNu2CyGfzVrP+Poh83jmCW/BcugWoY5Rw+/JEUlwPdGTfDcsF?=
 =?us-ascii?Q?IFJlId5C/YibywLT2A0LJTBxWy2VoUiS4YL5STTYYqa7lk5G4KJ5B1KAF4A/?=
 =?us-ascii?Q?IKCLIO7SQEvuqjALRg2YfQ6Y+qeFLlXOH6ZmK3qz88bZ3MnMx5qlRQVJSKDG?=
 =?us-ascii?Q?ApkaF0NK7U7IUJzz7DyXVDMvaCMlHoWXlDtv7xUA0XTDyx7Le37M8seTNALi?=
 =?us-ascii?Q?zeL0FAul3NUPXLlr+HA6O3RyuZsdrt/qE6gUt32ALRWCyHMixgAdJDj3DBcT?=
 =?us-ascii?Q?4ILTO+1YBwv3+oUUQAmvlzRH6tgjxOFbh6v1ElNxngqQN/hcCUQeE9SYea/9?=
 =?us-ascii?Q?Vfki4e72dkVnta2/rtDTYPtGpVj1jgzi2xsaASgqtBVlwFmmeUfqOufuGD6a?=
 =?us-ascii?Q?tN/dLAR+nN2nFeX/M0YxPDrkOxvTe+Z9Jdo4POQlXlO7zIaC9lpprITGEnFn?=
 =?us-ascii?Q?dUkOkyzk9R5a5OhtetsxN1WdKqEMX3t2ctN9EMKa71YYa6S7igwLElHZ00bW?=
 =?us-ascii?Q?US5W4FeVuYNCdoBQ4v7tlV5ch9J0ZaI6K4bNM1M5BCJW249OyAaTsXNuAou6?=
 =?us-ascii?Q?uksnx5TmfHZ9RrmYi3pasqc+8cFoUTf3mrrZfbsaJSMhWnPswST9ifvVmc3O?=
 =?us-ascii?Q?1l61m38ZBysD5iMF81mJz7vbtepXECC96f1TOUr8Y6Bu3okmfj4eETDARr9S?=
 =?us-ascii?Q?Y3WPRm5amTeD5ur8+Nhxjzfnul/cbU90hxLYvFW48JTJM9kwCUpQ0PuNPWB1?=
 =?us-ascii?Q?18aD/O5bUcGOaUZnegVGWhUO0g9hZj8pC0HGn+ukoM8hMmBegx3AJy8Qr2+i?=
 =?us-ascii?Q?LzL/wsTGhWdb2JeY4s593N6pcChryr4HA72iJ9SewF6Crrn/YopZV16ZwJQl?=
 =?us-ascii?Q?Hu/oBj+fzrbJFdlCTUOqDQPdv2Zofm5J9r5GDzyXfOFF6rwvY+fdBbGWGdkc?=
 =?us-ascii?Q?wyPBRM8PX97DGk2VaraVPi0hyU9dsl8d6GHj5aZfLnpf5MbkGpFioqetVb/l?=
 =?us-ascii?Q?kC836N/HPhlUtbtxwHXC9KOX2q7hxdwJblDU0rySfX/1JbN2zPoH3ls0zAIM?=
 =?us-ascii?Q?2iDypb1i9iNxgQC06k8p4wrDKlLZ4VFGCJoCdlnbX9IF/8HzFo7zkIwdwSZa?=
 =?us-ascii?Q?/O0gEftohg8bQfFbWyoQ4WpGrfvHjGcV34NlZV75c5ehaZ1VIn7QsrmuRXhC?=
 =?us-ascii?Q?FmEiantBJWSAMK7lArIQRf1b6iXz1q7dJtY28bc15xqG1EYi9V4qCDVSnFF+?=
 =?us-ascii?Q?4PyBKi8fX1K+aLVtPWV9iEyDh7nMYI444JKBnzn/P2Uv3E7aTrGJBz3JhE3n?=
 =?us-ascii?Q?NBb0crcTVw+0jac4NNyhCuWh1EhfgldfH1GQk69O?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f2e7af-e06a-4802-f98c-08dac8a8f372
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 14:35:19.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoOGhUUAFY94Zg93ssuG7jf6vzOlIki9lY/Nn8DdnDwFSmLnPQZG6IT9AXrQq0/NKCC5oiHCsQSRBv9X03t4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4311
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Through this node, you can control the background discard
to run more aggressively when reach the utilization rate of
the space.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/segment.c                       | 3 ++-
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 24e7cb77f265..202ac1bfc6f2 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -646,3 +646,11 @@ Date:		October 2022
 Contact:	"Yangtao Li" <frank.li@vivo.com>
 Description:	Show the current gc_mode as a string.
 		This is a read-only entry.
+
+What:		/sys/fs/f2fs/<disk>/discard_urgent_util
+Date:		November 2022
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	When space utilization exceeds this, do background DISCARD aggressively.
+		Does DISCARD forcibly in a period of given min_discard_issue_time when the number
+		of discards is not 0 and set discard granularity to 1.
+	    Default: 80
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dedac413bf64..fe42ac74491d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -411,6 +411,7 @@ struct discard_cmd_control {
 	unsigned int min_discard_issue_time;	/* min. interval between discard issue */
 	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
 	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
+	unsigned int discard_urgent_util;	/* utilization which issue discard proactively */
 	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8b0b76550578..575c24b42df9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1069,7 +1069,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 		dpolicy->io_aware = true;
 		dpolicy->sync = false;
 		dpolicy->ordered = true;
-		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
+		if (utilization(sbi) > dcc->discard_urgent_util) {
 			dpolicy->granularity = 1;
 			if (atomic_read(&dcc->discard_cmd_cnt))
 				dpolicy->max_interval =
@@ -2085,6 +2085,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
 	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
 	dcc->max_discard_issue_time = DEF_MAX_DISCARD_ISSUE_TIME;
+	dcc->discard_urgent_util = DEF_DISCARD_URGENT_UTIL;
 	dcc->undiscard_blks = 0;
 	dcc->next_pos = 0;
 	dcc->root = RB_ROOT_CACHED;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 97bf0dbb0974..a7dc726054b9 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -493,6 +493,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "discard_urgent_util")) {
+		if (t == 0 || t > 100)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "migration_granularity")) {
 		if (t == 0 || t > sbi->segs_per_sec)
 			return -EINVAL;
@@ -795,6 +802,7 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_request, max_discard_req
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_urgent_util, discard_urgent_util);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_ordered_discard, max_ordered_discard);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
@@ -925,6 +933,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_discard_issue_time),
 	ATTR_LIST(mid_discard_issue_time),
 	ATTR_LIST(max_discard_issue_time),
+	ATTR_LIST(discard_urgent_util),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(max_ordered_discard),
 	ATTR_LIST(pending_discard),
-- 
2.25.1

