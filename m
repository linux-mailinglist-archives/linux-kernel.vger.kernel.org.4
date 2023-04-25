Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A276EE53A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjDYQGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjDYQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:06:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275101BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIrsFHLezJU1yQ1Y/811YWijE7t8dkG3NdZNdHGCKsyPIX5z0jwqKZfzh2gGI6mn3qPRqdiButAWc0q/1/gMj4gcaC7s//hU6x55AKvj0UBJ8lL1lssVfV3P+dRL2SenOMSVQA08x62iOElSS8N8J84Ljxg0lJRKrQOHyirvlTS36NLd5Y/0gmBZXpuhgGxW4dvA1KlAg9NXehxxo9e5GIJtWIy8+EBCY6+b5GuFRI7fA60JUElR8xSegYCDSiWkSDlLiocE0V+7CJBXkCPXHzqPMnHT/dE5gnOKJUYbVYiPKuhx/4EpjaC51U40x8P+hvmyKHCYtDkjsBdFWrqsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXroYt61aQky65Pi8sxOVmca6w9Jd5lF8uIngz7u1Ek=;
 b=Uia83U8lLnMC+GqdgdCvoZRytOV8Ip6HClQYq20gSt88cegDA4bG48I60XzJ7DYeIacPzelWbi943lXFFk5MWwTXnJVdsMnzFX0kXk8vuL8PHKorffjDFss1D/KuLqiKxP4wUtHb3BZruKal4m3lHXm43fTPkSfBL7i8VhhFccYb0NN3FdMsYozTK9EUCr+XyMrUqcGVgo9iAtgLFfWvw7bxCmivXf40ijftYhRUybqXSaxy74u7gSJ9MDR+GYZhhvo837GQjDVxlHTsu6iff6NGpV3duoMWg4SNyzjm9auOGhiLdrB6/E8a4drOK4KAGXpJ+N6Gf2Ew6VzsZXURFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXroYt61aQky65Pi8sxOVmca6w9Jd5lF8uIngz7u1Ek=;
 b=Wn8rKdSDi6NdxopMXWO5vJKlPL3iAxC6tR4Tz11ysVeFUwGjXgi0pUKw+jg+Jz0xzbkmJGDGu8tbsF7bhKBlUWl18ygwQ/pQYtk80+UdB2htpfcouKgxNApgxlgk/LLwfF+JVmyDY3LI2W0axBhUsJbUDBntjMzmgRJvXIrVVPMRwzdkBmdHF6Z9qEIUipPa88SqaMqn3UCuySok9JgXtB4RODwKiYUDn0cU9JBmnqyg9uviivZS65n4J+lbyrQpi3+eL+EjATrgm9jhvrAUirenSJ+962tSO76NVvC1i9MoXblKBb7ZuCdHON5+qFqUDPpkPOC0wqDKIB589U2/ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4078.apcprd06.prod.outlook.com (2603:1096:400:4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 16:06:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 16:06:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: add sanity check for proc_mkdir
Date:   Wed, 26 Apr 2023 00:06:11 +0800
Message-Id: <20230425160611.79848-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a40f99-8fea-4629-4f9c-08db45a703ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLWW+/FRF9Vh+daU16/nI9m4u/95k81Nt9OkrMW6pb3lv8xdWVqBOaHtfBl1yjX9ZPPPkddiDiWcYUi5vXX1RRCuzwMQ9gwJCwkWVR6A86FEj3rwzZIlUf6LSR66iMRxN3W/z1fwiC2n+0+HD1rLrcS4F9Lj+NhiEpkCcItNqfhyfCVr5zeS8rdXP/DhnIEyfSak1I0cA2vkUWVheg/agYIc48BZPpSNKgfZmqYIsEPAUZnj8DoZfmLAxTDknN3u4y+hezw2ZxaZ7RV1UAjJ5uxck9QHXYfCYGaLyXA9TMZlcADjVGWMMRgT3+1urL8dRK9jjh+JZBbzDjnPK+/WlgithLkjjFD/l9I1J/V79FytVH1LWcdV+iu+ou5aGkditzWQ3Nl4Fr2rZyuX+pYvAi/asvMES7jTjaw4TCUKayxn2IPvazbw9w8pTjR8///NEbHiN3/34q8uTw1GOT9AqKnp/ZPQ6fSe77BL/JolX0NxmTXpVqv+mdzjnpC3XUNUDAc+MGDz/Z64v05c3qY8oAKhZHKhBDBee5B2DBn0+krl89wtRWg6wmhqsX1uADSWnhyUNpS2vJc6U4/+YmTagmKULyMiRq/blwHFor+l1Zp7lSRZ8Zmm8n400W1HZI0I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(38350700002)(38100700002)(6506007)(6512007)(26005)(1076003)(186003)(2616005)(83380400001)(8936002)(2906002)(8676002)(5660300002)(36756003)(478600001)(6486002)(52116002)(110136005)(316002)(6666004)(4326008)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oBBaH1pM6PR2c6pRUI9lj8iWh+lXhKe1w8xR3sPlzkylGmRH3ArOE0ioFdHy?=
 =?us-ascii?Q?rCIi/uHBb4rdxPiK4fZ1zlImITZTT0KYpnB+sEVuESH0IcjEu9CNw69aiGEO?=
 =?us-ascii?Q?+bG77ggOT6tGqb1AQ6sT1PgGacWKgv6I+5C0Ip+bqK9M7Tf2LFseXkkVKmzq?=
 =?us-ascii?Q?jIj6sv71hVYkda0udI4BTRrYcLxQimaex5ah9xcRgO2Ce9PCSnvWcmOrjWEe?=
 =?us-ascii?Q?10qYKsxi8Vp/KDKExnUUVJNEBCp58sZShomPu9CQDA0CsxFxzdTe1pW2lQns?=
 =?us-ascii?Q?OFYPUqn30auIaee0AQb55W8mkE6RxIQM9pXK8s4Q4pFkeUK/0K6tHBymo4qp?=
 =?us-ascii?Q?GJXKfdwf7gpbd6vRy3N9f4yGKsEeJbxATSoP/E8MQWoKVtpA3/fTMS2X6Xbw?=
 =?us-ascii?Q?ifH7V7sXVqlkRdtbkfPIJVQ69Do5DqXii27C+Buw1PMq8jMtzumfV6R09qmG?=
 =?us-ascii?Q?ySuCm419sipxzxLC/CX5eJo8CxaoXY92hb8LIFwEQxMu/mwtTtVB8G3YnwA4?=
 =?us-ascii?Q?hQU+nbOJdYGtnOYifFuxlcI8ZBupW+am9sxDNheS94Qx/CTd9BS1/vLTEXOu?=
 =?us-ascii?Q?K2HfeOuVU91LMUNWglQuWtdWiUntuonrkwdSv+XcogyB0hfg8FQEphuOpehP?=
 =?us-ascii?Q?pyFaQuIGMVI3TtQUtxUB60zIRhPYb53SOb/1VProyGBbu1fioPedElIsE+/p?=
 =?us-ascii?Q?N7ZBThy8WmOt38NP0btU242ozH7YsfKCK8NuU/ds5K60SdL2/w7a7HtSsDoY?=
 =?us-ascii?Q?mWPwXnHie40994uHLeuZzUWhRS26j+x3jSq/Lv58eTI0giyJqwizPmwF9BTp?=
 =?us-ascii?Q?RjQXQWRAwXoPTb403/hF6iBPMr4fHI5VGUnPavVW1D8RIZ8Tkpjc43w02f/9?=
 =?us-ascii?Q?U99gjiGpTM7pqjWKbIl20t4TSkFiVCpDGhdYnp5BNgeXqeyr0SNnNQz7kYQ0?=
 =?us-ascii?Q?+Wvng3PiaRj2pWZ6dYt2mkIWRz0oT+dit6X4BHsv720wjIrFpBaJstoDoR00?=
 =?us-ascii?Q?rQEijloQUqMi1Aw0w+Pu7G04E/VmLmDlqhr+FdD4mOkc1wlkk29vS0QrVzyU?=
 =?us-ascii?Q?65YK3KOOzOhI5S2EpUjKX3ykP2EvF/0zcBycNksWzJdmsAL3gtAILCtfMPBs?=
 =?us-ascii?Q?DkVRt6NiHT0S1HtgN+74VUixIYUWZhkzhp2HF4TOpl9Alc8oKOrAN0LJB7Tg?=
 =?us-ascii?Q?1B1fdwr3ff7R85u3AeRR1gSENFZuzWkFCtNU+h5E+8qIN4heIJWcjMWc/DZf?=
 =?us-ascii?Q?a3V8CAoIJdm4OJ60gNiewVrQ91BtPgX6EtyYTeIG5RHS3QOz20BnqB3geKlP?=
 =?us-ascii?Q?l5sRbrCxJxrG1fCksvENXVpwsgrvFL44a9CscmEI7iaajI8YkD4aAmOFGe4z?=
 =?us-ascii?Q?hW4f2agv3sopwXyR3jkYg2626JvBhFeEmED046AcAo3rImFVZoI6PcvqK4vi?=
 =?us-ascii?Q?2f8r05ai4q41RxJiHGIAEfCdpK3iLeEZhyOcLo4kWnXLleYfSA6RsP8NduQ8?=
 =?us-ascii?Q?JEc99CsDeDk/b1DkSR7hsbjmn9Bgr8Z3ngnYXxjwoOEPHOvmI83j1XjUpmVh?=
 =?us-ascii?Q?N3rlBjXZ8NRSE22mP872Pmu3Nee4PryrhY7qkMx0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a40f99-8fea-4629-4f9c-08db45a703ee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:06:23.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jWMQsOBQbF/jelfeG2TmtF9roo0hNGqo+2MbZxuNsyT2yeaD32ycJ2jvT4XmwzPauISC85ixfGGmzyOkFX71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -ENOMEM when proc_mkdir failed.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-removing check for proc in f2fs_unregister_sysfs and f2fs_register_sysfs
 fs/f2fs/sysfs.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 8ea05340bad9..467d743c801f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1386,12 +1386,19 @@ int __init f2fs_init_sysfs(void)
 
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
-	if (ret) {
-		kobject_put(&f2fs_feat);
-		kset_unregister(&f2fs_kset);
-	} else {
-		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
+	if (ret)
+		goto put_kobject;
+
+	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
+	if (!f2fs_proc_root) {
+		ret = -ENOMEM;
+		goto put_kobject;
 	}
+
+	return 0;
+put_kobject:
+	kobject_put(&f2fs_feat);
+	kset_unregister(&f2fs_kset);
 	return ret;
 }
 
@@ -1430,23 +1437,24 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 	if (err)
 		goto put_feature_list_kobj;
 
-	if (f2fs_proc_root)
-		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
+	sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
+	if (!sbi->s_proc) {
+		err = -ENOMEM;
+		goto put_feature_list_kobj;
+	}
 
-	if (sbi->s_proc) {
-		proc_create_single_data("segment_info", 0444, sbi->s_proc,
+	proc_create_single_data("segment_info", 0444, sbi->s_proc,
 				segment_info_seq_show, sb);
-		proc_create_single_data("segment_bits", 0444, sbi->s_proc,
+	proc_create_single_data("segment_bits", 0444, sbi->s_proc,
 				segment_bits_seq_show, sb);
 #ifdef CONFIG_F2FS_IOSTAT
-		proc_create_single_data("iostat_info", 0444, sbi->s_proc,
+	proc_create_single_data("iostat_info", 0444, sbi->s_proc,
 				iostat_info_seq_show, sb);
 #endif
-		proc_create_single_data("victim_bits", 0444, sbi->s_proc,
+	proc_create_single_data("victim_bits", 0444, sbi->s_proc,
 				victim_bits_seq_show, sb);
-		proc_create_single_data("discard_plist_info", 0444, sbi->s_proc,
+	proc_create_single_data("discard_plist_info", 0444, sbi->s_proc,
 				discard_plist_seq_show, sb);
-	}
 	return 0;
 put_feature_list_kobj:
 	kobject_put(&sbi->s_feature_list_kobj);
@@ -1462,8 +1470,7 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 
 void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 {
-	if (sbi->s_proc)
-		remove_proc_subtree(sbi->sb->s_id, f2fs_proc_root);
+	remove_proc_subtree(sbi->sb->s_id, f2fs_proc_root);
 
 	kobject_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
-- 
2.39.0

