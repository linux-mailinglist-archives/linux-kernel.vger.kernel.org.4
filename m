Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8042062FC25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbiKRSCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242511AbiKRSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:02:34 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E191C24
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:02:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqD6K+l9RhwAlFB6QvgMRHJqQNF5MvBsLwN4fiIixyUPJvrPNj6RcnhlFkXop0QCfHz4ZhbP5Tz+dMNS/eswgdkmdtxyFmwxNf2tWlrjMcQzkJZ2vdfkxZhLcj9GZImBnbS0qK9aQx0QxaSvDGwxMsxbWlGv7XA7quFAMLPZjUu0KaH1B+L1CiUNEZUp5Um4nOWwFUOp1Q2cghvYeij/f4Tav9TIqW+pb6aLDhVu+ePFWDZqANJU9bXLpkfiSSER6nsAdcOZ9zQhAe+lBtcqxZWXvRf5EVBTrTOmxwSIzz5EHSn1lL9E1QGQjUVwFPUfwpN3aSv3EhzVQDotpDVg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z2by2e+cOC+xdjmjMWgDCVy6SXg59YdUOWUyIrKAbA=;
 b=EbbE3aMQ+kE4GgB0BQs4+3e+PYMmpJx4XRzlmpZRq0VW+FbG0wB0hfj7NdlWn1UAOhNYGTbpTdyV6SvZgUopbA9tzRD8jFTUxgDkZJ7baKycUi0CMsAGqsGKqIsFYBBlyR+5BQSjbx4SR6BCtQd8vik3qrWrj4Uj4DVpGln3CkARGTN+WckqXJJDe8r49CNI1EqfLqXb/wHG2CxGiOALarWAwYqRn1/QeRitdT+8XIzu4bzO65a0MDU8tvml8pBUiVpbGplkV2+rx+orbZKyMfsl/VBd40F6LXQ12KV5tjZRwYFbFwKXs4wAlwU1qvooNRcRgtPOqHSY45kkvAT7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z2by2e+cOC+xdjmjMWgDCVy6SXg59YdUOWUyIrKAbA=;
 b=TwtbIPidPGlPgpmybx87hYhzfmY2+pVo6WQGKv1i+czfFC69Kc0Qz+KPfxXR7XbHHgeXuY+qT5kwpiKctJeuPWLepn1QFNCitsWqtYG0IxbI5zXYf8tDBIjju0FcFEezTTA7LdKUSxhZLE7aWyUEUhZLmCffr8JCh6hlc8znOQSrG3fq4dxJQEesId9XaT6Aj/0AZ3aBbbw64QK+KSH32Lxn998p+Nw4q0Q4jCBQKrvDVs0Rsqeo68pQU9COEE1V9WWDTxBaNU5Q6SAWDtn1YjmN3hbSZ8ALHzvP6BQLsSjYgH9yolYmkbI77ynxp19R038jbQzZmpEa6i4YZxnNDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5419.apcprd06.prod.outlook.com (2603:1096:400:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 18:02:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%9]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 18:02:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: define DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY macro
Date:   Sat, 19 Nov 2022 02:02:08 +0800
Message-Id: <20221118180208.66578-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: 113b5765-ab96-45aa-e10d-08dac98f09cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioi9jJCRnHW4rIZII0XKNXcN0kL2+mGlrnReilg8n2YS3hIEqnGrP3+Tdnt1P/1hSKt595zRjG0EfnIipJPZh2SnHBdDgILcYqR6iuYju3FxmcWjvIuQx/f122hwrVJilGlttHJR89vcG3ep64vfg3ssKrJeD3Meo4Z3tGnU2IZtemlXqdS4u7f5Rla0XOMD1P6l7gHGZtX03NLvwQC7MSxN4VBv4QoHUfHAgaA944lkIZEWX+iTBMQ7DApVmT558yyMXKZ8IH0ZS5Lh3qEvolYA0/USDZoMh6XAu2LbLoyafJHoMjtFUK3l/9poKXYFqjfXe7qbNlR+w9M7qkhwxGkUaGZrhHs6iMqfxVxKFe2UDcntrA7Vw/X/D3OO1SYUp2ZK9pEfFv1CiboD5VWwa6Xc/PGmcfLxlcLscgCZR81hzLIPVUl2QuFI1kEA4gsXM/af+v2SsdXfKzexgiyPVF1026lyuJQEnO/KKWzXqt8SCjdnqx7LNVs0dGpa2EbLUxiDJJ9ftRjvWsf6TLCubCV9alcqWFwHck/aETi67hzVPBglnT7nb5Mb6UsHBa31XDgy9rkw+JC3N4dTPwNaMvHHDNIxDwFFQQe711DGKytW3jrywcCD1Pu90e5+arHtWmno7rfu187Mv5a7aIjyyvMUcEWcudyBV4qldhtPYQB8pPqjbZBhtvTfWJ7+20un
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(1076003)(41300700001)(36756003)(2616005)(2906002)(5660300002)(8936002)(186003)(83380400001)(86362001)(38100700002)(38350700002)(6666004)(107886003)(52116002)(316002)(6506007)(6486002)(478600001)(6512007)(66946007)(66476007)(26005)(66556008)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IusM55oqNTBedPc6BOymERWlxuQeVZfl8DhODVbMket6gvrBwY0IuWK9cpK/?=
 =?us-ascii?Q?FavP33yay0PRLgXhnDt2Y6TJbWEGFGxZXHr8VXS4wDBunf+aUW6THOghvzBe?=
 =?us-ascii?Q?22mZWbtxRRMsJrdws9Vl7bu7s4w5BNJ4V/QT/cqXupMIamT1soBWg/nEpoKA?=
 =?us-ascii?Q?9fM6hU7d96ogfXf4XpCSyE7ClYKF66BwHLoW215pTbm9nhC+pSuebH3cOyTb?=
 =?us-ascii?Q?JDk0gwRtJNKvCx8NFDCT35H1W4xmqFIExW6RFk50f1bGAjaZ9hW2hdB/Qh85?=
 =?us-ascii?Q?kWLNL/76N0adGHAcBDROIuFrcYuw6F29nW2/h3dfbbXEItoTgn+mXz/AEvX3?=
 =?us-ascii?Q?p79vp9MIRc/YOTjom1M2KuCFbMbUuBTjpLg0wBO+++C2viz7UptslO+bPcr6?=
 =?us-ascii?Q?YvNUDbtXRHNUEbFnFcAgRF2mGKnqYeWq8/VYAW31YEaMMN4s+OmlzwpxSqX1?=
 =?us-ascii?Q?dLNYv/0nDSSWFAnWjmJQc4DdvONLMR82KC+ExS5VNsS9Z+gdJ2I+04yNC8ap?=
 =?us-ascii?Q?UG55I4nd67bdnK13lQ3fenYUmPQumhd06N9w+Or8uOB15nbgBYig7SBZM7e8?=
 =?us-ascii?Q?/em85thkFbhsbkdh1pMCgD0GnNUS0T/99dIx+C0PhUmvdol6LAQrvr7jljSg?=
 =?us-ascii?Q?OJWglaYyyhegBYfSEmFXfSdAXmgJtUIw54C0GEV0bnTNaNZgLzyRAio7yHU8?=
 =?us-ascii?Q?hEO7bagIEg2IoKTgXeI+8HbFxdn/axuG0GDeulB/4jCCR8kob+JD5LVoOnuc?=
 =?us-ascii?Q?dhx+8uBSrgh/IFv+r2i3cxYcHFqKIiebrZXSyYCljT3VYqlbzobqf5YcV7PI?=
 =?us-ascii?Q?fcwo0Pl96PGrDETWwRaSA20fWoAFL3PX22hjnzo8xJf4QlaNGVVA9Ca+vxoy?=
 =?us-ascii?Q?uZmpU1Q9CPi1zCWgc+WfHTPwHOrC7+f8smrjBFv+pi/M7pMl6Jh/eyH4c5Ph?=
 =?us-ascii?Q?S3JIE0HxKsqWvXsNXeBw37UclhmtBPl70NHVXHqavWzhfSGqRwXzjlAUBkRx?=
 =?us-ascii?Q?1EobgGviMRG3hH4g1iolhonF/DL383AngIW40oeoEJZyAJ3HcoD5KfREKmpK?=
 =?us-ascii?Q?CvzYzksymrFgp2zImQWNuM54oNpv6PksPi1ZXhMrlbJ+zEKB1eebCX5W2Jep?=
 =?us-ascii?Q?43nh7G5KtUUsha2/0XhdWPI5vKb6QQZwAnqJ2qWznsiE59eUE3JFV9T9Hj06?=
 =?us-ascii?Q?tvXEG6HkgoEu8e2usyv4Db4zyqbf/cNrey/qfhxoKG416mzvpiHch51owfYW?=
 =?us-ascii?Q?bvxqhHVbafSNFUM/mTa5Pfa5/uF8ryb1A/+4coEJLhgYS96eq0TuV7102Duq?=
 =?us-ascii?Q?U5+Y8QYZPj/PEB/060UFvL9ECvTMOt8Y8AfAOsXVdjNdGRVAmDljN4pReooj?=
 =?us-ascii?Q?IYMoPeb+aNANKSzJqlQIDiMxH2B/n657SMdzPWgBt8Z8N23XCtGC5Ig574Rs?=
 =?us-ascii?Q?g0pEsJsI8lPEJ1BP5troesxjoZsucLX3BPYDKUGHmqkrJa+mMLRGacXnk1ou?=
 =?us-ascii?Q?Q7uAW1pz0iyPNbGkO42JtfQERvzhBCZ/LslS3DDfgzi4CjGwwGe1RYUp5eCw?=
 =?us-ascii?Q?zYf7NS6z52YU58JLKJUH4iE1sKruFAu476io/EQq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113b5765-ab96-45aa-e10d-08dac98f09cf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 18:02:20.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyeXmSx3dmvyD795ZbmiF8c/pKBN3hez0R0UeSrLVLQoTbTNNCCyfq66CbpjI8sabRcPqogiCWr+wat45ywmVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5419
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do cleanup in f2fs_tuning_parameters(), let's use macro
instead of number.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  | 2 ++
 fs/f2fs/super.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f0833638f59e..86c651884d26 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -329,6 +329,8 @@ struct discard_entry {
 	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
 };
 
+/* default discard granularity for small device, unit: block count */
+#define DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY 1
 /* default discard granularity of inner discard thread, unit: block count */
 #define DEFAULT_DISCARD_GRANULARITY		16
 /* default maximum discard granularity of ordered discard, unit: block count */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 31435c8645c8..7c32eabcf50c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4080,7 +4080,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 	/* adjust parameters according to the volume size */
 	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
 		if (f2fs_block_unit_discard(sbi))
-			SM_I(sbi)->dcc_info->discard_granularity = 1;
+			SM_I(sbi)->dcc_info->discard_granularity = DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY;
 		SM_I(sbi)->ipu_policy = 1 << F2FS_IPU_FORCE |
 					1 << F2FS_IPU_HONOR_OPU_WRITE;
 	}
-- 
2.25.1

