Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9B6B136C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCHU5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCHU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:57:19 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEECBCCEAB;
        Wed,  8 Mar 2023 12:57:17 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5384ff97993so328086797b3.2;
        Wed, 08 Mar 2023 12:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678309037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTT8n29DWNd3urgPa1kCRTbJVOAEGECiIIU8nl+Nkjg=;
        b=LfDjf6FYZTWA5GSZkgEi8KpG8mClAxawA58QJzzzQpRHpAylJ8Ui8zyXXL3vFD9LGB
         I97hm3W/sKpiwn9wm36pwbGuTvp7gRkAAtV9dhE7w3gImFb2C3uSBfhP0T6lq8/4xTHL
         FP9D3ATdgkVTTjOhLvtBgvICoSgTaaSLo/RnkFvajnSDZOmOZsiWo8u3U6kRHD3AJtni
         v87R7WGAKJ1Kvv6ZmgMM8JQpsbIj1QEZx5P1l546HIC8DV010jWiy5PDZERJdRD2M69L
         92H6LrPUqLzwL+oFb4LLSNI0bFXOLcepOkoIPG3TQBJB8ITp/V3DvyJwgeF2jpnj+Aoi
         Hgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTT8n29DWNd3urgPa1kCRTbJVOAEGECiIIU8nl+Nkjg=;
        b=iW95AegMM8MMpo7fskTVVFtALEfxlE7Z/lRKgi6Od/E2QhtY2r09HM5yuHe17nnWBq
         qRkZHtlsgC5edR81HevfSVSjQ0pAzv2xASkNT8MhF3z787d1w7RPx0GhcU1xGRE+pPBP
         Cz2l4aIysP28VEpl2uFtMxUa/50n1Km1aOuNOWmLgTrjiKbzdqr2PJiJjKmDLPTF1ngg
         GSezpFVyGR5qIJx2rSJ6oO+SO32hQ9JIxGMu4GOWX1nPDf48ldCe736u9vCWYS1uwvJY
         vA2JvyGjxuQVHB8gfXKDjivWFMOFkuY1303zlzYtqMH9N8wLlrzoEYikk2kkdtUjQvG8
         M5YQ==
X-Gm-Message-State: AO0yUKWiTthEy1AZH4qdz0Jv7tyztLiNq62GDjbRRAzmAZ56XeHw+5Gs
        kw0IgwTMsBcPbr19sCAk733tGAwuijkPzFsvV7Mb5wDfFTyeGg==
X-Google-Smtp-Source: AK7set+gyItpNI/8KIIH66pLospwhy4B/I9V63tct8DgMY8dLQRXpobXiGACii8Apv2vV5+Zq300kWyV7ixpz86xuEY=
X-Received: by 2002:a81:a9c8:0:b0:533:9c5b:7278 with SMTP id
 g191-20020a81a9c8000000b005339c5b7278mr12170063ywh.0.1678309037046; Wed, 08
 Mar 2023 12:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
 <20230224-rust-macros-v1-2-b39fae46e102@asahilina.net> <20230225003156.4858d79e.gary@garyguo.net>
In-Reply-To: <20230225003156.4858d79e.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 8 Mar 2023 21:57:06 +0100
Message-ID: <CANiq72kaLzV4qajxXjWeDGXLwobhevWcuWLdf9DsZUrc9nGymQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: macros: concat_idents: Allow :: paths in the
 first argument
To:     Gary Guo <gary@garyguo.net>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
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

On Sat, Feb 25, 2023 at 1:32=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> It seems weird to me that this is called `concat_idents` despite
> working for more things than just idents.
>
> How about just implement a simple version of the `paste` macro instead?

We discussed this in our latest meeting: what about a change of name
to `concat_paths`? That addresses the concern plus it avoids sharing
the name with the unstable `concat_idents` which could be even more
confusing after this patch.

Cheers,
Miguel
