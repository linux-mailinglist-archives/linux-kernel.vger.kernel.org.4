Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91649730C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbjFOAU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbjFOAUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:20:47 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1BF2974
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:20:04 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9e207f5f0so1215131cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686788389; x=1689380389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xG3BQaVfAInEtWzfz6GXM6niKI5YlCC6tXwHa1+aR1g=;
        b=2ITOJAE/ABayc+Y2PogEH0Hjt6JukQ9FFLmtYDRk4okZw3JvlxVe2biDOgSJC25VyP
         Zv1W45DbtWljd8SqUYNquUmQU8on9p3ONIobsum/xUFMZ0H7EquKO4/JKvXpY0KtcaSa
         +h7/qfF3OxH0aeRmO/N4wosAXGZt4eNumz+U3OoNuxO4ETOzXhS3EIF30XS3itV8Lt/h
         t356yx31sFMOcljjWpszAWIjy+ug1zp6vlntHxIj/UeNrmCMW41DcD7BS3i6gaoBKW43
         S05KvcdMnZHV1shPPFOTEFGe04QDrYX6IrNo9iE1b/jxa9A28xfIVthbygGzPsp3lsGA
         ufdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686788389; x=1689380389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG3BQaVfAInEtWzfz6GXM6niKI5YlCC6tXwHa1+aR1g=;
        b=fuMkSpCfr6PnYTSxz7SvtHTQFZI5vUg4n7TMwKwv47drDsgCaPWYhS8RROzUrFlcMg
         BqBP6u59qDjC/AjOtPbsuLFH1GwS3Sy4HwO/EM6cnIlkgrGLjVhXblVSi8prG0/XVs4F
         WSLB1WkbyXIzacege2SV+EHMdISXMFBXrXctr+OpQnBovE+J/TubwIMUFi5k3dVF2UXD
         sDjV51FptyMcdGFkt8dzzc8p/4QsZw0Sp9a9I0Tn1LoFKTNpdU5XYpr4yIMjcOdNza1g
         dTVntY9cfJfCHXx98inSnHkRNrTYofHVBrVNgmhDqucUWMdfIxVwPhSzpabvbeXfPQE4
         pREA==
X-Gm-Message-State: AC+VfDwp2mDfIOJK35zZ0/3N9C6W1b4UiZ1NzxZydpLUFT8PGnq/9q5i
        VZmmMsgzvl+YYMLNXHuDNPOyPmoh5dL7O91IgrMrGA==
X-Google-Smtp-Source: ACHHUZ77T/z/r+sF+BnKA4y7X04c478y3LUwdhEcRCBhZC8/mj36lgn53z6yIHdRAN9zaDTaoUu+j6yVI9Jh5mICta8=
X-Received: by 2002:ad4:5aa8:0:b0:62e:d9db:c788 with SMTP id
 u8-20020ad45aa8000000b0062ed9dbc788mr3622770qvg.3.1686788388738; Wed, 14 Jun
 2023 17:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-6-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-6-ojeda@kernel.org>
From:   Matt Gilbride <mattgilbride@google.com>
Date:   Wed, 14 Jun 2023 20:19:37 -0400
Message-ID: <CABVGRkcnKX3Sb=LgUHz+E0XPxvemkuO+StAq4xxDY2xSaAt0GQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Rust has documentation tests: these are typically examples of
> usage of any item (e.g. function, struct, module...).
>
> They are very convenient because they are just written
> alongside the documentation. For instance:
>
>     /// Sums two numbers.
>     ///
>     /// ```
>     /// assert_eq!(mymod::f(10, 20), 30);
>     /// ```
>     pub fn f(a: i32, b: i32) -> i32 {
>         a + b
>     }
>
> In userspace, the tests are collected and run via `rustdoc`.
> Using the tool as-is would be useful already, since it allows
> to compile-test most tests (thus enforcing they are kept
> in sync with the code they document) and run those that do not
> depend on in-kernel APIs.
>
> However, by transforming the tests into a KUnit test suite,
> they can also be run inside the kernel. Moreover, the tests
> get to be compiled as other Rust kernel objects instead of
> targeting userspace.
>
> On top of that, the integration with KUnit means the Rust
> support gets to reuse the existing testing facilities. For
> instance, the kernel log would look like:
>
>     KTAP version 1
>     1..1
>         KTAP version 1
>         # Subtest: rust_doctests_kernel
>         1..59
>         # Doctest from line 13
>         ok 1 rust_doctest_kernel_build_assert_rs_0
>         # Doctest from line 56
>         ok 2 rust_doctest_kernel_build_assert_rs_1
>         # Doctest from line 122
>         ok 3 rust_doctest_kernel_init_rs_0
>         ...
>         # Doctest from line 150
>         ok 59 rust_doctest_kernel_types_rs_2
>     # rust_doctests_kernel: pass:59 fail:0 skip:0 total:59
>     # Totals: pass:59 fail:0 skip:0 total:59
>     ok 1 rust_doctests_kernel
>
> Therefore, add support for running Rust documentation tests
> in KUnit. Some other notes about the current implementation
> and support follow.
>
> The transformation is performed by a couple scripts written
> as Rust hostprogs.
>
> Tests using the `?` operator are also supported as usual, e.g.:
>
>     /// ```
>     /// # use kernel::{spawn_work_item, workqueue};
>     /// spawn_work_item!(workqueue::system(), || pr_info!("x"))?;
>     /// # Ok::<(), Error>(())
>     /// ```
>
> The tests are also compiled with Clippy under `CLIPPY=1`, just like
> normal code, thus also benefitting from extra linting.
>
> The names of the tests are currently automatically generated.
> This allows to reduce the burden for documentation writers,
> while keeping them fairly stable for bisection. This is an
> improvement over the `rustdoc`-generated names, which include
> the line number; but ideally we would like to get `rustdoc` to
> provide the Rust item path and a number (for multiple examples
> in a single documented Rust item).
>
> In order for developers to easily see from which original line
> a failed doctests came from, a KTAP diagnostic line is printed
> to the log. In the future, we may be able to use a proper KUnit
> facility to append this sort of information instead.
>
> A notable difference from KUnit C tests is that the Rust tests
> appear to assert using the usual `assert!` and `assert_eq!`
> macros from the Rust standard library (`core`). We provide
> a custom version that forwards the call to KUnit instead.
> Importantly, these macros do not require passing context,
> unlike the KUnit C ones (i.e. `struct kunit *`). This makes
> them easier to use, and readers of the documentation do not need
> to care about which testing framework is used. In addition, it
> may allow us to test third-party code more easily in the future.
>
> However, a current limitation is that KUnit does not support
> assertions in other tasks. Thus we presently simply print an
> error to the kernel log if an assertion actually failed. This
> should be revisited to properly fail the test, perhaps saving
> the context somewhere else, or letting KUnit handle it.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Tested-by: Matt Gilbride <mattgilbride@google.com>
