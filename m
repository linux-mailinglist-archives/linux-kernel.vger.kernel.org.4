Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B767913F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjAXGsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjAXGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:48:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC16B14EBB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:47:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so12851930wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mwb4sSyvoBqZbGMkv+tS6zoNlwvQg1ry8h2xWGwvds=;
        b=TFbt40VRUD+3v7Hj+EazvhzRjlxHf2Go6r0vKfl6GKVkp/orDwP/IW9FzhvalBrqwz
         tobT0sz1n2Qc8YObpOvlFGaUIX89qsQNaB5jvBWdSQCuFHkmUN2qXX6d4iAwKSulA49a
         b/5T43rTis98W9GqGlAM54q8SO+bLHz4Zl2hJ1sQLCCCb950l35AmuslV3R2xnXqVcpw
         z+FFFzYO16oiziGWTUIxtOUnN8yduG6b6SbYVl1M/ybypvkJkpGkTlHkuj2qN9Dafxwy
         2U9WTemA/u098ld7dgQUfzTXLCy1LKDpQUxoHmB357WZqnd8tYzqd0TX7zXHGASS5BTm
         xnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mwb4sSyvoBqZbGMkv+tS6zoNlwvQg1ry8h2xWGwvds=;
        b=YUYHCEDvCvKmyy9uf0M8SFKNvilbuaLSmsPgwzFO75a/MdDV2H5JqKN3uxuK/L4N7Q
         Ip/rFRWgM7PNtoYuU6c4amzFr0XiRl/pbejIWG7YwUDr8ZzNO6vprrjfysWCBy4PV9K2
         QHfBXY4tXXxS84N59iCzXmoDWHleeNF4hDBwHLb97SSenSeJugXcO9Mr6HU/jrimPN1M
         zD7wbzlqO5/QI3JNKLhOe1JxaXoS/A8L2DHHqoKSXg5S/qsps6LdaTjulvF7HSZMcxez
         2C3XZ62c3cQNmiRRdJKLMmJxD0dAgQ8hguT66/M/tQbloK3vzKBKL5LwTl0Cz8vJqHn4
         OrqA==
X-Gm-Message-State: AFqh2kpB606eRufMnZwMx/CWvMqqScxaRfMykhNX+vrkZBeWrOHUh0wN
        bawXWrnoMchTfubmb0ueiy0OhE0B/ESv+tA0IMoVTw==
X-Google-Smtp-Source: AMrXdXsakQD184RjfxuiscCPHBM3lHkJ7i3cOP1i8ElEEa2n47f9HLfSFAXGnCZH8ze4oK4EdtXvntaauBKIGnyietU=
X-Received: by 2002:a05:6000:124f:b0:2bd:df97:13f4 with SMTP id
 j15-20020a056000124f00b002bddf9713f4mr1060721wrx.654.1674542878109; Mon, 23
 Jan 2023 22:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20230119183118.126387-1-irogers@google.com> <20230119183118.126387-2-irogers@google.com>
 <c022261e-bff4-8aea-0d71-f8683b6ad449@iogearbox.net>
In-Reply-To: <c022261e-bff4-8aea-0d71-f8683b6ad449@iogearbox.net>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Jan 2023 22:47:45 -0800
Message-ID: <CAP-5=fVRaPJpW9aPGA3mqvxS5gNjZppJWwNNyuhHFt8Dwbb91w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tools/resolve_btfids: Install subcmd headers
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:37 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/19/23 7:31 PM, Ian Rogers wrote:
> > Previously tools/lib/subcmd was added to the include path, switch to
> > installing the headers and then including from that directory. This
> > avoids dependencies on headers internal to tools/lib/subcmd. Add the
> > missing subcmd directory to the affected #include.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
> >   tools/bpf/resolve_btfids/main.c   |  2 +-
> >   2 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > index 19a3112e271a..76b737b2560d 100644
> > --- a/tools/bpf/resolve_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
> >   BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
> >   LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
> >   SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
> > +SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
> >
> >   LIBBPF_DESTDIR := $(LIBBPF_OUT)
> >   LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
> >
> > +SUBCMD_DESTDIR := $(SUBCMD_OUT)
> > +SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
> > +
> >   BINARY     := $(OUTPUT)/resolve_btfids
> >   BINARY_IN  := $(BINARY)-in.o
> >
> >   all: $(BINARY)
> >
> > +prepare: $(BPFOBJ) $(SUBCMDOBJ)
> > +
> >   $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> >       $(call msg,MKDIR,,$@)
> >       $(Q)mkdir -p $(@)
> >
> >   $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> > -     $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
> > +     $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> > +                 DESTDIR=$(SUBCMD_DESTDIR) prefix= \
> > +                 $(abspath $@) install_headers
> >
> >   $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
> >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> > @@ -60,14 +68,14 @@ CFLAGS += -g \
> >             -I$(srctree)/tools/include \
> >             -I$(srctree)/tools/include/uapi \
> >             -I$(LIBBPF_INCLUDE) \
> > -          -I$(SUBCMD_SRC)
> > +          -I$(SUBCMD_INCLUDE)
> >
> >   LIBS = -lelf -lz
> >
>
> This series needs a rebase against bpf-next, given it results in merge conflict
> e.g. see commit 0e43662e61f2 ("tools/resolve_btfids: Use pkg-config to locate
> libelf") from Dec 15th.
>
> Thanks,
> Daniel

Thanks, rebased onto bpf-next/master in v4:
https://lore.kernel.org/lkml/20230124064324.672022-2-irogers@google.com/

Ian
