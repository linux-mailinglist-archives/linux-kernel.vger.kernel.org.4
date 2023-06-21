Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D45738034
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFUJoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjFUJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:44:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F62122
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNnoR2rCULpBceGH1qrKqVw2tL6maIBWOKvu4ItmI4HzMrd+6PA/6rEMgKyDF8WLw8ycn1YZMVlmUl/m5JGgFClFbnsx3IzT2urhugqSUDJx9U7Mfjn6yYFAg/I6dnFqenT5d5iz/AQxwLU7neYKq8a9MtI0Sf1li1y242aNIGTBmUQzL/P/+FGigNH5HKmi7EhY2aVjIUS2347zMfjx7c4wY43pB/PP8FHnvq3ok5UtVeAn9qJ32Uzrshgk1Plex6f/6BzSRguBc0DlZ6GjYopVzFTkMEIVlOVC1UYHlwPucHGCSo8Grv8pUXyVgnqlBEYsXFOCHsSGapmYIoJu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9n6hAlwBhaCOVqO1oeth7RtUmcL9lX0Xgg0Awq05to=;
 b=Uh6leckUpve0QRHeiBMI9UFh3QoX5VtRJc1pstIeMRkxhQ7NS4h//XHPcSSuKthqqVNzz9d6bv6yzg3+l9nZbw0altk1BsdmUORAiRbrze6IsLb77CVg0gombZPR9L9CwEilNBy9sx4fwml7VwksVJZRkzA5RMPOKtFOddbhLZmUcS62TzgtlBY9mhAxZOBixvCt+IvqoNdUw7Yn7fn/XBAIHlyyynrWWBooF9wR4QDLUUS7Y77aOf6cn3VXt9Pt2utw7PeM3lWFQRLwIiYmhZABHaqVX6BBH/+znD0H/Fc4rCfyaxivQ6lGxWWCzw+qhSQc8bWjn01wvu3VCyOvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9n6hAlwBhaCOVqO1oeth7RtUmcL9lX0Xgg0Awq05to=;
 b=iV2OIaG0Sq9XxQOXhcfDKeth118fPnrWlQ9pg7Whkl2UZRdOghX+zmheGw+bo2qIGg281fHBo6RImqR56AyuEr7ScfYRyZM0iP5ZKlCVZK2bIyedT98rD15QBcJakZLlQzUKz3VeqHhk1kGJZ52H5dhIL+qvgOZ+nQ3egBpuV+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
 by TY0PR02MB5621.apcprd02.prod.outlook.com (2603:1096:400:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 09:44:14 +0000
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb]) by TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb%4]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 09:44:14 +0000
From:   Yunlei He <heyunlei@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yunlei He <heyunlei@oppo.com>
Subject: [f2fs-dev][PATCH 1/2 v2] f2fs: update mtime and ctime in move file range method
Date:   Wed, 21 Jun 2023 17:43:58 +0800
Message-Id: <20230621094359.3827832-1-heyunlei@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::35) To TY2PR02MB4479.apcprd02.prod.outlook.com
 (2603:1096:404:800e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR02MB4479:EE_|TY0PR02MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 57826df0-0d76-4273-b075-08db723c12b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DRZLKYtDHQNRX8tdkArPatWH72OR+KMOl6BLmFC8/KKmfrUT+wdYv/lGhyGVGywxwC0MTU13naWvMJdlPk5c0bbMPK1/86u1HtmA7hUeh/y4rN1GYK0sdwzHVl1nOZoYoYd2UcE/+/M7xPmShVIEudgslw6eJkx8ru1vM35Ts90bkTBWrof/fRUu8Fb04Jz0rt63cmZKqADF8ivqyiyQrzgmzXEcF//lATBSUEoOHL51WXC7Z3eb+ZecFtVEs7j2HCwRgL3fnQzjY31Bb/ce9pTEAeKK9OYK+7V/ceFWqqRvwU23qfYprO7W1PzEckunpNYi7tCsPPIkburUNFQZus3it0lhNVPJxIJ42H2um8aH8O+w7nqnxWjGyFhSZf0+Uw32/YU6WtKq1MpSBcBp4Vs49Y/kH56FHMz1oMR3tYkvh3X58w8ovhdO+qczo2uySxM/AYAYwgWSyp4B8qjYvlMsVVN+bDzzdFCU7Er0j2yqPKuwt2s0CtQyuzrB6sW3rRhmgtL4nrb0FgxHdHmBP52auknr7SlmhT2dnkiuwVkKf3oHXP+wBXXJ/UmV3891T9EESY/HhCkKhEOS39xcPP6M/QsKQJtma4MAbqCDArzGO54M2pvRG2JLNeaWRq3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4479.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(38350700002)(38100700002)(36756003)(86362001)(8676002)(66476007)(4326008)(66556008)(66946007)(316002)(41300700001)(26005)(1076003)(6486002)(107886003)(6512007)(6666004)(5660300002)(6506007)(8936002)(186003)(2616005)(15650500001)(2906002)(4744005)(478600001)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nvf936NC4o8VZeq5/vYf3Gw3hlMnA660RwnlrlqQ/i87NZ1NMqXMi2iSAgBP?=
 =?us-ascii?Q?tO1cubyorUHBPcjMrw95a8zZHv3UZcoOQqBaaIxcT0DKUskxODeCAe1wFqML?=
 =?us-ascii?Q?aB2X5vXbDVIdpKdVP5TlyI3L/t9Mxi3Z+M0hB0NLEyae2iqO/6sJBupqm2+F?=
 =?us-ascii?Q?GDhQQhDF0Jzkvmh5j/kj2baDh52ojFLr5xXfyLXyV/UldNp212V+gTyLZddB?=
 =?us-ascii?Q?h5FWkAFK5JrIP4faGb4ZrDagGux1Np9o5UO6QFxrS/CBg9HLHiraREsq9qrI?=
 =?us-ascii?Q?HuZVyzJcwVyoQks+oupTXB3ZpCImC87p/ZLAKOOLrV4GFST4qrxIjg/qHICI?=
 =?us-ascii?Q?58RJ7A8qhZKJQPoKEEYi09nYEB10clzwemjVkDYdhSQYPPkdPkZiWWTnuqUt?=
 =?us-ascii?Q?634mz6j5IegHUx0X2L9e/a+l8puw6cgfFJ4sp9mVT6VtZRi2yeV2lBmAbvag?=
 =?us-ascii?Q?u7lpGYKAoDvgYHiwffoNRaW9TrD2qCni5uDb474iFhUyLIXj96eDTJXCVUEO?=
 =?us-ascii?Q?OWR4gWxYmaB8ky9sDOb4rv0CbsHNCZtG/ZCboLOCO9iLD/O759duNNqK1Lna?=
 =?us-ascii?Q?ZCXKQFzfSwe05LBnE+R5rTQ7nSuc15IDnxC/RdlS10SALZKwTgiAx/JnQET4?=
 =?us-ascii?Q?Mhsz1hEQxstSAOaO8hHSETpWqH0CmdaG6uMR6HEo5w6fHQI1acARpr2MfO2o?=
 =?us-ascii?Q?bWLOiJBEeafFbfhVGZ0o40Cg3l3WrJfwBU1xPjmeSWzK6cIiAQGwpFwUkcN7?=
 =?us-ascii?Q?UXwoCHDYQdi6tEU3AcvaCvWLGugPy1rl9EPzT315Fule+eohiaxns0UzsOe5?=
 =?us-ascii?Q?5T9XAlmv1pmGh0eG09UEpCUS31T7Ft91uGKYcB30C2xOivukt3gLzSsXpCta?=
 =?us-ascii?Q?p8thgHkuXOCCmMGF8rqu2awE0AkhVbCCloxgZDH1t9NBhsAfk9eZv9Icxt9Z?=
 =?us-ascii?Q?qZLgT2NT+pSkqv9Qejw5MdQX56Ng2PsZ4XjUEC/jwgkYLPo/kERA12nE0n1/?=
 =?us-ascii?Q?r4ou5Wpw1w4FDeIHdaoqpNmy2iUn38Oe6yMsqObFq/wkxCoEs+iHEY9i6dee?=
 =?us-ascii?Q?H9dNDpaAJj3cfKFNcdJ71l43BTiOHcf/3S+MBE9wSGy70BSvKumqqTKSexID?=
 =?us-ascii?Q?eA6PINtpR6xcQ6OsvwM+AXA9QSgsud+3wsYKnWDYE8KQrqwCOwGFhbSQN2d0?=
 =?us-ascii?Q?MTgHntyVEmENIz12dmZxKTL88sujQ67LpyRXA6XZfBt7aZCtrZRAMRP0wFqk?=
 =?us-ascii?Q?UGKCG5E3eDuY412buDzu7pYRme3TykdsHdepydW5tV+fRo8ThzwgUGFODY+I?=
 =?us-ascii?Q?vrT9pkzCNDw8T1pq4M4/drYcKfBvlzHjfLFUQV3621FxYMIRbezzIWq0XM0G?=
 =?us-ascii?Q?yhYjinUgUEXl2aUBFCcSAYC7zq4GPP1BZV94lVRwaLOLcWB74wP5faicAz/d?=
 =?us-ascii?Q?cvUFJzPeQH12KPcZHKG4yaxiSaQIamrDM5WgfaEEpNZCYoZyuRWQQFTjP3Wl?=
 =?us-ascii?Q?QGsr14JFQKNT794Jo0M5mvMG1LvqMvvqhPAPr8j3xj6wd9CfVhBAOqZ9Q0MR?=
 =?us-ascii?Q?jVZLeQm9oL3MBjn84hELtQVMy936jG395h70OQ9X?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57826df0-0d76-4273-b075-08db723c12b9
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4479.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 09:44:14.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5j4Koy1A4TDJCBUtRVEiM/JUGXTz/IBKf7iIABRmDcmgIapRBk5EG089XRURehRB26m6zHxEpMHHV9+c5uKv5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5621
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mtime and ctime stay old value without update after move
file range ioctl. This patch add time update.

Signed-off-by: Yunlei He <heyunlei@oppo.com>
---
v2:
-update both src and dst inode
 fs/f2fs/file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cb42d8464ad9..4adcf62e2665 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2884,8 +2884,22 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 
 	if (src != dst)
 		f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
+
 out_src:
 	f2fs_up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
+
+	if (!ret) {
+		src->i_mtime = src->i_ctime = current_time(src);
+		f2fs_mark_inode_dirty_sync(src, false);
+
+		if (src != dst) {
+			dst->i_mtime = dst->i_ctime = current_time(dst);
+			f2fs_mark_inode_dirty_sync(dst, false);
+		}
+
+		f2fs_update_time(F2FS_I_SB(src), REQ_TIME);
+	}
+
 out_unlock:
 	if (src != dst)
 		inode_unlock(dst);
-- 
2.40.1

