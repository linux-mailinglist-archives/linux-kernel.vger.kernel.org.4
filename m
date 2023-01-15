Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE966B43D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjAOVmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjAOVmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:42:31 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91EA18168;
        Sun, 15 Jan 2023 13:42:29 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4c131bede4bso357925637b3.5;
        Sun, 15 Jan 2023 13:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpe4Cs3apB57NmbKcRVMVjPZWhlGE6DeZrb0ougpU28=;
        b=k7HNDvA7yBT2mWSvDi79UVBz+CTOTJxivdKBWOkTKdKCBTdGeV4Qur+c4zpR8AsfNB
         1KLgCdZAFoki8bE/a43ZAGDx2tY3odmvCyQEzR2J5XMsM8f9GuZS3Q5OQq9U7mX9+OV9
         Z+EP3EPEd8EzX/G9S9iuiFGpBNTwGY62+zGhT3pIy2XJoog0Cl1sasnj8Aip0Efl7iar
         HqGK0NzTsz9DgUo1GwG8uGCsIYJtZyu1d7kz1QlFXlR15FoHsjG16pHrUQDDpum4m51t
         DUoX64rMkrnGKS9WUZ+aEwVWrQLGAx8NYREjibiDqgQlUJT9En2AtSowp4yb7RTYjlI6
         1MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpe4Cs3apB57NmbKcRVMVjPZWhlGE6DeZrb0ougpU28=;
        b=sL5C80Pl7J64NmEc+lxyL0UNdlO58sgK46SHY5AaKwbgVmgtaldKmJzL9Ct8GPzC7U
         u3sXD85wrBzC9stsvce3Vg6zmMHtQ/CwRZqoQLT44Ggq8aWCXOZyHzlxdP0l3OwJOttv
         vMfGuzaBnJzxQzQSfb/la3OKoO51cMWV5tVJG84Ce154ae0EFHS+PF16S1CPDqrM41NH
         aoH7IJ9ervtHmorazcZdoaXkYwHqOqNSYSo0In+A2c1DxkwLYlMJusZEkvVB+RYOo7Ir
         FMzS+X5uYsOP0vnoHGHnju95BMK8YpTFzVZStt5lluez2xS6osPFdzEsYTv4zXHFggPk
         +nPQ==
X-Gm-Message-State: AFqh2kq8I9t+QH2/aRSIHln4oKyi9Tscl0AzF5CYiCrS23p9J+WcFrvk
        2fln8TmFFPQarsZCr71HurPEcWRUGkPVPBxg0Rc=
X-Google-Smtp-Source: AMrXdXsk6dgb8lDkgSAQXZMZISxptaZIMBqYuDQ1ggVsAY1+5FIgdyIo9AdxAd74n91Tpn8TG9IG5P46Q45S6KQkCuo=
X-Received: by 2002:a81:b60b:0:b0:45c:d900:f30c with SMTP id
 u11-20020a81b60b000000b0045cd900f30cmr4284866ywh.256.1673818949084; Sun, 15
 Jan 2023 13:42:29 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-4-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-4-davidgow@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 15 Jan 2023 22:42:18 +0100
Message-ID: <CANiq72nXMsnUsJNZOG-QZiCVOqa9dRUSMc4RAS3ExLZNJ7VhHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: arch/um: Add support for CONFIG_RUST under
 x86_64 UML
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org,
        llvm@lists.linux.dev, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 5:45 AM David Gow <davidgow@google.com> wrote:
>
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
> index 6982b63775da..a526ca1c688b 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -17,3 +17,5 @@ Architecture  Level of support  Constraints
>  ============  ================  ==============================================
>  ``x86``       Maintained        ``x86_64`` only.
>  ============  ================  ==============================================
> +``um``        Maintained        ``x86_64`` only.
> +============  ================  ==============================================

Nit: if there is a v2 for another reason, this could be swapped to
keep the list sorted.

Cheers,
Miguel
