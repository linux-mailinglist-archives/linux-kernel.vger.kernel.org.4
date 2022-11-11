Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C682E625706
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiKKJlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiKKJku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:40:50 -0500
Received: from gimli.kloenk.dev (gimli.kloenk.dev [IPv6:2a0f:4ac0:0:1::cb2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F35654C9;
        Fri, 11 Nov 2022 01:40:47 -0800 (PST)
From:   Finn Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1668159645; bh=2vdujejFWPkDoHCGzEXuqCjEsBgU8k9HG/Ttf/xIgCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kOH24GfbNxc3koT1wNOSM5WOSW3jb2krZ0UvEW7zLvr/aDOSX9ZYyCdG5gqK0N+wW
         ZOcfelkDYU9Z6lYkpM0ogwl+kiqwL1VHsGyupZKmngQYfZFRiA7yhrXDV2+SjGPjWd
         5s/8uj1kNwA2PDV8j3B+FuR724yMFFY5dRcDREqc=
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 04/28] rust: samples: add `rust_print` example
Date:   Fri, 11 Nov 2022 10:40:44 +0100
Message-ID: <6C48433C-2B12-4D35-A93E-72CC1B41A8C4@kloenk.dev>
In-Reply-To: <20221110164152.26136-5-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-5-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Nov 2022, at 17:41, Miguel Ojeda wrote:

> Add example to exercise the printing macros (`pr_*!`) introduced
> in the previous patches.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Finn Behrens <me@kloenk.dev>

> ---
>  samples/rust/Kconfig       | 10 +++++++
>  samples/rust/Makefile      |  1 +
>  samples/rust/rust_print.rs | 54 ++++++++++++++++++++++++++++++++++++++=

>  3 files changed, 65 insertions(+)
>  create mode 100644 samples/rust/rust_print.rs
>
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 841e0906e943..b0f74a81c8f9 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
>
>  	  If unsure, say N.
>
> +config SAMPLE_RUST_PRINT
> +	tristate "Printing macros"
> +	help
> +	  This option builds the Rust printing macros sample.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_print.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_HOSTPROGS
>  	bool "Host programs"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 1daba5f8658a..03086dabbea4 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+=3D rust_minimal.o
> +obj-$(CONFIG_SAMPLE_RUST_PRINT)			+=3D rust_print.o
>
>  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+=3D hostprogs
> diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
> new file mode 100644
> index 000000000000..09f737790f3f
> --- /dev/null
> +++ b/samples/rust/rust_print.rs
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust printing macros sample.
> +
> +use kernel::pr_cont;
> +use kernel::prelude::*;
> +
> +module! {
> +    type: RustPrint,
> +    name: b"rust_print",
> +    author: b"Rust for Linux Contributors",
> +    description: b"Rust printing macros sample",
> +    license: b"GPL",
> +}
> +
> +struct RustPrint;
> +
> +impl kernel::Module for RustPrint {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Rust printing macros sample (init)\n");
> +
> +        pr_emerg!("Emergency message (level 0) without args\n");
> +        pr_alert!("Alert message (level 1) without args\n");
> +        pr_crit!("Critical message (level 2) without args\n");
> +        pr_err!("Error message (level 3) without args\n");
> +        pr_warn!("Warning message (level 4) without args\n");
> +        pr_notice!("Notice message (level 5) without args\n");
> +        pr_info!("Info message (level 6) without args\n");
> +
> +        pr_info!("A line that");
> +        pr_cont!(" is continued");
> +        pr_cont!(" without args\n");
> +
> +        pr_emerg!("{} message (level {}) with args\n", "Emergency", 0)=
;
> +        pr_alert!("{} message (level {}) with args\n", "Alert", 1);
> +        pr_crit!("{} message (level {}) with args\n", "Critical", 2);
> +        pr_err!("{} message (level {}) with args\n", "Error", 3);
> +        pr_warn!("{} message (level {}) with args\n", "Warning", 4);
> +        pr_notice!("{} message (level {}) with args\n", "Notice", 5);
> +        pr_info!("{} message (level {}) with args\n", "Info", 6);
> +
> +        pr_info!("A {} that", "line");
> +        pr_cont!(" is {}", "continued");
> +        pr_cont!(" with {}\n", "args");
Could be nice, to also have an int or similar as arg, but as internal the=
 same macro is used as above, not really of interest.

Regards,
Finn
> +
> +        Ok(RustPrint)
> +    }
> +}
> +
> +impl Drop for RustPrint {
> +    fn drop(&mut self) {
> +        pr_info!("Rust printing macros sample (exit)\n");
> +    }
> +}
> -- =

> 2.38.1
