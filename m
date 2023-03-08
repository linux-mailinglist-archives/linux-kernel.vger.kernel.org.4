Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12F16B121D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCHThn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCHThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:37:41 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298D0BE5FB;
        Wed,  8 Mar 2023 11:37:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 04F8542037;
        Wed,  8 Mar 2023 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678304256;
        bh=bGSmqve6Q1FPtd+ajYOJkWVDvwsz5IUECf9DYdAEDq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=l3KAZBz67DIrADlxVjsP9aADwc9MBYSxeSyma5bbE93n86EbwmPw9vWiJXjtisZ0q
         avjhhsIer/a3PCMUONJ3FCN5X2lotXnD4Idi4OAu7A4RRMj01UltcWD6a7t71cLIIj
         vuJtJEqAfbJatpwrhRFu3viIJ9h7Oh+qvHoElRhHBHiSB/oZaK0qfAq7YmBlcJNCs6
         VUShYYsOqisv5556rqHxCkLcPWxWCdiQGeDbXo5DaAcIEabW+7FrzTFwSut4xDgVHh
         FRT3wP9tWXZZ2sOcN2Mp8wSumycilGPywC3ixe22hABaSyK1G7Ma4p6sMQGVCQe2aF
         RqTsnWpyB/Zyw==
Message-ID: <8696d00a-c642-b080-c19a-b0e619e4b585@asahilina.net>
Date:   Thu, 9 Mar 2023 04:37:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 11/18] drm/scheduler: Clean up jobs when the scheduler
 is torn down
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-11-917ff5bc80a8@asahilina.net>
 <bbd7c5ee-c2f0-3e19-757d-a9aff1a26d3d@linux.intel.com>
 <585fa052-4eff-940e-b307-2415c315686a@amd.com>
 <3320e497-09c0-6eb6-84c5-bab2e63f28ec@asahilina.net>
 <7b39ef96-3ec5-c492-6e1b-bf065b7c90a2@amd.com>
 <0f14c1ae-0c39-106c-9563-7c1c672154c0@asahilina.net>
 <e18500b5-21a0-77fd-8434-86258cefce5a@amd.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <e18500b5-21a0-77fd-8434-86258cefce5a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 03.12, Christian König wrote:
> Am 08.03.23 um 18:32 schrieb Asahi Lina:
>> [SNIP]
>> Yes but... none of this cleans up jobs that are already submitted by the
>> scheduler and in its pending list, with registered completion callbacks,
>> which were already popped off of the entities.
>>
>> *That* is the problem this patch fixes!
> 
> Ah! Yes that makes more sense now.
> 
>>> We could add a warning when users of this API doesn't do this
>>> correctly, but cleaning up incorrect API use is clearly something we
>>> don't want here.
>> It is the job of the Rust abstractions to make incorrect API use that
>> leads to memory unsafety impossible. So even if you don't want that in
>> C, it's my job to do that for Rust... and right now, I just can't
>> because drm_sched doesn't provide an API that can be safely wrapped
>> without weird bits of babysitting functionality on top (like tracking
>> jobs outside or awkwardly making jobs hold a reference to the scheduler
>> and defer dropping it to another thread).
> 
> Yeah, that was discussed before but rejected.
> 
> The argument was that upper layer needs to wait for the hw to become 
> idle before the scheduler can be destroyed anyway.

Unfortunately, that's not a requirement you can encode in the Rust type
system easily as far as I know, and Rust safety rules mean we need to
make it safe even if the upper layer doesn't do this... (or else we have
to mark the entire drm_sched abstraction unsafe, but that would be a pity).

I know it's a different way of thinking, but it has pretty clear
benefits since with Rust you can actually guarantee that things are safe
overall by just auditing explicitly unsafe code. If we just mark all of
drm_sched unsafe, that means we now need to audit all details about how
the driver uses it for safety. It makes more sense to just make the
abstraction safe, which is much easier to audit.

>>>> Right now, it is not possible to create a safe Rust abstraction for
>>>> drm_sched without doing something like duplicating all job tracking in
>>>> the abstraction, or the above backreference + deferred cleanup mess, or
>>>> something equally silly. So let's just fix the C side please ^^
>>> Nope, as far as I can see this is just not correctly tearing down the
>>> objects in the right order.
>> There's no API to clean up in-flight jobs in a drm_sched at all.
>> Destroying an entity won't do it. So there is no reasonable way to do
>> this at all...
> 
> Yes, this was removed.
> 
>>> So you are trying to do something which is not supposed to work in the
>>> first place.
>> I need to make things that aren't supposed to work impossible to do in
>> the first place, or at least fail gracefully instead of just oopsing
>> like drm_sched does today...
>>
>> If you're convinced there's a way to do this, can you tell me exactly
>> what code sequence I need to run to safely shut down a scheduler
>> assuming all entities are already destroyed? You can't ask me for a list
>> of pending jobs (the scheduler knows this, it doesn't make any sense to
>> duplicate that outside), and you can't ask me to just not do this until
>> all jobs complete execution (because then we either end up with the
>> messy deadlock situation I described if I take a reference, or more
>> duplicative in-flight job count tracking and blocking in the free path
>> of the Rust abstraction, which doesn't make any sense either).
> 
> Good question. We don't have anybody upstream which uses the scheduler 
> lifetime like this.
> 
> Essentially the job list in the scheduler is something we wanted to 
> remove because it causes tons of race conditions during hw recovery.
> 
> When you tear down the firmware queue how do you handle already 
> submitted jobs there?

The firmware queue is itself reference counted and any firmware queue
that has acquired an event notification resource (that is, which is busy
with running or upcoming jobs) hands off a reference to itself into the
event subsystem, so it can get notified of job completions by the
firmware. Then once it becomes idle it unregisters itself, and at that
point if it has no owning userspace queue, that would be the last
reference and it gets dropped. So we don't tear down firmware queues
until they are idle.

(There is a subtle deadlock break in the event module to make this work
out, where we clone a reference to the queue and drop the event
subsystem lock before signaling it of completions, so it can call back
in and take the lock as it unregisters itself if needed. Then the actual
teardown happens when the signaling is complete and that reference clone
is the last one to get dropped.)

If a queue is idle at the firmware level but has upcoming jobs queued in
drm_sched, when those get deleted as part of an explicit drm_sched
teardown (free_job()) the queue notices it lost its upcoming jobs and
relinquishes the event resource if there are no running jobs. I'm not
even sure exactly what order this all happens in in practice (it depends
on structure field order in Rust!), but it doesn't really matter because
either way everything gets cleaned up one way or another.

I actually don't know of any way to actively abort jobs on the firmware,
so this is pretty much the only option I have. I've even seen
long-running compute jobs on macOS run to completion even if you kill
the submitting process, so there might be no way to do this at all.
Though in practice since we unmap everything from the VM anyway when the
userspace stuff gets torn down, almost any normal GPU work is going to
immediately fault at that point (macOS doesn't do this because macOS
effectively does implicit sync with BO tracking at the kernel level...).

By the way, I don't really use the hardware recovery stuff right now.
I'm not even sure if there is a sensible way I could use it, since as I
said we can't exactly abort jobs. I know there are ways to lock up the
firmware/GPU, but so far those have all been things the kernel driver
can prevent, and I'm not even sure if there is any way to recover from
that anyway. The firmware itself has its own timeouts and recovery for
"normal" problems. From the point of view of the driver and everything
above it, in-flight commands during a GPU fault or timeout are just
marked complete by the firmware, after a firmware recovery cycle where
the driver gets notified of the problem (that's when we mark the
commands failed so we can propagate the error). There is no
re-submission or anything, userspace just gets told of the problem but
the queue survives. In the future it might be possible to re-submit
innocent commands (it is possible for a GPU fault to break another
process running concurrently, and this is a problem macOS has too...),
which is still not perfect due to side effects but might work most of
the time, but that depends on the "command patching" stuff I mentioned,
and I'm still not even sure if it will be possible to do safely. There's
a lot of subtlety around what we can and can't do during a firmware
recovery cycle that I haven't even started to investigate yet (the
answer could be "nothing" even).

~~ Lina
