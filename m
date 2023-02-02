Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53171687421
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjBBDsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjBBDsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D22F756
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675309681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0sLQ+b7VOw0XT0pfQdrVJ4ODuNR3QMGSSrpYwO19H8=;
        b=NhggJxNBzkoq7XP8zowfod/fcwp3tvvndDkv1C4XMb/3JPWpohatjz1nLYmeyvFLZyDzqn
        JPNe9q9VghM2Rg3uDKy401Qf8KcceIVUieYE8DA7AwPedy5fzAuLIKXfo8iTqksh9aqVha
        FjGaJfFqav++yJBXygLI6tGrHIXNFt0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-83OPE2a_PBSInQnT66Fisg-1; Wed, 01 Feb 2023 22:40:58 -0500
X-MC-Unique: 83OPE2a_PBSInQnT66Fisg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B5803C025C4;
        Thu,  2 Feb 2023 03:40:57 +0000 (UTC)
Received: from [10.22.32.115] (unknown [10.22.32.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C7E22026D4B;
        Thu,  2 Feb 2023 03:40:56 +0000 (UTC)
Message-ID: <39752908-cc10-d63f-d02e-381693060af8@redhat.com>
Date:   Wed, 1 Feb 2023 22:40:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org> <87wn51znsh.ffs@tglx>
 <15e8c929-845e-ef65-dc04-a51f071dd256@redhat.com>
 <20230201195517.GM2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230201195517.GM2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 14:55, Paul E. McKenney wrote:
> On Wed, Feb 01, 2023 at 02:26:29PM -0500, Waiman Long wrote:
>> On 2/1/23 05:24, Thomas Gleixner wrote:
>>> Paul!
>>>
>>> On Tue, Jan 24 2023 at 16:27, Paul E. McKenney wrote:
>>>> On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
>>>> NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
>>>> TSC is disabled.  This works well much of the time, but there is the
>>>> occasional production-level system that meets all of these criteria, but
>>>> which still has a TSC that skews significantly from atomic-clock time.
>>>> This is usually attributed to a firmware or hardware fault.  Yes, the
>>>> various NTP daemons do express their opinions of userspace-to-atomic-clock
>>>> time skew, but they put them in various places, depending on the daemon
>>>> and distro in question.  It would therefore be good for the kernel to
>>>> have some clue that there is a problem.
>>>>
>>>> The old behavior of marking the TSC unstable is a non-starter because a
>>>> great many workloads simply cannot tolerate the overheads and latencies
>>>> of the various non-TSC clocksources.  In addition, NTP-corrected systems
>>>> sometimes can tolerate significant kernel-space time skew as long as
>>>> the userspace time sources are within epsilon of atomic-clock time.
>>>>
>>>> Therefore, when watchdog verification of TSC is disabled, enable it for
>>>> HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
>>>> time-skew diagnostic without degrading the system's performance.
>>> I'm more than unhappy about this. We finally have a point where the TSC
>>> watchdog overhead can go away without adding TSC=reliable to the kernel
>>> commandline.
>>>
>>> Now you add an unconditionally enforce the watchdog again in a way which
>>> even cannot be disabled on the kernel command line.
>>>
>>> Patently bad idea, no cookies for you!
>> I have a similar concern about this patch as well. That is why I was
>> suggesting to have this enabled for a limited time after boot for sanity
>> checking purpose only.
> Fair enough!
>
> If the watchdog checking of HPET and/or PMTMR against TSC only happens
> only when the sysadm asks for it, would you still want to have the ability
> to enable such watchdog checking at boot time, and then to disable it
> once the system had been running for some limited time?

Yes, being optional is another way to avoid the overhead for the 
majority of users. The paranoids can turn it on if they want to.

Cheers,
Longman

