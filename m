Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D96D1F95
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCaMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCaMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:02:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584FD1BF64
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:02:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q19so19065438wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680264138;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=me6wuukqjm6+JgHKL/b7Cfg/XRIamYGaPs47EOLk4SA=;
        b=NtEMRH7lOht6iy9cvC9nfq7w6MPzHGqwFfvITBaIWiPIICbDdkmz5L3qKu16YujBLP
         rJapPCtzjxPECq39Es2y1wu50GTpiSXNHyVqN3YIBKq7VXjTjRm6NuFxKINK4VcA67kO
         u7EqxjhmWwl9c0TqtWNB+bs/Ph2/g5d48oFH7tq4WjjTn8Su2S/cV6XOl8ndff4boVuZ
         cU0ly+emc0ndyjSiTOAOwRKOw/yfxdA0UEpb7kct7f0QQzXPEtVPu4al3ldiv8gD95Q/
         2qaHmJR4la9wVKcs9PuyrSR19P6ijNL5/xSkEzYkkdDrd/nxyZ2iOttIzECWMFNh0vmh
         OkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680264138;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me6wuukqjm6+JgHKL/b7Cfg/XRIamYGaPs47EOLk4SA=;
        b=YFbyBdiWGKs3Pu+5/VKnKsKGbLnk3yX3FG4jjYvWE1AQuqh+2VEoYX1CDwJTwvREgg
         pOvVVOEqkH1mTWw6LT8VYXMv2TAtxcEXGeHvIM2bmpTU2h4n/kO8zYXhAJcWj9gj+o/f
         MjMy9lDF9VvQ35iKc/OWMxB1F04uDwEgMcbMvn4fUE07n8bX+zXF1vYLamanuTH2iM1h
         6zhcXwYQ9xwS9kGonOuntXAM+Mfor9me52DU5YS2McsJDsV2s6uRYNW+O5bK9aQHMmkd
         Bw0K2+hRVUEkNMT+k0y6HMthKFq/BMhKkgQ4wAZml9hrhGvg6Lzr8W6q/kO4aBcPbIyn
         y9Og==
X-Gm-Message-State: AAQBX9fgEalHPLvU1ByUE5isa7zpPOtLjplQ2wIkpx+u1tgyNFO9vuEh
        laU3hUTayZlddkspKtI7Z0IxXg==
X-Google-Smtp-Source: AKy350aJxK4HdPucT44lt8HLnYYH/U3bSyRG2tAOfK7Gdna0jErfLf3jUp17vzmvhF9FC2LNVs+HVg==
X-Received: by 2002:adf:f6cc:0:b0:2cf:1c43:7056 with SMTP id y12-20020adff6cc000000b002cf1c437056mr19268160wrp.36.1680264137871;
        Fri, 31 Mar 2023 05:02:17 -0700 (PDT)
Received: from localhost ([147.161.155.91])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d5265000000b002e55cc69169sm2064017wrc.38.2023.03.31.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:02:17 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-5-y86-dev@protonmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v3 04/13] rust: add pin-init API core
Date:   Fri, 31 Mar 2023 14:00:31 +0200
In-reply-to: <20230329223239.138757-5-y86-dev@protonmail.com>
Message-ID: <87sfdl2kon.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


y86-dev@protonmail.com writes:

> From: Benno Lossin <y86-dev@protonmail.com>
>
> This API is used to facilitate safe pinned initialization of structs. It
> replaces cumbersome `unsafe` manual initialization with elegant safe macro
> invocations.
>
> Due to the size of this change it has been split into six commits:
> 1. This commit introducing the basic public interface: traits and
>    functions to represent and create initializers.
> 2. Adds the `#[pin_data]`, `pin_init!`, `try_pin_init!`, `init!` and
>    `try_init!` macros along with their internal types.
> 3. Adds the `InPlaceInit` trait that allows using an initializer to create
>    an object inside of a `Box<T>` and other smart pointers.
> 4. Adds the `PinnedDrop` trait and adds macro support for it in
>    the `#[pin_data]` macro.
> 5. Adds the `stack_pin_init!` macro allowing to pin-initialize a struct on
>    the stack.
> 6. Adds the `Zeroable` trait and `init::zeroed` function to initialize
>    types that have `0x00` in all bytes as a valid bit pattern.
>
> --

<snip>

> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
