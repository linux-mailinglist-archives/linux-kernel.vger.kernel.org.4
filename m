Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C774FBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGKXpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGKXpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:45:00 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790E3170F;
        Tue, 11 Jul 2023 16:44:59 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so7213041276.3;
        Tue, 11 Jul 2023 16:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689119098; x=1691711098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqagiTUmZB/5CFgUf1pF1GfTaJyc9bRwpeqvA9m39kQ=;
        b=XoT0SZ2pcH+fLkNz8tah/GIkgFpsyRNFrGuwdykAPATYOvc8Uh2hdpzCj82Jl9s/B7
         pp4t+YFaWVM83bO2XJ310WUSBtxX2cqELm6tyZMtdizpZrhghKW4p4ifCHo4FsYfv2hV
         SqwhXxPtnAKRSjpYhcxIylzI/D88chilt+zuvTcIeOvcpDtOQohXbieQj1hG30x5K/+E
         aVJQrO8I+EzZIu3v2r/4JkS9pis7SQohptXbGXn78I0mlLXlbEwmOWOn599/g5cGD7lz
         Nr2S8d1c1r11JsFoEbqBFKBUJZwjY/K9BkBfMW01nSL3PUCT5irpcoSNTljklIGo3fao
         fIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689119098; x=1691711098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqagiTUmZB/5CFgUf1pF1GfTaJyc9bRwpeqvA9m39kQ=;
        b=TYu0B7CCSI0gEbHt0KrpBiTgoPTxl5KWBqUpTGO1TSzg3dmjcNFHPIn92jOw1JVv8y
         ijLyluhsQBQlalCtywsHF23AQ10r2SJRhIj1JzoosMWSWlbMp8x/KO4QZZhMdC55jqzw
         F+c7hqUBRkd0XsnXzWsuyxoPZfelZoh5/5Ib9q5Lr426KFS6v8grLMFbalFJZO7gCwRR
         Qafr77qveTyejQNRIsdEm5yBsYxLvBylMfZWcn9GY7TnNSp495FCljKR8lPd1xE6PDXz
         L02EhjYA7geqcAOPW1j7wUW6VzoFzmcLIN7tOQK0zXZTmBloEoDg1428tko3usWfTesm
         oZDA==
X-Gm-Message-State: ABy/qLblhkEZHky9p8bay8cYLx88by7dI4jYCsjCcyhuaDAIWkp8QDp1
        cKPE7z1NfO0HXB6NI9+qg8IwlIJaSxtvsbdJnS0=
X-Google-Smtp-Source: APBJJlGqWFfcEk/Yuzd7pg0bifj+QyCg9f3zWHFbBvad184C8din+q5CRZcghJectXmQ/PKE9FofTcznqbOu7yRztKo=
X-Received: by 2002:a25:b988:0:b0:c13:7b11:e786 with SMTP id
 r8-20020a25b988000000b00c137b11e786mr13933242ybg.17.1689119098672; Tue, 11
 Jul 2023 16:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230711093303.1433770-1-aliceryhl@google.com> <ZK3VEPeBEyErmerR@slm.duckdns.org>
In-Reply-To: <ZK3VEPeBEyErmerR@slm.duckdns.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Jul 2023 01:44:47 +0200
Message-ID: <CANiq72nktgf_j-+S7snysQgwqeqB12sfjc-vrLsnOUKiZZ5WJw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] rust: workqueue: add bindings for the workqueue
To:     Tejun Heo <tj@kernel.org>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:17=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> I don't understand a lot but the part that I understand (Alice helped me =
a
> lot, thanks) and the example usages look fine to me. While the interface
> leaves some workqueue features uncovered (e.g. flushing, creating custom
> workqueues, queueing on a specific CPU), there's nothing blocking adding
> them later and this looks like a good place to start. So, from workqueue
> POV:
>
>  Acked-by: Tejun Heo <tj@kernel.org>

Thanks a lot Tejun!

> Please feel free to route the patches through the rust tree. If you want
> them to go through the workqueue tree, please let me know.

As you prefer -- if you are willing to take them and/or maintain or
co-maintain patches to it, and it is not a lot of work for you, then
it would be great to get you involved, of course. Otherwise, we can
apply them to the Rust tree too.

Cheers,
Miguel
