Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F084B70E0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjEWPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjEWPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:50:34 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2111.outbound.protection.outlook.com [40.107.11.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F61ADD;
        Tue, 23 May 2023 08:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCGttJo7mPJLptqFL9PRdymLmXf958o+ACyl99Xw5XNkQknOhev12bVCR40qXbuWojKe88okKssxAszhSko2VH/Rwt/QKepIv6etsEd3eiDCC5hLafnpbjeM8JYA/QRTgKZ3sL6DvOVFAu4hNngo9HxMf1Mrw3j/N47/h3GKWiClSqIPQpSvzvyVMG+6WCph9l85XQJ0lMMyD8jT8LNjoV3Ks9NC66dcELLTsw7K7hOt2dXnI7v8qbj82hswIZETr6MvBSgpYMxSx2oJ7pC/edZcYZugDCpXMaM7XRYfP6OQe+HmdaLu1yIId7o5H79vWdK4+7QUO6/sQdVD0bBsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4ZPMDyMfr9bPaNdWp8oa1JJqhgW8wETrNhY9Wz1Qtk=;
 b=FhUwfd5zzbEP6OFKJXwnIDHij11EdZFEloAfLJp9b19e7PyK3oKbObIqQhdvvSx52YNLltmA6PXkIL3g9KnaaDTA5CxmXQrAGyAtuXnHJXwD9xQwaRG2Bs9csdlLCLNz20KfwrH4nbGBFeKU4S0AzlGjpymMFMYH22nGl98+ukolQM25lUoW6cThbJz5Khue9d744JvaU6ldaCjXS10dhqVPvXndDgiHHW4xF29rQfGzz5yak6zAavLCm6cSXBcaRaRuEnVaZ+5dgc4tTV3AAB64P6z21sVbkA3F0UzdTsQhs6JAj2NzEmrSvoearJfNB9SRJbba9NXU7z1+NmVV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4ZPMDyMfr9bPaNdWp8oa1JJqhgW8wETrNhY9Wz1Qtk=;
 b=QN3TsHeIBhQviv0pcN6XGqtg5GTgEkW1KOPKHeaXlrbgK6+AQ2cu7Oa1CODPkfSV3/OTcTgNqA4zXVzRiDwFE73oyRLxAgPTOTobrgWaUMtqB8yIVIyyQFJWLgCcxPXyMxDbc2XgXfM9Fpd/vWT9K2XYk2Qqt/r3dtZqyJbFJkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 15:50:29 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 15:50:29 +0000
Date:   Tue, 23 May 2023 16:50:27 +0100
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
Subject: Re: [PATCH v2 2/4] rust: sync: reword the `Arc` safety comment for
 `Sync`
Message-ID: <20230523165027.71600b4b.gary@garyguo.net>
In-Reply-To: <20230523144418.1250547-3-aliceryhl@google.com>
References: <20230523144418.1250547-1-aliceryhl@google.com>
        <20230523144418.1250547-3-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 509dfd14-a1a9-4e1a-4e1c-08db5ba56f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0c7EHY5b2qYPlgEhPjs7i5MiQXgg1DnVrq3zfU056jxTcuxxpxirU+c2Fz0LhtmUAJis+Qmd9Yg+7h88Q2QTptUnVqAPcUAL4lfrK9ZICsqgJDJ96iTbQ6DuKEpAXv5XZAyERyhx01x5smeKylc2bzqidGaLFBN04ykJnZgwCN2cAOUE57khsmBwmw6pHgd3ET/ubXcy1PPKyygiM0xUmBiNhLQgX5yZ73uaAcQkxX8S6HGEpGtjECpqcqqqFhUFswWcYiAAlZWEeO/HB+O5c/iAs3DaLbCAhqBBF93MPLTC82wlOJN5/PQO+cApvzGwwJx/iO8g2v/rsNZ38lZd7ZffAMQRgHEozS+BKwfH1gXmZyKxOrrESPJS0il0ht4a07yPOkK1GhHv/+YhQrTO8bDfxbvnh7UC/eD8yMPbJckbyNBlxwPbnnCT4B102eue+EJ1rdqytpPvOO7Em+hO4ndOX6J1RWiaEONRp2PPNKSNVdbaw2tXi1sHXYoiC7BU31Ol95Yjt4jEl9x9A4zhIX6OA6FTjkybMchJof9YLM6tOCH/mXgjlZRl+7N5M1yTf69Tidi2X+K1gcYPs2fLcnBrVIdeVXCIsDEE9G5t7BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39830400003)(346002)(451199021)(38100700002)(86362001)(36756003)(6506007)(1076003)(6512007)(8936002)(8676002)(7416002)(2616005)(2906002)(54906003)(478600001)(186003)(4326008)(316002)(6916009)(26005)(41300700001)(5660300002)(66476007)(6486002)(66556008)(66946007)(83380400001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kwnMv/xXoIVNknDzsU9VP4CxwBEroRtudtsM1dvXJJhUWqYv7C45BWDIFdvV?=
 =?us-ascii?Q?mvqjJ9mPf7lwZyVmuR7BAXhXrU3yzJ7QpADLM5jlT88/DKlrmeTA48TmxTYz?=
 =?us-ascii?Q?0/ApmEwZD4iIbE9Az21CFt3NgeHIKnDETNNKCaZmiZXZqtzpIaDJdbZSffSE?=
 =?us-ascii?Q?Hs84oy08GCrsxaoIyhrlBywohFxGYqL1fJjI6Z0Hav3zd4qRYnczBFltjzM4?=
 =?us-ascii?Q?xMr7L8lyB3B+GTC5MaM8bpAvBmJnJqgNKjUlviUdZ69juVlgmH/hUtW0+ElN?=
 =?us-ascii?Q?OyVgGq5A7LwkHzmvw37sbZl/tqyT5y7k70TdNXlv1XrTEfcWBLt/xS1o68F7?=
 =?us-ascii?Q?HBlIZ+1StAbJoJP7uJjv6QYPnue4uXH+VALcBpV+kMNwux/Jt1vKbEpa0de3?=
 =?us-ascii?Q?lV7TesDhl/EOBeFRQSpX+JCtacpD+QCTM3PPeQDpLa5rKkiM1fop2wDMa/uV?=
 =?us-ascii?Q?OkqZoBnBr56fUa4GydyUIgY8WkIkg6FTmUoIsg+fs7xTey97qIbKxMgO+wK2?=
 =?us-ascii?Q?FeUOKYsY05GrfWoPbrPHIo6PzsEU2KdGJ8pUdforRmkw2UK9kP1d14dLxpch?=
 =?us-ascii?Q?6H6QbpQK3dB4YwKeUa4QDkXyFjIHC9JXKq3HhXSRL9QpepxWsTUpg+AtRNXs?=
 =?us-ascii?Q?YsPqXaDZ5P32/foWC9FDlp3B0MzNiCANyN6/UMYNr2WsRxpxGfEMl+BfPqTC?=
 =?us-ascii?Q?/Y7yM9k6ek276AQlWlb3tFMs27m3jYjXzKBDW7txuPW666h8b/T9RGDRh1S8?=
 =?us-ascii?Q?OJp6QEeJ9c5B8y5E3Baiy851ZloDhkXG43TIjR4MoWCfFbFsnrySh9cx/mj9?=
 =?us-ascii?Q?UrrSqU81e9DaAmooC78M9pvxMOBAlmw1mIH9qCiSPjwWH4BOHLx8rodJWQYS?=
 =?us-ascii?Q?6KaH/Qc7K4UQdYC4R5iO3Vx7+zTERenofFJoIoCD1I9VZk8gGeB2vJ4O6w4z?=
 =?us-ascii?Q?LD1UDchiZXGnhCG5a+6IS6DLijPLkEvRMDHtbcTabbnojdqGDUv47MVm+mjx?=
 =?us-ascii?Q?k0EfjO1IRBN4Z2sSEFSHpgIPfVIRsAjMSWYPuAbUd2ulZeuNOs6H3bqRkZwr?=
 =?us-ascii?Q?PYwxJ2Ss73FcpzwTZTreLut3CRYkHW9BPJbJ/aU0kO0nomZPhjCbPnre7PCv?=
 =?us-ascii?Q?ys1InelqA/i5vbmZaQ4GX1HyVgKIeai7u+61fSjy5ZURsOOb+4lV5zJlkbrG?=
 =?us-ascii?Q?mxAdQHA2kVcXAts6Haow5r4EiKho47vq4IoJC78bTLkhijKA320jjzwOB8bh?=
 =?us-ascii?Q?eCAAhmp+Ipolm15gx21DdQLmAj7LSABpwQ+IVuTuy4UvDIgd5bulo6xakxoF?=
 =?us-ascii?Q?0z79moPmFgHol7VLnS47xrojNwohQNin0FjNPpxDZhPnLZk22R+u5567au1t?=
 =?us-ascii?Q?/JwuXxCR4v2+Gteketo+OXZnjGac6hEFSCLt1CK3Kcb8B3wu5C62qAGTWbNQ?=
 =?us-ascii?Q?HLh4v0LlyqVBxfYe3NwUejtH5k8kjrB+VE53vPFnn9UX5Y19BchTnqXUco40?=
 =?us-ascii?Q?jwa6chGCYOaN1tuz+wxr4okkRzAnChZbBYFVJjEG4xHYq/+S62O9akcQwq0k?=
 =?us-ascii?Q?GIArN4JQYfSZvfeAQB/WEoGegEUP4ctcOp8ii0mm?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 509dfd14-a1a9-4e1a-4e1c-08db5ba56f2a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:50:29.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVnHu0MdMcU0Wf4rkkMCVDHLpkOMMrISZWOKZTUI41iO8TmmlwifvcF8Fd8xQqM2W5103ESjIZ/Ks6xYVY+rSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 14:44:16 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> The safety comment on `impl Sync for Arc` references the Send safety
> comment. This commit avoids that in case the two comments drift apart in
> the future.
> 
> Suggested-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/arc.rs | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 87a4c9ed712b..4d10f9868d9e 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -150,9 +150,11 @@ impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>> for Ar
>  // mutable reference, for example, when the reference count reaches zero and `T` is dropped.
>  unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
>  
> -// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
> -// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&Arc<T>`
> -// into an `Arc<T>`, which may lead to `T` being accessed by the same reasoning as above.
> +// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
> +// it needs `T` to be `Send` because any thread that has a `&Arc<T>` may clone it and get an
> +// `Arc<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
> +// example, when the reference count reaches zero and `T` is dropped.

"for example" here implies that there are other case to get a mutable
reference? I don't think that's true for our `Arc` since we don't
provide a `get_mut` method.

>  unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
>  
>  impl<T> Arc<T> {

