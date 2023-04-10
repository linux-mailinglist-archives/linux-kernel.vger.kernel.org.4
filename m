Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8046DC531
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDJJjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDJJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409F270F;
        Mon, 10 Apr 2023 02:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8FDE60C7B;
        Mon, 10 Apr 2023 09:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E814C433D2;
        Mon, 10 Apr 2023 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681119542;
        bh=ZlXt9bvYoZ8BqfUyTU6NlEiE9ot9xPrMtX1cOSFmNU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=plkm9b+3XmYxfjhhNINnDShJXKmEy5q0XlNaerNQ7OKQryWUndgZ9P2Wv6n//aYKJ
         gEG5zBgYoAIJ5qDeLiwnWsyzrcLtTJwRhRYuw6OLKMVAjOgyNePP693ZgBsOfNzFbb
         YuSckk/IVf9JRKjIwkXfVzzw9gVrnEeYbl8Nnghsk0PVFQo6fHRd+xS0Zasbe7Bo8o
         GICDSgEY1nrAwcQkWtPMunPpEWftVvroLSVjrpqEPxm1QhkeGEWUMpkanY99kwLgWy
         0t0KjRfze4tk78yhQ3ZfemMK5N/K9nrru+8mQe5u9Z0hYAPwPWzhjzH0nhSCLJkevh
         H4i7V/cO2SXIA==
Received: by mail-ot1-f53.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso9391429ott.4;
        Mon, 10 Apr 2023 02:39:02 -0700 (PDT)
X-Gm-Message-State: AAQBX9fQ2cKrUq8DGRb6kkxZjGU5P+bS1z4b1AYXRv1UW4vRugycmLBY
        aiiT2xH/dnx6Yw14E9GVNqYovgUr1dPZ6lhs7K8=
X-Google-Smtp-Source: AKy350ZtDJzno5tDS5feiyCGtIfnzhA2E7fPG+oRT4pcDdw4Tifbq57jhYXzlIWBIT2RxL4RBRyyoszn2wEeE5154B4=
X-Received: by 2002:a05:6830:1641:b0:69a:2eb2:e11b with SMTP id
 h1-20020a056830164100b0069a2eb2e11bmr1843195otr.1.1681119541576; Mon, 10 Apr
 2023 02:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230308115243.82592-1-masahiroy@kernel.org> <20230308115243.82592-3-masahiroy@kernel.org>
 <CAKwvOdnmiL_wDgzepYb+ZGgWt2xnsp48-awn0Cd0c4RDR43t_Q@mail.gmail.com> <CAK7LNAQr+y2y5vCKSpA0THyakRUcRcS9X+X9i3mbhTYvnh1wHg@mail.gmail.com>
In-Reply-To: <CAK7LNAQr+y2y5vCKSpA0THyakRUcRcS9X+X9i3mbhTYvnh1wHg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 10 Apr 2023 18:38:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQe9CSp5CuZ50UftMZ7CgfxV96VmrjXOJ29CLXx1d19QA@mail.gmail.com>
Message-ID: <CAK7LNAQe9CSp5CuZ50UftMZ7CgfxV96VmrjXOJ29CLXx1d19QA@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/mksysmap: use sed with in-line comments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 11:29=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sat, Apr 8, 2023 at 4:00=E2=80=AFAM Nick Desaulniers <ndesaulniers@goo=
gle.com> wrote:
> >
> > On Wed, Mar 8, 2023 at 3:53=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> > >
> > > Move comments close to the code.
> >
> > Consider adding to the commit message why you switch from grep to sed;
> > that's currently unclear.
>
>
>
> I just thought "Move comments close to the code"
> explained my motivation.,
>
>
> I want to insert in-line comments.
> Something like the following.
> Apparently, it does not work.
>
>
> $NM -n $1 | grep -v             \
>          # comment1
>         -e ' [aNUw] '           \
>          # comment2
>         -e ' \$'                \
>          # comment3
>         -e ' \.L'               \
>          # comment4
>         -e ' __crc_'            \
>          # comment5
>         -e ' __kstrtab_'        \
>          # comment6
>         -e ' __kstrtabns_'      \
>          # comment7
>         -e ' L0$'               \
> > $2
>
>
>

Anyway, I will rephase the commit description.

"""
It is not feasible to insert comments in a multi-line shell command.
Use sed, and move comments close to the code.
"""



--
Best Regards
Masahiro Yamada
