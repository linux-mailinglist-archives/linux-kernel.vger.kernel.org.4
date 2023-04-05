Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ED16D8514
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjDERmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjDERme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:42:34 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41B96196;
        Wed,  5 Apr 2023 10:42:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54601d90118so535712717b3.12;
        Wed, 05 Apr 2023 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680716549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86x0PDp2dRuf4KN9mwGdfvGa22shKRZzxNZEoJhsc00=;
        b=neZ+pF44MG3C4xAeYyqgKVPoze49D81zPReOTcgWHOL242Ty4prwJlWbXFx/fBCIED
         y+YX8HaGyT5nd+vBjPjNNsU3ihOCbUgnAWYHsJJi3cGLGON1L7+cAFD+3vOsA6Tpwpgs
         XzBNI6hgFNaxG5ggzl+yRYqO5RnW+1Q2EQ7MmQVmLH4ZW1V1ZyVhDJ9MRB9wXkE89uAJ
         VH0QeoPyDWh6OgJ2HnjBByzm7WMnEiubhuBuV+o8N67XghIMn9f/63POcdrEVpN0oPvu
         /o3KTxyNCwRTBsEg/WVGfwDoAenlnTDPQplTb6mNwZ3YQyKwZym4N619f6kxRMT2DoJM
         Z2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680716549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86x0PDp2dRuf4KN9mwGdfvGa22shKRZzxNZEoJhsc00=;
        b=M+IzhsNxl7PazHZxGgICH1I6916zc4MfqhmmoP83KjpR7Ku7R3t5F21+TG0W77u92H
         d31QTcSYvx0KEuvQy3AAisqOGky8dXBXNDRMBdlbS2sfrp+szxXnDlNoPc1iC5ztUJEp
         QATwSE+2jt+GJ8kC9E9EzedLpuPG6peRexiUh5FigW5T+gbWnc6GqzfcVdtDVTrIgP7w
         goaldowu09ui0mtlepPN50SZBD5qdwattbodPCobC8MnQ7+FG4iSu1/VnRWrzl1Lahj6
         OWuYxadwJj3b2fwVzUdK7SWZyA5iwIY9Tta1S1R5Bz/aWXOWq6JsMxZQ1DUlqa9TaK6r
         UVKQ==
X-Gm-Message-State: AAQBX9dW+Kv8w4snWvG2kCP+9wxFYKj4YrTDx/0Y7VZK55xl0oBU0T1u
        LRqxqtL4WnTfsyFl69+RuGwjQ/FiEb4MFiFfDU4=
X-Google-Smtp-Source: AKy350YRQYsEzjOQOfJlCfHpRc8kN0PYcDnrp9nYnw2f2Jy0Xn91S51iKuHZ1OzLGeGabDojkcaR55dxksCqK96KjFo=
X-Received: by 2002:a81:ce07:0:b0:53d:2772:65d with SMTP id
 t7-20020a81ce07000000b0053d2772065dmr4176918ywi.9.1680716548909; Wed, 05 Apr
 2023 10:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230330043954.562237-1-wedsonaf@gmail.com> <1cd137de-6ca0-a079-429f-6cb964a0f811@ryhl.io>
In-Reply-To: <1cd137de-6ca0-a079-429f-6cb964a0f811@ryhl.io>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 5 Apr 2023 14:42:17 -0300
Message-ID: <CANeycqq0ORMD2ybFoysnFVYcpnkVpr10GKyqsFuq8kehKveyTg@mail.gmail.com>
Subject: Re: [PATCH 01/13] rust: sync: introduce `LockClassKey`
To:     Alice Ryhl <alice@ryhl.io>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 at 04:28, Alice Ryhl <alice@ryhl.io> wrote:
>
> On 3/30/23 06:39, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > It is a wrapper around C's `lock_class_key`, which is used by the
> > synchronisation primitives that are checked with lockdep. This is in
> > preparation for introducing Rust abstractions for these primitives.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > +// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
> > +// provides its own synchronization.
> > +unsafe impl Sync for LockClassKey {}
>
> No Send?

We haven't needed it. We can add it when needed.

> > +
> > +impl LockClassKey {
> > +    /// Creates a new lock class key.
> > +    pub const fn new() -> Self {
> > +        Self(Opaque::uninit())
> > +    }
> > +
> > +    #[allow(dead_code)]
> > +    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> > +        self.0.get()
> > +    }
>
> I would just make this pub and drop the `#[allow(dead_code)]`. I think
> it is often useful to have methods like this available publicly.

The `allow(dead_code)` is removed on the next patch, it's here just to
make this patch compile when applied alone.

This isn't public because the return type refers to a type from
`bindings`, which we intend to eventually hide from drivers, making it
public now would like our lives harder in the future.
