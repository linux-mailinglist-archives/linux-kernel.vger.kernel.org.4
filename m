Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7F716CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjE3SzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjE3Sy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:54:59 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC48410C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:54:53 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-62603efd2e3so24500856d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685472893; x=1688064893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOjS6CVqlBlukMRZLNaJyPM2L7QGvu6hUflH8GHgCWM=;
        b=34SfncPAo+S5Zx6sK6HG/1bJhx8/ATdMJVZMHEQaRT7Y4f3gXOLTXCLR7rblv6YwFk
         TTaLRJERwM1s6a2jYaBhQMVNtdHEdPoJozenRUFkkQUaITKX2I4Hwv3lhTsbsHgyJiCH
         zDezfydRMcPlAbojRKJIvoD3zB2AyUBxWKXdDf3YwNKgU2IGL651kVxcxyUjevXQygmY
         DpedRmrmRkq2pCHQvBhaYwXMwVI8BeVTIAHyizdkAmi7MLlckyT1lI31NWHO06HGZ9S2
         36LEDysP9nZ1wbkF0yv2NxaLRh677Pb4wEhLX62qlVeVjyKvpvL5Tv0edR8iNNCuTxX8
         fJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472893; x=1688064893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOjS6CVqlBlukMRZLNaJyPM2L7QGvu6hUflH8GHgCWM=;
        b=fwf1bvGqS9eP+C5XeR/28dRBmI4Sj4PooJzM2ZdIpbE1vFAoZarWZuYE3eTON1KFwb
         KZ9gm2rSeOjUnUEASInawEtNfCUUD30WxZeE+PDz59It7eO+Fu6znTkVCVQbOZu4dieu
         3x1mMvLM5d8FABRVuMd1eLiSQxVLzll0Pgxx/d9sb/bkoeDooXfo667GSrNvQRpxSpVu
         +SJpBdU6lX8UTdmm24Ruh6WVaRFNDJF1hu86471m/5bG9W4QiivZb/m0JJA91caWY8ii
         K4cQGCPePM5nC8nhvpU7heyLn7HQYwMxeKz9GLP3QMoAJzytj/ioZFBEjsQfdFhNsS8F
         ZUaQ==
X-Gm-Message-State: AC+VfDwA3LLfB19EHE4wBqQEW4/dQlL5TItR0EnSsIq2S0KHbKCnlwNv
        aaH9MLerV9Lbp3TDj1A/D6IGkQ==
X-Google-Smtp-Source: ACHHUZ4zOpT7wylBmFPvgJ9K6sJTZ7a/0tYIBptFJ9spvNGkLTEJ51s1qpvDB12N7yf9NabvwV+iRg==
X-Received: by 2002:ad4:4eae:0:b0:625:aa49:19f3 with SMTP id ed14-20020ad44eae000000b00625aa4919f3mr3525901qvb.64.1685472893062;
        Tue, 30 May 2023 11:54:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id 18-20020a05620a06d200b0075c9779c03esm4318609qky.17.2023.05.30.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:54:52 -0700 (PDT)
Date:   Tue, 30 May 2023 14:54:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <20230530185451.GA101722@cmpxchg.org>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com>
 <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
 <ZHUSfg+z3wcaIhAT@google.com>
 <20230530041341.GB84971@cmpxchg.org>
 <ZHYNaxgcKs7PSp9I@google.com>
 <20230530155519.GB97194@cmpxchg.org>
 <ZHY+C0ICTah8/+V3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHY+C0ICTah8/+V3@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:18:51AM -0700, Chris Li wrote:
> On Tue, May 30, 2023 at 11:55:19AM -0400, Johannes Weiner wrote:
> > On Tue, May 30, 2023 at 07:51:23AM -0700, Chris Li wrote:
> > > Thanks for pointing out -ENOMEM shouldn't be persistent.
> > > Points taken.
> > > 
> > > The original point of not retrying the persistent error
> > > still holds.
> > 
> > Okay, but what persistent errors are you referring to?
> 
> Maybe ENOMEM is a bad example. How about if the swap device
> just went bad and can't complete new IO writes?

This is actually outside the scope of zswap, and handled by the
swapcache (end_swap_bio_write).

Once the IO is submitted, zswap will ax its copy and leave the rest to
the swapcache. It behaves the same way as if zswap had never been
involved to begin with when the swap out fails on IO errors.

From a zswap perspective, there are no persistent errors in moving a
zswap entry back into the swapcache. Not just currently, but generally.

> > Aside from -ENOMEM, writeback_entry will fail on concurrent swap
> > invalidation or a racing swapin fault. In both cases we should
> > absolutely keep trying other entries until the goal is met.
> 
> How about a narrower fix recognizing those error cases and making
> the inner loop continue in those errors?

Right, I just I don't really see the value proposition of this
complication, and I see some downsides (see below). No single entry
error should ever cause us to stop the wider reclaim loop.

> > > > extreme case where it's the only page left on the list, I again don't
> > > > see how retrying a few times will make the situation worse.
> > > > 
> > > > In practice, IMO there is little upside in trying to be more
> > > > discerning about the error codes. Simple seems better here.
> > > 
> > > Just trying to think about what should be the precise loop termination
> > > condition here.
> > > 
> > > I still feel blindly trying a few times is a very imprecise condition.
> > 
> > The precise termination condition is when can_accept() returns true
> > again. The safety cap is only added as precaution to avoid infinite
> > loops if something goes wrong or unexpected, now or in the future.
> 
> In my mind, that statement already suggests can_accept() is not
> *precise*, considering the avoid infinite loop.
> e.g. Do we know what is the optimal cap value and why that value
> is optical?

Oh but it is precise. That's the goal we want to accomplish.

The cap is just so that in case something unexpectedly goes wrong (a
bug), we fail gracefully and don't lock up the machine. The same
reason we prefer WARN_ONs over BUG_ONs if we can, to avoid
crashes. That's really all there is too it, and it strikes me as
reasonable and robust design choice. It's fine to limp along or be
suboptimal after such a bug happens; the bar is avoiding an infinite
loop, nothing else.

Your suggestion of whitelisting certain errors is more complicated,
but also less robust: in case an entry error does by some accident
become persistent for the whole LRU, we're locking up the host. We'd
rather catch a bug like this by seeing spikes in the reclaim failure
rate than by losing production machines.

> Putting the definition of precise aside, I do see the unconditional
> retry can have unwanted effects.

I hope I could address this above. But if not, please share your
concerns.

Thanks!
