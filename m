Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6267A3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjAXUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjAXUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67197D8D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674591881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BeQBrphgizYTu2EmfQ4dpSbHgXLQCkY9IO+ImuU17w=;
        b=Jko1TEgj74yCLjUGKmtvnNaeKVXUYuW2xhr4n7qprTNywIFTINE2xVmmJ1rcGFrPUFr30B
        9IaP9TxUyIQVk+IATN/JkKAvO01hiaYhTL3r4f6AF8jnWvLZqBpSGZIenIBjcnHi3vNXth
        47M90d8Qg8HJEc49T4SMulXBTybN2Dk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-SwbYbzDeP2qd_FkYaRbBhA-1; Tue, 24 Jan 2023 15:24:38 -0500
X-MC-Unique: SwbYbzDeP2qd_FkYaRbBhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E92AC1C04345;
        Tue, 24 Jan 2023 20:24:37 +0000 (UTC)
Received: from [10.22.10.191] (unknown [10.22.10.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E98DD2026D2A;
        Tue, 24 Jan 2023 20:24:36 +0000 (UTC)
Message-ID: <fdf76fb2-1da4-2d72-7eb3-21137a7d6845@redhat.com>
Date:   Tue, 24 Jan 2023 15:24:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <20230121021749.55313-1-longman@redhat.com>
 <20230124194805.GA27257@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230124194805.GA27257@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/23 14:48, Will Deacon wrote:
> Hi Waiman,
>
> [+Thorsten given where we are in the release cycle]
>
> On Fri, Jan 20, 2023 at 09:17:49PM -0500, Waiman Long wrote:
>> The user_cpus_ptr field was originally added by commit b90ca8badbd1
>> ("sched: Introduce task_struct::user_cpus_ptr to track requested
>> affinity"). It was used only by arm64 arch due to possible asymmetric
>> CPU setup.
>>
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>> cpumask"), task_struct::user_cpus_ptr is repurposed to store user
>> requested cpu affinity specified in the sched_setaffinity().
>>
>> This results in a performance regression in an arm64 system when booted
>> with "allow_mismatched_32bit_el0" on the command-line. The arch code will
>> (amongst other things) calls force_compatible_cpus_allowed_ptr() and
>> relax_compatible_cpus_allowed_ptr() when exec()'ing a 32-bit or a 64-bit
>> task respectively. Now a call to relax_compatible_cpus_allowed_ptr()
>> will always result in a __sched_setaffinity() call whether there is a
>> previous force_compatible_cpus_allowed_ptr() call or not.
> I'd argue it's more than just a performance regression -- the affinity
> masks are set incorrectly, which is a user visible thing
> (i.e. sched_getaffinity() gives unexpected values).

Can your elaborate a bit more on what you mean by getting unexpected 
sched_getaffinity() results? You mean the result is wrong after a 
relax_compatible_cpus_allowed_ptr(). Right?

sched_getaffinity() just return whatever is in cpus_mask. Normally, it 
should be whatever cpus are allowed by the current cpuset unless 
sched_setaffinity() has been called before. So after a call to 
relax_compatible_cpus_allowed_ptr(), it should revert back to the 
cpu_allowed set in the cpuset. If sched_setaffinity() has been called, 
it should revert back to the intersection of the current cpuset and 
user_cpus_ptr.

Cheers,
Longman

