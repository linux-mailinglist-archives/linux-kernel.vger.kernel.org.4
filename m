Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F67734A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjFSD00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFSD0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AF8E62
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687145135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivKvkwGCkvotfc0fZr6hNN4RRHeyZqwTcj4Dp/7Dgzw=;
        b=dmLqF+xRgaoE8IO4xOYS20JX2KopSejT6xrOmBz0drDZnA30nyxt8VAbfQHqyoGyFq8+at
        UHictc/aH+W2aBFHJsdSj2qEy+eIPxUaMr1e3SirY+ZD8LE5+aUAJTxlWr0BikG2l8cHIQ
        eloTkhYZYdmRDK0VHT4kN7mGbSBc7W8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-3b1LzjG6MRy7lRBMkdskOA-1; Sun, 18 Jun 2023 23:25:31 -0400
X-MC-Unique: 3b1LzjG6MRy7lRBMkdskOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8238C3C11A09;
        Mon, 19 Jun 2023 03:25:30 +0000 (UTC)
Received: from [10.22.16.51] (unknown [10.22.16.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC66C1603B;
        Mon, 19 Jun 2023 03:25:29 +0000 (UTC)
Message-ID: <ef2490a0-2768-ba70-e89d-59c0df76f827@redhat.com>
Date:   Sun, 18 Jun 2023 23:25:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/5] x86/speculation: Disable IBRS when idle
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Robin Jarry <rjarry@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.Peter Anvin" <hpa@zytor.com>,
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
 <55219f3b-992d-ccc3-ba29-7bf33465b5cc@redhat.com>
In-Reply-To: <55219f3b-992d-ccc3-ba29-7bf33465b5cc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/23 21:18, Waiman Long wrote:
> On 6/17/23 08:21, Peter Zijlstra wrote:
>> On Fri, Jun 16, 2023 at 10:14:52PM +0200, Robin Jarry wrote:
>>> Waiman Long, Jun 16, 2023 at 21:59:
>>>> For Intel processors that need to turn on IBRS to protect against
>>>> Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
>>>> the performance of the whole core even if only one thread is turning
>>>> it on when running in the kernel. For user space heavy applications,
>>>> the performance impact of occasionally turning IBRS on during syscalls
>>>> shouldn't be significant. Unfortunately, that is not the case when the
>>>> sibling thread is idling in the kernel. In that case, the performance
>>>> impact can be significant.
>>>>
>>>> When DPDK is running on an isolated CPU thread processing network 
>>>> packets
>>>> in user space while its sibling thread is idle. The performance of the
>>>> busy DPDK thread with IBRS on and off in the sibling idle thread are:
>>>>
>>>>                                  IBRS on               IBRS off
>>>>                                  ------- --------
>>>>    packets/second:                  7.8M 10.4M
>>>>    avg tsc cycles/packet:         282.26 209.86
>>>>
>>>> This is a 25% performance degradation. The test system is a Intel Xeon
>>>> 4114 CPU @ 2.20GHz.
>>>>
>>>> This patch series turns off IBRS when in various idle mode to 
>>>> eliminate
>>>> the performance impact of the idling thread on its busy sibling 
>>>> thread.
>>> Hi Longman,
>>>
>>> thanks a lot for the quick turnaround on this issue.
>>>
>>> Tested-by: Robin Jarry <rjarry@redhat.com>
>> I can't see the patches -- they didn't arrive in my mailbox nor can I
>> find them in the archive, in fact this here mail is the only evidence
>> they exist at all.
>
> I got a rebound message from your mail server about incorrect message 
> format. It is probably caused by some problem in my end.
>
>
>> However, did you all see intel_idle_ibrs() and how that is selected for
>> C6 and up?
>>
>> What exactly isn't working there?
>
> We were testing on the RHEL9.2 kernel which doesn't have your 
> intel_idle_ibrs() patch yet. My preliminary testing does indicate your 
> patch will likely work. I will ask Jerry to test a newer RHEL9.3 
> kernel with the intel_idle_ibrs() patch to see if it helps.

We may need to extend your current solution to cover more cases. Perhaps 
adding a module parameter (e.g. idle_no_ibrs) to force the use of 
intel_idle_ibrs(). BTW, is it really the case that we can't disable IBRS 
when irq is enabled? The idle thread does not really interact with any 
user applications. I don't think there is any risk of information 
leakage even if we disable IBRS with interrupt enabled. Is my assumption 
incorrect?

Thanks,
Longman

