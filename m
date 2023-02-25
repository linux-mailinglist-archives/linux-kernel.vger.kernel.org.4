Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59796A26D0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 03:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBYCbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 21:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 21:31:23 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084E13D71;
        Fri, 24 Feb 2023 18:31:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D0BDA3FA55;
        Sat, 25 Feb 2023 02:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677292278;
        bh=d7fNCc0OXWajjux2XtUPq9jeuVNkW9eE2qqP/QqkV9E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=uPuxPeuIMiA3/pG9mj3tq26RVvZw6XOx+p/mf8zoWUVGDBwu4NuCCGJlwIwCA+Aqb
         5hTGTj03EMoKTJs+MDUB4YVbPrae9yJwWfXqLUXBaypapt72p5m6iSxmZi3UcN9O4r
         J+c8cN38Xhucb/ylLRmPjpFVBhBBjcXMOb57ga7qQDBaDbfKEjQ5Yr2CQqgl7sYEcy
         ag0NGLoGcDUSycEFwkHXW700FsN8oIsE+zlxCClxZz1161YitPnRTJWmCFg7jneFko
         TXmsSCVISszbOsY5yZPEPPa2Ca7rx5LQgaeMlqAD/YQGz7cVVhx2KkB3v5y+Rax6EW
         4l2E2Td0duvrA==
Message-ID: <18fb86aa-4c63-d455-4bee-ff6fcf95f8a4@asahilina.net>
Date:   Sat, 25 Feb 2023 11:31:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net>
 <Y/lOlcSpc+d9ytq/@boqun-archlinux>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/lOlcSpc+d9ytq/@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 08.56, Boqun Feng wrote:
> On Fri, Feb 24, 2023 at 05:50:23PM +0900, Asahi Lina wrote:
>> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>>
>> Add a helper macro to easily return C result codes from a Rust function
>> that calls functions which return a Result<T>.
>>
>> Lina: Imported from rust-for-linux/rust, originally developed by Wedson
>> as part of file_operations.rs. Added the allow() flags since there is no
>> user in the kernel crate yet and fixed a typo in a comment.
>>
>> Co-developed-by: Fox Chen <foxhlchen@gmail.com>
>> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
>> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>  rust/kernel/error.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
>> index cf3d089477d2..8a9222595cd1 100644
>> --- a/rust/kernel/error.rs
>> +++ b/rust/kernel/error.rs
>> @@ -226,3 +226,55 @@ pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
>>      }
>>      Ok(ptr)
>>  }
>> +
>> +// TODO: Remove `dead_code` marker once an in-kernel client is available.
>> +#[allow(dead_code)]
>> +pub(crate) fn from_kernel_result_helper<T>(r: Result<T>) -> T
>> +where
>> +    T: From<i16>,
>> +{
>> +    match r {
>> +        Ok(v) => v,
>> +        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
>> +        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
>> +        // therefore a negative `errno` always fits in an `i16` and will not overflow.
>> +        Err(e) => T::from(e.to_kernel_errno() as i16),
>> +    }
>> +}
>> +
>> +/// Transforms a [`crate::error::Result<T>`] to a kernel C integer result.
>> +///
>> +/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
>> +/// from inside `extern "C"` functions that need to return an integer
>> +/// error result.
>> +///
>> +/// `T` should be convertible from an `i16` via `From<i16>`.
>> +///
>> +/// # Examples
>> +///
>> +/// ```ignore
>> +/// # use kernel::from_kernel_result;
>> +/// # use kernel::bindings;
>> +/// unsafe extern "C" fn probe_callback(
>> +///     pdev: *mut bindings::platform_device,
>> +/// ) -> core::ffi::c_int {
>> +///     from_kernel_result! {
>> +///         let ptr = devm_alloc(pdev)?;
>> +///         bindings::platform_set_drvdata(pdev, ptr);
>> +///         Ok(0)
>> +///     }
>> +/// }
>> +/// ```
>> +// TODO: Remove `unused_macros` marker once an in-kernel client is available.
>> +#[allow(unused_macros)]
>> +macro_rules! from_kernel_result {
> 
> This actually doesn't need to be a macro, right? The following function
> version:
> 
> 	pub fn from_kernel_result<T, F>(f: F) -> T
> 	where
> 	    T: From<i16>,
> 	    F: FnOnce() -> Result<T>;
> 
> is not bad, the above case then can be written as:
> 
> 	unsafe extern "C" fn probe_callback(
> 	    pdev: *mut bindings::platform_device,
> 	) -> core::ffi::c_int {
> 	    from_kernel_result(|| {
> 		let ptr = devm_alloc(pdev)?;
> 		bindings::platform_set_drvdata(pdev, ptr);
> 		Ok(0)
> 	    })
> 	}
> 
> less magical, but the control flow is more clear.
> 
> Thoughts?

Looks good to me! I guess the macro was mostly to hide and call the
closure, but it's not really necessary. I'll change it ^^

~~ Lina
