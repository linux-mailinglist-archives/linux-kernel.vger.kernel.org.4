Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D407E6DC0AE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjDIQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDIQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:43:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77C30D2
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 09:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkopS462ymRkao+S4wH3EuLL/Rb6svaEMYppvxWyO8dStkKE/y9WOZQJIPYV9IZO1n9khtxQiU/Ty+yyzMx/kLCot9SlV0TEu0A5dfCt2IkHyBP0Ub0+KeHqJML1UQeHoHRaMGoABy3Xc8qHiZC9O6lh+z9PlILQvd2jq88SiyuhcIu2MY0de2jYt9LaPrTq1aJIFHaPVrbs0DfrvB6b6W2upGZsvN4FeLty3QrLPIUYZxCgumqI0zltObI4y1ny5ylkbS21qYUzPOxjx012x7BpR1g1QiCyCTTgLAu5R95/B8+KV9RWaU1c0Hlw7wg+TkaYdo6ilW8e1f3omc+wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BepxkS9KLCD9DVByeFSB1OWpBKf9rHyhLKu30eW2akY=;
 b=fIHXcEO9+5n9KtILB+SOUJn/G/w/UCs5khg1ppfCMg/OtnE3c89bAXLctdcMEnXECOpgmflCMCFypZoEETqJyJLdbNbR6gS/E/CCn07VzAQ4FE7LNTbfoT8ly08i8i1nv0xl8cFcwvXIecgt/axqfVLpzBxfduxmcR1L8klLvkq6OtMtRCUPpsCUX+USmmDajTAKbS4Sr7NP4FRIXfL6ilm6Ef0kT/dgjm+TwaF2PT8kDaKWZzqqIOF8Amy+V/xnF9OJAfaHo3/noNx9cXGzYsErawSeHUmQZJ1f7Ed/zhjvu8uDqwRKtV/8WzTY5CGoFbsMPvw0AAtJ2yN6pxkmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BepxkS9KLCD9DVByeFSB1OWpBKf9rHyhLKu30eW2akY=;
 b=W2XRIb1ZP6ZHxAz7sb7QmFl4luCQcWaORZoBFWp1aiTETy8rSlUVabUv7FLxML49cKc+OfAFuHzHa7abO3kgbJ166mW/8BHsXJdH4gwf9dKr2sX+cIKmGsZ8ey3gQ63ZtD581YLUAXf0212IYwy5j7LJaxz3EAe7yiqhQBOCLWkjosrBUjClV4ONpUjjPoYu5ziqS1t9HpjynQy7oH3Ji1xfEDhkY30BhSYQF0lau2JsPhOxVcNk/8zUgNvlC5vfAF8dWxDHxAOB07ObvSB54e2mzmRDisfpPArvxq/gzIwbMOLIvA6lnAB4VltZDON8iTHNsBNxe9hatvrvv0YA1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Sun, 9 Apr
 2023 16:43:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Sun, 9 Apr 2023
 16:43:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] dm: add helper macro for device mapper target driver boilerplate
Date:   Mon, 10 Apr 2023 00:43:37 +0800
Message-Id: <20230409164339.60919-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9a6bee-380c-4210-c393-08db391998f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGRih5u+qWzQolQC13KfZhUBQs7Nvc4g1unf7YYHJJMa5OH8JKtflwKreCToJkr4g2dXfL/XSAXjCLweG2t4CFFK+vTP2/bEJ+xl/gKqLPFfgNNglX14+PtESRifGCW4Ax45BuDhVtkfzRuGlFC4hTNna10xCcDHB+xmEsRr/HQ+zWETIqhv6lGoKr1lHYUFqYJpBisDcgrwSjQrxPyi/zFEg+M5nTCWYTueSZ+Ct7yrBHGmwaezrUEhiQPxE+4mb0UQ51EmoGcjtf1/sXxu7H2XYPoJSJazu9M22cGhZkmv5kB2AXIgziBmMeJ981aKPpNq+UIvcsoNlQ6+2FovX9kAua8EAjuPhTKgTpYsMXGyoCjgSp+s1hc8gN37ERwIMQgcSxB++S4wynKEkSL+LsYHK2yfCsX1tnXwlNf4o0wZ0PzhSxBGKhRPXvrZfpolQzY2HY3ZwfyjIKCeuvaFHywNCdrr9M4Aelg7pDmjG6zmDazKNnDl8RSOpK8LjQbSlh1QHV0/xKEi5JcvJLOiFmadMCSD5sqnEKOY4WJqZQqItYQjWdjnK3t2pm1/tw/BhnUPzz/opIff3XQFsWAqVPclJWJkpqhFHaiGt5UcHJoezwNwWBYffEojJZdeAERQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39850400004)(136003)(376002)(396003)(451199021)(36756003)(86362001)(30864003)(2906002)(2616005)(6486002)(6666004)(52116002)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(478600001)(66476007)(4326008)(66556008)(66946007)(41300700001)(38350700002)(8936002)(8676002)(38100700002)(316002)(110136005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ga0Nn1dbRPSMQPSmO/2RJdUe16ovNLJts9zlEW4tWEKUFk9f0Kjehc2Fy4Il?=
 =?us-ascii?Q?OYoC73MAV/pVZyJoHNRW/lQmEVXqztOGB1uoDJ1j0cIQgK1Qj8KR5zL8UYPa?=
 =?us-ascii?Q?En359aomfFyxJwcu1rzYGzyxcuen35kt3uscOPglMyyWmsJ3uH5CIU2OKYc5?=
 =?us-ascii?Q?Edq6rxf8264k//31xLb+10wc1am4crVk8BpNbSo5PyFeysvq2RcZwi6IJxwq?=
 =?us-ascii?Q?FEg36gPgMyk6DhB3Ea/YcqBPP/EpnDu6scWULmih1x5b4o7+z1exX7jhHxdK?=
 =?us-ascii?Q?hqL9v9RRlFSjANg9W4eMXosp5ckikSDJSrAFQ7xz4Gy+nix8+ZWa2oB8TDSC?=
 =?us-ascii?Q?H/ToziAjIpvnbcbz3+NdI2GfkAabcYYFnZhwr5FS64SABJYxUdS16aaVHyrA?=
 =?us-ascii?Q?16D9Goo+9Q62EeY1NldXfzbIrUk3VYrO4e/Og1jzZ5GhXWKR9H0ZFbUVT2G8?=
 =?us-ascii?Q?oNQo/L8/MUwhi2Ah9ATunWczQujw++rW93F+y5C1nKu3JYAIUa5cK+XWJLap?=
 =?us-ascii?Q?jptEIBxuxgoZHN9kwY27otJWtCCwnuwIZ+zkfxGf9QAc5l/q4XFffnW8q1o/?=
 =?us-ascii?Q?sJKAhGj+091y3oYAQzdtRN6QtgN9U0Oa9qk1kWO7CcVtnNV7r939gnJ1rZCh?=
 =?us-ascii?Q?ioMDzHeLBePcug/bcoRlBTXlC9PXKRx+zFl3Jvc+MbTRyb8O8cNrwEg14GSD?=
 =?us-ascii?Q?sYSgFm9sMTCIoqsDh379yJzBYvzoNSXh0HQ+4w8HRgiw808A1GddVbD70rB3?=
 =?us-ascii?Q?mXPqWLJibUVgLc1TQFnUNQ2FrlmDXmNfQTfTLnMd5WkBCCne9sKSi0av5WQa?=
 =?us-ascii?Q?djrP9AP+lzZqQa0wqbacAsIRo/o9Vlzw6Mkc597OU6dhUIvnXzND0bRZf++M?=
 =?us-ascii?Q?OTASM0EivHt/9dCe3b1F0K2SCup2AnXOfmSwjPL2w2P5BbKy9xLBhYfGH7+W?=
 =?us-ascii?Q?z1A33u8d+56QVeed2xf8CtoLLtL5nMTxtEkVBHNkyWz6lFVDgxLbdtlRPdWL?=
 =?us-ascii?Q?YmI0oi1M/6YqZTqoP5ATlJZEpdPs9hrbS4cwY783t3+eg4qLH6yLdFSgzpso?=
 =?us-ascii?Q?okxdDgaRuSlgBzYz76J6j491FXxQ4yUQKGAs4oGiLKCG9eqNTL3IvdE2jMus?=
 =?us-ascii?Q?KVWUo3wY2IPR+99eDKmo1Nq/BGlTDBtl1KLEO4U+5cbL5PTbqflV/vFZP3b7?=
 =?us-ascii?Q?bdAb+FIMABnVXjnnnU4whsxHdv5BOmr7tDyyBtmwOwm9ys8QXOGOTSYa6zkQ?=
 =?us-ascii?Q?WTCFrxMqV6xohAvRoPF/qMe/yLupRiMyZY54E4U+638b8fEli7343dbhaOiX?=
 =?us-ascii?Q?Iac+3hZO/SEUhP4MPxm/avCcuAE3S1RBs1skX0TVrM1935TK9rbPi3CQwKB5?=
 =?us-ascii?Q?xtGJ6TrE3sSR+5drpc6vWebqXWju1mnH62mGJVR7p8MbwfIMjKt+kV9WeBnh?=
 =?us-ascii?Q?qJA2R+ytdRbOL8P7V2ACFUZI+uLzp+CxvKxhc7uLMsmqzk9p0fJ4fZFYAht+?=
 =?us-ascii?Q?lCtkZjLTSv3yyrxhAV6z661COXy7UYSqYtqst4Ek7BpWtx5R6eiPOmLhv704?=
 =?us-ascii?Q?NnR6v+DmsSpcbO7OFAgJU9RMfZo5rS/wKM4vz8hp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9a6bee-380c-4210-c393-08db391998f4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 16:43:50.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBdkAGcNo+joB3TsAVEJ1GRwgy7QslVHS+tKexYTsiR47GQCY0a97GqOeSuRjywbU2RrUzLYQ5dHNtveZkicdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For simple modules that contain a single device mapper target driver
without any additional setup code then ends up being a block of duplicated
boilerplate. This patch adds a new macro, module_dm(), which replaces
the module_init()/module_exit() registrations with template functions.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/md/dm-crypt.c         | 14 +-------------
 drivers/md/dm-delay.c         | 15 +--------------
 drivers/md/dm-dust.c          | 14 +-------------
 drivers/md/dm-ebs-target.c    | 14 +-------------
 drivers/md/dm-era-target.c    | 14 +-------------
 drivers/md/dm-flakey.c        | 15 +--------------
 drivers/md/dm-log-writes.c    | 14 +-------------
 drivers/md/dm-raid.c          | 18 +-----------------
 drivers/md/dm-switch.c        | 14 +-------------
 drivers/md/dm-target.c        |  3 +++
 drivers/md/dm-unstripe.c      | 14 +-------------
 drivers/md/dm-verity-target.c | 14 +-------------
 drivers/md/dm-writecache.c    | 14 +-------------
 drivers/md/dm-zero.c          | 14 +-------------
 drivers/md/dm-zoned-target.c  | 16 ++--------------
 include/linux/device-mapper.h | 20 ++++++++++++++++++++
 16 files changed, 38 insertions(+), 189 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 52615a258e13..8b47b913ee83 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3659,19 +3659,7 @@ static struct target_type crypt_target = {
 	.iterate_devices = crypt_iterate_devices,
 	.io_hints = crypt_io_hints,
 };
-
-static int __init dm_crypt_init(void)
-{
-	return dm_register_target(&crypt_target);
-}
-
-static void __exit dm_crypt_exit(void)
-{
-	dm_unregister_target(&crypt_target);
-}
-
-module_init(dm_crypt_init);
-module_exit(dm_crypt_exit);
+module_dm(crypt);
 
 MODULE_AUTHOR("Jana Saout <jana@saout.de>");
 MODULE_DESCRIPTION(DM_NAME " target for transparent encryption / decryption");
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 00d18b2070a5..7433525e5985 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -367,20 +367,7 @@ static struct target_type delay_target = {
 	.status	     = delay_status,
 	.iterate_devices = delay_iterate_devices,
 };
-
-static int __init dm_delay_init(void)
-{
-	return dm_register_target(&delay_target);
-}
-
-static void __exit dm_delay_exit(void)
-{
-	dm_unregister_target(&delay_target);
-}
-
-/* Module hooks */
-module_init(dm_delay_init);
-module_exit(dm_delay_exit);
+module_dm(delay);
 
 MODULE_DESCRIPTION(DM_NAME " delay target");
 MODULE_AUTHOR("Heinz Mauelshagen <mauelshagen@redhat.com>");
diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
index 9bf3cdf548de..12a377e06d02 100644
--- a/drivers/md/dm-dust.c
+++ b/drivers/md/dm-dust.c
@@ -570,19 +570,7 @@ static struct target_type dust_target = {
 	.status = dust_status,
 	.prepare_ioctl = dust_prepare_ioctl,
 };
-
-static int __init dm_dust_init(void)
-{
-	return dm_register_target(&dust_target);
-}
-
-static void __exit dm_dust_exit(void)
-{
-	dm_unregister_target(&dust_target);
-}
-
-module_init(dm_dust_init);
-module_exit(dm_dust_exit);
+module_dm(dust);
 
 MODULE_DESCRIPTION(DM_NAME " dust test target");
 MODULE_AUTHOR("Bryan Gurney <dm-devel@redhat.com>");
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 38da4de3ecbf..435b45201f4d 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -452,19 +452,7 @@ static struct target_type ebs_target = {
 	.prepare_ioctl	 = ebs_prepare_ioctl,
 	.iterate_devices = ebs_iterate_devices,
 };
-
-static int __init dm_ebs_init(void)
-{
-	return dm_register_target(&ebs_target);
-}
-
-static void dm_ebs_exit(void)
-{
-	dm_unregister_target(&ebs_target);
-}
-
-module_init(dm_ebs_init);
-module_exit(dm_ebs_exit);
+module_dm(ebs);
 
 MODULE_AUTHOR("Heinz Mauelshagen <dm-devel@redhat.com>");
 MODULE_DESCRIPTION(DM_NAME " emulated block size target");
diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index 554d234fca18..0d70914217ee 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1753,19 +1753,7 @@ static struct target_type era_target = {
 	.iterate_devices = era_iterate_devices,
 	.io_hints = era_io_hints
 };
-
-static int __init dm_era_init(void)
-{
-	return dm_register_target(&era_target);
-}
-
-static void __exit dm_era_exit(void)
-{
-	dm_unregister_target(&era_target);
-}
-
-module_init(dm_era_init);
-module_exit(dm_era_exit);
+module_dm(era);
 
 MODULE_DESCRIPTION(DM_NAME " era target");
 MODULE_AUTHOR("Joe Thornber <ejt@redhat.com>");
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 14179355e6a1..ebcfb99b186b 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -506,20 +506,7 @@ static struct target_type flakey_target = {
 	.prepare_ioctl = flakey_prepare_ioctl,
 	.iterate_devices = flakey_iterate_devices,
 };
-
-static int __init dm_flakey_init(void)
-{
-	return dm_register_target(&flakey_target);
-}
-
-static void __exit dm_flakey_exit(void)
-{
-	dm_unregister_target(&flakey_target);
-}
-
-/* Module hooks */
-module_init(dm_flakey_init);
-module_exit(dm_flakey_exit);
+module_dm(flakey);
 
 MODULE_DESCRIPTION(DM_NAME " flakey target");
 MODULE_AUTHOR("Joe Thornber <dm-devel@redhat.com>");
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 6d7436d2fd7f..f17a6cf2284e 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -937,19 +937,7 @@ static struct target_type log_writes_target = {
 	.dax_zero_page_range = log_writes_dax_zero_page_range,
 	.dax_recovery_write = log_writes_dax_recovery_write,
 };
-
-static int __init dm_log_writes_init(void)
-{
-	return dm_register_target(&log_writes_target);
-}
-
-static void __exit dm_log_writes_exit(void)
-{
-	dm_unregister_target(&log_writes_target);
-}
-
-module_init(dm_log_writes_init);
-module_exit(dm_log_writes_exit);
+module_dm(log_writes);
 
 MODULE_DESCRIPTION(DM_NAME " log writes target");
 MODULE_AUTHOR("Josef Bacik <jbacik@fb.com>");
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 2dfd51509647..c8821fcb8299 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -4077,23 +4077,7 @@ static struct target_type raid_target = {
 	.preresume = raid_preresume,
 	.resume = raid_resume,
 };
-
-static int __init dm_raid_init(void)
-{
-	DMINFO("Loading target version %u.%u.%u",
-	       raid_target.version[0],
-	       raid_target.version[1],
-	       raid_target.version[2]);
-	return dm_register_target(&raid_target);
-}
-
-static void __exit dm_raid_exit(void)
-{
-	dm_unregister_target(&raid_target);
-}
-
-module_init(dm_raid_init);
-module_exit(dm_raid_exit);
+module_dm(raid);
 
 module_param(devices_handle_discard_safely, bool, 0644);
 MODULE_PARM_DESC(devices_handle_discard_safely,
diff --git a/drivers/md/dm-switch.c b/drivers/md/dm-switch.c
index 5a5976b0cfb8..dfd9fb52a6f3 100644
--- a/drivers/md/dm-switch.c
+++ b/drivers/md/dm-switch.c
@@ -565,19 +565,7 @@ static struct target_type switch_target = {
 	.prepare_ioctl = switch_prepare_ioctl,
 	.iterate_devices = switch_iterate_devices,
 };
-
-static int __init dm_switch_init(void)
-{
-	return dm_register_target(&switch_target);
-}
-
-static void __exit dm_switch_exit(void)
-{
-	dm_unregister_target(&switch_target);
-}
-
-module_init(dm_switch_init);
-module_exit(dm_switch_exit);
+module_dm(switch);
 
 MODULE_DESCRIPTION(DM_NAME " dynamic path switching target");
 MODULE_AUTHOR("Kevin D. O'Kelley <Kevin_OKelley@dell.com>");
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 9e9871361440..a6381cf376c1 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -84,6 +84,9 @@ int dm_register_target(struct target_type *tt)
 {
 	int rv = 0;
 
+	DMINFO("Loading '%s' target version %u.%u.%u",
+		tt->name, tt->version[0], tt->version[1], tt->version[2]);
+
 	down_write(&_lock);
 	if (__find_target_type(tt->name)) {
 		DMERR("%s: cannot find '%s' target",
diff --git a/drivers/md/dm-unstripe.c b/drivers/md/dm-unstripe.c
index e7b7d5983a16..48587c16c445 100644
--- a/drivers/md/dm-unstripe.c
+++ b/drivers/md/dm-unstripe.c
@@ -192,19 +192,7 @@ static struct target_type unstripe_target = {
 	.iterate_devices = unstripe_iterate_devices,
 	.io_hints = unstripe_io_hints,
 };
-
-static int __init dm_unstripe_init(void)
-{
-	return dm_register_target(&unstripe_target);
-}
-
-static void __exit dm_unstripe_exit(void)
-{
-	dm_unregister_target(&unstripe_target);
-}
-
-module_init(dm_unstripe_init);
-module_exit(dm_unstripe_exit);
+module_dm(unstripe);
 
 MODULE_DESCRIPTION(DM_NAME " unstriped target");
 MODULE_ALIAS("dm-unstriped");
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 260f04d12982..e35c16e06d06 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1514,19 +1514,7 @@ static struct target_type verity_target = {
 	.iterate_devices = verity_iterate_devices,
 	.io_hints	= verity_io_hints,
 };
-
-static int __init dm_verity_init(void)
-{
-	return dm_register_target(&verity_target);
-}
-
-static void __exit dm_verity_exit(void)
-{
-	dm_unregister_target(&verity_target);
-}
-
-module_init(dm_verity_init);
-module_exit(dm_verity_exit);
+module_dm(verity);
 
 MODULE_AUTHOR("Mikulas Patocka <mpatocka@redhat.com>");
 MODULE_AUTHOR("Mandeep Baines <msb@chromium.org>");
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 81b60b75a9fa..074cb785eafc 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2773,19 +2773,7 @@ static struct target_type writecache_target = {
 	.iterate_devices	= writecache_iterate_devices,
 	.io_hints		= writecache_io_hints,
 };
-
-static int __init dm_writecache_init(void)
-{
-	return dm_register_target(&writecache_target);
-}
-
-static void __exit dm_writecache_exit(void)
-{
-	dm_unregister_target(&writecache_target);
-}
-
-module_init(dm_writecache_init);
-module_exit(dm_writecache_exit);
+module_dm(writecache);
 
 MODULE_DESCRIPTION(DM_NAME " writecache target");
 MODULE_AUTHOR("Mikulas Patocka <dm-devel@redhat.com>");
diff --git a/drivers/md/dm-zero.c b/drivers/md/dm-zero.c
index 884ac726a743..3b13e6eb1aa4 100644
--- a/drivers/md/dm-zero.c
+++ b/drivers/md/dm-zero.c
@@ -75,19 +75,7 @@ static struct target_type zero_target = {
 	.map    = zero_map,
 	.io_hints = zero_io_hints,
 };
-
-static int __init dm_zero_init(void)
-{
-	return dm_register_target(&zero_target);
-}
-
-static void __exit dm_zero_exit(void)
-{
-	dm_unregister_target(&zero_target);
-}
-
-module_init(dm_zero_init)
-module_exit(dm_zero_exit)
+module_dm(zero);
 
 MODULE_AUTHOR("Jana Saout <jana@saout.de>");
 MODULE_DESCRIPTION(DM_NAME " dummy target returning zeros");
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index ad4764dcd013..ad8e670a2f9b 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -1138,7 +1138,7 @@ static int dmz_message(struct dm_target *ti, unsigned int argc, char **argv,
 	return r;
 }
 
-static struct target_type dmz_type = {
+static struct target_type zoned_target = {
 	.name		 = "zoned",
 	.version	 = {2, 0, 0},
 	.features	 = DM_TARGET_SINGLETON | DM_TARGET_MIXED_ZONED_MODEL,
@@ -1154,19 +1154,7 @@ static struct target_type dmz_type = {
 	.status		 = dmz_status,
 	.message	 = dmz_message,
 };
-
-static int __init dmz_init(void)
-{
-	return dm_register_target(&dmz_type);
-}
-
-static void __exit dmz_exit(void)
-{
-	dm_unregister_target(&dmz_type);
-}
-
-module_init(dmz_init);
-module_exit(dmz_exit);
+module_dm(zoned);
 
 MODULE_DESCRIPTION(DM_NAME " target for zoned block devices");
 MODULE_AUTHOR("Damien Le Moal <damien.lemoal@wdc.com>");
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 8aa6b3ea91fa..9d79ce428b62 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -631,6 +631,26 @@ void dm_destroy_crypto_profile(struct blk_crypto_profile *profile);
 		DMEMIT("target_name=%s,target_version=%u.%u.%u", \
 		       (y)->name, (y)->version[0], (y)->version[1], (y)->version[2])
 
+/**
+ * module_dm() - Helper macro for drivers that don't do anything
+ * special in module init/exit. This eliminates a lot of boilerplate.
+ * Each module may only use this macro once, and calling it replaces
+ * module_init() and module_exit().
+ *
+ * @name: device mapper name
+ */
+#define module_dm(name) \
+static int __init dm_##name##_init(void) \
+{ \
+	return dm_register_target(&(name##_target)); \
+} \
+module_init(dm_##name##_init) \
+static void __exit dm_##name##_exit(void) \
+{ \
+	dm_unregister_target(&(name##_target)); \
+} \
+module_exit(dm_##name##_exit)
+
 /*
  * Definitions of return values from target end_io function.
  */
-- 
2.35.1

