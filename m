Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E831965A65B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiLaTrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaTrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:47:37 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2127.outbound.protection.outlook.com [40.107.11.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0560DD;
        Sat, 31 Dec 2022 11:47:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaeJVm2QaAiVEaEgi3V5ZcFUNyqbJY6NspDJid9WKCcinMV2c7I3sxoECIR0lOXCC7s1BH0KvRDvfd4rMosSJw3DHWQKo3IkdJCw/sS3rMk2FbQAtlUJMgp78ZWgprp/Ph3rlVODGiPp/x+fE1ysVuKnHSyxXiVZGT7Seggn6dW8BKXUKzuHwIT3MMLnIedRt1eXnwF3+Wa4PJX2YD957Amv5wN3D84OTtyoYyQ18RCp6EnkE3XEchyeZwwUdz4BuiLSK3zdemEp0t7iGFglbYQBwitF06eVbps8i6W5oc06V6mGiZzPh0hfM+3hi+rd0ZFikwjHCqinuN9PlR2MeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baFBumBBaePwJ0rCoAp6y9hQbZJMy9sW5wzCySpcO28=;
 b=W/CszRemgIZ71c6gkcLmkP7FwOe6/br1A40pLMqEpvPrfAmONdtmTa4DrIMjUFsJ6WjKhDC3BsXHj0R7Arb+2yrbjnnLBwyFyQFLEYT7kIeSNs+B/GJGz/BGbHwiZ/OvnHLMk9ZVmSSJ54DpfoIfUSzV/BggaDrOVEgsV/00GuNF0bBb6QazHP73g6tTRPY5avRpkqOry+Tl2mgr09UcKrraI5jKiODR5syk+tzdHkwPK0CCN2/WP4T6IG+Uw01P+kxlIfLrOx5JftnD9/8e7YWS+IUFDAL3bMmntvSdWHH3YlT4vk57u4DRFQ5YfA06wReaKKuTlGXgvltOhRsrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baFBumBBaePwJ0rCoAp6y9hQbZJMy9sW5wzCySpcO28=;
 b=QGHn/Nfb2o0LYyRXsPdP6XnoH9Ygwzrkk83O3Dqttj2vcdFXKmCnVW42SGh+0aF8FVV3gcJHwGxKX+fVY45VGVaZ31TWR+/zI/uvrnDhvEEtYAJYGtnfYFTY+4meHMlGdvztTXQcpbSoyWj/geEuqI9WwReeWqqSe3u42V9lu10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5403.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:47:33 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:47:33 +0000
Date:   Sat, 31 Dec 2022 19:47:32 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] rust: sync: introduce `UniqueArc`
Message-ID: <20221231194732.79290fb9.gary@garyguo.net>
In-Reply-To: <20221228060346.352362-6-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-6-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8126fb-7cff-43e2-d56b-08daeb67dc28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7N5UdaHGASrE9ewTs/T+I1cVvum0qPxwJ+tzr0BFNbaltGFRfiYCLbybWi5tSwUSP6kO0PrV+HJAqg73cXM/BN4DURixDEdwncBVZyT7sRcwvCu2cZYk4IXkcQ1osD20Se6IdGizgg51tDgdZX3GYYBoGsB+BZHF43jGsBslNB+j06BB50JlPDyz8acXtSshDvwR3fxX7rTzzbdkdT2cAss7L5uxYt3pp0HxD3BDUSRmUd1jQz0O1x9X8H/mbIe2Uc0tpQeuH18Yh2xrgqHqlgjNKTEeXgdNp3xyb97aLXpb5Rvj91RVsqZxZOYQINORzafXendAF2UAMfXDk0MQ1w3KDhtCHt3tsRHyjOB+HImN0giZehyH4/fPl/eO85RpzSuwLCLfldzT7Q6YVCKd+Plx8/BE8cZyntJri/IU9iph3QXbME8NwAa0tRzuhfyO/aDJeV7K1D46H/WfjvMeRIjVWT4Q/tL9eWG7zvkbACgaQGph76lSIoaK2k1VXPqlJlvhGGKHfO1KziEF/GxHnt5X7x9/w3nulm/ZIXsSTE/clduQ9UrCPiODiZTB/NvgxfJTshU7NDUIACY7so9cypn41rhNB8koUcPRgduSHOcjSQ+dB41YSRsPBerPkGU3oUlkAJCGp9pflW3N4/YQauq5evf93uyJU56ziGB/EGfnZOHA2HKufHOFvMxDUDJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(376002)(346002)(396003)(136003)(366004)(451199015)(36756003)(86362001)(186003)(6916009)(316002)(54906003)(478600001)(6486002)(5660300002)(2906002)(4326008)(8676002)(66556008)(66946007)(8936002)(66476007)(41300700001)(4744005)(38100700002)(6506007)(55236004)(6512007)(26005)(1076003)(83380400001)(2616005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+t9dS4Gk+CEwStYoDBYgWiyLiQGJzrLoveHjQxYz4ljXwIGcsewX72G+0Ddc?=
 =?us-ascii?Q?AGcX9BOcCI8WgtBQnZVSn36DbXS/u606t9I1s8MhJ7K6OHc1P0nWIIqNV8wU?=
 =?us-ascii?Q?9RnlEBdzrBiZWYVvpDDs57eEW2KnoADQ/+NTBDzmsxj41WbNOaCn00kzFg1F?=
 =?us-ascii?Q?vfD1ucQJmg4CR7uKyXfKhCxplEAS3dYNxEXwbQZFW0w9k6ZFjjgAz9hRHpsn?=
 =?us-ascii?Q?4wl43fzqm4uw+dDujfNHy61/Hwsb0FGNL4PfF6BWzTcQm2CVYtzmmD/mF1aR?=
 =?us-ascii?Q?weausxjAnLqxEhNypP1OBLPydkW64DdTiB9J8VXepAduT3T8BcVxYZndasTi?=
 =?us-ascii?Q?w675pfyU31OANHECduQSB/vstQKQKb75Wa5zT0kgU4iuW4Y00fkYSOhCGArw?=
 =?us-ascii?Q?YLnXCZM18Hn6+PCa7C4ftL7eJXgI1j+IrG3fV5VaAth9cL264/xUtg7oAe3i?=
 =?us-ascii?Q?VmxgIb0oBxGDJOuaoJMABruVxQFK12SJREy+lfcndWe6Qr4MQEqbd08V/P+T?=
 =?us-ascii?Q?7n1EwVFL+AoDEKkK0mqZIqwoFeVhQZIN+qcINou4I2qitNBahkCsuR0ZRJY+?=
 =?us-ascii?Q?/SJNP8/zPbAkBlySFNtbTL1V7Go3xF1ipZ58fwKGCix1qaYpCRSDNPiHx16u?=
 =?us-ascii?Q?YNZ40Q33i7RFiuP70Z6Smvew6UhsQSpZpjdtGnV55ZWlhx2OdElM1tsIHfYh?=
 =?us-ascii?Q?a/0n7bvSjIgiKQfRWIG54bEEqCKHjHpvYAXlDyqydymmYc7pmBpM3KQKMnq5?=
 =?us-ascii?Q?j/SRzjVcwb/BR37Zec6gQt1M+Sl2SwFtXl7biyMq46Q8wqFwtDewdnqSyiWB?=
 =?us-ascii?Q?Nj5qJhtxDhOl0lUJhNxBGE2nhMqS0w8vkDDALIMEjTpHd0J7R5yZEmK9mlPA?=
 =?us-ascii?Q?KortC7ztzceOmEru7xYIxqb3apf6Uwl4k1dwHHnoKZXJmuKI6xxK8epsUjI5?=
 =?us-ascii?Q?Reekz0RpIDsG1jYDe9gjN9V1+HwHel9X6iVETqff9M92Ic5p23FIyZUDsnm+?=
 =?us-ascii?Q?htNMFc1wKJYmjqGhZGB98iEMZDB+Djso88FmCSPhACmuAwfJZ41UjssbuXmG?=
 =?us-ascii?Q?Hd1YkNXnNhQpK7LM2q/wM6bzr/riXqyQQDxcEeHIzScH45FKylaAYHIUPwOY?=
 =?us-ascii?Q?Q1xDNv1RpH5T7UhGQqN0QLp5Gubbcb9YRRxRuif56i/+qZxwsxNVhwSQNtpd?=
 =?us-ascii?Q?Eqhkq1kkX0kP0yJ8MSqxn9YC0ehojGTtzlZDUez492O9/qjllx8HW6igGQVI?=
 =?us-ascii?Q?0stjZu/knX1l8f/Q224T5aPC2hULCAm9TchBJGVKwmFMZHDXBfJmclzk11sk?=
 =?us-ascii?Q?bwTuJs8LSpqJlB3peY2Sa+d/NWAUmkmq99aizqgTt1afbexB7sQkh2DEpZrF?=
 =?us-ascii?Q?HgwnAGm4kvxueoLdj/cm/DL7cJdxz2kff5W4/AsHhyl45XHq6fY67VF0vXS4?=
 =?us-ascii?Q?cN11H+2iBvMVFgO8t3se3zRYHmsJkUR4Xh8jFmpyOxRy5SEa5sUJC9L/tGoZ?=
 =?us-ascii?Q?IbwkS3K6YhkEUphKiR+3JXt5qCqJAbBI7Iomy7TLK+gts2vV6rZILids3u5m?=
 =?us-ascii?Q?Ip4NM/HBFUc8nY/DDMc=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8126fb-7cff-43e2-d56b-08daeb67dc28
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:47:33.5105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4YH0j7ulkqtz6Nv12KneJVHZDCbHtw4e0IidQTJnqoz0uXnmuZl3OJ/TyolJF5ZyH7xu3A4SviTQZLmL7nE2Q==
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

On Wed, 28 Dec 2022 06:03:45 +0000
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> Since `Arc<T>` does not allow mutating `T` directly (i.e., without inner
> mutability), it is currently not possible to do some initialisation of
> `T` post construction but before being shared.
> 
> `UniqueArc<T>` addresses this problem essentially being an `Arc<T>` that
> has a refcount of 1 and is therefore writable. Once initialisation is
> completed, it can be transitioned (without failure paths) into an
> `Arc<T>`.
> 
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync.rs     |   2 +-
>  rust/kernel/sync/arc.rs | 152 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 151 insertions(+), 3 deletions(-)
