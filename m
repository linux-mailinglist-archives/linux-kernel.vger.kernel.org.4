Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F796C2081
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCTS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCTSzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:55:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3911F47804
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKkpa05FHPVYLq03oEV2Ph2JQvO2JT76ZfdR1rSmToreMdspeH3mROFlVGmBGkulLtDBaly5dPGM39BLfROyFSuw4oOQEYrdoKFmqsBjmJ+B9h9NRmnjIP00vqi9DJrwihfb5kBlaa3ftAJRsEfOud+OLpiuUjuG9LdnnHo8BgovqnmUsYAd+vi9vG4rnbNhN41HAs1Y2cMU5r6Lu3MROoBfn7FCDmp4dQGMja+z11aegd9UlPHl9ke/hPiFgAlTXtmtoAuErTUnDujfFWMZfgY3TKkutL0e7/nEoWf7EYnrsLq++/pGt9l32cQWwP49g6FdYsSGilh4OFrJzwu5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi/SB7uU/Vm7xG+VaANHu7liHPdOo0JIwPJ5priBNiQ=;
 b=nUkuacbYjmmnd5RAFjVdFkrpVxkDbsvjhUhkWRDeWIkGOc7DPCwHr957GwkGfR1u+lxIdiGDEDMIZlBwyrRsbA0d7tp0Z/9zrKfmth48K77TutbWcQ2RgvYpBF3w6aLfaIVWxmwuD8FhpfurOKX/FfnNHqEYhUUIkqWr7FNokHysBPURb9QPW8S/QLskoIMpwTON8j9uJ2PGqJMxybSKEygUDKivFVL/2FjlyWfRCdZrcLv7DjXhvmCevKBhslrdlBZO+hp6sDNTOAwa+232cVVdJyoQOzjVEVneeUP5619fMeT6TbZR7jkVoUQ9efLeS+RuJvi9V2nmHzvNo/BfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi/SB7uU/Vm7xG+VaANHu7liHPdOo0JIwPJ5priBNiQ=;
 b=msUuHeySd+HvNzZnlQ/VzyVlWmoGokAozMclfOqa5rDpcU6+mRw9enlZ+lciCBQHYvrSnJdyLqG+UIIg+R3h/ZcxSWw4rBsZiaBxZGcBdjcC8eEWMFE1TgSpXSJlV7gy2y4sUD7B03K2wZrgyg60FNmacCamsNjw6UZDILV761XLjuY3zjBzBEkL6lxEwiQ0PicTCwaXYifyreESq8p1vSXpEhUaMoya3oFLB9kj02soq6S4dEbNJl5r/rhHVFWEGBgM+yPnzzSh0Fe6QpZGddG6giV8ULdxPZn+uFtmY/5n+TwwlJGo6JGfjafWf3GjRje/rD/XskOIydPnxKthEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:47:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:47:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 03/10] erofs: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:22 +0800
Message-Id: <20230320184730.56475-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320184730.56475-1-frank.li@vivo.com>
References: <20230320184730.56475-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a50b14-7e0b-4c5b-3a25-08db297399fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkcOnaNbyM9UVaj53P5i2tQuVGTs4QcqmfYwRYtRxcYkjqyU3XtBH3xRDKnophgjhI2rE5dnhrlh7V844HIhRoQ0X4+THi0m931xLYkETYp5mVSq/sjWCoCiTonWE2JRxmNurvUP9Fz+hD5BKdQNdu1yhFiVLDSVVx4ucZiLiDJdR58xkpHR3ehC/eN5j5BQNRmEQvYt9zczhfEvf48VnWKtGO5kyCQhgQvnSvhge87YhkwxMB/vI45PpyTO5stkGQ/yb1+spMZIajvgjQuxcOy7kNMfpBH8bGX5l8bKEMVPNui+Fn68QvFPqhNjCQjHS/qPLBPvAxIS9ErE6+dYpGf9N0xeHYJF2l+B9pWkgYtbXESRrNZApWI4I6rBJByU0VgvmxYb9N8U2E4WColP2FElco+VA5H/3yktcmgcjp09rWfqBIh/6oZccb/uadF6VCysZUYMGmkamX9K8MbKw78yJHBGa6moOi3VS/Wjr4rhf12UJwPZnZGClZ54+byqIm1PLSKofjPb6HtdlJOmppk8TKT4FCCxeQBmuJ9vkY8t2XZyo5VlJW/Yiipt/N8kpurTKKxHpd84PTzgeCvhMlCdzjJfFtssmJMMBhjeqKcS6cGsDcSehP0BgHhn16vod/8wOktFakCf3FAqLfHcbzgaxDxE1K8uuJNIln+duEvoTb8/t4kfRa9scU2YyZpDKJEQeOb3rXNZL+BE8ZlaQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(66946007)(478600001)(66556008)(110136005)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(4744005)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KFZdApr3gNn9tZHF30YaOMl6U65Pu/s3qIN4Xjk7L8cy5pMX6b8uA3WhY2bA?=
 =?us-ascii?Q?eIJ10DRTyiCj9qJL+xeVcTwc3Ovx4KVbY4xA4kXJcq2Wcs989ccXlVFx1J8w?=
 =?us-ascii?Q?PvdKVZA8kG+/qXtBJQ9jLOKZblFO8KX8XAPYweUjhWzuj7gP/mPvpuogpX9v?=
 =?us-ascii?Q?rXWNolgjutlJgWuT7yP6Pb/C1sAWTeiWJf+ZMdpELwx6CXCJ98aTstZc/U1M?=
 =?us-ascii?Q?0GnurqTXQvatsg/ezKprmkR+Ne6xLtP4rAC3iXjyrOxZnpID2xxFeqQWHeUS?=
 =?us-ascii?Q?G7hVqWX2ga0Luq2bEQUqh/RaSxyCH/LNDFAX7AZ2EoKfFvAQ58CEsT02xHE7?=
 =?us-ascii?Q?9WMU9N9GDef+rchaaEAuravrd/gjBDiS7EHrls+eyYaYdIl22fqvm9++SlmR?=
 =?us-ascii?Q?tmWvaMXyQ9uao8cfr4WLURx/3Dau1Oy1ImTRQ97FMte45idxSkqQFklzql2B?=
 =?us-ascii?Q?H1ON9Ug/mmYY/dEAojtE7Y4PfsabcM8Ajp3INEYu7J2m13wmdAKFJzwbZuTc?=
 =?us-ascii?Q?v6/e29GLtdEXDyUE1T/fHSIX5xWhSiaZDKEUOabtREUebZ/R60p1MprH3ncH?=
 =?us-ascii?Q?YmSIamdyyL0JWgcZgCF8Aor90L56EvNutP5DTDysYYYU7Jbl64wXDZ6B6Nw/?=
 =?us-ascii?Q?cJZj86JF8DE93BhdBvDa98H9pzpYXwhY41FCL1TLxdgqqO5vejnzLYfHR1ta?=
 =?us-ascii?Q?d7QmhKw5st4NCt/oqWbL0OZkV6JIONkcyKle2MV2SYj1vH0SEhC94aSHIELH?=
 =?us-ascii?Q?uYV3Nau0MkCkDmJRkHgaAT+BjP5a3v39ZMb5aV7Prlr9BZDLX4QCQ/jLZcem?=
 =?us-ascii?Q?rovgrAeiYqUBUbjUh+saxHbuNglH4BUXWkChOJDt9k4m1GDZPr7yIOnHQp2s?=
 =?us-ascii?Q?UH1/AfHpYdTFMgx5yc3CWgEBIp5YmAGic19qhSSxhFEG2rB3hg8eMrquEM6h?=
 =?us-ascii?Q?QJsmh8Zdr5hR3oJOFoeB1U59CsIPtcmXIxEE2s0WoqXPerZNP3diABMwqz2e?=
 =?us-ascii?Q?PGC3c1Ub66wtQADUz+nocduxQCmNdnNP70/Sg11WD3k4Iiz1W2VU2n/V3FJF?=
 =?us-ascii?Q?rHeS8+eELWHc4h26d/RvxGTnAHU1HNDsai2LxzLBBj5JJnX+GoqQC3zx7oJJ?=
 =?us-ascii?Q?Rk2l5HUm0QUAb5LmJEhbyWUvT0iggrzm/Cp1lqELWAUkvlntXEvfWVOonJl+?=
 =?us-ascii?Q?Uhl4rZcMm+R287kgCbRxcUtesxtD2PbugHTR+MYCuHBpL2nsYzAhYScDegcA?=
 =?us-ascii?Q?ljml/YZskcNLr8dT0Z6q2lvV0hHjxq9Ef27Ko5mIkUc2F2tjCy6LDT8ySXyn?=
 =?us-ascii?Q?MA1NsRQKgTx8Dht2tdJmzYiKQWZcNBaQXFgxQ6Aq+CwJNgVCR6IiXgrs1BSf?=
 =?us-ascii?Q?0GoLEvajBDf6nLIaFVlHs4GqapgTwXeFLRjavCzHr+6d0/dmTfSpJFmhq6KL?=
 =?us-ascii?Q?rCekQ6pvcfNTxscXssHqIZwvdkfzAoY8yeZqCHnCAmmpm6xedu21P6wdgRKN?=
 =?us-ascii?Q?e2tVICIRduod6KUihTCer4ePdPsqQLsv0VsfNqFgbO5PEuRfS8/Uu9UTwRad?=
 =?us-ascii?Q?dPTvW4waQnZNtsNzstsC8uZIFRy4jq/a6GFtOEVm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a50b14-7e0b-4c5b-3a25-08db297399fe
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:47:48.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kAtJf5ELGvkUzc0XWrBzUi1RM9WaVQDzQ5WYo2Tdut/K0q/gi40iRs2oEjXcgepxVBje33t/uiMcuDsS9PuOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..9ed7d6552155 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -241,8 +241,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	if (sbi->s_kobj.state_in_sysfs) {
-		kobject_del(&sbi->s_kobj);
-		kobject_put(&sbi->s_kobj);
+		kobject_del_and_put(&sbi->s_kobj);
 		wait_for_completion(&sbi->s_kobj_unregister);
 	}
 }
-- 
2.35.1

