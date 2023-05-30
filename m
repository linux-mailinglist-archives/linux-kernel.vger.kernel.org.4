Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C106671682A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjE3Pzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjE3PzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:55:23 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BD8E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:55:21 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75b015c0508so275141285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685462120; x=1688054120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwWNOMoHZ+UIdNSWemfCGD87I++1r7zOSkWu1kWsMYM=;
        b=sUQAliy2CXREXRDfURy5ytT1mp6Z2MVRnyOpeymtwMw7RdoAiL5YRa0MmQLydAuXqU
         vgbFfj0rElE0lwudazbOwScQSfuVCq2SaymmgO86qe9hKMw/ieoDY+53ZOK4AQm2lRhQ
         gYx9zKeUHwLdwVXr5FQTsRIifWNNqn7belm/2dqcnfyP1bxQO5ZVVRfGufqk9ZtKuStA
         CbgGI4y5OkhmkAFo/a3fttbFCkE8XlTJ0oYoGcdxnxkk27aBVC3lNsNQQjzFVYZuJM3y
         fhCQ8OvDtdubeZwbvOHhiNY23yo7i01SdMIfeb9L+njLvOQ+eN54eyTvajzX9aoRpz92
         O9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462120; x=1688054120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwWNOMoHZ+UIdNSWemfCGD87I++1r7zOSkWu1kWsMYM=;
        b=DOItsLgF428TE+Q7aE8aAe9Ti4o8xaED+EmacjQ3AeodHwsFNmJCdHBNVBWiRMirvK
         UUKDd73Xo7vs/2jSX0the11X/DBIIWU+r7siRnwqAnH9R2v66lX/weYxn1hj+Abb1F62
         2cRN9JOCu793m2UQWYW1uZgzadWl3WSjv3NtQU5w6VvAgy1poIhTl13YtbT3lkuS8AIC
         222+LHrx2t8AfcWw6nTMejx4YvlcgviVXtGFHPaRVIkwQ+wE9KxXl3cnSCiZFa7/NnAB
         IcEg+1cqtZkithJ486By4XpgRGk53N0wzgKm2+wdsP1sXzwjuizybL5mvMKCg/d2FzS/
         FA9g==
X-Gm-Message-State: AC+VfDxm9jeSwXXZ9wrdBHsz9iDT6nK6LSkG4QMbTQ4Sir0RM3uH2qYL
        idLiIQtF8+4IelN7KUA0djQULQ==
X-Google-Smtp-Source: ACHHUZ6OXMzPI6lr8A/TCW2P1241xJOMGwaC4wkP2J02sDjyQ6VmkPnb/K7M0hGqOVx+3+wuseTcLw==
X-Received: by 2002:a05:620a:8e10:b0:75b:23a1:3663 with SMTP id re16-20020a05620a8e1000b0075b23a13663mr2024531qkn.36.1685462120300;
        Tue, 30 May 2023 08:55:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id v22-20020ac873d6000000b003f6b98018casm4760092qtp.77.2023.05.30.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:55:20 -0700 (PDT)
Date:   Tue, 30 May 2023 11:55:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <20230530155519.GB97194@cmpxchg.org>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com>
 <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
 <ZHUSfg+z3wcaIhAT@google.com>
 <20230530041341.GB84971@cmpxchg.org>
 <ZHYNaxgcKs7PSp9I@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHYNaxgcKs7PSp9I@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 07:51:23AM -0700, Chris Li wrote:
> Thanks for pointing out -ENOMEM shouldn't be persistent.
> Points taken.
> 
> The original point of not retrying the persistent error
> still holds.

Okay, but what persistent errors are you referring to?

Aside from -ENOMEM, writeback_entry will fail on concurrent swap
invalidation or a racing swapin fault. In both cases we should
absolutely keep trying other entries until the goal is met.

> > Should it be fixed before merging this patch? I don't think the
> > ordering matters. Right now the -ENOMEM case invokes OOM, so it isn't
> > really persistent either. Retrying a few times in that case certainly
> > doesn't seem to make things worse.
> 
> If you already know the error is persistent, retrying is wasting
> CPU. It can pertancial hold locks during the retry, which can
> slow someone else down.

That's a bit of a truism. How does this pertain to the zswap reclaim
situation?

> > > > As I was writing to Yosry, the differentiation would be a great improvement
> > > > here, I just have a patch set in the queue that moves the inner reclaim loop
> > > > from the zpool driver up to zswap. With that, updating the error handling
> > > > would be more convenient as it would be done in one place instead of three.i
> > > 
> > > This has tricky complications as well. The current shrink interface
> > > doesn't support continuing from the previous error position. If you want
> > > to avoid a repeat attempt if the page has a writeback error, you kinda
> > > of need a way to skip that page.
> > 
> > A page that fails to reclaim is put back to the tail of the LRU, so
> > for all intents and purposes it will be skipped. In the rare and
> 
> Do you mean the page is treated as hot again?
> 
> Wouldn't that be undesirable from the app's point of view?

That's current backend LRU behavior. Is it optimal? That's certainly
debatable. But it's tangential to this patch. The point is that
capping retries to a fixed number of failures works correctly as a
safety precaution and introduces no (new) undesirable behavior.

It's entirely moot once we refactor the backend page LRU to the zswap
entry LRU. The only time we'll fail to reclaim an entry is if we race
with something already freeing it, so it doesn't really matter where
we put it.

> > extreme case where it's the only page left on the list, I again don't
> > see how retrying a few times will make the situation worse.
> > 
> > In practice, IMO there is little upside in trying to be more
> > discerning about the error codes. Simple seems better here.
> 
> Just trying to think about what should be the precise loop termination
> condition here.
> 
> I still feel blindly trying a few times is a very imprecise condition.

The precise termination condition is when can_accept() returns true
again. The safety cap is only added as precaution to avoid infinite
loops if something goes wrong or unexpected, now or in the future.
