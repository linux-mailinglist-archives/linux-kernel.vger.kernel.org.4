Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E183E68F015
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjBHNpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjBHNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:44:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F636680
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:44:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675863873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8F4anSaAXOgaD7d2SXNTwzuF6VCoNge2r+vc3EHUuw=;
        b=jza22pT4f+uyQ+xvhLROf+nawi64DF8K4bQV/5xIE1VXfuRmBDEhtuaOsVKfdsUL83UhJF
        LlMuQe26cozAAFD43T1MgHuaEfTgp8odHGJ2pXgCt6Lk+0xeWvZ6l0aqiiHSWUQWylmbVB
        gFQ5kR9azZGf4DsWHaU8m1+VZqDpi+ehDzJoFz8Ap+LHverBvY5sHq0k/L7Z5bw2pWIMiV
        2u6VBhqWAh6xeN12ERHy745IzOQo1AFYjFTjah24UjAjFqtMyOHpz+CCyJMbKHkO4Nex8C
        CgnqJUjXLuT10ocz6JfVFxtWGnd0tBA1W2hDrvQ1ghwehA2FedgikW7j+8HRlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675863873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8F4anSaAXOgaD7d2SXNTwzuF6VCoNge2r+vc3EHUuw=;
        b=vCi+2bWwXSLRxMWFjtnYZTiNH4pFrBS/pZXytPYxbX4+sRUdN1fSg6tCxzU+cE1091n3vl
        /5nLMLIT1UmlB9Dw==
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
In-Reply-To: <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
Date:   Wed, 08 Feb 2023 14:44:32 +0100
Message-ID: <87h6vw2rwf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric!

On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
> On 2/1/23 05:33, Thomas Gleixner wrote:
>
> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>
> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
> attempts at locating this state failed when inside the STARTING section, so I located
> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
> this state as the callback for the .startup method.
>
> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
> placed it at the end of the PREPARE section. This crash hotplug handler is also
> registered on this state as the callback for the .teardown method.

TBH, that's still overengineered. Something like this:

bool cpu_is_alive(unsigned int cpu)
{
	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);

	return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
}

and use this to query the actual state at crash time. That spares all
those callback heuristics.

> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
> makedumpfile and (the consumer of it all) the userspace crash utility,
> in order to understand the impact of moving from for_each_present_cpu()
> to for_each_online_cpu().

Is the packing actually worth the trouble? What's the actual win?

Thanks,

        tglx


