Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3C71F07D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjFARRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjFARRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:17:53 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on070d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe15::70d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C953AD1;
        Thu,  1 Jun 2023 10:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyknP60WK4HDmdzY83qrz4MhedImsugd+UV0SPX/34d8Oh4pMZQP+x/GQfTcJCCyGzP133S2ZZ/Bars492AzyYMYZvoUsa2Rn+683jM3q3Ty3rupuBMah5mUt4HxAGVY7gozMWRrlvJ9XHTFIb12FX7IMUFsjN79oqi+w02PKdgaBEHmIgvKPL+2wzIRH0IeokbHy/BVcPRM1eqUgUbMZ3H0n9/nYBntBcMrhRvT1gFvWCKbKtCNXvCtesngHW09GnolNrToR7cl0PSW/JXR4nreQ+VtDT8MhfAy2jC5qkwfATELjrCqIjF8gQ1SnbtSARq1vf2hJA0/bGAQnrSRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC5X0yvtRGEHRfEo+5FeXpbdYywWFg7szHjKqliUe24=;
 b=iK4XwuSj9D0nNz1b976vwgDbRL7eMPzcSwNGPzMFpY1duBfORP23npr42SG/mRYq6J5MszBU7gxwuMnnn7KPRbs/Sv605+w83A2IIrPuhPmO4Ox7d58vvapFSnXPqtLp2K2co2zUDLzzjT6MELxYZn+9E0focerV9oHqVBda63lYNdaVBEBOf3O+4yPSuG8SUSPQrake6KWa2xT/EEFMouDKSKjvqSxshmGy5VqXvJG2V4K/w2opIk01btaP5rucvO/B51D2MEXk/NVHG1lMAKQOHfcE8f5xKtVIU66x1+DgfzlK/qdb+/LRANKKKmr+cF7QqWA9YoH5HgHHLSmSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC5X0yvtRGEHRfEo+5FeXpbdYywWFg7szHjKqliUe24=;
 b=z38lQPm4uPasPJ34hlGp1UUNmfR38mls7V/2W+HXayVoVEGLRTSSF8oCTtmhvhPNphaGACl3DweYEJwCbD3eftWLqbTDrOh+0hwO5ctmpUbHYDL5IZJBnJh6LEYEUIkogq+v5RwLSAq3dTVeQFSIbriB+CXOMUkciMGElyP0SkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6866.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.8; Thu, 1 Jun
 2023 17:17:47 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013%5]) with mapi id 15.20.6477.008; Thu, 1 Jun 2023
 17:17:47 +0000
Date:   Thu, 1 Jun 2023 18:17:42 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 2/8] rust: add offset_of! macro
Message-ID: <20230601181742.5538460f.gary@garyguo.net>
In-Reply-To: <20230601134946.3887870-3-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com>
        <20230601134946.3887870-3-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e81a1c-d1b0-44a4-5ccb-08db62c41edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLAOdLEFfkbo5BMargsDnBZuY643pMlvdPkMrtURZMJxE2nmC2xgcdWu4gUdBlqz9PwY/FG8YcGqtYNOMj0kXzRr77uGvc8os4I3/9P75CZkYOU24fgBCyU/nz5XjNri0s77GuctOx+LEzHA9Bl1lcTzmbhZhnINCxr0WK+6Yuo3hPJhn7rELl+M8aJBU+KbJasCEOTw/VceRGfJ8SNJJfrMM7yove5zQdME17V4JnINBZ/PmNqCcLQlucq2+UZgKl0dr1izenLW78KLTvpVEuqLbjE5TLcKfhqbVGxTJnVcIydNityJ10zGnc3DTK451CN5xWK2XiXViZ57HywPG1i18bQeBP7dMGQcjoRJG0b6L6ADYe0LEwK6hacN1ommCDmptEU3YOEy9KOyGuBwG9+eGyG+Wem57E1dqY6967v7XdDQv9B44/68bpa6KfCWKkKsUiqN+Cjgr0tmQr+mhv8xkGWXtneKP4J4O2TKlJBD0BTJL1Bx8wr29vv0TTOX50bAveyJu7dkGB22cv6Yj7U0SvKybjrMJVghKoF3Fzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(136003)(376002)(366004)(451199021)(86362001)(2906002)(6666004)(66899021)(54906003)(2616005)(36756003)(6506007)(6512007)(26005)(478600001)(45080400002)(1076003)(186003)(7416002)(83380400001)(38100700002)(6486002)(966005)(8676002)(8936002)(4326008)(66476007)(6916009)(66556008)(66946007)(5660300002)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWrxhYc8G4IHBPwvm79fD8PzOGAS7pUNIDJmzc+8PIXWg27znC1VNqkXC5m1?=
 =?us-ascii?Q?qECxIZFxQIEPcX9LKeVNiX3POT02Lc+q9ppzSBD9buLkFhdFs7tHPSva6TuP?=
 =?us-ascii?Q?sM3KFMk1L1oBCFCPpt25TSikPvSESTeMn4tLw4FBUTlvzcKPopj0Pox8GC60?=
 =?us-ascii?Q?VDHIqvmKXoCN5sL6xz6v88YK0m1uyLPeN4GMR0m88EyKeQcPaeADckRVIci6?=
 =?us-ascii?Q?pkoB+ofyVQnga94KayuAG38wviAtV9hohqAgAke+u6kiebWBWGAO48uDaih4?=
 =?us-ascii?Q?xICGBT0t48ltOrZkPr27YafalWGdMMdg6XnVAv2be3g3Gk++u0fqZOsfA9PQ?=
 =?us-ascii?Q?cJfYimGb2j+rOr1sadgKbkQD/FlU7mT9BkxD+0weOy7qlliAKmKUshQmRJg8?=
 =?us-ascii?Q?t4qSv/kgLK0NhzQAYtihS9Vwgt7mqqalSubXwjHZugge74F6v1z7d3rrtTcZ?=
 =?us-ascii?Q?VLgVAOPQwGekSJdgFBDzHfvZZY5ZB2wZyB8fNQyGl4rylbiSaXETaTHquG5Q?=
 =?us-ascii?Q?6uehE0FPXg+iJVN6o6kRphwS9YXuwohGggXCUd2f05POj/DMSulijGrVjjWj?=
 =?us-ascii?Q?vgmppJpWlZKLNnhtAfo8dp9b5fUbL3Ys8cP1gP6gDCpNohm13wXSOtXXQqqq?=
 =?us-ascii?Q?yCh6AiKFJh+uIwPAgAQtbjR0TOCL1J0l/O5ZaeB7tzsT2VlxbP7eQdLC2Akb?=
 =?us-ascii?Q?ktCYyobkFvXHhZr9rPRuwHDm6a0OQDBG4A6lMTukHB+oafO6b7qYAk/Mj5t0?=
 =?us-ascii?Q?Y6GRzyIpdUwV1YJUVHbE0qsgV/M5D2qJNMbVvp0aihkwZMOtyUFige/QwqTe?=
 =?us-ascii?Q?Ddmushq5tdl4+efGocwZSaMXZ32cVPwpKmL3hUN8o9NzQPL9MH6Zvyl/4uTh?=
 =?us-ascii?Q?IJ8c6Gd9IjYzgoduzUhmcPPNcNxNnNr57qViSixw65GhV77Ws3wnIHhdQXmv?=
 =?us-ascii?Q?FTcuIDCVgZEPlPhciffo5FGfOQK8vADTfIqgDAbn8NptiIBD7i4Je3bFf4U9?=
 =?us-ascii?Q?llRTYzv8UhmN8duPd+38Iw5D8KJzndW65FfwNZRgZiyN4dYYJ4U4ICaCUGmE?=
 =?us-ascii?Q?97DnkGg2T1SHMgwOwcpGua18eH/9Jw0a6be4yafIJE8ygSFBLjIJbQ3uyk66?=
 =?us-ascii?Q?JNBeNw4TyyByYv+ND5lRrDgWH8OUQy00ZCo8PBhPjKst4EM4Lsp/kSDB15u3?=
 =?us-ascii?Q?ADW/0FI/PI0TEJVYMIC2vFufe85+5kHDlUFo9bBNCI9DxsuVyjMaQyiPr7qa?=
 =?us-ascii?Q?7b4GvPHwz1DKQ0Po67kNxKnPMfMGC+mV7v74l7UAhgB/qzKI+GtKmQjZJV7c?=
 =?us-ascii?Q?g7iiSlf7U4cvyAVLGEYs5n7Qm4PETgsQq9mOh6HXsNqGsP83nSq21RTBlBlB?=
 =?us-ascii?Q?qGXrQiabeNZN/DsON0DlkywDRCMKejhJ0g+U8E2WZ/e1fLy/vZoA8DwQzHwX?=
 =?us-ascii?Q?uhLcIXMGDxANzuRqrE2S39teCJhqEMU1P3cpNBQwLxgp0JUckslFzSZQC1qn?=
 =?us-ascii?Q?2WxfX18wpLgECYwFE0cXiae7G5coSu8dFSEv8avRvgcwau4oOB0H2TBjtrpD?=
 =?us-ascii?Q?nf4DiuJ+bhNWpsK92YU1yzm36W+qiGcZdFTlImNG?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e81a1c-d1b0-44a4-5ccb-08db62c41edc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:17:47.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTXOQ6QWVjVzkELJ5XZFYxhQDFXp1sUkcAvKfauVJskx2l0/r/BQ0rpNxKR06tQHW5+8zLEWzgMN3ssvXPYIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 13:49:40 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This macro is used to compute the offset of a field in a struct.
> 
> This commit enables an unstable feature that is necessary for using
> the macro in a constant. However, this is not a problem as the macro
> will become available from the Rust standard library soon [1]. The
> unstable feature can be disabled again once that happens.
> 
> The macro in this patch does not support sub-fields. That is, you cannot
> write `offset_of!(MyStruct, field.sub_field)` to get the offset of
> `sub_field` with `field`'s type being a struct with a field called
> `sub_field`. This is because `field` might be a `Box<SubStruct>`, which
> means that you would be trying to compute the offset to something in an
> entirely different allocation. There's no easy way to fix the current
> macro to support subfields, but the version being added to the standard
> library should support it, so the limitation is temporary and not a big
> deal.
> 
> Link: https://github.com/rust-lang/rust/issues/106655 [1]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs     | 35 +++++++++++++++++++++++++++++++++++
>  scripts/Makefile.build |  2 +-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index eaded02ffb01..7ea777b731e6 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -14,6 +14,7 @@
>  #![no_std]
>  #![feature(allocator_api)]
>  #![feature(coerce_unsized)]
> +#![feature(const_refs_to_cell)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(new_uninit)]
>  #![feature(receiver_trait)]
> @@ -98,3 +99,37 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>      // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/issues/2094>.
>      loop {}
>  }
> +
> +/// Calculates the offset of a field from the beginning of the struct it belongs to.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// #[repr(C)]
> +/// struct Test {
> +///     a: u64,
> +///     b: u32,
> +/// }
> +///
> +/// assert_eq!(kernel::offset_of!(Test, b), 8);
> +/// ```
> +#[macro_export]
> +macro_rules! offset_of {
> +    ($type:path, $field:ident) => {{
> +        let $type { $field: _, .. };
> +        let tmp = ::core::mem::MaybeUninit::<$type>::uninit();
> +        let outer = tmp.as_ptr();
> +        // To avoid warnings when nesting `unsafe` blocks.
> +        #[allow(unused_unsafe)]
> +        // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
> +        // we don't actually read from `outer` (which would be UB) nor create an intermediate
> +        // reference.
> +        let inner = unsafe { ::core::ptr::addr_of!((*outer).$field) } as *const u8;
> +        // To avoid warnings when nesting `unsafe` blocks.
> +        #[allow(unused_unsafe)]
> +        // SAFETY: The two pointers are within the same allocation block.
> +        unsafe {
> +            inner.offset_from(outer as *const u8) as usize
> +        }
> +    }};
> +}
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 78175231c969..819510694769 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
>  
> -rust_allowed_features := new_uninit
> +rust_allowed_features := const_refs_to_cell,new_uninit
>  
>  rust_common_cmd = \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \

