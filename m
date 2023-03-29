Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A96CF4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjC2Umr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC2Ump (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:42:45 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2139.outbound.protection.outlook.com [40.107.11.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD065BAB;
        Wed, 29 Mar 2023 13:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBwE3YcKx9yat3yLcMhCllJbYBpD8hyumC+SQHBJYNmQtbJJistkUoydzIryWyQyOEDBRxNXZhRX1aQmU+dzVensOPwDV4AcOLyN4vNfk+6oVDNlrwK3FDT3kAYBLcz29RPlAw5DDgOo47vEAqGnZJDRokAj7UU5KavVhjBvNQ8n3gb8LNFUeVV/wDGOVN6EWck2JiJfSwH34HcibUrxum0kV9gJXle83JWf7zcUJ6UjQ2uBNUaN0O8Ak9ZFg+4a8W4ZH1vuNs75SFTMFtALIyEQJb/cY6LOAA/aNkOB9P4ob1vIgzQlUvXNXxUY0N4o7g00pJHnBtzBxqZregQ9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IkwpJYO4PenG5tOM021SXA2uj0ZLR/vmXrfJIFG/kY=;
 b=ZP1imgws7g9XRDaGDEkpmQ+UzR3hOVWCn3+PSW/RxePY9mTv/J/WjT9vvQ+uMHKtpOJlkhmx2hWyr/vm+q/yFMa9Ztwd17i2K5VNZf+UJbJdMbXBBJbuh9BHLPvqMzx/dqK8gonjiP5fCuYZVu6A/+fwZ3uq9sIjoj7oLgLD9TmZE7CFVFm/dujdUIudapOsQAs44hqEwzzyMzMlPHREf+vMvzvVfgPdIKiwoHi7yev0XVkLzNtlkBAU90YIr9teLZmMiJFrZuA41B2YOBzpsOsqTKqZjgKVg4q2WeQNNDsIK2zRWQY572hpO1Ix++sjSITi1TJjZqsHhRWFYIvwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IkwpJYO4PenG5tOM021SXA2uj0ZLR/vmXrfJIFG/kY=;
 b=BWFczot6odW/NOeAsz/2BDN2m4yreO+atoZAiTbVnpFdJ44PNVTpJIxRjyZMNVmHrFgkOp6mhuCWIqxFbHlDyJqWSHcJk+xDqX8KKfnJtgZbzK7IQzOZtmUv59Q/LDvree0UMOwhuJle7v0q9FozMvvwAb05mLUsBGNSzDeUcm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB7163.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:42:41 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 20:42:41 +0000
Date:   Wed, 29 Mar 2023 21:42:39 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>, asahi@lists.linux.dev
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] rust: error: Add a helper to convert a C ERR_PTR
 to a `Result`
Message-ID: <20230329214239.6a19825a.gary@garyguo.net>
In-Reply-To: <20230224-rust-error-v2-5-3900319812da@asahilina.net>
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
        <20230224-rust-error-v2-5-3900319812da@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0474.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 67670cb9-e25d-43b8-15db-08db309623fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: savEbAEgcVRUl2VP73vaD2PkyVyF0qXZuZuyxkiAGbA9+EL1nYLdjcZxvKkMEJuFLelEgWpXjstKameLMHsBZb0bgXkA5mRbQN6JNW/iWaeFm+lEpKUKYORU1qmrGzBeLWsnEzLisB6hfNwgdjbc3Ozjc98tgtyPlbJHR3Wa0NUKF24d+uJ5uDpNtKzl9e1NN/xBLTmZhx9sNGkfKwbqwK/NvCy4uyDYdZIcjEoQfR1bQZ+OpQCw+FXMLKwtSyyBqxLT4mDJQ506YiCwYbhjK/LgyPWClOoAC6sfYdWw43C8G4f38RFofRX6KZdPNcc39xrlQwbvWxZ3qYLE4AnUi1QY5QOlqYdN9YUCnZm7QWTEyoaUFw8bWU75/ecxzvjxGbuYpb4CoOm9nVIXx6JPRqpICMAmMIY/Lk6qpve5kbvfjTuTiuH86t8hk1UAp+gVgkYE43NRokNIDBwurfj9blAxYKrHmRqzlA9ZEadQ1DqVfZX4fquAmviHH0AFq+qwYPGXZpbiP72pzumBTDaAvw789unj4ZrPReZITl+TWruzN+pGhFRQIaUwS0glHwBIG+F9xN8nvSenr8r4oW/QtMZwmAQo0QiPLBYkribj2vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39830400003)(376002)(136003)(451199021)(6506007)(26005)(1076003)(7416002)(6486002)(38100700002)(186003)(2616005)(8936002)(2906002)(5660300002)(6512007)(8676002)(66556008)(478600001)(316002)(36756003)(54906003)(41300700001)(86362001)(66476007)(66946007)(4326008)(83380400001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rktulCcuXSC6EP1Zat3NQPmEyshTRG0tTRDr2QA0SW87DOF9JlTA70c9g2q?=
 =?us-ascii?Q?u54zDp24KSwybTPsAmTe6nyO5I0Dn0KQhEWl7P1G8zL7Nnd7OC76TDH2JPxx?=
 =?us-ascii?Q?LLZTCxMsAJlJzIopb93OqvTFjfFQc3iVcqVh4UuAK3wWJnXApka8AnUuNKv6?=
 =?us-ascii?Q?jJWA5ywhmNiL26aJ21y8FHn/KuFx2OtwxkCvQlORa3c43VRcgLSVW9ic11GE?=
 =?us-ascii?Q?TKPuoFjQrgayX5mQsluowXQEv5qvjjGVvblznDANi8gSdLTe9sLH4dVK0FmI?=
 =?us-ascii?Q?RkNZfUa2IohqZfHX7ygQihdzwGeHeWgdziNjvYF4Yhz5feyn1JZme9VW8U3q?=
 =?us-ascii?Q?BzDYCgdOZy6t+sBN+xVdbMOiqGNdNltVcYvN9vdLcR++/OZQpu9FR54z88DB?=
 =?us-ascii?Q?nKK9QZN69/tXpjwJJGZJpC5t5HblYQR7zCNYDj1/9NmQn8YMlH9rFfIBJs6t?=
 =?us-ascii?Q?5DtYreCU7hkFc3yd9OThHbDuNbk0FIcfCuwY27BOYp3DHrNJBlE8RB95kz2K?=
 =?us-ascii?Q?wE+GJzqQfRUexYux5tl/Hhte5wEsIsYQC7kMIejmuvCLfUca4Ph1zAAExOzF?=
 =?us-ascii?Q?E3UR++03G1en3HRXC0AiAbqD5iRXiQc+pcrWXDJK0cnFugwickgOvHbsVRQD?=
 =?us-ascii?Q?1K6am8/iVs1hn4K/5V0mJ/atwx7ggjeYxz8cjCsngcqAl41fJCazopAr4qe+?=
 =?us-ascii?Q?F4R+VKyMwari/cnKZe4zjkoU0M/Pgiv757XD7OdzHhAlIS249w8lzwAEY92y?=
 =?us-ascii?Q?U42yOgD8WRHud3O4l46vqGHft8U3DWLQBNlcjaWA6TLol5pA1xzxCfzroXeO?=
 =?us-ascii?Q?FF5QSAI+jwAKhcneQraElmZdQmGVWqaz+ZioXkwGUfE1wBzhaf8HQgKUhtYQ?=
 =?us-ascii?Q?G1Fu9+9zAmsUPf4e9KcFWPViUikQEimLeaFe7+J8SHlWdwXjMB0pHgs1JM7f?=
 =?us-ascii?Q?oD31qWngGyGI5SofkA2FuRQQzuSXTtJzNbCrfCh7muCQ0DrRn9FePVLtb7CH?=
 =?us-ascii?Q?mzSuhkLRa/Ydp+pQ6UH3rMnyMhNcftnyHGwgt9qCd1qKB1+WR7FZfKVdiNpE?=
 =?us-ascii?Q?an+XjwHpskOnP9+pwyeCQRlV4j6YX0kt0zyHYJVuomksFyRQIbwGu0Au4/AA?=
 =?us-ascii?Q?U2U7fJQsdkFVvbN9Ddw1izXrSggGOswBdE+PDMZs6O2o8U5F28ZaoLe+XYnp?=
 =?us-ascii?Q?UUnDvT0myPvijTxjvJOUFdEXOt9VOqwo2UCiu9YyQtkGjTAP8bqHhz5RVHh9?=
 =?us-ascii?Q?Xgi1TnLgM24CzurObS82Mw1qqfei5Npk5KKRTxVgeLLOO0UUHqeR9A4khNbW?=
 =?us-ascii?Q?GFUWMmCdORrDnuRqF4igkmj0bcRWuRv3vCHqLgC2P4Hza77uqtetp+zvbpL+?=
 =?us-ascii?Q?V8gEVfkWNzV0PdWXNvJNhDzWct5HegcEtgZ9nlDWHBnouCgkYP5LU9vQuTLj?=
 =?us-ascii?Q?dG6b0uT7AHh+vtPYmlLwojpsrcEo70JfwJms+HvkF1hWGKgtQ6nhAjg7Wuov?=
 =?us-ascii?Q?5Mek0Nbe9RsxtAOeZ1RCjMQaBQRd2LCCKwDTTZjCvt9K/qnrQiSRJ4SJ/7Vd?=
 =?us-ascii?Q?M3cQOQCzkYkcLJFLom3gSdO6vAliMTK2QPge/ryX?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 67670cb9-e25d-43b8-15db-08db309623fd
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:42:41.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mv5xk3BsVyQpeeJ1FS033NM6m72o3TIW14vsxhKR1pnsld92XoNnspEIiOq+2K2ZqVfHH2Y5SVopGqruzEE3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7163
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 21:04:37 +0900
Asahi Lina <lina@asahilina.net> wrote:

> From: Sven Van Asbroeck <thesven73@gmail.com>
> 
> Some kernel C API functions return a pointer which embeds an optional
> `errno`. Callers are supposed to check the returned pointer with
> `IS_ERR()` and if this returns `true`, retrieve the `errno` using
> `PTR_ERR()`.
> 
> Create a Rust helper function to implement the Rust equivalent:
> transform a `*mut T` to `Result<*mut T>`.
> 
> Lina: Imported from rust-for-linux/linux, with subsequent refactoring
> and contributions squashed in and attributed below. Replaced usage of
> from_kernel_errno_unchecked() with an open-coded constructor, since this
> is the only user anyway. Renamed the function to from_err_ptr().
> 
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/helpers.c       | 12 ++++++++++++
>  rust/kernel/error.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 89f4cd1e0df3..04b9be46e887 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -53,6 +53,18 @@ __force void *rust_helper_ERR_PTR(long err)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
>  
> +bool rust_helper_IS_ERR(__force const void *ptr)
> +{
> +	return IS_ERR(ptr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
> +
> +long rust_helper_PTR_ERR(__force const void *ptr)
> +{
> +	return PTR_ERR(ptr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 4f599c4d1752..6b10129075a7 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -177,3 +177,52 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
>          Ok(())
>      }
>  }
> +
> +/// Transform a kernel "error pointer" to a normal pointer.
> +///
> +/// Some kernel C API functions return an "error pointer" which optionally
> +/// embeds an `errno`. Callers are supposed to check the returned pointer
> +/// for errors. This function performs the check and converts the "error pointer"
> +/// to a normal pointer in an idiomatic fashion.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// # use kernel::from_err_ptr;
> +/// # use kernel::bindings;
> +/// fn devm_platform_ioremap_resource(
> +///     pdev: &mut PlatformDevice,
> +///     index: u32,
> +/// ) -> Result<*mut core::ffi::c_void> {
> +///     // SAFETY: FFI call.
> +///     unsafe {
> +///         from_err_ptr(bindings::devm_platform_ioremap_resource(
> +///             pdev.to_ptr(),
> +///             index,
> +///         ))
> +///     }
> +/// }
> +/// ```
> +// TODO: Remove `dead_code` marker once an in-kernel client is available.
> +#[allow(dead_code)]
> +pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> +    // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
> +    let const_ptr: *const core::ffi::c_void = ptr.cast();
> +    // SAFETY: The FFI function does not deref the pointer.
> +    if unsafe { bindings::IS_ERR(const_ptr) } {
> +        // SAFETY: The FFI function does not deref the pointer.
> +        let err = unsafe { bindings::PTR_ERR(const_ptr) };
> +        // CAST: If `IS_ERR()` returns `true`,
> +        // then `PTR_ERR()` is guaranteed to return a
> +        // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
> +        // which always fits in an `i16`, as per the invariant above.
> +        // And an `i16` always fits in an `i32`. So casting `err` to
> +        // an `i32` can never overflow, and is always valid.
> +        //
> +        // SAFETY: `IS_ERR()` ensures `err` is a
> +        // negative value greater-or-equal to `-bindings::MAX_ERRNO`.

The comment here should read `INVARIANT: ` because now you are
constructing `Error` which have type invariants.

Where is `from_kernel_errno_unchecked`? I believe the `rust` branch
on GitHub have it, as it's generally good to limit places where type
invariants are used directly, so the method is used to convert an
invariant requirement to a safety requirement that is more obvious due
to use of `unsafe`.

> +        #[cfg_attr(CONFIG_ARM, allow(clippy::unnecessary_cast))]

This should either be gated based on pointer size, or should just be a
blanket allow without cfg gating.

> +        return Err(Error(err as i32));
> +    }
> +    Ok(ptr)
> +}
> 

Best,
Gary

