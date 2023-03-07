Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915406AEEA2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjCGSNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjCGSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:13:30 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9D9FE56;
        Tue,  7 Mar 2023 10:09:07 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536be69eadfso259954637b3.1;
        Tue, 07 Mar 2023 10:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678212546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPM190mWLLkc07dSqy28s11Zcwbxf5IPd1Jdgp0CgOE=;
        b=ghNeLR6Ak9VAOjLD39wV4MjLb6xPIWr3hbQoyqUD50LpZgS5BYAF91Cc5jy/Slun3D
         gcJFdgGLoJIhSbQ8SNt2uC5HEemGRrWuCUkeEBAPJOvQL6ph3ub3ljb3F69TujRkRu/o
         Vm139/mowJHqvVXXDf4HO3LHnGsMS8d6WDtfQDcVA1BQRi2872fwamNKb/XBHLvbAK5P
         dNFdnWExnRcCSVHSQ/SFKh5IxI/1yLf4oU8uDugv5jKy2X5wVlrRNpg6QnVWE1fLbREX
         aLqPL1TAmiRBd1oSU7Ad7NVBNNoImI+q4jQoQKibBE6easr9zAgCxyN5RG+Jh5cK/twS
         1LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPM190mWLLkc07dSqy28s11Zcwbxf5IPd1Jdgp0CgOE=;
        b=jnJKFwxXUGzD3xseeIiF9g+WB2eKY1lxZJYbBiBYAwXTqGU73uk5vhL8WRS2sZ3s9p
         Mr3UDNkcIXiNeDLo7NAa31pWuwNYlO+vn5s7Q3OFbrsEIjIpK7hVsbQxlqi/isZ7Y8VR
         6Ou9K9lJkmVI8h0sPNVvt8LOp2sE4Jzb/gohscF/56X/MdPN1+r/hY0ojpV4L2DeKB2H
         0cwRg3JqL8vQFaqVzQtOV6ZHzVDDpT30OzHmJtiU+3NBp1w4dyY77g7Bs1cbTKt7RnU8
         U0xIZxdmaMLwALfKuVJtsXxwy5fs4qNEg6CoQ2PXunvvQnj6yitXyYQ32ha4GmtmkNug
         X/vw==
X-Gm-Message-State: AO0yUKV0dLEpaNt+mp4XZe+E4paRVd/a1O0WLHKBckbZfZUPe5aPfD/K
        ce0DCkzSs/yeJobLVXWYcSbm7sm8PDFyIgEsHqUQ7Bp1EINO6w==
X-Google-Smtp-Source: AK7set+zX2rluBwJh50Ty9wiKIeQaVf+J6OP4bqn5EEBFhTdKRbejtoGapg0eBHCGfp7r+DCU79YjdHmoY7o8hC1vVs=
X-Received: by 2002:a81:ad44:0:b0:52a:92e9:27c1 with SMTP id
 l4-20020a81ad44000000b0052a92e927c1mr9818472ywk.10.1678212546451; Tue, 07 Mar
 2023 10:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20230307130332.53029-1-daniel.almeida@collabora.com>
In-Reply-To: <20230307130332.53029-1-daniel.almeida@collabora.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 19:08:55 +0100
Message-ID: <CANiq72nkBAfM_b50DsuoJjy3hXhBxNRK0oeU_kyQHaMnnjvGJA@mail.gmail.com>
Subject: Re: [PATCH] rust: virtio: add virtio support
To:     Daniel Almeida <daniel.almeida@collabora.com>
Cc:     wedsonaf@gmail.com, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
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

On Tue, Mar 7, 2023 at 2:04=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Feel free to point me to the best practices around Rust patch
> submission, as the C stuff like checkpatch etc probably does not apply
> yet. I did take care to run clippy though.

Yeah, some nits below as if you had run a script like that :)

>  #include <linux/uaccess.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
>  #include <linux/uio.h>

Please sort these.

> +#![allow(missing_docs)]

Unless there is a very good reason (which should most likely be
documented in that case), please instead document everything. We keep
lints "deny" instead of `-Fmissing_docs` just in case there is a need
somewhere, but that does not mean not documenting is OK in general.

(Also, the module-level attributes would be placed after the docs).

> +///! Virtio abstractions
> +///!
> +///! C header: [`include/linux/virtio.h`](../../../../include/media/virt=
io.h)

Please add a blank line after the module-level docs.

> +unsafe impl const crate::driver::RawDeviceId for DeviceId {

`unsafe impl` need `SAFETY` comments too, just like for blocks (which
Bj=C3=B6rn mentioned). I see you did one elsewhere, though.

> +    // No `data` pointer.
> +    fn to_rawid(&self, _offset: isize) -> Self::RawType {

I see there is no `data` pointer compared to e.g. an `amba_id`, but
what the comment means? Is it about that that is the reason for
`_offset` being unused? Or something else?

> +        from_kernel_result! {

We will be going away from `from_kernel_result!` (in case you wonder
when rebasing in the future).

> +        // SAFETY: `virtio_device` is guaranteed to be a valid, non-null
> +        // pointer. `priv_` was set on probe().

Markdown: probe() -> `probe()`. Same elsewhere where possible to be consist=
ent.

> +        // SAFETY:
> +        //   - we allocated this pointer using `T::Data::into_foreign`,
> +        //     so it is safe to turn back into a `T::Data`.

Please start the sentences with uppercase (same elsewhere).

> +    /// The table of device ids supported by the driver.

Maybe "device ids" -> "`DeviceId`s"?

Somewhere else you used an intra-doc link, which is great. Please use
them wherever possible, e.g. if you go for the type here, maybe it
works too i.e. [`DeviceId`]

> +    /// A wrapper over virtqueue_add_sgs()

If you are referring to the C one, normally we note that (i.e. in
order to distinguish it from a Rust one). Also period at the end.

For instance:

    /// A wrapper over the C side `virtqueue_add_sgs()`.

However, the function should instead document what it does, rather
than just refer to the C one. Same elsewhere.

> +            if buf.is_null() {
> +                return None;
> +            } else {
> +                // SAFETY: if there is a buffer token, it came from
> +                // into_foreign() as called in add_sgs.
> +                <T::PrivateData as ForeignOwnable>::from_foreign(buf)
> +            }

No need for `else` after `return`, so you can remove the indentation
too. Also Markdown.

> +    pub(crate) unsafe extern "C" fn vq_callback(vq: *mut bindings::virtq=
ueue) {
> +        // SAFETY: the caller should guarantee that vq is valid for the =
lifetime
> +        // of Self.

Markdown and uppercase -- here and elsewhere, e.g.

    // SAFETY: The caller should guarantee that `vq` is valid for the lifet=
ime
    // of `Self`.

> +            device: 0, // The protocol ID.

Please place the comment on top.

> +        // let virtqueue =3D virtio_dev.find_virtqueue::<VirtqueueCallba=
ck>(kernel::c_str!(""))?;

    // ```rust
    // let ...
    // ```

Thanks for the patch!

Cheers,
Miguel
