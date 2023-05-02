Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D66F45AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjEBN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjEBN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:59:33 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA791A5;
        Tue,  2 May 2023 06:59:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4FB044214F;
        Tue,  2 May 2023 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1683035969;
        bh=8Wn3w9SLbhBFAEK8pHc8Xyamcv2XxT5RZDDxAaNh7AM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Z9E8L28FKAybrZUWOPVDX7Q++j8ioGIUeuqYwowdgAg02iiAt5iHk2ebfiJDdwnvV
         S/FPph/bI5ll4r4AcrC2dtjfa+3Q6A2/jJG+N5oXmUczrlv+o20zTpuGxyg6l62rtW
         9iNWs742FySAdCAB/KGkaK1/iKu9ecV+4lu7er9EDL6tVHx2CfvOlmzsevU8wFBssf
         He2/09jqhheQXflYSh1HwjQ83wHUq9D0cZi8KTkLSKE3JgU45v28v/pzGYe8iCg0eY
         amKKBEQZzp40+rvnAVZ9ZpamJdnBFudzCr5FbcXBiEMHVYvhFDwZhBvfelf5+Qo79Y
         kYOdnZE6jqSaw==
Message-ID: <b48b84fe-c71f-b3e4-890c-8ccb26e6bdb0@asahilina.net>
Date:   Tue, 2 May 2023 22:59:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] rust: error: allow specifying error type on `Result`
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230502124015.356001-1-aliceryhl@google.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <20230502124015.356001-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 21.40, Alice Ryhl wrote:
> Currently, if the `kernel::error::Result` type is in scope (which is
> often is, since it's in the kernel's prelude), you cannot write
> `Result<T, SomeOtherErrorType>` when you want to use a different error
> type than `kernel::error::Error`.
> 
> To solve this we change the error type from being hard-coded to just
> being a default generic parameter. This still lets you write `Result<T>`
> when you just want to use the `Error` error type, but also lets you
> write `Result<T, SomeOtherErrorType>` when necessary.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/error.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 5f4114b30b94..01dd4d2f63d2 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -177,7 +177,7 @@ impl From<core::convert::Infallible> for Error {
>   /// Note that even if a function does not return anything when it succeeds,
>   /// it should still be modeled as returning a `Result` rather than
>   /// just an [`Error`].
> -pub type Result<T = ()> = core::result::Result<T, Error>;
> +pub type Result<T = (), E = Error> = core::result::Result<T, E>;
>   
>   /// Converts an integer as returned by a C kernel function to an error if it's negative, and
>   /// `Ok(())` otherwise.
> 
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162

Reviewed-by: Asahi Lina <lina@asahilina.net>

~~ Lina

