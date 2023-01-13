Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B213F66A6C2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjAMXNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjAMXNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:13:07 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267552C6A;
        Fri, 13 Jan 2023 15:13:06 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 188so24140437ybi.9;
        Fri, 13 Jan 2023 15:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcttPvIOqjLZM9F4gnEg1fZ9duaMxSmsJ9dAT4eVMto=;
        b=fsQRQYaY5XCcHXaWXRuTKkkyaOlhbgd5f9J9NehHJt1yDL6jWOLYtP00oTRQM8X+EV
         PzZ6b4gUaeBWZxDXhZMhuoJ3vCgOeOE6bDFdzqZR3KtOec9HxcSj0PNS0HwqXuitKp8c
         4kKB4jD6svKgKQTIfr6q0I8SLgfQUWYjy0kovaXnuIulrJ2r5AQNed402wSVDtZjqCCY
         sxtDD+P5whbyeTs7N5+4xrykU1o9ZVG8tNmjvtebpKted2crhPWLNXxKC4nzt8epMRDP
         bGraUhX3drBGhmKqjmhnUtLH53UboTzKhyjma5AAYJjiOBwEO/bgrzl24YM0vy+Ck0vT
         hppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcttPvIOqjLZM9F4gnEg1fZ9duaMxSmsJ9dAT4eVMto=;
        b=YXT9mCNHHXHRJFlRNYv+9vt9T6f51w0zdNqryl8VMOj8B4xxnCVXhLZT+BBBCEwdAO
         usypbdPwhub7c2vvmJH1MUBG2lNJkO1UkYfIGoyQ1P1rbF4Iw4SswsW+rHvF+qiZF45f
         CUFUz9hxTD5R8X3FLqbEXaT3l7XRrHpcyArcPe2o8pKqlQ/eCbY18NZV0MiofPD3rGzt
         EZRrZ/E959E0+prxn7JZYHN7T6yTcWr8JeDjWmEk1kDI474hmherMKdjtB1xOgkiKF6I
         lyLeS7Z75MXNhUi/Hrj39GB1E9QzUdDLGBiE/fvbH9GurBYXo6MRMvpZmizB0/x7N+PS
         Up4g==
X-Gm-Message-State: AFqh2kqm4kwDj1/j1pODKM7Kq9H2oJkwAaCQb82zRAcjR7bCvRfbRhM4
        lrWyO/bwKsMub0o0cPJRw59h+CjUxgBhSfC8v9I=
X-Google-Smtp-Source: AMrXdXvcg7dpfZwB3s0fAR3OY5o+zrWc7k7fTH4cyRXkF3jJzahtcGpoV1NtYkEOEmH6NAnM5wRTgZkTcEqdootpCXw=
X-Received: by 2002:a25:e6c7:0:b0:7cb:dfbe:3996 with SMTP id
 d190-20020a25e6c7000000b007cbdfbe3996mr615970ybh.489.1673651585333; Fri, 13
 Jan 2023 15:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-5-ojeda@kernel.org>
 <CAK7LNAQj_WykFWcrj=L3wJYxDhOCGs+JHPB4E2vzWcx8y_at0w@mail.gmail.com>
In-Reply-To: <CAK7LNAQj_WykFWcrj=L3wJYxDhOCGs+JHPB4E2vzWcx8y_at0w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 00:12:54 +0100
Message-ID: <CANiq72=MsV8EXV9cib+GJd0AXbpF8YSGdDd723m7=ON4jhjXxQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] kbuild: rust_is_available: fix confusion when a
 version appears in the path
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
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

On Thu, Jan 12, 2023 at 6:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> +set -- ${bindgen_libclang_output#**clang version}
> +bindgen_libclang_cversion=$(get_canonical_version $1)
>  bindgen_libclang_min_version=$($min_tool_version llvm)
> -bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)

Nice trick :) To be honest, I am not really fond of `set`, and in this
case it means the command is not symmetric (we remove the prefix using
parameter expansion, and the suffix via positional argument
selection), but if you prefer it that way, I think it would be fine.

However, why the double asterisk? One already matches any string,
including spaces, no?

Cheers,
Miguel
