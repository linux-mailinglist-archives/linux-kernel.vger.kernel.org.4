Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7562BC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiKPLto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiKPLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:48:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 014AF29825;
        Wed, 16 Nov 2022 03:35:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1120A1477;
        Wed, 16 Nov 2022 03:35:51 -0800 (PST)
Received: from [10.57.6.51] (unknown [10.57.6.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01FCC3F663;
        Wed, 16 Nov 2022 03:35:40 -0800 (PST)
Message-ID: <205c3ebf-5a0b-883e-a9db-731e04bac728@arm.com>
Date:   Wed, 16 Nov 2022 11:35:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to
 sugov_policy"
To:     Sam Wu <wusamuel@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com, Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20221110195732.1382314-1-wusamuel@google.com>
Content-Language: en-US
In-Reply-To: <20221110195732.1382314-1-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 11/10/22 19:57, Sam Wu wrote:
> This reverts commit 6d5afdc97ea71958287364a1f1d07e59ef151b11.
> 
> On a Pixel 6 device, it is observed that this commit increases
> latency by approximately 50ms, or 20%, in migrating a task
> that requires full CPU utilization from a LITTLE CPU to Fmax
> on a big CPU. Reverting this change restores the latency back
> to its original baseline value.

Which mainline kernel version you use in pixel6?

Could you elaborate a bit how is it possible?
Do you have the sg_policy setup properly (and at right time)?
Do you have the cpu capacity from arch_scale_cpu_capacity()
set correctly and at the right time during this cpufreq
governor setup?

IIRC in Android there is a different code for setting up the
cpufreq sched governor clones. In mainline we don't have to do
those tricks, so this might be the main difference.

Could you trace the value that is read from
arch_scale_cpu_capacity() and share it with us?
I suspect this value changes in time in your kernel.

Regards,
Lukasz
