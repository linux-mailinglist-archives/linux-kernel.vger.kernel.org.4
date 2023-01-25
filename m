Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD667BAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjAYTp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAYTpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:45:54 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448B521F9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1674675953; x=1706211953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HeYCKNAQvODKPnidyMCNbZ/+1A6D3FKxf0yIX4K0Exw=;
  b=nqCksQgUeqH8YMi3vshvH9F6H+EghB3/hY/n+M5BYNXmqvFiUc35o4s+
   ycZiNNq26Hgg0wTxtVFutRYCMoDFddqKT8NP9hUHtScX/FFLxbpbcmxAO
   CX5pWeqwqI30qoNKCMhxuD481opx9vgroTEWXKq9u8eeN6sJ0GPy+zHWC
   U=;
X-IronPort-AV: E=Sophos;i="5.97,246,1669075200"; 
   d="scan'208";a="257837258"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 19:45:47 +0000
Received: from EX13D47EUC004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 2FF26410E8;
        Wed, 25 Jan 2023 19:45:42 +0000 (UTC)
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX13D47EUC004.ant.amazon.com (10.43.164.178) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Wed, 25 Jan 2023 19:45:42 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.43.162.56) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.7; Wed, 25 Jan 2023 19:45:37 +0000
Date:   Wed, 25 Jan 2023 20:45:32 +0100
From:   Roman Kagan <rkagan@amazon.de>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D42UWB001.ant.amazon.com (10.43.161.35) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upping the thread as we're hitting this problem too.

On Thu, Dec 22, 2022 at 01:45:48PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 21, 2022 at 11:19:31PM +0800, Zhang Qiao wrote:
> >     I found problem about s64 overflow in max_vruntime().
> > 
[...]
> > static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
> > {
> > 	/*
> > 	 * vruntime=0x124b17fd59db8d02
> > 	 * min_vruntime=0x918fdb05287da7c3
> > 	 * vruntime - min_vruntime = 9276074894177461567 > s64_max, will s64 overflow
> > 	 */
> > 	s64 delta = (s64)(vruntime - min_vruntime);
> > 	if (delta < 0)
> > 		min_vruntime = vruntime;
> > 
> > 	return min_vruntime;
> > }
> > 
> > ----------
> > 
> > max_vruntime() will return the kworker's old vruntime, it is incorrect and the correct result
> > shoud be cfs_rq->minvruntime. This incorrect result is greater than cfs_rq->min_vruntime and
> > will cause kworker thread starved.
> > 
> >     Does anyone have a good suggestion for slove this problem? or bugfix patch.
> 
> I don't understand what you tihnk the problem is. Signed overflow is
> perfectly fine and works as designed here.

Disagreed.

The calculation is indeed safe against the overflow of the vruntimes
themselves.  However, when the two vruntimes are more than 2^63 apart,
their comparison gets inverted due to that s64 overflow.

And this is what happens here: one scheduling entity has accumulated a
vruntime more than 2^63 ahead of another.  Now the comparison is
inverted due to s64 overflow, and the latter can't get to the cpu,
because it appears to have vruntime (much) bigger than that of the
former.

This situation is reproducible e.g. when one scheduling entity is a
multi-cpu hog, and the other is woken up from a long sleep.  Normally
when a task is placed on a cfs_rq, its vruntime is pulled to
min_vruntime, to avoid boosting the woken up task.  However in this case
the task is so much behind in vruntime that it appears ahead instead,
its vruntime is not adjusted in place_entity(), and then it looses the
cpu to the current scheduling entity.

Thanks,
Roman.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



