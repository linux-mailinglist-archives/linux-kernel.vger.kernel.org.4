Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07976C0053
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 10:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCSJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCSJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 05:27:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153031A486
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 02:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9/jvvHWV+ZFhCYXu4hi987raatLtO14FMHjoxCUw4/8CuJXTjrRx0JBNCRLBXu99OpCr6Rg4BfOUFIdp/P/qnw8JPWsroD2MW04SacPSyk8DJ3hmxPhV3R0AqbDlT13ngpDo1BG1gBVh/hyf6JX0kp+W5QD0KWDKeo92l0NY8ad30Cdt9Ho5kEw6drIS6uzp0z6aqYlGaC+q3gX1ievW2UuQR8uU2nS4yJ2kM4nj2LTZIWmcknj6q83dRKnOnFQl0i+QeHFwdJHQGpqwbZUcuVi2wgdY5aORhuPWVZtoVBjonuYThCwJuE5Gz6RnI7fY6sbelLR7QMXUbcE9/OAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlI6qokwpgOkaE5Zh3c3JyOWZOSK5DXV2jjrjRhAFQI=;
 b=a2AILjJot1WFeOtchq8AxGOz5zvwuS4hhnbGNu09NrCn1ti/A75+IpbSy8jH5oLW+K02bBcaWy/5lBZnuwhJxfMnW3CIkGxmjmqqFvaUSXkWDjRw02i7W/RdoUOU9um7C47I7zAxg7B7/z/qMLoAakNjOrN8vrRr1aEHeGlFs0gXaSu6I4XqAnjvF5jFi5sdovaHoztb3jTUiUNeQUDJQ6QoqCl+xuMDlTYml6J8BCI/sUiTqDplzXOKhQtd99U9gPHdP2+hye9SQHKCtJiPGXVEjnPtdEWaOR8gJkHLZVTjY1nqrBBhWlpsgjivMrxMTmPbKvO3ThAeSwE8SOWSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlI6qokwpgOkaE5Zh3c3JyOWZOSK5DXV2jjrjRhAFQI=;
 b=pcGMD+J7+EnLqKvjpLCe9VBriPYDCxRrVU/AG7yoXrvX4yVvwYB0nGewTrLn9RoPTgYtsrVQ8hAxokEYHPh8dQ0RbbPqWuBw9X6oLeuIGoJ2aJ8Ms+zXgPRmyXXfry+BGs74qY0U3hG+abASwqpQ+Yh/XpS3ccZY0gjyLcgpklSuuBzLx81tGU+ikkaqSnTy0Fc/jC8IobTjul5YJvh6Y3wSP4IFcP8vFIJngpdVyCtoRqQ65Lsd/oVggi1uKe49kijTCNFklFVq2lbT0KIqsXiCNPBH+vHxcduLSd9Kw/z3t0Fq1t98czDBsmfBQvC1HbM71uPXYRBh/rC3L1kYzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2, RESEND 02/10] f2fs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:26:33 +0800
Message-Id: <20230319092641.41917-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319092641.41917-1-frank.li@vivo.com>
References: <20230319092641.41917-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: f14da4cc-c289-41a1-5026-08db285c1c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uB9fRmvYsqRj9oaKK3NcnAORt6KWq3GZ3bgnT9Fg2/OtxS3UMEiJexXH98QqP7lum+Nndvr5w9txlZQze0wMWepTcSdKTwnxynUrjplNS7EZYW2t8BlaHta0B4XWipQS5HjSf9xNgfP23Wn6Y3YkOarhluZKxNiuJj/O5KuqP9707E3JVPEoIXXGoR2V/cknZbVxmlhAdJ4BktA3x7NKbkrijRMcE5w3tox6CJgd6X5rKu7dkT7vT0SGAST4uM6NHq6lX9ZtjLlaemVJ2O7SAdD3HRWkUei5yh8vUEj/s5LW7G3p/xmstHYH0jmSeqlTP5UbHskioksm44GdXbB2REq00ZlQwaf5boVEaInruGIVQNhrE2FCn/5QKCEhyc4meumf4Pg3CflDTlmK9/VkON40tnjbWzrGvDcKSvrxsq6CMlKzuPdErs7p84RyiXehovWED3xI3Euiu3PT+y7jpV+kXwAAC+YPmK65OtVcxNLLblU6SJpRBYYH5/mKJFeFeXnpJHZZYGna24DRQteN+5A/AG8gRe0rNPzUWPxp98/r9+fVUqng0bsCiidg6KkLScvXtmRq2Yn6m7JobSAQDFmgRHqPcKllSH3Q1GA4rqux8jOAHiBjCOxBDbFQFmxwEpoVB8++x0awq2d7YGt7daDxVX2sVGC+4V7JriWHDh0zXYFWGTgOGIyEZcaK/zR/szscc2x8os1x7K6IXPr3Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(110136005)(1076003)(4326008)(5660300002)(41300700001)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t208Qz5qXeGEwt0y/AFa5PBChgRl1NVKGgO6ncuetiwV8pcfYbGni0rBtAFD?=
 =?us-ascii?Q?1ADC14lED1MkMa1uIhzz5RAVZ7TCAh2aEnKEd1c7ZpQqquWntUyJv8CpNg1L?=
 =?us-ascii?Q?MkZ8fLRvHF19NBpeVG8EWzupdk+XISin0AXo5Kfv+ndiHNu3LlmPevzWEKRy?=
 =?us-ascii?Q?qiQXlNXrHZ75XoAFXDrLIRoOfJZ0RfzfK9U+noOZrhZjDD627uDhOFqXMXNm?=
 =?us-ascii?Q?NUDFaYmwYjf36hHuw6ZfFNE/l2O87EgB2OdDrNl5Dw8TkZj4XaPfGDC+z4bo?=
 =?us-ascii?Q?ygQfAqwCBHVXDSnSodHwvfapa4rG+bbIPAzmqGmEUB7O32CgEZZcK5NC2/n4?=
 =?us-ascii?Q?vpk845MpWkEZGoTl0iSJhPt2cdy+PFuUOP+Dh1Fua7rIlK2nFbe+lLZUJVdC?=
 =?us-ascii?Q?Qk4jTF2NTNnrq9M6ZHEfo4Uj2+BUABpLij+ZgGQtLJJtaLoj6y+0S3cK726M?=
 =?us-ascii?Q?+C2PTcFQp9gZ9z9rIkMNtFt+nnc3sPVl1kE/zAVKacZANWsUGa5MIispBKfc?=
 =?us-ascii?Q?2UJBBGYUSoM/BEbKZDUJxAK3NTvBzUE5f8FgZ9AcGy9IM1g6ngrLC7cqutAU?=
 =?us-ascii?Q?qYwpi7URjb2+/zUmf+tSUTOC4kyR2ayBqRxNmg+IbNZjXqSduajzvT1S3Y0S?=
 =?us-ascii?Q?T91CKlyEfQYVHbP4dva6NYZSPd6KOrV9fn/29PkFYmtye9DlWSrk6/8i7zEe?=
 =?us-ascii?Q?hdsmBGfc2M2MviyIEaroFpxElJRlv9SvD+Iwh7HepDP55ecf9nFngE/WTgJP?=
 =?us-ascii?Q?qoaxvNFv+m5MGBrTV3ljoaaK8SNP6whDOnGGrRbw0eMjEn009hQk1+poKuJo?=
 =?us-ascii?Q?aDmUG+IkAFhAy/76uLusaSbGyUnBYQI/7Tmoxd0hwv9Z0e1ZwPHxPkyftf8d?=
 =?us-ascii?Q?nbvF4Ohl0NrNLiBPW0jy7Q8+sQhk3cOiFW55WYHvLkjItYSXZc8vUcPjvIpX?=
 =?us-ascii?Q?lBzoCPgFhmt1gX0njeq7ZG8CZImTcZuTFSW+ia7HwGPrAxqhj+AdwJbsfpdQ?=
 =?us-ascii?Q?9xnxApvAvqGhq9QcOjCt4OH74lcFAlFzoQK2tupnJaB0r6e2sKoDEQ6ACiaH?=
 =?us-ascii?Q?r+MNfqEDOP8gTZh5NhtRKVbvBaB0at5imSyKvZzO0agkeWIbmSKLuU+ITfc4?=
 =?us-ascii?Q?iMox7XKMzjF7ZGaR/pKuiuzzcxumOHO3bZK75Yedy+M1qYTaKxtKI15KSqaV?=
 =?us-ascii?Q?d8s4jWSJidfHH86q2AZpQmvLDbbTFFmXOZQAwfFBA8nFOIpldokeSCYzZkfn?=
 =?us-ascii?Q?K0uRjKHtW+4R8hnSchN/zXPu6+BpQdhZozAszdjFHH6AS7iGVdGNgOG4nuI0?=
 =?us-ascii?Q?nJkH7PKlPi4MUQgb9kxv4ttPNMvjT4gAMiQjVuuuGWSBg5Jl2mWRHEMYIkCb?=
 =?us-ascii?Q?pXgNG1Lc279x8EliBRmwYUOIddE2VQ8MLfsLl4LmLf+6aQ8QQwxP2ovAFeFW?=
 =?us-ascii?Q?3CbBUwT5wHy952Oev2v6yAt+t79yIp722mCklXgxNHKUpwQHFSs1SJrp7g6/?=
 =?us-ascii?Q?HcOcg6UpmyDyiXIykTahAYGOyM/mXUZvOLlf8eDkMCqYj6pdo5xtrLXg2SDf?=
 =?us-ascii?Q?2UrqdIYFMmOSS1iovXU+LDEJb2grrdagRqPQ/Ud0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14da4cc-c289-41a1-5026-08db285c1c28
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:07.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seFoHrwQjfDxix9aLWz4bOWsPChtzbaLsGxan9tdYNFQtsKJdZzZdgurhEoXvijPgLxnOvBfgHh9Rl5x1im8vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/sysfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9ddc6ee19433..b455afc12cfc 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1478,14 +1478,11 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 
-	kobject_del(&sbi->s_stat_kobj);
-	kobject_put(&sbi->s_stat_kobj);
+	kobject_del_and_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
-	kobject_del(&sbi->s_feature_list_kobj);
-	kobject_put(&sbi->s_feature_list_kobj);
+	kobject_del_and_put(&sbi->s_feature_list_kobj);
 	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
+	kobject_del_and_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
 }
-- 
2.35.1

