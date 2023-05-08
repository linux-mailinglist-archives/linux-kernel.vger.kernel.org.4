Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7E6FA1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEHIEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9E49032
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683532976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MFXAjFUnD3DQtiGulvH5viQWsTkaor8wEAJr5G/4CI=;
        b=itW82EutQJUnTDfP5ltBGXdaLWHhXC7491+wduQJ1XIQHTRINmW5LDisQu2ccnYth//jPT
        Uj7s3NxQ7mphFTw7xxLfTW+InYZyc7Ai0GMsi4a2LY4xwjZwhyvfPWwYYAH7b5RWDFxqHl
        PJQn7mEEM5e6M0hey15XtO2+H6QWu5g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7qoqv35wMJqqvlkIyKiA2Q-1; Mon, 08 May 2023 04:02:55 -0400
X-MC-Unique: 7qoqv35wMJqqvlkIyKiA2Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75782401b13so49844885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 01:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532975; x=1686124975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MFXAjFUnD3DQtiGulvH5viQWsTkaor8wEAJr5G/4CI=;
        b=HorW3cL0WayExOZt7JzOwods9E5zHdxLk/WMvrf+QYVKMmJy0wkloLtm5S5/qondPB
         be7m8mv8S/sob+TEnRl42E2uCW9fBQcT1XCoCulWyJk2YHuERVmRqCPeeS9gFHQgiG2+
         jJ6nK8OS0l+Uuh7Ts6bdzDUywePdKS0AStlRrlAvkp2QIrL4VEfa6DuomQ5zLcKHtdxl
         iztoTB+IdQHU2z2IGOsom3FhcCpqQuZpqyEwTPZydo+LwoO1QjgOyZR9DFiCmcdPDc16
         AJpohcAre9ks/f1wx/Yqua5ySXdRPIUr3JKgdwqcgXIboksy46RohJtwKO+bv72/D43k
         F/bA==
X-Gm-Message-State: AC+VfDwupUzwFpjfn8gP9CLs5W+PMPbabn61fHgy/MK0VbQ4DEExGxxN
        KpkI7rm3mrjlMd6s7ScyagRUcJXytHvFAvuaQXazeHVUJ6b9BuVgn1QEL7z0m4wWnaP+ZVKUQ1+
        dcbqlBNQRoanFp1CZkvtcC0qa
X-Received: by 2002:a05:622a:148d:b0:3f0:daab:f24f with SMTP id t13-20020a05622a148d00b003f0daabf24fmr14276608qtx.68.1683532975217;
        Mon, 08 May 2023 01:02:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49sKG4SRtZSdWAEFwRy8w5M6OoN5oyZ9XM+mMhdjkNL/fTgDiITu1RGRM8ghkz7Bqq8R+7bA==
X-Received: by 2002:a05:622a:148d:b0:3f0:daab:f24f with SMTP id t13-20020a05622a148d00b003f0daabf24fmr14276585qtx.68.1683532974860;
        Mon, 08 May 2023 01:02:54 -0700 (PDT)
Received: from localhost.localdomain ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id c11-20020a05620a164b00b007468765b411sm2400053qko.45.2023.05.08.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 01:02:54 -0700 (PDT)
Date:   Mon, 8 May 2023 10:02:46 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth
 restoration
Message-ID: <ZFispnba4DZt50Io@localhost.localdomain>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230504062525.GF1734100@hirez.programming.kicks-ass.net>
 <ZFNqJf+BQ0GMdr+y@localhost.localdomain>
 <ZFVZdbdZTLGhqYp4@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFVZdbdZTLGhqYp4@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/05/23 09:31, Tejun Heo wrote:
> On Thu, May 04, 2023 at 10:17:41AM +0200, Juri Lelli wrote:
> > On 04/05/23 08:25, Peter Zijlstra wrote:
> > > On Wed, May 03, 2023 at 09:22:22AM +0200, Juri Lelli wrote:
> > > 
> > > > Dietmar Eggemann (2):
> > > >   sched/deadline: Create DL BW alloc, free & check overflow interface
> > > >   cgroup/cpuset: Free DL BW in case can_attach() fails
> > > > 
> > > > Juri Lelli (4):
> > > >   cgroup/cpuset: Rename functions dealing with DEADLINE accounting
> > > >   sched/cpuset: Bring back cpuset_mutex
> > > >   sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
> > > >   cgroup/cpuset: Iterate only if DEADLINE tasks are present
> > > > 
> > > >  include/linux/cpuset.h  |  12 +-
> > > >  include/linux/sched.h   |   4 +-
> > > >  kernel/cgroup/cgroup.c  |   4 +
> > > >  kernel/cgroup/cpuset.c  | 242 ++++++++++++++++++++++++++--------------
> > > >  kernel/sched/core.c     |  41 +++----
> > > >  kernel/sched/deadline.c |  67 ++++++++---
> > > >  kernel/sched/sched.h    |   2 +-
> > > >  7 files changed, 244 insertions(+), 128 deletions(-)
> > > 
> > > Aside from a few niggles, these look fine to me. Who were you expecting
> > > to merge these, tj or me?
> > 
> > Thanks for reviewing!
> > 
> > Not entirely sure, it's kind of split, but maybe the cgroup changes are
> > predominant (cpuset_mutex is probably contributing the most). So, maybe
> > tj? Assuming this looks good to him as well of course. :)
> 
> Yeah, they all look sane to me and both Waiman and Peter seem okay with
> them. If you post an updated version with the minor suggestions applied,
> I'll route the series through the cgroup tree.

Thanks for reviewing and eventually taking care of the series. v3 just
posted (20230508075854.17215-1-juri.lelli@redhat.com).

Best,
Juri

