Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE94716365
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjE3OOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjE3OOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:14:30 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203ACE44;
        Tue, 30 May 2023 07:14:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-568af2f6454so13351057b3.1;
        Tue, 30 May 2023 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456039; x=1688048039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTwLalb60PTMu/jAkQpXrnGqb2wva++F9Sq3eW5kYQw=;
        b=qPUeDTcfr7OxXHtWHpcNb077XYd+nlwgobee3voPFCtgiNZZCdBM2G3Mhwr2tv/LRJ
         jHmRt9KmlO/RUNoiqFwZSzGXMZaBSGflQGfKo+G6DDH+ielIX7hxTdc3rHYBPgRLOYX7
         h8GQHgoSGNJ+0lf1kj6aZ8S8zbAByKRnQBhxbFrgOcciMBi3CGF9Ey9JXPNtqraKpXgc
         Moy08rwTmdHh4+hZOS6DMcn5aohfMr+L/rSQcCnG2cCVx9nQ0hNv4qQNbCUcy0gB7FOi
         VMfhyusYx46sN3ZYS3Y2vxo5SkU+Kgx4hTm41bvGnkgAgk4P/fKBHtiMCJWWNcLAvwjN
         AIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456039; x=1688048039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTwLalb60PTMu/jAkQpXrnGqb2wva++F9Sq3eW5kYQw=;
        b=Q8j1gaqtJrci+p3jn5VzVgi/iEcmHhO/8pyolxASgUiSwWegt7uLpKU3NUi2byARg7
         TKzzAWxsioeGofIWZMEeg4kjLN92yufhMUeUmT5+huL/AD2upUNCnUH5XSXlAJOnfXDI
         WiYYOYpWMRuvV53wkzXXjQRz+Pv37PI0uI4mbiUkg2YYfxs+6V1KJ+jN59EhGVo1H4et
         eKaChUvspFXCosyiaP5jm6goGCRLEdqxqCi+c5xVcIi4V5Q/6gKvRbnS2iiq3UblqNgT
         T7h7MJR9rziFfi3whddxRRLzeqO07dYGA//gmbQR6NNHS/dEdWu5jTLWv9PIrgy12pjQ
         kepw==
X-Gm-Message-State: AC+VfDxyZvqL4GfoyjhdWus5UwSUAWRUYT/ksW8VP2V4NDyRtz+jAZ8h
        gRmKcSJ710i6jZ+MKbAN1TAQlexohAJ8R63Hjd8=
X-Google-Smtp-Source: ACHHUZ6RCEc1+fd5Perd8QLWxHmkFspNj2sVjBhJt3SR1lXVmV9tboAd8bJTp6zA0EHcE71YBH9ngmMm6Ax3uTvHiJo=
X-Received: by 2002:a81:a0d2:0:b0:565:6acc:2e56 with SMTP id
 x201-20020a81a0d2000000b005656acc2e56mr2589958ywg.15.1685456039055; Tue, 30
 May 2023 07:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <b54801cd-1afb-2190-3b8a-4a095d04fdff@gmail.com> <20230523110709.4077557-1-aliceryhl@google.com>
In-Reply-To: <20230523110709.4077557-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 30 May 2023 16:13:47 +0200
Message-ID: <CANiq72kw-3usvn6JfD9Lp5KVrYyCVgOEehM7qXdpTvoDrX5TCw@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] rust: workqueue: add safe API to workqueue
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     yakoyoku@gmail.com, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 1:07=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> I think this is a question of style. For a comparison:
>
> match (queue_work_on)(work_ptr) {
>     true =3D> Ok(()),
>     // SAFETY: The work queue has not taken ownership of the pointer.
>     false =3D> Err(unsafe { Arc::from_raw(ptr) }),
> }
>
> vs
>
> if (queue_work_on)(work_ptr) {
>     Ok(())
> } else {
>     // SAFETY: The work queue has not taken ownership of the pointer.
>     Err(unsafe { Arc::from_raw(ptr) }),
> }

There is also the possibility of using the early return style:

    if ... {
        return Err(...);
    }

    Ok(())

This one makes it consistent with other early exits (i.e. whether at
the end of the function or not) and closer to the C side.

It is particularly nice when we are talking about errors, instead of
two "equal", non-error outcomes.

Cheers,
Miguel
