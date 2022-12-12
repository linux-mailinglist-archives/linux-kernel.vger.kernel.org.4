Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A22464A3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiLLOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLLOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:43:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F06424;
        Mon, 12 Dec 2022 06:43:46 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670856225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mc//3PLDbSRDt2VwTyd9NngL7trzTV+j6zIM1+K7Tks=;
        b=q3OL99uE092Nlh5tXBUVTqa/DPFN1PxY+r2Z0hOZyNDVlu6BPBsR4UmfSDtaX9W9YbxMlQ
        Jn6eZqLbCxXlfvvhQRcGvR/z7me3z5R+YSskUUh6/kLJ2+PGy1soXStLFavf1/+taBIfap
        XqndSH5Kge4pf+Ze0I91vHXR+ZF9akmzsf31zKhbv7Y3wYVOE4jDwOopu62LTXT5gwqKrd
        wTEcty6JdvkaLh6GKYfRqI7DROKe/zUxVDrrerNeDJBrMs780QR8vkS3pcXNuNUBZp/RTl
        4kQroOUv5DBWtuLxGBU2w4wfHwVm4ACpr2RfvNMnLgizaY6zuHmM/gGdz6y2QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670856225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mc//3PLDbSRDt2VwTyd9NngL7trzTV+j6zIM1+K7Tks=;
        b=9gQCHhH8BwNCaimjXcwY4KzobwZ0tI10wE/N9lUSET3pYfDLCcfvr1O79wE8CRjubphd7j
        SwbKST2MIv2kqXAA==
To:     Manfred Spraul <manfred@colorfullife.com>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1vier1@web.de
Subject: Re: Invalid locking pattern in
 Documentation/kernel-hacking/locking.rst?
In-Reply-To: <be5a4c10-3b69-1c2d-d413-62f79ccc178b@colorfullife.com>
References: <442ecdf402f8e726f2be4ab19c7299d272e27c0b.camel@siemens.com>
 <be5a4c10-3b69-1c2d-d413-62f79ccc178b@colorfullife.com>
Date:   Mon, 12 Dec 2022 15:43:44 +0100
Message-ID: <87k02wbs2n.ffs@tglx>
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

On Fri, Dec 09 2022 at 19:47, Manfred Spraul wrote:
> On 12/9/22 13:23, Sverdlin, Alexander wrote:
>> the latest version of locking.rst contains the following (since 2005):
>>
>> "Manfred Spraul points out that you can still do this, even if the data
>> is very occasionally accessed in user context or softirqs/tasklets. The
>> irq handler doesn't use a lock, and all other accesses are done as so::
>>
>>          spin_lock(&lock);
>>          disable_irq(irq);
>> "
>>
>> Isn't it "sleeping in atomic" actually because of the sleeping
>> disable_irq()?
>
> Good catch!
>
> The documentation of disable_irq() claims that the function is safe to 
> be called from IRQ context (for careful callers)
>
> But it calls synchronize_irq(). And synchronize_irq() claims that the 
> function can be called only from preemptible code.
>
> The change was in 2009:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.1-rc8&id=3aa551c9b4c40018f0e261a178e3d25478dc04a9 
>
>
> @Thomas/@Ingo: What do we want?
>
> Declare disable_irq()&synchronize_irq() as safe from irq context only if 
> no threaded irq handlers are used?
>
> Or declare both function as preemptible context only?

The latter.

The comment for disable_irq() needs to go away too:

 "This function may be called - with care - from IRQ context."

Obviously it can't be called from the interrupt context which it
tries to disable as it will live-lock on the "in progress" flag.

So that leaves the option to call it from some unrelated interrupt
context which does not make much sense. In fact, back in the days when
this comment was added it was still allowed to reenable interrupts in
the interrupt handler, which obviously opens the window for some other
interrupt to come in which then tries to disable the one it just
interrupted. Not an issue anymore, but the synchronize_irq() change to
handle threaded interrupts made it more or less impossible.

Thanks,

        tglx



