Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F07331CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbjFPNBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFPNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE85F2133
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA3E60E75
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4E2C433C8;
        Fri, 16 Jun 2023 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686920463;
        bh=VDhR3aHja601dxfffGSb2Hxfy5D9ToFNcA+dY/sI3ok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UYTSwFWoOo7Upc91ExoaXialN89psxS6/Peaore+CVr+a1+ThiM0oNKY+RHlgWzKc
         fdvI6YA5G2VnpnMFXq05VZFd6EY9xT/9R23flvyMruvC/+YVPdYyvdd8NpTPEPAKet
         lXDIpT+PhY8sya4VbInwK5UjNYV3NMcCIZMobOqZ1ygcMGBlxhF54pWtOIoGO6p5q+
         lEp/9romh4+yIXbN6yss/Nr77ru7V+bwgAMuSdne3g/3idAp7QCRD1ecg9+jtWMXTH
         mmTjVX0IGgp0bjRUSJ9YGCqgqQCuQarHDzmIJKL2cMsJlumdr3Dix1n6VS8jnFcnhH
         Idtzb/V6Fkrqg==
Message-ID: <c8a48cd8-b3bf-743c-55c5-f942fbe08792@kernel.org>
Date:   Fri, 16 Jun 2023 15:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 5/6] sched/fair: Add trivial fair server
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <8db5a49ea92ad8b875d331d6136721645a382fe8.1686239016.git.bristot@kernel.org>
 <20230616125946.GN83892@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230616125946.GN83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 14:59, Peter Zijlstra wrote:
> On Thu, Jun 08, 2023 at 05:58:17PM +0200, Daniel Bristot de Oliveira wrote:
>> +void fair_server_init(struct rq *rq)
>> +{
>> +	struct sched_dl_entity *dl_se = &rq->fair_server;
>> +
>> +	init_dl_entity(dl_se);
>> +
>> +	dl_se->dl_runtime = TICK_NSEC;
>> +	dl_se->dl_deadline = 20 * TICK_NSEC;
>> +	dl_se->dl_period = 20 * TICK_NSEC;
>> +
>> +	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
>> +}
> 
> These here numbers should obviously become a tunable somewhere... :-)

From sched_rt_runtime and sched_rt_period, no?

-- Daniel
