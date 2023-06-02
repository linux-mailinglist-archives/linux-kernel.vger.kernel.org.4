Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475EF720472
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjFBO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjFBO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:28:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14811BF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=St8XC9p0+1FYpXODhRnwrBpiu7bJbfyVfq7/unurfDk=; b=XRQU8CdTxXTh+Wn04iRcoUR4gr
        Tfvn061VZ895GY4Lyeuy6/93HW3uVDwzu8fW5O1HhbXxf6uWG5njvVJh9HpBPm2w+lEnTp0ibgzzg
        CjUyDdWVUduDgq/IRHtW3lLUoD8wQ4Dr9XPXvLEr/uNesAxka7Buan0TWqqSJOYhODYLroYmYGlqn
        lKeGS4LrsAP5BnKpVDVt0MsbBKMz0fuutUP72GELlaYuc8GPKsXc5piRtH4ro6VUgeVWOvHT8eFh8
        rvJtviK3JfR+FfjB9DoYTXzUaXlDiUZMuplXn+X8eCjNV4aV1Eni9TnEicEAGkf/R86+La5k4cKg8
        0OaKiybA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q55kl-009HVG-0j; Fri, 02 Jun 2023 14:27:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23FA330031F;
        Fri,  2 Jun 2023 16:27:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEC2A241579F8; Fri,  2 Jun 2023 16:27:39 +0200 (CEST)
Date:   Fri, 2 Jun 2023 16:27:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 01/15] sched/fair: Add avg_vruntime
Message-ID: <20230602142739.GH620383@hirez.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.654144274@infradead.org>
 <CAKfTPtDsHJ+d2dmi8sezU0VE_aRgPO1Ltj7k207rw-_jr=ZjhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDsHJ+d2dmi8sezU0VE_aRgPO1Ltj7k207rw-_jr=ZjhQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:51:53PM +0200, Vincent Guittot wrote:
> On Wed, 31 May 2023 at 14:47, Peter Zijlstra <peterz@infradead.org> wrote:
> > +static void
> > +avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > +{
> > +       unsigned long weight = scale_load_down(se->load.weight);
> > +       s64 key = entity_key(cfs_rq, se);
> > +
> > +       cfs_rq->avg_vruntime += key * weight;
> > +       cfs_rq->avg_load += weight;
> 
> isn't cfs_rq->avg_load similar to scale_load_down(cfs_rq->load.weight)  ?
> 
> > +}

Similar, yes, but not quite the same in two ways:

 - it's sometimes off by one entry due to ordering of operations -- this
   is probably fixable.

 - it does the scale down after addition, whereas this does the scale
   down before addition, esp for multiple low weight entries this makes
   a significant difference.

