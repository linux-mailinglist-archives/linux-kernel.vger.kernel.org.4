Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67654641E3F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiLDRgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 12:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLDRgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 12:36:21 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43E14096;
        Sun,  4 Dec 2022 09:36:20 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-14455716674so4867806fac.7;
        Sun, 04 Dec 2022 09:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TXEZvr3bKu2vBIW+lpuSVItbWZwpWlZ50nx9XuTinWU=;
        b=K5E0+LOnggn/gYMPFlw4zI4PSzD+JHSdGy4UU6wttfDL2DlzF3ueIgIOWR7oRXgHct
         xh9/3Brq5EmMilnZRjlVNdphsZo4PWHbyyb/k6XiLdDRWtE6JynFvaohTeAc9fSEii3/
         O/cJm1NIlZq/KdCpD/QjSgbxheAoTFj8fsV9nL/J0zC0HAwKKezkr0ZseQAaU0n9/BBJ
         xMdieALMDasrbQlarT2uBdq5jLLcve65SIkefFLHCVyhwxyGzH4ePF+6ikpWycWuWATh
         XP5BoyplLSdQ/zWMjnzqnSv5Vl3OeM3M9Lsn+L0yP14j8Ftd9RDrKoOmoHz0LwrkqcoQ
         AIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXEZvr3bKu2vBIW+lpuSVItbWZwpWlZ50nx9XuTinWU=;
        b=Ibq8XhiRu4yKwKUoleDS78llmAwgua7rD4Nl1ozubPkoPjo9soYavhRgH17R+xQlkt
         16NCGui+TCZAplJ9d8z77bPe+3vZZ02ivcwm0sDUqOsrQvUAAy/xGFtlr+kdRgOnpOoj
         5DMTz70rH6QrTQ1Wq9reXE8miYzo6klMWCb5K0LaNc7ffeHtcZfsZ0PKyqDAhV52IRuj
         dOeCmOStUW9dCf4jNJ+IJjM2wBXTOUPIi/C/LRDPr6jGInTsyJyKcorKonhWyrAD9V0u
         EwTgtPP+7sYvm7U1zU5j2C8ukyfPTefVB03axP9Z69In1jBf3OrTE/4pdTT72qU4oN5M
         K8Aw==
X-Gm-Message-State: ANoB5pk7R6IKjsq+JgJMU/F3wZtFTv7VE0hpRrHElvt62x3JnMpDAvBp
        sdnjBGwokH2UsnEgPpQluUH+C1f/7Tv78YcG/NI=
X-Google-Smtp-Source: AA0mqf5xGkkp4TyK3rNiEGg6B2v4wlLttK5ZifOyxNPE9HKBFN7/u15rFv7uwOIrxKmrz2YDbDeQ4YFqtbIlts4XwsA=
X-Received: by 2002:a05:6870:6c02:b0:143:80af:e36a with SMTP id
 na2-20020a0568706c0200b0014380afe36amr22895324oab.254.1670175379350; Sun, 04
 Dec 2022 09:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20221202161502.385525-1-ojeda@kernel.org> <20221202161502.385525-28-ojeda@kernel.org>
 <Y4qNR+Nn9utDftHq@localhost> <20221204103153.117675b1@GaryWorkstation>
In-Reply-To: <20221204103153.117675b1@GaryWorkstation>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sun, 4 Dec 2022 17:36:08 +0000
Message-ID: <CANeycqpNW0E5fQqD1Qzqr0p-3cgs5k5KgLusragaSWbrmcx2Nw@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] rust: types: add `Either` type
To:     Gary Guo <gary@garyguo.net>
Cc:     Josh Triplett <josh@joshtriplett.org>, ojeda@kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
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

On Sun, 4 Dec 2022 at 10:31, Gary Guo <gary@garyguo.net> wrote:
>
> On Fri, 2 Dec 2022 15:41:59 -0800
> Josh Triplett <josh@joshtriplett.org> wrote:
>
> > On Fri, Dec 02, 2022 at 05:14:58PM +0100, ojeda@kernel.org wrote:
> > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > >
> > > Introduce the new `types` module of the `kernel` crate with
> > > `Either` as its first type.
> > >
> > > `Either<L, R>` is a sum type that always holds either a value
> > > of type `L` (`Left` variant) or `R` (`Right` variant).
> > >
> > > For instance:
> > >
> > >     struct Executor {
> > >         queue: Either<BoxedQueue, &'static Queue>,
> > >     }
> >
> > This specific example seems like it would be better served by the
> > existing `Cow` type.
>
> We use `no_global_oom_handling`, which gates most `ToOwned`
> implementations (e.g. `str` cannot implement `to_owned()` because it
> cannot guarantee allocation success).
>
> So the Rust `Cow` is pretty much useless in the kernel.

It's also implemented in `std`, which the kernel doesn't include.
(Which is actually good for us, since we can't really use it.)

Josh, how do you feel about adding a `TryToOwned` trait to
`core::borrow`? This would be similar to the precedent of `TryFrom` in
addition to `From` for the fallible case, and would be usable by the
kernel.
