Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3272A73078D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFNSoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjFNSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:44:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E8B2688;
        Wed, 14 Jun 2023 11:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A685645BC;
        Wed, 14 Jun 2023 18:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59415C433C0;
        Wed, 14 Jun 2023 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686768259;
        bh=u121J8cwfQKQR6Kp3TJgvgH0HaZU1kI3wvydqEX92H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5rBRWTrCkoJ+qTPwmGrkxzlmvUd0ZgYh2JcOrsPRzcABCjXXDlwxvB2ASEj2o1kF
         xZvg7Xa2zElP4A1rFkO0k9DhHCQKyZUbd4eLD8FEts1vQR6QpkmkxSycoTaW3/yBv/
         YmVkS40+HQc/+74Naz0P5MGPkYR1bGXEK0k6yS3Kf05qRihps+wvRQaXlx/Bxx/Xdj
         jyCVWVHQqVh9R0zfI8iZZPwEzNpcUW2ofpXcqMRsr4dbnP+V3oEba+GPz+hyr200HG
         eZsMO99GJKq7SLamPw2PwupDvtJknFL45CzR8AODF+qoN/i/fskoxGts9O0KAXD2+4
         y+oLiMEcn9U6Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0BC1340692; Wed, 14 Jun 2023 15:44:16 -0300 (-03)
Date:   Wed, 14 Jun 2023 15:44:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] tools api: Add simple timeout to io read
Message-ID: <ZIoKgEO+pz3cDgEH@kernel.org>
References: <20230608061812.3715566-1-irogers@google.com>
 <CAP-5=fX1X=A7gkExsV917EntTdfgytNA8LBvHwTCsXfq1zHixw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX1X=A7gkExsV917EntTdfgytNA8LBvHwTCsXfq1zHixw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 14, 2023 at 10:36:47AM -0700, Ian Rogers escreveu:
> On Wed, Jun 7, 2023 at 11:20 PM Ian Rogers <irogers@google.com> wrote:
> >
> > In situations like reading from a pipe it can be useful to have a
> > timeout so that the caller doesn't block indefinitely. Implement a
> > simple one based on poll.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> There is overlap in what these patches aim to fix with the 2 submitted
> patches making addr2line more robust:
> https://lore.kernel.org/all/20230613034817.1356114-2-irogers@google.com/
> 
> I think it could be pragmatic to take both of them. Be robust but
> timeout if addr2line doesn't respond for 1s. What do you think?

Agreed, fixed up a minor conflict and applied.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/lib/api/io.h | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > index d5e8cf0dada0..9fc429d2852d 100644
> > --- a/tools/lib/api/io.h
> > +++ b/tools/lib/api/io.h
> > @@ -8,6 +8,7 @@
> >  #define __API_IO__
> >
> >  #include <errno.h>
> > +#include <poll.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <unistd.h>
> > @@ -23,6 +24,8 @@ struct io {
> >         char *end;
> >         /* Currently accessed data pointer. */
> >         char *data;
> > +       /* Read timeout, 0 implies no timeout. */
> > +       int timeout_ms;
> >         /* Set true on when the end of file on read error. */
> >         bool eof;
> >  };
> > @@ -35,6 +38,7 @@ static inline void io__init(struct io *io, int fd,
> >         io->buf = buf;
> >         io->end = buf;
> >         io->data = buf;
> > +       io->timeout_ms = 0;
> >         io->eof = false;
> >  }
> >
> > @@ -47,7 +51,29 @@ static inline int io__get_char(struct io *io)
> >                 return -1;
> >
> >         if (ptr == io->end) {
> > -               ssize_t n = read(io->fd, io->buf, io->buf_len);
> > +               ssize_t n;
> > +
> > +               if (io->timeout_ms != 0) {
> > +                       struct pollfd pfds[] = {
> > +                               {
> > +                                       .fd = io->fd,
> > +                                       .events = POLLIN,
> > +                               },
> > +                       };
> > +
> > +                       n = poll(pfds, 1, io->timeout_ms);
> > +                       if (n == 0)
> > +                               errno = ETIMEDOUT;
> > +                       if (n > 0 && !(pfds[0].revents & POLLIN)) {
> > +                               errno = EIO;
> > +                               n = -1;
> > +                       }
> > +                       if (n <= 0) {
> > +                               io->eof = true;
> > +                               return -1;
> > +                       }
> > +               }
> > +               n = read(io->fd, io->buf, io->buf_len);
> >
> >                 if (n <= 0) {
> >                         io->eof = true;
> > --
> > 2.41.0.rc0.172.g3f132b7071-goog
> >

-- 

- Arnaldo
