Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4C6B1276
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCHTx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:53:24 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352E8497CA;
        Wed,  8 Mar 2023 11:53:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C4A4842037;
        Wed,  8 Mar 2023 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678304766;
        bh=371amrNIWdOrt1eX/rE/8QZd18kWMNJmNXDp2QdVSbs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=yGK2eXhVMDT3UcH3lltkf8vpz7BK33d21ZigE2QwncNn4koTKZf90jqyk41sFXyp/
         hCVYoec52IPuKLTdg8ImtH/hjN/ym4zWtZt5fw9ikDSLCKIEi3jIsdirbn7zRpIYwI
         sRiJ+y91O7fPhmVFFdjjSKo4af7KCCYZGexuOnmdFwyKkK5dcFL2tFdMT4pgAZpsUo
         sUt7oqPOFJNSbrS1U4HsWxouSmgeKt9R9dRHvlxLiJ0/pnfBoBUFfNbVrAANhAlqxF
         Kl7eIy+TonptlKOSkRhyAh9k4oVsIxOYVYCF56uABdqu2Tlpg4EAXwcIjXkxB8mkux
         H9MLMH0cWml/Q==
Message-ID: <9c3dc2ad-11e4-6004-7230-8ca752e3d9f7@asahilina.net>
Date:   Thu, 9 Mar 2023 04:45:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 10/18] drm/scheduler: Add can_run_job callback
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
 <20230307-rust-drm-v1-10-917ff5bc80a8@asahilina.net>
 <cd788ccf-0cf1-85d5-1bf8-efc259bd7e11@amd.com>
 <a075d886-0820-b6fb-fcd0-45bfdc75e37d@asahilina.net>
 <2b1060e9-86ba-7e16-14f1-5b5fa63de719@amd.com>
 <9f76bb68-b462-b138-d0ad-d27c972530d4@asahilina.net>
 <a39c6b40-f190-002d-ae1c-8b58c6442df2@amd.com>
 <4bbfc1a3-cfc3-87f4-897b-b6637bac3bd0@asahilina.net>
 <b0aa78b2-b432-200a-8953-a80c462fa6ee@amd.com>
 <c0624252-070e-bd44-2116-93a1d63a1359@asahilina.net>
 <d1fccceb-ca77-f653-17fc-63168e0da884@amd.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <d1fccceb-ca77-f653-17fc-63168e0da884@amd.com>
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

On 09/03/2023 04.12, Christian König wrote:
> Am 08.03.23 um 20:05 schrieb Asahi Lina:
>> [SNIP]
>>> Well it's not the better way, it's the only way that works.
>>>
>>> I have to admit that my bet on your intentions was wrong, but even that
>>> use case doesn't work correctly.
>>>
>>> See when your callback returns false it is perfectly possible that all
>>> hw fences are signaled between returning that information and processing it.
>>>
>>> The result would be that the scheduler goes to sleep and never wakes up
>>> again.
>> That can't happen, because it will just go into another iteration of the
>> drm_sched main loop since there is an entity available still.
>>
>> Rather there is probably the opposite bug in this patch: the can_run_job
>> logic should be moved into the wait_event_interruptible() condition
>> check, otherwise I think it can end up busy-looping since the condition
>> itself can be true even when the can_run_job check blocks it.
>>
>> But there is no risk of it going to sleep and never waking up because
>> job completions will wake up the waitqueue by definition, and that
>> happens after the driver-side queues are popped. If this problem could
>> happen, then the existing hw_submission_limit logic would be broken in
>> the same way. It is logically equivalent in how it works.
>>
>> Basically, if properly done in wait_event_interruptible, it is exactly
>> the logic of that macro that prevents this race condition and makes
>> everything work at all. Without it, drm_sched would be completely broken.
>>
>>> As I said we exercised those ideas before and yes this approach here
>>> came up before as well and no it doesn't work.
>> It can never deadlock with this patch as it stands (though it could busy
>> loop), and if properly moved into the wait_event_interruptible(), it
>> would also never busy loop and work entirely as intended. The actual API
>> change is sound.
>>
>> I don't know why you're trying so hard to convince everyone that this
>> approach is fundamentally broken... It might be a bad idea for other
>> reasons, it might encourage incorrect usage, it might not be the best
>> option, there are plenty of arguments you can make... but you just keep
>> trying to make an argument that it just can't work at all for some
>> reason. Why? I already said I'm happy dropping it in favor of the fences...
> 
> Well because it is broken.
> 
> When you move the check into the wait_event_interruptible condition then 
> who is going to call wait_event_interruptible when the condition changes?

I think you mean wake_up_interruptible(). That would be
drm_sched_job_done(), on the fence callback when a job completes, which
as I keep saying is the same logic used for
hw_rq_count/hw_submission_limit tracking.

Please think about it for a second, it's really not that complicated to
see why it works:

- Driver pops off completed commands <-- can_run_job condition satisfied
- Driver signals fence
 - drm_sched_job_done_cb()
  - drm_sched_job_done()
   - atomic_dec(&sched->hw_rq_count); <-- hw_submission_limit satisfied
   - ...
   - wake_up_interruptible(&sched->wake_up_worker);
      ^- happens after both conditions are potentially satisfied

It really is completely equivalent to just making the hw_rq_count logic
customizable by the driver. The actual flow is the same. As long as the
driver guarantees it satisfies the can_run_job() condition before
signaling the completion fence that triggered that change, it works fine.

> As I said this idea came up before and was rejected multiple times.

Maybe it was a different idea, or maybe it was rejected for other
reasons, or maybe it was wrongly rejected for being broken when it isn't ^^

~~ Lina
