Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20C2667A99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjALQTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjALQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:18:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9DD4E;
        Thu, 12 Jan 2023 08:14:58 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AE8F1EC04F0;
        Thu, 12 Jan 2023 17:14:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673540097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kXgGOS0t1Dmzod2SUlVqdk8NheeeK7L+8V9FBwGiZ2c=;
        b=m3JMpkzRjC8s+Ax3AVMnGYV4D08mDT/nAPRGVvPn9MS6OIJBqz47llq3S/Zr//hgi7Lujd
        RfYRnQupWB15RFD0Ey1QDe50Yidqw1+88F0QbkzxSoFaZpIW7gSVU8GDD+LIHhxRpbC2uN
        +Peu+rXB3xj9M6aLYIr4P12WzeD3V5I=
Date:   Thu, 12 Jan 2023 17:14:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Yujie Liu <yujie.liu@intel.com>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
Message-ID: <Y8Ax/I5qOcVDZljG@zn.tnic>
References: <202212272003.rgQDX8DQ-lkp@intel.com>
 <Y6r4mXz5NS0+HVXo@zn.tnic>
 <CANiq72kc60aPcx5LwFhOGL4AXOhZsZj32iOg75K5ZxLaaRaYkg@mail.gmail.com>
 <Y7i1h3lCMKfxB532@zn.tnic>
 <CANiq72khMLU6tF8vGD9fs7mLNAAQu8wJ2n1SLM3th2QMMfGPPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72khMLU6tF8vGD9fs7mLNAAQu8wJ2n1SLM3th2QMMfGPPA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 01:38:42AM +0100, Miguel Ojeda wrote:
> You are of course right that the instructions are not complete, I just
> meant to add a bit of context, i.e. that Rust got enabled due to the
> config, but as far as I understand, it shouldn't be getting enabled in
> the other ones for the moment.

Right, or at least the repro instructions should state it clear.

Btw, this is part of a long-running feedback process we're giving to the 0day
bot in order to make their reports as user friendly as possible.

> My point was that the script expects some variables set by `Makefile`,
> similar to `$CC` etc., so that output does not imply you have (or not)
> a suitable Rust toolchain installed (i.e. it will currently also fail
> if you have it installed).

Aha.

> Meanwhile (of course it is not the same as proper reproduction
> instructions since the LKP team may do something different), the
> documentation on how to set it up for a normal developer is at:
> https://www.kernel.org/doc/html/latest/rust/quick-start.html, in case
> it helps (if you are up for it... :)

Probably that link should be part of those reproduction instructions.

> > And while we're reporting bugs: the error message from the compiler itself could
> > use some "humanization" - I have zero clue what it is trying to tell me.
> 
> What would you want to see? We can ask the relevant Rust team to see
> if they can improve it.
> 
> In general, note that you can ask `rustc` to further explain an error
> giving it the code with `--explain`. The compiler suggests this
> itself, but sadly the robot cut it out :(

Well, I find having an --explain option too much. But there are perhaps reasons
for it.

One improvement could be, IMHO, they could turn on --explain automatically when
it results in a build error. So that you don't have to do it yourself.

What would be better, tho, is if there were no --explain option at all and the
warnings are as human readable as possible.

>     For more information about this error, try `rustc --explain E0588`
> 
> In this case, it gives:
> 
>     A type with `packed` representation hint has a field with `align`
>     representation hint.
> ...

so the struct is:

struct alt_instr {
        s32 instr_offset;       /* original instruction */
        s32 repl_offset;        /* offset to replacement instruction */

        union {
                struct {
                        u32 cpuid: 16;  /* CPUID bit set for replacement */
                        u32 flags: 16;  /* patching control flags */
                };
                u32 ft_flags;
        };

        u8  instrlen;           /* length of original instruction */
        u8  replacementlen;     /* length of new instruction */
} __packed;

and everything is naturally aligned.

So I'm guessing this is a rust bindings glue shortcoming or so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
