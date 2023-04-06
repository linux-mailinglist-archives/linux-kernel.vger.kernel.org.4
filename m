Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313926DA5D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbjDFWdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:33:39 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AF98A7D;
        Thu,  6 Apr 2023 15:33:38 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k17so47640142ybm.11;
        Thu, 06 Apr 2023 15:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680820417; x=1683412417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGcJPZ80pNpeUNTdnfoI/M49khouK/uMZrIoh3EwTiA=;
        b=cQ8XPduU6QaAZ2PlRtwZGLF1wFwk2u9b9BmTRVzAAS2hqQejAmOKoXM03nxFTl9ATZ
         nToeHuDH9/FCW1OP0X15HFLaRM68IQOzgx/y+wOc4dvfo0iMVnDMLfxt7OQSxDTTPjmI
         iYGHUhYmtlCV9MPQKgckz7alkg0O4WCjX0WHtvMGQckO5IIG6pdpCTqaRFBWk4YnsbV6
         LrFxsOVCfZRUSNp54lqRZHnKsXR3bmAtOeITPaRE5K/ubqaC7qeLstappEzaCY8bLeRE
         ZpNGPN5YV8NMLXb+u4v037jT4Mp5hzjjdl27xyS5u9pjyKS1cBY5fJqrexeBE26llscX
         LrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680820417; x=1683412417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGcJPZ80pNpeUNTdnfoI/M49khouK/uMZrIoh3EwTiA=;
        b=ajxQZ1bHg3/a/esSZE91YmZmq/0fqxv7jtarYS/bxGTxO4pyR1W9Rs3baZBls8e3ms
         pi/ozxkk8Ct4Hl8Mh6qVMPuPAS56A3Ct4iQBrVovxve1plAmMj5YKpQs8eTeEdYTiVgC
         IaranbFc1JvyLzBIE9jH06RYbWUyOsL8QB3w6bemsDob+0YLiQsypAfobzRtw8mWsgLd
         WaMobPtovZT92zHJTRAnDOWqFXgBE6ZuAzLPNZ1HQDQ36es9fOHItEiTnhLUJN0k+nSU
         5vTcqMYHL/7VnlzuJypwNEHYTe2nSd2qDeKvqJug+wvkLSnm7iUAcEDFYKaEFxkVd6SA
         LBxg==
X-Gm-Message-State: AAQBX9cuP+wuOynqyF5V2fDVJXHllZz4wt0aZtBFBcuJ9HirRCpxPZ2J
        VzOizCIpE3kG/rxRaYWNzQO2dKbvFFxZyZniccfKIPbr5Zc=
X-Google-Smtp-Source: AKy350bRTL4otvy2wnO4ARK730c1in1Xfj2jbsg1H4utlgDsdVzvwhbJnFxmcZBj1jEcieGpcANfNyapF39UPADzzKk=
X-Received: by 2002:a25:d4d1:0:b0:b80:2bf9:2f78 with SMTP id
 m200-20020a25d4d1000000b00b802bf92f78mr635138ybf.11.1680820417471; Thu, 06
 Apr 2023 15:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230307120736.75492-1-nmi@metaspace.dk> <CANiq72mvL3f-MZiZiZp-uZDQGCnYJ9yFh_QTWrTMUkUdiXdm=Q@mail.gmail.com>
 <20230307163204.44278987.gary@garyguo.net> <CANiq72k=HU8r-Qr3YH9Bn_9RvoPykBGs0iF57Sdc4Y4uqiyy6Q@mail.gmail.com>
In-Reply-To: <CANiq72k=HU8r-Qr3YH9Bn_9RvoPykBGs0iF57Sdc4Y4uqiyy6Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 7 Apr 2023 00:33:26 +0200
Message-ID: <CANiq72m=wBvQOYo6-Uwbc7icou7bBCZNJgpK0DiaCwMKmY4OaQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust-analyzer: Skip crate module directories
To:     Gary Guo <gary@garyguo.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 6:14=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I don't have a strong opinion either way -- this was originally done
> to improve fuzzy searching, see commit 829c2df153d7 ("rust: move `net`
> and `sync` modules to uniquely-named files") upstream:
>
>     This is so that each file in the module has a unique name instead of =
the
>     generic `mod.rs` name. It makes it easier to open files when using fu=
zzy
>     finders like `fzf` once names are unique.

Apparently the "encouraged" way is using `name.rs`:

    https://doc.rust-lang.org/stable/reference/items/modules.html#module-so=
urce-filenames
    https://doc.rust-lang.org/edition-guide/rust-2018/path-changes.html#no-=
more-modrs

Another argument I saw for `name.rs` is that one can easily the name
of the file in editor's tabs/titles, and some of the editors can add
part of the path to disambiguate, which may take more space in the UI.

Cheers,
Miguel
