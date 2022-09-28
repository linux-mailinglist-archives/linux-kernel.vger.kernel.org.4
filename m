Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF05ED9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiI1KKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI1KKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:10:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E98FD55
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:09:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w10so11365531pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=duP8xfDehjxwwRzMlO+xIkuofiVIyjCnJ39OqEBZnvg=;
        b=lib6B2mMxl5NxnINW0OzG0zC66Z3LCxS8m+inz3s790XzYWfBXOcjpz79BlYtXU+zC
         hfchdOgWGjEq9QbwDqw2agsx5TcvvzkUpGqDh/OymxIaA0trvTvjbAlv2j422Heo/mhf
         CHZYlO8o6iKNhyTtuCByT1TiWNNIHXygpcP6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=duP8xfDehjxwwRzMlO+xIkuofiVIyjCnJ39OqEBZnvg=;
        b=3gEIFzj3sg0lQy7NweLfrpqD4yulvGSXWCwWr3MthikZ9A+MrB2DVek8Bp/tp2QfzU
         +wSSSZIht1B6g6O8/Kg3Xuj3vWMb8UqXAdypFerjz0d2zQchMyIoFrBrqTCrdH3lx3nu
         r4mRltJ6H99OnJw6pwlv2RlRBXP+1rtEIF2Uohqhi1441zclgjvye66ou9Xcvt/i74Wa
         T1qmkIfBBEExM7925ZH4wvn4Iw3jChXjdcGCVJDzziMV4kUpiVT8zFNQhRMdlmdPZCX3
         7Y5GzXIhAlC/TkoavqW+3z8sdZCxl7pQTmaHJHBPMdVnZbdzpLcCiBToGJZRYlbZYg4k
         epAQ==
X-Gm-Message-State: ACrzQf0ZRlYNmqS/BxJh+0TJ5yHwT1FC7wlf2RyCqZFzRP1kY7RMXXu2
        3vKe1zbApHe16cPUyH1z8bCL+Q==
X-Google-Smtp-Source: AMsMyM4xOfc8HLa6MnTzpmJZID7CRRxzXzSmbwQ3uH59f74/DtPFaDC2Z73NATAqWDt7D8COPRC4yg==
X-Received: by 2002:a17:902:bd8e:b0:178:25ab:56cc with SMTP id q14-20020a170902bd8e00b0017825ab56ccmr31062254pls.86.1664359797576;
        Wed, 28 Sep 2022 03:09:57 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:d8e5:5ceb:cc0c:18ad])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b00172f6726d8esm3285144plf.277.2022.09.28.03.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:09:57 -0700 (PDT)
Date:   Wed, 28 Sep 2022 19:09:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 14/27] vsprintf: add new `%pA` format specifier
Message-ID: <YzQdbi1xUNGxi+SM@google.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-15-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-15-ojeda@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/27 15:14), Miguel Ojeda wrote:
> This patch adds a format specifier `%pA` to `vsprintf` which formats
> a pointer as `core::fmt::Arguments`. Doing so allows us to directly
> format to the internal buffer of `printf`, so we do not have to use
> a temporary buffer on the stack to pre-assemble the message on
> the Rust side.
> 
> This specifier is intended only to be used from Rust and not for C, so
> `checkpatch.pl` is intentionally unchanged to catch any misuse.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
