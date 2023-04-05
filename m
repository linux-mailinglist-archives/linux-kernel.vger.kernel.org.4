Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF636D7D62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjDENIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbjDENIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:08:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1DF10C4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pft8ISaJxzOY1THYOW3n4upMwGpAAv2gyKGUe4f3FjwvNhfrMz6c7h9lAxsOB2S0DQCrTPK3XoqXEzspAGUmvy3rUTF5kBUWahSF2NEiX4eVtYdpMhvo8UmUl6oeaT0XH8DyFO8C+5VZ9uyRJ06u0jHR8NzqevcSniLspBmaKCpAy8ypa0H8qTv4ZGnpHmL5tA9MQJe6F/maR0ewtMEHII5f0tIBw3Fm71Mz66wV7XemT3Ppa7aYNzd61qgfieyYXkffHZTc/2N3pbdVUesRcCL7dozoQN/SmmQO6dhWrgGj3y5IwuxQSS7u2XIS2KQ6EW8djs790kdXmf7fS9HLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRB8RkVUG4iyjf7pN7JNY+Vegz9/XVmkBYpqS0Fi8gc=;
 b=dKQvChkXBGY/umlqxotzK4Jitam7NX5aHMp2Tfrc39OmLFs66ZNQK6ZDGJh3lePzu5yJictorsElruZBbzCO0EjAIBc5x5d7YENjwdx1/v4IM3Zo/UFaheuh4QS3JmAw9uL7mEwch9YZXvof/9kCJf/XY+vp9nZvlXPS6I3WZ8a6ctoWZ/HTFYGrJx/u03yiu6JFgsA+7aUCYerDKW6dLfNWAreRO2gif+q/ph7FPUeOsepbSHIeQ9dF+CMaIKm+ewDCGoYOSuqh0dTvcnZ6aP2Tw2jp7pW2JAWVNay+RwTqcq+oacZxb2Gn/U+9wlsH43h42n19Q2iYYciELYReVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRB8RkVUG4iyjf7pN7JNY+Vegz9/XVmkBYpqS0Fi8gc=;
 b=Jp5oxHhQymmN2MxtYNQrtWi4Mxdd0a7gmnCYhg6zZ9oFCXOKnqZskDmWsHN5b/6ixwoDE8BPHP2kyFX55M+D6IfIUnw3xKNT1Csg2JZbMb0OQDxsniGTqCS2qvoY+az371heRfEomZIC2dn2ySDGZKlfqBTcaHHlts1Kw93CtCsnv/U0LyBnIszN/9Yj3Z0PamFn46vFiqMOpRBDaKpaQMoKeAVMFUqfx1i1VvdqTvtGorSQTYSa9KI0fNlXw3EhF2GaquRZ2NxQ1lMUfE7wbWgRF0psRTkgaDyeL+VzbbyniRP2QQnmGeWKX3vhaO6fBj580YuHTU5Pg32grRIOlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 13:08:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Wed, 5 Apr 2023
 13:08:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: remove unnecessary kobject_del()
Date:   Wed,  5 Apr 2023 21:07:46 +0800
Message-Id: <20230405130747.66006-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e52fea-1f3b-4666-424a-08db35d6c8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNxz8rUFE6kXhZ1QBFbyZlMwfCgAmkmd92OhwADsIjCRu7mcQ/Ovcm3ktEAZVa0eNKAicb7idxsIPgNelU6+bbC2yc3xpBUycAKw8hQQ2woNyYt5nHozkQ0DxrYnWou6ByihpTdXhKll3GPv1WJKNq0nfUAOiH30x/xPQYqO9qyRHXGlVhJptahqkL+6JjqjQcjdiPb6432bv6P/UaP+CvPXOUWj7ho4smXT45VYtPMrWd2ly1AWkuKD8blFuh7xIvfi3Dhxi+KS/YpThCtsSjmFVg03J6J5K4OUOLopdrv0PtlfXyizsfcVq0C0BzSsq5Cs3qGRKkZ38MdjUlUGSeOoWIRmOjjOtLg+J/oUrU62SOuxL3tJdjSBZZIcxn9uY/bFbkctIOreA2+mFrh1lAHI+8exRA4p5f7TH0WzsEfP9Z2QYEkTCGHbnFpCzeub5OTapV6ZmK0KX9G/RCiUiRkBwGaU5imu457ei/7kZqjf89Y5IyKrEo6cisHm/teD6fsNlAf2fOUiCcwKZMF8mfmmhs26gqhTfpyEJUwqdFOZVa2RegQy+LldeosHovDKz2dICy7fBegU8DKRN0D+dgYFMwveSkqSDCDJFp+AFnECDV5wrV8jttSeORPAqLik
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(66946007)(83380400001)(6666004)(186003)(52116002)(478600001)(6486002)(316002)(6512007)(6506007)(2906002)(1076003)(26005)(2616005)(4744005)(5660300002)(36756003)(38100700002)(6916009)(38350700002)(4326008)(86362001)(66476007)(8676002)(41300700001)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J5xiSuS9WI4NGeM3KoPa8iMlGRFOCRaGsWsVXRawK/hC6mCJEsXh5ykRQhfH?=
 =?us-ascii?Q?meSSxeciKb7G24eouIEK5sRHHp+yvJ3G8bWZJz4/RIfHJa4vag16IkVg+moQ?=
 =?us-ascii?Q?bD4OMu0iqBc80z+4TYPQ/nG/4l2ICIgLW86GHZdyWgF0ik0Nq7kyHXqlSAsq?=
 =?us-ascii?Q?YwRXutPtbMJzgIsC9hk2mC92NCYkY18qRHr7DHnqZEV8OmFO5Pl/TRfrPYs1?=
 =?us-ascii?Q?So9Ll7h4T6rx1I7/EYhIESFByJedD+jPprVnJcuz0agi4043sexdde/0lFGG?=
 =?us-ascii?Q?8KfuAmlVfhmuvIzshlB5vxLHpDJPR12HeoO40BhTzixcRSQShAjCl/0J0iAC?=
 =?us-ascii?Q?Z0ufkBfZFgaqlSTewt6e/fBDKWIVzRPwxs6MbAAweWufXSlRndfu1xxvrg43?=
 =?us-ascii?Q?w1Q/BAGe7pvvB8N55V4KVubp1Hfr9HlFLK+AkrjYXgOJfjgh08SiwifweRTV?=
 =?us-ascii?Q?wC4LnlNLieDpM2Ttgsxn0/cMCog6o4hvTrKdEo0gDuoUKVcYdn+KsdQCgEgS?=
 =?us-ascii?Q?2kfuMchOIVeaMRDjw03G8Vtzy6NZNtDv1n6htAsfCdDv5aVDGHy3GZeUSuQZ?=
 =?us-ascii?Q?NWc4PFBT+Sqy18mXpfS9WtdocwgAXeSg5AVJdOmzqjaubAOsOJ9HRIdFOJZv?=
 =?us-ascii?Q?W+JBoNsR97YsUdElV1jj0hFs+ZoaoY27CTDs4hiPpG+B/xYhPa0AYZjhzuBY?=
 =?us-ascii?Q?ytBLXjcs2+XDm7/bRr6VPI4Q3eljFjMnE3CNWVgzFfMFIXd/qLmJ9KRVRJHz?=
 =?us-ascii?Q?EoM8SoWo98UUtt49bqg/Cagz6+/aye7klnf86+y2JvTVGKOGIp2Qa16BmYZJ?=
 =?us-ascii?Q?F3nF9YYWJ/qG1EPoJ9vrROhFvZilb1cJ2VCq8ViEi6uZqI+AyIZtvQ0DBo+r?=
 =?us-ascii?Q?XPx0vOQ1nptKndQAfidbTxPApuqztH8kgN6tp66qA2qGPudhbyB5gI/gDvhC?=
 =?us-ascii?Q?60z7MwqSoJtYnTVkdpfU6qFol8jV7H+sH+zdQkm0HrzN0Ua2Wacf6rKXLWsA?=
 =?us-ascii?Q?avYFTPYMj4oU9qPPYE4WpFhKzsfGgRG2f3CamfObv5K5Q8+GPAOjBhsC/hvI?=
 =?us-ascii?Q?kUpSRfwZccd4PuAExf4gQkgszJOSoZ8gov4RwZsYDB5iVEKGJGaIubv+7YU6?=
 =?us-ascii?Q?2akfIeGtzkxJuVUmJ8IAMZpFEGW6ie93/bVoFkgqRG27UoNLP4VCLDd42FfE?=
 =?us-ascii?Q?q2ZKsdpqVghQGZ6ashEaQ7T2YX8xDbIUNLLhJW10wNO386A0xAnKUrenLoQt?=
 =?us-ascii?Q?b8rT1Vf7sIkPQfT9/xF1wzcxT1LmQHBcI5wyNfVUeYiJQmN9XwZiHxgcf6bV?=
 =?us-ascii?Q?l8OBddbJV5ZkENy7CJppHIMSm2IRsmnBHCUV5ziNuUFyjcjBuAmNFE9F7Sj0?=
 =?us-ascii?Q?Li7AzDmiWnLXgZ6crDkxgp/K5GYbj3uPPGkau4m7UKSnnFx/eyEEyKoUYWQP?=
 =?us-ascii?Q?bbCIFtzcMM1BCEPliFOLWznUd9PYc9IKmOCBcPqZill2vwXIXT2EUjD1Eojs?=
 =?us-ascii?Q?lQXpyaFd5BsPAA/rcGxAE+dWgKLBjK3bGtRr4J+j2TqknR20jBKTPzF8whiT?=
 =?us-ascii?Q?thQYRN2eVkKAQGqeZTitr5TZVVHB5JKDbtV4yEU3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e52fea-1f3b-4666-424a-08db35d6c8ac
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 13:08:01.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4iRVcmvSQ4plgYOPa6/0qQ5hhTTzu4O9N7oypo4I7JHCdUurLSqV85OkKf9erciieZfuQB/IlneOxgkpCuc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_put() actually covers kobject removal automatically, which is
single stage removal. So it is safe to kill kobject_del() directly.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ubifs/sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 1c958148bb87..1ffdc3c9b340 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -130,7 +130,6 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 
 void ubifs_sysfs_unregister(struct ubifs_info *c)
 {
-	kobject_del(&c->kobj);
 	kobject_put(&c->kobj);
 	wait_for_completion(&c->kobj_unregister);
 
-- 
2.35.1

