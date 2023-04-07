Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09286DB44B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDGThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDGThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:37:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F21FAF26;
        Fri,  7 Apr 2023 12:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhANpWfTdsx1cLZJZBo9/zx2jjU7Rv1yRMaPSHoCtKlwUpJJ4J89sWmLfyvOnZqydLm1T4QhosUf4Ao8J8s979cPPOhHEPIs7t3fzOSogqOYqZL+SIVszOVi/U8nTp70vrLzpHaTwbLRurhpBxXpUMsuaRjWhkOMX9TRBJTOL3RfgwatGDFtuJ/dGzX5i6BtnHJoU6UzjJ3L+Iu1Ula3ls+SplHzrbEg2tWDoDMLxwknnTtELsNmgBWBgWmfd8igYuO+49t5RlrmclSPJVREp06I+rjMD0V82fhr8PZEiio1L159sPbFg5iy0qi1mcL0Xl01SEq00UbbdmdqHDsPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AREJXfHJoEbwuKan/uy5991hSj7PpaUENUEhjN7PeHI=;
 b=VbSzy/uVgKyFEVTAIk++4zVPKTBhNJz3NJaxvGA9xAdGqsA4iXGoPBR2weR3mQ5rU+CbsEo2dCgIYf40LNX9eAGEl3CWOjnr8xmcCZ2SbfJRyNaeRHiHrF7gbWlt1jrfGpFJAAIrjPdb4JU70+gWn8cEvHk7vtlNjb+ruyIfrR33WAddNB/HFg2eGsLeh4AEW5Pad3JPOzav9F82I6oHVxqyMKiC6WmfRioccvptkLBmy0HnjKS/zSvtJX+UG9C8Sl0duvkd+COFTLNLWLOVZV1KGGCm4Qdps11Odg5jPb6ty7441ZVRjE4liVpW29upKjrcccgrMphrZUjxM9K1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AREJXfHJoEbwuKan/uy5991hSj7PpaUENUEhjN7PeHI=;
 b=aDaxJdAN8hOPEXUwNMr7u9dIH6tFLWo4OQ2Jz5zfd8onokbVlN/LOe7OL0xHoWMF1ENKI5K0THPYoc18y08Mbwt+biYX9GGEbjucY6BwadhKNPbw10DA/DnSTnVp2PGc0xSpDSNi0KTT7ulIU0jYsTmJLDQ2JiAnBhZLocjdWRwIQEK+jwzmVl4eO0g8iqg0lLPahbXfcam8z+MScq8njh4Och0GQKEd/kCrr2TSW3DE7B7pji4mpClRE8ie65g7Mv8WsWHI9+Vzz3+lgbQzHuiH+tizq/kLPLoHuo7o7kvLcOh/B7QFCItb90zeAkIwzw1U2sNQah16biYOa+cdPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4387.apcprd06.prod.outlook.com (2603:1096:820:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 7 Apr
 2023 19:36:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 19:36:52 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Yangtao Li <frank.li@vivo.com>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND] ecryptfs: make splice write available again
Date:   Sat,  8 Apr 2023 03:36:42 +0800
Message-Id: <20230407193642.39243-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 086ff483-fdb1-47d5-ee1e-08db379f702b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxWGP/rEsz/Lqo5ZeU/zvFVtXiKRw1ACqvb/yZBGilYjsaDfWkCpLE6ZebDkcNx3ARqggWvQ7km0X6kxCNo0eUgMRpz5wc25yIEyu0UqSWvPio+atKXJAS+GCWovEoYO6CAQ/5myF2pFfNEnHI/y8R8xFKDMG5r1pCLjciSlQw1vw7VG7e/Xz5IcfOIH9aONkFE0GcLPx7YzfCDcHkaGVkv+1TrKfqbtISsPvKEUpweH9rKvx7jeIvj1AXVdT73v56GPjWesj88u0ynF5zpZnL5p2YxHyJTNtQ5n6CDFDUV3QNdl1+zEXyTiOmzxtTMceh3MsDqyRam8QjnCKrBUMdtjV2NefIKNVShlWNmB1a8YZ88OIcmfYweW2Qd+EfeO5G5kgDSGGEwNGngshAhp70FdaK+ypZIqsdIujSTPz2BPPvX2jRpBhv/e1o434EkDF3g2v+b+uFZX6yAL5RW5YsHSBYhNqyzT+48hClr+vWBdhDh2aCyFetY7j05F/laVsYnL9cuNHXLbivq6N3oEF2GvEkgH9fqHt7Z3tFYjtyoWdzSy9J351+6vN4rj+wpjiBfGspwDEdUyU5YX1mJa+F2C6gix3yeFpIx7f86bdbPr0pmM2XhLlFFfPU1iU5YE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(52116002)(478600001)(83380400001)(36756003)(38350700002)(38100700002)(86362001)(2616005)(6666004)(6486002)(4744005)(2906002)(316002)(186003)(6512007)(6506007)(1076003)(26005)(4326008)(8676002)(6916009)(8936002)(5660300002)(41300700001)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMFl9MVdZo3ImY22Tl+REgATJRzgUhdeOC1izV8Z0RjAf8UsBKYso1aQNEfK?=
 =?us-ascii?Q?nhpqRiYtpjzDeUwaWbXpCm4ceOmWiw8yQqWE78GY/1BzWF31yUjMVWq1msJf?=
 =?us-ascii?Q?KXbab+eMME2MnCHj8wpJgOPCOGBPe7VgDg/REXlTVt9bwGCS6jUJikbMk7so?=
 =?us-ascii?Q?XhJ1AyWUunj0y39FmJtXi9aq1iSQYkLxjnDqF95c625VhwomL3871JXTGebE?=
 =?us-ascii?Q?Jt5temqRCtkdJ6U6+QyBr9ft7CNS0nBJVptlfF5KO71fjRl3ODbntuTxmfuq?=
 =?us-ascii?Q?fS/MD8P30oEdhvIAe2aPKXp50Mg03wgUq3VCYvo+A9bAjL76UzIqBiGrSoPf?=
 =?us-ascii?Q?y1dS7Xr8UeTNOOe8lOWVy2wQLenL8gbmASiEK6Os9UJSnukqUS4YCopjqmxQ?=
 =?us-ascii?Q?C4Tm4+85HdIhShSK3cMogwsvg+wToBzNOv7VW/uR5y83LtshvlPRMUNikMnV?=
 =?us-ascii?Q?a1duGbRntBooawj/TeutS0Bcjeovp9NRYbkPU24mPYdQ6/VGpDgzBUCouhK5?=
 =?us-ascii?Q?9n64wuQ/mI61HEIdksatt2F+Roc5x0stMbqZdMwds5bH6SLn3wbim5H9hIdw?=
 =?us-ascii?Q?Wu9kaHrFkKLtGjgRyot7YMxEjTMi9BbR5aa3QcB1JIcArZJwbQlxhYwpkcNu?=
 =?us-ascii?Q?5GnCpUXKb+iBkORH/xT0i9Uvz1PJI8XkTSb5aXa1DARiUKZrmOOksvo0sosy?=
 =?us-ascii?Q?GYPi3y7VNCEZjD39l7miKdgwBG8/j2Fb8ZV4GPOI0W+sdKbCAponrLDtKOG4?=
 =?us-ascii?Q?/SxJbhDIm53horg/rr33l0eNFQ5I4UtpJTppI/pDEeJFMMMTdZG0Xq2cytlz?=
 =?us-ascii?Q?LYdPINM1lRp6gQ8q6JQtMuV7gMvhv64OKm009IgMNMDjEuOQkd96ux2Eej87?=
 =?us-ascii?Q?NqvsYoH07PwJcj9vJAyqPnnXoXlnyB+DI0iEIhwDXMDuwOVyvMV/13rxysKO?=
 =?us-ascii?Q?PJh0TqsODCO9d8gXqXV2Svh7mMRQ6O3wP8pbDbl/GtX/YZWjUor5WeuIIMwj?=
 =?us-ascii?Q?NV7X+TI2pmH9sqUbU8t6151kdkVih3/STg60s0ptuKIvpZQ8aK1bZFJSsho8?=
 =?us-ascii?Q?E3ELxkdf+z6woYhEWuVq78RIpmV3oJA8caPlqP5QkfV19MAnLLSvXKgZ/V9Z?=
 =?us-ascii?Q?CoMsCE8hy1Mf7qVFjdmnSDXXzmxfND4OOa4EXgUbSqZWAGvGj/schZaj8kid?=
 =?us-ascii?Q?3Gi+DTDzesiCIIkP9qRc7k0F4N6TX68IsfPkBsRvRqiQT3aL1O3l5xtNIaaG?=
 =?us-ascii?Q?q8aU/aTjYo1TpD4Xb9MhQ2iLa2hgA/hRr51Rajho0Rr4UBed6b2WDDNxvarG?=
 =?us-ascii?Q?6DELXNeU65huNnISPZEh7JAh/VCcAVma6ceTeYdGKLGJJwITF7FtEhPQ7rpg?=
 =?us-ascii?Q?VJUBa28j2sh3L7hNSzSKcgomAd6tzRLUIXgpAZeKKwQM2CLJyE73PPHRbVTT?=
 =?us-ascii?Q?WPRD+7CJoYNUdkMD7YmTzgGELrkAqQjEEWBsvXPYrYachJkt4ubzrUc5ti/A?=
 =?us-ascii?Q?PboiWbRTT7S9mlYMLpFF/VEyId59vIBzFnDF8GZs+NwRjvZ199MO2pb56M6A?=
 =?us-ascii?Q?v8uN6PTs0d7ah+MkqNnwMRrqach83u6W0drA670m?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086ff483-fdb1-47d5-ee1e-08db379f702b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 19:36:52.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo/O8m5IAzbZ+FjAG0doo4mP6bNDuTq2TIR0YW5i9ySc8cKECHkDSymMcAbFETlb+W+vJ3ZEUBheitrqYani8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4387
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 5.10, splice() or sendfile() return EINVAL.  This was
caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
without explicit ops").

This patch initializes the splice_write field in file_operations, like
most file systems do, to restore the functionality.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ecryptfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 268b74499c28..2c9c2af74785 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -415,4 +415,5 @@ const struct file_operations ecryptfs_main_fops = {
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
-- 
2.35.1

