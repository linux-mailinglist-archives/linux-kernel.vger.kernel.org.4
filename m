Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEEF709DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjESRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjESRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:18:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B047D13D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:18:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75776686671so183942185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684516732; x=1687108732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn3pb3ky6n4pf56znsEup8Qsq33kfGGXMaRQqXwj8cQ=;
        b=VHiqiiu5vIGZNTPeNu0FhkJvwL+2BjFAoNow/g3ICbSBEwihkmZjAb3qKLzE19Rvim
         QjNLO+8LOXTmbFl/HZuTAe2Op6Xpsg9hnk1pJkDnZpkmy+Z8sPDIH3QOt6Iz1Ibr61OQ
         FVpqIcl+LsdOccTS04B8LtvChbvAoqna+VTteCz5t71xR6kFv4amEAK28zCz6PnceO8o
         0U9S3XPyZTLiZv5n/uFm/BoP+J0Su9IJ+036XYPyqzMzxs9fumCUh8pKqeUCMS2fzERb
         gLu6CsSXV7NsbNNCEi1tyHq+Fci6HiXqwBugxo6yJVQjcT1KLtYOq86MbCfFETX2+ekl
         19Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516732; x=1687108732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn3pb3ky6n4pf56znsEup8Qsq33kfGGXMaRQqXwj8cQ=;
        b=gC7CPZsU+w6Nr5wNZ3+OHv4YdToAnvQDqw96ugdOOnlsz16uOQVh/J6Bo9JGIu0aLV
         KkCud0Jd7ABz5yIRkO8yCznsewMaNzdFD974cPEMMmdlRtuqgYEdwHnga8ZmgvsSXcmP
         fWoxpNMUGANakEBhV0dnswHcuvkxPyDb8o8tJjGoH6NS+eOJlVguUxbVrF6Vj9QYmd6M
         YgMwWV93D91ONT2SMNoYLXERFC10t5BUpN9gEP8x3SY85YjWDHDfj9nmz8E+s0bpwycG
         jnCXKIm0ZWGiSGUaIYLEWefkwo7N4TNFpCg/eWrFbB09kEA0kKA0jIv99uIHQ3rj210b
         LDlw==
X-Gm-Message-State: AC+VfDxujBPp00oDvRi3zhVNWhUa0zrBhu3OtAtzcGNSKj5urBR4JGXK
        4z0aVzVR1YNVI5ib6v0SDuSE5us3SjthwoWTKWyRlg==
X-Google-Smtp-Source: ACHHUZ6xwwhBbIjFEzoyEL/zh1GhlX7PmwlY/xtNyHdQa9LBAsq0Od/kzqiSqmzeNnOgl1Dc5KUtJMBBaqFLb68gcW8=
X-Received: by 2002:a05:6214:e6e:b0:623:9218:58e1 with SMTP id
 jz14-20020a0562140e6e00b00623921858e1mr6374017qvb.31.1684516731558; Fri, 19
 May 2023 10:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230412-no_stackp-v2-1-116f9fe4bbe7@google.com>
 <168440808395.404.16801982965854981978.tip-bot2@tip-bot2> <20230519171120.GA1939377@maniforge>
In-Reply-To: <20230519171120.GA1939377@maniforge>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 May 2023 10:18:40 -0700
Message-ID: <CAKwvOd=ywPnLS40HNUnXH1nqm3Ke3sMtomSgL+rVOoSjXvQB=A@mail.gmail.com>
Subject: Re: [tip: objtool/core] start_kernel: Add __no_stack_protector
 function attribute
To:     void@manifault.com
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:11=E2=80=AFAM David Vernet <void@manifault.com> =
wrote:
>
> On Thu, May 18, 2023 at 11:08:03AM -0000, tip-bot2 for ndesaulniers@googl=
e.com wrote:
> > The following commit has been merged into the objtool/core branch of ti=
p:
> >
> > Commit-ID:     514ca14ed5444b911de59ed3381dfd195d99fe4b
> > Gitweb:        https://git.kernel.org/tip/514ca14ed5444b911de59ed3381df=
d195d99fe4b
> > Author:        ndesaulniers@google.com <ndesaulniers@google.com>
> > AuthorDate:    Mon, 17 Apr 2023 15:00:05 -07:00
> > Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
>
> Hi Nick, Josh, Peter,
>
> Do you have an ETA for when this will make its way to Linus' tree?
> clang-17 built kernels have failed to boot since [0], so it would be
> nice to get this in sooner rather than later if possible.

David,
Can you confirm that your version of clang-17 is updated? clang-17 is
unreleased; ToT will become clang-17.

https://reviews.llvm.org/rGfc4494dffa5422b2be5442c235554e76bed79c8a
should have fixed any boot failures related to stack protectors.  That
is to say that Josh's series is irrelevant to anyone using either an
existing release of clang, or something closer to ToT than April 13.

LLVM commit fc4494dffa54 ("[StackProtector] don't check stack
protector before calling nounwind functions")
landed April 13, so please check that your build of clang-17 is after that =
date.

Either way, thanks for testing with clang, and the report. You can
always file a bug at our issue tracker:
https://github.com/ClangBuiltLinux/linux/issues or see our page for
more ways to get in touch:
https://clangbuiltlinux.github.io/
We're very active on our mailing list, and on IRC.

>
> [0]: https://lore.kernel.org/all/7194ed8a989a85b98d92e62df660f4a90435a723=
.1681342859.git.jpoimboe@kernel.org/
>
> Thanks,
> David



--=20
Thanks,
~Nick Desaulniers
