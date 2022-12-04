Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1B641DAE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 16:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLDPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 10:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLDPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 10:41:35 -0500
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB411A1B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 07:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=+wJRlMho2FnAbXYg6+mlmNW9Tp+g4pBu1hc7038i/W8=; b=k5+S41vpJRy8VXu9WSCdXEzK4K
        sgBVsnQrNv2MMxOxy6/uVkCuQPy40UNA0LQkWR/V9cD510olMOCkUBARvmaOqY5yW8YA/lQEPflyX
        NW8yYNz6GWZBb4JQMc/4IYpt0r/FQXkvcJhorct2DxoouGaM3uzXGxQmncgt6A7r9Vvnd1XHJ5X8U
        GjJd1/u7trHt+WctKwPirpyB+c2viPYvpoxaCMQPPU6gYqqHgj54IbmVIfHJpbKrzlTRfua4mHWPy
        stbf6IxtUcLlhs8Wc5KfS3Igb5TIhDAMit1s9ZbrCry474WOClCNu435InNED9vWvLAEDPCmDFmmA
        3OyWdGFQ==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1p1r7K-0052UU-UT; Sun, 04 Dec 2022 15:41:22 +0000
Date:   Sun, 4 Dec 2022 15:41:22 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH v2 20/28] rust: str: add `Formatter` type
Message-ID: <Y4y/ovfF3len/22J@gallifrey>
References: <20221202161502.385525-1-ojeda@kernel.org>
 <20221202161502.385525-21-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20221202161502.385525-21-ojeda@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 15:37:53 up 268 days,  2:03,  2 users,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* ojeda@kernel.org (ojeda@kernel.org) wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add the `Formatter` type, which leverages `RawFormatter`,
> but fails if callers attempt to write more than will fit
> in the buffer.
> 
> In order to so, implement the `RawFormatter::from_buffer()`
> constructor as well.
> 
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/str.rs | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index a995db36486f..ce207d1b3d2a 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -406,6 +406,23 @@ impl RawFormatter {
>          }
>      }
>  
> +    /// Creates a new instance of [`RawFormatter`] with the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> +    /// for the lifetime of the returned [`RawFormatter`].
> +    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> +        let pos = buf as usize;
> +        // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
> +        // guarantees that the memory region is valid for writes.
> +        Self {
> +            pos,
> +            beg: pos,
> +            end: pos.saturating_add(len),
> +        }
> +    }
> +
>      /// Returns the current insert position.
>      ///
>      /// N.B. It may point to invalid memory.
> @@ -439,3 +456,43 @@ impl fmt::Write for RawFormatter {
>          Ok(())
>      }
>  }
> +
> +/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
> +///
> +/// Fails if callers attempt to write more than will fit in the buffer.
> +pub(crate) struct Formatter(RawFormatter);
> +
> +impl Formatter {
> +    /// Creates a new instance of [`Formatter`] with the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> +    /// for the lifetime of the returned [`Formatter`].
> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> +        // SAFETY: The safety requirements of this function satisfy those of the callee.
> +        Self(unsafe { RawFormatter::from_buffer(buf, len) })
> +    }
> +}
> +
> +impl Deref for Formatter {
> +    type Target = RawFormatter;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0
> +    }
> +}
> +
> +impl fmt::Write for Formatter {
> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> +        self.0.write_str(s)?;
> +
> +        // Fail the request if we go past the end of the buffer.

Reading this for the first time, I'm surprised by this, perhaps a
bit more comment is needed?  I was expecting that nothing would
let pos pass end.

Dave

> +        if self.0.pos > self.0.end {
> +            Err(fmt::Error)
> +        } else {
> +            Ok(())
> +        }
> +    }
> +}
> -- 
> 2.38.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
