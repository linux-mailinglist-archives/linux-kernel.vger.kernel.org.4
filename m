Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1572AB1E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjFJLXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 07:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:23:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B32359A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 04:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yX02WC8ktj69lQbROi0A00crE4iBr/cVf+JS0FiOfOk=; b=qk+cWND8JgUGtq35j4hciFC43v
        0IYSECAC05qzhY9JuSH1fcS43yf5oGv6587FeO4DkKReypZPCVsPN3jo+iEdla4j/w9aMUR3zlfSr
        DCsYxJ1EMZfXKNcmZa48nV3B6usfF67ef6sy9OAy7L01SWz06/3tjBQqzR4zf/LIdeG44a2xDZ6t+
        fIf7aqC7hnLF+9Wut1qVz5rEmZU/ZsKakrqn2srCRBvjbbyvFu4gyjPN6DcNmCnaFhNNtqveOVfP2
        j4Wj/Qp+d5hJ9jJAEpxu++IYLMvYFDErMDJFTyQ29nYpPyDa5HZ3uKLznMlVOcUYH24HgiuDTavXa
        tPKP4W3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7wg8-007w6b-1s;
        Sat, 10 Jun 2023 11:22:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86D23300188;
        Sat, 10 Jun 2023 13:22:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59443240FDF94; Sat, 10 Jun 2023 13:22:41 +0200 (CEST)
Date:   Sat, 10 Jun 2023 13:22:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 11/15] sched/eevdf: Better handle mixed slice length
Message-ID: <20230610112241.GB4253@hirez.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.341527144@infradead.org>
 <ZIQZXMHvV3FKOquH@chenyu5-mobl2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIQZXMHvV3FKOquH@chenyu5-mobl2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 02:34:04PM +0800, Chen Yu wrote:

> > +static inline bool
> > +entity_has_slept(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > +{
> > +	u64 now;
> > +
> > +	if (!(flags & ENQUEUE_WAKEUP))
> > +		return false;
> > +
> > +	if (flags & ENQUEUE_MIGRATED)
> > +		return true;
> > +
> > +	now = rq_clock_task(rq_of(cfs_rq));
> > +	return (s64)(se->exec_start - now) >= se->slice;
> > +}
> A minor question, should it be now - se->exec_start ?
> (se->exec_start - now) is always negetive on local wakeup?

Yeah, also:

https://lkml.kernel.org/r/20230608124440.GB1002251@hirez.programming.kicks-ass.net

That is, it should be something along the lines of:

	delta = new - se->exec->start
	rerturn delta/W > vslice

