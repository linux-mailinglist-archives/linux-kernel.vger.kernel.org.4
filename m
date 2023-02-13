Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79666946CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBMNT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBMNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:19:51 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0728BDFB;
        Mon, 13 Feb 2023 05:19:50 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id x71so13387756ybg.6;
        Mon, 13 Feb 2023 05:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UOr4ozvwA9OLcG6Cg8gl1kOtiXAXUBmrZjmaMtRbaUc=;
        b=IMmPd2hD8gEKvd0r1A+LQsgCSNwQrWpx7pa3x70ofmhFgnx0044xcOMUFDYZCL6XfA
         IWBiC/dBGQHzrhzBRKpmm2I9MUv+LvvN3bA/q5nEmj+5TNNgIciXBgjvnUjNsEhRGzy0
         BW1VyOrIV/Ee0k2Pe7zrx3I6KaIiIWtPBRiYc6UGQwaTR3ZhQ3IX69GaT49KLLDa8hGk
         Cu/s2jNN8e8MDoc8BY2he4l2V1vHlCpfC3+kMsKaQfBqqmbxBzXg8djXWykUqd98ZEz3
         VRxcuHZBqPPkykBKWBigX6hvFSbwLZDKK5nzP27a1cYa10UUzAq6nW3UDgLxTjCeSBf5
         SzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOr4ozvwA9OLcG6Cg8gl1kOtiXAXUBmrZjmaMtRbaUc=;
        b=aFnfVt6xKvge4FxCUvZBXdgkrvx6KlH9GvRAWdqgfhQTJs3aHudE7Fu5toc97t61n3
         uokwUFlAO2fieoLlg2VNd1uJMwt3p5bJET0Kjl4iQigJt/Sn+lPmTOAUW90gaNgvs/Pz
         yMIC4ZPtBxz+Z5QYXe9Mf5AaikVpiU4tpZmgaTaIC+uG+/IStXz+OhNhPYBiNU6GVOL6
         YzIIe7Q2gZgrEpBV7WcC7Ze4DNTtbo4auHb8TZ3SD48Vo7C3449DsEnKHoXdeZtq9o4D
         R2aL0/XcfxWVUF2L75LWjJgZXjjkR8pP8JKeBZ1ieilc/ofeyt4pA7BqkJrr4odUsqnI
         tRsQ==
X-Gm-Message-State: AO0yUKX2Ua2lwz3nfFE6DvX9uHliWPw/jAHvi0MKzs50+CSCiLVuDVg2
        PmWoa5SVAymdnftdUpFgAcpKT39HcXAtb0TOJzQ=
X-Google-Smtp-Source: AK7set/OvU+36piJ1s3ckXP2nBooMKy0n72I40WQA+5tayQtU4Y+JTsGLLUzJFjRjC7gRAI9n1MIC7D0GYD5POH4eBk=
X-Received: by 2002:a5b:d4e:0:b0:91d:685c:bd3b with SMTP id
 f14-20020a5b0d4e000000b0091d685cbd3bmr375394ybr.25.1676294390015; Mon, 13 Feb
 2023 05:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20230210152622.92912-1-andrea.righi@canonical.com>
In-Reply-To: <20230210152622.92912-1-andrea.righi@canonical.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 13 Feb 2023 14:19:38 +0100
Message-ID: <CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com>
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
To:     Andrea Righi <andrea.righi@canonical.com>,
        Eric Curtin <ecurtin@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Martin Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, rust-for-linux@vger.kernel.org,
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

On Fri, Feb 10, 2023 at 4:26 PM Andrea Righi <andrea.righi@canonical.com> wrote:
>
> nm can use "R" or "r" to show read-only data sections, but
> scripts/is_rust_module.sh can only recognize "r", so with some versions
> of binutils it can fail to detect if a module is a Rust module or not.

Do you know which versions? If so, it would be nice to document it here.

> Moreover, with this patch applied I can also relax the constraint of
> "RUST depends on !DEBUG_INFO_BTF" and build a kernel with Rust and BTF
> enabled at the same time (of course BTF generation is still skipped for
> Rust modules).

Even if that build succeeds, can you load the modules? i.e. the
constraint was there due to
https://github.com/Rust-for-Linux/linux/issues/735.

Also Cc'ing Daniel, Eric and Martin since they are the ones working on this.

Cheers,
Miguel
