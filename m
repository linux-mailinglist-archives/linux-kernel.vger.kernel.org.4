Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4376AE8EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCGRTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCGRSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:18:54 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A32397FDE;
        Tue,  7 Mar 2023 09:14:30 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i6so12105620ybu.8;
        Tue, 07 Mar 2023 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678209269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTrTZWjbM4a6litehFcieAJGkg4vP1lCAY7R+xoy8GI=;
        b=R3wq+PqiYUg7FMDVlTRSpElaxjx1KItGfhOaSUSYpdrFuV90h3kUCur/ZQseJMkTAC
         6au1Oxe0YRigF6GgFu3MSVSKK6n/PxVbp3ta7eBEg6Xr51MSyboCEEBfgqvzJtxZHe/a
         RJ4f8hIhSvAPCWup0TRaq4h5J8SMpSmZSyaakvlZa9yPKZ9YuaEEZu7XyEHVVqdkDJZB
         q6Wf67JLxTI4IUPaC6dsVRpVobOBp2XpCdzn7VSAffNh5A9+3+BlccW989bCt9tsEXJB
         vh3sDJw2pURoBwWj3AENuWrHklcfIjqWtVcdA1WmH+KxjSRBNWP62p6mOSG6lRVG4gO7
         w3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTrTZWjbM4a6litehFcieAJGkg4vP1lCAY7R+xoy8GI=;
        b=WmEVnIqxAWtGSEZgBpaKbP/Sfa0/VBt77z/q/OpJKrJ6SCXghrYV6A8uzcpJ7VrWsl
         fL3wacR8vSOQjG8JAjbnnaNmxfpsVBOBnTgnbLWopeJr0++/ZifCYShZU1jgKvMIfz+E
         mBRUKv3c7gHb80y0fl69yp529jmc6Yska49ssjy9VSK75CNDSV/Vjt23+Wmzm97ip8wl
         qKX1SXFPZDlFb02jMNRQG4nSqjlTDt5aBYp6qCC34uwYWTvQ6Kpgwwq4WWPzDe09rRDq
         wJ4Pl2vj+Cl/XzQHDywY4F15xZswh7+5y0PepkSWyFUBdQBAiOFAnRLxJssuwHF0YROp
         WFEA==
X-Gm-Message-State: AO0yUKURzBClHglAU1RrNoOPaOS/B6CqM9PqguiyXu41xmqbcL61eGZP
        AJhGQagNtLSddtytsM3qQ1ByV2I7wbQg55pK1SufHNxU3mY=
X-Google-Smtp-Source: AK7set98cGCEtS7wDsG/LKdakRlaKHa+jcpsORwmNuPrzJivRYwPHMHEMb1yC323aCkOqryrOBiuGk9mCRtmu/6qpqo=
X-Received: by 2002:a05:6902:4d1:b0:8dd:4f2c:ede4 with SMTP id
 v17-20020a05690204d100b008dd4f2cede4mr9177957ybs.2.1678209269085; Tue, 07 Mar
 2023 09:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20230307120736.75492-1-nmi@metaspace.dk> <CANiq72mvL3f-MZiZiZp-uZDQGCnYJ9yFh_QTWrTMUkUdiXdm=Q@mail.gmail.com>
 <20230307163204.44278987.gary@garyguo.net>
In-Reply-To: <20230307163204.44278987.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 18:14:18 +0100
Message-ID: <CANiq72k=HU8r-Qr3YH9Bn_9RvoPykBGs0iF57Sdc4Y4uqiyy6Q@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I personally think mod.rs makes it easier for me to find files because
> all related stuff are contained inside a single directory, especially
> the parent modules and submodules are closed related.
>
> That's just personal opinion though.

I don't have a strong opinion either way -- this was originally done
to improve fuzzy searching, see commit 829c2df153d7 ("rust: move `net`
and `sync` modules to uniquely-named files") upstream:

    This is so that each file in the module has a unique name instead of th=
e
    generic `mod.rs` name. It makes it easier to open files when using fuzz=
y
    finders like `fzf` once names are unique.

Cheers,
Miguel
