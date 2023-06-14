Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B9B72D373
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbjFLVkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbjFLVkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C798
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686605972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IB3OQKtcVIr9/DCHLKfkqMz+EcMQ1kWMg+jYsrNdXkA=;
        b=R/IsXLVl61uD4SPh3DhXIippO7YlVWYkEmzZUhTy9sNzTsrYb2mocF8n279veBWSYhDCgD
        Ysj7lsCGGqfceZbVTC5o6R1jpixCLjaWWXEqJetaZOo+Q1cvTPJkQX4VcxH+9oX48b1AH+
        6Y8EDymQCIHqald6KxD+X5Kc4ZY5Oys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-7sZOOaqXNN-ZYECyNodQag-1; Mon, 12 Jun 2023 17:39:28 -0400
X-MC-Unique: 7sZOOaqXNN-ZYECyNodQag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F4152185A78B;
        Mon, 12 Jun 2023 21:39:27 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82EC21121314;
        Mon, 12 Jun 2023 21:39:27 +0000 (UTC)
Date:   Mon, 12 Jun 2023 17:39:25 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RESEND] sched/nohz: Add HRTICK_BW for using cfs bandwidth
 with nohz_full
Message-ID: <20230612213925.GB524810@lorien.usersys.redhat.com>
References: <20230518132038.3534728-1-pauld@redhat.com>
 <20230518134746.GB2860939@hirez.programming.kicks-ass.net>
 <20230518143718.GC110197@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518143718.GC110197@lorien.usersys.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, May 18, 2023 at 10:37:18AM -0400 Phil Auld wrote:
> On Thu, May 18, 2023 at 03:47:46PM +0200 Peter Zijlstra wrote:

...

> > OMG; so because NOHZ_FULL configuration sucks, we add hacks on?
> >
>

...

>
> This seemed to be a sane way to handle what are effectively conflicting
> requirements.  Stalling a task to the point the host gets rebooted is
> pretty painful.  Maybe if we could fail the tick_stop test in this
> case that would work but that would keep all the ticks whereas this
> tries to respect the request for nohz as much as possible. 

...

Let me try to argue it differently.  Forget about the nohz_full configuration
part (I dropped that from the commit log on v2, too) since you could hit
this even if nohz_full was dynamic.

My contention is that given two conflicting requests the scheduler is making
the wrong choice. A request is being made to stop the tick if possible (which
is best effort already - there are numerous conditions to satisfy). And a
request is being made to enforce a cpu bandwidth limit (which is a hard limit
that can violate work conservation, and requires regular fine-grained
accounting).  Currently the scheduler will favor the best-effort nohz request
over the quota limit request.

I posted v2 of the HRTICK based patch but maybe a simpler one that adds a
scheduler tick dependency when we pick a bandwidth-limited task would be
more palatable. 

I have that one which I could clean up and post.


Thanks,
Phil


-- 

