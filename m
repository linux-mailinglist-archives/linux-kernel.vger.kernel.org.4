Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926C9749B64
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGFMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:09:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A180171A;
        Thu,  6 Jul 2023 05:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA2RCWLuzV3lLr7GMQ0I1/0tMKMlKyJ2TbD41Z0zwiOcIQ7xmdYplIW5i9BReoseI8ksqLJFR7YidOyMwt3tOL86kPPR8xlAC9I7BbS5yUIagY3qNJ27RT2U53cYWePfj96x5BvjtwjYf7lBej2F2d4LmQKUkZcGMri79EK8JgXOQ/7rcFSbwIWRYb24U4LU9rH8vouGF/7GpFjg26wRG0UjhPkbWIHTvjfceaG78AlE+j8a8TWjklWaK8jTEivpUalA/UDmCWYlJRQBEiIGM0Xlqcn+WpywLbZ/LbaMSzhtzUlnUrUv7qk3cVFKxxwTvTVfn7teMDSvujYqcmSXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIQFtyrZI7r77TsQYgyiBaI6pBVrzhHfNhyoBtEs3u0=;
 b=hzYMMPZBYDB9ChOwSID3e7TX5FJo1K3aeA/KVspk0ys2buLcu5GPaAtHsyCtcFp5ytnXgtIEGFq0uCnuwKJqgjtBOxlkagDzUXUsa1Hnz72K6ycvKNxna+YrE+8YUPMssJ64ZSqXjnDnD5MGHKfO+1ws2OmMVD0mETwvD8TKzkEbJnaWEaaW9O5/3kPtuiXeDbpro2E7BM79733Nlw9n/8yMuZB08msaVQR9PNN1QxmQ7s8wHxhrsF40xrpEafsE7h6BjJ/H1T9NC4m3vE4U17pYEmuWc9cHyQZvs3NlxPYComRLPXJnVY7hkYEae9MKYJMHYPGAPFgA8fdyAPE7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIQFtyrZI7r77TsQYgyiBaI6pBVrzhHfNhyoBtEs3u0=;
 b=JFu0CWLFPrttmzpEFcYXtlolfGd5+HHClZTb81Y+TBysErwQBGPaDCVT3GO14x7zzBHUnEcbEHCK310ua3KJ8DEm3Xsk1SQeuqLomDZutsrok9NM9yQoMRn3yFL19znjd69tTs97sClexcG0c2MCZm0WQOxA/hML1QFcw+NxrfE9rGkedaBjdjVULa5Q2y3Nz5eg14Om8XfPoEArT3xOzEq3lHjL5EnNowYBJSPINlkaOoRG1AW4mDM6l0O5GK6JR0yOOH4J756/D5kntwp/up+vs+/xCmvxkShE8gHfFm8Gqo1pF4Wzzl8au5jv0dcNrYZhaoWDb2bKGBcBfdiS0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5634.apcprd06.prod.outlook.com (2603:1096:400:278::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:09:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:09:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] net: emaclite: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:08:47 +0800
Message-Id: <20230706120850.11026-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: e814c854-0180-4c4b-75aa-08db7e19c875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1G37IJmceuO6UMQin1Aj0oKjw8UO/yFZ6EnIePBJYrHtn0Kb0cEO4hZUNG9Ih8nN99addgEHNUwEmAsnieFm2NwD6hZrL+zKvViSggP+CMaHU+2kJfvPuQXUjIhX3lA6/SkdHmHU4nTUD7ucTD84nQK4nrRb/lSGjlEKAm3ZnOt5ZPVIZdIqKY2Np1J+i50168NA0z4iaj+LZmivFicruqpRruRRuie6a+gUuxlGfVVyoFMLKht0No78lFJt0q4+hfXx9CTxu4srHY8zKQlTILFGfAAJhCM19GTnZhZESKABzWJ0a2AIfyZA05A+lkw74RcJK/Io1lpcoz/h44pNrmwJfWWuXrVzmSjOfuDMJObXgmMq8k1fYZXxoAqjIHhe91ViZrAy2TC4RRJPdYfVNawTg1p6hM7X4kds5b1Ma0cISZQWIWIqj1rKou66bRdTEEYQ943MvzbLVadflnwh8SvXgmfaRTAkzSga9TghlzC4hD5bzzqIe1qXY+O4tfP2mSZTJQRKIqQNw0VDM1lKM8J4mG3grRjz5nySlYNaxz+6liSkvrh+gYKxNdiksNHvXvZvieGCFFwpQbdWFK4r0R1Y2VJXNiX0pSG/nxI8owr5WygDzQnbmhD0MVVwGlFh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(6486002)(52116002)(478600001)(6666004)(110136005)(83380400001)(86362001)(2616005)(36756003)(4744005)(2906002)(66946007)(6506007)(1076003)(26005)(6512007)(186003)(38350700002)(38100700002)(8676002)(316002)(66476007)(66556008)(4326008)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7JNU+QfwV7I3Me6vjEXua/CPLJjT6TE7mF7mMHaaoGl2cHeiph/fgQ407OW?=
 =?us-ascii?Q?qLIJarOn58XJ4l5tqfvSad58ZkY4ZyRqNztehQHjfA8SltvucC/Ilay13kcw?=
 =?us-ascii?Q?3+AHdBWLr544aaTBnus7AgyS8UipsW07Zh/eo3zF1VbFq9nQRCqyDDQdL/e5?=
 =?us-ascii?Q?+iAzUz+Td7jxHsy/ZAEynDdaWbMnmRESa/HGYGJygm5e36EIropGQbfU2iOY?=
 =?us-ascii?Q?c/21I8ioWA3vmf3CeSxiI1D0NxRgx9Z8BlVQMzQHH/MM+ApUGmTNOn9RvRrH?=
 =?us-ascii?Q?dHeuFJu1jbx2NHDUBSy8AlSzwLe9zkJa9r49aDIAMg7LvIsMsAqUtk2YgI7c?=
 =?us-ascii?Q?VFo0Xdw4oeADQtdteFF9xd99BedjyyhSbXX8j0xwThGuHTffEEpbIuVNkfa7?=
 =?us-ascii?Q?k8rChLC5F1CbaddtIuZtQJm5xYbBhX1FsVJYx+KEP55xpbGIsPm2J1YAPR0c?=
 =?us-ascii?Q?20sBwo8DOTqH2vmppMuszi23KTCuAUe/P4JyXB2oCNsjs7lqO/h2b3QE8AFD?=
 =?us-ascii?Q?p81kQNGEK/vqJN9NZRgVKa8NnweIXKBC6LAYDvpfT47Q+a/NVWfVKidBnUiS?=
 =?us-ascii?Q?kbaCVDz+mqf/Y3liT0N5LIkjG5YSvztCisDqiXukfr2CsRV38RaOAy4Kvgxu?=
 =?us-ascii?Q?9GBbAMvGBziV8uWZDL5RNxU7DaJ6DtI2lwBUlVUNmROtDCf6XFrtLiwG4CIZ?=
 =?us-ascii?Q?T06McJedK9PKtUjha4fD7qJmukIiEXe/IJxCimt/VPGn05Rp6C+CIxmpzgEU?=
 =?us-ascii?Q?EQdk5Fp6i2UQxD56k8IiZsFpHIat3VdAJK3fBkQQRTsMS7EBkgdcD7Dt5hnO?=
 =?us-ascii?Q?2qPdqWOhpb4SgNUUUTRDRLNHa4kOfx3O7xjaOT6cAFPcYLnj0/78pDbRAbAI?=
 =?us-ascii?Q?QKk4Zz1V3APVETbS0XgRjheDicMNmifpv1f84PZO6fcXjGz+Bav69T72sOyP?=
 =?us-ascii?Q?cejgzkcLdrT8fOwN42FtKWPUIv6UDnQW3jUzRcdMYhgnlpgWiLd7khxvadSM?=
 =?us-ascii?Q?v/RthOA4DRhFnuLm6fG+jt/vHtHhsDpFCn41EtgM2m1bM/3vX9OhSIswODgq?=
 =?us-ascii?Q?HkCOYTTICj01Cr+PyfsPI1K4qfI9f3Y5P9ttA3jccebAdoY9oYQUJRAFtume?=
 =?us-ascii?Q?fJzcFnrZ6ZhAV07S31+0wbosmE5qkYMhh3rMul/cGh++rSJZu4Iz8c6PHoco?=
 =?us-ascii?Q?HSCyeOtBI7RmI47y/fasuqnniP94dnHaIJN7inHqKvSBKDYOcEkAVe6fgr2x?=
 =?us-ascii?Q?f/eNKOdATyXjrmeFUWFsnBYhyfU3au05f165yp/ulQ1mmgF045s/Iz2mczmW?=
 =?us-ascii?Q?82D33p2TaklX23SVzeHFXeRgIDyMmACzp8CEK16AvwTz7su6lFVIHT4VV+4L?=
 =?us-ascii?Q?taNI3jqHcSXRq1q61F3lNbW7lc+WjfIb1OPHMzT6B3sOIxReX6htxfjjIgK8?=
 =?us-ascii?Q?uIBdXK9vllg9OPPfoLrY5UXgkhyRqQwxQaPGi5Da0HcqQJjkyRpI1VZFCReD?=
 =?us-ascii?Q?5wIGkTabCk4JkL8fUAulfJMSuP4vWXDzPTmkI0FmkXHtesGkB0C9Ib6jINVm?=
 =?us-ascii?Q?/569RjqxbxT2t1TN0+bfoZl10QT56z9VE56cs1bT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e814c854-0180-4c4b-75aa-08db7e19c875
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:09:00.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIBl3Uz8EISM/ZRnvpLNsqo25KU9/YymQCoxEp334lxXfo8EWY8zJQAN+ZGbyTIM7WIl6YuiBJEzqqA5OJlEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index ad2c30d9a482..3cba947e4cbd 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1114,8 +1114,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 
 	ndev->irq = rc;
 
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	lp->base_addr = devm_ioremap_resource(&ofdev->dev, res);
+	lp->base_addr = devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
 	if (IS_ERR(lp->base_addr)) {
 		rc = PTR_ERR(lp->base_addr);
 		goto error;
-- 
2.39.0

