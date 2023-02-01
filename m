Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45109686EEB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjBAT1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBAT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBD183073
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675279596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zF3OA8SKzKM9RTG081dSBYfAt/aARMWX+Z3LR6evyU=;
        b=Z1wTNrb1hOG3bYn/nvtWd9x9SsaqXXDsoXYb9A1JYsHoBMCHtJ41hYCk6wjOGjwcrxnpPX
        Mjg55hulNvR8wZsN0aezJtN9cB6dpvuSnID4nk5/4CYCwRrS+6Pm0GYP6xWVhMLppsGEbX
        /stQ50x8AMACShQ/EVrCWh1CeUYcgSM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-ZzU4mkOaPOiOFbT18iGTWQ-1; Wed, 01 Feb 2023 14:26:33 -0500
X-MC-Unique: ZzU4mkOaPOiOFbT18iGTWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9662886066;
        Wed,  1 Feb 2023 19:26:31 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEF92140EBF4;
        Wed,  1 Feb 2023 19:26:29 +0000 (UTC)
Message-ID: <15e8c929-845e-ef65-dc04-a51f071dd256@redhat.com>
Date:   Wed, 1 Feb 2023 14:26:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org> <87wn51znsh.ffs@tglx>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <87wn51znsh.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 05:24, Thomas Gleixner wrote:
> Paul!
>
> On Tue, Jan 24 2023 at 16:27, Paul E. McKenney wrote:
>> On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
>> NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
>> TSC is disabled.  This works well much of the time, but there is the
>> occasional production-level system that meets all of these criteria, but
>> which still has a TSC that skews significantly from atomic-clock time.
>> This is usually attributed to a firmware or hardware fault.  Yes, the
>> various NTP daemons do express their opinions of userspace-to-atomic-clock
>> time skew, but they put them in various places, depending on the daemon
>> and distro in question.  It would therefore be good for the kernel to
>> have some clue that there is a problem.
>>
>> The old behavior of marking the TSC unstable is a non-starter because a
>> great many workloads simply cannot tolerate the overheads and latencies
>> of the various non-TSC clocksources.  In addition, NTP-corrected systems
>> sometimes can tolerate significant kernel-space time skew as long as
>> the userspace time sources are within epsilon of atomic-clock time.
>>
>> Therefore, when watchdog verification of TSC is disabled, enable it for
>> HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
>> time-skew diagnostic without degrading the system's performance.
> I'm more than unhappy about this. We finally have a point where the TSC
> watchdog overhead can go away without adding TSC=reliable to the kernel
> commandline.
>
> Now you add an unconditionally enforce the watchdog again in a way which
> even cannot be disabled on the kernel command line.
>
> Patently bad idea, no cookies for you!

I have a similar concern about this patch as well. That is why I was 
suggesting to have this enabled for a limited time after boot for sanity 
checking purpose only.

The previous "[PATCH clocksource 5/6] clocksource: Suspend the watchdog 
temporarily when high read latency detected" patch, however, should be 
fine. Right?

Cheers,
Longman

