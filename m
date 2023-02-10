Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03703691A29
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjBJIlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBJIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:41:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C255D3EA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=khMnYDc7UOKzbX3CCDSAj+Wo4i4NAPcutmfg9CiymIE=; b=nLCfmHjeWTrPVt5mxMrFljm35K
        C1CfDOlR2U0qnY3a6JZLa8Liyq9JwItNQPVtUJE5neYZD4nU9UuY/vXlIXRQmgZi0e5bANWUeVQ7V
        QadqHXt7MImOlOwlCrpGZDB9Is0KXerOLbsVsxDPJCNvoQjTRcoyq5ikZbBMt+bweLl1wFlzKXYu0
        87kIqtOkoOenevkTJek4xufxQQnlUZePT+PSlFsjPHRNndOiXcVxxni10BICC40pawlw4mJHuMnL2
        Lnp3P/YtriqTcxfJHnuFDoTFAvPR/i5ShywQr7KNlH6eotNsB71mEA50mQWnwzHm7+OSA+UDKZPeX
        QvnQXcfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQOy7-002xRd-7y; Fri, 10 Feb 2023 08:41:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 598043003E1;
        Fri, 10 Feb 2023 09:41:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0859B2061BB0F; Fri, 10 Feb 2023 09:41:15 +0100 (CET)
Date:   Fri, 10 Feb 2023 09:41:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Message-ID: <Y+YDKpHLDkYOTVWL@hirez.programming.kicks-ass.net>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtB_YR8e6fcx3Un0vTeJR4EJS9sOXG=wLb8rZeM5Ub4yyA@mail.gmail.com>
 <Y+TexehP3140vxBu@hirez.programming.kicks-ass.net>
 <20230210004333.GA6166@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210004333.GA6166@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 04:43:33PM -0800, Ricardo Neri wrote:
> On Thu, Feb 09, 2023 at 12:53:41PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 08, 2023 at 08:56:32AM +0100, Vincent Guittot wrote:
> > 
> > > > +                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> > > > +                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
> > > 
> > > This 2nd if could be merged with the upper one
> > 
> > Wasn't this exact same condition used in the previous patch as well?
> > Does it wants to be a helper perhaps?
> 
> Patch 3 focuses on the destination CPU: make sure that it and its SMT
> siblings are idle before attempting to do asym_packing balance.
> 
> This patch focuses on the busiest group: if the busiest group is an SMT
> core with more than one busy sibling, help it even if it has higher
> priority.

Yeah, so? If its a recurring expression a helper never hurts.
