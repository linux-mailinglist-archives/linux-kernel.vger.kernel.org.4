Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219BE7270BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjFGVwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjFGVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:52:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD141FFE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:52:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686174722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/D9r9Rsx5h2WLwSswODEIs7Q/AeCFP+mmWk4qws3RY=;
        b=MNpVAEBkBygHg8Nu5K1Oe3/3ieh5/cUm/RVG1epO+qnPm7Odt9satWLarHBDTLKoudaqeH
        k4YSShxUZk3+nDZT8i/X4fJD54L2c1iCNnqRLZlW8UPZ409UAsNDgQh3JqupI9zy4mSTBU
        OlobqPDX8XAZSLKc0y1lRNO5nWuLeGcORhV9JCqVgLAQlv7bucmAeW7a2qnkXOqgl8vM23
        BcOXDLbB3V+e+LvyN1Dfi0HHQVt8CYRHpfZg52g6ByKyMTtcj8Adiu9mJC/OOdZfLsBWIK
        GGfZW0+BcyEj1+Qz57aY/fmN+nFqA1jtnNQziZzI/H8GzmfnRvLTyQRYgHbMyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686174722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/D9r9Rsx5h2WLwSswODEIs7Q/AeCFP+mmWk4qws3RY=;
        b=9Zhy/OiZgYfcATlQ7eXNeuD0kBX6BJTYoKWAlcEkkB2Edhh3KwuA9XlbBq+MdNAk2eyJyl
        avv2SNqIXOBaS+Cw==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if
 ia32_disabled is passed
In-Reply-To: <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com>
Date:   Wed, 07 Jun 2023 23:52:01 +0200
Message-ID: <874jnjj5z2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07 2023 at 18:25, Andrew Cooper wrote:
> On 07/06/2023 3:49 pm, Thomas Gleixner wrote:
>> Ergo fact is that clearing the present bit is a user space visible
>> change, which can't be done nilly willy and burried into a patch
>> which is about making CONFIG_IA32_EMULATION a boot time switch.
>
> Removing GDT_ENTRY_DEFAULT_USER32_CS is necessary but not sufficient to
> block userspace getting into 32bit mode.

Correct.

> You also have to block Linux from taking any SYSRETL or SYSEXITL path
> out of the kernel, as these will load fixed 32bit mode attributes into
> %cs without reference to the GDT.

That's non-trivial as there is no way to disable 32bit SYSCALL on AMD
(Intel does not support 32bit syscall and you get #UD if CS.L != 1). So
to be safe you'd need to make ignore_sysret() kill the process w/o
returning to user space.

Though arguably if GDT does not have USER32_CS and LDT is disabled (or
the creation of code segments is blocked) then invoking SYSCALL from
compat mode requires quite some advanced magic (assumed there are no CPU
and kernel bugs), no?

> And you need to prevent any userspace use of the LDT, which might be as
> simple as just blocking SYS_modify_ldt, but it's been a while since I
> last looked.

CONFIG_MODIFY_LDT_SYSCALL=n is the only in kernel option right now, but
that could be made boottime disabled trivially. Extending LDT to reject
the creation of code segments is not rocket science either.

Though the real question is:

       What is the benefit of such a change?

So far I haven't seen any argument for that. Maybe there is none :)

Thanks,

        tglx

