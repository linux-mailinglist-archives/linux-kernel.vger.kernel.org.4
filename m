Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B61735A26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjFSO60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjFSO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E0F127
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 119C060CA5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4182C433C0;
        Mon, 19 Jun 2023 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687186702;
        bh=4UfSusgYw3exkdItnAYAPRhe1K3UVvL03XGMYn3n71c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uFB3Yx1o25EcZj5nxkm+DLJcYoTHRrlZ3DxXkllPSlDAfHX5a6uNbLm8oomyNc+PB
         znAlV7A7y1hHSLjMZO4FGf93+ymJJrxIrIa8Oj+eZdMbefIBTBGoT13UBTVBRdmqx8
         M8vWnjj2+2vYI637oV2F3e9tPqGcNy76xuXr4XndyWPh2zscXPDAV8L9NEcNCCOo37
         oYIV4mOs3FpHXnZ3r/AL/TgGNFZJ5G1KTcdYxnC749jmXV1Sqa+ZWIVIlDCjBVGLwL
         AQ9RN5QOesCbR9bY6cRKmMy137Us8Y0rHa4s2vlw4vOTB0i0x0XiDvA5udUmEq0oFh
         oWpTgUYiEaigw==
Message-ID: <c7d6c737-801c-8f9a-ca54-e6be93a96f7a@kernel.org>
Date:   Mon, 19 Jun 2023 16:58:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
 <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
 <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org>
 <20230616120507.GM83892@hirez.programming.kicks-ass.net>
 <20230619120215.GO38236@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230619120215.GO38236@hirez.programming.kicks-ass.net>
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

On 6/19/23 14:02, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 02:05:07PM +0200, Peter Zijlstra wrote:
>> On Tue, Jun 13, 2023 at 03:41:30PM +0200, Daniel Bristot de Oliveira wrote:
>>
>>> In an 0-laxity scheduler, the server would run at 0-laxity, jumping in
>>> front of DL tasks... that would break EDF. It would be mixing two
>>> schedulers in one. It is not required and likely not a good idea either.
>>
>> I did consider a hybrid 0-laxity and EDF scheduler for mixed
>> criticality, as have others like Ted Baker IIRC. IIRC it can be done
>> using an augmented tree, but none of that solves the problems 0-laxity
>> has (like over preemption and the general problem of playing chicken by
>> doing things at the *VERY* last possible moment).
>>
>> I think I did a talk at OSPERT on this at some point many years ago.
>> Luckily some bright fellow had this semi-partitioned stuff that would
>> make live much simpler :-)
> 
> I must clarify; I was thinking Least-Laxity-First, which is ofcourse not
> the same as a 0-laxity scheduler.

ok, least-laxity-first is another thing... I think the 0-laxity came from the need
to wait until that point in time to deffer the dl server for the throttling case only...
not as a scheduler.

but still, the vast majority of research is concentrated on EDF. The laxity depends
on the runtime. As the task consumes runtime its laxity changes, so its priority.
With deadline only, the priority stays fixed during the job (Job level fixed priority)
It is easier to take decisions, less overheads & context switch and  we can explore
things with virtual deadlines.

IIUC, the EVVDF is also uses virtual deadline abstraction, right?

-- Daniel


