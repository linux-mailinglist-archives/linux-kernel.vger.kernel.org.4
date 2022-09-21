Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D695C0410
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiIUQ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiIUQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:26:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BB46B2CF2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:09:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC34813D5;
        Wed, 21 Sep 2022 09:07:49 -0700 (PDT)
Received: from wubuntu (unknown [10.57.50.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D56C93F5A1;
        Wed, 21 Sep 2022 09:07:39 -0700 (PDT)
Date:   Wed, 21 Sep 2022 17:07:38 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
Message-ID: <20220921155521.qb3jb74nbjoenau6@airbuntu>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org>
 <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
 <YyioI4iBFq8ib9JT@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyioI4iBFq8ib9JT@slm.duckdns.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/22 07:34, Tejun Heo wrote:
> On Mon, Sep 19, 2022 at 05:49:27PM +0200, Vincent Guittot wrote:
> > > For `nice` we have `cpu.weight.nice` next to `cpu.weight` in cgroup v2 ?
> > 
> > If everybody is ok, I can add back the cpu.latency.nice interface in
> > the v5 in addition to the cpu.latency
> 
> Yeah, that sounds fine to me.

I do have concerns about cpu.latency knob as it exposes latency_offset which
won't be meaningful for all consumers of latency_nice [1].

The current use case proposed by Vincent is not going to be the only consumer
of this interface. The concept of converting this latency_nice value to weight
in similar fashion to existing nice value is specific to it. In previous
discussion this conversion was not required and I'd expect it to still not be
required for those other use cases.

Wouldn't cpu.latency.nice be enough? I think the latency_offset is
implementation detail that userspace shouldn't be concerned about.


[1] https://lwn.net/Articles/820659/


Cheers

--
Qais Yousef
