Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB874BEEA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGHTQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHTQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:16:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01698
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:16:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso3509252a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688843789; x=1691435789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLZlu9xJmqIEDMbaskzro9PEeknNhuP2jk6hFXnqIJo=;
        b=DuDOfgn+MmJ4xpS8fJRKKxyb7BB86J7nfnPl6/7z+iCxdVq98uRB5iTmgDNfoSK/ox
         tFxGhYHkYTq0ivXrSjRUFhhPgj9AR06k6x+bDodVjyGDxWJqDixqXJ2CaGj00xnaja4D
         B9QnnDFT5IOJz6cWgnajqCpDAoFPeajDojHqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688843789; x=1691435789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLZlu9xJmqIEDMbaskzro9PEeknNhuP2jk6hFXnqIJo=;
        b=eH48/LeCQoeaoEX/+wf8QdAnsmamxC4jG+PPGPWjwqh2GwUv70gbgKSmUOzc6/DUj0
         LErmY69yvQhMSvjH2zwnRuwNHlMQrbOr5Tk95r1GI7fD3Re8rxdpqamPJDlBT0vHa4ms
         ae90M6GNeRnd4vYpjxONRMrnJnqFlWvozK4QIZ5DycsuA6VxKyFNYm5SQelNVa79/1oy
         Mj0XgxWDZf6fnJ5YheFES3KDX9KaSMxpwy/b34JXZu/Re9GJmBzRllD5WPqoKCWEGrP5
         HhpmLtjYbh17dpRlKXCiiYGwqK3JbXQZ3xi2bx0sLIQ7/P+T0p92lu95FZnVZmGkS8Ob
         MTzg==
X-Gm-Message-State: ABy/qLYxnAWA3Cq9WHnCnVeLKff2X+d/Fct+JZh0oV+G2Ovd+WCyN9xN
        bpqmB8KeENU3fK87hrl0C+jt5Zz9O6x04Z4aXbLnwn1b
X-Google-Smtp-Source: APBJJlEreVFHrL3Zmb3shdaY8K/0oiE+pe2zXK7o8Ktmg6h5oPJLqMd73a1f/bPerifGjrUeFasa6A==
X-Received: by 2002:a17:906:4bd2:b0:993:336d:bc0c with SMTP id x18-20020a1709064bd200b00993336dbc0cmr7163924ejv.34.1688843789793;
        Sat, 08 Jul 2023 12:16:29 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906858900b0098e78ff1a87sm3819019ejx.120.2023.07.08.12.16.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 12:16:28 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso41285805e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:16:28 -0700 (PDT)
X-Received: by 2002:a5d:52cc:0:b0:314:f7e:8755 with SMTP id
 r12-20020a5d52cc000000b003140f7e8755mr9103807wrv.55.1688843788496; Sat, 08
 Jul 2023 12:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230707042644.94061-1-namhyung@kernel.org>
In-Reply-To: <20230707042644.94061-1-namhyung@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 12:16:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRP0qeuTSWtHgDdvgUTfBD1mGwrenbOyJC7_ygsbWCEQ@mail.gmail.com>
Message-ID: <CAHk-=wgRP0qeuTSWtHgDdvgUTfBD1mGwrenbOyJC7_ygsbWCEQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.5: 2nd batch
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 at 21:26, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello Linus,
>
> Please consider pulling more perf tool changes.  These are remaining
> changes and fixes for this cycle.  The last two fixes are relatively
> new but other changes have been sitting on -next for a number of days.

Hmm.

I htink there's some dependency problem in the perf tools build that
just caused a random build error for me:

   util/expr-flex.c:214: error: unterminated #ifdef

that error went away on a re-build, and it's clearly nonsensical when
I look at that file, so it looks to me like somehow the parallel buld
used that file while it 3as being generated.

I don't see anything obviously wrong, and I've only seen this error
once. I've done the pull - I doubt it was introduced by the recent
changes - but I wanted to just mention that there seems to be some
problem in this area..

Am I the only one to have ever seen something like this?

                 Linus
