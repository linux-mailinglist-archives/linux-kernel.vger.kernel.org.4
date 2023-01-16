Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5966C011
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAPNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAPNsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:48:11 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2109.outbound.protection.outlook.com [40.107.117.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1C2196E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:48:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDeRtKOIn53uLkDI9krLPKImPYXZ7BawEY32SsChLgKY4USbMgOLwEILAkD6/0bliaAkCmspWO1ulkxAf3Ol9NIkL/TcdQbU6uf+ORUyB57mQbl86kGSokKErxyLwXfa21eaEdgFQTiMZl/GL0QUKwkk+uX3OMko8kr8ac8ek4WUGb2bi73cxEBSekjTwuJfVoYEGjH5Hw3/34dkJ/KAz0M8236ANWe7M/zJAj3CwZNJWjlsfJAj4EVsBlveOFXPiVJDYgkl8Sjk5GCk8u9y/4ODLr78NAVhjwvu28ztyHjylw9iVvVuEfGO9wzASiKcZhFEKjg+Zsy5ABqCf+EYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0YLaj4DfBEA7B2Kj4fr8p7mNowrC37gzYyOiHLLgr0=;
 b=gYGndhk++Qr+Blku/MmqOphZlWzZPRDRfsbwP+nEVIudmPx1UDbG5K4XPwaVWpd5B4G8Ie1g5FY2JE08VVizkqxa0hfp+Ui1HKiXijOlQI0Lpdi5J5Rn7TBVgX4hmC0H4bD0YAPdJ9hZTaE8XbqX5kK/2pbY7dVF9GE5vthDtNTKvzp0skGWArKsC5bdhr+xCtguE7QOSmmqAjdGkqWEL6zPjpaD9vftLUkrZOKkgTzSIAjvS1AHZfyumKtlXULlg9RoEL0PD/ox3DbCDopXcXOPJ6AnVSX4t5nPMiUOn7FGtqL9HTourFthwgnVPB91zya2owO7G3cViGYIHSLgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0YLaj4DfBEA7B2Kj4fr8p7mNowrC37gzYyOiHLLgr0=;
 b=RtcKXruituuJXBl0IW+IGijRA0vsnQR4++NyGpV3uIHU6+7xrTazCGDZSL6iUQO6ehpyhQEw4tm5mmhVFYQY7wo2IytbuZw+QtNLu0tUmO2UbzkU3/nfGsT92mzjIqEdrecMOsJ1vxghSIfW8Kqi0xRmXTG2eE6f2vMExewFeBQEAr4guMSCkObGKk80gKlBktjYnbuwe1OY7CtRGvZMduW8ZO24m5Vt9ZzyXGbJQJOUmvlPdUTmmddsWZ8qrYx+oI4PX2wQrydZn/74fq8mGxuYgf1I0pwRySG/zMyCqysrf3Uymo9pQrjyXtQ9NlFEzalVztCtGQyug62ZfFP8Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5008.apcprd06.prod.outlook.com (2603:1096:400:1bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 16 Jan
 2023 13:48:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 13:48:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix to avoid potential memory corruption in __update_iostat_latency()
Date:   Mon, 16 Jan 2023 21:47:55 +0800
Message-Id: <20230116134755.40119-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <da57fbad-8242-eb1e-ab2b-322d61d0762d@kernel.org>
References: <da57fbad-8242-eb1e-ab2b-322d61d0762d@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 6543c8c5-af51-4248-d138-08daf7c84a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cyo31qnmFJDqGm7PSnPQqprz5bcLuzYq5BC81ZaFWCoO0XQXB7Gulta2BUygyTvTR4AM62Tu/8Lm8reMMJnoPBcnAwF6MPMW5KNdGbaN4KWXWBLYDXvyefRpmQZqEtIND9YvMU4mpnKH+lrH7UzqvOp1XAFDBiwjk87tPzuoGFJ61I1oJbBdArCp1MkK7s5PSbGmwD/GT9bFlIDVgJSRB29TUAaRQFERLfrv+YzfxT+G34eB3v5N4NshMLmpVO5QpMM3qxD9Lne59WMctVqIBugflhjQt0W08kgrU0QYRuWXgIut0i2Zj8iCF2Mi7pU9VDB8LRfbj5ioLkipR8uFXaKL2Drjvb/408YViSWQKcrQChBv8tV4iqfjk9p9XNP3LfkVUoeyOe6+5WdfPf/NRa8AE3jMXYGHHyXETrHdYV8ms17yuc3NPxljjRDwyinRy4Ui68FT6b29uAb3asROQQSSOtQwYy97KYHM4spka9BaaTJP704mMF5xzhCmUQPQckLxbcirs0NhKSga4iiWBB9ICaGqlPdzhiw5DRzjX4KSp2pmFLlvzFKPBjz9GqAZ/e2iYe3jnHsG4PIrw5/44958b7H/sVibGSdEa0G8eSc83/dKbWLnw83FsByj9cobFADcXM9TxwBAzoErxllGYTw2wGT8j2Ik2b28wgudNkL9enK5PM72IzdSCQIKzHn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(41300700001)(8676002)(4326008)(8936002)(4744005)(5660300002)(2906002)(66556008)(66946007)(66476007)(6486002)(478600001)(52116002)(26005)(6666004)(186003)(6506007)(6512007)(2616005)(1076003)(83380400001)(38350700002)(86362001)(36756003)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cWIE38d7HBoVlwH2/DLGyZ/yslSHWZwhcW1ozANoZpOCJL+5gMqXrK3Pbd/e?=
 =?us-ascii?Q?tP0ubr2IwKANr2hNz9PS0dKtSkBJv90BAgsIi2d6sE6au6oWXHCcDoPSzZPB?=
 =?us-ascii?Q?s73RbJnFCJuIgeBHNRFsUTurxb1nX+BADlmXqMKillZKon6fvk1RRBh9V9sq?=
 =?us-ascii?Q?dzof6ZtiCvaBQc03JfhNRHvlN6BZNovJ6F4PLMPQ6Kgzi290hjkgBmlQmjKB?=
 =?us-ascii?Q?SUTXxB6iAA7QB39I89E7NTGXrArCf7+cgTNivh/ifYzlCSU1cGoMrJQjOZFI?=
 =?us-ascii?Q?YCoMZCIZ0cqFDEudc4+G/QmI/qY65G/P1aftmCFGTkvQSx7mS2zFmIhIUwKc?=
 =?us-ascii?Q?0ZAHSST9C3Y+PU3otGyCwcbzN7BLZXZ8P4VHU2Hm0JCzKouAXJA1y7S7EovG?=
 =?us-ascii?Q?8gb7BFLxuipnJlDqdzWCa/NMxaYTHgGRTVu7t2VQIMShgaIyGM+VkBvLIY/i?=
 =?us-ascii?Q?KszIJnhaCX2PnXh3p2jwJoNT7Sj/iufyXrQiOTeU5xgDtnY47MbnzWOCiSX3?=
 =?us-ascii?Q?MG/7lpctRdglNPk1gg/BlPPoSljrxu++lG8hGrCvvQbsQMEC64hDjWdNaQ65?=
 =?us-ascii?Q?sO+EIi9XD6h9JtBzDpIBYA4DuL3FTCQJkxU0KXN5F3WJHRKhfItS3SBPz5+/?=
 =?us-ascii?Q?P7/qSV8arUlz3wyVX96Tsk8ufw8Em7UOBbW6pj2mwZ6NhFqMdEXnWh13BqJD?=
 =?us-ascii?Q?pztmqXohDV1ksem+bh+82Yw4cAT9eXO4DPWLppPrvSBuvvrX5M1EFwC3GA18?=
 =?us-ascii?Q?SBXd7AbO7YGXZ35uAZuGSdd2eMohhxeBFa6ck5qJHz6k+78YjnshzjpgP+mV?=
 =?us-ascii?Q?qFiyCp8fp912xwMzCtQeacvyluy0qv4+RwXkZs4hT6FOm5jMLfY0G6Qtzx5l?=
 =?us-ascii?Q?AVCr41jj66LTRPCeDIoLjKpxsFymapo2rlJzu3On3GE75LivE8Taxsg61T8I?=
 =?us-ascii?Q?WxCxukQ6Bn6SxJLE+CE3ygpq+2NgagkFn7S9lIwhHVLqOmPqI1+6FDGjSqwQ?=
 =?us-ascii?Q?B2OtiNc3KZv62TH7jRxca0rgdP1JrEl129Isfl8hrScCgsjVpYu5zoXG6jqe?=
 =?us-ascii?Q?R3eoKtU7/kMMY4rSk57Lm2fPZ9adYMe9rn/wjXdXsB8cqoP/4d/qK13IS5H6?=
 =?us-ascii?Q?ZJEkUB5VglHvxmSqov+aFQNls4/fnpptG8uJs/DPUwFBSPZO9FQ9TtNVtZeh?=
 =?us-ascii?Q?i/HdhRHF3paxkBwyvIvP0Ph87q6qQzZYb7WW2UW1wtoVpOkFbClB2ucXQ373?=
 =?us-ascii?Q?Dl+6sjqKIduLahk/ghTWSdnXr+nmz4BU4WTT0D3i78QuySavCk/0DSxPlz6p?=
 =?us-ascii?Q?AVuKQM3mF7qOeryUO2QRTiwnQ3tkQaPtKxJKTNmC1TVszgk1Bf6r6WLJbbq1?=
 =?us-ascii?Q?MGKfqXI8wmHk8NyXeWhwXPe1aFdiboYeXZoBxFKUyT9K8Ywc2/Xu/lSkrHMI?=
 =?us-ascii?Q?Ad1QRZ0vhNEdMfM/ZstsZlLMMN+sVRYeLwan+quODE1MTDfcz4bkfTLabe5D?=
 =?us-ascii?Q?xnQXgDTpp5xzr+194rmiMc3mNtvPPR2aeRtjWNBDUh1HfOvFHMPcOdrVXnsv?=
 =?us-ascii?Q?I+d6VxsMMdXfQO/piCq1v8eGEs6LvHsxCRr69zrA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6543c8c5-af51-4248-d138-08daf7c84a27
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 13:48:03.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2Wa+oBeuJPvy4G1H4eZ5QFME3HnBSsPElZR6uudK+rB4P3l+CD0AMMS8cnNIe0lNL8wBBU/Zes0ACWtVSS2YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

> Maybe it's betterr to merge these two check condition as below?
>
> if (iotype >= NR_PAGE_TYPE) {
> 	f2fs_bug_on(sbi, iotype != META_FLUSH);
> 	iotype = META;
> }

For normal , only META_FLUSH will be greater than NR_PAGE_TYPE,
there is no problem with this logic.

>
> For CHECK_FS is off case, I guess it's fine to not return and just print
> warning message for notice.

But if there is an exception, we don't know the type we originally wanted to count.
If they are all changed to meta, it is possible to get a wrong statistic. I think
there is no need to make statistics on this kind of error scene. Just like in the
next patch, if iostat_lat_type is wrong, we should return directly instead of changing
the value beyond the range to WRITE_ASYNC_IO.

So it's no need tp merge these two check condition?

Thx,
Yangtao
