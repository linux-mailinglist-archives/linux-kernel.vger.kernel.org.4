Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1B729765
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFIKt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjFIKtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:49:22 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001883
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:49:21 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565bdae581eso14713237b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686307761; x=1688899761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iyyfN7NMVqAuuk8Vu6VKNwFZiN+E9panen4tuUpG9s=;
        b=FHZV3UeY1wVUZ0XK4Ts3+CovZUlqEdTOMSXclh/40PpQNMAt62LOBu+5w6fI17HPRj
         kDyVUHHCL3Yb0GP5DAeFDba/9uQAc5WPzGqw7ve4xpMPIvLNfnLGYn7YF56aobHxYHvE
         UziPmw53wITpgB1pMIBdxRAmfZfp+fDiF0dlN1TDfR95duGYNGZy0ggqJRbzBn+pV1+y
         zDEpYMuNT0Eo9fkUyx/bolUk6esdFN2LYintrZQAoRf1a22abVVUrOvota8JIHqavJyP
         Sp4STK8pJcchSzvo6s6ON6o3tyNiy96BGLNuGjpj18Ev/wYgfX5drnMyVkcIgjt5na0O
         OjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686307761; x=1688899761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iyyfN7NMVqAuuk8Vu6VKNwFZiN+E9panen4tuUpG9s=;
        b=ZtBAZvd4KiGfSC62909AZ7ocVhIMhQPss6w5GJuxDRVBhuw5NeBSqweGGl81cpuHAp
         t0Nt4Zlvxv9MzVt9gMDp/GNccT9XOx+zBFcyTH7hcQRMXfvjJI1lOZMunpMAu3OiEHn7
         2dW3qUnpwdaBnJwFMZ9IpUGCXVzbU3U6HzlvsIwkclFqQGiT3fIZ3xKWsmUicLknkHFO
         4fkpfkskusQRwcShWt38XoMJ1qA8dJqaTBUS/vO0A2ktXmR3caJnReh67K0uSL90WF8s
         2YXCcTUQhFJ9JzDUzB/k5UXQfGML+hZ9f+kiAG7S4XossSZpusjy/bd4FhmoOb7BK2wT
         OPaA==
X-Gm-Message-State: AC+VfDzoZl4q5IX65PCDRl6GFUmRK9uxuWaHiqlQkBVreLT0K/WHRHMp
        8UAyz+29l+wNJBgb+UyYzMmKhwXRXCnErq3/nj8=
X-Google-Smtp-Source: ACHHUZ45SC5y00G5zvRnad4iA0V4vIvPUFJDER89GH+qj4ehSEsIevGh/1fdO1snWUdvmP+W/3bh3gEU6PgLeC+4ocw=
X-Received: by 2002:a81:4e4f:0:b0:55d:a4fb:864a with SMTP id
 c76-20020a814e4f000000b0055da4fb864amr893554ywb.14.1686307761170; Fri, 09 Jun
 2023 03:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
 <CACT4oucYVtGPj+cJrkAKXiwW74VNqb1R3u9jYQ9XnU6-LVde7g@mail.gmail.com>
In-Reply-To: <CACT4oucYVtGPj+cJrkAKXiwW74VNqb1R3u9jYQ9XnU6-LVde7g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 9 Jun 2023 12:49:09 +0200
Message-ID: <CANiq72mt=jWMoKPioaii_35ojzs0QTbmBQuBde_iUO1cNtPHrQ@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org,
        mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:49=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihuguet@red=
hat.com> wrote:
>
> This is a valid option, indeed, but In my opinion we are overlooking this=
.
>
> Adding an .editorconfig will not silently reconfigure the editors of
> everyone because for most editors you need to install a plugin to use
> it. In my opinion, that's enough "opt-in". Here is the list of editors
> that have built-in support, and those that need a plugin install. I
> don't think that those with built-in support are widely used for
> kernel development, and many of them allow to disable the feature.

It is true that some of the big ones (Emacs, Vim, VS Code...) do not,
but e.g. NeoVim and Kate (`KTextEditor`) both seem to support it, and
those are used by some kernel developers. In particular, NeoVim says
it enables it by default, if I am reading correctly.

But perhaps those two behave as we want.

> I see this as the exact same case as adding a .clang-format file, as
> we already have. Some editors, either built-in or via plugin,
> automatically reformat code when this file is present. And it's far
> more "intrusive" than editorconfig.

I do not recall any complaints about code getting reformatted
automatically -- which editors are you referring to? (i.e. that
natively reformat the code, in its default configuration).

In any case, it was a slightly more constrained case: `clang-format`
(and LLVM/Clang) needed to be installed with a new enough version,
which may not have been too common back then, and it ""only"" applied
to C code.

Cheers,
Miguel
