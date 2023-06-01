Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC72671F370
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjFAUKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFAUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:10:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3D134;
        Thu,  1 Jun 2023 13:10:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685650245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chRIhlGc1ewVpa0H2/yhfREyLjRPBthRnCPNhZqy3w4=;
        b=EqHSk8bEiOWSuwySTSmsQgtq830ssjROGQtit5HNEHYJ/gjR34yN8yXUz7ZMRh/Qnz3bsX
        3q/i/8ubGcuRoJ9LNSOm4tE6yCne0OUWv7MBaao8tXdHM6EZkZUmK41E8orcToCH6B5LK7
        Lmrcag+YuWD231i7hncnKtyPl2gvKJ78IKeMCI9gshnm6QdKevb0EZTNqShOV8AD8IiVcl
        A1ru55rc0KpZTSV2CCf3S3ot8HR9GgiqOUILX/9fN/a/g8aZMRL8PrNgPR9x3YmDzfH5Dt
        wgt12ihLEiy0/bVOzA41ZBMVyo2LuqhWOSBwWr2XKLDoM8BzfTK3qOgmTC2zZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685650245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chRIhlGc1ewVpa0H2/yhfREyLjRPBthRnCPNhZqy3w4=;
        b=17MZUD2EjWUZBS3/xwGd6iUUcbbrPxMb6Kq6j0xq9Ck8dwTyIwKe7JOvBAYABUorn99+vq
        wiodoJbf/sg1+ICg==
To:     Steven Noonan <steven@uplinklabs.net>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
In-Reply-To: <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <87mt1jeax1.ffs@tglx> <87h6rrdoy0.ffs@tglx>
 <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
Date:   Thu, 01 Jun 2023 22:10:45 +0200
Message-ID: <871qivdjui.ffs@tglx>
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

On Thu, Jun 01 2023 at 19:07, Steven Noonan wrote:
> On Thursday, June 1st, 2023 at 11:20 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Here is an example where it falls flat on its nose.
>> 
>> One of the early Ryzen laptops had a broken BIOS which came up with
>> unsynchronized TSCs. I tried to fix that up, but couldn't get it to sync
>> on all CPUs because for some stupid reason the TSC write got
>> arbritrarily delayed (assumably by SMI/SMM).
>
> Hah, I remember that. That was actually my laptop. A Lenovo ThinkPad
> A485 with a Ryzen 2700U. I've seen the problem since then occasionally
> on newer Ryzen laptops (and even desktops). Without the awful
> "tsc=directsync" patch I wrote, which I've been carrying for years now
> in my own kernel builds, it just falls back to HPET. It's not
> pleasant, but at least it's a stable clock.

Well, yours seem at least to sync. The silly box I tried refused due to
SMM value add magic.

> Agreed, TSC_ADJUST is the ultimate solution for any of these kinds of
> issues. But last I heard from AMD, it's still several years out in
> silicon, and there's plenty of hardware to maintain compatibility
> with. Ugh.

Yes.

> A software solution would be preferable in the meantime, but I don't
> know what options are left at this point.

Not that many.

> The trap-and-emulate via SIGSEGV approach proposed earlier in the
> thread is unfortunately not likely to be practical, assuming I
> implemented it properly.

That's why I said we need to ask Microsoft to do the same so that the
applications get fixed. :)

> Most Windows games that use this instruction directly are doing so
> under the assumption that the TSC is faster to read than any of the
> native Windows API clock sources.

The recommended interface QueryPerformanceCounter() is actually not much
slower and safe. But sure performance first and correctness is overrated.

So back to the options:

   1) Kernel

      If at all then this needs to be disabled by default and enabled by
      a command line option along with a big fat warning that it might
      disable TSC for timekeeping and bug reports related to this are
      going to be ignored.

      Honestly I'm not too interested in this. It's yet another piece of
      art which needs to be maintained and kept alive for a long time.

      The fact that we need to check for synchronized TSCs in the first
      place is hillarious already. TSC_ADJUST makes the resynchronization
      attempt at least halfways sensible.

      Without it, it's just a pile of never going to be correct
      heuristics with a flood of "this fixes it for my machine (and
      breaks the rest)" patches.


   2) Binary patching

      Unfortunately RDTSC is only a two byte instruction, but there are
      enough advanced binary patching tools to deal with that.

      It might be a completely crazy idea, but I wouldn't dismiss it
      before trying.

Thanks,

        tglx

      
      
