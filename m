Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43A2720A35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjFBUY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjFBUY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:24:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988721BE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:24:55 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6260f03b76dso22112156d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685737495; x=1688329495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5E5GkZMJuW4S28Szy/Oiu1DB4/4/yZIXoSGZ+cVyKrM=;
        b=CcEwhKFq4C09UdNDJLKS3xKQ2YpG1V8wO7cOX4LjgFxE/BEXogGRXvcweFFe4m/mIq
         BTtxAjo1bATUJ7+N5qRRZHa4WCG78QJEeTjYlEkA907sJWry62DknsS4DoTOGkf85Ow4
         04fjdghA9FkHzN+qpLcZ3TUKMa0jvihKfVr3VF7o0AJ81fnA0Ro5xOgy0JqtApNtaQTQ
         I7GZZ+6UAiZXqZ+hVWjCarhqFaKmDds2G1fFdsCWUs7zUFXOybQeG0ICmkS52K1heo2o
         1jjCcXTf4IcyW2E/MWaWPEJbPXr4wdqJobNIuxLQlzgbTK0FkNtpoZSfIn9ixpjjPSqP
         v/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685737495; x=1688329495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5E5GkZMJuW4S28Szy/Oiu1DB4/4/yZIXoSGZ+cVyKrM=;
        b=Wk9DIzuZ+MnE3MgIXNB3AhexjwAttHjGhdAuRDVrRPQ93CsK7ZKDVowNOnWEYgh73X
         G2gOciEjY0gg3CBHuYtPzHBDqd0bNx2HBGAEopgHV1sgZGBBxMY8g/SsATJsd8PtDjPP
         W89xbZgHGRohp2F59O74tIykFxgKArY7mt7U+8yHtO1mU/tXvYkYxadGzq9xwPJZI0HG
         ubrpRgBgOZV1MLZgG0m+vbtapLqQZppWOVGeTDnNgh+taKWevYG8SF/Gp9kggadKZbVj
         ibstH/1Oztc3UFIu39KT+S80kCHRh0nXCl+gV94Gyz2pgExPC8gJU4PB7dZBJFwPWyF3
         6scQ==
X-Gm-Message-State: AC+VfDzVUqutDqarl6SsAgKssfUn0zfXHgd+CWmw35CIH1x2PpyLzWej
        POjxV7JGBXgI+RZnw4mx0xyOHQ==
X-Google-Smtp-Source: ACHHUZ5+4QuSSR8wlZlWxqM4/zwDcD0EB1Jc8W0AgqxX0h2Cacrhrci3cimhmpr6dJ8zDlXc4dY6sg==
X-Received: by 2002:a05:6214:aca:b0:625:b849:fa3 with SMTP id g10-20020a0562140aca00b00625b8490fa3mr15635613qvi.30.1685737494770;
        Fri, 02 Jun 2023 13:24:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id d18-20020ac847d2000000b003e4ee0f5234sm1180984qtr.87.2023.06.02.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 13:24:54 -0700 (PDT)
Date:   Fri, 2 Jun 2023 16:24:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: multiple zpool support
Message-ID: <20230602202453.GA218605@cmpxchg.org>
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org>
 <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
 <20230602164942.GA215355@cmpxchg.org>
 <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
 <20230602183410.GB215355@cmpxchg.org>
 <CAJD7tka18Vw7HpA1gh6wWJcaCJ_U6jNfCC696pX=UkbiXKZMvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka18Vw7HpA1gh6wWJcaCJ_U6jNfCC696pX=UkbiXKZMvQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 12:14:28PM -0700, Yosry Ahmed wrote:
> On Fri, Jun 2, 2023 at 11:34 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, Jun 02, 2023 at 09:59:20AM -0700, Yosry Ahmed wrote:
> > > On Fri, Jun 2, 2023 at 9:49 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > Again, what about the zswap_tree.lock and swap_info_struct.lock?
> > > > They're the same scope unless you use multiple swap files. Would it
> > > > make sense to tie pools to trees, so that using multiple swapfiles for
> > > > concurrency purposes also implies this optimization?
> > >
> > > Yeah, using multiple swapfiles helps with those locks, but it doesn't
> > > help with the zpool lock.
> > >
> > > I am reluctant to take this path because I am trying to get rid of
> > > zswap's dependency on swapfiles to begin with, and have it act as its
> > > own standalone swapping backend. If I am successful, then having one
> > > zpool per zswap_tree is just a temporary fix.
> >
> > What about making the pools per-cpu?
> >
> > This would scale nicely with the machine size. And we commonly deal
> > with for_each_cpu() loops and per-cpu data structures, so have good
> > developer intuition about what's reasonable to squeeze into those.
> >
> > It would eliminate the lock contention, for everybody, right away, and
> > without asking questions.
> >
> > It would open the door to all kinds of locking optimizations on top.
> 
> The page can get swapped out on one cpu and swapped in on another, no?
> 
> We will need to store which zpool the page is stored in in its zswap
> entry, and potentially grab percpu locks from other cpus in the swap
> in path. The lock contention would probably be less, but certainly not
> eliminated.
> 
> Did I misunderstand?

Sorry, I should have been more precise.

I'm saying that using NR_CPUS pools, and replacing the hash with
smp_processor_id(), would accomplish your goal of pool concurrency.
But it would do so with a broadly-used, well-understood scaling
factor. We might not need a config option at all.

The lock would still be there, but contention would be reduced fairly
optimally (barring preemption) for store concurrency at least. Not
fully eliminated due to frees and compaction, though, yes.

I'm not proposing more than that at this point. I only wrote the last
line because already having per-cpu data structures might help with
fast path optimizations down the line, if contention is still an
issue. But unlikely. So it's not so important. Let's forget it.
