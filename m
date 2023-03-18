Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D796BFA2E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCRNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCRNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:16:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EB03A4D0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVE1i/fL1SWelmSp1I6KIavKPgmCf9CQ/Zt5pqdwpRRw/Nkc/QFMxAlRBk4jxpNLsj3hNgub5S5/xYp1qiJs1VVJhHij5tMRe6fHdbkU45m9ZZzF/+Q7/m7LJD6E59wDLt660DOYzmzrSwZy9/EQW8uv9Lj+jSaBwBudAa2beda5at/lZbsZK0NlvyL0kFpZkSY2jHyqol6eGeR2uZafJ24wyp4py7U3MnpP3RI6pGXn5sd7nvYX0wmvGAgWcMVFX0Jq0tPPmIGa6Bh+xqUMq5e/HgjvrqXnrfshvOBq4Nc/06V17mImOTTqeilglVEh4/VPhOkAYAlK+9AsLMMw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBNbfqe65GISFNaMFiEN7zkpOfadDVbjdb7rHkbAs04=;
 b=WrGzAx9H/fo1ahphbr2pvZ+MWu89YTxxqIqeitY1ysFBWiCawhYydjA68BkgiZVZGn68RX+I0KKLrE4gVcyCvGZxjibAu26Gv70kB6M6+V/ENs5m5oCN59Zcz6Dqsgkik3tgGSuFla53p3jVxlsgoVT0xZ2lE7uuoAdxw90zv7+1Ug50iLTceqyvPz+oeAl/yhCrNwI/ly5Ov/4vqNPd5BVnzqS9886A7vraZmkEh30zD1p+vMs75CbIMBnsmfYa5P169Wicm9+2EXP8OhLl5IAKB1hzuy2e9eWyQoH9H3K1mBjDRWANVv/XuwzWD+VwZhO1sTs5Yv+Odntpquburw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBNbfqe65GISFNaMFiEN7zkpOfadDVbjdb7rHkbAs04=;
 b=PXSUsAxltiYhVspWj/64nWbnuU1ocEbar7SjgBqi+S+LBD8ahWePQay1Ds8icg7amq62Eki8zx+Zyvp6M4Fc7VO48u/yeCdIMkSvdFsK6Ws5dFT0sucWY0owCuBs5m+pSdzSHYDCUi4mSbRBzeVOvBhYR/kWKix1ecWXv7Ep81ehtlITBNOI0FzcWrr8cklLgh0WX16V9ZzhvIvZ+AEnOx0Wc8nuFAP6QEuW63Iqkj7S4M1KdXdINLxwmbnTFGfJ/UwCSer9M2+s3zjSVvGCI4D8cZbZXrm4CfVAwYJkk6J5zZKeyTF46v8f6quYM1AqR4E+7jeQdwnsYmYJHEOuTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5386.apcprd06.prod.outlook.com (2603:1096:4:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30; Sat, 18 Mar
 2023 13:16:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 13:16:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     agk@redhat.com, snitzer@kernel.org
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] dm: Add error information printing for dm_register_target()
Date:   Sat, 18 Mar 2023 21:16:33 +0800
Message-Id: <20230318131633.41573-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4d19cf-3fca-4516-8d19-08db27b304ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAqsaE/pbXhUiWvKLRkT5ZHX67rSQyu+Z9YLm+EiAoZoo8Tk2TpnYif1/ZN2sJh7IhBkGD1kir8ZV2vP067BrGg/I8QdoYuRgx28tNY6AoHgrjoGEgwf/8gEN7NgYM24c2U1lsVsKsP/laupkaeRop8pgqMdGDkZG17BrEioj+2xlYZUwSum3sx7aqvUl2YpeMYSdpXQTBuXPUfNGDvpwsK/q0pcsmhJDZrgs9VT5jok+zpOui8b0PngcjvxbPXC/M/d55W+hNzHIXM7F6afMppgk/bYm6tWDv+PAsD1hl8YRBYY/DR5D+zftHWvkpOvzgyZcXwBGRYIBBpA3Fy1Z4aEXlsVPRAcQY4imPSsC+zWhmhIce4tMmFl/fxVhpOswPU9YAQ9Khykrj3yxE2CwpotvX/b9FRNyCrrLQcomp1eBgLEs2a+8XQHffx9YcXnGDw94sMDSchwb5o1jw3WWtZY5gH4VEa9nIu74HbNa1KbPNIgpeNCqGgbaFo0OjFRgzQXN9DQNrexOjS2wI3Qur8GJ/ZsOJlOz+XTiqkkPkw/j7Oe0dNiJsB7PNTjcpJ3X0UwFUCmZzQnHHIiizYIAW120Yy0LQ/5Rh8yW3SdZkMsBWSTNDsTudHi4GhbgLk7lTiHUbhglIpoKFkX6CZKB5GgrZaadhVErLyOJrZcobqapXapEaaEHSdhgG3sYmRy74NmSryKrk9ccIB1ti2iXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(186003)(2616005)(6486002)(83380400001)(316002)(6666004)(52116002)(107886003)(26005)(6506007)(478600001)(6512007)(1076003)(66476007)(2906002)(38100700002)(36756003)(86362001)(4326008)(38350700002)(5660300002)(30864003)(8676002)(66556008)(8936002)(41300700001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmXI8JfGVVQ6WD4Yc460RRB8hZmg8t8dlo5mF3wZ4sofywUUa0PkJdu+1hxd?=
 =?us-ascii?Q?cQliwa1kzKB+PdHuXoz7BjG+p7/OZXcyy1/UnZz8ALGn/UQD7DANeWzduoT/?=
 =?us-ascii?Q?QbCTWIqdX6ZxwfT6DS59NBiqdu+hcc5prIqNo0206mjOrHvp++heuAzfEYjb?=
 =?us-ascii?Q?QNShA10kVvJ+TrwSrpc3nA+9UxdoGbEMykz8O5JRF8MPeNqEJJ/D009Hswwp?=
 =?us-ascii?Q?Wy/uOIfoFFJBdHTIGBREYZjiNlCaIoryzdGuwn5ZJHWExInX27O5e6nYiTtw?=
 =?us-ascii?Q?IXrYJGvDEGdvk9NNUKFTINtsVjEUlKpYDgufCj+sOg+AU0VlcPmJCcb5MUpj?=
 =?us-ascii?Q?TT/9AP/TzsXExWMQJg4lEBybAO6VUk820CUbhqBpUAVfDVx6WCujQSGUH9xz?=
 =?us-ascii?Q?oTIhH9BtUCy2gNTq39g8uyQjSrKczt5HfBvnldnl/zWcRNWrIlSvpstoNVQR?=
 =?us-ascii?Q?KOElkz2PdYJwNZTbaQ67clIhZd+od08lj1I8C6wsQkkpR9TSnWIqfYIUhRYp?=
 =?us-ascii?Q?+WachwOUyCwVgKxJkfhnG00/iWmbcNmI3dcTzxhu3nQThj3XgFjj/it/izZC?=
 =?us-ascii?Q?WfWQgjS/KW2FshSo/ZsKkcWd1OM/TW8rUM3pkyNYoZHvEcjc16Yg6OAI9n2c?=
 =?us-ascii?Q?TqxN1gwuyxFprZTGGh3cjdSVzMvHESmguvoZsCi1BCkNE8QkbTxAlARBpB0U?=
 =?us-ascii?Q?Cgn+0m9WDvu7yE01AJfu/jtpcozvpCiTYWLy2JjjA6dVqe5AckG5Txr7L4be?=
 =?us-ascii?Q?mbs4tly+y1pIix8IfeDmMIIMA5E2bIcDMU6qKpEi2uqas2lI2rQCY4T6XchD?=
 =?us-ascii?Q?ANHUshrG8UYfF3V2nXPQZelUWhTZK4Z3aI8QpWFzvMqUPVwf+qbomXGYujMv?=
 =?us-ascii?Q?LBl18t6fX0mfXOZpe9BpVWyWCI1V/6AS7VDd27oeNpRzpVbTAPUP66X5kCLc?=
 =?us-ascii?Q?Fgsay8PL+QfXNECSC2u4GkqDljcJH0cFCOw7fkwJVyVV2WcPL22C3070MD6E?=
 =?us-ascii?Q?8ckEtVv6lkfw5A2MJBExW6jZygmozqFfp0YoYhzlCwPQsYq5rZKrC3h/SKg+?=
 =?us-ascii?Q?fVW3qBqRkDUcavfCfKgvR6ucP3DINoNA6HJfUHDygCWbxf+0nbrH69O9bGu7?=
 =?us-ascii?Q?iQLxcQo17NO687WfzOj99aPND+E53XkvQoYp5EBYHR6vx4aqhqePkY/M1wtI?=
 =?us-ascii?Q?xkG9QKCONv4sH05pnrMrdV00ijPJtSNB3ihiiPkbeffrT1nH/+TrqeWtKqFe?=
 =?us-ascii?Q?deoULiAiZfAyIefgs/Zkw/NCo8DD5twacvRaZ8Dblbgxk5Wc2ha0ZhB6nxsA?=
 =?us-ascii?Q?3b6ssLScN8c6qVavn7TEAgg2VJ8DvvIjrLVaCtxg81Li0iKgoLmCKYqOJxsA?=
 =?us-ascii?Q?UDmqDpZKxSpqMI3+eqchdb99tGxYV9bWtjYcQ0VI3fRhBTXJb7C4jbMDuf7H?=
 =?us-ascii?Q?3i4SLs/apnuY3mp08I3ccegpYGLI5UPTVxUUlknQVONHVgCs7Lcq5ygrN1/M?=
 =?us-ascii?Q?begnarTNQIRitqn7xrQPLyIbSD8TncCGXPYVdGNQ80ONEP2TBcqdhUMzZOGG?=
 =?us-ascii?Q?Aersx5K7w/x4p4gMjrIyxfUKhF/W3aGtfrqmmeuk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4d19cf-3fca-4516-8d19-08db27b304ec
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 13:16:44.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3l33nG1w4Jq/pDQ/zewB2WOnR/FGkR9FuBSVphL6NfPvaySsqg6JSg/7gisMZakMwFuJlbZuEC83kLpwf9ZNSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that all error handling branches print error information. In this
way, when this function fails, the upper-layer functions can directly
return an error code without missing debugging information. Otherwise,
the error message will be printed redundantly or missing. BTW, remove
redundant printing information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/md/dm-cache-target.c  |  7 ++-----
 drivers/md/dm-clone-target.c  | 10 +---------
 drivers/md/dm-crypt.c         |  8 +-------
 drivers/md/dm-delay.c         | 13 +------------
 drivers/md/dm-dust.c          |  7 +------
 drivers/md/dm-ebs-target.c    |  7 +------
 drivers/md/dm-era-target.c    | 10 +---------
 drivers/md/dm-flakey.c        |  7 +------
 drivers/md/dm-integrity.c     |  9 +--------
 drivers/md/dm-log-writes.c    |  7 +------
 drivers/md/dm-mpath.c         |  5 +----
 drivers/md/dm-raid1.c         | 16 ++++++----------
 drivers/md/dm-snap.c          | 12 +++---------
 drivers/md/dm-switch.c        |  8 +-------
 drivers/md/dm-target.c        |  7 ++++---
 drivers/md/dm-verity-target.c |  8 +-------
 drivers/md/dm-writecache.c    | 10 +---------
 drivers/md/dm-zero.c          |  7 +------
 18 files changed, 29 insertions(+), 129 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index dbbcfa580078..dba2d85105f5 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3458,13 +3458,10 @@ static int __init dm_cache_init(void)
 		return -ENOMEM;
 
 	r = dm_register_target(&cache_target);
-	if (r) {
-		DMERR("cache target registration failed: %d", r);
+	if (r)
 		kmem_cache_destroy(migration_cache);
-		return r;
-	}
 
-	return 0;
+	return r;
 }
 
 static void __exit dm_cache_exit(void)
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index f38a27604c7a..cb0078a7201c 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -2196,19 +2196,11 @@ static struct target_type clone_target = {
 /* Module functions */
 static int __init dm_clone_init(void)
 {
-	int r;
-
 	_hydration_cache = KMEM_CACHE(dm_clone_region_hydration, 0);
 	if (!_hydration_cache)
 		return -ENOMEM;
 
-	r = dm_register_target(&clone_target);
-	if (r < 0) {
-		DMERR("Failed to register clone target");
-		return r;
-	}
-
-	return 0;
+	return dm_register_target(&clone_target);
 }
 
 static void __exit dm_clone_exit(void)
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 3ba53dc3cc3f..52615a258e13 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3662,13 +3662,7 @@ static struct target_type crypt_target = {
 
 static int __init dm_crypt_init(void)
 {
-	int r;
-
-	r = dm_register_target(&crypt_target);
-	if (r < 0)
-		DMERR("register failed %d", r);
-
-	return r;
+	return dm_register_target(&crypt_target);
 }
 
 static void __exit dm_crypt_exit(void)
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index a425046f88c7..00d18b2070a5 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -370,18 +370,7 @@ static struct target_type delay_target = {
 
 static int __init dm_delay_init(void)
 {
-	int r;
-
-	r = dm_register_target(&delay_target);
-	if (r < 0) {
-		DMERR("register failed %d", r);
-		goto bad_register;
-	}
-
-	return 0;
-
-bad_register:
-	return r;
+	return dm_register_target(&delay_target);
 }
 
 static void __exit dm_delay_exit(void)
diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
index 7ae9936752de..9bf3cdf548de 100644
--- a/drivers/md/dm-dust.c
+++ b/drivers/md/dm-dust.c
@@ -573,12 +573,7 @@ static struct target_type dust_target = {
 
 static int __init dm_dust_init(void)
 {
-	int r = dm_register_target(&dust_target);
-
-	if (r < 0)
-		DMERR("dm_register_target failed %d", r);
-
-	return r;
+	return dm_register_target(&dust_target);
 }
 
 static void __exit dm_dust_exit(void)
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index b1068a68bc46..38da4de3ecbf 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -455,12 +455,7 @@ static struct target_type ebs_target = {
 
 static int __init dm_ebs_init(void)
 {
-	int r = dm_register_target(&ebs_target);
-
-	if (r < 0)
-		DMERR("register failed %d", r);
-
-	return r;
+	return dm_register_target(&ebs_target);
 }
 
 static void dm_ebs_exit(void)
diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index c2e7780cdd2d..554d234fca18 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1756,15 +1756,7 @@ static struct target_type era_target = {
 
 static int __init dm_era_init(void)
 {
-	int r;
-
-	r = dm_register_target(&era_target);
-	if (r) {
-		DMERR("era target registration failed: %d", r);
-		return r;
-	}
-
-	return 0;
+	return dm_register_target(&era_target);
 }
 
 static void __exit dm_era_exit(void)
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 5b7556d2a9d9..14179355e6a1 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -509,12 +509,7 @@ static struct target_type flakey_target = {
 
 static int __init dm_flakey_init(void)
 {
-	int r = dm_register_target(&flakey_target);
-
-	if (r < 0)
-		DMERR("register failed %d", r);
-
-	return r;
+	return dm_register_target(&flakey_target);
 }
 
 static void __exit dm_flakey_exit(void)
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b0d5057fbdd9..b99c3f98412b 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4693,8 +4693,6 @@ static struct target_type integrity_target = {
 
 static int __init dm_integrity_init(void)
 {
-	int r;
-
 	journal_io_cache = kmem_cache_create("integrity_journal_io",
 					     sizeof(struct journal_io), 0, 0, NULL);
 	if (!journal_io_cache) {
@@ -4702,12 +4700,7 @@ static int __init dm_integrity_init(void)
 		return -ENOMEM;
 	}
 
-	r = dm_register_target(&integrity_target);
-
-	if (r < 0)
-		DMERR("register failed %d", r);
-
-	return r;
+	return dm_register_target(&integrity_target);
 }
 
 static void __exit dm_integrity_exit(void)
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index cbd0f81f4a35..0ce9b01d1393 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -940,12 +940,7 @@ static struct target_type log_writes_target = {
 
 static int __init dm_log_writes_init(void)
 {
-	int r = dm_register_target(&log_writes_target);
-
-	if (r < 0)
-		DMERR("register failed %d", r);
-
-	return r;
+	return dm_register_target(&log_writes_target);
 }
 
 static void __exit dm_log_writes_exit(void)
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 61ab1a8d2c9c..bea3cda9938e 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -2235,11 +2235,8 @@ static int __init dm_multipath_init(void)
 	}
 
 	r = dm_register_target(&multipath_target);
-	if (r < 0) {
-		DMERR("request-based register failed %d", r);
-		r = -EINVAL;
+	if (r < 0)
 		goto bad_register_target;
-	}
 
 	return 0;
 
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index bc417a5e5b89..82430b8dedfa 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -1498,22 +1498,18 @@ static struct target_type mirror_target = {
 
 static int __init dm_mirror_init(void)
 {
-	int r = -ENOMEM;
+	int r;
 
 	dm_raid1_wq = alloc_workqueue("dm_raid1_wq", 0, 0);
-	if (!dm_raid1_wq)
-		goto bad_target;
+	if (!dm_raid1_wq) {
+		DMERR("Failed to alloc workqueue");
+		return -ENOMEM;
+	}
 
 	r = dm_register_target(&mirror_target);
-	if (r < 0) {
+	if (r < 0)
 		destroy_workqueue(dm_raid1_wq);
-		goto bad_target;
-	}
-
-	return 0;
 
-bad_target:
-	DMERR("Failed to register mirror target");
 	return r;
 }
 
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index f766c21408f1..9c49f53760d0 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2815,22 +2815,16 @@ static int __init dm_snapshot_init(void)
 	}
 
 	r = dm_register_target(&snapshot_target);
-	if (r < 0) {
-		DMERR("snapshot target register failed %d", r);
+	if (r < 0)
 		goto bad_register_snapshot_target;
-	}
 
 	r = dm_register_target(&origin_target);
-	if (r < 0) {
-		DMERR("Origin target register failed %d", r);
+	if (r < 0)
 		goto bad_register_origin_target;
-	}
 
 	r = dm_register_target(&merge_target);
-	if (r < 0) {
-		DMERR("Merge target register failed %d", r);
+	if (r < 0)
 		goto bad_register_merge_target;
-	}
 
 	return 0;
 
diff --git a/drivers/md/dm-switch.c b/drivers/md/dm-switch.c
index ee2432927e90..5a5976b0cfb8 100644
--- a/drivers/md/dm-switch.c
+++ b/drivers/md/dm-switch.c
@@ -568,13 +568,7 @@ static struct target_type switch_target = {
 
 static int __init dm_switch_init(void)
 {
-	int r;
-
-	r = dm_register_target(&switch_target);
-	if (r < 0)
-		DMERR("dm_register_target() failed %d", r);
-
-	return r;
+	return dm_register_target(&switch_target);
 }
 
 static void __exit dm_switch_exit(void)
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 26ea22b1a0d7..2653a1c5e084 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -85,11 +85,12 @@ int dm_register_target(struct target_type *tt)
 	int rv = 0;
 
 	down_write(&_lock);
-	if (__find_target_type(tt->name))
+	if (__find_target_type(tt->name)) {
 		rv = -EEXIST;
-	else
+		DMERR("can't find dm-%s target type", tt->name);
+	} else {
 		list_add(&tt->list, &_targets);
-
+	}
 	up_write(&_lock);
 	return rv;
 }
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index ade83ef3b439..1eed2a9b4e8e 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1501,13 +1501,7 @@ static struct target_type verity_target = {
 
 static int __init dm_verity_init(void)
 {
-	int r;
-
-	r = dm_register_target(&verity_target);
-	if (r < 0)
-		DMERR("register failed %d", r);
-
-	return r;
+	return dm_register_target(&verity_target);
 }
 
 static void __exit dm_verity_exit(void)
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 3aa5874f0aef..81b60b75a9fa 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2776,15 +2776,7 @@ static struct target_type writecache_target = {
 
 static int __init dm_writecache_init(void)
 {
-	int r;
-
-	r = dm_register_target(&writecache_target);
-	if (r < 0) {
-		DMERR("register failed %d", r);
-		return r;
-	}
-
-	return 0;
+	return dm_register_target(&writecache_target);
 }
 
 static void __exit dm_writecache_exit(void)
diff --git a/drivers/md/dm-zero.c b/drivers/md/dm-zero.c
index 2601cd520384..4d96a9d50894 100644
--- a/drivers/md/dm-zero.c
+++ b/drivers/md/dm-zero.c
@@ -68,12 +68,7 @@ static struct target_type zero_target = {
 
 static int __init dm_zero_init(void)
 {
-	int r = dm_register_target(&zero_target);
-
-	if (r < 0)
-		DMERR("register failed %d", r);
-
-	return r;
+	return dm_register_target(&zero_target);
 }
 
 static void __exit dm_zero_exit(void)
-- 
2.35.1

