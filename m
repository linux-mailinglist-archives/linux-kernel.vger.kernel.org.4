Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738EC70E0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjEWPtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbjEWPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:49:10 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2134.outbound.protection.outlook.com [40.107.10.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4077313E;
        Tue, 23 May 2023 08:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dustC0yErM3WBzQw2UOlRHjLuM8r9dBhntS8ikEusHz9PcEG6jO9qJCMLj1jH6ylSBi5qWpOrMuJw4fFDEcVhgtzLBnoeqkmL4iA2BkN+xm3l59Vyk6DqCFC86pXBwW9KbMWBdROx3SgPDfBe/9m8L1jd9lr/0//mBHWxJQ7mRMp/JwETyAUFpaYWoNI6tKAkjMWrYPwFySRLQeWVOXnIK7JLBM1MFLQeFKfFhdtatk/gndBaUpr9ktp6PxXHnSBUrTvIf/msQ0uTI8z4ax1Eo/7249Fn7uVYqI2m1+BKhhfie5jvj+4xRg902ahYeUrEfZij6+yaH74+Mk+ct7arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ule8LLWJux09mvVxsdMFJnc0Ga1csv0k9sIpnEC4BE=;
 b=ejkmeAYa7+iKKemgkEmvIuBBtTUQmEkCGXwpAqslcnyTZ0s0oFWedoYYclUTES53GVRKyQ0m15cwrK59otDKAYEycYVYmOiE8v9W4JnleDsYUvf+9X0i5D1Mkz86z8uUvDAYXOfKEOX+da5F1bsn/tHWrUbyzoy7CuJfCTSupvpCKN8QWDK9ENchmC7DyAB/h0RC/mAwdMYLUX9oHdghxLWtXu5AuRKdxJW+jjsb8fmsk8Xp+3OHXlwwGrWBwFlL/btOKZi59nzWKn4Rmw1KS/ZxyJ8OfLSnUAO7yJAKFVrapSLjHU85RaXtBn87CKWoQA9o6yBhnvii5X0t6PySTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ule8LLWJux09mvVxsdMFJnc0Ga1csv0k9sIpnEC4BE=;
 b=FeP70biDxMzHjlzv+IR3fpOhFTLzFnOMpzLD2XSkaR9pzQvervu/T+5c0lW+29APXt75/1DeMCvj1l9PHtURsPoRq9/sLLa87p17psWJYohIS6jvM0dy01Tqkka5Sri7KRYMyRr008Ep96OXkmf/exYsEt/fNoWzXoxXVf7ZaVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5091.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 15:49:02 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 15:49:02 +0000
Date:   Tue, 23 May 2023 16:49:01 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2 1/4] rust: sync: reword the `Arc` safety comment for
 `Send`
Message-ID: <20230523164901.2fe8621e.gary@garyguo.net>
In-Reply-To: <20230523144418.1250547-2-aliceryhl@google.com>
References: <20230523144418.1250547-1-aliceryhl@google.com>
        <20230523144418.1250547-2-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0415.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: de586611-c434-44fc-6e7d-08db5ba53b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqrvMMHl8+yZgvh0Tmn8P809O5OfdOrMv3+Fac8pc0Wp191/jF9Jpva4acX/8b453HD/6kCdK8STWNlEdTJD4AANYQg6tU0qeF/LVIKbbq8GlWdSEoQjNKSCcuN7GzJnlPXaMHFQMY28NSj1x6aHUcjHRC2Rl00egAy76wZF1B7h7lLmzSkWYgaThHzmdjQrldSrR2N1SOTqyY+hkUlZqQ5+/ijQVuoc5u5Ms26F9KQ3XJ1tWyFdneGKaR/d0MS+3DD7P7Z2+v01Zy5u8KlFriW89qZFyHPHXH80oWf6MPfKHqGrnC9uC13IgPKd960nukwbvH2VuQjEgWLs8dcwOhMAnc++lRg+anJ2uMD1DawDH1lU/tKLzuvyg1xprHVTiLYbQNLYlRAHNoM3bN2R/kFRgMgKU/FmFMoHoxkWPCFn6xzMp6Be5SyhWmqGjk/GylovMzNBq1UH/DC34KQd/gBV7HpfZGqlo9xRH5B+ndPFUd9Qud5qz//SdfaxPS5J2kxQFUpOHpJjx9t2ak+nhfSGt/Fzpgo+xLgW0XaabB3hekNh9uQvRWpFsb7IukUgdPvvQRDtNSq4jBZYqvK+MMPRcentx56ASowtujt7gkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39830400003)(366004)(451199021)(5660300002)(8936002)(8676002)(86362001)(1076003)(26005)(6506007)(6512007)(2906002)(83380400001)(2616005)(36756003)(186003)(7416002)(6916009)(66556008)(66476007)(4326008)(66946007)(316002)(54906003)(478600001)(38100700002)(6486002)(41300700001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H3J0J+ba/dAAroC6b0bnDIfjh3UH8docq6+Dg/mQKd0xLmZbQpslX7NHba+4?=
 =?us-ascii?Q?E0hC/B6MpFAgcVRfk+Ylkr8wAVYRvjkahlN5zPSLhW/Kb62wo5fLadsrXkJF?=
 =?us-ascii?Q?SyPEZnuXrc3QCzUUOBICzbqxVQfDZNro+aX3TVB4fABP3lk9N2TOeOppqD+j?=
 =?us-ascii?Q?E10lLl2FZm0OM1wwFp/sPX9zeY4ZHfSF43zUYCcJpdKPepUT1AZIMUj9MYiw?=
 =?us-ascii?Q?V2i1A2zAw+ohzBI1RE0wL4IxLJltjKXzOFYXzG5Ey4c+lWKiZl4klvB2pRNr?=
 =?us-ascii?Q?/msd20I+Mlyt4qGUbmmZBibi/hxN9IthtsEaX1Zv6z1p2XiKbzlD717c+F+H?=
 =?us-ascii?Q?SV6OEdlb0oiU+BGiVXRle4ZycHpwYLh09dpW+djn394uW6iXQwSBsmZl9rJG?=
 =?us-ascii?Q?2Jaxds0jq+LECkGqG4WEq9YJJZEypepFiIS+UvivV7xP6s1iBhWOtG9yLtI4?=
 =?us-ascii?Q?/G0QZKuRxU+S3whl+XurHmfWourfOwYL0HCvnduXgboWOd7JTuCflIAGReyN?=
 =?us-ascii?Q?t9tupHxJCMbr0FqSm/ZEi2tWqamaRfdLF8vwMe3tAtNkPNXYOgWowZMphy2h?=
 =?us-ascii?Q?iaENck33S/oHWlSfwD3BK7N2knmz44mJliPM2+If+MlsEtkvVXFGYmQMGFK0?=
 =?us-ascii?Q?HQrwpPJUOHQ47otoCgpnAmSmQ0fk/3U2eDrj3Qb3UdhAk6n7v3S3WfF7yxmg?=
 =?us-ascii?Q?CC9YK4FLHqgw30JgY3fQ5iXHRh8ywEGXXmYqBpn4KYqrCnXZOS2HDXGuI5MZ?=
 =?us-ascii?Q?zbcEQYEgZFLHSV3vmzYZNWbAQS5wOnY3Bmk3clpL/rm9mTgvFo5GkaDxnQzO?=
 =?us-ascii?Q?pKwWC94v+vgqSNQM2FroCjp4UElFQeLOhu8HLCIb5aP4K/4gRNKbVC1aouTC?=
 =?us-ascii?Q?AOPx84zuwGu0bUHaIzaptulFtxjgWtTExL5cWcO7zn8KCVT+UYrY/PLedSK6?=
 =?us-ascii?Q?DxRqQRo1WA11IL+Oc2Q4GpdyDYWKCskO8U2Dw2jISnbV5n+7Kic3GIeU93yo?=
 =?us-ascii?Q?fpIIKtSWvorfqchec/2nN6IcqtrJZnLHDGOMQL8AaHbFaUvxVOwN670SkQiG?=
 =?us-ascii?Q?jb/l8xdY92qqHB31d5ZYlJ/d+U2NUyqPKgqVTGLhj7szefAdF8EGgxBTTnZI?=
 =?us-ascii?Q?LCw7TbbppmsmlouNmWLcTHkM35T3iWmROLQP/5ipmTlcBMoInlu50UpVoXIR?=
 =?us-ascii?Q?PStq3yeSkTEUXvulAC8pBtnGsXHFEW0u//CTheXxan+DCeZonB4py057mywr?=
 =?us-ascii?Q?C4jYMQBiQ8PNOBi7s5F7MElQ1fmeHGObdb9SvS0VHappt34Q6hZlndT3PG9i?=
 =?us-ascii?Q?vyMepGRoRAWf26nhHZF/85bL4aLEDTqiEA+ljc8wGiWY1wwr9t5Zy5VTz/GR?=
 =?us-ascii?Q?i1nvPecHuHI8XYkuyz+Ssj8ItwdHdJWdYcd/SnAZVDemKy0zy2dXJQg0qosj?=
 =?us-ascii?Q?xtEWuSBGlNwLNrAaidPtcIPRApOTaagMdSjKz6VXtl32uFOYwTtHvIb/QrrS?=
 =?us-ascii?Q?GHGmw9hUAOEvIHpYsRT0o18qtSBLh6Wk7GR6aRdQ9E9coMmt8WHBRet8r5Vt?=
 =?us-ascii?Q?/r84Yd89viUStU4A6VifyDKQfdrcUfDQ8SGfR9VO?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: de586611-c434-44fc-6e7d-08db5ba53b69
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:49:02.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCoWl0tGDXE159VEq2t95zWRZek45o03YuTklOvFq2Q7BUL0p0UPbgxD4eEUVI5z/+1atmlOt5Gc9aVtE9hNOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 14:44:15 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> The safety comment on `impl Send for Arc` talks about "directly"
> accessing the value, when it really means "accessing the value with a
> mutable reference". This commit clarifies that.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e6d206242465..87a4c9ed712b 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -146,8 +146,8 @@ impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>> for Ar
>  
>  // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
> -// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
> -// example, when the reference count reaches zero and `T` is dropped.
> +// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` using a
> +// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
>  unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
>  
>  // SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the

