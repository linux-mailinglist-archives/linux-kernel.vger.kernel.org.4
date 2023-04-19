Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395B6E718E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjDSD0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjDSD0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:26:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C7CD2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOE+dzP9MVmKv8ZVuY3O8dwg+EX18mToTNXPMvtXdhbcmht1OGj1Ra6XaN01adfo5BHsNLTD3EzWC/587HPbls6nQ74MnmcT0VdECwLA7mxKv1UOYEtgh+ROQ+BliheRXMpqsEjaCsDWUP7EVrgB6TziBFKtP16MOg5s3NJU5wSZhTie4exq6Mywo6+1uIspevQyaQNz11rTKMPWNrOAX9n1P+igppAdTRZx3nrRUDxGCOvWTgap3k1d7wa4y0d3wTpPIuXkQroR8CW8IE7MW2kiV1y0f3Mfp1zSCZYAspf1jTDP4d4SnAX9XI3SOIUuw7csFfOfu8TOQ7S66Uw1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjHzi9FD0wWlg8TEYTy6ZQDafhjTGwCfezsR+jsv0Tw=;
 b=Kog3Y9vGQrBg04NQzMipfoMRfQyyKNHB5owrYjPrmbnIcGhzy/TR4t6WuC/6Tjwef+8InfLVAVQcs7Wj5heTOfl2yHmj0jjvBHyI8isbRAOWkPeZHWEuWd4vBoJoI9R7mxnnDJyJDfYlp4JZxwkBYlFK6pINgg0bpb0gq2BT12kWOiQ6rCg1oE3MVEW4+UZQsGPJ60GYl19sDmlazhjQGkwtOcFklI/WPyIOKNhG9w69vwbQrRrTWE257u6H1uBFjfE3wyBYaXeM+vSFZL52PQAenAISm2eGtKuoG8CDXaqOaMOA4BbgmRItry9F1nINSfsJanb6wlqfgD5JA0FhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjHzi9FD0wWlg8TEYTy6ZQDafhjTGwCfezsR+jsv0Tw=;
 b=qihesdGykmB0i020UD7vBudSKusn5YvdXAxeGZyNUWNrCbarCcBApWlynRvqjb0KXpCmWFXBQsyfnlImB5pNX8wSmS8/pQWziSKjWkiiOG0rcKJub69bO8zPz2B0rD+8Ch5xavyq+9CMdpdfQQoKxvv/a5fg9JDl4LIMI1WfItfKxNEOPJC8LkKfrp9g9CnBecYcvaUJM9df/BYO4fZoGQCJnk3Oo/8mNb7JGzJ6GI28yF7e0gT8FABnxjf32Gyl9g+9SZ3hIbWhyvqw+voyAHAgUyoJbQvm1AcqPOIzG1kJbiMcYplHNqTuY4yW87LzWdTcrBC9GNHPESog1eqgbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4151.apcprd06.prod.outlook.com (2603:1096:301:2b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 03:26:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 03:26:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix typo
Date:   Wed, 19 Apr 2023 11:26:26 +0800
Message-Id: <20230419032627.15421-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d489d3-5c9c-4818-8fd5-08db4085e3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUP56xiZ6KiEg3/RgNyHVqHPwzGggOQbR5VdsOlKcSwqsShVx1dfcuexqRr8B2H1/92lMvjGPDDX/xlwksQ/8C2Y7wDeWQYksqnLwaKiFJS1SB431yXTxY41FdhWiI/vPEzgTCIveL1Yz3DOeXXebjYhJarxDNv6WR8RVibITcuIKE2RyieO0OE/yBQP4kzvpiUbSfkGAvk0+KxDHL9/qMkVvKuO/3G05k8Sw4MQtyEsp3CVmg1Va2J4O41VqhMOQUJgEsxlsqwJcxFxPSzxHZtJNn+6GbE/sKHGlR3yYU1J1lrPn1hGFI6rNilCh3UmMQWpf+BZ/Q7RDxIKPltcY5L7+m6IDyci9Dy2eQgkRMU3JDR5hsGmKkXBIPtA8rvamZqX15TkzV3aLrot0cCpDNXvKiDvCrPyANSJUAPmgPj/WOxnj9eOrHqNxrN91Fp4YWv7p+Pjv7Xmto+wzETM/RNh41k5c0OOnGbVRM3J6Hdh47E7yj5+35C7J9EbXjQGu/0l2KTHm8eLynQqGwBhh9qzNBC5d4LTVIBAEL2hJ8xVgQFPgmBS4legjeoLiK2atK3mFMV+m3zQEx1kzC4QMmY19OWCkaYJKa3VGC4jV141Pd1+atrUBQxN410R/J30
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(6666004)(6486002)(110136005)(86362001)(478600001)(2616005)(26005)(83380400001)(6506007)(6512007)(186003)(38350700002)(38100700002)(52116002)(1076003)(4744005)(66556008)(66946007)(66476007)(316002)(2906002)(4326008)(5660300002)(8936002)(36756003)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i33j5wdNWCxEsOFmhHqhW3TJnd3jhMADr8lU1TL0iqgtnp4EAoaVUjz9tu5j?=
 =?us-ascii?Q?s+XGWscLNGvW3PHD67xulQE3KR3ODi3d2MzzjONYEq+E1NL38BXFCLV1KBfc?=
 =?us-ascii?Q?Ir1Rdgv3YxHiQDgfhUeao3X4kwg3kxaxvpJ3ec+3Kd8tSduo2+cTosQB7Yjv?=
 =?us-ascii?Q?mThEDXgnAMmzKpLSn3b0tCeZk4U/G0WvoJlPx6uirDh8d1Ujp7WkDXy/y2ro?=
 =?us-ascii?Q?ci9YZbAVQ5VsWT3iVWvEYRTe97P4R9bMqDVRDZ4SaK4FItQVACSEUXXY5xWx?=
 =?us-ascii?Q?rehZdh8DravJ9tRiystOqaGabtuygr2iNmwWXMxuz+wA/iqmf4Uid2l67fjb?=
 =?us-ascii?Q?XT60ZhdE1XnzPx00/zBY9+Lsi+dhPajo7Xjm/Bwz1egPTDjcnDjR4THW/R6j?=
 =?us-ascii?Q?F8qLcMCrG9vD29Jh00pfB3fIUhymkFJLtLjGsikT5fa4hshp7nl8j7Cgff3C?=
 =?us-ascii?Q?qcCvgoj07ekcdfqHK4i82bJe0+H2DDVKmdhmqjj57ZJ8UfsVBprNzfL5pGX8?=
 =?us-ascii?Q?qaBEMN+c0EPdwivb42PQe3j8qLTRVvJJ7keVrUVj1zVUVJ8s1dL/QN908gXh?=
 =?us-ascii?Q?y/oZ1l2I+A9V4o+3f3Nmd+DwhQHVFRmOvhi22vz07gg4kZoke+EDz0ai0Len?=
 =?us-ascii?Q?O0mQUt07Zsb2N0ZmIGK6rjiSVwj8rc9xzN183RCjfA6IXc0Y1XOB7FUxAzUe?=
 =?us-ascii?Q?cr+erZrG2fxFamgsEdAfaZ1BRlfjeG1eDDw5KaGv1Mvjj/D3qHTLDHInhUbS?=
 =?us-ascii?Q?6qLiNRHp7r93im77YHxVf7wdClWWBgKo0eiAsjyJvJXQWnQXnclRKXGauraG?=
 =?us-ascii?Q?N9SEx3JXhMBqeQPck/TZ/gedvpdDpTVpbUU3mzRaKQIkDEYLIfUR+AjSmNbw?=
 =?us-ascii?Q?OJW45VyfTrGNoipzbHvhEKe82GYDeCDZq/Zf4klF0SrcyzY0tPi50ZZSkL8C?=
 =?us-ascii?Q?i+MimLFkn9emqwdQsJ+G01l6UkGYi6jrwG1WVNYDBTTLj7kh+UwXIS4mXTqQ?=
 =?us-ascii?Q?t92wizSRbsZ2gXnWxKyzu/TeeA9KHzNLewuTfxHfWGOBaS5rvwl0YuQ6S36V?=
 =?us-ascii?Q?YGZy/r01CSMBes4u+LBYylRv05vagP/tWU+lLEcOKH2Aj0INg/zwn8zQBKeI?=
 =?us-ascii?Q?W1jWosV/IMRbqtaEZUwvgaRuDST7ANSuNI4hfyOpRRIMus0ltLSZsvxckDAC?=
 =?us-ascii?Q?lMqEiHU3NnCf313b58+i7C6jzo9hNOHiWebUKyEqk/98jh/eL8LYAvSXEwgq?=
 =?us-ascii?Q?ZynoWAu22OZzWLrRSMmhozNVxq1E3wwwgj/vbjI6bR52ODqxNKP78yNUbVrX?=
 =?us-ascii?Q?DaCYfHHXkh5CVhd/HD5xugwjilgR0XHgPhhdMFpKwIa8JVkBOhDpliDcyyNp?=
 =?us-ascii?Q?RCnPYGIoUypZftctCiARMcZSmHS8crGZQ+IPhzItz85oQOAYZMpe3O/clArW?=
 =?us-ascii?Q?ghQniXaQAOiqyRlswBvd17tT9t5haJm0ejC2XE3X5uFTRkA/L+wuWY9fifmo?=
 =?us-ascii?Q?6C5V2cLmeQ2euKGgl533q3aKX00lpvgJHcrqwJpWX8AmAnlysLPY4Y2rw7nU?=
 =?us-ascii?Q?UZmUZ7u/dOJo3+TVkSS2t4B6igD1CfXz+kYnN0ws?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d489d3-5c9c-4818-8fd5-08db4085e3ab
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 03:26:39.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLt0GLn/0OG/2nVjMjb2/c3MYIfGeqExFCmCfN8+HfETvxj6xTB7kiptbNMXCtOTOYlILrsP9/7KNP0tr+hpVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing 'is'.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9f15b03037db..357d45e49635 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1362,7 +1362,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	}
 
 	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
-		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
+		f2fs_err(sbi, "FLUSH_MERGE is not compatible with readonly mode");
 		return -EINVAL;
 	}
 
@@ -2356,7 +2356,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = -EINVAL;
-		f2fs_warn(sbi, "disabling checkpoint not compatible with read-only");
+		f2fs_warn(sbi, "disabling checkpoint is not compatible with read-only");
 		goto restore_opts;
 	}
 
-- 
2.39.0

