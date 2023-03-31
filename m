Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8C6D1F98
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCaMDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjCaMDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:03:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565A1D2E4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:03:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o32so12741127wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680264225;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=IRLPm58nvNy/2NFW9neC7Qw5GTvVFQCMvaYOxcSEPmA=;
        b=0BgaJCtMEiEOlcg8O3FcHhdaMk9i73ICEwE5v97F1WAbUlcHbQnGsqNMz9brTOGwyr
         JSHjHjyl4I1quIv6hVdfYZBXMJt/hodKk8vQRw7fbnZXx1kNutcXsYfDvjTIKw9VUr4m
         e49tfQLIXGiv7p/nWI2pIOswlc1F6NypOwJKw8EGiBfNuwnd9rKsmmT1T1pie39aHKPb
         d+ACBxPozHIeMPMwYWMX8eaJDVATpJZErWLknavTpM4kt0FHdieULuMZOm+9IiyQh/5u
         U50IcPWGOsih/HqfdWiEoOqYF6z1gIslXeGClJI1zaDEHNR1BEeO/3y/lpul5YdUU71K
         v25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680264225;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRLPm58nvNy/2NFW9neC7Qw5GTvVFQCMvaYOxcSEPmA=;
        b=2awjIUATkbluwFsfi5iGtxuKHVXB9Tye0SgZnUpy1BYKWpTeZzfx49MWILZJcvOuCg
         TG+Ijk21OnXayefiuSegS1k4c/rKyV1bU+Vem93B1cXhh9hLL71nNti8sZ625o1DEOkL
         izW3zcL3BifPD3JhrS9KSQb2Fids7uNplI9OI4y9zYkSHRUUoWpSu0NyDNh+cGhhL6Ex
         TZ14cAVPX8V8fILIIuSNBeYGKRiQhJumA/xvZDgV5iy8wxK5dXKwqg3llcjRT15wg1UY
         KWIomvBihTTtG+f6K4buLf+v3X8LIQmgUCtjqNFst25MVCzjRVL3P7Y6x3mkeH+kxIpS
         OQmw==
X-Gm-Message-State: AO0yUKUQ/4kemXCfAUh99Nsn9TWxB245xGsp3VmaXvg5Wpqr1SR9TlVy
        I5mUWpl3iPlmjcCOF3gzQZH9tA==
X-Google-Smtp-Source: AK7set9z+4TYwXvwxxS/ReumUqCrNxDNO7RSbX+Xb7eBl+H7zYeDXuRhsdk3E1jRdTpdbc8wKebjAQ==
X-Received: by 2002:a05:600c:218d:b0:3eb:29fe:f922 with SMTP id e13-20020a05600c218d00b003eb29fef922mr19875265wme.29.1680264224939;
        Fri, 31 Mar 2023 05:03:44 -0700 (PDT)
Received: from localhost ([147.161.155.91])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003edc11c2ecbsm2517307wmd.4.2023.03.31.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:03:44 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-6-y86-dev@protonmail.com>
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
Subject: Re: [PATCH v3 05/13] rust: init: add initialization macros
Date:   Fri, 31 Mar 2023 14:02:47 +0200
In-reply-to: <20230329223239.138757-6-y86-dev@protonmail.com>
Message-ID: <87o7o92km7.fsf@metaspace.dk>
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
> Add the following initializer macros:
> - `#[pin_data]` to annotate structurally pinned fields of structs,
>   needed for `pin_init!` and `try_pin_init!` to select the correct
>   initializer of fields.
> - `pin_init!` create a pin-initializer for a struct with the
>   `Infallible` error type.
> - `try_pin_init!` create a pin-initializer for a struct with a custom
>   error type (`kernel::error::Error` is the default).
> - `init!` create an in-place-initializer for a struct with the
>   `Infallible` error type.
> - `try_init!` create an in-place-initializer for a struct with a custom
>   error type (`kernel::error::Error` is the default).
>
> Also add their needed internal helper traits and structs.
>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

