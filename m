Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBA5EDD5E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiI1NBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiI1NBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:01:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 965DF9DB4F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:00:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A191063;
        Wed, 28 Sep 2022 06:00:53 -0700 (PDT)
Received: from wubuntu (unknown [10.57.34.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CD1C3F73D;
        Wed, 28 Sep 2022 06:00:44 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:00:43 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kernel-team@android.com
Subject: Re: [RFC][PATCH v3 0/3] Softirq -rt Optimizations
Message-ID: <20220928130043.d6ijyxbq43tfvqg7@wubuntu>
References: <20220921012550.3288570-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921012550.3288570-1-jstultz@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

On 09/21/22 01:25, John Stultz wrote:
> Hey all,
> 
> This series is a set of patches that optimize scheduler decisions around
> realtime tasks and softirqs.  This series is a rebased and reworked set
> of changes that have been shipping on Android devices for a number of
> years, originally created to resolve audio glitches seen on devices
> caused by softirqs for network or storage drivers.
> 
> Long running softirqs cause issues because they aren’t currently taken
> into account when a realtime task is woken up, but they will delay
> realtime tasks from running if the realtime tasks are placed on a cpu
> currently running a softirq.

Thanks a lot for sending this series. I've raised this problem in various
venues in the past, but it seems it is hard to do something better than what
you propose here.

Borrowing some behaviours from PREEMPT_RT (like threadedirqs) won't cut it
outside PREEMPT_RT AFAIU.

Peter did suggest an alternative at one point in the past to be more aggressive
in limiting softirqs [1] but I never managed to find the time to verify it
- especially its impact on network throughput as this seems to be the tricky
trade-of (and tricky thing to verify for me at least). I'm not sure if BLOCK
softirqs are as sensitive.

I think the proposed approach is not intrusive and offers a good balance that
is well contained and easy to improve upon on the future. It's protected with
a configuration option so users that don't want it can easily disable it.

[1] https://gitlab.arm.com/linux-arm/linux-qy/-/commits/core/softirq/


Thanks

--
Qais Yousef
