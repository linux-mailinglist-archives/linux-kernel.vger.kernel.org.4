Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAED6DA5D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbjDFWdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFWdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:33:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62EC7ED0;
        Thu,  6 Apr 2023 15:33:19 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p203so47625636ybb.13;
        Thu, 06 Apr 2023 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680820399; x=1683412399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz0vJXFN46x67W2xSAeH5Sf7oVGGDDuPE550b2nVspc=;
        b=gLQj17toKK7r5rDcI9pyo99wnJ5lbLV/b7bNxiyrh53bsbudyqu3z4V8AvzhuZWZD3
         wRAlabqZKkSjwMnwv5wmv16Gr98Ew8/IMu7PeI5THaHnOceGGi/Snd6Q6yxWZ3KraR3p
         8NYmn+3t20M9MmuOYrDyqMo/aHeijEAtJgz8Ji+41WjQ8PfRsup/g+prQsyusXR4DtJv
         LjAPJBZmQop+/0yz+NBQnAqeQfz42TDw7MDkjKmz/PIhC0TECqspMl8jejj7asY2jllB
         B+7dwSkULJIE9Dd1EeTcvGAaL5PUznKnIwGUbzBBdIgkGHBTLL5g8do1hRmGmDpfRigu
         wTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680820399; x=1683412399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz0vJXFN46x67W2xSAeH5Sf7oVGGDDuPE550b2nVspc=;
        b=T9ZWQjensMwUJITHU0ukp0TodAYQ5c5OtKgmZROGuWA434vfywhTmpXzptpkNRH/Sz
         xGi5rEHnbTd8AJxO5y5JFhnIvRxn8SggVrI9W1q6LStsGENDIqDEci+doBRbJHq+/c+y
         1hN8nnUTLdtkgYUucAVWN4UmT3OPclXZBzFLrxz9fEU8Ty9e2Y0z0tWjWzlKOWsaZurZ
         eL5NGXYBquQFSyKkcaGyUYs8GWlSF6sR9cqanoiGeIItMhUSeMLOs0cXpgBucHAHzHOM
         LhapGsV8AOVhsOI6AuRa/KqzTg5nNNYuUAYVaprU8ISl+9m2AhRcloRIVtUFo0M4Sias
         igxA==
X-Gm-Message-State: AAQBX9eISdgmtJCLlDFa8aaAb9Pn5iTzAWYUtnK1qNV7E+BbJKRMZfVW
        Fjuoj21reOjXWTvnds1rNTqW2V4vJXkW55EHhZY=
X-Google-Smtp-Source: AKy350Zcp2AlP8/G4hTd2GDzvNo0XMseAzgJgv0DN5gyWs9Z3q/Bqc3IhdBhLNxyWkxnanlb7L+M479uhESJIQai8Vs=
X-Received: by 2002:a25:cc02:0:b0:b8b:f234:981e with SMTP id
 l2-20020a25cc02000000b00b8bf234981emr605454ybf.11.1680820399103; Thu, 06 Apr
 2023 15:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230307120736.75492-1-nmi@metaspace.dk>
In-Reply-To: <20230307120736.75492-1-nmi@metaspace.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 7 Apr 2023 00:33:08 +0200
Message-ID: <CANiq72mahAGxQAr44rU_bEHtyJxDgKgbY1G_+fG7YhL=Lq5xtA@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust-analyzer: Skip crate module directories
To:     Andreas Hindborg <nmi@metaspace.dk>,
        Asahi Lina <lina@asahilina.net>
Cc:     rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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

On Tue, Mar 7, 2023 at 1:08=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk> =
wrote:
>
> When generating rust-analyzer configuration, skip module directories. Thi=
s fixes
> an issue that occur if we have
>
>  - drivers/block/driver.rs
>  - drivers/block/driver_mod/mod.rs
>
> If `driver_mod` is a module of the crate `driver`, the directory `driver_=
mod`
> may not contain `Makefile`, and `generate_rust_analyzer.py` will fail.

I picked Lina's for `rust-fixes` from
https://github.com/Rust-for-Linux/linux/pull/883.

Cheers,
Miguel
