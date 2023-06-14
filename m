Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554E17308D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjFNTxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbjFNTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:53:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF20171C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:53:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686772402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rktf2uLTnKAQUHaIFj/SYHVmzsJNecM/MARwTsCRF4=;
        b=ZrB4WUtgCvQQVvs23UV6Ikhcfn/btIxZ+0FGiE7k9jn0+c+wU8+4cnUBp2AcOoF4AilMQ9
        DWdWZhG2ZeB4NjrICE6jIPmecNqWuyW4wGSXaQlbTXrTSablPSz+Fg2P6FiJyazVXkv9Gm
        W50uaUzPPIDmCUkXMCpBfIKhUuO9tCWHxQghFm2v5Uz0Zab9U+rxOM5tVfUPLuWWSaWeBr
        FUkO6lrWUO5YVlyVIXq9kQhxP7gPgochNMO/8EH11XX1vVkhKBUwMj6r5B5KKH/0WHLOBJ
        FOaSo2T8rRH6C3Um7qSiiBEF+yYFg+JwYFGPGugrYyZ4NAq4ynwwczyhCEy45A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686772402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rktf2uLTnKAQUHaIFj/SYHVmzsJNecM/MARwTsCRF4=;
        b=I5cXD3geq77dGR0+r5QOZ9ZUdK8NDwTLKSBMvNXJ4Ia445PRfQpaDiCiIilxcWbDBt8N4H
        PYd6NTqCyYOZNXAg==
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 1/8] x86/smp: Make stop_other_cpus() more robust
In-Reply-To: <ZIoYMakfbAU9EOjc@a4bf019067fa.jf.intel.com>
References: <20230613115353.599087484@linutronix.de>
 <20230613121615.639116359@linutronix.de>
 <ZIoYMakfbAU9EOjc@a4bf019067fa.jf.intel.com>
Date:   Wed, 14 Jun 2023 21:53:21 +0200
Message-ID: <87ilbp95xq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14 2023 at 12:42, Ashok Raj wrote:
> On Tue, Jun 13, 2023 at 02:17:55PM +0200, Thomas Gleixner wrote:
>> 
>> WBINVD is an expensive operation and if multiple CPUs issue it at the same
>> time the resulting delays are even larger.
>
> Is this situation similar to what happened with the unexpected wakeups from
> mwait_play_dead()? 
>
> i.e the wbinvd() takes a while, and when CPU0 moves ahead, the previous
> kernel marches past the wbinvd() instruction since we didn't wait to ensure
> this has indeed completed?

This is about reboot and I don't know how wbinvd() interacts with
that. But yes, this could be an issue vs. kexec() too.

> native_machine_halt()
> {
> 	machine_shutdown()->stop_other_cpus() 
> 	stop_this_cpu();<---- Unbalanced atomic_dec()?
> }
>
> But the last stop_this_cpu() in native_machine_halt() would 
> make the count go negative? Maybe that's OK since no one is waiting for it
> to go zero at that point?

Correct it's the CPU which stopped the others.

>>  		timeout = USEC_PER_MSEC * 10;
>> -		while (num_online_cpus() > 1 && (wait || timeout--))
>> +		while (atomic_read(&stop_cpus_count) > 0 && (wait || timeout--))
>>  			udelay(1);
>>  	}
>
> If we go down the INIT path, life is less complicated.. 
>
> After REBOOT_VECTOR IPI, if stop_cpus_count > 0, we send NMI to all CPUs.
> Won't this completely update the atomic_dec() since CPUs in hlt() will also
> take the NMI correct? I'm not sure if this is problematic.
>
> Or should we reinitialize stop_cpus_count before the NMI hurrah

Bah. Didn't think about HLT. Let me go back to the drawing board. Good catch!

>> +	/*
>> +	 * Ensure that the cache line is invalidated on the other CPUs. See
>> +	 * comment vs. SME in stop_this_cpu().
>> +	 */
>> +	atomic_set(&stop_cpus_count, INT_MAX);
>
> Didn't understand why INT_MAX here?

Any random number will do. The only purpose is to ensure that there is
no dirty cache line on the other (stopped) CPUs.

Now let me look into this NMI cruft.

Thanks,

        tglx
