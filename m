Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43B704998
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjEPJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjEPJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:44:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2023.outbound.protection.outlook.com [40.92.22.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0625EF2;
        Tue, 16 May 2023 02:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C808O3L0HUUlBvUPpY1hCFIWSeU/dngB9zfA5T1kkUIg5eOJw9jbqpNwb50BMLLmGHqJ/1+x4dpYq2qWIMJ6F0tgTVmVOJs+hybuPnVo5hvg7O1t94TbBOoROlRQc2YySgEDntc5tlxIFwK6CsvdJRamlFppw0TixZ4JaaFab7p59cvvEnIXNwBH4wkEFOZqYFTxvDNs9NE49R4EAW4w2irUs7HmOmSotCSLSNfu937as/GTg4NyTd0P8X5hwICKHqk969csIiIvEgRUp+QMyCAp7G51Ag/TO0I5p6vAzihKU6Vx8zxf2EYMNsvnF9Ur26kwSyOTDlpmx34rAAMQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBNO//W7H4mxwZS4hTm7JB1l0GPCqfYpyIp6djrkCmM=;
 b=ZHR1/r/nPss/GK1z+v4JV3o3X+9iBxOFNZIqGjjtF8Zwqd1nVPjL4b8ia8NkW3LEvRshrYKOUlJNz+BlY0o+6u8Wn7E2JJMnqEJ2Ruv33kdPj8xNjKC+jbiiheAEPmayfmah/QSrH6AjVok+9R3iQcwquSR0BxFigLze5/p7nQQ8dau3XzFe6tBEoX9Ry3GJaSeI+hk1QgS/Ow86z/ZH2DcJY9enDf84zhxca2U+6r3e9G1Yqf882O4YvQ66P/npsjPyzu8R8D+jWjORLJb32HJuB9Sz/v5XwUP7+uDPfnG0ZBGGZnqlbCZkDcJXUQlXoCE9zG7mQAuMKDQx0GSWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBNO//W7H4mxwZS4hTm7JB1l0GPCqfYpyIp6djrkCmM=;
 b=T30xZ7ixT0al2wkA4OjTai177/bLRPWErTqpFf0dQtI3eGBDAlaugm6IzctZbXpA+InAcnOS9DbGIEqyU7DCOKF7k9JsASX9QOPtUbK4NrMmezZ+Xat3emlee5nEHDUmc4kWtjdrhxCYcOw/FZhxwkUFx0aBTIc4EeUdl8ruLhHQ2g3T+9GGgVBI5WNDaEzuzVxkm0HpWNJJWwBrGROq5OEBE9cjDrz6/mbChKzV+aITyqZvWHWlBbVNBSsRNWQ+Q/Tor2hDYdp1se2VafDehpbwyEaWyJhIFEsFnJMSiPhmubQ7jRgtEHU5/skl9PtrkO6ASc2XAdE8zeEmm1jadw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA0PR20MB5706.namprd20.prod.outlook.com (2603:10b6:208:436::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:44:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Tue, 16 May 2023
 09:44:23 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Tue, 16 May 2023 17:45:03 +0800
Message-ID: <IA1PR20MB49539F3FBE068C7C811152B1BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <38eaec6b495786b048f78be08470f7c770793d7b.camel@maquefel.me>
References: <38eaec6b495786b048f78be08470f7c770793d7b.camel@maquefel.me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wwI8SVQ3qAorzoi9B0vPLlFkW9ocqAnLW6yFhtkhgSM=]
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230516094503.481969-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA0PR20MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 6feced5e-beb0-4a2d-c2e1-08db55f22196
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3mlyp2+JOGVZNHdcEZItuc9zYy/vOUoYm0GHO98Ki3HQdBeVjAIhNAXVB7sGoUu08S7U8PxYlKNwOc3+ajz9YfQbsxh+otj2PQdp/r/WlcpOXLFeaAx+GRmLzx4FsvQkSeWXbPl55IkA9hhGx+3JaN5X7s91MZu7arIk0huC1qJWv3ivCQ85lpx+gZtXSm4j8XALDG92Bm9CO4JWc5iKFfn7aR/bwIgIKiCfGKjWKyJhoklmTSZRZqbge15LsCq+ltlZXfNTUXpZo0OiTnDw7h8lIV7HSdzeTaJsHnVWXPLnV5tvu2S0YFso1zYoFqJQ2Okwv7V9g3pnnb2trwOBDkawCLUKYBj43Kkj/4XaUuBpDxUA1EKOl4H5juvdG/y4mbdQE14v9EDInV4/tm83SQdHu+0S+d9gsjH11nvX9sZwrsEe8992cvO91ztsqiVF+VO+2KmjG0K5Q1pfD0xc7mtTrUMFpOaU7svAcK7Mf+qgCzfWMWKKKcG/e3Pf4vtwFcDoR08fzMvTXCXBSPKyxhuimHNs7fBz071BpHrsNGEdFlqj3+LD5C5xqdonpJ3+2i4p71vTwjgVajYHs/NZYgvf4nehHZuQMvoHt8E6SwnNgr8nEPat/75u5p92OSNeQFy+xO90s0g8hg25mDfCu3Rp+vaNqjcaMHe0F+ounWmJ+Vn5KYagG5qtWYPx4OHTXcmMxu4RgVY4VLrHYYBneptgHxamdbt1wQDm6nxCcE2Bz6IyOuSlwcqiljuAuTV8uT5veVxNuqurKh38kmLBDkU
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDDjOIrKHF486WakZ83QTrY4rxet3+Gbc/n92hIX2jTQ53XAHt9SPUlywWa59k4L42qd1e6Lmf6B3Hwf0Wkpec/bmGepcYgpepozBPUVOFmDL3jIoSh3JsIwJ4XIyq+3SXLO8+c+aQEJuCP+sojluTKdc2tGswTGbQQrtdP3DzjDaTeX+S6kuqyqNfX7eLVK5IgFu+zocAdJpj3imDScQ5v3OuUQByTinSq9JUitWOFNLU6N4Rpmuyl+vFnqlV6W6FyfkRRnc00gqYN9j4LyKBuL6TgHtjDSCvglbFlZXUE4t5qXry8rqWyOTR3m/5jNvgXWSB4WBG6Jf5UAqkKvG93bewOd/ZLket58djm+00T1xGRUEEIRyR5XBzqnwjNtwNFD2jNqbsfxWh0GEs0scuXpNIarvguxwkEkQPD+jTcy/hoB6C7CCQZ1eT+m/6hsiibSo6Ctp7J299uHDLeustgkD12Lessh+wgQH1LonB+MP0NXqCmXTh3D/SeuqxLd03QMtbYrzU1ADCCuUm8VzRBYSNQiryGx3iMkpvXCmnXKN+vCmEX4WYAHTX2iHr5gF2EOKkI0w2uJxM96Df/c2fvmLyR23qEQfzwipAzva5U6W648O52X+OJZ4BKS8XNB1R2zFfAZjQWWbNpi3W1zaeA6onbpwtQCjrRtBY5k9CI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xXcQbLKF69rsbh7USQYLzIpUU+CqNUX4/TBVT6HUxZ5VcfKjfO6fTiRBtfu?=
 =?us-ascii?Q?/Tzt83Y4Czc8DqK+kmZFg3m0cCW5c4egmLz6I5CwGwHIgY2Ur1Njnu+pbC9g?=
 =?us-ascii?Q?CxxVdPdQGG6eOKg2dgbpxvJ5JaM8xP2PmPO6m215h6GY8WQFtiETEBf88w/K?=
 =?us-ascii?Q?HUMVB3uwaeDpcsucujm4i7D9/xUpptjMhgGov51SSHnMLU330uVlUg7BbBNG?=
 =?us-ascii?Q?vzby+4nq8q7OuI6o1JbYUKNbjhN14vsc21DA/BXHK4HcVmxA239R3MVsFfB+?=
 =?us-ascii?Q?F7+HSY19LZIGeXLDqjB/QgtOKAEO+andMg93rblUAdZHtLL28w9DKjBitghF?=
 =?us-ascii?Q?vNknhQ9a0Of6CknUVhbVg6z+xb/SCRC0U+d+ctJJ62rEvIOYlo8VBWWk+T4A?=
 =?us-ascii?Q?N1CwOo32x47KWi8y6OllqOrQfqOmbosGIqrokeu5pmbdlCPelwWGWryQrCyI?=
 =?us-ascii?Q?2Rm4ls/U8E/ywseB/QlPCEb7fMKY9bhwuraIog71j4JbWCJ8nbUh6MOVxdAc?=
 =?us-ascii?Q?EURv6hRSLyJxyrNazKLsPDaOyMaBfNCRfywmyIeFeWgsS7RrAz/KEyQ/QUbq?=
 =?us-ascii?Q?yCwwdIh++BhJPCxcrxIULsvsTM27ElMZrscM3PJkvDNZe+zK3qYFcDwiqfFD?=
 =?us-ascii?Q?rdQWE9ubr1UJ2KEzRHWk2fRgv8MUFSwyJp3I/nO1/VbEpL002WZdWANJVw4V?=
 =?us-ascii?Q?Ma3Q+jpkGVwgCN3+8LQF8vsESsOBghgEm7Qtmbc4hgB1bXaWoiWnA9tR6mRh?=
 =?us-ascii?Q?7XfIW4bYl9qblkWxpuRQlejxU7bUzFEg+xWPcrwpwI0mO0Evvj1/6EhGF196?=
 =?us-ascii?Q?NzD3l+SaPBDWFIkGBM/rpEAn0s1Jdzf91dTUihYIwUm8X8igknL3j2rbORVu?=
 =?us-ascii?Q?zwd9V2xbMULf0WlnPh3Kcr5k4Bf6VZLk6hzZluKNTMLxN2mrLKYWn8RK2n5L?=
 =?us-ascii?Q?01+XdcVKTRhBiRNmdDNnWQxVyQul8xMmHZUs7UHiwcKereuLhZgjT+DZjqCl?=
 =?us-ascii?Q?mRFJsbr2TPMP+La5bQJnjH9zOvnA7dpN68+3/pz7v0P9iRfUje3ANN+o/TEU?=
 =?us-ascii?Q?UBA28J9Im9vYADQqiJmQlDLHG/IYyXNskJ5l0obfrWk1hQsii6LxPNIiA7L5?=
 =?us-ascii?Q?aiHMfKxGyy5iXrSQ1CkJZgpKvAjlME1RFekhvrFT2MNcKJIRPsXNBhTO816Q?=
 =?us-ascii?Q?xDPquRuQUzQKPncqCIkxKvPgnFwL6w7LwHWl+W0OgLn86Jcf9LTIa1b3zHY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6feced5e-beb0-4a2d-c2e1-08db55f22196
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:44:23.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do c906 and c910 have same HPM events ?
>
> https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v
>
> and
>
>
> https://github.com/T-head-Semi/openc910/blob/main/C910_RTL_FACTORY/gen_rtl/pmu/rtl/ct_hpcp_top.v
>
> Look different to me - am i missing something ?

Yes, they as different, but event ids are compatible. See [1] p.99 and [2] p.73.

It seems I forgot extra event index from C906. I will fix in the v2.

[1] https://github.com/T-head-Semi/openc910/blob/main/doc/%E7%8E%84%E9%93%81C910%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf
[2] https://github.com/T-head-Semi/openc906/blob/main/doc/%E7%8E%84%E9%93%81C906%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf
