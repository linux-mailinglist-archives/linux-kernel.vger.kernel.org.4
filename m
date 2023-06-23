Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D573B1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjFWHfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFWHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:35:37 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012C7195;
        Fri, 23 Jun 2023 00:35:35 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 993973F038;
        Fri, 23 Jun 2023 07:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687505734;
        bh=bKhME4x6xiWH8kS9xyBkaY6hugmNKgepHlQQ2MHYY2c=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bkvTi4fDtVrzGxPgZhQoYFws4ul5LKb3XZvqKX2PjwzI2Yw4mCgf3X7vY04yQ+XdF
         4yVkhJPvnhIHfsUoVT8QlCBZzXQb9LlvrVe+haC5T6DFZr+OJUbf+0MtCbXaxLf5Yl
         u6E+tOCyEMMTOLh1QjHmNCxE79tWyg5petDJ+/9Y40xl9NfTvT1AE2KEnBVPvrrTyw
         tNz4noVSc1tWilRFCjn3AO6DRCC4levw+WaSbGQm7xvtMN7joONSUtBmVTdmkJmba+
         SmjfyZisipmXCBV44N+DPSk0h7/iM91lZnqBBepziIPt/10YR3fhNMpakg6y5xkWkF
         QA5pP8R6HT11Q==
Message-ID: <ed287d2f-5b53-dffb-dec3-e5b28fa70a52@canonical.com>
Date:   Fri, 23 Jun 2023 00:35:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
 <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
 <ddbd1564-8135-5bc3-72b4-afb7c6e9caba@amd.com>
 <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
 <6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com>
 <f94cd9fa-1a83-1f54-0259-123fcd86d549@canonical.com>
 <20230623063726.ejuc6v9D@linutronix.de>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230623063726.ejuc6v9D@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 23:37, Sebastian Andrzej Siewior wrote:
> On 2023-06-21 16:59:31 [-0700], John Johansen wrote:
>>> Which turned a per-cpu cache into a global memory pool protected by a spinlock. It may benefit RT, but it does not appear to be so great at scaling.
>>>
>> it is not. And I have a patch that needs some more formal testing for some stats.
>> Ubuntu pulled it in last cycle so it has gotten a fair bit of use and is looking good
>> on that end. There are probably some tweaks that can be done to improve it. The
>> backoff in particular is something that has mostly been adjusted in response to some
>> basic benchmarking.
>>
>> anyways patch below
>>
>> commit e057e9b47f1749882ea0efb4427d6b9671c761ab
> 
> I think I've been looking at this patch, or a former version of it, and
> it looked good.
> 
iirc the difference with the earlier version, is in the put case. Where in
the earlier version, if there was lock contention the buffer would always
get pushed onto the percpu list. With some debug patches on top we
saw some degenerate cases where this would result in percpu lists that
had excessive buffers on them.

So this version added a condition to force putting the buffer back
in to the global pool if the percpu list already has 2 buffers
cached on it.



