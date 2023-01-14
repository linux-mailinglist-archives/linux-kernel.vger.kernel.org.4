Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2166AB4E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjANMMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 07:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjANMMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:12:33 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6E658F;
        Sat, 14 Jan 2023 04:12:32 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4d4303c9de6so169104287b3.2;
        Sat, 14 Jan 2023 04:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocG+aQYX3J6pPZiaecLuAdSLxqQP2C97Q6clgYMlPSQ=;
        b=NnTUf4zMPGcuJ6iWKPXSOQftiob0xB7Hg/1iZUp5RaIZwPisRkMZ6aSHAyd6P+G6xf
         0bj0mYQz7wfvxYCF9HSGHnF2Nwde7H5fkl3u1aEznXqeS/D22qj95sAETiNhl3PVZW4n
         FuLhGW4vqCUSBXe824IQ1DVGVf0kJIiMKLtQcK0dvW5uoVfY02T7pZ+wia4FKYqSm821
         l6FLI1h9zFMCtK37fOWufwrXnEIL8HxipROm+S+n6akXZ1hJevJAuyq6JZPs7RA6ryfi
         UktJFQaaI5z+IuSw31GbU1wqvS+4x9gVGjcTZk0I36dxhAq0QailGg+nDEh00yjzWl+9
         OEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocG+aQYX3J6pPZiaecLuAdSLxqQP2C97Q6clgYMlPSQ=;
        b=CYTJxEyZ1wGLGKVR7mXRh7gBXqoZcko/O6SnihERIMQX+XJMRTAzAZPwcdu4VUCZ1w
         HA0sOY6lliur8+zmWrr+12DsZQC4nVjlVHB1bN5Sz9mrXEW+ix4zeJsgcu2SAee3W/lv
         2g5yNIFMJNyH/bvqc7kSR5P2tkDrWybtxjUV0+y6WWqUbH+z7Y9kssWFDZK3AuTxoYYm
         Zg+UpyBZwgdsMxNjl5D/Bm11HVRGrkAAyayg8oyf5psORsLgs/Zjmzo1MyFxuDS/pjIz
         wrsAy/oXORC4bm68alcGAq8mRo3Cg0ak3ATwJzhjD0ouE7PAZTz6tGZz0L4lWyFj35dC
         9gJg==
X-Gm-Message-State: AFqh2kqyYIfFXCu1hrW40x7KqdTPbFSuOLkv2l4YwT1mivkm/AdGkdSD
        vwKC8tF/cGoQxLlP+nt/po/XU4MBTutqvvOyKRA=
X-Google-Smtp-Source: AMrXdXuMmb7KLM5QgZsTcsQwoQKe4cn16T9y85eLJUWL3VYmrFA94ufuFZpeh1+313LveyMesX8TLRkUmKEG37iM/w0=
X-Received: by 2002:a81:b60b:0:b0:45c:d900:f30c with SMTP id
 u11-20020a81b60b000000b0045cd900f30cmr3752622ywh.256.1673698351831; Sat, 14
 Jan 2023 04:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-3-ojeda@kernel.org>
In-Reply-To: <20230109204520.539080-3-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 13:12:20 +0100
Message-ID: <CANiq72nZ0YUYOUO4NAKDzQKisxguovb=f2f4uNcL3TqwEWRQeg@mail.gmail.com>
Subject: Re: [PATCH 3/6] kbuild: rust_is_available: add check for `bindgen` invocation
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alexandru Radovici <msg4alex@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
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

On Mon, Jan 9, 2023 at 9:45 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Reported-by: fvalenduc (@fvalenduc)

Cc'ing Fran=C3=A7ois who gave emailed me his name and address, thus a
better tag can be written here for v2.

Cheers,
Miguel
