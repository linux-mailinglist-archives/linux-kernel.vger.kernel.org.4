Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20CE7506DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjGLLtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjGLLs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:48:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1261BFE;
        Wed, 12 Jul 2023 04:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl98D57hJ/5T88oDFw7XmnopbiCK5MM/HA7xhzDdHA03f+7HNxuNlzn1j6GmGsrRY+tF8q+7vBBVynb3pGxjPjc1Tx1n9uZyl93uubz6xw7ohpUJLV66RzgUPQrBXn9TChNtA7biZxP1dHi69Y7YSplRIXNCznYXWfquOoS4+T+TNIrPU7LAKnvuJlQma1xskyI/rkgbcwY/NFeuwnJS2/gW2f6NyCtu/UdltBMDcc1TW4ZpTr3vK0tCBXGFolc2gGE6aQypjrU0U8ZeShMFPb0tq3rLs5tnDPWkxqxNsuJapKuoPEucLvAjcj2hUqltRSY075KO5HZv/O1D6jgT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIwbIWF8cEM+VgOSMueWzfiWGwvQNR3AxgeuwoxzVWw=;
 b=k0unNuWXmnge7j4/ycby8bxEFxXpqUIRKdbMVLx6/cyMdFTof/mNjKbh1QKcY2vkV/9W0YFsAiEJH+tQVJETpB1v55u7LkenAwvLypvEeWVrKcSXlEbbQ5Rdb0vueu3T5w1kbG/lSsI6ofz2gtqk401flTV/pqeQVpt0mTS3VwfdlCQqQgt7bPggCWhe6ZAze/MDPkIbNA+eglOdP+7khcHOb2IXSLtBuIrnNppla2srfE/7Tkfgnh0UkpOpk5//VwVhF0/5JGMj43Can7YDAFgE/1GpCiN+zvQtxqOUi1Z2VDEDSlxYzVbqsH+GUQlV2WXQLH/nGs0RgUBHDZw5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIwbIWF8cEM+VgOSMueWzfiWGwvQNR3AxgeuwoxzVWw=;
 b=Rnl12+Kqn+2rEbvRgVQhx63/GswOoqhM8c9VV9+uLkaDWtfD73VrKb4sOX8LWaNHApTfZgk8bYbL7Tz1vb4cngW2vHPoXh4Au/8JB+8HdeH4LGgOyl37sFFJM+jqDv9TgormEXl4vK1lGNvz218+ezlpBH6PmW00klu9C354XuyE0XHd985IAF/D9MOfvjAF11v0Prbxaay8nteNZoqBliKPJEvVInOvFPBQKcaDpFIP5qRzYxM3n2OsPEwkRE7/zZ61xdxm6TWnLbV/b7B6MSGd2y/x/WH8RHv4jsyT/L1Bft+8hu9ohybK0bjPOS0AifeeZgOy/tqtFTr+Qn9qjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SI2PR06MB4537.apcprd06.prod.outlook.com (2603:1096:4:153::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 11:47:56 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 11:47:56 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH9K
        WIRELESS DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] net: wireless: ath9k: fix parameter check in ath9k_init_debug()
Date:   Wed, 12 Jul 2023 19:47:40 +0800
Message-Id: <20230712114740.13226-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SI2PR06MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 668a583d-cb47-4298-f936-08db82cdd513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZ06optc2JmWx8v2s+wik1I6zfHg+Llq/0qEAFSF+Yf3VmyDMQ42T6uk5q5VvS5Cy+nDCSVHDPoH+gtIRVh5rP8seIHFMK0tz3plPknj/iBcq9vIeAX9AUIW52nJUyZKw60MRHZBmgwnfymrTHpyD5nwqMqOed9ijnP1WG0BRoLvpC+rPdDuXvvUTi3UAADkv3TdW6v8OMXGxw584cLQZXBaMas7nRSogbXWnQUNwBEpAkgMSSMsDJo5DpgDSaL5G805uyLWstGYC7j7+BbWR5D2g0+U+P4jAlJugHbG/CQKC5k+NLlUBNgGY4Kkz90eRMkkPwirtz0VNkHsVSyyKzwappINmVRQtY4FV8q+MqlqHOr+YOA0X9qcdtWmgAdJ5F4KeRwLHXFf6Rp4kVSNqWbjaa7CI5uwFuBd8jdpFh2baHYgBJpXyckXqStJjnAftdSOwPqckqxKuVBEiplm3KVKgvTkjfTjBqTZfOzePB9UL6nn9If7r6bDSq7+5A18fdyZ3f9SgKWa39EfYHTwnDabJXnVkCFKfvSgEkf7VsemMpRaexLFL4pbIhT9sTK+su6+dJFklT7dh9JMYF6gm/Y60ffGKNy16zMBcgJa9xf0e8ncSbtlkkBwX4QIMSZu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(110136005)(52116002)(6486002)(6666004)(478600001)(1076003)(26005)(6506007)(186003)(107886003)(66946007)(4744005)(2906002)(6512007)(4326008)(316002)(41300700001)(5660300002)(8676002)(66476007)(38350700002)(38100700002)(8936002)(66556008)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sVH7rGTAB2DzfsfJL3TEADLccoLNn8gQsI64GGg82b7oHsjuEpn7Wh4GQm3?=
 =?us-ascii?Q?yiBoQf/S8yALppJlheD9PMRKcBLNgQ8acoDCWEG/c10PoAV5y9RwVeoulx2o?=
 =?us-ascii?Q?fTvEeRi2TBeGnhX/Hk9toJp6JrNohT5XiQ084DW0yt4pXZSKZp1f4tl8qKGi?=
 =?us-ascii?Q?8nDunszD565/e7ln/GgX3whSiOLnGZDEuWjieCWLAmrmC83p+kmA6h59edRY?=
 =?us-ascii?Q?594Ou3G3nfN2wa6W4XGYvjAdTXpDgMLhxB2wgDj1/VPNao1Ls8/o9tyXuLE9?=
 =?us-ascii?Q?r8185TmEPXu8MNIgcofKD9MPeWDqyWrRg1Hu1dDPRFodn8+zbevuoKQNiTUB?=
 =?us-ascii?Q?iasVcfBhuFaZW94zw51T5rDROa1GSyK7kZqaonIf3M+99AfBIc3TPOlaTy2D?=
 =?us-ascii?Q?KkO2IuRR/+3QULGehpAMzsTgdqcrifvIa6xt+kS8XahEroD7AAWH2Vv0xuAF?=
 =?us-ascii?Q?XjlUfVeWjlb9BYF84u9S+wGsOJ9BT/X+iHjTQLGauduj00bciGCI5FMZwS7b?=
 =?us-ascii?Q?rSQl8BU46E8XYqbv5YkwnD3dIbYyA++kOIguuVQ6h4gKhMi4gEKA6paoiq5Y?=
 =?us-ascii?Q?uzpU0Rc3sV0h0MR4lyCNbJvu/FvhYckjiwGQHCF2PVIPpx0mSXJXD9iTJmI1?=
 =?us-ascii?Q?EtZvwSDAGSfjh/lVdO+HRpbZVvWY5MRmFkjQ2p2VKEnkeWoUVpq1m2g0qR6K?=
 =?us-ascii?Q?KDTgEd6XI/STgkFbJReVSVpE9cSqHTZHfLkPld5MpIFjxxH9Ygl1867Ce/nC?=
 =?us-ascii?Q?rq5Mea8sGpYI4t8uBsGod/VuvEI+pOvktWZ5D38hGTG2cCJUStZomejW5KF8?=
 =?us-ascii?Q?XQhaXt8jLowTLCMRjsdPJUBuIYjoV3c8UQMZCPsfoLdlTPc2JMsVc0gGtTUu?=
 =?us-ascii?Q?YPEMXBgJ8nfxk2HXAGZSc8AVKoNQ1dMa5IP/WdSViTHuKTUdf3cV7Fr3FeVi?=
 =?us-ascii?Q?hVdBy3rkBoX4s8Wyqlw+eiA8EdaSp1Z4vADjAZflgR3P4VQ061qtNyhobXq9?=
 =?us-ascii?Q?m1s601K8npgbpubsL6HHita4bOcy97zwkHdNiK8KJ8MNeFjdgBgNK+lPHEI6?=
 =?us-ascii?Q?kAB1tfr9vB/F6Mvw8jEPDlwNmJYNjhy8/NahuKu6ydF9BvMD0Nwys6qiCCWn?=
 =?us-ascii?Q?/6reAenOdaumZIQQIjD1i6fwgohjn2rS61BxE9wWJf/+3KZF7SefGdnN55zP?=
 =?us-ascii?Q?pruX/u+ffJftlEI8sHTf0nXe7Tc3mUtvAvPirl8xLNjZ6IL0LtJ9ewfITcKN?=
 =?us-ascii?Q?HMQ/9RHOKZjy/3iUsTqVRmFbNZY9tS4DVpmPdj14a/sfxnev1GY28ggmLJbs?=
 =?us-ascii?Q?9opilQPX7LIKysxtwMemAbIrxditDHrpTCAyzWlrdmU7NsEQDejUK1GX9ZPR?=
 =?us-ascii?Q?2jho/4YnZSNZM9BFLJ+3ojQhfb4Pl7ssgKa6+bk0h7pMKNX+TNbzgodd+0Gr?=
 =?us-ascii?Q?Ac+nv0kyTagwAMhFmkLVyRXkvMSi5B/mkl5A+FGAVuvk7TLmz0ZHKDE9fCmj?=
 =?us-ascii?Q?WDmb3gpaSJIovGshFbNkFCjALgkm0GhXiM3cCnzBUyJdee1JR2tyExeLHJM/?=
 =?us-ascii?Q?C1RNPTihVdM8z1HFrJ9cqMfVyQ+3PatFnJy4Ej/A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668a583d-cb47-4298-f936-08db82cdd513
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:47:55.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xluMiKJOdCS+ge0MIDRH4qCBjBSP1J1pnD7mMPBOpiD5c6Ffsw6bQn+aUFqjy6x4xgx0Jx5/L9lA3NFXSxf2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in ath9k_init_debug()

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/wireless/ath/ath9k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index fb7a2952d..995c6e705 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1420,7 +1420,7 @@ int ath9k_init_debug(struct ath_hw *ah)
 
 	sc->debug.debugfs_phy = debugfs_create_dir("ath9k",
 						   sc->hw->wiphy->debugfsdir);
-	if (!sc->debug.debugfs_phy)
+	if (IS_ERR(sc->debug.debugfs_phy))
 		return -ENOMEM;
 
 #ifdef CONFIG_ATH_DEBUG
-- 
2.39.0

