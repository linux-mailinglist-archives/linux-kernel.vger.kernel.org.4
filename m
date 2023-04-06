Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A06D91F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjDFIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjDFIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:49:26 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E784ED2;
        Thu,  6 Apr 2023 01:49:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B3E3042494;
        Thu,  6 Apr 2023 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680770962;
        bh=ggui/OxqvP63DzMm5qyXgF7uzlNIBbSwugFjqlei62I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZeyPidK4cXdxOVmtY7dDfxefJlBru4dsyuAwR0SdSKuUn0qf8JQuKuM8iMZHAD0+s
         nW6AJwRR6BQMhkOk2/unsVeCWPBQisrsZyt262i9KhjOAu6ylsglGv+hmnJeCJQnSq
         C1YWodRkWstWcNpGA8by8wYAjXUG3XdZDia06Bq58tPnH+JM2nFJG2cQ05TCTxcfba
         4JNMtI7SWdYUAbCUPxWMRTxMjYfjkaor8HY1Fvu6E+2GKJOg+QWFQ/o6drzHThzG6y
         /SujIjVBgZhmXDyeZ+POd24kWtrk5+T5t+IVuSHIKmAnkrPIW5hGnxgLhLKNXM7pKb
         BBoNaYbAQLGbQ==
Message-ID: <cfbaceae-6d40-a8b3-e449-6473be234d2d@asahilina.net>
Date:   Thu, 6 Apr 2023 17:49:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/scheduler: Fix UAF in
 drm_sched_fence_get_timeline_name
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
References: <20230406-scheduler-uaf-1-v1-1-8e5662269d25@asahilina.net>
 <6b3433ee-0712-f789-51ee-3047ead9bb79@amd.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <6b3433ee-0712-f789-51ee-3047ead9bb79@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 17.29, Christian König wrote:
> Am 05.04.23 um 18:34 schrieb Asahi Lina:
>> A signaled scheduler fence can outlive its scheduler, since fences are
>> independently reference counted.
> 
> Well that is actually not correct. Schedulers are supposed to stay
> around until the hw they have been driving is no longer present.

But the fences can outlive that. You can GPU render into an imported 
buffer, which attaches a fence to it. Then the GPU goes away but the 
fence is still attached to the buffer. Then you oops when you cat that 
debugfs file...

My use case does this way more often (since schedulers are tied to UAPI 
objects), which is how I found this, but as far as I can tell this is 
already broken for all drivers on unplug/unbind/anything else that would 
destroy the schedulers with fences potentially referenced on separate 
scanout devices or at any other DMA-BUF consumer.

> E.g. the reference was scheduler_fence->hw_fence->driver->scheduler.

It's up to drivers not to mess that up, since the HW fence has the same 
requirements that it can outlive other driver objects, just like any 
other fence. That's not something the scheduler has to be concerned 
with, it's a driver correctness issue.

Of course, in C you have to get it right yourself, while with correct 
Rust abstractions will cause your code to fail to compile if you do it 
wrong ^^

In my particular case, the hw_fence is a very dumb object that has no 
references to anything, only an ID and a pending op count. Jobs hold 
references to it and decrement it until it signals, not the other way 
around. So that object can live forever regardless of whether the rest 
of the device is gone.

> Your use case is now completely different to that and this won't work
> any more.
> 
> This here might just be the first case where that breaks.

This bug already exists, it's just a lot rarer for existing use cases... 
but either way Xe is doing the same thing I am, so I'm not the only one 
here either.

~~ Lina

