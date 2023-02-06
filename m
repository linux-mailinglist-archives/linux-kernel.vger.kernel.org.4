Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941168CAC9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBFXr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFXrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:47:25 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081EA2A9BE;
        Mon,  6 Feb 2023 15:47:25 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i2so13250225ybt.2;
        Mon, 06 Feb 2023 15:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0VIMf/p8DNxnvhdoRgInCxniTaEHL9Qw+dJEsM3OSrE=;
        b=EGxO0xjAGUZ+SJzVZyBLNa5dKEZe5afTloTr1HTwcrgDVKIEydhIMtIXJMoZyo2upU
         wYpE6rn1m7XCpUeB4vk9R32oz2s/NnGsFpV4ebz9SoIABAOUCRrxC3wZY5p9bDjLePOW
         yViJadibxWqK4C67UKTkMIECiovnMw7kmxzn5hX4PDaRnyBXrpJ4ygjYGZqbjjWOl+Nb
         UsmEj8T8UbxggSh/EDNFvGA7dWUyYacbsMDPFQR1zq8RSWhwQnM0P0KmCjT3CKTm8Grc
         VI9FMd8h4eGY8DbkE8/PqSWNgLLz/mXmXGd7ny4Jbk/5Br9oVvgoY9W26PrE5Cu/pby6
         9IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VIMf/p8DNxnvhdoRgInCxniTaEHL9Qw+dJEsM3OSrE=;
        b=m2uBCybbHbxaHr5LDbGewJgR3IMG7Ogi4V+QBdRJXTLaLPZ0JfDSQM9aJiFq7BlTty
         b54pShA67P0X6eJrFgNrFcHSLjdIoIMlgIbmBltdPPXV7EuUtczOTqcxXHsc5R7trZwy
         43GRVsqRitsoKzGqMWj0JFHSmhLTsyMQMoku18hwRQNMYVOeUXZ7PQx5PoXDSgZh233U
         zgXyRrlR603WdDqNPnbX0egwp1lpLOtNWV5gC8aGXd+IFtvIDmiE7UUK7ww/VSGM32CB
         HFY5DGj2aJoKqvxm6I7w8UkdhQLUj34jcv3w8kx04Htz2j3egEwEj6IOi8znF/cVLkyG
         wdWw==
X-Gm-Message-State: AO0yUKVm6gjxl0uXNaP2w89rDLjFkNsgZW2EYrbNEESXZT0IAxEnTkl9
        +yjchjvxL6bh03eB6j0rdTuzgeCGzyIobUTOF+M=
X-Google-Smtp-Source: AK7set80hjxJwDBD5e4tOifsmc39RMdBrwz6z5NcMTczanHcM5pwCl4oxz97AFQJs8s7o5HuDLXdPlsK/vkkuP5Sgvg=
X-Received: by 2002:a25:50c5:0:b0:80f:3b51:ddf5 with SMTP id
 e188-20020a2550c5000000b0080f3b51ddf5mr187801ybb.507.1675727244243; Mon, 06
 Feb 2023 15:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20230130064404.744600-1-wedsonaf@gmail.com> <20230130064404.744600-5-wedsonaf@gmail.com>
 <87h6w5isfq.fsf@metaspace.dk>
In-Reply-To: <87h6w5isfq.fsf@metaspace.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Feb 2023 00:47:13 +0100
Message-ID: <CANiq72nGh9ypPY2QvJF5oak_1qBBG6z6LhHz8hxgp875HCx48Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: types: implement `ForeignOwnable` for `Arc<T>`
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
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

On Wed, Feb 1, 2023 at 11:35 AM Andreas Hindborg <nmi@metaspace.dk> wrote:
>
> The last part of the sentence does not read clearly to me. Would this
> make sense instead:
>
> // SAFETY: By the safety requirement of this function, we know that `ptr` came from
> // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
> // holds a reference count increment that is transferrable to us.

In a private chat with Wedson he agreed the "owned" was a typo and he
is fine with this change. Thus I rebased to apply this and avoid a v3
given it is trivial and almost at the top of the stack. If you want
the `Reviewed-by`, please let me know!

Cheers,
Miguel
