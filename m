Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68F607E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJUTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJUTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:04:18 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093D127B54D;
        Fri, 21 Oct 2022 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G4K9k1zNE9wxg5828SFlibbq6Y2lTTow4KwI+UrsdMs=; b=EjIsHayOJjShOqKbuvRNg/BfVx
        wGxcDLK4fKQSgrsiJm0Z8OfXu3P+B58c3VK44khdWVFq/k0C8fgiHt2HMaHlSy0ohymnOlWBEsnVn
        M6gk2uE4QGjZ0KuksYvMuxl4whA+vt8ASJlalPiEggT2PBxR9z/Z15WmGideNgD3FTdoNVulTuDFx
        4THpItlFE1rgBL6PEg8yIJOQij4FHIRZk+iRG0KHx6ZR2bVSeo/VYighKVtqpcw+2twjhWzbkHhh1
        Qczxk1geIN6dLty3kyHbZtuw4a5ghdXQZDv7oJ1w3GOj3yzpukrN6MdSMIupaSnN4EC4ryKKXiF8x
        zIbBi/AQ==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1olxJ6-0031Wf-RA; Fri, 21 Oct 2022 21:03:49 +0200
Message-ID: <267fb708-9fae-f651-d8c6-e34a873d668f@igalia.com>
Date:   Fri, 21 Oct 2022 16:03:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Andre Almeida <andrealmeid@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
 <44b41091-d474-9f80-fcf1-93c8d1316272@intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <44b41091-d474-9f80-fcf1-93c8d1316272@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, thanks for the thorough review!
Comments inline below:

On 21/10/2022 14:27, Dave Hansen wrote:
> [...]
>> +For x86 CPUs supporting the split lock detection mechanism, this parameter
>> +allows the users to turn off what is called "the misery mode", which
>> +introduces intentional delay in userspace applications that split locks.
>> +The goal of the misery mode is to prevent using such unaligned access to
>> +DoS the system dropping the performance overall, but some of these split
>> +locking programs are legacy and/or proprietary software that cannot be fixed,
>> +so using this sysctl is a way to allow them to run with a decent performance.
> 
> I think this is missing a lot of context.  End users looking here won't
> even know what a split lock *is*.  Please either refer over to the real
> documentation on this issue or write a brief description about what's
> going on.
> 
> How about this?
> 
> 	On x86, each "split lock" imposes a system-wide performance
> 	penalty.  On larger systems, large numbers of split locks from
> 	unprivileged users can result in denials of service to well-
> 	behaved and potentially more important users.
> 
> 	The kernel mitigates these bad users by detecting split locks
> 	and imposing penalties: forcing them to wait and only allowing
> 	one core to execute split locks at a time.
> 
> 	These mitigations can make those bad applications unbearably
> 	slow.  Setting split_lock_mitigate=0 may restore some
> 	application performance, but will also increase system exposure
> 	to denial of service attacks from split lock users.
> 
>> += ===================================================================
>> +0 Disables the misery mode - just warns the split lock on kernel log.
> 
> ... and exposes the system to Denial-of-Service attacks.  That's an
> awfully big side-effect to not mention.
> 
>> +1 Enables the misery mode (this is the default) - penalizes the split
>> +  lockers with intentional performance degradation.
>> += ===================================================================
> 
> As much as I love the misery terminology, let's try to use one term.
> Let's either call it "misery" *or* "mitigations", not both.
> 

OK, regarding the documentation, I'll follow your suggestion in the V3,
good stuff.


>> [...]
>> -static void __split_lock_reenable(struct work_struct *work)
>> +static void __split_lock_reenable_sem(struct work_struct *work)
>>  {
> 
> "sem" is a pretty crummy name.  Wouldn't
> 
> 	__split_lock_reenable_unlock()
> 
> be much more clear?
> 

Agreed...


>> [...]
> Better yet, do you *really* need two functions and two
> DECLARE_DELAYED_WORK()'s?
> 
> You could have a single delayed_work, and then just do:
> 
> static void split_lock_warn(unsigned long ip)
> {
> 	bool need_release_sem = false;
> 	...
> 
> 	if (down_interruptible(&buslock_sem) == -EINTR)
> 		return;
> 	need_release_sem = true;
> 
> 
> Then, farther down, you do:
> 
> 	split_lock_reenable->data = need_release_sem;
> 	schedule_delayed_work_on(cpu, &split_lock_reenable);
> 
> Then, in the work func:
> 	
> 	bool need_release_sem = work->data;
> 
> 	if (need_release_sem)
> 		up(...);
> 
> That's nice and compact.  It's also logically easy to follow because you
> can see how the need_release_sem gets set only after the
> down_interruptible().  It's also nice to have both sites share the
> 'need_release_sem' naming for grepping.
> 

...but, this is a very good suggestion, and will eliminate the need for
two delayed_works, right?


>> [...]

>> +	struct delayed_work *wk;
> 
> I think we can spare two bytes to make this "work".
> 
>> [...]
> 
> It's a little confusing to set:
> 
> 	wk = &split_lock_reenable_sem;
> 
> and then not use it.
> 
> I'd probably set it below the lock check and return.
> 
>> +	} else
>> +		wk = &split_lock_reenable;
> 
> Brackets, please:
> 
> 	} else {
> 		wk = &split_lock_reenable;
> 	}
> 
> (if you keep this hunk).
> 

But then we're back to discussing the approach of multiple delayed works.

I guess I prefer your idea of passing the state and have a single one,
will do this in V3 OK? If you or anybody else disagrees and prefer the
approach of 2 workers, let me know.

Cheers,


Guilherme
