Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5960B313
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiJXQy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiJXQtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:49:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4AA1A046
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsJViV8/HjFW2WV2SYfbE007eeBp5gHX6DtJnjpp1aO3f5GMewMdknWBg1mkuMWVYQB0P1HytkNdQ0jnbyJ3XzcX6801s44LgeGEArM0bwXIpBM/VwuBBUpqLw8S3vYmGPnqU8544Nca+okL3m2gZa8kW9czsy/sXhLT/HH/ZXKdED9IyjfdSZeJ/NF7oIEbrFiplY1FdRncloZ0erXDtFNGJC1cUSDHFmHicXYUNvU1tP2+vkGEM9kN1fHByxv8udY+RACudhsA2iN6mAygqs3zV1Stu7qPTXmzsR1K4XO2P2HxS3WJZJNWQafwXc2yXpNcFqC6IKVYCS4jhgEGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulipJIhaT3hGFhk/K3//OPFdqFauYnBPGVD6HLEz8nI=;
 b=WTspfrBj69X2oawCHY+ThZEIAnOEaTUy+dKrccwE/vuSLbVTuXp/BB0h35JNVS6Drii8ywHbyw7yRQ/HnJ/7drbovnOr8rSk2xz9+WF6/0Smt3UkrdI/DtQsNEdLgXZCK1BUZT6Xwr5Woup9ohBXBYaWwScWDCZsu8aw4qOYPN30DvpXLixdvTbtvtyyro6BiX1YzRwxxIqnVxD+tP12gGuW7rKd4rdemKksUCd2irne9gIsMKZMwjBpGQWPtAgWtFOEsvOyUAUa+Y8XKn7KFemzmx1ZztBTZXCD+SMuqNQlbIbGYnPQr/xjH3e8kouBt0rrw1bJVN1rxy7yrDx7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulipJIhaT3hGFhk/K3//OPFdqFauYnBPGVD6HLEz8nI=;
 b=grcR7dozbOnUJCstDcAiGHrwOSL1IDI16dHgBcg7KfqzRnITHRk6mp3GzBL6Jr/uhp1PMqmMC7saRjCGCqOtMXSnz7q4gGYYOjkAfTIqu5mcyMGWSWc79FJtDT1+UMArkmGEiihC2zlrWmP4QaCD/fjMZwuXGQSVpbEhwn1FJQ1rEFRCuEWBxhVzpf6tlCwNzMXT98g0D3LrZ5lXRQ3bZ8HXgCRhF2HpHcyZTHQTtHFgBifwihF3hkGX+gk445bGzGssjJIxDnJZqeFe7jeFduKMTC55P8Dn2JWY54aSVmyxaKaGaAgy+b5ooPxrRFU+3qLImadUm0+c4y+eIh83Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5113.apcprd06.prod.outlook.com (2603:1096:4:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 13:59:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 13:59:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: remove redundant return in f2fs_create_flush_cmd_control()
Date:   Mon, 24 Oct 2022 21:59:43 +0800
Message-Id: <20221024135943.76120-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::13)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3653b31f-ffa7-4f53-f659-08dab5c8061e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6NCA9A0s7azgFzRtcbaGQM02/kQEBpH3x+kgXmt5/zd+wSddJvZwgCt2cNZQIIXXVYB+ljmSC5Bqtt+jedD1ewdFE+Mp09upfbr3Xc+FmgTJzVwJMB6gIFyBV8WsFMU8tBoZE5GIAaLT57kkSML0AXdwKzJyW1XDSWRfs07eUUld/CcfEvexrasBfuqB9osyCJSXUYk3y/fpEFwJGplH7nRQu+8l7M9cDPuxqsufDwO/0eOZiFdBzZ15LNRJYM+hVVEqsuxwU0Px2rHJm3KDa9i7rDsFv/v5JUt24bgqor0NPJUXeEyF75E3ZB5hm/l51XluBhSQW9gkZLz9IlYF18YBDGuVRGFYJEMHu/YcvZZeG4GDs3k1UmbwmUvSXrY1Hcm13xoNniBAXhyxmdky4ek4Ixg7VUvaiyeSBUWJEOdnB3bObImAu2Pd1kQKMSWtRUjhFcTCUpLbiSbsJeLBr7+bhW/aipJQrVXqTt8oBAbde//KXKlOj4ZyMVZE6GCs6LrCWvl3SicdIDceTjdiIxPKLvhdAkgA/etczFS0IreelsSfdtBvpe/EQVgce21BkvdqwxpjjlEcwqPNjyTxsyDkzo/DnxRQMxFr6hoAelrbTS9wlHLet7lqo5sMYjQ6PAddAtvJDa3qXfXwhsZjBEYl7bLd+RTdNTrfus0pGp9mmxXOSxxaBNxioLTiMrnr7HUsGtsHj+fclD01+EDfNb2pdPYaVf4l2+MPdFjMne+GTLznvbpL2spx0NVnNL+JVwhUmCSzMvC4KFvRPpglw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(66476007)(4326008)(316002)(107886003)(8676002)(4744005)(66946007)(5660300002)(41300700001)(36756003)(52116002)(2906002)(6486002)(66556008)(8936002)(38350700002)(6506007)(6666004)(1076003)(186003)(26005)(6512007)(2616005)(83380400001)(86362001)(38100700002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SUzGuUIXgR3HckWg8/s+weTBiRQC0LUoRRdN5De5CFWW9pHju4LJny5oV/88?=
 =?us-ascii?Q?Bp0dLOplPDHLW4fm0vhmHKOb83xQ2d+xELtR1OVgOO5oB3I+smfi2C1/Zrr5?=
 =?us-ascii?Q?Oly9cHYB9guZLaSNvurnKvnBWZc06V19SxiMTCEFQY5HKEQdcyn4ymyLM0Ct?=
 =?us-ascii?Q?sY8gRIpVSu4RFSlVu82wB3LbWAvrSkZ3Vn7cuiNoFoFmw2Ra6j3jKwRqbknT?=
 =?us-ascii?Q?9aLRdEtuusNqLCu5mOlEfzUtsDo52I5kB9tUJm+/HpYa5UKW7qkOoobRWHV2?=
 =?us-ascii?Q?h7cEB+XEgPHMaBnPIp8UsyrBjOYy5pLZMeOfpetgcD1FggVUiuKDX0LRmrNQ?=
 =?us-ascii?Q?wDEb/GWP3djOebHWjwELRueIEXwzdRGy6H+FiJ2JqNxPJg7J8fAjFOyyZh4a?=
 =?us-ascii?Q?xP9DR5o758O4HYdP1GA4yZTSWGdApw+k1tYdclzuEARgonUkJSS898uhdI1o?=
 =?us-ascii?Q?qkwtDGsZvImd8lY3yiIbEMmnBi1K+gJ2P1djSG9UPiVhub7qUkdy6PPjRyYv?=
 =?us-ascii?Q?mKeXoKzFTzVQMwV0AlBA3vwGQ1B3Ahm0Pf7PCR2cWNt1s7b00CdFZVw6PTNf?=
 =?us-ascii?Q?E7491x6G+dRhCCo/8Bis7o6iec5YowG5dTJEzCuvgTqybtpyczqByzO+gAnh?=
 =?us-ascii?Q?W6gn8HeYP3peZbYhDViVylzp05Wrt1OyoRbyGc+0n1Q3z0aSsVcbHUp8nM9r?=
 =?us-ascii?Q?A8eHdgdHUOK+NeQskFe2LGe8UXWNFZJHsNmnz9Br3njEPD+Qc/9+bm9GWJGc?=
 =?us-ascii?Q?UAw/FINsOX4yMHUjpIHsRWM2uW4qG/rHMvidXBhk/jyrmO4GANFS23+M960R?=
 =?us-ascii?Q?1oCdZUV3oExVS5A/FsyhNcG45zcIPnk2pO2IyV53X9p5enro9jdQMzeO2CfX?=
 =?us-ascii?Q?/Dp7UxNVtAAl0SJqyjB1vGFVA0PpLaA7Hf5iNfkBeWJxzWWqL6PYrlYIKhzK?=
 =?us-ascii?Q?R+Ox32J3DTN5udxNGSiSLWA0HECFr4uMyoMM4aMSQXl/iNKCTE6Wpthv1JfJ?=
 =?us-ascii?Q?+h9jjjGTbZmHb5iTIybSV+4l/uMIK4JL25mPkuzk3WKW9X0xzsJtXvOblYzf?=
 =?us-ascii?Q?GpVHM5++Hl0k/rbhdBmLQ4nKLjWDINiat4Dk3SkWExijh9LqRh6/gdiSdorM?=
 =?us-ascii?Q?8yMuXCeNOPefQ9HXivst6gaxtDU0MhTzRAsO/2fdld1uXJRWx01zXGcpI8vC?=
 =?us-ascii?Q?QdgIGvOKdPvxErxFUtkLADeMZN9fIzPU3bUXhpan0iRPswzCuoi//0uOLAOR?=
 =?us-ascii?Q?SRV+xyHI8o49NTPRsMyNe/p1AAVuNaPlqjDUWlFdiWt+getXsDtiusPIK8qA?=
 =?us-ascii?Q?9EMQClZsx8VMIhYb23OMfkwLZucRXR2bWzagpWGvAA+t4FXmjZoyfOujDiUv?=
 =?us-ascii?Q?+W3smMy4KMs4XxSgDC/MQ8L9DgM9TWRcXE5EHGUppPr8iSCRKSvQJLAx8pTm?=
 =?us-ascii?Q?E81Mq8qx9YPPbqLsSwknLplkdkFXC1dAwXD6QfAnj9Ca3LNCBpwVm57309AZ?=
 =?us-ascii?Q?kPR77dJQuBG//VzCPbEqA8Oke4q3p+1GypcEXW4aeCAmIK3ggCMF84pPpplL?=
 =?us-ascii?Q?NVIkGIQBA6X+dFOFW3eot7q6XiJiGft2zsEj+yq6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3653b31f-ffa7-4f53-f659-08dab5c8061e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 13:59:52.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvNv72Ric4mwdA4VEBevAGvhbJJ7NBYCLzh98ooIWzzoYyp/FUOSLBDSiFZPGOnyyaiVEVIHwZaHzMgkp4vjSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace
	if (A) {
		......
		return err;
	}
	return err;
with
	if (A) {
		......
	}
	return err;

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3fa4363..f6f16d691226 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -647,7 +647,6 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 		err = PTR_ERR(fcc->f2fs_issue_flush);
 		kfree(fcc);
 		SM_I(sbi)->fcc_info = NULL;
-		return err;
 	}
 
 	return err;
-- 
2.25.1

