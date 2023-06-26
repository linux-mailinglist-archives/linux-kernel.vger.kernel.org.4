Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E773ECFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjFZVmP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 17:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFZVmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:42:10 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B9116;
        Mon, 26 Jun 2023 14:42:08 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c1061f0c282so3139655276.1;
        Mon, 26 Jun 2023 14:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687815728; x=1690407728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdOZq17J4e8rhRHEPHZEQm6bDkdkz7IHg5SEQcMgbCQ=;
        b=F/b0SRZckjDKkvhaGSIhXhtsmldaTZK9N0PVYK93/BjD/cGU6NgbqJZl6RVOvM3TUr
         nDMBtoGrbPtASj1/0YV6hG9bUokVOGSd7B0JUp6oGTO6YcAWfNeEQyPXdaqJQHvAp12z
         zLDHTBDsjVjk/14auXqlXR8S4/Qnce3iqLXK4FhtvchMaazzS1Q9VLw1Me7NI+ZItq9g
         h8fzfzWuXFJGGhZmaj0fys/TCxIB78YCCDCn0jx4QyhKUb5jPw3LdBLq8vd5DTwAyMw2
         TQ+eSu7beo6xjQrNd23FkbG0rjO2/mHRoGMmMfmloSDA6I6I3uA5tXMranEdcianErSJ
         QrPg==
X-Gm-Message-State: AC+VfDxU9+3SEU+UKZRepeX/orClvqUCjipTSLBgSBu6/Z1ixYbKJ+/2
        uncTpZj0FyvKnLPhK4IVndoy6kCsDCrK6KE7xh4=
X-Google-Smtp-Source: ACHHUZ5CkfRZSowJvGxhTfstgoOjpf3ifxVAikedwaDuYiNmONQ0mpos1E8HAwSJWwM95G4rJri2ZGhGZ4XA6cDa/Xk=
X-Received: by 2002:a25:2d02:0:b0:bcc:a4a6:bf34 with SMTP id
 t2-20020a252d02000000b00bcca4a6bf34mr25830890ybt.37.1687815727899; Mon, 26
 Jun 2023 14:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <2947430.1687765706@warthog.procyon.org.uk> <20230626090239.899672-1-matthieu.baerts@tessares.net>
 <20230626142734.0fa4fa68@kernel.org>
In-Reply-To: <20230626142734.0fa4fa68@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Jun 2023 14:41:56 -0700
Message-ID: <CAM9d7che_3z=NgT9OkrNmAQigY3Bo8nv16TVH6fgx8pn76xUbg@mail.gmail.com>
Subject: Re: [PATCH net-next] perf trace: fix MSG_SPLICE_PAGES build error
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        dhowells@redhat.com, acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        davem@davemloft.net, irogers@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, netdev@vger.kernel.org, peterz@infradead.org,
        sfr@canb.auug.org.au
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

Hello,

On Mon, Jun 26, 2023 at 2:27 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 26 Jun 2023 11:02:39 +0200 Matthieu Baerts wrote:
> > Our MPTCP CI and Stephen got this error:
> >
> >     In file included from builtin-trace.c:907:
> >     trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
> >     trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (first use in this function)
> >        28 |         if (flags & MSG_##n) {           |                     ^~~~
> >     trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
> >        50 |         P_MSG_FLAG(SPLICE_PAGES);
> >           |         ^~~~~~~~~~
> >     trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is reported only once for each function it appears in
> >        28 |         if (flags & MSG_##n) {           |                     ^~~~
> >     trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
> >        50 |         P_MSG_FLAG(SPLICE_PAGES);
> >           |         ^~~~~~~~~~
> >
> > The fix is similar to what was done with MSG_FASTOPEN: the new macro is
> > defined if it is not defined in the system headers.
> >
> > Fixes: b848b26c6672 ("net: Kill MSG_SENDPAGE_NOTLAST")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Closes: https://lore.kernel.org/r/20230626112847.2ef3d422@canb.auug.org.au/
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> >
> > Notes:
> >     @David: I solved it like that in MPTCP tree. Does it work for you too?
> >
> >     I guess tools/perf/trace/beauty/include/linux/socket.h file still needs
> >     to be updated, not just to add MSG_SPLICE_PAGES but also other
> >     modifications done in this file. Maybe best to sync with Arnaldo because
> >     he might do it soon during the coming merge window I guess.
> >
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi Arnaldo, are you okay with us taking this into the networking tree?
> Or do you prefer to sync the header after everything lands in Linus's
> tree?

Arnaldo is on vacation now, and I'm taking care of the patches
on behalf of him.

As it's introduced in the networking tree, it should be fine to
carry the fix together.  I'll sync the header later.

But in general you don't need to change the copy of the tools
headers together.  It also needs to support old & new kernels
so different care should be taken.  Please separate tooling
changes and let us handle them.

Thanks,
Namhyung
