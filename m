Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF72B60C5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiJYH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJYH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:56:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9F21633B3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHYAMOINhaMnSb4bmpgROKoPYJ+66K3YrNFdAKd3Fs2VlSWKvlrN8OBunMgiwPvH2VVOu0SnKLzIZFHAJK+2cZXmCPs9Ms5FmKgww+POqH7FN/odaFYSYr355+kHbV2nDG4W45EGhdKX2JT99d1UUY+TH90UIbwJRyhfuLTxOGR4rtilx1YwY2OEfg1yHe4HrcSti4qJ8blOE83qbfs47N2dC0tloDxSg/iQZNXrP/KTa5EmYulM0JwVmJvqoBLmmu9cM89+yuC9NyRfG+wjFpSik4Jfso++EfnpfdHKkFMAnJB2kdOGmsVTFGTMZKbCd2iUkIYVx1eNRc7xbuCfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piKQPwu+RdRGaBq/FepwcAEu/irtK7ZeUzcxyAT0eR0=;
 b=UrYSuoRtErQJXdwzrFNmqsk3y4zXP9vvx4CEuol7Iav7+wLTPdg1BtGVkpyNYtH518ADAdkFRbLkdvOypdfXssl+DFVHs//0XnLNd8Okx8Ki9QqV48SeSkbLN4FmeFPezqfa3qNaO2y2fXLRoiBWK1HINUkx7I387lFhj/J73Qav/hWoinhcZIDIS2hkUQCZDIo/mDSXA37RtqofH/PH4WIr/Pa7CsS9xXot0oXsJ9MrJq7ALL8QRROrTo//DGu5Ba9Yzw9SvYpwRJK9EutMnglnWVYxkmVwaTBA1MJiajJprAdN9IPn98mOjGoKKGpmxIsG1I1cFmXqWblcbHqQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piKQPwu+RdRGaBq/FepwcAEu/irtK7ZeUzcxyAT0eR0=;
 b=Ofo19P3f4rp2WoNifGAUKi7Xh8blGF+4a11FBLX29OaQ+nRU4AWD+o5wxmid0viBdtHAU1L9vmd8rxcQTBEBaIhc2f+byWG6al1HMJaRN9HY3PWRp2R+S+nI4RyKoly907MSJ/BC7dSRE9BM4fdiiGMDjFAxZmXd61151VL7jlBt5MqMKQP6fMLvQENKFpZ16SbMcNgo1bySFVgmMgA2zGqjjVOqxDdgc0VsjZB3hE+OuFGEzMwlzKRzfuuhc+IjESLpnSsIlugfC+AHMNwUo5xIIeR15gKl99CgaEI0AAs2FjsGBZHsUV+nZLHL/60wD7JOzDoModqtVWIyzU/Afg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5284.apcprd06.prod.outlook.com (2603:1096:400:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 07:56:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 07:56:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: cleanup in f2fs_create_flush_cmd_control()
Date:   Tue, 25 Oct 2022 15:56:23 +0800
Message-Id: <20221025075623.7958-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae866d2-09e8-4ebe-b3b2-08dab65e6e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tf2I19c9U1H/oT49INOaoDuL+TIqH9BOSoPoqx/occ0O14WhTbM6mFKaRR9Z3hZtqm7KL52n/SY2DiZ0TUcpW90OiSGLU16ajRR1tjAUSG7/dbiSFAmoOGUQnDTACR4aw118IcXCef3O4zAkI3xrybyR0hnST4wbQoNniFCCsoTBIKRrnoFyMvbfO6SwzNPb8nmQnhHTwrp94qCx9YjNz++5nvjdSQDztQ/6v0/tMlaBUijQeyvSSSnSLfd5f0OcueIRJ6H/1Ure0dOVXrs6Mwey3ies44GgUoP53gT9kinuqmr/2n/920jwB5r4xwo9iejSFBo/ok7laBW1VAYb5g7n6wDIC5032Sg6YIfBgAokIh84UZ11hUkaICVcazq3JmvfYv9PB3ITNySGcmBWe9LOzsFQzilV2/iZnUM6HjIhyGdZFEiDH2gDQOmWFhieTxA6xEZF96A0rZUI424Sd6K+ZuixWR4o6/HcRImiFTsSqCFN8qsPbv8Dc76Xcc8VrZZPtiu8QDrbGsipMa1H0+lixyIO/0d5T2/o+Vc2nJpDMtKtZ/ZyZEZrlgB1kbXPhAORJGAVrHKfG/eZXTLwWP1rPVda4ggc5UvE0ytRuqM+fWgnw1qIGP6odXHlBEAT5x92eyI7nanMNJQpmUutFoXpqlE90E5OSriDp5BIt2usLWnKzF3v5X0GbUF2y++r+4nX4wm6mOdhboeqg6vT32TmmRdeYtVvAc5fsgYkBt2J6qGjhht0BlRM6eOSeWV2FM/RUpmwFBx1XnC6QGvAGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(6486002)(478600001)(107886003)(6666004)(316002)(6506007)(2906002)(36756003)(66556008)(8676002)(4326008)(66946007)(66476007)(6512007)(186003)(26005)(41300700001)(38350700002)(86362001)(38100700002)(1076003)(52116002)(2616005)(83380400001)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kayqiZdHoYunMIJX08fPJD0B2XuAYA1laKn3ISNmJlE0vF8gKmQgwloF+IuX?=
 =?us-ascii?Q?A9NFl2IG60hfQdVTv0ZdPyxaFz/XbyXBBKRzxPilc+wmnNgKzsDV4yYuYDNW?=
 =?us-ascii?Q?fNqtSOcKFLfHIQumf3lRmVrH198RTcN7RN6yAokY7zRGszSCgNP05j+JGPv3?=
 =?us-ascii?Q?SSJSOqpistkk7Uoe9gN9DYmm/JTyvxL0LGGdLfQ1xUOHfbP2RlG733FHoP/d?=
 =?us-ascii?Q?QSA9JDcnRcHLNGeUE15MKplokhLeORqYbd7AKsUUBoQrPGabvGE6qNSCSGEr?=
 =?us-ascii?Q?Fm3/OoWywOj9ggy3maAWHgryXBWwBYphQw9oJfj3FCJm4alXdptquozNdm+D?=
 =?us-ascii?Q?DilDaedbVL+9j1wC8RsvzF2RrCRFD5bQ1vvR441NdAM/C929dv9dRMcTHK4d?=
 =?us-ascii?Q?AXD+9NanhQs7WyBHgAHrGqtJRhvBe39Ate9lnj4J9OGLUP8ZhKMpSdjMKLPP?=
 =?us-ascii?Q?+n/UVh6pf/qVmo2r5TbIHx/8QLFbMKWFU7wraxmn1TxPKlPOPceKegu7AKts?=
 =?us-ascii?Q?2mQx3Jt8QxWeMKxXKF5FlGtDA2RzMTsEb/7ee4ObqxW9RwoQLDktR9sRizEE?=
 =?us-ascii?Q?8lSbiRIk/rtLMxyYS2sH2vC0VNY8L5DNr1dHMffg41K488XYqzE4JCo8Ud5b?=
 =?us-ascii?Q?Oule6y2ZHASsSQXQHWGkm0hJ56fSptN6RO016tOo0BQ5oGPFs0hHxa0DGHU8?=
 =?us-ascii?Q?5K+wB8n51FNh63vp1sE74vPac/yaEKPF2EnXCbYaTnG0Gj4Ay3CyR5uCz4f3?=
 =?us-ascii?Q?NZGj7narZp4RdDANKgym6CarOccflyoyB3b06bla/gJxXqI3rhjpX+afHdCe?=
 =?us-ascii?Q?cRV7zXvpITCV7CnbgqUSF5XtJytHrQkME+4S7yltrZS7fcnRUHBCPLaXJ5+M?=
 =?us-ascii?Q?zKKb4PhiBfIRSuqR9dGKZCQok9AbG36uGeqprRg+EE+ND6+qerJ0Vw27QFtj?=
 =?us-ascii?Q?EQm8wcssjiKulM9VNDj+L5IB32GOjbWMfU0XzYa5yiJk8+LsLdD5nvRFF7QP?=
 =?us-ascii?Q?h+PY0hd1aC2Rlvq5up8nw4kZUTOdNon+9MeNNP1n8yVvZufYxXapCXpG05XB?=
 =?us-ascii?Q?/g/0utd2IMfsj6wViDXChWoXFj73n9QJ4ykam+vGMR1QacE/FsUATgIPidUC?=
 =?us-ascii?Q?yWr6Df+TnRc6y6GA2+E9mmdHiJTP943t/VelWw3MjxFImDPszwyd9ZPZGmyc?=
 =?us-ascii?Q?rqDsGp7enwQ1K4455E2l6fBXQPHHGaHzJ+IYzPgJp+75IfdTMp1xYS727ePC?=
 =?us-ascii?Q?UEmX+QIeqz6wgXs3Hxb3KVIW24bxkHXa0EQoRL27fvHB9AL6oks57AyCdAFP?=
 =?us-ascii?Q?fUISMmn1H+4VmpDKHyH21fR8gVoUg0Jj/Tv4rWPUgvC9A6o8943Pn5sEYE/o?=
 =?us-ascii?Q?/vMppKK0DUGMZ8vi5MMS2SiZpK6xu4WnRcRLC5HGEQCtJnl3P8Ei7Tl3DT3+?=
 =?us-ascii?Q?6kULUM5oErqiM75VgRuf27ZcgyFt9SScMjMrMaweNs5mWNc5GjvxOdWNtWDs?=
 =?us-ascii?Q?w5nfT3eNMdZQDLkJ+Qi2QIc3ErL1Sj5LK9TXIt0ZFZ28s2nONTCCsoDPiJMr?=
 =?us-ascii?Q?D/BJ0cnZYiMUpFs4zYu77TwA/4NU0p3R5SmPkQrb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae866d2-09e8-4ebe-b3b2-08dab65e6e03
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:56:31.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HFUeRK/LkCFnKhTeg8bIYrbzK3embcSEeWnrdVUpM4uRO7dvip8HmOqC/PMdLxDZhH7FTa1cK+89DuQE3WZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the local 'err' variable for readable,
no functional changes.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3fa4363..ed247195a20c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -620,12 +620,11 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	struct flush_cmd_control *fcc;
-	int err = 0;
 
 	if (SM_I(sbi)->fcc_info) {
 		fcc = SM_I(sbi)->fcc_info;
 		if (fcc->f2fs_issue_flush)
-			return err;
+			return 0;
 		goto init_thread;
 	}
 
@@ -638,19 +637,18 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->fcc_info = fcc;
 	if (!test_opt(sbi, FLUSH_MERGE))
-		return err;
+		return 0;
 
 init_thread:
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
-		err = PTR_ERR(fcc->f2fs_issue_flush);
 		kfree(fcc);
 		SM_I(sbi)->fcc_info = NULL;
-		return err;
+		return PTR_ERR(fcc->f2fs_issue_flush);
 	}
 
-	return err;
+	return 0;
 }
 
 void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
-- 
2.25.1

