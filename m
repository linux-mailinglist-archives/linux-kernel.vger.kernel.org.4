Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530A1648857
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLISRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLISRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:17:23 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B03AC6F9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:17:20 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h193so4047502pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mHldBNwMDxBGa5oJAciP9SUh7XCxBJPxzIOTUsmKXsg=;
        b=WN8zt38fo0rPzI1M/6FwYLK6sw5AQwIa6Pr5EoLBhkjMBvLUWnVWr0DxkBlJlJ8Uib
         7O7rhSf7jJoryqf0zhjFyeRUTUHZdMu3yTJaMm5kK/UTv+7hyq6ilrMMEk9pqYl/bQcG
         dXIuqC4UOSOWfpEfqD9PrDzkJsuwrxH/YP2tiwSsM4TyPUeXB6m5gIk+YRQNYGivlLmB
         PpogDGG/pQumE4+vhoOiU6S/k7GN1Qxg8FZDPvwqUf4N6SIvZ0XXQver8oUZiWtfIg9w
         wcXYt9uRPJ/iiWJA7z1jF95/usONGU6/+6MgmkWTBFfSAkt0vjUm0bkwRGUgWLV6H3pM
         Bt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHldBNwMDxBGa5oJAciP9SUh7XCxBJPxzIOTUsmKXsg=;
        b=AZxJ4+FX5Zucgbv7oQy6eO8E6STudzj9EW5mh+m/HeG+MhhlRDC3bk5x2N02KGGIIK
         0nmdIlhNQrToshzgvX0dPkDpm7v8EqcTbLth7DVF6GOk979KudaQdniUDfC415Cz0a1Z
         xS8uK8vnh/dq265c38JlKc/YeeV07MolfHSxHrw2gMT/7CCVEP+Yh4arhYUI7J8ID+K+
         JOyAL1/+PdlLhR4X9YZxYGcKsxssImsVUyEtNEzWFvqj0J19GjRb06H2rj9hGHg4WJ/Z
         Avu2eaWc9q3UhLqQTKHGJq4LYHltaJojBpDD0CZx2Q7NIGcxMGNhkyrB7hvpfzL9RdWh
         QOOA==
X-Gm-Message-State: ANoB5pmgXxKOGtH+cKaw8alxJVU2WfAuV7IdSf9ZBx2Wz5Izy4avf8ND
        PiwELgYQp5LpQw3sPLVeC/EPNLMHf00qDry2i+ZWSQ==
X-Google-Smtp-Source: AA0mqf7Z/nMXR28vj8/FO4hAcG3xVvi1C0aJ5KtF473JPDM/O/TREHX4VgMJrUiLBXmw/AOAZYWK+u+q+01l1XwZgCI=
X-Received: by 2002:aa7:8c54:0:b0:574:2f5a:18d0 with SMTP id
 e20-20020aa78c54000000b005742f5a18d0mr73001464pfd.23.1670609839914; Fri, 09
 Dec 2022 10:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com>
In-Reply-To: <20221122001125.765003-1-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Dec 2022 10:17:08 -0800
Message-ID: <CAKwvOd=fEc=f++NFJpb+QOynC8vRrRp3wFT1KpQNwVcG9WWdrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] objtool build improvements
To:     Ian Rogers <irogers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 4:11 PM Ian Rogers <irogers@google.com> wrote:
>
> Install libsubcmd and then get headers from there, this avoids
> inadvertent dependencies on things in tools/lib. Fix V=1
> support. Clean up how HOSTCC is used to override CC to avoid CFLAGS
> being set for say gcc, and then CC being overridden to clang. Support
> HOSTCFLAGS as a make option.

Ian, I'm terribly sorry about the delay in reviewing this; usually my
turnaround time is much lower on code review...

Anyways, the patchset LGTM; thanks for the work that went into this.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> v2. Include required "tools lib subcmd: Add install target" that is
>     already in Arnaldo's tree:
> https://lore.kernel.org/lkml/20221109184914.1357295-3-irogers@google.com/
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=630ae80ea1dd253609cb50cff87f3248f901aca3
>     When building libsubcmd.a from objtool's Makefile, clear the
>     subdir to avoid it being appended onto OUTPUT and breaking the
>     build.
>
> Ian Rogers (4):
>   tools lib subcmd: Add install target
>   objtool: Install libsubcmd in build
>   objtool: Properly support make V=1
>   objtool: Alter how HOSTCC is forced
>
>  tools/lib/subcmd/Makefile | 49 ++++++++++++++++++++++++++++
>  tools/objtool/Build       |  2 --
>  tools/objtool/Makefile    | 68 +++++++++++++++++++++++++++------------
>  3 files changed, 97 insertions(+), 22 deletions(-)
>
> --
> 2.38.1.584.g0f3c55d4c2-goog
>


-- 
Thanks,
~Nick Desaulniers
