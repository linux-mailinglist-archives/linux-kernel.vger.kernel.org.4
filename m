Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E988F6BFB66
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCRQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:06:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1F27D60
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 09:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M69TGiZzzlDlcGBdNMHy8dQga4j6Rdev/j4oXWjOeTgljWlowBbsqTfcmvO15P/+LAIN1NHwoXaTlEQaPNvMtfZJdLmjiZYLdJgueWyYanMAGrgxKEIEKiw95nSIyGUVQ0yifT9I1kOnZtUE1JNhbIVaofRJ94jJCm9dxRL0d2dUUqK/YAE86Ry5EPZzvdBruEimCh810yCXOiO1I9fxl57Omc+D5SklKJM04r3h1JQqqjd2aFo1hhLkFWSW0tCglOsdN9Zt0cVtuW4d+HbzN/nVy/5+6weaMDU6PKtIX6Q9PPJbH/SCmUDelYeRKbnWof3szisieCh8rlUE8TEyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpPEc7jyJUnpDsH73rivdFQQ5JC8qvnyUjuKo0BP/0w=;
 b=N35oZO6gRdpFoUpfBzs2GQZKmNONj1gS8JwsWXUfWwu9fX58wcSsFQhfl0OZLI+8FUx06q3MhLCXvxZEeuY0HBWbNiuTw3kt+t0Ul9OK+Nj8uH4XQVgb35BpcVAm7Up6KJzbhbt5Lt7wabTPE7wuL4/RIrGedPsNHzvjeRtu7SRQL0044RGQ+fITQ6/LDjHslr5li3J1+BU8c9hfz4cb7ctn9xumt9/pOQDdpz7HzezxBkmiznh27gGqcC6shGa1eh5Ps7kEqkq4Is4fXDKfqeIjdyU9m4iZzF4eOWV9OuWYIzKfACu/kF4cRs3yZa/zNcUVIPqSnH62RfeZGVDuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpPEc7jyJUnpDsH73rivdFQQ5JC8qvnyUjuKo0BP/0w=;
 b=dady5JMixp9/PLI1FVGcREEyKffSKFANbpe4JTU0PMuFsSGDyKqETrCjCUJvDRsvhZJtlEGjEi0rB5Ks1IhK2fJHfkhN5bUBu7jwSdDC82M+F/QvCFnuWeeuJsgOsg7SvzqOizejLc7Tw2pXaEBP0v+sJxK50MIP/k7XAKrsNk2RJOkgcEpjglAh8f8TH0UrzULI5z4jyzWeURCAYS2MO4BRxYb2muFFshv2kts79RdobEz3J4dopCbg3Ov72IXhmsJDL9B0/2Lb4+C1wkkK4pI2ryQ247JmiMm/akdIHfMdaHgrZRE+VYixe8uDnHCnV7borngzejWjFpJbPIpanw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5664.apcprd06.prod.outlook.com (2603:1096:400:284::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 16:06:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 16:06:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jan Kara <jack@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] quota: check for register_sysctl() failure
Date:   Sun, 19 Mar 2023 00:06:39 +0800
Message-Id: <20230318160640.48461-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aaeaa9-ee94-47a8-d2ed-08db27cac8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVFyMtzgR1viObGASiR51bpV4YMmJq/WOXcUVEYhEX0zPp+mbFqKB2Uch065JqnG64OC6x9tugvZLnu6/bVsfDBIQSEYt7WDGnxk0dK/kQcxE6K0gugYh87qBOnxgP71n8pJoQgdVVlCeEfEczDyF3Wr4UUUSspOEwFmtwGVpsYqU3Gv2MzE07Hz6Bu+epAEoZwvEmHOcZpc+Ku0LsoktqUKEyLoJKJHM5TlXfxbxd2BXbhg9Mqu2Xwkh4cF52TVxydfuMFxohrs41PHhwSHxpZo2Nw3/SREd9rb90hshHktY/NrRrusyTsP4pGM9+l93usz0qoL13T1BXC0deoUwmnSNd4n5t7jf1J/Vd+C3pekAYnX27Eri7WaGiKednBnuYWjN6nBCehWf5qxNGUhWZelhEmSffd93jlKlwPTsOEnti9k2leElnju1ElwE4n+TH+6OfolAUqcFamCHgSDFw5AOLMqbd01iihxt0YfuNPXGPqVcpgRjI9eedeQhpA3v/soaWYgj65KSfOK5m/CPXpAlHBONS9NTvkPAHBICrbqWH6hfxQvmwGaQNyhzDolsG8z19jB1ppdL6fvDG+WpLkjZCof08YpxBlW4GhwlAOYop5GnYXSzS0AY1qGbf2L+Hi1IK2QWxWcWRdUXfCjnh5PFSa+p0dfve236gybMnVi67E68a85krfYEJlImj4aIhWiI6UXGOr8aFVGOfB+HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(451199018)(38100700002)(38350700002)(186003)(6486002)(52116002)(36756003)(15650500001)(83380400001)(478600001)(2616005)(1076003)(6512007)(6506007)(26005)(6666004)(41300700001)(2906002)(86362001)(5660300002)(66556008)(8676002)(66946007)(4326008)(6916009)(66476007)(4744005)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k80npLpgjH3NKsJheAk9MCXL2TfKQJTZBVjRKq0bmsZT10oFc3ZthV2IB63a?=
 =?us-ascii?Q?tdJbvxaOetqZjFe8eUby1zypxVzeIrzMTPC2gdDebWOb1JcvQFiweefc3WLQ?=
 =?us-ascii?Q?KDP4RdBGjZkPe11rikibDSAsC+bAHZ918CpNpr/plwE1pr1b/Fxs5j2zljBd?=
 =?us-ascii?Q?BMX2UTULOuj6AmVipuGLEKLYprFjnfYHjKBTijeTBj9RO7fpM/Ilh0SZKQdM?=
 =?us-ascii?Q?gnm53mu63vxnlWE9jstr++2YX05cCnw/TfUPl+rbg3OTxMX1D6ui/sCk2Izu?=
 =?us-ascii?Q?ydBRcpG4G2+03eDlF111uhCPNe0LFRs9R6LB8dgPZ54bEtnF39iE1oz14Cp4?=
 =?us-ascii?Q?USiWxwWD0/q1aY4gTvp6fevuBY+dfhT62X8TH4AQt/x97hfx6Q2YLpBlQ2de?=
 =?us-ascii?Q?LXY8AClxZ5L9HAp+bPyk22WAM8gJ73s9PaxnkiXVJ7bcxHGV10kT246oPRbO?=
 =?us-ascii?Q?1CNiZgkPU8aKNsMtAl19KWFjIplfee3F/MMNMXQeEm1evlywFJY97YJKXU+Q?=
 =?us-ascii?Q?d/INYxWYicrviiR9PyTlIROWFQoO8Btygz151t4qnRwNaT8t+uHWCw7sRjy1?=
 =?us-ascii?Q?ygfETQiTHZ7c8qS5kLZ7dX4SdxqcNAq8g3fDWP75Iiac0fvULbGG7ferYHc5?=
 =?us-ascii?Q?otOTmUkVpsir1Icc5rZJzO2+6P1enKRWD1iDCsftW9z1f4IXJbeDjwzhCJ/I?=
 =?us-ascii?Q?/YXixyqit/kCBbvtnB4xkEbocJF+ym/hbX0PUXGezhgp+kxHen3dJzFi7BfK?=
 =?us-ascii?Q?XqcByTGN4ljugGjvO9LgSLjRDr7oX5AKAVjA9OoqemmcKhSbreZElNN7iIS+?=
 =?us-ascii?Q?Mf8kMnmMeTEeanoBYKjM3eQ6mtCOmHMUw7qYQnXnWXRZbKKQIf56vh02qEAL?=
 =?us-ascii?Q?apSrhVvXwMUljsAX4tfdglxynLn+94RWRlbECARKLogf50v0u4xE1ov4OSp+?=
 =?us-ascii?Q?RVYJeRLmqR/TP7GYOS8Z558hdCA9mFEeYjTd0n2wyNcI13TQnnavqc61Z9ly?=
 =?us-ascii?Q?XV+HyGPvHKms5joOzbdihpZKLfP3LmALVteTF0LWqmD3DtZSYNAtEXViCSoW?=
 =?us-ascii?Q?h1DkNcazjEGlCEWOcShin700uDy3Tayta3p77w3iwI0Dk3tB4ZXG2OuEV05C?=
 =?us-ascii?Q?xNr8XW4lP4vUyy3yoRyhIguZlFBGOaHgds0Fld5St+59f9gd+D4H5PEfB+Wk?=
 =?us-ascii?Q?NoqSV69ziI4ZeAaFt3e5q8QGUiJLWyeQB484kP7tLV+GdenOG5wUxNmg+vk9?=
 =?us-ascii?Q?RvPwuvlI7D3F+IqiK/egJBfJFyHiZNM9oyNvYXPy2+gWTka7vdx7gSCjVSgv?=
 =?us-ascii?Q?JQxO0TtIhlluelv6hn6IJlZ5ePs8VwBzOL2vcsyofIWbsm9l8T6VNRpSxSb8?=
 =?us-ascii?Q?1/c66BEapD56/xt/7mfOC3xnW5tpJnN0hO5v+9yIBDWE1fh2tjn7cdbcB0eI?=
 =?us-ascii?Q?y7KAScLH1YoJ6o3VzUy/7IocrrajyIHXjQj2dQgfyMLxOyX3h8IgUOqPo7UQ?=
 =?us-ascii?Q?Gms+rjIi+x1kNrHLWmeHsu5eI4OTW/frgyeNRAwAtLXjbID0eHzmokpx/5N/?=
 =?us-ascii?Q?B70gN0pp5iMsTU4+S5pudVedgQbRQX7kHB1yLX2l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aaeaa9-ee94-47a8-d2ed-08db27cac8c0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 16:06:51.0514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yc43yZaTmhAGuyu/b0WI35RlzeZDfBI0X7VmsOh1mSt/Tm7AICo15B/bP386ejp/oxupsVo6LZojV+Hax0Iq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

register_sysctl() might fail, call panic() as with other failure
checks in this function if register_sysctl() failed.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/dquot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 90cb70c82012..1483af271368 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2955,7 +2955,8 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl("fs/quota", fs_dqstats_table);
+	if (!register_sysctl("fs/quota", fs_dqstats_table))
+		panic("Cannot register dquot sysctl");
 
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
-- 
2.35.1

