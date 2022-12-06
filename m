Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E6644844
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiLFPpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiLFPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:45:05 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5523BE8;
        Tue,  6 Dec 2022 07:45:05 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3bfd998fa53so156136177b3.5;
        Tue, 06 Dec 2022 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyn/5OOpj6fuvvU8fDY8RxPX62J9zsQGOj41hMQD++E=;
        b=k8z+ItRXCJIZn49dArRvY9i2iLkbpKITT2yKWV7GhS15NtPNWTLX4W9gPJiA+n5QUF
         NcxMp5umXW3D3lkSQYDFn7B92I7NQD79r09dTxc83Lmc5+iZ3mZf0H9JklZhxWkedCCx
         RpF9jzuAYx3dFugt2ZfmjVuwhv5hqi8kn+Bk1Rxc5NQ3z4D7cd+oL1Lwu/EiiXu2VG+Q
         C5bKbdEhWEhJd9hsfJdsXVrnwteuyekAYTIGcYnp6jX96HE1/jDe93IFNfCY7116GX7k
         yFIipMpUPbzTNYVwr6pmiOnumxQXAfCg1qlTYyF8vX5PXphOLeKRirj5QQ7lXXVb12Ww
         A9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyn/5OOpj6fuvvU8fDY8RxPX62J9zsQGOj41hMQD++E=;
        b=Gro79z+l4MHTeIRWJOU991upIigj7a4eR/b0wJkmaHZM+RRA3uvX4A/Tbo9vk7jXjj
         8UCTFjZ/XuqdTfeC4bqPKdGpprdMN/+1VKSkKm+wXdkaOuXWL4gw7F+qiZtAEHfxIMQl
         kHobAoQcdXAW9FgdV8hX81TvenFFjXi6KzEcOogY6k/LLZw5nAmmgiO8E2S+KfIzB44h
         sm6v45e3DS6+Y8LruEXlbQkmoG5vmdd0hx7trpPCh0uXu66EeQ8TfSM15p/3FtQJMnh6
         C7h7pUsIEiUm3uGhteTk0jLImWDTOwpciQVNwtEFOZuoU87VImopcPnx2rZng/XxDmg7
         rHEA==
X-Gm-Message-State: ANoB5pn7rbhQvIb5j5zCs3K1fMo7UyVmgh0AevTquyqytK4HZ9KhO/im
        rOtF4znivSKeFVcJ2wPlmF/eX+fY7jZH9hQKi8Y=
X-Google-Smtp-Source: AA0mqf7yhwfAtr/XG/SmzqtvjyIx0HdmN3mODQ5NsTqnY7yPgIynig5Nt7kqbdksBf+abg/7ApTsX1Zkryio5SQeUns=
X-Received: by 2002:a05:690c:b03:b0:3f4:6e40:89c3 with SMTP id
 cj3-20020a05690c0b0300b003f46e4089c3mr4057837ywb.266.1670341504250; Tue, 06
 Dec 2022 07:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20221202161502.385525-1-ojeda@kernel.org> <20221202161502.385525-7-ojeda@kernel.org>
 <982F921F-08BF-43E3-95F3-20329AB59A69@nyantec.com>
In-Reply-To: <982F921F-08BF-43E3-95F3-20329AB59A69@nyantec.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 6 Dec 2022 16:44:53 +0100
Message-ID: <CANiq72ncU_LcNgFBgLorHgiaP1ybGrtvi=xrNittX47n2WE5JQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] rust: macros: add `#[vtable]` proc macro
To:     Finn Behrens <fin@nyantec.com>
Cc:     ojeda@kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
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

On Tue, Dec 6, 2022 at 1:50 PM Finn Behrens <fin@nyantec.com> wrote:
>
> Reviewed-by: Finn Behrens <fin@nyantec.com>

Thanks a lot for these, Finn -- I already queued the patches on the
weekend, but if for some reason the series needs to be dropped and
reapplied, I will pick your new tags.

Cheers,
Miguel
