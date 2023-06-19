Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80E973559A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFSLUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFSLUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:20:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFECF3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:20:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51452556acdso1206793a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687173632; x=1689765632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHwcK4+G1+pHJr/AemM31vH7TcoiQYXrJjZnbqSfWkU=;
        b=b2x+MiU0PNvIKQ+guvqmHOmI9F6CAu+aBiwIh+pcKMDRkv5FSecZnrBIhRQxGQVxgr
         8jqozfaP6xvU6hamhUGx4GUfkighFMxNE29OAp+uEkAGPE51+JZ2kiA9LRbssoyd2dmH
         WvWSYb24P+BcJZWxR8dSv7bAiOgWqJ3Xp0yvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687173632; x=1689765632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHwcK4+G1+pHJr/AemM31vH7TcoiQYXrJjZnbqSfWkU=;
        b=Dpelm90HcWp+XznpFfn/H05n8O2qAWYxxgMzYSx38qhVsu0i8dXL4DIt5ylE8WUDoU
         Vefj73cCQTkebepsif2VAAtEonG/wKnCB62xg+UxtV1I6Y+p2j3a1bTq5TyDpeOMJA/2
         WMGIMar2cuAWNUoWFL949e7TUWv4zzCskXtqVwuk9CZDxmSR2ak0Qj92ttJW6fcrDfhp
         puzcnsrxRd8amToERGnSQLNGYqUUUc6HncP3zcu6va1lg4fJRNYJPyzba4piBh1atCvS
         N7w1c1+lDZey1QqZ+MQJ4MQ/99i3Z/ZlmpFYeBMuYOf471gj12X50684FFNam1FsUsgf
         sz9g==
X-Gm-Message-State: AC+VfDw+cv6K3rab++VHK1TJD6VwTVE4NhaASUcx+6UyFA2QjEtN8FNw
        2t80KTV+VJxgNn0mwhQbikNplXNClSJcit23dnvc+A==
X-Google-Smtp-Source: ACHHUZ4RzEz4p8yr6qGhmElkBhQ6Fs4KdBjLaQWqTw2kN8Qcn172fmQXOI9Utd/vo5KAF+1+6ZMSSY7q/0kiO1LHPJA=
X-Received: by 2002:a17:903:234b:b0:1b5:42fe:5eac with SMTP id
 c11-20020a170903234b00b001b542fe5eacmr2783982plh.10.1687173632019; Mon, 19
 Jun 2023 04:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org> <CABRcYm+C+tPwXAGnaDRR_U2hzyt+09fjkKBp3tPx6iKT4wBE2Q@mail.gmail.com>
 <fbd79f5f2b250ec913c78d91b94ca96fb96f67ee.camel@gmail.com>
In-Reply-To: <fbd79f5f2b250ec913c78d91b94ca96fb96f67ee.camel@gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 19 Jun 2023 13:20:20 +0200
Message-ID: <CABRcYmLaummOg=Nf0qXVN2eci=25OqXLD0zpCUz4CgmTjvo9LA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 7:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-06-15 at 17:44 +0200, Florent Revest wrote:
> > An easy reproducer is:
> >
> > $ touch pwet.c
> >
> > $ clang -g -fsanitize=3Dkernel-address -c -o pwet.o pwet.c
> > $ llvm-dwarfdump pwet.o | grep module_ctor
> >
> > $ clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o pwet.o =
pwet.c
> > $ llvm-dwarfdump pwet.o | grep module_ctor
> >                 DW_AT_name      ("asan.module_ctor")
>
> Interestingly, I am unable to reproduce it using either
> clang version 14.0.0-1ubuntu1 or clang main (bd66f4b1da30).

Somehow, I didn't think of trying other clang versions! Thanks, that's
a good point Eduard. :)

I also can't reproduce it on a 14x build.

However, I seem to be able to reproduce it on main:

  git clone https://github.com/llvm/llvm-project.git
  mkdir llvm-project/build
  cd llvm-project/build
  git checkout bd66f4b1da30
  cmake -DLLVM_ENABLE_PROJECTS=3Dclang -DCMAKE_BUILD_TYPE=3DRelease -G
"Unix Makefiles" ../llvm
  make -j $(nproc)

  bin/clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o
~/pwet.o ~/pwet.c
  bin/llvm-dwarfdump ~/pwet.o | grep module_ctor
  # Shows module_ctor

I started a bisection, hopefully that will point to something interesting
