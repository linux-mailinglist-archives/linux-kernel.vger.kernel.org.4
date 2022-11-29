Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1E63BAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiK2Hts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiK2Htr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:49:47 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA010C4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:49:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd81O3fmv9W8f5alrkwnoget0m8wSrc1WeSen8DWKq9Wyof5q/p89I3KIwnnv9gBxKE9X9RefR3f+2Mg1YNJoezbAEhZgytMtURK+ypjMkWckR7aZGAhzAQ8lnC2hBMaD+ib8vOFUN4rZMoUFgbeHFnkhA3hH3Ombp36EXT2Y9rnQH/CmgX1GIBJEdRpuf1PUHuNyGRTJs8Dx49knGI7sHNj6Arrb7NRz95Fx1JVAnHoDSJOwkV6X1R613zRVGVo+G/5nZ1AEMimPabDe4Z3JZG3vpQ4EMxDkLulDMri4HP12zKstFSjwJREihW6XIEcXWiXLr8ng9acQW+z2omfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BV3dpZTpsr4yE+baP8EUKJ6qdMvQogHFJcrZasXMP8=;
 b=kyytIrXgN8BBbwVThIvWxgJjHnFc5N6SqYpHz9+90yQ3LNVu1j+arzm4xLlRwu70UKT2kNYCGnwr87ESQVgKyGVaHStTC80oA+RlGHg/JeWerRFsLAVhkuLVElC/CMnMqaM6KJ23H6XwntuknukFNmjhey7QLhBUgB79b3VDYGS/23JlP+rHC66LFTeDzEcagKchR3Ycw6ER0u1y54gOoNSmzDaRNQ7xQ40X5R4QN3ojJr2IuITavrgAkYGJCtSrdU/STjwiWSleFZfdtSJ28CflyqVOUniACIMVXEg5nqZKTTFe0pZHGGKjpjKSVqnxizDokF356lScoEfzLCMULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BV3dpZTpsr4yE+baP8EUKJ6qdMvQogHFJcrZasXMP8=;
 b=CgGxaDBxmpaQciIzSR9OudMCFI2xvOriKbD/oiH0wowwrZEffSmwz3sIfqxxDAVgI9+OIgqTJ3x5DxuGOW5xmTtuL4Zx5MVlzMhs1/e/T5RO4c3RztZKbj7nZAhca+xCGHwx7N4EFGMqaxVwUrkc+pFsos2F84ZPa9KikITKnCBLr7KtMPNx98dVY70PjPvHyuDpERfy5HnonMYZIjp+43uIKmafLEph+ma+Rlx5Rqe/IWCmMkYWlBlF9rRWc+ZJBOaEYUqwflCmcovgmuNe2Gwus6KqXLaymyqLUWP/NPPNPmPzs3VvtxpZjteua0Dw7QAb72Bs6IjixIh9CjVyyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5013.apcprd06.prod.outlook.com (2603:1096:101:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 07:49:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 07:49:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, qxy65535@gmail.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qixiaoyu1@xiaomi.com,
        xiongping1@xiaomi.com
Subject: Re: [PATCH] f2fs: Support enhanced hot/cold data separation for f2fs
Date:   Tue, 29 Nov 2022 15:49:33 +0800
Message-Id: <20221129074933.25124-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128085859.5295-1-qixiaoyu1@xiaomi.com>
References: <20221128085859.5295-1-qixiaoyu1@xiaomi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cbfa30-552a-4dde-6019-08dad1de469f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gN1wFSlE6SSTA6xQS10x3aQGriU9BkFFQxZWL3Cqqu+UuhRNRqNFvgmxEpKppM4JBECQJo2A9Gvau4m+zt9bIJ1eMdtWsA0iumm8tU9E8tFn24C0tZICdaVEvx9xQMnmopjD+Laqx5CLF7fhmRekyyGybiEsqL/tR2cb97ML4DerMpD3hCboRmkTKdmKGKQ6gyP2VN8azJ03Wa+tGByVA4ARHrjk8YIt98fghvW7chRQnT4K6xZSuv0z1xsE8UatmsT6OHNTl5FX3TyPJ7up1jbkK0yzi6BV/gY7SaGgvbfHcQqP5s4+sosqh1MFztqMBsRu43IctHqU6E+ln2E5LLOMS8fj441ox9e+EmEGr54QJt8W1Tiom1a3DiJuYyOmAD8opOmdDh6jKrCC4jTlurPal6IZonvJm71IIMxtwhrQTfD77aN9wlriOXCZJ4H/WFLs831J84o9HIkK/Izoj2QUTMve7zL/xI8dL75PuRvDG4abkanWA98/q0CeWGT/WKPylt/O+ljcqso4r+dvrDhQt/KvUpzcQvWZSZMMKZScGJyjWo9mBtiGTSQ6I5GZW04s9N4wSh705fudAPr0JE+GUH/P3HSfDVkq++RZEUjMCuTLmfDkt/CltwfXoUMMt8AauEd6tTXllRGYOk7M0Bsx/Okbro3SBhc+vJkrCcvYK8E/XaSjBDeQVJp2Ga0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(2906002)(41300700001)(316002)(36756003)(5660300002)(66476007)(66556008)(66946007)(558084003)(4326008)(8676002)(8936002)(6512007)(6666004)(478600001)(86362001)(6486002)(26005)(6506007)(2616005)(186003)(1076003)(38100700002)(52116002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HV6lPT/136JBltalMSCDwra66qIh26aF3j+1Um1unf5MCEKSC8pYk+sUbmfD?=
 =?us-ascii?Q?pqQ+UFi4l6pT+W+FEpyiCnmOAjvxax6oy4YsXHRgFLnbJM+8vUzYqyTT2qJe?=
 =?us-ascii?Q?0bhyG3+d5L0oVq3Rhcrf0H3w9i+R2lO3dZWoyMhAdzpTiPUX4x9QtztiQjQV?=
 =?us-ascii?Q?CroXk4bguSfvbKkEKxS7f/f/gQcD7ecB0rx9Nq6AD/zC3URRCyNWW1pfeVsO?=
 =?us-ascii?Q?7BR1keejfZyFn67Pa2nEJXzz0cEh32nYZ9XBC8fmGgh273YWclYeZUUtM1tU?=
 =?us-ascii?Q?bLk8x7M7ebi+zrBLsLK4qacXlxol+0mg40DwWEHKmCtAH7uzRHMcX6MXfxWI?=
 =?us-ascii?Q?t0IeSMRlRKiyTU/3ijE9TZKubSh7JZxIdhx9fNQQwhX5LdA/R3vMMxfL2Ovy?=
 =?us-ascii?Q?ZbgJVKTmC0t1XROpPToXmsBT/e5fnhD1k8M6+mhyP6PklwLoPkce/pztXMuN?=
 =?us-ascii?Q?OSLmxrdHp40yEB0vgAtJ9qHL/1Vw4zveIKcKc0LOvdC7s3WQ6irW03gaQs8i?=
 =?us-ascii?Q?kR2w8Z3NvAfjf2znjyu5QDTWjTmqiVUp06gzjHV0YNRU1IwBv6GOtGgnn5Ul?=
 =?us-ascii?Q?sEQRPQkxQCLQnFehRz0Tau7hTmz/Pp8GEWTHFURVvywK+47Lm9Z8ylo/U1Fl?=
 =?us-ascii?Q?XALMiOfTeXyS4/vUDJHrH/vSp8GGsCB5Mk4DV2sEc9OAUkKp7ycwCVhdBnIX?=
 =?us-ascii?Q?pIK2jziBw5w7KgXfIllgAamzylP6T0emajWW8GZo68sotlTguqqXJflsTrtc?=
 =?us-ascii?Q?4CS5fpfKmRb0rUsrb0gWvmtIHNn8VrUuwlwjD4uFsoolcXAofczmvUaspQ79?=
 =?us-ascii?Q?s2g/GebNpxBaw1ytlZKUhRUk3zGZHZialfX6T3oO/nqdPxtvhCWKhiwcvjkP?=
 =?us-ascii?Q?1kAZXFiC4tGTPqrTxL4l5UPeNsn61EKPtb8ob9lnslXXuZ6oOmnwEiNQLi/l?=
 =?us-ascii?Q?Vdx+nB8o89lr0hR2NwCv00gWrZ2ZwrFNd6WSyouslGB8zWW/34cXudZkbfSg?=
 =?us-ascii?Q?TBCujOce/OaexkbJhN0Mo/hD7vx71Xt2cyqOgr4k9fedgD85kWESl9b+77pv?=
 =?us-ascii?Q?50xyTRcji/2v6Kp3Vb5DqJVz6CSk+GPTaS3XpCrpYnViLSH0DaoT+h8NpOZe?=
 =?us-ascii?Q?Rk9dUNeyU7u5/rFkav3Mkuu+ZpOeP70W4bCGYlAugLAgcYYWwvGQWnP0pKC5?=
 =?us-ascii?Q?NHuLTjrQ9eXX/5QTLQYTr87V64tL1n1kzJ8DuIxVex0syNJkgUeC8DVMtTu6?=
 =?us-ascii?Q?Q40GnapJVOuQRE6rso6ejdCKI08s722Y13tlERws4KqYCQi3sQgJ+UTWF4Hk?=
 =?us-ascii?Q?9wXjhT520fKeUTFSTTtm/KRa3/7/yPspuJs/spZqaChbhgDmRzsM+hfcv8nY?=
 =?us-ascii?Q?gLQYIVPA1wgo5ktxwxPIM1ON3HqBShCT2DKPme/iN+SIqA6vfT5LQR2QC0ag?=
 =?us-ascii?Q?eGcqnPyznWOQny5hBpZKyO11SKVptv+suK6MjPTISZaPmgX9GRChWxIjIPS/?=
 =?us-ascii?Q?5eBDR8dNm4O17eOXrrZ76eYIJOuhd37L36VWD7hsC+KIZEwO54b+1zNaTuL1?=
 =?us-ascii?Q?ntShngw/Dc7lFVVJZM1CXDcW//oF1QRy66drl8JE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cbfa30-552a-4dde-6019-08dad1de469f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 07:49:42.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeTnbPlcQiFaqSRxz1gN1uD/488djfg7X5nWHde1kTLBXmhiGLMBqTzjccqfetU0Y2Ce936LhkZtwlt366Wr8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi qixiaoyu1,

Thanks for your patchset.

Does this patchset have data related to memory and performance impact?
Can you provide scripts or commands for related tests?

Thx,
Yangtao
