Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2E67E7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjA0OMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjA0OLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:11:45 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432B113C0;
        Fri, 27 Jan 2023 06:11:44 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p141so6074386ybg.12;
        Fri, 27 Jan 2023 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJdCvvu6jSVfMd09Z0nqsZgbe8izrnWySR6PkXWkYEQ=;
        b=LbptWjg9OYEMP8jaMM/xpeH4hxenBsBxCKenBxPUAgbI5YO059GQRgvy/x7OD3JMVa
         +r9h0fUoiwbbj9SL6iXgTrZq4ZmiA8K35QZNOHiUQdQ/m2/p2HHu+bHM9afmTEgp3fQo
         5z11rSFpF5/2jkxsvDYsxBzmR8SMfLFQZcrDsCYmy9Hshi8r8k3cUe9ncLYlDCxiB7mY
         ScnHAtLGJ42tou/1+4K4C7WR2oXsKhC5gPcQn08ktYX9Cxu/k6/PIEa+mkTfp049bT/q
         ELzs+9Vo60hOA4MWqiun3Gz8tRykFEcp2gNoykKWC80x4RjqbuGj4fV+5klzhhB6FRaG
         HMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJdCvvu6jSVfMd09Z0nqsZgbe8izrnWySR6PkXWkYEQ=;
        b=55tF4NNLKx9eu+J0sTNJ3pFwj7yQDq6NWccE8+HXzHpIFF3gi4vgdx+dRdzuqumUyW
         Wn0Z1w6z9T7rwSbnQiG3h6i4sHHt3AwRNPb9m7YJ4YDR8kQ6ZmqZVkApwiMm79h4TfCR
         qzvgSKzQovR/KIwFWKAG949aFDVn5MVXKhnqHlV+I6b4JGKTQSDRctZBU9WmEQl7Ame5
         YmQajNxCKppZ3UaZwnPCLmXVUXGdJsmAZNcXwZ5aoyBp41jcXx9zvYfQzwrjGVZD0ebE
         C819f/Q0MtOcgmw3UMJ8VLB/+TVBAnzyaPq/9XZT8lezaGsZJMCqga5v66Aeg7lH5Lm4
         NSAw==
X-Gm-Message-State: AFqh2kovEKX/Pc57HFPFLv6B2DM89AXcXfz7k97Lpa42yKEYex5HFaDC
        YcsDBeZHZ7Dxqo9Qn9HHCtlq8DHumV/PlVYL5PU=
X-Google-Smtp-Source: AMrXdXvSTuzTYQpzBLSE2fCjqsUFmt6y0WaWNmhRwLNYTDqtm397siZf/jEllKjMIL1Y9jyuHYUfByoZeHWaqeppoYs=
X-Received: by 2002:a25:c88:0:b0:7fe:eff0:87ac with SMTP id
 130-20020a250c88000000b007feeff087acmr2905524ybm.581.1674828703791; Fri, 27
 Jan 2023 06:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119174036.64046-1-wedsonaf@gmail.com> <20230119174036.64046-4-wedsonaf@gmail.com>
 <20230127140319.22af6060.gary@garyguo.net>
In-Reply-To: <20230127140319.22af6060.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 27 Jan 2023 15:11:32 +0100
Message-ID: <CANiq72kXNvQ-GY-uw24s_1NmQ5G12Cu+JfYKFQ0rC-4Fnm8o8Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: types: implement `ForeignOwnable` for the unit type
To:     Gary Guo <gary@garyguo.net>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 3:03 PM Gary Guo <gary@garyguo.net> wrote:
>
> this should really be `core::ptr::invalid(1)`. That's currently
> unstable, but can be equivalently written as
> `NonNull::<()>::dangling().as_ptr()`.
>
> This has a different semantic meaning from `as` since it explicitly
> suggests an invalid provenance and thus will not alias with other
> pointers. (Although I don't think compiler currently can take advantage
> of this fact yet)

We talked about starting to use `strict_provenance` when it came out
-- what is the latest status? i.e. do you know if it is expected that
it will pass FCP etc.? (my understanding originally was that it was an
experiment).

If it is likely to become stable, then I agree it could be nice to
start using it before a lot of kernel code gets written without it.

Thanks Gary!

Cheers,
Miguel
