Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8470EF88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbjEXHg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbjEXHgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:36:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB2F8F;
        Wed, 24 May 2023 00:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caSxp5NTN/DAxGGUfe5oXeUEM6I5AaDsgoOqEE7LQJB+CraU7De9mQ0zqqSnw2T6olT/5LpVAeYlSetK4NpRly5idtlUPrO2qMsHcKXQtvS32n1OnwHC+2In9Ccex8PyVaTWjYO/vGx6k0TvHK973wRC8VjhfSs2LTdJyCVqoypQ6sdDJKWEr3eAa/S5Zw3ViVKWAafHwAdG4a/SGs9zg8Lcc2ZoJP3Rj2d3jjbIBVk9I8ry9CxV7+XrGnPkUWahtwxJAq7jJlUPQ8Gx/FG/1W6tqu9tGmZ91ObXKnDdk7+R6HA+SWIkm6se21/zgfobwEHanlkQQmKM9ipfh96J7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnS6c7Cs2mSUih8jW4N3wv7WrKDYKtgTAG03X0paeBs=;
 b=LjM70rq2bZx0Cm2yjxLHMZbgrmx33AQsQUtIHWGz4BeD0cyWGmVF2sPEIbTmHznXVy0blrFGHmzAZQLW2yQ64/rpsx8/VL2wxwkFZBs5JG/ijuTyCTfWzZETMiBV0jzhmrzBGfyr/o1oHhbfFM3h6vWHAyXWuHgXrHktxZRvol1OpFqTDuS+C8pHy+It+FBARXfksXNKEfIIlbHtVtmkSlQ4GReN8vziqhFJ8C2QlDup+dOigenG2WebIXxJWPKO2PvMkUmzHQfUuMITJxXfnDBpQNgwzcwjI/++yFUsinlyCr8fI32BsAzpyWY+gtW7VyHNzgdaOdlf08u5jT1y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnS6c7Cs2mSUih8jW4N3wv7WrKDYKtgTAG03X0paeBs=;
 b=MtUZCRiNuYuTowb6VQfCxFr5UX/ugMFtEoSkJ5TnyfJPQ1SlaF3qni7qahPbhvguvA/Qfz18dHRAV0eI2rc03jJhvLChO5MP3OVlEBTQY0KpqO+oZQeQFbblmlTGR5w+HYsEC2J939bmKkoxkR9IhreDjUVUQ/5HkBbBE2itAi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8304.eurprd04.prod.outlook.com (2603:10a6:102:1bc::10)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 07:36:11 +0000
Received: from PAXPR04MB8304.eurprd04.prod.outlook.com
 ([fe80::513b:76ce:48c9:f9f2]) by PAXPR04MB8304.eurprd04.prod.outlook.com
 ([fe80::513b:76ce:48c9:f9f2%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 07:36:10 +0000
From:   Zhipeng Wang <zhipeng.wang_1@nxp.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: dt-platdev: Add MODULE_LICENSE
Date:   Wed, 24 May 2023 15:34:16 +0000
Message-Id: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To PAXPR04MB8304.eurprd04.prod.outlook.com
 (2603:10a6:102:1bc::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8304:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7b9fb2-4057-4e9c-3df3-08db5c298b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tk6qOshHhAgwhSi5X80z7we8b8tN2JP2mPya65OOKXkgyFmLrl01CQagRawofTD1xPNHUHDlsFe6cmdGsJSttVZ9CM9ZMcPNntYVprXvE1C4N49IQkxlZo7N1kItIyZ2dKjnbq/ObDOsfRWepYanAAvGxHXL6EJ06Fuz9vBhjkzPQlEZa2CSEdq2drB/m7YdDl9ox+4jZzkFbOadKCK//9NbXoGQ5z3UFBza+NBMfQSynEQ9FMRGMcfSNjpf0ZUNXDfvLLsQVgJRRaRYz6B303QzCGJn5TL77T7PbfdJm0LtBK0t42fQuILNPsuYHtOQiRPNLqlwhtWjpi2KLx3k4lEL1AtnPakVN7h5wxFsDDn8nm4ioNc72Q2plD0WYNy/PvZ/iYDvk16mRFSLnP47H8/chSSyPIShoS8/dW0+tV66YiYsRurR++TalX9gofwUDs/KBO9XACJQgnrxiRB8TiNZz2CCxmb1VRAgrCszHc6YRQZ52XjX5yHNNZp/Y0Gfmam9HqZr0xOaRRkI/nOHh7oKDPRZy3vBJ5E5KY3ANGC6dqyREcxcHFW37iStVBP+jdgMQYydGUz+wiRhn7aj49ZK+/CQnhZ+jdi1LUIApBM2o1ISHgsLwEke0Z32sNhL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8304.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(26005)(6512007)(1076003)(6506007)(2616005)(186003)(2906002)(4744005)(36756003)(4326008)(316002)(66476007)(66556008)(66946007)(41300700001)(52116002)(38100700002)(6486002)(38350700002)(478600001)(8676002)(86362001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bcPdKYf/HxLZyag5W+TF1uvuyNbwLR7wC2F8o3lDGrFSBe2bQ37sWntn3zfa?=
 =?us-ascii?Q?ExBS/6sZ68S25fUlofu2zqSEMI9/Mv9tZDIbXd+qVjg/w71+avAy31Zy//Un?=
 =?us-ascii?Q?pycOWwp1UgvR7UH5LuSKwUc07wItUJBue4xrclCI0ry/nVml+mWmXURMAlwA?=
 =?us-ascii?Q?AmZrmknvzu9z7fMeEQ9y4zitSotq1Ac5L1+HYLPqGkUTeUfdSop4DnokrjKO?=
 =?us-ascii?Q?PexMJ2mLwTh0f9pGvkiklT2T0Y2ntjdFNzXWRZ+7srpWqQIlo7IEx0dbEOTt?=
 =?us-ascii?Q?v+UbS+vrqEd4bgtn+JDSOqBABbwOP/U1p1//uajkbsmrGbYaz2Zo3E9pGCeJ?=
 =?us-ascii?Q?pMwT0/Yl0m2rbn/fKE6gcb2sptKi52OF7yS3/JPNS9OqOD4ffF/618j4rrKu?=
 =?us-ascii?Q?+yPvOW8PWa+BXfM9qw7bNkhjmdC8R08fYMnqC+bm/UEoiQPGHsB9Zn2VaZZZ?=
 =?us-ascii?Q?p/tXC5MhvL7Z/L6taAo5Z/bZRtr3rEUQvd9J8MX/Xg+aeCM96YXl54/QiVwK?=
 =?us-ascii?Q?rZ/zgWLdZ05hgKYc+GaGOhLdcL0ZzMp9CIBzqKd79HgkgjP8uhHNwF01b/gZ?=
 =?us-ascii?Q?wYnVy2eD5suL4GM8gA0kce+o/1utjCQnFj+7iv1oR8oCfOBV6QIsQcXPB8s5?=
 =?us-ascii?Q?3MbcGuXEQwk276DIU/IrOeeIruP1pcMeQLBVQ062f0GbYiCVu2P39LZdtJhI?=
 =?us-ascii?Q?XHz3TYvvAtUpAKVNBFoqWVDXkLsuctlwbdu2wXQtGxF7emSC8PLPLyxrC2RJ?=
 =?us-ascii?Q?3GSzNIIjgM08NwY9Qik25Zf49IMDOXBfTAE0OnB9F7Wd2Ov2Z7/RCg3y7z5T?=
 =?us-ascii?Q?7/AXf0zlKpr6XoXe1+Y4rccLZqFK3XU0zXahaDmjeQMZm6LlfAiD47fz7BK1?=
 =?us-ascii?Q?Wrp8WeFYnSQvyZkkj0LQ/C921wHEqKLMM+8DL9ck+EiV3wGGCSMBUMV+cIvr?=
 =?us-ascii?Q?DUq7kXKnqwoluMflwB2mxfvm0FzBXki3YFG+mITwjJpf2/h3ItFm9ladeD1f?=
 =?us-ascii?Q?bWbSxdSiO3oBmBX4UWMAmDc3qhVMPZ2/It5VpBZZtk+DGLkEoCG8cY5beET+?=
 =?us-ascii?Q?qeBRjVQ6ialZ8JWEE7VQU6YmTZdb8jG07CcqQgJK8FAaIKU4UN88TW6HuXXE?=
 =?us-ascii?Q?psqAUqXoARwwCmO5bFBnMz7zPwX6D05YdeMhHt0uRkoQkjGTDowq+KVxX/Br?=
 =?us-ascii?Q?fm5xhj/748NThu3q+hBc7HeNo1nIbd0pDckgaRD8dF3Pak34xvO/YLkETbBc?=
 =?us-ascii?Q?QafmRckTP6pQxvyPN8DtruFeGbqOemUN5Tn4bk+GKjdDJg9s0p+YYu9DKn5z?=
 =?us-ascii?Q?/5FKSdlAEqJ4ewn9ccgDJFafKV/Zvv0+/X2g485G03aqOuovMhJDqC8xX3if?=
 =?us-ascii?Q?e3v5Q4FXiMNE8An9f3aB1hRgF+hdc096JV2Ga/jhficUAWKWbkyM0n56I/uP?=
 =?us-ascii?Q?PHkqgPqzwgErZO+j0tDZ+xb9AdAiDAYvMH+wViK+A4qWm6exXN7ZvpSciOM9?=
 =?us-ascii?Q?O3/710liCI45aQTBolQG1HBSbKQbWDBhlvgVT4tgvlZ/cxvcXCGwuttBEubs?=
 =?us-ascii?Q?pZjm9YJZKfUmxaWLmuhUduQxig7Fx3VZZFrBWnwc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7b9fb2-4057-4e9c-3df3-08db5c298b43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8304.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 07:36:10.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tf9cMMzFWNTv6fyjr55zeTjWeAnpvN2R4muDr2uPscpolHckTvHrX3ygfxl5Vv0mZPwJH3ZOk+RBLFFY3+qRVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as module.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 338cf6cc6596..54529aa16d53 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -214,3 +214,4 @@ static int __init cpufreq_dt_platdev_init(void)
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
 core_initcall(cpufreq_dt_platdev_init);
+MODULE_LICENSE("GPL");
-- 
2.25.1

