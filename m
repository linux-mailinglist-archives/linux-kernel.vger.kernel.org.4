Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527C073EE93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjFZWSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFZWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:18:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4A793
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:18:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687817909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pq/278w4iPtQ/1zu8/UxhpVibR0HxFF7LZ7PyP6/uDk=;
        b=oUamhx0rLt4dcw/AQ3qg+MgT76iLEVTGRKZhmAqGkYxpGFk5a+wq9uJymebAd9vTLwlCwq
        PBCXaDakbpjF7gfUoxQ/GUNbFT/Fez+w5a7qb4T+I6pFlPsm6VHAuJKScP6LDUaDCQ4O+B
        h9bre/C6lGbHttiIUPChB2nDo0yB6Jbec52Q0Qr9hqESsdIG8vQ/1eOXDQUmhevVsHhWbE
        4u9iqYCR9h25+LtrT0Dp1Tek0Q0+THZNO6peap+BLmbhYoiYbECFEVB7bhg1xL3wtadCBb
        yOAcswjsf6gpb0OUGp8lTQ1cKJm4wFh6Wu9IH4zHb8rcnYrpOnq98fxPDQtROQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687817909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pq/278w4iPtQ/1zu8/UxhpVibR0HxFF7LZ7PyP6/uDk=;
        b=F0WSs03MlycwNPxgn8BcKucWNc1MWQPuHAO4NcExLpLa+aK+gKx1mBYV9+5qwJRveuscLD
        Y9TWCupbAOSMrJDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] x86/core for v6.5-rc1
In-Reply-To: <CAHk-=wgoVt9izQi2iA3F8PZbnmT+r4CcqaHp+FhEozSj2D=UFg@mail.gmail.com>
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz>
 <168778151644.3634408.18311962903658740097.tglx@vps.praguecc.cz>
 <CAHk-=wgoVt9izQi2iA3F8PZbnmT+r4CcqaHp+FhEozSj2D=UFg@mail.gmail.com>
Date:   Tue, 27 Jun 2023 00:18:28 +0200
Message-ID: <87zg4l50ln.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus!

On Mon, Jun 26 2023 at 15:00, Linus Torvalds wrote:
> On Mon, 26 Jun 2023 at 05:14, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> This conflicts with smp/core and x86/boot. The recommended ordering of
>> merging these three branches is smp/core, x86/boot, x86/core.
>>
>> The x86/boot and final x86/core merge have both subtle conflicts. I've
>> pushed out the following tags:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git merge_smp_core_x86_boot_for_6_5
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git merge_smp_core_x86_boot_x86_core_for_6_5
>>
>> for your conveniance to check against.
>
> Bah. I read this after I had already done the merges in a different
> order, and my result is a bit different from your merges.

I see you started with x86/boot, which has a similar note. I clearly
missed to add one to smp/core :)

> All my differences seem to be benign, though. The main one seems to be
> that I kept a preempt_disable/preempt_enable pair in
> wakeup_secondary_cpu_via_init(), the others seem to be just comments
> and declaration ordering changes.

That's fine. I do the comment fixup and the preempt_*able() removal in a
follow up.

> Still, you might want to double-check the end result.

Other than the cosmetic issues you noticed yourself, it's all good.

Thanks,

        tglx
