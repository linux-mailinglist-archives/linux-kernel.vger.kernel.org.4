Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6255D6540FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiLVMbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiLVMbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:31:15 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA093A47A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:31:13 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p8KjA-0002nv-4B; Thu, 22 Dec 2022 13:31:12 +0100
Message-ID: <28c5c38b-de13-b2b5-0ffa-8a08d96391df@leemhuis.info>
Date:   Thu, 22 Dec 2022 13:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [6.2][regression] looks like commit
 aab9cf7b6954136f4339136a1a7fc0602a2c4d8b leads to use-after-free and random
 computer hangs
Content-Language: en-US, de-DE
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        luben.tuikov@amd.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CABXGCsNryN9Koz48DiSTPwTBSOKo0U0B3PnW3+gEf2B8n8u0GA@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CABXGCsNryN9Koz48DiSTPwTBSOKo0U0B3PnW3+gEf2B8n8u0GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671712273;4f67854b;
X-HE-SMSGID: 1p8KjA-0002nv-4B
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 18.12.22 14:28, Mikhail Gavrilov wrote:
>
> The kernel 6.2 preparation cycle has begun.
> And after the kernel was updated on my Fedora Rawhide I started
> receiving use-after-free errors with complete computer hangs.
> At least a good reproducer of this behaviour is launch of the game
> "Marvel's Avengers".
> 
> The backtrace of the issue looks like:
> [...]

Thx for your report. I'm not one of the developers for this area of the
kernel, but to my untrained eyes it looks like this patch might fix your
problem:

https://lore.kernel.org/all/20221219104718.21677-1-christian.koenig@amd.com/

Anyway, to be sure the issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced aab9cf7b695413
#regzbot title drm: amdgpu: use-after-free and random computer hangs
#regzbot monitor:
https://lore.kernel.org/all/20221219104718.21677-1-christian.koenig@amd.com/
#regzbot fix: drm/amdgpu: grab extra fence reference for
drm_sched_job_add_dependency
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
