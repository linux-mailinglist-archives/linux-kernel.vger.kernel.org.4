Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EFE6876FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBBIHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBBIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:07:36 -0500
Received: from galois.linutronix.de (unknown [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104007EFF2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:07:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675325248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDDjeochTSj7gweSDG5YaHCvWoBKQUX0sM0as9FUl4s=;
        b=NPK5CvuDbq5YSwgYelHq5rhDayp2TCnNipapHvsjDf/1jAhjuLuSiOuktBH/XV5YIHz6ui
        BTvVktQMPqTwQR2gjiUPGMSkCHA1ggxo88ukImIHrHJTAGG2hmFs5JZ7ugiDrJaf+enBVG
        V5pckai+X6sIIEfmT04IftsRqF0Coz6TsIy8tZmwZwiu5QAC73LlwplKpdZ47LZ1JjjalU
        Z1ANdWaJgUFcQltfccu5gfgs9pZUV4wPS+RBsGl9csL2YTAevJ2ETPVdwG/NPA/Fy4FZPZ
        Af8vKKmixQzgIjiLHrJfLe53GC9DxGaOW1Mf4vcgy7ZpiMImiGFukuVxSQpymA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675325248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDDjeochTSj7gweSDG5YaHCvWoBKQUX0sM0as9FUl4s=;
        b=zetWM6m46f+MA7EaVrlYZ7nJ7E79rdgk2CsWGYMvc0vgVhQzFpgy0RBJiQUfhBXx18hrNh
        GPCytt1pBSkzsIDg==
To:     Waiman Long <longman@redhat.com>, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
In-Reply-To: <39752908-cc10-d63f-d02e-381693060af8@redhat.com>
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org> <87wn51znsh.ffs@tglx>
 <15e8c929-845e-ef65-dc04-a51f071dd256@redhat.com>
 <20230201195517.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <39752908-cc10-d63f-d02e-381693060af8@redhat.com>
Date:   Thu, 02 Feb 2023 08:57:39 +0100
Message-ID: <87h6w4zeh8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_MED,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01 2023 at 22:40, Waiman Long wrote:
> On 2/1/23 14:55, Paul E. McKenney wrote:
>>>>> Therefore, when watchdog verification of TSC is disabled, enable it for
>>>>> HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
>>>>> time-skew diagnostic without degrading the system's performance.
>>>> I'm more than unhappy about this. We finally have a point where the TSC
>>>> watchdog overhead can go away without adding TSC=reliable to the kernel
>>>> commandline.
>>>>
>>>> Now you add an unconditionally enforce the watchdog again in a way which
>>>> even cannot be disabled on the kernel command line.
>>>>
>>>> Patently bad idea, no cookies for you!
>>> I have a similar concern about this patch as well. That is why I was
>>> suggesting to have this enabled for a limited time after boot for sanity
>>> checking purpose only.
>> Fair enough!
>>
>> If the watchdog checking of HPET and/or PMTMR against TSC only happens
>> only when the sysadm asks for it, would you still want to have the ability
>> to enable such watchdog checking at boot time, and then to disable it
>> once the system had been running for some limited time?
>
> Yes, being optional is another way to avoid the overhead for the 
> majority of users. The paranoids can turn it on if they want to.

Yes, opt-in is good enough.

Thanks,

        tglx
