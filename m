Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B170873EFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjF0Abr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjF0Abp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:31:45 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE5F1703;
        Mon, 26 Jun 2023 17:31:44 -0700 (PDT)
Received: from [10.8.192.2] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 298E53F25A;
        Tue, 27 Jun 2023 00:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687825901;
        bh=ZJuKj+u/iaHfpnToK3Hjz8WAqXefP5JdPosEoq9MmW4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=hboEUQu9s70yZcXCgpqK7RsTvsmD1KKk6A42+uK2cx4xuDA16YR2zAprJexV4ERKq
         bg4NTT5XrXrUkS6miJy88A3SP7ANqZKZzxJqRAhp5mcKjWpUJpGxXWZoz/anMbmy8k
         VpPdPGpNLeo4MwC5Fdj5SgiaC3SgF6TSONL4PHzj213BbaW45q15YeF3wNH8L6vOEX
         /3FngaWH7uvmGm9ADjtt9wu2L0XwLgisu5JEBZoP9NjesrnO9V0MAb1Km0Pen5HWuA
         YDc8oxJn39tJmdBKy8TrB7dUoj+8MYL7TCksiCVI5yRjle7CN1G/n1SF/KPEzhMgzF
         +lNHe2xdaFynw==
Message-ID: <31d6e8d6-0747-a282-746b-5c144a9970bb@canonical.com>
Date:   Mon, 26 Jun 2023 17:31:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] apparmor: global buffers spin lock may get contended
Content-Language: en-US
To:     Anil Altinay <aaltinay@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKLM <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
 <Y+9aoFjrYkpFSvuE@linutronix.de>
 <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com>
 <CACCxZWOK6=mHNQrWEhjw4pC2i3qBKYdn9joiaaCNE7ge8FAz0A@mail.gmail.com>
 <CACCxZWO-+M-J_enENr7q1WDcu1U8vYFoytqJxAh=x-nuP268zA@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CACCxZWO-+M-J_enENr7q1WDcu1U8vYFoytqJxAh=x-nuP268zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 16:33, Anil Altinay wrote:
> Hi John,
> 
> I was wondering if you get a chance to work on patch v4. Please let me know if you need help with testing.
> 

yeah, testing help is always much appreciated. I have a v4, and I am working on 3 alternate version to compare against, to help give a better sense if we can get away with simplifying or tweak the scaling. I should be able to post them out some time tonight.

> Best,
> Anil
> 
> On Tue, Feb 21, 2023 at 1:27 PM Anil Altinay <aaltinay@google.com <mailto:aaltinay@google.com>> wrote:
> 
>     I can test the patch with 5.10 and 5.15 kernels in different machines.
>     Just let me know which machine types you would like me to test.
> 
>     On Mon, Feb 20, 2023 at 12:42 AM John Johansen
>     <john.johansen@canonical.com <mailto:john.johansen@canonical.com>> wrote:
>      >
>      > On 2/17/23 02:44, Sebastian Andrzej Siewior wrote:
>      > > On 2023-02-16 16:08:10 [-0800], John Johansen wrote:
>      > >> --- a/security/apparmor/lsm.c
>      > >> +++ b/security/apparmor/lsm.c
>      > >> @@ -49,12 +49,19 @@ union aa_buffer {
>      > >>      char buffer[1];
>      > >>   };
>      > >> +struct aa_local_cache {
>      > >> +    unsigned int contention;
>      > >> +    unsigned int hold;
>      > >> +    struct list_head head;
>      > >> +};
>      > >
>      > > if you stick a local_lock_t into that struct, then you could replace
>      > >       cache = get_cpu_ptr(&aa_local_buffers);
>      > > with
>      > >       local_lock(&aa_local_buffers.lock);
>      > >       cache = this_cpu_ptr(&aa_local_buffers);
>      > >
>      > > You would get the preempt_disable() based locking for the per-CPU
>      > > variable (as with get_cpu_ptr()) and additionally some lockdep
>      > > validation which would warn if it is used outside of task context (IRQ).
>      > >
>      > I did look at local_locks and there was a reason I didn't use them. I
>      > can't recall as the original iteration of this is over a year old now.
>      > I will have to dig into it again.
>      >
>      > > I didn't parse completely the hold/contention logic but it seems to work
>      > > ;)
>      > > You check "cache->count >=  2" twice but I don't see an inc/ dec of it
>      > > nor is it part of aa_local_cache.
>      > >
>      > sadly I messed up the reordering of this and the debug patch. This will be
>      > fixed in v4.
>      >
>      > > I can't parse how many items can end up on the local list if the global
>      > > list is locked. My guess would be more than 2 due the ->hold parameter.
>      > >
>      > So this iteration, forces pushing back to global list if there are already
>      > two on the local list. The hold parameter just affects how long the
>      > buffers remain on the local list, before trying to place them back on
>      > the global list.
>      >
>      > Originally before the count was added more than 2 buffers could end up
>      > on the local list, and having too many local buffers is a waste of
>      > memory. The count got added to address this. The value of 2 (which should
>      > be switched to a define) was chosen because no mediation routine currently
>      > uses more than 2 buffers.
>      >
>      > Note that this doesn't mean that more than two buffers can be allocated
>      > to a tasks on a cpu. Its possible in some cases to have a task have
>      > allocated buffers and to still have buffers on the local cache list.
>      >
>      > > Do you have any numbers on the machine and performance it improved? It
>      > > sure will be a good selling point.
>      > >
>      >
>      > I can include some supporting info, for a 16 core machine. But it will
>      > take some time to for me to get access to a bigger machine, where this
>      > is much more important. Hence the call for some of the other people
>      > on this thread to test.
>      >
>      > thanks for the feedback
>      >
> 

