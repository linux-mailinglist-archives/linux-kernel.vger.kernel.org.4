Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4BE7349AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjFSBUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFSBUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283710C4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687137531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJcFjV6pMmGhhQ74b6q47TJilbjK91hK2Te/yYvvcKY=;
        b=HH83hPVobLJJVwVaJZbbud3WXOFijc7zV54zcaVE7/ZWL3D9UUuuJtbr6KDOQrygKRpNLY
        TJeGiLpDnyNXyhLnFPbj2bsVqJWRl6A+K1GPz0X5cUfajnbF2VWJNcYXvx+aEPdP0qVvMX
        jZfzrQSCr8v4GA0M2/IVOVCz8stx5yA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-V6JgilncMMe0GUh746NMGw-1; Sun, 18 Jun 2023 21:18:44 -0400
X-MC-Unique: V6JgilncMMe0GUh746NMGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7359F101A528;
        Mon, 19 Jun 2023 01:18:43 +0000 (UTC)
Received: from [10.22.16.51] (unknown [10.22.16.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6FDB112132C;
        Mon, 19 Jun 2023 01:18:41 +0000 (UTC)
Message-ID: <55219f3b-992d-ccc3-ba29-7bf33465b5cc@redhat.com>
Date:   Sun, 18 Jun 2023 21:18:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/5] x86/speculation: Disable IBRS when idle
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Robin Jarry <rjarry@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Joe Mario <jmario@redhat.com>
References: <20230616200003.745742-1-longman@redhat.com>
 <CTECMFWMMST3.9FTWRDG7FFKQ@ringo>
 <20230617122115.GA1830050@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230617122115.GA1830050@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/23 08:21, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 10:14:52PM +0200, Robin Jarry wrote:
>> Waiman Long, Jun 16, 2023 at 21:59:
>>> For Intel processors that need to turn on IBRS to protect against
>>> Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
>>> the performance of the whole core even if only one thread is turning
>>> it on when running in the kernel. For user space heavy applications,
>>> the performance impact of occasionally turning IBRS on during syscalls
>>> shouldn't be significant. Unfortunately, that is not the case when the
>>> sibling thread is idling in the kernel. In that case, the performance
>>> impact can be significant.
>>>
>>> When DPDK is running on an isolated CPU thread processing network packets
>>> in user space while its sibling thread is idle. The performance of the
>>> busy DPDK thread with IBRS on and off in the sibling idle thread are:
>>>
>>>                                  IBRS on               IBRS off
>>>                                  -------               --------
>>>    packets/second:                  7.8M                  10.4M
>>>    avg tsc cycles/packet:         282.26                 209.86
>>>
>>> This is a 25% performance degradation. The test system is a Intel Xeon
>>> 4114 CPU @ 2.20GHz.
>>>
>>> This patch series turns off IBRS when in various idle mode to eliminate
>>> the performance impact of the idling thread on its busy sibling thread.
>> Hi Longman,
>>
>> thanks a lot for the quick turnaround on this issue.
>>
>> Tested-by: Robin Jarry <rjarry@redhat.com>
> I can't see the patches -- they didn't arrive in my mailbox nor can I
> find them in the archive, in fact this here mail is the only evidence
> they exist at all.

I got a rebound message from your mail server about incorrect message 
format. It is probably caused by some problem in my end.


> However, did you all see intel_idle_ibrs() and how that is selected for
> C6 and up?
>
> What exactly isn't working there?

We were testing on the RHEL9.2 kernel which doesn't have your 
intel_idle_ibrs() patch yet. My preliminary testing does indicate your 
patch will likely work. I will ask Jerry to test a newer RHEL9.3 kernel 
with the intel_idle_ibrs() patch to see if it helps.

> Also, instead of investing more in this IBRS trainwreck, did you all try
> call-depth-stuffing ?

Yes, we are planning to backport your call-depth-stuffing code, but I 
believe there is still some issue outstanding that you need to address. 
So we need a solution to work around this issue in the mean time.

Cheers,
Longman

