Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4FA74427C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF3Sn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjF3SnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:43:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2922F3C00
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:43:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so2592361a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688150602; x=1690742602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPEvXo6WjRs1USguPeZQCvSg+BfPycq4avRrgWVGqyM=;
        b=Tfd4srCUb5pQPtWZGrzEItpOby83+pCgDydvDuEEyTa7LSdNmjIMuWUxGxMnwUiKw3
         hhL+mYcTJpREALUKA7NuMx6BzVcp3tgEfPFtW5rIpw93SYNEbPlwJfzvHMzcEMDCb0a1
         dO6nTRA+ES7Ob6qnlZ64kGLfbiUn+5ya26kN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688150602; x=1690742602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPEvXo6WjRs1USguPeZQCvSg+BfPycq4avRrgWVGqyM=;
        b=VhHwnug0SWkG1mJBnDFNCNgiH+5S1XbgmJ1/qlcslZfTrrB0HOXjgZCQ235eUYGRpY
         CK+dSNr6HJ0Rsqmm1/+XRNMZ/i470xN5FSgnJpIt5tDEIq2nqODAm42MT291LKlQ9cSk
         n1EC1yCmLlssWG0jBYhvnMYv0MzjUcpQTYao5+FaOk4DWQmatsN12HsSCrHX2Cr0gwlC
         QQVaGh2ArWWzMQ5TXXeMgCVm2XuoyrSdPxMXLI7+sWIsCXCipC9i++NJDLerFZpM/Cjf
         C+fC8SdhNij5KmAb/KDp8fJ64GO1dsojlGPdWmK0HFRPW6ThX1PgyoPCMupDqj28TFnr
         Tp9Q==
X-Gm-Message-State: ABy/qLaPMgB9l0ZCuQzkV780b9Y+D9YiqVCQff0RZDiJvGw8MbLwJYw1
        2jVAo12cf1UviFsUWL31PYuzxSf1Lgb12w1ahUpPFhe/
X-Google-Smtp-Source: APBJJlGw1qbsrrksaRSL7ad9akiV8t068k37OXnm3dmYadJU7YPGF2jjtgI7WYn/D688McdRa0hqBg==
X-Received: by 2002:aa7:c410:0:b0:51d:9110:4b11 with SMTP id j16-20020aa7c410000000b0051d91104b11mr2452534edq.12.1688150602527;
        Fri, 30 Jun 2023 11:43:22 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id i12-20020aa7dd0c000000b0051830f22825sm6996441edv.90.2023.06.30.11.43.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 11:43:21 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51dd1e5a621so2607349a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:43:21 -0700 (PDT)
X-Received: by 2002:a05:6402:3456:b0:51a:50f2:4e7a with SMTP id
 l22-20020a056402345600b0051a50f24e7amr2198661edc.13.1688150601530; Fri, 30
 Jun 2023 11:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230628215954.1230048-1-namhyung@kernel.org>
In-Reply-To: <20230628215954.1230048-1-namhyung@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 11:43:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOLQsPiDJifHzfg+q-W4q=MXcbvzKLS4J4otOicbZqjA@mail.gmail.com>
Message-ID: <CAHk-=whOLQsPiDJifHzfg+q-W4q=MXcbvzKLS4J4otOicbZqjA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.5
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 15:00, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Please consider pulling perf tool changes.  I'm doing this on behalf of
> Arnaldo as he's on vacation.  This is my first pull request and hope I
> didn't break anything. :)

Things look normal, although I find your pgp key situation confusing.

I looked up your gpg key from the kernel.org pgp key repo, but that's
apparently not the one you used for signing this.

So I have two keys for you, and neither of them are then signed by
others (although that part is probably just the usual pgp mess with
signatures being dropped due to flooded bogus signatures, which has
made the whole pgp infrastructure be essentially close to useless).

Anyway, I wish the pgp key situation would be better, but it's not an
actual problem.

HOWEVER.

What _is_ a problem is that the end result doesn't build cleanly.

The

        if (list_empty(&pmus))
                perf_pmu__scan(NULL);

        ibs_pmu = perf_pmu__find("ibs_op");

in the amd-ibs-via-core no longer works, and it seems that it should just be

        ibs_pmu = perf_pmus__find("ibs_op");

That's fine - I can do (and did) that merge resolution - and it's part
of my normal "merge and test build", but I'm slightly unhappy that I
wasn't told about this part.

The actual data conflicts were trivial. But this was a semantic
conflict that was invisible to git, but showed up in build testing.

And I *think* you should have known about it, because the conflict you
do talk about shows that

 +perf-y += amd-ibs-via-core-pmu.o

as part of the actual data conflicts.

Anyway, I've resolved this, and it wasn't a *problem*, and I'm just a
bit unhappy that it took me by surprise.

              Linus
