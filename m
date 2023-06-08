Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D5728457
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjFHP44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjFHP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:56:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8330FD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:56:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686239780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pi/Ml/HjFhIPKGpG6a2XNyaJJkM+1hcuNsAqSb+ysvI=;
        b=AkNvho9aGbIFH9ExnaqkQ/NHoYh+PBS6TgybX4r4rzp2TM5xx+SuurGlPACjtvO7eFoUWp
        ARckTvITbSMyNRiKLb9F3PD94+HdxZFjCU7qWUfD5D1pO3v/WRhn/RfKvwT4vj1NNbKd1M
        y2a/oA0RnrgUqg2KY9ttJQRsVHyzEGQksyD/EILAIKZZplGMYRnYsOJNgyjwxeZ+LUu2BM
        nPsU3wPTGl5B+O79mJ+yqtMgFF7FWGfu+kyoC3laX4nk2npAu5102UA3y73mCzOEziiAyk
        fOkRX0ewY+sYY6apF9bRn4rqxWVPEuv1HF2c/oruTZEvIACshmckgu4T42uoBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686239780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pi/Ml/HjFhIPKGpG6a2XNyaJJkM+1hcuNsAqSb+ysvI=;
        b=IT85OYZI3Il+mINfOwHin88cOxJUAmW4X7Lik/zQnXJHVE2uw1JxX5V49kC8Be23tHDaGk
        JjoVSkB1DrcNnnDg==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if
 ia32_disabled is passed
In-Reply-To: <455418fb-8050-3985-5c6c-8b2068702286@citrix.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com> <871qimkdft.ffs@tglx>
 <455418fb-8050-3985-5c6c-8b2068702286@citrix.com>
Date:   Thu, 08 Jun 2023 17:56:19 +0200
Message-ID: <87v8fyhrrw.ffs@tglx>
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

On Thu, Jun 08 2023 at 12:25, Andrew Cooper wrote:
> On 08/06/2023 1:25 am, Thomas Gleixner wrote:
>> I really wish that we could disable syscall32 reliably on AMD and make
>> it raise #UD as it does on Intal.
>
> You know that's changing in FRED, and will follow the AMD model?
>
> The SYSCALL instruction is lower latency if it doesn't need to check %cs
> to conditionally #UD.

Yes, but with FRED the CPL0 context is fully consistent. There are no
CPL3 leftovers.

>> Didn't we assume that there are no CPU bugs? :)
>
> Tell me, is such a CPU delivered with or without a complimentary unicorn? :)

It's deliverd by a fairytale princess :)

Thanks,

        tglx
