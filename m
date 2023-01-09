Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095B2662F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjAISkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjAISjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:39:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5713B924
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:37:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s9so9145275wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv9Qlp//d2HQ8m+fdxA11p5JwKQ7sVVltk9S+MocsQk=;
        b=ik1z28ROscuLAtWReqcAjUFVbb42S1cYpK/n/PyKhtuypCrma7yZJtFIw2hMvn6NQX
         WAS9ydDC5f9JEzO9jxU1ictaTF5sFxT0EwjoUX7TX47OwQA1/kH1+qE2uoevxWE6RTw5
         HDYUfJP7L+uHDU6H/FEsd8dfXbw+sXsMKKctVntGogLTgy9GOlAn6O4PfyDjQNIkTAXQ
         XO2xpkhpJ2JaEADCZyJNst7nW9Arr4QnnGrUVEr6i+uEU2U5WybbNcAuC9vGIBDYY37m
         25auEHD034UJdMX/Oq3tuo9Pk2LZRirw0qr/XPnKLkntzeiFWZzUsVGBCgDCRYKB1SGJ
         wxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wv9Qlp//d2HQ8m+fdxA11p5JwKQ7sVVltk9S+MocsQk=;
        b=fBAlPm4Lr1XKR9b3UwuZ1xwO8iA0LNWkxTbVLWyI10en/xsmNwJ1gKPP5FvSqMxmG3
         2PqUkkkfHnVlbEOWldHVbeKIYmks3O+vMUOzYtfaCs2i74GZX8gYQrfVBS4LJLPO007v
         9LGiOhvyE7T/xchukSB650IvXyPs3cHL3DJjk8Z6wnTnwsyvWifqvhGcEQFIK/O8zZRE
         5sUWtwUZLTuG3FLH/hfg7ZUBwk8H9O8WLD0Fh4Vftn+HxoN3cw0Fru6UA/ptJQ+isWWl
         Jl0/bePpXxJEMzaS4KffQCmQkxbKZIBhXUlgLPk0YNJVn2gqdIBOF2swybQuJ7ZOJYyx
         YGNA==
X-Gm-Message-State: AFqh2koa+BN/LJooqpYMGwTt4bG7g1iAWjHnKeTrj1b3+TZiPTt69GfH
        eUxIuqOlYKT9PUjbe1bc7dyg8HFuYn0EF6Tp4a2jUw==
X-Google-Smtp-Source: AMrXdXuKEofUGTCnvnhcJ2xd222r5b7LIhPALeQmr34cxE7+eoBRNoZiOfY0OTO79aG8wkaMJU7Aepv2ZoCEms+FHY8=
X-Received: by 2002:a5d:45d0:0:b0:29c:52c7:3dce with SMTP id
 b16-20020a5d45d0000000b0029c52c73dcemr779159wrs.375.1673289447507; Mon, 09
 Jan 2023 10:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20230106151320.619514-1-irogers@google.com> <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org> <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org> <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org> <Y7xYimp0h4YT72/N@krava>
In-Reply-To: <Y7xYimp0h4YT72/N@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Jan 2023 10:37:15 -0800
Message-ID: <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
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

On Mon, Jan 9, 2023 at 10:10 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jan 09, 2023 at 12:12:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jan 06, 2023 at 11:06:46AM -0800, Ian Rogers escreveu:
> > > So trying to get build-test working on my Debian derived distro is a
> > > PITA with broken feature detection for options I don't normally use.
> >
> > Its really difficult to have perf building with so many dependent
> > libraries, mowing out some should be in order.
> >
> > > I'll try to fix this.
> >
> > Thanks.
> >
> > > In any case I think I've spotted what is really happening here and it
> > > isn't a failure but a feature :-D The build is specifying
> >
> > I get it.
> >
> > > LIBBPF_DYNAMIC=1 which means you get the libbpf headers from
> > > /usr/include. I think the build is trying to do this on a system with
> > > an old libbpf and hence getting the failures above. Previously, even
> > > though we wanted the dynamic headers we still had a -I, this time for
> > > the install_headers version. Now you really are using the system
> > > version and it is broken. This means a few things:
> > > - the libbpf feature test should fail if code like above is going to fail,
> >
> > Agreed.
> >
> > > - we may want to contemplate supporting older libbpfs (I'd rather not),
> >
> > I'd rather require everybody to be up to the latest trends, but I really
> > don't think that is a reasonable expectation.
> >
> > > - does build-test have a way to skip known issues like this?
> >
> > Unsure, Jiri?
>
> I don't think so it just triggers the build, it's up to the features check
> to disable the feature if the library is not compatible with perf code
>
> could we add that specific libbpf call to the libbpf feature check?

Looking at the failure closer, the failing code is code inside a
feature check trying to workaround the feature not being present. We
need to do something like:

```
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 6e9b06cf06ee..a1c3cc230273 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -33,17 +33,18 @@
#include <internal/xyarray.h>

#ifndef HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
-int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
-                          struct bpf_insn *new_insns __maybe_unused,
size_t new_insn_cnt __maybe_un
used)
+static int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
+                                 struct bpf_insn *new_insns __maybe_unused,
+                                 size_t new_insn_cnt __maybe_unused)
{
       pr_err("%s: not support, update libbpf\n", __func__);
       return -ENOTSUP;
}

-int libbpf_register_prog_handler(const char *sec __maybe_unused,
-                                 enum bpf_prog_type prog_type __maybe_unused,
-                                 enum bpf_attach_type exp_attach_type
__maybe_unused,
-                                 const struct
libbpf_prog_handler_opts *opts __maybe_unused)
+static int libbpf_register_prog_handler(const char *sec __maybe_unused,
+                                       enum bpf_prog_type prog_type
__maybe_unused,
+                                       enum bpf_attach_type
exp_attach_type __maybe_unused,
+                                       const void *opts __maybe_unused)
{
       pr_err("%s: not support, update libbpf\n", __func__);
       return -ENOTSUP;
```

There are some other fixes necessary too. I'll try to write the fuller
patch but I have no means for testing except for undefining
HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS.

Thanks,
Ian

> jirka
>
> >
> > But yeah, previous experiences with Andrii were that we can do not too
> > costly feature checks, not using .c programs that would fail if some
> > required feature wasn't present but instead would just do some grep on a
> > header and if some "smell" wasn't scent, just fail the cap query.
> >
> > - Arnaldo
