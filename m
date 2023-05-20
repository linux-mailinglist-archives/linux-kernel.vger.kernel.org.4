Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCB70A69E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjETJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjETJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:14:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5891A8;
        Sat, 20 May 2023 02:14:53 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3093eb8cd1fso2570239f8f.1;
        Sat, 20 May 2023 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684574092; x=1687166092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p26w75jnOzAEdo+Byo9aO1qQn64wYCOl3bY13+vxNmk=;
        b=oOl3jkJ6SD5TY56pKAFFeCXwzDR/dT6qZPAb1m7wFYg/h9zOoYhU7nDbmXo0+iqqrR
         2sUrZXzOioUEEXZEJvSlHfHYzbOVmnOM7Rx/ANRsUAX3xWe7sfrGJPy34HpJBLxEorpd
         M8J78EuPVkYsaA70esysc623hyLmkF3qvl2b6xwZEZsRzDlKSEB2FvgN375kCzzSHmh6
         jXbozkqpMnPyaZwwKPTCCb6fsNyclb52LFRqgi8VJkY85sLrAhCQRSZGe4h6ZjzY/7s1
         fEQsQCZDvusqEObIGOmEMnuziyDw5qXkCxJ+GRVrfaaVu0Qgs7vYIv6xNit10F44NfWX
         VZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684574092; x=1687166092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p26w75jnOzAEdo+Byo9aO1qQn64wYCOl3bY13+vxNmk=;
        b=FqcEi3TnE+K/3lo9bL11MOETx9m54GHckJ2nls2ht3lSFMnoHr0SSnPGvCrxENQXXH
         9oBhN0iaWatyaWbY9eDJq69E4JoLitTI7WRk5P4CyGoqzFUlC+oi3JttNnNxVIPq0lIE
         fknqS/Dk153a9eO0wY9xAAkBtROal4J09Z3mKTk0fqjp6j93tkaPetzmU2L6wWvaLm05
         enA5ZhzfB2pSdjNdOoeWziaZw+iG/t/JUiTpHWfdlJhRut8j7XjRxSI4wYPS+HIC3PLB
         FQPuOcGE8e9U1rMS3UKV+u/YLA0Pmmt/MkG2/EPp40WkNOp+tjU18ZEG7Mc4c90QHFlR
         yS+Q==
X-Gm-Message-State: AC+VfDxWItDyZQ9Yr7bNUMXWVk9Lh4KLkO5SvlCjZEv8oin/4t3ERqo3
        48i8cPlceUcYvkNuiv33sT8=
X-Google-Smtp-Source: ACHHUZ71oQFelW3p0VPKhNo3IJWJEBFsEgvGe0d+bIIqgHevklfCmsbpUHXpFr1U8wMuimNDrlbMKg==
X-Received: by 2002:a5d:4385:0:b0:309:436a:fc2f with SMTP id i5-20020a5d4385000000b00309436afc2fmr2826502wrq.57.1684574091429;
        Sat, 20 May 2023 02:14:51 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id j2-20020adfff82000000b00304832cd960sm1401962wrr.10.2023.05.20.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 02:14:50 -0700 (PDT)
Date:   Sat, 20 May 2023 10:12:40 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <0bc9dc2b-0da6-4d5c-96af-e21aa287eecb@lucifer.local>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
 <ZGf1hV7iEQyqAim5@ziepe.ca>
 <1ca47b8a-292c-47ab-aa6f-ca24fdfc0d3c@lucifer.local>
 <ZGiEEPXdAMnKqkqx@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGiEEPXdAMnKqkqx@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 05:25:52AM -0300, Jason Gunthorpe wrote:
> On Sat, May 20, 2023 at 06:19:37AM +0100, Lorenzo Stoakes wrote:
> > On Fri, May 19, 2023 at 07:17:41PM -0300, Jason Gunthorpe wrote:
> > > On Fri, May 19, 2023 at 03:51:51PM +0100, Lorenzo Stoakes wrote:
> > > > Given you are sharply criticising the code I authored here, is it too much
> > > > to ask for you to cc- me, the author on commentaries like this? Thanks.
> > > >
> > > > On Fri, May 19, 2023 at 11:39:13AM +0200, Arnd Bergmann wrote:
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > While looking at an unused-variable warning, I noticed a new interface coming
> > > > > in that requires the use of IS_ERR_OR_NULL(), which tends to indicate bad
> > > > > interface design and is usually surprising to users.
> > > >
> > > > I am not sure I understand your reasoning, why does it 'tend to indicate
> > > > bad interface design'? You say that as if it is an obvious truth. Not
> > > > obvious to me at all.
> > > >
> > > > There are 3 possible outcomes from the function - an error, the function
> > > > failing to pin a page, or it succeeding in doing so. For some of the
> > > > callers that results in an error, for others it is not an error.
> > >
> > > No, there really isn't.
> > >
> > > Either it pins the page or it doesn't. Returning "NULL" to mean a
> > > specific kind of failure was encountered is crazy.. Especially if we
> > > don't document what that specific failure even was.
> > >
> >
> > It's not a specific kind of failure, it's literally "I didn't pin any
> > pages" which a caller may or may not choose to interpret as a failure.
>
> Any time gup fails it didn't pin any pages, that is the whole
> point. All that is happening is some ill defined subset of gup errors
> are returning 0 instead of an error code.
>
> If we want to enable callers to ignore certain errors then we need to
> return error codes with well defined meanings, have documentation what
> errors are included and actually make it sane.

Yeah I agree it's not exactly great that a failure to pin can be considered
an ordinary case, but I don't think a wrapper function is where we should
be trying to fix this.

In fact this patch isn't even fixing it, it's treating EIO as a success
case for the (possibly broken) uprobe case.

I think we are at the wrong level of abstraction here, basically.

>
> > That can be a reason for gup returning 0 but also if it you look at the
> > main loop in __get_user_pages_locked(), if it can't find the VMA it will
> > bail early, OR if the VMA flags are not as expected it'll bail early.
>
> And how does that make any sense? Missing VMA should be EFAULT.

Yeah missing VMA doesn't really make sense since we invoke the function
with the mmap lock held (it _could_ make sense if you were calling it via
one of the unlocked functions, speculatively, though how sensible doing
that is another discussion...)

>
> > caller differentiates between an error and not being able to pin -
> > uprobe_write_opcode() - which treats failure to pin as a non-error state.
>
> That looks like a bug since the function returns 0 on success but it
> clearly didn't succeed.

The code is specifically handling a failure-to-pin separately - set_swbp() ->
uprobe_write_opcode() -> install_breakpoint() explicitly does the following:-

	ret = set_swbp(&uprobe->arch, mm, vaddr);
	if (!ret)
		clear_bit(MMF_RECALC_UPROBES, &mm->flags);

So even if this is... questionable, the code literally does want to
differentiate between an error and a failure to pin.

Presumably this is because of the flag check, but yeah we should be
differentiating between sub-cases.

>
> > Also if we decided at some point to return -EIO as an error suddenly we
> > would be treating an error state as not an error state in the proposed code
> > which sounds like a foot gun.
>
> No, this returning 0 on failure is a foot gun. Failing to pin a single
> page is always an error, the only question is what sub reason caused
> the error to happen. There is no third case where it is not an error.
>
> Jason

The uprobe path thinks otherwise, but maybe the answer is that we just need
to -EFAULT on missing VMA and -EPERM on invalid flags.

I could look into a patch that tries to undo this convention, and then we
could revisit this for the wrapper function too.
