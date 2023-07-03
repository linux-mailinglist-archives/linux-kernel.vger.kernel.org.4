Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771FB745E3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGCOMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGCOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B0E58
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688393471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBOERPIoo6ho6MdhXFVtaYCIHUOl3yOvK/q0qC4bZE0=;
        b=itxzg9gNJkQuI09sAXe766VhBgzHyArLxPfN544C31b4a3eFtnKHpZ5shQ0nTueX63K17W
        fpW5tFWN004wS9iNl/aYmYHQAclKSb0KABY9f0m9KhyeKaemy6xWEBosyhCyi8pgu83+27
        O0Tp+JbZgZkAOa3PCKJ9//InsVuk+R8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-m6ED0EWVN--0u3qAhlIH7Q-1; Mon, 03 Jul 2023 10:11:05 -0400
X-MC-Unique: m6ED0EWVN--0u3qAhlIH7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA61F810BB4;
        Mon,  3 Jul 2023 14:11:04 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.194.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D098A1121314;
        Mon,  3 Jul 2023 14:11:00 +0000 (UTC)
Date:   Mon, 3 Jul 2023 10:10:56 -0400
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
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
Message-ID: <20230703141056.GA67396@lorien.usersys.redhat.com>
References: <20230630135714.1018434-1-pauld@redhat.com>
 <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
 <20230630152824.GC43299@lorien.usersys.redhat.com>
 <20230630160534.GA2534344@hirez.programming.kicks-ass.net>
 <20230630162910.GD43299@lorien.usersys.redhat.com>
 <20230703121009.GH4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703121009.GH4253@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 02:10:09PM +0200 Peter Zijlstra wrote:
> On Fri, Jun 30, 2023 at 12:29:10PM -0400, Phil Auld wrote:
> 
> > I think you are agreeing that I need the pick next code but need to remove
> > the hierarchy walks, right?
> 
> Yeah, the dequeue case makes we have to care about pick, not sure we
> then also need to care about sched_update_tick_dependency() though.
> There is indeed a window where these two will 'race', but afaict it is
> benign.
> 

Hm, that's confusing.

As I see it it's the enqueue case (0->1 mostly) where we need the check
in pick.  At that point in enqueue we only have a handle on ->curr which
is the idle thread.

For the dequeue case (2->1) we need the check in the
sched_update_tick_dependency() path because if the 1 is the task on the
cpu (and is staying there) then we'd otherwise clear the bit when we
shouldn't (since we aren't going to go back through pick).

I'm thinking that I'll try to set the bit in pick since we only care about
it when it's the task on the cpu.  That, I think, will simplify the
code needed to update the bit when the quota is changed (to or from
RUNTIME_INF).

Setting the bit in enqueue/dequeue means updating it on all the queued
task if it changes. Although I may clear it in dequeue just to not leave
it around stale.


Cheers,
Phil
-- 

