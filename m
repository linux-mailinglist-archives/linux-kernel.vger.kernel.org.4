Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647C36D57EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjDDFTF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 01:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjDDFTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:19:00 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF71BF8;
        Mon,  3 Apr 2023 22:18:59 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id g16so3288367iom.11;
        Mon, 03 Apr 2023 22:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680585538; x=1683177538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+z2DtIXlnX8JchPJicDuk6IiWR6KVUfDtLG8QXJzFo=;
        b=aoUKVeqpk6YbPAVSDNSEnPcoe8h9qnzh+2F8xnXiiMag5e6MSLYh9Rt0r9Pe9OoR4O
         m1tXg3WRC6mrJLTsa9BrN9OC8ntmfcAFXyxcW4I32Gjob7L1xW8+KjcId92dh9LvYIVW
         c+1lkHdO6ENDk66bd6IjBGbToXh5qZD4pNgWZj0UJRgM9B28xp1Y0KSWDRmDMopyR+yg
         Odz6/u6MsJgEfl0Ujmoz1lii/hl1rsrH7nJEsGk8SVhffCxXP6WmFBoWfjnamKJiz4pR
         KmwtuKMafg+IsH/UhXg3N9btTz9Z/FB5D2ctHmRu1qxJ0xshklwpEeEW+KiM4vBs0MAP
         ipyg==
X-Gm-Message-State: AAQBX9dN1zRoMSWJGIWXC1HD5bMTS0CMBXnhlm/qoZVV50VYdIkKkKBV
        +Yl8hXsQj4chNVJsm29HGuFBnMWe2ynVyYgnHbQ=
X-Google-Smtp-Source: AKy350bBvTyWsO4MYoAA2TbNVAjasEfvOmD1ErXgo3dwhUR1n6WX/4f4etHN0Prhw4chjc8ELJOPyhM4X69infy65mU=
X-Received: by 2002:a6b:7e03:0:b0:753:568:358e with SMTP id
 i3-20020a6b7e03000000b007530568358emr1416961iom.20.1680585538552; Mon, 03 Apr
 2023 22:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230403184033.1836023-1-irogers@google.com> <ZCs1/skb2XqDYrYF@kernel.org>
In-Reply-To: <ZCs1/skb2XqDYrYF@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 3 Apr 2023 22:18:47 -0700
Message-ID: <CAM9d7chDz9dNpB+vywLMNxyc9p=wLaJp4qUYwfu6y88tEDYLLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Support for llvm-addr2line
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 3, 2023 at 1:24 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Apr 03, 2023 at 11:40:29AM -0700, Ian Rogers escreveu:
> > The addr2line command is started and then addresses piped to it. In
> > order to determine the end of a addr2lines output a ',' it output with
> > an expectation to get '??\n??:0\n' as a reply. llvm-addr2line differs
> > in that ',' generates a reply of ','.
> >
> > The approach detects and then caches the addr2line style. When records
> > are read the sentinel is detected appropriately.
> >
> > Comparing the output there is a little more inline data on my machine
> > with llvm-addr2line:
> > $ sudo perf record -a -g sleep 1
> > $ sudo perf report --addr2line=addr2line > a.txt
> > $ sudo perf report --addr2line=llvm-addr2line > b.txt
> > $ wc -l a.txt b.txt
> >   12386 a.txt
> >   12477 b.txt
> >
> > Some other small changes, switching to the api/io code to avoid file
> > streams wrapping the command's stdin/stdout. Ignore SIGPIPE for when
> > addr2line exits and writes fail.
> >
> > v2. Address review comments from Arnaldo and Namhyung, fixing a
> >     realloc error path, argument ordering and a comment.
>
> Added to local repo, build testing, will be in tmp.perf-tools-next soon.
>
> - Arnaldo
>
> > Ian Rogers (4):
> >   tools api: Add io__getline
> >   perf srcline: Simplify addr2line subprocess
> >   perf srcline: Support for llvm-addr2line
> >   perf srcline: Avoid addr2line SIGPIPEs

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> >
> >  tools/lib/api/io.h        |  45 ++++++++++
> >  tools/perf/tests/api-io.c |  36 ++++++++
> >  tools/perf/util/srcline.c | 171 +++++++++++++++++++++++---------------
> >  3 files changed, 184 insertions(+), 68 deletions(-)
> >
> > --
> > 2.40.0.348.gf938b09366-goog
> >
>
> --
>
> - Arnaldo
