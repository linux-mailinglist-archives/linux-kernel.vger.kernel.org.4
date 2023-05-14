Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1F701DB6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjENOLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:11:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2065.outbound.protection.outlook.com [40.92.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD961FD3;
        Sun, 14 May 2023 07:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjSRlrpGcUG1nWxDA6f2lPk9wjKjun5Edb93qyfN4BVzEXN/v58uO3WRGgQvfdf2IVKsshr2HYBlqqL2YKfovU4cN7+FdL7e5VOiXI0pZde4vx9TK2OuN27ze6NhOHUkDNyy4KZ/HJlb9DHcFntogDqQY//W629zY1k5wNieO1In+HN/bw+vI2Mnha9T0t+EVNszhhuSJunugxtHSQgN5kS4wMkfhhEpkNCiUQ86/eEY4X7BfZaQpkFoOHQmrgy5+a36jj3irYWDKQXqPfTxDuvPWvd62y0SXA/tbhWVxGYAK4dVM3Z2ZORsDjeS7J2nAfhiy6NPqARtkGTVbw6X2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEURXn2MUSTOfF6V8QS0pnLZ4pDAzgStc64V4iyDi/o=;
 b=cN637mmTLwmLA8hJCTfnwiTU1bRAxTOaahsgMYXE/Ko9k6etHUy3S5Kyf1KLrYdgTtnyN1jF5vU2C659XhdPPylH6eatabPySlct9eg1T60+InmSP7yP0cC3vJDzzuB1nuCd4gsN8WA+h3yNbjb0A/POHqVH6xNVqFF5IbJYDEGa2r7GAMAwPGITVnBYYZGYp3URVczi2HqvZ9vZgGSyjtR7HpCJgrlYBvDqnli1jEByb0NsI99XD9dC2FLCbUMcF+hBNPi5bMo5DCsP3kINjN8LN5bz9Rhhb9KZq0rXXDsiYHH0KP4eqP6BbpO4SayYld2ZHvsX3XdqlB6+8ZqKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEURXn2MUSTOfF6V8QS0pnLZ4pDAzgStc64V4iyDi/o=;
 b=IQ35wsrke/fM1q7strJK1hETQOxLOfePRrGPc4YKH+7E2qH+bDckK7ptbHBLSIGE52zq2B0WrCqG0+CvSqbzwNDNNM6WQMC79YA+KMHPaRhds1a7WyEc2o54NslthINnn3lR2heWy1+uFkecUgk8mmp3oh5xzqLiM3VM0D6KKrwfVfLaM1mRDPv1eW6IGsa1qrrwd2CoO3XIocF5yeL2xQU0qy+R2NHyJoSkBiUZVT2iIMPqrEMBPEyHynzq9R1xaDamTrxfI5wY3lKYbykTamLDBxqKLBzli7k2FRMgR7VrTpSDcJujFEgPbEViKQDEWAOaTzvgHXdAAqWkl+gW3g==
Received: from CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 14:11:04 +0000
Received: from CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6]) by CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6%5]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 14:11:04 +0000
From:   mirimmad@outlook.com
Cc:     axboe@kernel.dk, christoph.boehmwalder@linbit.com,
        drbd-dev@lists.linbit.com, lars.ellenberg@linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mirimmad17@gmail.com, philipp.reisner@linbit.com,
        skhan@linuxfoundation.org
Subject: [PATCH v2] drdb: fix debugfs_create_dir and debugfs_create_symlink error handling
Date:   Sun, 14 May 2023 19:40:33 +0530
Message-ID: <CY5PR12MB64558DB2E8ACBD592F26E61AC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
References: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [mPiGp7NSzqAnqy2xDuqy70YZ+6LqbMoYoeIU3kCKUChCI6yypO1ZEK9XzfurKdza]
X-ClientProxiedBy: PN3PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::10) To CY5PR12MB6455.namprd12.prod.outlook.com
 (2603:10b6:930:35::10)
X-Microsoft-Original-Message-ID: <20230514141033.190225-1-mirimmad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 3976f6a6-5f8e-4795-e61a-08db54850d97
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M06tUm13rjHg3UWqCCywsj8bXnitzZLkvNChTb11yS+8hMjZf2Sf/nlFqBEtGqWz8xsSguoUWfeP1XH0ZpOIbjMDtcMvAttYmXariObAN6A9KHEh8uYKiDpMU8iV/zuTbVnBQOYmCc3H9B/ni9kjQgvHunGPeEQ7Uw3V4tsxViZ3ON6UpWqxnkyT7f6zLxfXRUDdrylVL82SHvrK5GdQBLchUCqnqDQEhmddpjeJJlvwtThh1dTfNxua5pHZyHRwJYcC/e2nNpMehiJRPoW4YYvztpF6nmTpN65StVOb5ORynaDh7Kld9q9TtekvzhMh6ojncP9qLDU23QQamCR1K/2Y7UjJkQCONf5K5IVFtxZP4DYtXyIOqizBtKQ8qEUCoxzDfKxJ914mzUQpVkQgIU+Ff0Xj+f4CPFmCw4mAM/pFSSm/wv5JZY308frtK27uQ7A5CNN7k61de3gJDtH5mINDMhK4Z52Dt1IqhZ9GFjZKw/mWtrO+4nSm9UsUUiH4rWD+9EecoVogcPaEmPuSt6OTy5fChsPgKllLwZoZp6nM++OohOGHNT4ED1Cl4Vw7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3VqGW3rF1zmn6O6FtMiQqTVmxNwcg+vGeD9kM3ONTf+REfRX9Rq8zAqM3bsI?=
 =?us-ascii?Q?+3F5TNtH8qMaYeyDIRoTDg38TBV++ZGLxqv9RI6XEmwOJfwAmBUYJs1i8toj?=
 =?us-ascii?Q?p062ejyt+o+Fkji1IAMI4/hq+dgkyppuhuRPsLL9ZE9x4pWo0RtvOVdrpD5B?=
 =?us-ascii?Q?oopX7+2tvRIJtxUSdMKEsbMhfc5CLEiKpgBfS+Cp/BW6/lvyntgxcP9hIy8b?=
 =?us-ascii?Q?ujyn6qQ0zklhzA1WJHdaFMnSMF50kX8aQsfEFIL3XDEuam2O+CcORdn3VK7C?=
 =?us-ascii?Q?Hm3uwE+ngW1zNz9UGe+6/ZTTwZXgNbEk3+lqqXmk9vM2DWZOmIKnUpKCp86u?=
 =?us-ascii?Q?G4Gw9yXtId8u8BC2JGh8mfoSv3S1B9JYpmLtY1viuKIopZb179PILkQa73EV?=
 =?us-ascii?Q?u2JnCDe5ovsYb2KrfgYXRWftc0i9nAzovjQ1eOVJy/CVI28K2mfObLwJBJT4?=
 =?us-ascii?Q?U1kcigjSLgRiOaWnYyhQ4aulYsaNPZzey7lFcMyHav1R0HTeuCBMbgJC3Xfe?=
 =?us-ascii?Q?Alp/eY+AKcjTXcyFyBYkrJ0Jksqa0gBZUzZl+WJddY4vrbSKVwmnu/YMtkLJ?=
 =?us-ascii?Q?t7uMpBaWeL6EGln9NHKQOfxUS0E+DEeACJUdTxLhSMmvkBSzQKmNemyXbtkH?=
 =?us-ascii?Q?OzTZVBEtftC76eVdaBt4gY8WzNvwAYc0BnFUg10Ckt9KpP5Qki0Dx4fAuYUI?=
 =?us-ascii?Q?6etvBoFXwCr1dX7Vmf84nOq3CVIU/aB/sQifs1TGQxZxucR6XF18faOv6q0I?=
 =?us-ascii?Q?mFqz0P/HIqwjyke6qwZJoEmbAHHgVs7z4N8NGxJDvdWLmBcbMwLX5soDwMcz?=
 =?us-ascii?Q?GJwEJdX6WFRuy/COFJQPQ+HJpr6yPFgaIz62rQqLzgLKgrSXSJXjHVzc+op5?=
 =?us-ascii?Q?7qKBFha+e07AKMTKQx/3M2Nc3UKGLBy7wXKtTG2gGx0VZJQLFfDuhPTHHyK5?=
 =?us-ascii?Q?XN/N1PpBt8he2V5WSzOB/ITMB0zBkgkLjttLMAECeIq/YubmEwZ100jqjeSV?=
 =?us-ascii?Q?SGAzb1HgD5CZZFd6etcT9O1ReMjdxEsew+9IlsMuDSKWLMHayKh+zO2vxtRN?=
 =?us-ascii?Q?VbF7DK55koFYb8PVyuX6O6Ry4Mwj1KsKkS3PoXeACCMBXNsJ0m3v6MDBpVwT?=
 =?us-ascii?Q?Mz7wnVkbiXfP0MvI9Yl05nTYgPnQGCBgDNFil/A+dr/0X6ikDx4tHXZLopGO?=
 =?us-ascii?Q?dKuvWtML2uTR4Ad2VmEvP48cNQ52k2KkZcTMFHB9ubbg1OWF5Y2SP5kkMlU4?=
 =?us-ascii?Q?h8nU7DtsI0LaPj+O1kzD2tsRVTRrcxGAQA3PnliuGQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3976f6a6-5f8e-4795-e61a-08db54850d97
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6455.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 14:11:04.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

debugfs_create_dir and debugfs_create_symlink return ERR_PTR incase of
a failure which must be checked with the inline function IS_ERR. This
patch attempts to do the same.

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
---
Changes in v2:
    - Fix indentation
    - Fix potential memory leak

 drivers/block/drbd/drbd_debugfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 12460b584..ab431a3f2 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -781,6 +781,7 @@ void drbd_debugfs_device_add(struct drbd_device *device)

 	snprintf(vnr_buf, sizeof(vnr_buf), "%u", device->vnr);
 	dentry = debugfs_create_dir(vnr_buf, vols_dir);
+    if (IS_ERR(dentry)) goto fail;
 	device->debugfs_vol = dentry;

 	snprintf(minor_buf, sizeof(minor_buf), "%u", device->minor);
@@ -789,9 +790,15 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 	if (!slink_name)
 		goto fail;
 	dentry = debugfs_create_symlink(minor_buf, drbd_debugfs_minors, slink_name);
-	device->debugfs_minor = dentry;
-	kfree(slink_name);
-	slink_name = NULL;
+    if (!IS_ERR(dentry)) {
+        device->debugfs_minor = dentry;
+        kfree(slink_name);
+        slink_name = NULL;
+    } else {
+        kfree(slink_name);
+        slink_name = NULL;
+        goto fail;
+    }

 #define DCF(name)	do {					\
 	dentry = debugfs_create_file(#name, 0440,	\
--
2.40.0

