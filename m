Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB016B033C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCHJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCHJmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:42:02 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3CCB56D9;
        Wed,  8 Mar 2023 01:41:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C77F841DF4;
        Wed,  8 Mar 2023 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678268501;
        bh=vBxMB571C2rYbZLVgeBfcGW/6kjKGp2NbaNwD343XB8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CZvuPPNTVPZ5UeTvxDAPbq9istc0FQHAa695VyMpBbgJYwBKq3BYCxH5vGYEznwtD
         UsWvCb0Ck28/YE43ouuknNNtGFuJNUkPqCqzeTq0B0WPCl3ukEFiPQ6YtGUBmgH6FP
         JVxP/pFvVRc7toKHMIxyf/6IBkguOIsyZLC3baI8xwmQVvp2ZAZUWBaWDGdY7Lp2u8
         7NRARO6WbHzFBDxxIcKxob80EOdD2n5kb7qWnM6/OipZBy36VF9gJQUUpOm8fOOoFw
         6pGiB0Lx3DCNA5Xv/Xq8ckvcr4AF7O0bnR2ObjTc6cxxhcJXFAYmvJlvCXiMctnt6v
         nxYUr1kjdPP2g==
Message-ID: <a075d886-0820-b6fb-fcd0-45bfdc75e37d@asahilina.net>
Date:   Wed, 8 Mar 2023 18:41:32 +0900
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
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <cd788ccf-0cf1-85d5-1bf8-efc259bd7e11@amd.com>
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

On 08/03/2023 17.46, Christian König wrote:
> Am 07.03.23 um 15:25 schrieb Asahi Lina:
>> Some hardware may require more complex resource utilization accounting
>> than the simple job count supported by drm_sched internally. Add a
>> can_run_job callback to allow drivers to implement more logic before
>> deciding whether to run a GPU job.
> 
> Well complete NAK.
> 
> This is clearly going against the idea of having jobs only depend on 
> fences and nothing else which is mandatory for correct memory management.
> 
> If the hw is busy with something you need to return the fence for this 
> from the prepare_job callback so that the scheduler can be notified when 
> the hw is available again.

I think you misunderstood the intent here... This isn't about job
dependencies, it's about in-flight resource limits.

drm_sched already has a hw_submission_limit that specifies the number of
submissions that can be in flight, but that doesn't work for us because
each job from drm_sched's point of view consists of multiple commands
split among 3 firmware queues. The firmware can only support up to 128
work commands in flight per queue (barriers don't count), otherwise it
overflows a fixed-size buffer.

So we need more complex accounting of how many underlying commands are
in flight per queue to determine whether it is safe to run a new job,
and that is what this callback accomplishes. This has to happen even
when individual jobs have no buffer/resource dependencies between them
(which is what the fences would express).

You can see the driver implementation of that callback in
drivers/gpu/drm/asahi/queue/mod.rs (QueueJob::can_run()), which then
calls into drivers/gpu/drm/asahi/workqueue.rs (Job::can_submit()) that
does the actual available slot count checks.

The can_run_job logic is written to mirror the hw_submission_limit logic
(just a bit later in the sched main loop since we need to actually pick
a job to do the check), and just like for that case, completion of any
job in the same scheduler will cause another run of the main loop and
another check (which is exactly what we want here).

This case (potentially scheduling more than the FW job limit) is rare
but handling it is necessary, since otherwise the entire job
completion/tracking logic gets screwed up on the firmware end and queues
end up stuck (I've managed to trigger this before).

~~ Lina
