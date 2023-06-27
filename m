Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D7740407
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjF0Tew convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 15:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjF0Teu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:34:50 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F00019B5;
        Tue, 27 Jun 2023 12:34:49 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-c14476f8401so3842115276.3;
        Tue, 27 Jun 2023 12:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687894488; x=1690486488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUsQmSReCxHkqKT7OuIdKRpzJJXqb1I9oXjZYPaKNpA=;
        b=ZEX3MlV3BKNOk/buTtHYYkFVR+iBVPWL46ZidpLg4C1W7/ZR1FGRZYmThJGtaAKdMQ
         nXAeHGYTe2Hp6c3RxoySn32UKFdCS3G/x2beHxYnZP0SFHfQg/w2iTHl5qjm8wR1gMGY
         gGCf65eV3lDEQI5YcpsX8EkGUMv36YL7DQBNh1wJHU0Z0f2fTWXCmD753eVhCfjlgiYt
         p+IjysV5FO3QrFNY0LjO4bnRSs4fupC4DBbMEzGkejJ51hRXB3Ab2jvHWJ1sJIgcLuVD
         eptsDYbrdybruenfPRU3/dJjkkWjuNYOzALUObOmt4iYFZ/bRPQc6YpUUqlz4XWQTzeP
         iE7A==
X-Gm-Message-State: AC+VfDycy0hGVgyofq167YrY7SPUo+rqVBiGD+yDupzbn2uSJ+ARy/IW
        dIVEugLH+CbRSV1T2Ma7BUazU5x0sJpFmmHrnEE=
X-Google-Smtp-Source: ACHHUZ6fiKok99YjzU7OG8pBAydJNKiKHdySyfWf8dVjX0ienYyez9kf3jM/ql4xd95WViLQhcO25v4qoodmkQWLByk=
X-Received: by 2002:a25:37d7:0:b0:c0b:7483:5cf0 with SMTP id
 e206-20020a2537d7000000b00c0b74835cf0mr12439210yba.65.1687894488592; Tue, 27
 Jun 2023 12:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230627063257.549005-1-namhyung@kernel.org> <CAP-5=fVGjsDEFfCXzqsDEz_dnXm635qGTLD+7L9w2qhKNr5VNA@mail.gmail.com>
In-Reply-To: <CAP-5=fVGjsDEFfCXzqsDEz_dnXm635qGTLD+7L9w2qhKNr5VNA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Jun 2023 12:34:37 -0700
Message-ID: <CAM9d7chvc7qVMN3N19avpy+noAkff=VaZiqio6Ozi1DM2+HdCw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix a compile error on pe-file-parsing.c
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 7:56 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jun 26, 2023 at 11:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The dso__find_symbol_by_name() should be have idx pointer argument.
> > Found during the build-test.
> >
> >   $ make build-test
> >   ...
> >     CC      /tmp/tmp.6JwPK1xbWG/tests/pe-file-parsing.o
> >   tests/pe-file-parsing.c: In function ‘run_dir’:
> >   tests/pe-file-parsing.c:64:15: error: too few arguments to function ‘dso__find_symbol_by_name’
> >      64 |         sym = dso__find_symbol_by_name(dso, "main");
> >         |               ^~~~~~~~~~~~~~~~~~~~~~~~
> >   In file included from tests/pe-file-parsing.c:16:
> >   /usr/local/google/home/namhyung/project/linux/tools/perf/util/symbol.h:135:16: note: declared here
> >     135 | struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx);
> >         |                ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
