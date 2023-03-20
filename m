Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C446C1E65
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCTRpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCTRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:45:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D2631E02
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEn9/CAzePRXSyaJ6Ypiks36Pa5A0c4GWz1kLY8YevriCt5hVoqE8d1DGNE0xeDZj2dzEZH4TAXSiKbAz7/6QlagV1D2SF1Fiev4ZSlDKHObaD18HAvBD6hWxMM80tA25oA21sqgIZTLJaNYLOaNaUzB/9sStDLM5XKrLPSqzv21PRaM7XPolBUHFqjSdUeMiZqqynRO1a5qYt8DX9GG1kTDbI2JDIIpPyaEfzdKT1eCk5eHZt4ohjYcDO56Vvt01RgHwPxuu5ZdZ0CohIkc+EYQu+oC+/4evoBKQYFlZ/2JVf/kAR7o81UO+GER7VX5AC62NqeJIauAeijuv1ZwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOeeg1ss1SXouh00ZqX1y2eGgKylKHXdLJfGFbRNaL8=;
 b=F42EDuuvvtKi7AKL9QVX85qb+1SVp5A+OcNTAHjuXN8eJr9Hy2SAusPbFnKst6CpQ2ulEBpiS/zqdcWSgyznpjUiPvwqzOjRy7O8TOPV5kDigH6NHr1cqJxkaMnopxZQY0eLewxkY1Vzsm195yV/oiyDIdR+fkcc5cM+nfVvri2d2tm1t1vRP3Pt8PHsZi7A4DGwgi7gUvGNOOsxNjShJ6GvsUfPr2/cMSx2LdPmrAW+3GAxlcsIH6ztyQDCCB8FFZieajaGDRd6q4dS4/Rq4N4+nZBkg9a6g4Y3mp0zB1VM8SAV9gCnk1ffAcFaYqhf62xs+SuDezlqWb+UHeL55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOeeg1ss1SXouh00ZqX1y2eGgKylKHXdLJfGFbRNaL8=;
 b=NUfqbgkqJZ7sUMnxTo0MUsZ83i3oFmtyuVRJ5xor1YYqjisR3tzurrUrMRV//veJiIXj6HQV23fbsEJ8zn6zZt/O63XEoLIGG+K/dgv00AJotG8aZ1saSccEvR7aUTf9lqYQBUq/N4do0IZdQb8rLLkaCde0WIjHD/5MTO/DMJV0POc2lvXBFH9P1ooy/dXlnY7cMob/p3zA6n0ezxTxNmPsUgETaGIaq25TIg9G4Hmvt1CnwXz5xdyHGy0kGEmEsEJlgHFQC6KaBP6bf/taLRtKMun9XXODOYSOoE5g15rSlJ55WGopXa2bK13zHVPg2DyOA1nXPxH63DVDmrIcYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4384.apcprd06.prod.outlook.com (2603:1096:400:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:41:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:41:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jan Kara <jack@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] quota: check for register_sysctl() failure when has CONFIG_SYSCTL
Date:   Tue, 21 Mar 2023 01:40:58 +0800
Message-Id: <20230320174058.72773-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7b8aa2-29d8-4810-2eaf-08db296a4952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2A4E7WbKMGA0kGt2CnCztySJO6sfqVlwtJcu2B9WT0lDYogKV5+MhLKSJztvoN4q9J2b44LHPjvR3z+F8BVNWp6gPFd94CQLmkwtkMfQKWMavY5e3Tb+YppI7AQ1Y4oOKtudWF1hmBBP85iMunjRflwE4fFTfOQr0lhduUtxjlzhkhSwudeWhANzNAG8xK6Hf/ICxtgW94uB5MqPR6sOZB0De66l6X8kg0CGmevPzov/6wPcwtA8MPzOIo83e6YxErAo+0L56Xz7qn5YGTqijkVjwFgjX4KHjI+wjRg1Xbpi96dcokP6muBAHpLe6WAzV5zbIsIoSuHA1w2BZrP0Qq+7v+ZU0oWK/bRGjXBW9oC73cigO7GUYITlM2ajrmYOgiskFBtbbKcvM7x9lf0R+7uXwPYgRJI8+DAj1ujKNuinmldmOOq8YacgWbCojjKaNu1P5iseV1jDZQsg9k5rgSiVU5CiyRUe1jtffoCq+SwDosJlqD561vSONxr3U28Ontow/FophGy1uv2IP0rjBl6PYTtk2ouHP1gTjCrzZvejXqs0xN0zjiMzK/Oi7js4JYNFrLl3ZkA5QjBi1Z4oZIIgEGSqPoHNJxbc8CxAuN6MIeo+9nH3m2Vwo2C6fOy+MNUOcCiu27sg+c2zlHnLsln2g1JtiGkjWYTNgtwc5pNrLfkxo9aeEVD8Y78SlmMC/OXxIZJNIah6eIXaT2pUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199018)(8936002)(41300700001)(5660300002)(86362001)(38350700002)(38100700002)(15650500001)(36756003)(2906002)(4326008)(6486002)(83380400001)(478600001)(6666004)(52116002)(2616005)(186003)(26005)(1076003)(6512007)(6506007)(316002)(8676002)(6916009)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2+eWmj6X0PplaYX6EiHzyQY99UtaiYp7zBdSCziMD1/OXu0zqR/kVzJxW/Q?=
 =?us-ascii?Q?L0+FAltjNyM6/GLnktTENgR1T4mSqQVBRmUO6rzgrfhOQnJXDwT2cjbzudG2?=
 =?us-ascii?Q?RXO8nJIUeWb1Dleqnq6v6RWHYlCg+77/7kdCR0mD4fwl+CLWNiC2fs1td4wN?=
 =?us-ascii?Q?Mw3fMyrWNqFyBmF4gpXJ4OC8Icwn5v/WuRLXJLCRrVFxK3ZsQp1UlrLXjZeS?=
 =?us-ascii?Q?n11TXy6HtNfAmnlz+y333VwHcYex/XEQqn/IOa57qKxeFncCtKQnDPfmwVUF?=
 =?us-ascii?Q?D9m90Ciwko0orLnx0cgZeq5Rifus5TFgWqdM2/Uar5a5szo1Qv0ZRGuMo/tv?=
 =?us-ascii?Q?V3k0DxEWSwO78BWJ4uQBqGjpExyQ5iaoEPKuZ8qT3Ja7YW3el9L5AAp7uIkV?=
 =?us-ascii?Q?R03GP/OMAFhwCJy2/QikIrHuBSjAzDqOWSPfTB8qC7kLUdQbnXuJ65npu6F4?=
 =?us-ascii?Q?aHPBEW7ZjlSXPkE7Gpzj2scJaZnvQRFrHKswmPXKfZMhgsJty59to/77VI8k?=
 =?us-ascii?Q?3Ae4y45OaO1umNBpi82SgekaC+gm21tKd2EtBOgkFvrdi6g9HZfnSpEfZpSG?=
 =?us-ascii?Q?mN7jMFXNIP03tXonsSS7KdZKfstuDnONhpoKf2bt1keVDN3WLgeqUPz+p28W?=
 =?us-ascii?Q?qM89S7GUthaflhB+F+mbQRT4gkxVJr/0kGkaDO1mhQfyYAV5cRlBcbXJXq2h?=
 =?us-ascii?Q?5PMmJZ6BhI8+Mgu6TNa6hSjeUc+8luy7aR2ChHqlirVnzwU6YM8hrHa4lryi?=
 =?us-ascii?Q?DNwYnYGPYNN7KP6FBQ1Vt92T863DzF5VwQKhb3U9C/yt+PIyOOcII4iTgNaL?=
 =?us-ascii?Q?zmRO/2OkzHDb0YBJEUqhOiXHfBm0Byramu1fD9zwJHV5dxhHuqQ4BW1JOR70?=
 =?us-ascii?Q?5untJBwRufYjyscf67t5FEvxfyumocCtAyf7BgZjNvh7YW6tb7A68zQEOSep?=
 =?us-ascii?Q?DqbQl646X9cYUGcRT5a8L4fKf0vmGYUMeki76ozJu1eXBCY3KYv8jcU+DV5o?=
 =?us-ascii?Q?7ziD8/DNylCHApsR00rExlOIOsWp3OVG7vkaoArMG0SoFknqiawrlWhV82WP?=
 =?us-ascii?Q?Vk9LbnrAVw+sr3Sh6Cq6C5wmrviqpsP6MyUekADFDSlCMJxcG+yJOLSGvHoU?=
 =?us-ascii?Q?uT+uh7uYXaK5SRBsHZ8OH2F7XjjZRmocvRToprUATYWiHJC07NwWSU5aUkXp?=
 =?us-ascii?Q?PwQbnBrNfoKZsOuim6UmDMV+oRA88eyWg/BkFA3xuFt+2eBLCdpU/xakRHNx?=
 =?us-ascii?Q?6TTh1eqfR4Hfa2bK5hQxdmIySNDjXNHI1Ef5oQJakW8OxewozzABaRD8Acu/?=
 =?us-ascii?Q?4ieMtm40pB4XQFN2A/eM+1VVzGvAKP6Br1bDxstqqlhE6pITl+JF/y7UWSHK?=
 =?us-ascii?Q?WrDUm/Dv/2u3BUicYiNxabv7sMO8r9dx7/ZcALuHaRFzBEaqGZf+jF1i6zIe?=
 =?us-ascii?Q?0xGT+fbFqcb+wz3XiPbaYQKBtdvg3SFJdnUCEZV9LDOej02TfOIih8Sz0014?=
 =?us-ascii?Q?PeahPCKSld7Jc3xIU+Rkm4dsTu105fqa7ckbyrYh0/0V3HpJ7a2FJSghaVuf?=
 =?us-ascii?Q?Y96VI+QLk12QY/ARyGcwInkaW3OemEG2peh9hw/4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7b8aa2-29d8-4810-2eaf-08db296a4952
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:41:07.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6V9xyYlYHGbuRM8YSa/KQPOMlq7SX11v6+ZK53966zqdQEuqc3O9jkdB28frTGJy2+C6kjlpfoJ1UBXvxEMJ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4384
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print a message that sysctl registration failed if CONFIG_SYSCTL
is enabled, and wrap the fs_dqstats_table array with CONFIG_SYSCTL.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/dquot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 90cb70c82012..a16ddda02612 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2879,6 +2879,7 @@ static int do_proc_dqstats(struct ctl_table *table, int write,
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+#ifdef CONFIG_SYSCTL
 static struct ctl_table fs_dqstats_table[] = {
 	{
 		.procname	= "lookups",
@@ -2947,6 +2948,7 @@ static struct ctl_table fs_dqstats_table[] = {
 #endif
 	{ },
 };
+#endif
 
 static int __init dquot_init(void)
 {
@@ -2955,7 +2957,10 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl("fs/quota", fs_dqstats_table);
+#ifdef CONFIG_SYSCTL
+	if (!register_sysctl("fs/quota", fs_dqstats_table))
+		pr_notice("quota sysctl registration failed!\n");
+#endif
 
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
-- 
2.35.1

