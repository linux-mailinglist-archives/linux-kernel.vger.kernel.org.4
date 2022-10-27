Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398FE60F4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiJ0KZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiJ0KZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:25:14 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D3357C6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbfKlDXvZ23YUQP4XEnk52ePxIQrHTCYmplz0oMI6fkx5Bxzxja7RvVsj0ELbAzsLg7TmiBM1qOYXVzE3f6vSJ0uug+NVSQMCt59PL9hJQ//sWfvlIluCqJA+4ea1/8PT0eSOsLEESW1Jb7dF4GgYARyAeeN28kij/XsVgW1h7jnRbdOZAB4ofd7ONZBes+DcCiwOV7Jh/eFEHj26h8i9QRZCNub0rmzaBt9BJqviZHrtku2+CaHMBWPKKYl8QRr1cTZ2hkU1Al2D/v6E3Oq7UDZAhHBNXdBdzFeXowbquj9VZ5o7SvhvVs75vPH1y4v5CPaCjzlwGPbfQVgsGRnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skSA7H6VRgAiz059YN9/VM/V3hCNY+z0ypuYCT9/0E8=;
 b=lO4LxlKjus0Ab4WulkEyvAJhLupXtYve6EfDso/gjJWkczi9Tloo5a+EW8ntTab3h6cf1tILTPN+ZNxnF7dThNu42B6xouEg5pDNRx4zuC6QxJrYMKM7mv+YqLlnM+j/EbF/eSyO66ppjBLueC6R478NxeHqPd19ry5KWd1lNOZDiX9N1KXA0pHMrEQhY1PpBYAuENDJr+i9KqzYA2ijORuw4O7T10I7h5y39bSzJurBc7/1MCL9OXzdgGHThuuYNP0j2q4HemErlzLPRNChiLOY9xkd7VrUO933fa99Sjw120kU4WWexpEcv1KuoR5RCpMsc0T39HMF+033Ct8z+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skSA7H6VRgAiz059YN9/VM/V3hCNY+z0ypuYCT9/0E8=;
 b=X392nSv9sbXX9RWmn7ZJMV4KGj/3PZlPOqyRqt70utP7T0I8zKPEMQc4ILoR5R038JZ++KTXt1HA7m0urUX6E/x35BFwDeqMrSXoO+ZFtn1Uy8A+p3L42GS2sfU+szQXPR0mCa9dQVVWzGaWRyVcbzm+mRr+0yNqiwUKOfv1zxrH/9ZeizngfgdYutiC/4KvyvaSxHG9voMUI6dGLR7HQvaMZgUJEwWtUKjf/L1gjtd79YN86dPjLnY0mN+jzUgQyMB9G/BjlSyC6ZRn+9e3q3iJBjTsGG7CQCl8zR+h3Rq3vCqeOMFHRqi9X8zhmHtiPKNsbM2NT2H6tgn5UBygLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5366.apcprd06.prod.outlook.com (2603:1096:101:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 10:25:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Thu, 27 Oct 2022
 10:25:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/2] f2fs: fix return val in f2fs_start_ckpt_thread()
Date:   Thu, 27 Oct 2022 18:24:47 +0800
Message-Id: <20221027102447.75708-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221027102447.75708-1-frank.li@vivo.com>
References: <20221027102447.75708-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: 59de766e-5f9d-491d-db7f-08dab8058382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmb4roGQzKbk5HxqmQ/KZXD72H4JA3698q5vGD4ayYweosb3fFGQ1UZSp0t+09e8reoKT0DNNQm/o+scolE7qmA6NuYwZ+SGE6K7uCsNayXBFnTgWCqwLTSjIGW2h0tx9Lpewg1ZgEJsR+KJJxfUz/2BwAoVH8nPb0XVlwyKH4FnPwOvFajjJnlGKSK3ZHbNk8ffkQvjkWaTh+6U1pDnz06BO0gsoPXczAOgwUcyPAQdXAX0u/gFC3etLaXMvKbRnK2RIy6kkPdffzobnfhNKNTTeYIIX9YmsV5f2ZMprSHDYi5wMVJKionvKTSmW9cM7g+zDYh+WjLG1SsJW5+GIXrAxBqP+g2CoYLaYeOsOsN72xq7iqHpss0AAYuZzEMd1Scr4h57ddRuY7K8OE88u1NxwwTdn8YugpZOhHuSVVS7T92LEdmvz2iVhIAutstgVEMGothLNW6etefxnabKmhpI26RxOhGxdAe33UUwdjjVgHJEwxOunVpei1vn3e6o1j37bYr6LXIKYDfV8ggRjxAlfNWytQu7XEVfye3ybS4BJfymou2dIWjaJe8PDr+qnRpg5jxJimOss4QpCtwlSV3yPdPbnrIeVoU+gt/9vEZWaSePwAlyyyK9R/3nBUfNm+WhsSonRPyJdjopnqxtQoYlhe/KD/+pz9DUzmkNTt5KJf3IaWb5Y2IWopJYRe3jGxuFk7uMLduTjmcR5kGF3p1jpuaxT6WnBgsmjBk9CkatjTqED4Z4nyJPeX1MHE6OoD77mT17HXPCXk6PzhtpVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(6666004)(8676002)(36756003)(4326008)(478600001)(83380400001)(6486002)(2906002)(316002)(6512007)(8936002)(4744005)(38100700002)(86362001)(38350700002)(26005)(41300700001)(2616005)(52116002)(5660300002)(6506007)(186003)(1076003)(107886003)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lrgoDOeRcxJMGfFhIqYWRBYenLYfrmg1+fO/fWTjQLzPmW5wFlP/SjKoQ3KO?=
 =?us-ascii?Q?b0E1jmBHGmmDrPAzYPBPylnAPy/+Gp4X/H5lp+vCvpATRV/nkNWKpbsHll6c?=
 =?us-ascii?Q?ZxZWynZthK6RxV+zpCwwDEebwYDPoDZvlU5vBp7SBPt+agdRbGF3YcjkpAR8?=
 =?us-ascii?Q?UPHGCkvbrA6umX/RliymiR+xk2i3yO6nzmjGPvQDHNGh6SeveCdKFyUkbhbB?=
 =?us-ascii?Q?8zIZV3L96v0egZvGRnU/P1ITiI9F/4yQKYyEJBANc+3zszFT0wDbV5faGV/I?=
 =?us-ascii?Q?QPptJ6g9/etZD+JLN/zy8Hnqppgn94srQLMWibWAqKWavmRtKGUGIMKqQocc?=
 =?us-ascii?Q?wjUh1yPdkszOiCvuuedy7uxRej8v5ZhanVMXjFps0O3HyBE3p+YpcqhqFwf/?=
 =?us-ascii?Q?NgaY5X1lAXvuhYpM+X3BwJnkC7pzwJ9bhwxusrWMSNbv4apNQQr/KguA4c7V?=
 =?us-ascii?Q?5d0JdoXyqJi2Pc6ini8ltoFW0UNs2SsI24wiRsnMBJqKXFnDil1n/UJ088oT?=
 =?us-ascii?Q?reyHfZfizlHtPi2qEbM3D6tfK4id2hqM13Fj5Kne7cWaJ84W+QPy65whfnrZ?=
 =?us-ascii?Q?C3mEMGeuKQc/Zk0NRO69J80x76WqEZK/2ZTKINvcONMh3boh4s6t8n6l41tY?=
 =?us-ascii?Q?urYI6jkjNS1DY1NFaL3osm3TJpgRWiVB8GakQCOUXgXFBccs++cRVL8lT4K4?=
 =?us-ascii?Q?rrSacIkFxY1Ckyd393H77rx1+ZsMHloIMop6769Q9XAuzyBs25wogznkbjRX?=
 =?us-ascii?Q?DGRquRfX9okKmhAtcag6iv5UKhoQWxgHwW6zoJ9ou6hOKuxIFOKT9StGOf3M?=
 =?us-ascii?Q?rQeFNEK1wLrOus80hCObS63KKVCuMHLSRqoNEfcEHx+vOlm2k+HLRhui03W/?=
 =?us-ascii?Q?d2PLD6m/IWLRiq0gU76sXchk2kxbErECJVvD4Dgh+w4dZCgMjYcRC29DrDJd?=
 =?us-ascii?Q?HBLrLdKlbvPUpgUwoZPjKMM2ujWjkoMM+csOXpmKs5Z19NkCK8OkySIBX7oW?=
 =?us-ascii?Q?QKpTmm0OU1h8EqYbqmxHeEAep1o4KFvhh979wUoiNRqw/bfktYuydZf5VfLP?=
 =?us-ascii?Q?+RfHiLXnxkVvWisYx7Nd9C5TyyTqbGOQRnvRarD8qb+3uTKanbux+kR2S4R/?=
 =?us-ascii?Q?WJGCvpAplMZe9HYWIga9SmXRtlGqssYc6D4UgChr41hBSlvV5DJYzDu1nZtU?=
 =?us-ascii?Q?MoQFGpivdP8N5vEx0074Z+5CesqVc2m0kp0U1NZ8FFYhUh+m4mgZlHdJhhiZ?=
 =?us-ascii?Q?ZDUeQzMUssv2CBi1unfaEU/6GlhASMoXFCeQbSlliDXD8EN7aJhC7GoEwe5J?=
 =?us-ascii?Q?9EsYW0dpnLBnfG+tZxOsqYf/OZaCjVXLR4FRh5gDyCygPHTAIHZw1uv8NYWc?=
 =?us-ascii?Q?Wfhxo4pYUp4/FBRAutBlO9i4N03cyq/g4UrJVd1iO9tdmcY4nDva+3R2Afeu?=
 =?us-ascii?Q?obhWUJEmJ0SrSAkhjUQSH4ZYVMILIqaHA951js6nuvfhQ5QHxaws1o3HqBi2?=
 =?us-ascii?Q?dsZ2kwti5aCOylUnrI4Et9WSZHDhDWTFbPfKof98XBSy9riQ73jAF4qKUJ0F?=
 =?us-ascii?Q?R6IacLXjGdpWFearqEjnu9eiiPT5WnpUnZDzlXtp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59de766e-5f9d-491d-db7f-08dab8058382
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:25:04.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnLgpI4m3RFkk+xlUOmebd2T9P9Jb8DRtHKW+c9R+eaw7zi0A5uxgAC2+/Xw6Uthf7iwSx1ZFzEoi0hBwtARZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5366
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return PTR_ERR(cprc->f2fs_issue_ckpt) instead of -ENOMEM;

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/checkpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2a5d9256a6f4..12fd12f2bb97 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1899,8 +1899,9 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
 	cprc->f2fs_issue_ckpt = kthread_run(issue_checkpoint_thread, sbi,
 			"f2fs_ckpt-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(cprc->f2fs_issue_ckpt)) {
+		int err = PTR_ERR(cprc->f2fs_issue_ckpt);
 		cprc->f2fs_issue_ckpt = NULL;
-		return -ENOMEM;
+		return err;
 	}
 
 	set_task_ioprio(cprc->f2fs_issue_ckpt, cprc->ckpt_thread_ioprio);
-- 
2.25.1

