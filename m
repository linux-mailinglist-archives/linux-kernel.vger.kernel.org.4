Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8160D5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiJYUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJYUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:54:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B994BB1B97
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:54:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t25so9092120qkm.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cbuu5NxrLuy+svcRghiXil0f9HUvsQIk72bu4jMYG0=;
        b=J7oWN5+rNPq33bmmHP5KEOMXl99soMVw2neA4Bjv19KOiAeW/wKkl3SZui8GfmUacj
         qQdcYwUbuesOi+tRJEkId6Zknra792Kf8Pg3McitI3MSthmwHPur6ycMdEtgW8QySHxk
         +duMwRHzxReQvx+ndLxXCI5RfvI1pfFVwLP2PquAPzEaisCVhMQYJI6K/lUzwS6uPR2N
         OhI7yZplqYw3/hypYqbnzsnMD4GLPQICijaQXAkx4L1sGfEBIPrdaU9Ey8PCVFZguyLK
         wV9eF+sEUWmvB7i3nsmEgK6VJCbmTB/Y4OuTtMpKYbtxlw5LDl8/BVNCkotu9dLbK35f
         mBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cbuu5NxrLuy+svcRghiXil0f9HUvsQIk72bu4jMYG0=;
        b=M2ajaqtMul3Om5F/8prNc+kbjioCDBDg4UKoO6bP1NQ7WK7bp8FRox5eUKPKOPbJKh
         mGcqp0bXKS+AxGPzRi0NkC7RQHrb3zpG+EQ48AqEUVFGgkEcSZcZu3+IFzRLlrSNxVp/
         K1CNLtpnskJ/V/C1MEn9aYAm5CYLGZPC6U5jVqR2vbZq+lUw80ughgl9HNPgMd5+BNj5
         DLSaYyF5kkmAx7mnS22gzf0Q4GAF0L69m4lWLEi1sEgd3ZlRel/dyjea4BnQC5Q4RLrC
         fX1Uni887dzhHGajFdBN2EWuJ39b4IqjCOpa5z95BLLI1wRM3gdUO8U5exQkStjKj8Zr
         tYLA==
X-Gm-Message-State: ACrzQf0J2V72lOar04iaKCC1KHTA5G3JpZlBPskcEJfZN0vewTQwedjY
        nWpgRPZuVjfSCPmbGZ2O0hFNsA==
X-Google-Smtp-Source: AMsMyM5nC8dAql4TQBE1Wo3rbAM+LONk6LKK8ae00dBX1b75ncbsYyxtlcd/I7py55A8AI1bLa3RVg==
X-Received: by 2002:a37:e118:0:b0:6ec:565e:f2d8 with SMTP id c24-20020a37e118000000b006ec565ef2d8mr28510136qkm.719.1666731241918;
        Tue, 25 Oct 2022 13:54:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a25d300b006ec62032d3dsm2714776qko.30.2022.10.25.13.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:54:01 -0700 (PDT)
Date:   Tue, 25 Oct 2022 16:54:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim
 stats
Message-ID: <Y1hM6sMRpBGUPRyo@cmpxchg.org>
References: <20221025170519.314511-1-hannes@cmpxchg.org>
 <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:40:15PM -0700, Yang Shi wrote:
> On Tue, Oct 25, 2022 at 10:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Direct reclaim stats are useful for identifying a potential source for
> > application latency, as well as spotting issues with kswapd. However,
> > khugepaged currently distorts the picture: as a kernel thread it
> > doesn't impose allocation latencies on userspace, and it explicitly
> > opts out of kswapd reclaim. Its activity showing up in the direct
> > reclaim stats is misleading. Counting it as kswapd reclaim could also
> > cause confusion when trying to understand actual kswapd behavior.
> >
> > Break out khugepaged from the direct reclaim counters into new
> > pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.
> >
> > Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):
> >
> > pgsteal_kswapd 1342185
> > pgsteal_direct 0
> > pgsteal_khugepaged 3623
> > pgscan_kswapd 1345025
> > pgscan_direct 0
> > pgscan_khugepaged 3623
> 
> There are other kernel threads or works may allocate memory then
> trigger memory reclaim, there may be similar problems for them and
> someone may try to add a new stat. So how's about we make the stats
> more general, for example, call it "pg{steal|scan}_kthread"?

I'm not convinved that's a good idea.

Can you generally say that userspace isn't indirectly waiting for one
of those allocating threads? With khugepaged, we know.

And those other allocations are usually ___GFP_KSWAPD_RECLAIM, so if
they do direct reclaim, we'd probably want to know that kswapd is
failing to keep up (doubly so if userspace is waiting). In a shared
kthread counter, khugepaged would again muddy the waters.
