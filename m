Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F975709B59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjESPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjESPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:30:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE03CCF;
        Fri, 19 May 2023 08:30:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-309438004a6so2122123f8f.2;
        Fri, 19 May 2023 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684510230; x=1687102230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtZZ6uUexd434AXLFIEIjI9JV/0k8tvwBbLdbRsCUXo=;
        b=PyR/EY842cKASD9G5w9Gq5/xB1KS97ac+lQU4cAzAlxoj7KZlKDqCPwqmHMjeOMOrv
         qcPIMvBWfeGMzdQ6uqpPs7Ovr6H/QpVogtdEuAJeR8EEDuSP00E0zPQmt+sDz45MbHoG
         h0kGWCHRaScH8OnixMhUfOPLGNy5N+Fm/6k6tUuqAETTdmhapR1JzXIvcJQN8IqjsfhD
         BN05ocwmxjqhDaTG9fFNA17KoNHz6wltqe3eoEvpHuBZFioRz9/9h7TdSrdIEGrh4FgZ
         OrNhmOZJPAf5ov1mPsV22peVwn5Z9VU8rEUKfSCFrhom7AcG9I8uL5U5v0cGS77oxsvB
         Ejfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684510230; x=1687102230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtZZ6uUexd434AXLFIEIjI9JV/0k8tvwBbLdbRsCUXo=;
        b=EftRuzj7N6WAfaaSIelK11seC5AfG3NCwG7f6XifokcQVNQbxV2369KlhmJl6/xUr8
         LKniwtQtBar0qZXZwR1Fp8vKCOAKEHcmlyFvlDtU4imXeYwQfsYdEspRXu5OhUSEA1OT
         SB3DWRYRuIKNnrE8nXDtkfGZwv5Xr9SmqjLYQP49+N8Q7klZQf/iOikHeNms8Ax0YIB7
         eg5iz8FTmgNQdVj7pCOdKV91ja1uUJ6yzpebYHrGaPxTZQNlA/eRdPfNV/kb7Evwu5LB
         w3rUN+Kkbhe64P9wTh/3RpC3tX1Dd2Mmo3Q1dgI6X9UWe7w22fTccxaTh0qmJaLCatRq
         0y6g==
X-Gm-Message-State: AC+VfDzfXgQwd1Ili+5YIb0AZOQZeiM40Eo5dAx8fswC/b86eOHpECaW
        wFG0R9dSt3B4+ncQnIp8SpxjN33r8L8=
X-Google-Smtp-Source: ACHHUZ52sgG6ZH6RefRvJGJis8biM2vI62TUrGHb64k5WVVmM+Y/pWEsCgexr9KGJ5ZJFH8IZVILjQ==
X-Received: by 2002:a5d:544c:0:b0:2f9:61d4:1183 with SMTP id w12-20020a5d544c000000b002f961d41183mr2017687wrv.45.1684510229844;
        Fri, 19 May 2023 08:30:29 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id y18-20020adff152000000b002feea065cc9sm5563195wro.111.2023.05.19.08.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:30:28 -0700 (PDT)
Date:   Fri, 19 May 2023 16:30:27 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Message-ID: <26e20ec3-51ec-43d0-8fdb-880e4343a77f@lucifer.local>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
 <7d7ddc48-5985-4678-9f87-6e9b574a24d9@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7ddc48-5985-4678-9f87-6e9b574a24d9@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 05:09:35PM +0200, Arnd Bergmann wrote:
> On Fri, May 19, 2023, at 16:51, Lorenzo Stoakes wrote:
> > Given you are sharply criticising the code I authored here, is it too much
> > to ask for you to cc- me, the author on commentaries like this? Thanks.
>
> My mistake, I expected this to get added automatically based on
> the "Fixes:" tag, I probably dropped you by accident in the end.
>

OK no worries, it's often the way that something is purely accidental but
seems ruder than intended (or even rude at all) because text is a terrible
format :)

> > On Fri, May 19, 2023 at 11:39:13AM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> While looking at an unused-variable warning, I noticed a new interface coming
> >> in that requires the use of IS_ERR_OR_NULL(), which tends to indicate bad
> >> interface design and is usually surprising to users.
> >
> > I am not sure I understand your reasoning, why does it 'tend to indicate
> > bad interface design'? You say that as if it is an obvious truth. Not
> > obvious to me at all.
> >
> > There are 3 possible outcomes from the function - an error, the function
> > failing to pin a page, or it succeeding in doing so. For some of the
> > callers that results in an error, for others it is not an error.
> >
> > Overloading EIO on the assumption that gup will never, ever return this
> > indicating an error seems to me a worse solution.
>
> The problem is that we have inconsistent error handling in functions
> that return an object, about half of them use NULL to indicate an error,
> and the other half use ERR_PTR(), and users frequently get those
> wrong by picking the wrong one. Functions that can return both make
> this worse because whichever of the two normal ways a user expects,
> they still get it wrong.
>
> > Not a fan at all of this patch, it doesn't achieve anything useful, is in
> > service of some theoretical improvement, and actually introduces a new
> > class of bug (differentiating EIO and failing to pin).
>
> Having another -EIO return code is a problem, so I agree that
> my patch wouldn't be good either. Maybe separating the error return
> from the page pointer by passing a 'struct page **p' argument that
> gets filled would help?

Yeah I see your point, in the majority of cases failing to pin is an error,
I just wonder if something like adding another parameter wouldn't just add
more noise/confusion here than it saves?

Sadly I think aspects of this are C sucking at dealing with multiple return
values sanely, and there probably isn't a totally nice way of dealing with
this.

>
>     Arnd
