Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC27272FC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbjFNLfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbjFNLez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD910D5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686742447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZ8YkYiRNyFpkA43Ht79MvS8YaGj3WYAc1zv2BWvzwE=;
        b=U+0WyhNnAZPnBoi7KmGpqRpi7tUoxRt3srEdNq3SdOQtvDJaQ0KADfmIMpKqauCoE9kx98
        OYD9lWKLCDlIXb1qBHp9JN5ZMi1ojpx9K6lz8K3BxU84ccJfxjaQZJYwpZ5pu1gNhky6KO
        t3tKyPqq7h3Rg8j9Ax1NnHsb2UFBwyQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-mGhMnzAGOEOhXropsUQbfw-1; Wed, 14 Jun 2023 07:34:05 -0400
X-MC-Unique: mGhMnzAGOEOhXropsUQbfw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1e6258204so4026791fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686742444; x=1689334444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ8YkYiRNyFpkA43Ht79MvS8YaGj3WYAc1zv2BWvzwE=;
        b=lAtCDSYhy413ymq6+LwR0/M5K2bgFRoPPocgrjDDwekIVZr3nU6X1hz7ztQNKuka77
         jY3775f8B7D1jot8ghle2nyeVlS8iex7CPfPthzr65uYMYY9gOfOUPj+bZgtwwyqYa5u
         f6EDQ8p/+xT7vyGux4zNZ/AxCy4V6YgGsP7s/UOSpLZ8vq61/3BON9OaB3E7PxFOB+gs
         gIcttbcJHoKWJY48xQhbOmCq+up0KJWNKdLKohx6b/zHnp/LQsVagmVDCNeaiTEucM1O
         f5YsDge9+5S9s1az7NM/y5rMlCsnXd6f9YsZdTL1Znw31EnVg/oEU96kzbhUXJtE0rLM
         WZBA==
X-Gm-Message-State: AC+VfDxCQfpYO4NnWcKph1XgreUmiZGa7mHEnx6L8XOPK9Lf9Ts0I+9N
        1DoTB9X/5VNqvcURq7FqXD96ZMxtHYszEb4NejZXylegR0iW36nmpxDrGM1iZGJTkCVZk38IK1V
        29vI8iXGy7Y41a9vv34xmsjctQJcucXK0wAkwAwZH
X-Received: by 2002:a2e:87d9:0:b0:2b2:5d2:ce5f with SMTP id v25-20020a2e87d9000000b002b205d2ce5fmr6107203ljj.50.1686742444145;
        Wed, 14 Jun 2023 04:34:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4K2qLcJVksFHiJ+KOoMYFwPfWXhmRb6QI4f8j7AGsZOlW7futF9ZEz6TkwupwULmf4R0/HWFqRYZ4mwIFNVH8=
X-Received: by 2002:a2e:87d9:0:b0:2b2:5d2:ce5f with SMTP id
 v25-20020a2e87d9000000b002b205d2ce5fmr6107197ljj.50.1686742443863; Wed, 14
 Jun 2023 04:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
 <CACT4oucYVtGPj+cJrkAKXiwW74VNqb1R3u9jYQ9XnU6-LVde7g@mail.gmail.com> <CANiq72mt=jWMoKPioaii_35ojzs0QTbmBQuBde_iUO1cNtPHrQ@mail.gmail.com>
In-Reply-To: <CANiq72mt=jWMoKPioaii_35ojzs0QTbmBQuBde_iUO1cNtPHrQ@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Wed, 14 Jun 2023 13:33:52 +0200
Message-ID: <CACT4ouf5EuNoS779ZjCw4RzgHz2w3HbZOsCKQ2_DvpXdyMoqsw@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org,
        mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 12:49=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Jun 9, 2023 at 10:49=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihuguet@r=
edhat.com> wrote:
> >
> > This is a valid option, indeed, but In my opinion we are overlooking th=
is.
> >
> > Adding an .editorconfig will not silently reconfigure the editors of
> > everyone because for most editors you need to install a plugin to use
> > it. In my opinion, that's enough "opt-in". Here is the list of editors
> > that have built-in support, and those that need a plugin install. I
> > don't think that those with built-in support are widely used for
> > kernel development, and many of them allow to disable the feature.
>
> It is true that some of the big ones (Emacs, Vim, VS Code...) do not,
> but e.g. NeoVim and Kate (`KTextEditor`) both seem to support it, and
> those are used by some kernel developers. In particular, NeoVim says
> it enables it by default, if I am reading correctly.
>
> But perhaps those two behave as we want.

As I can see, NeoVim allows to disable it, which is good enough for
me, but Kate doesn't.

>
> > I see this as the exact same case as adding a .clang-format file, as
> > we already have. Some editors, either built-in or via plugin,
> > automatically reformat code when this file is present. And it's far
> > more "intrusive" than editorconfig.
>
> I do not recall any complaints about code getting reformatted
> automatically -- which editors are you referring to? (i.e. that
> natively reformat the code, in its default configuration).

Maybe not in default configuration, but people might have it enabled
in their editors anyway, so suddenly appearing a .clangformat in the
repo could cause it. My point is that this is a very similar case.

> In any case, it was a slightly more constrained case: `clang-format`
> (and LLVM/Clang) needed to be installed with a new enough version,
> which may not have been too common back then, and it ""only"" applied
> to C code.
>
> Cheers,
> Miguel
>


--=20
=C3=8D=C3=B1igo Huguet

