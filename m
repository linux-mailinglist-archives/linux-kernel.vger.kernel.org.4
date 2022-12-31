Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ADD65A65A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiLaTrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaTrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:47:05 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2094.outbound.protection.outlook.com [40.107.11.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4145360DD;
        Sat, 31 Dec 2022 11:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijZEcwLLF3MDHqXgCwdzXtodPSz1VyI21jjh1FXd+7wqQ2W5ayehgHLyp/I21LhyBsN0ervsgMtTcW4jsJiPqWG0EgicLFzasX1JYfDpKztXWZ56ALPXpvrGcarIUQ/Sg5alP4+RldRGM40DHoMmP6Fgbjswv2VJ0r96//pRppGGUoyQVo7vthKJ71WAsYTB9YY8tYk5V3DpCZXMpNhe5p4XJx5h2iA5hw4PTl9BlmYB3KvQ/P6u85PoPAygkhFc70KacE+Fu1Ji+bgmrGiO7cRB/SpgBQI5TEYwOTJqxCLU4tSO/EMF1usF7s+Unb4zvdxtwkSYL4Yk8ziYjo76Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/1XAobYnhFWTboD0glXQqYan2yEi0BgyDr/Hw/APCA=;
 b=AgcUK8WnbcoSR9yPXkdMf5kCVaOFEDyzmIfbyI1wQ7ezirzCFiMdEsC4nORfSiWJwRuyAAxWBPu8uK1hQe845QIhUQhz9R8FasY+GeMqKhL3sSolnL2RLYnKwcMxTuSG8lw1qodfibOmMSqJjUgD2rwAbSclGhpz+PN/PCdE5cd3vOJPAy5FDDEQGHTyMU2KaVhTRUzCvZZwHjc++LN+7AmV4vQm71os377A1sIKFSCZPxprYQgW8GjAsVa1U6Vcuf5FQ912BKLroiTSwCsj5Qd/Il55Q3I6FJ6x5fltBP5ZGX3Sp5/0Ne3FfnSDspa+2befxbpW9QtjpzbXPCEccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/1XAobYnhFWTboD0glXQqYan2yEi0BgyDr/Hw/APCA=;
 b=qxOSvvYhBZXfpm06oSD9SJwXcht8qY1CIHsmipqUOW5Isk8FBP7wsk76c2hjzoaVKB17dAh1aEtam9xlZn5w1SuHUpCYf3qgYOjRyjpv76AccXCMNNo+heKlvX6uuo/aCztX1bJZPw1v/FOhgv/yAoqGOTZ0cQgNXU/+Ihba8+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5403.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:47:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:47:00 +0000
Date:   Sat, 31 Dec 2022 19:46:58 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Laine Taffin Altman <alexanderaltman@me.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] rust: sync: introduce `UniqueArc`
Message-ID: <20221231194658.4f45055d.gary@garyguo.net>
In-Reply-To: <792D12DA-73F0-4218-B0E1-7A0D8C235C21@me.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-6-wedsonaf@gmail.com>
        <792D12DA-73F0-4218-B0E1-7A0D8C235C21@me.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0447.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::27) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: ee70ac92-6168-4650-47da-08daeb67c82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSLZWn8i/f94U5CBozd0fVgLElFwabgZ/On+9AJDr1caknn4ALVg72ySpsIrLzeCEk7J0Fs8uDrStbefoNRmtCtgwMUAKxJCLy9poS9zC3VlXQpgbyAUwIpEXNmlIIcxU8QGgbfE58+rcoz7TzT7lSKYPvSm3FNpW9UruTUmGVpb/aFyYDHdRbFp9ImZmY6WYIia8wcz+cL68ZMJIFd6afb1KkrEGmFS4J+buoc34lI6M6Xfkcj+n+zM908t5cg5tzBsZYgCT2zfo5hrEglS65hxqG+yMZpYxJ282agF2x0EtLINV/t3D/YztllfWuVaKxsZwhJd1EcqBqc/K2p+UCRAXw1vgjGttfC9xx1kioicwMbTsPErfHQVjmV+OpkpvO2Kq/TrCgLusVof/lUr+YMZv8C0Sly2UXEOgYCTKqNKILT4wE1sXeWbj0ut+4WBdZRqsFMART4b7bwGwsSQ4ijXZGl30d2mwjCwFBxGbSZ1w7QZSRdRSHZjBM+eNkPGwamYlsdAdGUezdS7I8cjXfrUvQ0jMPO/NLZ5Vb0aDy61HkBc0QBsEdqW74Nc3IkVbTwdAuL9SHIbv/r5E2H292T0fmIubkxWsn7FUYgY9KKkg7olammV8i+Ylal7cecoTxLQ1rZEJzKY2OOduX3Wq0KOWn7s9gRdjc0EETnLFI4G7ZHHNVVs+l12gSPgyWdu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(376002)(346002)(396003)(136003)(366004)(451199015)(36756003)(86362001)(186003)(6916009)(316002)(54906003)(478600001)(6486002)(5660300002)(2906002)(4326008)(8676002)(66556008)(66946007)(8936002)(66476007)(41300700001)(4744005)(38100700002)(6506007)(55236004)(6512007)(26005)(1076003)(2616005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJ8PlFxYwQa2vPl7u2t5ACkM9whurhW3CnaeN26+ZRduXT3lcl/lwOM6WEam?=
 =?us-ascii?Q?l0MFl9AhbsvtVBJWk4VYsbkyNXi0dgDL32h6hnHQTvKdUMxXKHcIKT3gmiiK?=
 =?us-ascii?Q?HUcYcXIZQsSFE06FpAMove8WmsMWJLoVfvQJDOZyqcEuIa74Fu6sgudss992?=
 =?us-ascii?Q?AW17OiQBLGNGjZlH0g7geEjnUIVksubMVWEbxLBixeePfWaliM9ZBlVb92a7?=
 =?us-ascii?Q?uiBFhJvRPcZEvkGZAwo4WavTQqUko2u7WDGi5wd4j+6yZnr6/yVVONdboKNA?=
 =?us-ascii?Q?dCsbTWm+I28SCXmS39kg2MDF54EqpXb+Bv7dFEHI+gxA5w678LGatUVXvA9w?=
 =?us-ascii?Q?jt3PWcVL+JChZrR4svg9WDY/vfJenHjgEVhsocreiterSFepoNQNcuY5YZ/w?=
 =?us-ascii?Q?I/H9C6bceO6k3psr9OOpbK2LwABMlp1P8aOG9IafsgrolVOS06vZvzL6bFQ3?=
 =?us-ascii?Q?fbRTQ7lj4K2iJsODHhsgxAXj7rLsN1yKCoFBqBEAFXGg1bpzO7vlS3DVPqqU?=
 =?us-ascii?Q?RFY0O8bZyh90GViJywHZjj9axdyESryu3P3Utr6LcnlPOIZLVf5NcaOK59SL?=
 =?us-ascii?Q?TPgUyXpg/5zmi4fy28OJ7f4PYZOUqbiIUGtYPseIsSQtnNZ6yitlIhWg8Kpm?=
 =?us-ascii?Q?PHkHUEazexnE06dEBPucN2kmxzgdOv3/u0sNwYe2r61HZsIrdGGb+O82wpPA?=
 =?us-ascii?Q?kaBCq8Lo/HjKhJzQSdwtHyos+pq8mN11crh+1dI0hFgC1PFgP+1aPlX+Ihj0?=
 =?us-ascii?Q?iHhpFtZa7yGQKIedysQ1pjUlYTVEpi3Tt8ZfF5WxIL1izDRnBxM5+V46L3Wr?=
 =?us-ascii?Q?Q6WoS7VgAOy/nyO04q318ZRZiVQcga3Tw3ga1dXA+HG2KkSes8G6O1PzTnIW?=
 =?us-ascii?Q?33WT95eTPgYDna03RQC57CkuMbAzXBBkFbM+RrFRRVphR5dUKl0ImmVaC2KT?=
 =?us-ascii?Q?eBb1qRKUBxacu2vt3TekraCUkye2/yaKKVntSMPlgpqJ3bwr0JE4aOf6eswN?=
 =?us-ascii?Q?gGLmVGjmR066mIcE00Q+xCOTseo+UTQkU1Zy94RTyPOYWiKQxz6REKNRnhqn?=
 =?us-ascii?Q?3V4BCip5y3rZJX43OnlERDVOkAoUhoxlRA7JsZTQdsKQ15PhiNYJqumNgkNK?=
 =?us-ascii?Q?iR/YigmWDvb1Wg7OJwxYu32cj8K6uF02ooh85yEzVeg8wavB6kgDKQBMcs6E?=
 =?us-ascii?Q?MzNq/oQsT2SFZmb21GvN1lv0aYRaWx4bjVQ2RCm837ptlACnG8Y+5Z74OVEm?=
 =?us-ascii?Q?Ht9skaVTsOvzJu0w42ROxHn9B2o64O9esto4F0RSfTjihUVv5Y4mtCoqnfxt?=
 =?us-ascii?Q?BzaNqHggz/H+gXkk/iAFOl21STo/LSBtduPSt+8ggZmmcgdV+Y5QvvHOHbTd?=
 =?us-ascii?Q?kXLzPmoZdT14OrErE9wJ9HB8FOryyMdyNsfli+F8lL+uDuM+1gAaA0hiwVC7?=
 =?us-ascii?Q?n+Gd1Aw7ypg7n9SIx81k0sqpQHOCYRWlWE77yUyxZ4PZMDlagpJ9srYBRJNu?=
 =?us-ascii?Q?f6vZYovrsfhsP5ZQrWI5Soj640FRSZepayhTBW5vd+Qf86ETwLRxUKtL6wSn?=
 =?us-ascii?Q?ccQRFebt3eAs2Ls0Tvw=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ee70ac92-6168-4650-47da-08daeb67c82c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:47:00.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9rAo2HGmTyltoiMjm5U7EbUMdlGSW/sIqlDnjoBLAkK0J3RezJxMQZPR6AXLgmuk71Hs4i3jb6CRgJOg01mMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 23:19:52 -0800
Laine Taffin Altman <alexanderaltman@me.com> wrote:

> > +impl<T: ?Sized> From<UniqueArc<T>> for Pin<UniqueArc<T>> {
> > +    fn from(obj: UniqueArc<T>) -> Self {
> > +        // SAFETY: It is not possible to move/replace `T` inside a `Pin<UniqueArc<T>>` (unless `T`  
> 
> Minor nit:  `Pin<UniqueArc<T>>` in this comment should just be `UniqueArc<T>`.

No, the current comment is correct. It's possible to move `T` inside
`UniqueArc<T>` (because it implements `DerefMut`).

Best,
Gary Guo

