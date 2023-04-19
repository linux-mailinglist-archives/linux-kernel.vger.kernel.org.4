Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9800A6E7295
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 07:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjDSFTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 01:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDSFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 01:18:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2399E469F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:18:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CEFD143D;
        Tue, 18 Apr 2023 22:19:40 -0700 (PDT)
Received: from [192.168.189.178] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EEA03F587;
        Tue, 18 Apr 2023 22:18:52 -0700 (PDT)
Message-ID: <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
Date:   Wed, 19 Apr 2023 07:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce
 SCHED_FLAG_RESET_UCLAMP_ON_FORK flag
Content-Language: en-US
To:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20230416213406.2966521-1-davidai@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230416213406.2966521-1-davidai@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 23:34, David Dai wrote:
> A userspace service may manage uclamp dynamically for individual tasks and
> a child task will unintentionally inherit a pesudo-random uclamp setting.
> This could result in the child task being stuck with a static uclamp value

Could you explain this with a little bit more detail? Why isn't the
child task also managed by the userspace service?

The child task will only make a difference if it's on the rq.

Does this issue happen with uclamp mainline or only with Android's
slightly different version (max- vs. sum aggregation)?

> that results in poor performance or poor power.
> 
> Using SCHED_FLAG_RESET_ON_FORK is too coarse for this usecase and will
> reset other useful scheduler attributes. Adding a
> SCHED_FLAG_RESET_UCLAMP_ON_FORK will allow userspace to have finer control
> over scheduler attributes of child processes.

[...]

