Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96C5EE29E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiI1RKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiI1RKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:10:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33950915E4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:10:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB0A143D;
        Wed, 28 Sep 2022 10:10:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 170793F792;
        Wed, 28 Sep 2022 10:09:59 -0700 (PDT)
Message-ID: <ef5fcbf2-e018-9af2-48c3-9fea3109b27f@arm.com>
Date:   Wed, 28 Sep 2022 19:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>
Cc:     Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Kajetan Puchalski <kajetan.puchalski@arm.com>

On 20/09/2022 16:07, Jian-Min Liu wrote:
> 
> Update some test data in android phone to support switching PELT HL 
> is helpful functionality.
> 
> We switch runtime PELT HL during runtime by difference scenario e.g.
> pelt8 in playing game, pelt32 in camera video. Support runntime
> switching PELT HL is flexible for different workloads.
> 
> the below table show performance & power data points: 
> 
> ---------------------------------------------------------------------
> --|                      | PELT
> halflife                                |
> |                      |----------------------------------------------|
> |                      |       32      |       16      |       8      |
> |                      |----------------------------------------------|
> |                      | avg  min  avg | avg  min  avg | avg  min  avg|
> | Scenarios            | fps  fps  pwr | fps  fps  pwr | fps  fps  pwr|
> |---------------------------------------------------------------------|
> | HOK game 60fps       | 100  100  100 | 105 *134* 102 | 104 *152* 106|
> | HOK game 90fps       | 100  100  100 | 101 *114* 101 | 103 *129* 105|
> | HOK game 120fps      | 100  100  100 | 102 *124* 102 | 105 *134* 105|
> | FHD video rec. 60fps | 100  100  100 | n/a  n/a  n/a | 100  100  103|
> | Camera snapshot      | 100  100  100 | n/a  n/a  n/a | 100  100  102|
> -----------------------------------------------------------------------
> 
> HOK ... Honour Of Kings, Video game
> FHD ... Full High Definition
> fps ... frame per second
> pwr ... power consumption
> 
> table values are in %

I assume that you are specifically interested in those higher min fps
numbers which can be achieved with a tolerable energy consumption
increase when running the game with 16ms or even 8ms PELT halflife.

We see a similar effect when running the UI performance benchmark
Jankbench.

So you need this runtime-switchable PELT multiplier. Would this sched
feature interface:

https://lkml.kernel.org/r/YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net

be sufficient for you? People don't like to support `changing PELT
halflife` via an official sysctl.

[...]
