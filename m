Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE46819D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjA3TG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbjA3TG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:06:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096FA3865D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675105540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4gfsny8Qi2nzbLfn/fog81AyD69v8YJbIokuIUExJI=;
        b=TKCIO3s8DuQPVKGHkXMgEut4FnQ52tA5ODFPAIovK6KAsC+hfdBjeFhXA0Dv/W9bkwtY3C
        extdEIrjteznXyDjgQCZZkNuEsvNzuu5exIGM/r0pyWYuvjKSiOto7aGHjnhQjA1XAwway
        aniSxdREMlNaWNKSe26pQbR1h3b2VBM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-ZOwhbonLNxm4JVi75owWJg-1; Mon, 30 Jan 2023 14:05:35 -0500
X-MC-Unique: ZOwhbonLNxm4JVi75owWJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 808F11C00406;
        Mon, 30 Jan 2023 19:05:34 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01E2D2166B29;
        Mon, 30 Jan 2023 19:05:33 +0000 (UTC)
Message-ID: <b708c5bc-8b06-3c7a-17e9-38e0220cdb32@redhat.com>
Date:   Mon, 30 Jan 2023 14:05:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] sched: Store restrict_cpus_allowed_ptr() call state
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>, Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20230127015527.466367-1-longman@redhat.com>
 <Y9eweBuHFeO1jZCH@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9eweBuHFeO1jZCH@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/30/23 06:56, Peter Zijlstra wrote:
> On Thu, Jan 26, 2023 at 08:55:27PM -0500, Waiman Long wrote:
>> The user_cpus_ptr field was originally added by commit b90ca8badbd1
>> ("sched: Introduce task_struct::user_cpus_ptr to track requested
>> affinity"). It was used only by arm64 arch due to possible asymmetric
>> CPU setup.
>>
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>> cpumask"), task_struct::user_cpus_ptr is repurposed to store user
>> requested cpu affinity specified in the sched_setaffinity().
>>
>> This results in a slight performance regression on an arm64
>> system when booted with "allow_mismatched_32bit_el0"
> Dude, how can you still call this a slight performance regression after
> Will told you time and time again that's not the problem.
>
> It clearly is a behavioural problem.

I am trying to figure out if this behavioral problem is a result of my 
scheduler patch or just as a result of cgroup v1 current behavior as I 
don't see how my patch will cause this behavioral change if it is not an 
existing problem.

Cheers,
Longman

