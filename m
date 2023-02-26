Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B46A2FF1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBZO1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBZO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:27:06 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E103BFF2B;
        Sun, 26 Feb 2023 06:27:01 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536bbef1c5eso108879127b3.9;
        Sun, 26 Feb 2023 06:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGH9kXSraDN+mVD9fqltVHucO9c601DRLuGoJN4kmTQ=;
        b=QaX5VGmC41VJmIz8TPU/W9pU9Rlq9pZ/fyEg+Y2vn9A1f8ToZJReD9OrGqJ+DTKLRD
         ns1/z9DlMNvs6CUQN7zDHeudlxt1ro/FaxhLR78SSphz+727jJALOFuSJBjiWbxLsj4L
         S7krOunD0mliF8uwQvIlK6TtZ5l2L0kySnNA9lZ+vU9GHTrjl0DgynOjiTWfgxsZO6ot
         q16VJY0Tex84DLUmC12L+ZLNI93kDG9RuQ1boJ+xK1cNEIl0OSUBvueq0do2L9rmZRAp
         HZsnO6EQQWLCdo1OM9TxtRSJCXCNn+c3H4LijfegmZqH0LIdbLicdKPx5vS/we4W6X9x
         V84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGH9kXSraDN+mVD9fqltVHucO9c601DRLuGoJN4kmTQ=;
        b=k7lEoq2MzBrp7YfnxnzaO6UUFtx8KEPVz6csqaqESZ2EH4MFHXB2Oy7hnJaOhsFPrb
         6w1C4Th9s6h3mE3dTCJTwS+iuPHaQ8x8uQCVchlQVHqng8h+o/h7CZbMX+eDfZ5XTh/o
         TG6nCdAwsibtPoYHZZKnKpZttOpGcOrPUJglfL8zbS/JsjWbVmfHtGYAMArXnZ9jwXDW
         /OGFGd6nU7jsbk0XMnA156eoJV7G7dTW3iEgpw3bCkuJkd3zHMgYYq+pNW4EHREOwvGZ
         Z066hHze+52MTjlGz67tbeGkUhzsO82dYVjM0ceCjicKn2m/FLKL9G4Jk4g280Ntpbfa
         Y5Ew==
X-Gm-Message-State: AO0yUKVG1r/zA0ly6pNy4F3h3dK5uqEYKQKgjFn/gbVoEkYkU/OJWjX4
        ghtRHKZpNvImSPiLobTO0sBNJBN9nQ2wZBs4Xkc=
X-Google-Smtp-Source: AK7set+BtJD8RCDTOmU2TeKNwV20RDhvx+4CTS3ldjyAjzOcc5t/EOb7HDEA56Nq2rWGpj4W8kY/ScQOG4rqMg4sfDQ=
X-Received: by 2002:a05:6902:1:b0:a27:40c4:e12c with SMTP id
 l1-20020a056902000100b00a2740c4e12cmr6759616ybh.2.1677421621166; Sun, 26 Feb
 2023 06:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-1-f8f9a9a87303@asahilina.net> <20230225221405.62e989c8.gary@garyguo.net>
In-Reply-To: <20230225221405.62e989c8.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 26 Feb 2023 15:26:50 +0100
Message-ID: <CANiq72kOb9mbh4HQzH40Ey+Rax3vREsd0Nf2O0apjDpsboE6vQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: error: Add Error::to_ptr()
To:     Gary Guo <gary@garyguo.net>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 11:14=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I know that we already have `IS_ERR` in helpers.c, but having to go
> through FFI and helper functions for something as simple as a cast
> feels awkward to me.
>
> Given that `ERR_PTR`'s C definition is very unlike to change, would it
> be problematic if we just reimplement it in Rust as
>
> ```rust
> fn ERR_PTR(error: core::ffi::c_long) -> *mut core::ffi::c_void {
>     error as _
>     // Or `core::ptr::invalid(error as _)` with strict provenance
> }
> ```
> ?
>
> I personally think it should be fine, but I'll leave the decision to
> Miguel.

On one hand, we have tried to minimize duplication (and, in general,
any changes to the C side) so far where possible, especially
pre-merge, doing it only when needed, e.g. for `const` purposes.

On the other hand, being in the kernel opens up a few possibilities to
consider, and it is true it feels like some of these could get
reimplemented, even if not strictly needed. If we can show a
performance/text size difference on e.g. a non-trivial subsystem or
module, I think we should do it.

If we do it, then I think we should add a note on the C side so that
it is clear there is a duplicated implementation elsewhere, avoiding
future problems. In fact, it would be ideal to do it consistently,
e.g. also for the ioctl ones. Something like:

    /* Rust: reimplemented as `kernel::error::ERR_PTR`. */
    static inline void * __must_check ERR_PTR(long error)
    {
        return (void *) error;
    }

Or perhaps something even smaller.

But I don't want to block the rest of the work on this, which may need
some extra/parallel discussion, so let's keep the helper for the time
being. That way we can also do that change independently and justify
the change showing the difference in performance/text, if any, in the
commit message.

Cheers,
Miguel
