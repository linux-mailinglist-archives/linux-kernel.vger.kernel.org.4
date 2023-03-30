Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB86CFA02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjC3ENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC3ENo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:13:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547BD5277;
        Wed, 29 Mar 2023 21:13:43 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p204so21979732ybc.12;
        Wed, 29 Mar 2023 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680149622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJJx5iancqfU2xP6aCcU6aFC/gwsLXj0cw8Dg1r4APw=;
        b=qD2R+eHRuovgMaImQFjOnZhrTXDoFRtXFpQ4Bs/vlHCbI0U5sYPKI9KCxSHdB12zUb
         ddj+zmouaWz/vCth+2gz8b1HR1p1GJa/omGuk9rNUv4t0P1VIew7udHJjzo9FGCtGhHg
         kGfW/CfHYMPjCeSHtfrfKgUFFtqdyHgWsvFq+B2N5IVHEd2d5RWScb8KGeNLXbH+5abv
         VyAl8VvHWj+PHHadPWqaGzuWnyyQwO0wMdr1FhDkP8TRNC+2MFnXZ6YCTUWL+5Ad+Ada
         mc7tXp+sRbs10uFt7fYrQIYLmVSR27/Jb1ie1e1Szw+QLNvZWkztv2yzmnUkHb5SfZJs
         ln0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680149622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJJx5iancqfU2xP6aCcU6aFC/gwsLXj0cw8Dg1r4APw=;
        b=zD7R4UTNOCTP4HCSggE/xRLS7rgk6ouJpuyYb6+LxB3VmjQQ+8b0V1VDHFW9rosjPa
         tfhyIksuqV8MbTn4Pm3v3gdxkpt7SCbMfe4nLTLbFvuxu+nM3LosOCLgIZ1MuZrt9RPB
         0U17BDPR/xHITCgGaGaysnLCrfg81eKz5YKDDg6qFjig0cQA2TrZw2i3gjxhE2UGiobo
         QUCKtjpB41TYxPQAuF8IrnEe8cQAi0d/ynwaOafLvcd0s9t+sbIvZqFfVhvWfm6UfwzY
         0OP5hNEG7ytRUyI/ue5dF2NjGLB8s3jiKFZWbalRAkmMvPTFlLuyzKsWV1Jcr2ivmLRo
         zVXQ==
X-Gm-Message-State: AAQBX9f/VtOcq0/PjTMnSH0da8vJC6rySOpwPeZJxW9IbtdF7au82gtj
        OgKw1eVqBd1kdPuWFBJ6j/y+dcOgqa05ihynPkw=
X-Google-Smtp-Source: AKy350YVT/flqSFBvFxTZR2FoNaRxvExziTKKNo8YLQm0TU2WQWj4bq5x2eOF38rCggnH11dWohhHNjx5L9VarDX89k=
X-Received: by 2002:a25:2d7:0:b0:997:c919:4484 with SMTP id
 206-20020a2502d7000000b00997c9194484mr11425853ybc.6.1680149622452; Wed, 29
 Mar 2023 21:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230329223239.138757-1-y86-dev@protonmail.com> <20230329223239.138757-3-y86-dev@protonmail.com>
In-Reply-To: <20230329223239.138757-3-y86-dev@protonmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 30 Mar 2023 01:13:31 -0300
Message-ID: <CANeycqprth29MGQsAYHkQKAoCBr_C0J010VTvs1YK-Yg+pY+0Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] rust: sync: add `assume_init` to `UniqueArc`
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Wed, 29 Mar 2023 at 19:33, <y86-dev@protonmail.com> wrote:
>
> From: Benno Lossin <y86-dev@protonmail.com>
>
> Adds the `assume_init` function to `UniqueArc<MaybeUninit<T>>` that
> unsafely assumes the value to be initialized and yields a value of type
> `UniqueArc<T>`. This function is used when manually initializing the
> pointee of an `UniqueArc`.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Wedson Almeida Filho <walmeida@microsoft.com>
