Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31AD7134B3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjE0M3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjE0M33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:29:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0E8F3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:29:27 -0700 (PDT)
Received: from nazgul.tnic (dynamic-002-247-254-198.2.247.pool.telefonica.de [2.247.254.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 052DD1EC03DB;
        Sat, 27 May 2023 14:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685190565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lGAalMcI44BoMUnHyiT4dUVVsCE5jDHOSSKWuauwHLM=;
        b=MhDztrkHT7uHlxzsiEPOHv25IadCJLvky+z53VoiRCMmF/wavFqbAwp1FYybSV4nvHnxjf
        +QtTN3/mH8adv7bjrwDwnBEZ45EWGqpwyd5XmgzskIRUNFC1Pvp0oM8aEhd43D6zutl3en
        JYXSlsyc4ZPAzKGryAWlrFtF/vhqPpg=
Date:   Sat, 27 May 2023 14:29:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
Message-ID: <20230527122916.GAZHH3nHk7kkUA7CeM@nazgul.local>
References: <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
 <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
 <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
 <e6cd1909-2776-28d2-ccc0-4b3d2d09e9ce@intel.com>
 <49861038-B8CA-4CDD-BD44-73066FF453F3@gmail.com>
 <20230527072338.GAZHGv+no2LZASyLWM@nazgul.local>
 <9A302EB1-308A-4904-801C-DC70D9908E11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A302EB1-308A-4904-801C-DC70D9908E11@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 02:17:43AM -0700, Nadav Amit wrote:
> That’s not according to the symbol table - that’s in your mind.

s/your mind/objdump/

Objdump takes the next symbol's address as the end of the previous one.

> Anyhow, the argument that __get_user_nocheck_8 and bad_get_user_clac are
> related makes no sense even conceptually.

I don't think anyone's making that argument. Maybe you should read again what I
said:

"the exception handling ends up being part of __get_user_nocheck_8"

> Some people would even say “elementary”. I was sure it was already clear.

Your cocky attitude will get you nowhere. But whatever you prefer.

> I appreciate your help, but I have reasonable workarounds for my use-case
> (and for the record, no, I don’t think that this solution that you
> propose is reasonable).

I'm simply stating what objdump does. I guess objdump is not good enough
for you.

> It is not “a new tool". You screw up every tool that tries to understand

I'm not screwing up anything - that's your claim.

> All the other local symbols are irrelevant to the discussion as they fall
> within some other symbol's range.

As does this one if you deal with it just like objdump does.

> You are not (not) helping me. I am trying to help you (and other users).

Gee, thanks. I didn't know this needed any help.

> So just don’t do such weird things.

Yah, good luck with that. If it needs to be done in a weird way and it
is the *right* thing to do for the kernel, I couldn't care less about
some external tools.

As to what you want to address, I'll talk to toolchain folks first and
get back to you.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
