Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE316E792D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjDSMAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjDSMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:00:11 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2125.outbound.protection.outlook.com [40.107.10.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5515A20;
        Wed, 19 Apr 2023 04:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH3bwqfQS/oxirgCcuZrjAqxMyGYy6O2ALhW+boHIB2uwwW2WVccMuz6Fft0MLj6MviK2Kb5qbr1EwlaptFyQsVT44GubpswLfNZe6Qx4SVZp3wPoOvnYxQeXAYJl6D69GOPoE4qOKWt2/j5FI1V+yz+75X9jyptHln6yuaezh1SbZlYyB6Dq52m6BMWRuPLAFwqI914ShzvmgcGKFWKa2zxLGsY1TUNtH4lbS71HpP0Tdq2wjN6ZSU6hOIcF2bZ3BMneXySWZhI9E8KJGd2YKVIBDkYR7l3iPeUgYu0+jxI4cWyqdmhdBxCpeAX+8w2TKVK4K5vqWckYlys+EuwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TA/9vDyN7sMQN7SAF9KO35CktB6oPNzKKKlBIJG0a0=;
 b=UAhrcW7eoseiZvss9V5qYYPARJVRjGifxIVrLUML3Vd3QOZgz6zYDO5euPNTo+AxcT9uEtSssx2mHMMot533PWuxvItMiAbMfOOCzyWGUhIu9cX8aSWV8HPBKDWRknJGq7511o91d1ALqoWBShWXzakqDI+EsQ/sFtvAcFYwR+wL5ymjlt291B/DpWNv57KgR38eFsKeD1nPpjcwtx0/Cn1FiuF2mGHLclwDpkY7cdjlR4M88Whchn5yBpgLrjhlG0F7B/CsY/ozLsdI3pEkXJMcvuB/0hgjJxi1r+1DoiSLmNqz+VwJiOwFg1dZLsAYFtQpe0PmG8Q9zjiYsCk+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TA/9vDyN7sMQN7SAF9KO35CktB6oPNzKKKlBIJG0a0=;
 b=zMKUSiaNvv+NG97tur/p8qp68vVeSRp9kK2PWu8Bz4Y2E8ILW8192oJIRxupy0awvnAHEnr8xSaEZD99HLzBQIEakU7kKxbP7bkf5l7ZTnQEGXGKgCRarTYgSty7rKjgjWwWQatvoYYacI5s2rDe6iuYjBvnhSB4Yne5Tli0FSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by CWLP265MB6321.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 11:59:40 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1b25:7ea3:7339:6a0f]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1b25:7ea3:7339:6a0f%4]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 11:59:40 +0000
Date:   Wed, 19 Apr 2023 12:59:39 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 2/3] rust: arc: fix intra-doc link in `Arc<T>::init`
Message-ID: <20230419125939.5249e437.gary@garyguo.net>
In-Reply-To: <20230418214347.324156-3-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org>
        <20230418214347.324156-3-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|CWLP265MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 59098757-0994-4172-7248-08db40cd8e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqJtN+0HMvhVTixIepp0KTe4kdrxjqf8DZrjsLRsM0EmskYCHnfW+nV7H2wjU4HO5tYtqbWwqH8LEIIC+1vxa1AeNNrulmxG4uxc1borcmH2aJFOXXrUjLxLP4PShKSDydMLIcWqSDZLT03Eh/a7TlBOfEFFEkqpzSZ1gpXyYMqwKBtv+R9t3Yx3kS7sOe6jIMsNLzRRJhxJ+4+oljp9Pzg33x3WIZhyccPhlyGCXyTeP0qis7/zjG9getUQSWo1Uh2VjgjDjq81fnH/LK+9n6sOhefKHydg1F2brRe8R1H1q/USIqyibEDXxZYSBWOZICra741yhDeDOjN6dMvo+M+SGSQIr14GN/2/592pRZmn/9+vqatoNE1iP7hL/UYz/dbD+OsC6RTefq7BB+YWuM8qiAqx7wecscX608cjLEoq2rPDqMIL3Yg3h3vm3zdHQQqttU7le/0CLAUgpDRCROTZJMeJKDV1InNJ4EjICmNL69CuA6InPTVUy2CByK3GQIBmt0EkbmXGSXG6NCA0UownoHTj32/3CcrEapM8IQ59DOHI84m6dCal54DeTP3g5K7TihHmuR7wOHZqSXaRPNcSz6od12Mb4kzIXmthy38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39830400003)(396003)(376002)(366004)(451199021)(186003)(6916009)(4326008)(54906003)(316002)(66946007)(66476007)(966005)(66556008)(478600001)(6486002)(8676002)(8936002)(41300700001)(5660300002)(2906002)(7416002)(86362001)(36756003)(38100700002)(2616005)(6512007)(26005)(6506007)(1076003)(83380400001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zM+mWyN0qyMZ/CLHbavjVDEfiCgcL9LpROTakxFozdnY9WVaWwZH+ZzpNxBK?=
 =?us-ascii?Q?luSUF00iKO/5VgcJoGWhdFIr0zJ+zvHe1aRDrmQC0pWu0pXKTlif/jh/UZ02?=
 =?us-ascii?Q?KlEJdUF+sg7neSe9BqBBkrV5mHn8VfHaAw/x0Kd99ykd7E9dFmB53872vaEC?=
 =?us-ascii?Q?CFRhP7Wr8YlDrExMujBebHbAJiQ+H5wfAg/qdCbFwYu+lHk6kzoHQs9IO1LZ?=
 =?us-ascii?Q?+HxlhaVULUlOHQAFOgkXlbeuoe5QDAffXlzurfAZxkq75GWpr3e/Lm1vr9VP?=
 =?us-ascii?Q?JFhfzDvtTnqXDP6TdaZOZKcDrScEcXhZ0iWPlxCAvhDyuhZqKUfWtrZYrJFY?=
 =?us-ascii?Q?H9A214a5E3LyzrXvQ3M37ccDB1S6H4vElvkYhh8XyjmLBUC/3rAdSYnGOfY/?=
 =?us-ascii?Q?ft239r0NRkNJXt9FeRKZ+RdWOoDHi7PgKvoB1+Z8Hd0xvH+OJxXjwWPo8ssh?=
 =?us-ascii?Q?r3Tq/yUudg1xZEhAidm6H52eCiU5IMSgYIgVQHvFN9r9tMNHgFLCvw5in3K3?=
 =?us-ascii?Q?pROtQ73aP7Nbi6fBAoV6oSH14Cjci/pnl8fVWeqQKkTWF2LbiDSJ+YIOXBS2?=
 =?us-ascii?Q?7WHPI5039gxgORpyLeiwS7THS9gCSebyA7CViY58t0rCiBKZgY8b86BtlDYu?=
 =?us-ascii?Q?OOZS4qTtKWIJ4YxKvWDGnF8P/taS5ZapyPUvy2f+18L/BYzpNDlmZj4kcV0O?=
 =?us-ascii?Q?FAfTpeK7YDOwZBbWfM4fXYBtl7zDCp/KV1vDnv5UQTsNt/sR3qnsUck34iBp?=
 =?us-ascii?Q?DvA3Djot8Mwp0Of5034wX11BuPxs4cJVee2D1N9x/Oa3i9vdp7PDOhKswZ1x?=
 =?us-ascii?Q?aMQ4wTDlELaL9E297/roConxG2GST/j3RywvL6jl1B6EpBD4BRpuwy/s9hpU?=
 =?us-ascii?Q?Ukgsj1X616B8wA5ePaZgqAA3B1HnDmtVw97fPdBXUk8xCvUpfhAB5cFEYRLV?=
 =?us-ascii?Q?wpv90tj5xWXlnay3q9NrD8jmBnMYIaGHbQfd32P5av2uzFIaLdvHkpqX/wDD?=
 =?us-ascii?Q?RoRs9+dsnvIh1ZyprTUZtHZptgU28hIObcOYxtwsNrQM+4Uz4PhKUNb9MRRy?=
 =?us-ascii?Q?6NCmSEXKFmxsgeAkmFnv67LBzGiWb5/ayhisJpc3S/tSy+Dk7NMWpBw+UMjb?=
 =?us-ascii?Q?p3V9tR8izmbLolGt/5qjizRlmmnbMVWw+2dK4vac0VZKuxMNQGXuG0MRFWeW?=
 =?us-ascii?Q?5VxHfR+hv4zk6Al+EMxm8sG+aYAiNm0mzXlxmFS5BSYBI7cDJ+3Dlel8wjo8?=
 =?us-ascii?Q?OhdXciwxhKt5r6CINx9SxXvoU2BAIlCup6hH8ChW+pR+GuWrPpRM2925stMA?=
 =?us-ascii?Q?Q1RfFwN+jIKITKXpwC1Eo2dq+omd2BV4QAj1OEQzz2IPrrwxH4K+sbZvNJbA?=
 =?us-ascii?Q?LLrG4JY54ohaT9z/R4nQk0Y4zp+1CSFvwnmj5V8JL++ZyWvdIMN9VOjJHnOc?=
 =?us-ascii?Q?Sgn7mw6Zp+rmlUJnxK6doPHchgyvWoMJ5Oy8ShEANTCDd0wKaTZgkCRRM+bZ?=
 =?us-ascii?Q?hVzpjczCZnlIAkeqvgiXs0JOZMgCf1M6lmnah8CwCMT5Rqits1gg+t2S61um?=
 =?us-ascii?Q?N3uImWgrjRLiKJv0ru0h5kXSa8QvEgfdV1xCBh8A?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 59098757-0994-4172-7248-08db40cd8e7d
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 11:59:40.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4albVFBct7iEqoAq5DSYTnMCTB6vxnw6DRsras9xEZ0FVHDaC392PtR6T4HeVJoNwr6i0mRggf2G2DQcSafw0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 23:43:46 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> `Arc<T>::init` refers to `Arc<T>::pin_init` via an intra-doc link
> using the text `pin_init`, rather than more explicitly, which makes
> `rustdoc` point it to the `pin_init!` macro instead.
> 
> This is required for the compiler upgrade since the newer `rustdoc`
> would trigger the `broken_intra_doc_links` lint [1], but in this case
> the macro was not the intended target to begin with, and so the actual
> fix is to make it point to the right place, regardless of the upgrade.
> 
> Thus make it more explicit.
> 
> Fixes: 92c4a1e7e81c ("rust: init/sync: add `InPlaceInit` trait to pin-initialize smart pointers")
> Link: https://github.com/rust-lang/rust/issues/106142 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e6d206242465..1b0734fdf6a7 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -185,7 +185,7 @@ impl<T> Arc<T> {
>  
>      /// Use the given initializer to in-place initialize a `T`.
>      ///
> -    /// This is equivalent to [`pin_init`], since an [`Arc`] is always pinned.
> +    /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is always pinned.
>      #[inline]
>      pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
>      where

