Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6B767B6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjAYQX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAYQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:23:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5123456484;
        Wed, 25 Jan 2023 08:23:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA40CB81ACA;
        Wed, 25 Jan 2023 16:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C94C433AA;
        Wed, 25 Jan 2023 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674663777;
        bh=TQiqmThMS8h1877Y5nU5Fh3m4/A32suvDtBvcx9Y5OI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ihge/2UAshKVv7ffSOIZaNYtSSuwozAEF0ppR8qPSSCfMDEynzV1oU93klXagjM0u
         JkmDKtedOKPkDbGZBxuObrbRAEowEoOnqZ/XsGIQfMohYi+Na75aOm/rJIir5bLiMX
         M8YiRAAwZsf0kA/QB3WhjaKD/YusOTlqbKWltP20f+PxZwvAYovffVcmTZdBoVnazf
         gZo1uK9GMEOPiUykdu3S8nJQgPiL3cHLad8bAeiu5hjDrbHWoAG8Je8XFK3qt2T2Q6
         ktT2CFX+IFbbKAYRoBpizMGSD3APuAVu+1NEMZ6XwqP8dMOtpSpBWZMQ7/sNGdBgun
         Ha29iqF+2aqKQ==
Received: by mail-lj1-f170.google.com with SMTP id p25so20905373ljn.12;
        Wed, 25 Jan 2023 08:22:57 -0800 (PST)
X-Gm-Message-State: AO0yUKUaKaqtja5qOXe/uCuSj7+0vEXSFpJQaoFzeTzrvJG6QvVe8UDg
        8FUy6jGSHvR2Wh0X+2jLGSzP6bX7/9xF50e6bXY=
X-Google-Smtp-Source: AK7set/PquMP/FPpDSDRiB4oyDa5KT4Byry8FM7o4Ha44XAhPRypiAyl+tQ6QWjfU6rBDFlaapMULFues0nlM1lVhJU=
X-Received: by 2002:a2e:5044:0:b0:28e:6e21:fcc1 with SMTP id
 v4-20020a2e5044000000b0028e6e21fcc1mr32457ljd.152.1674663775570; Wed, 25 Jan
 2023 08:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20230125012801.362496-1-ebiggers@kernel.org> <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
In-Reply-To: <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Jan 2023 17:22:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEZi1ewVdqXHTi7kWX9aT+j1=rFOVE55LdJYb9LkV9Dkw@mail.gmail.com>
Message-ID: <CAMj1kXEZi1ewVdqXHTi7kWX9aT+j1=rFOVE55LdJYb9LkV9Dkw@mail.gmail.com>
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 at 16:29, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/24/23 17:28, Eric Biggers wrote:
> > To mitigate this CPU vulnerability, it's possible to enable "Data
> > Operand Independent Timing Mode" (DOITM) by setting a bit in a MSR.
> > While Intel's documentation suggests that this bit should only be set
> > where "necessary", that is highly impractical, given the fact that
> > cryptography can happen nearly anywhere in the kernel and userspace, and
> > the fact that the entire kernel likely needs to be protected anyway.
>
> I think this misses a key point from the documentation:
>
>         This functionality is intended for use by software which has
>         already applied other techniques to mitigate software timing
>         side channels, such as those documented in Intel's Guidelines
>         for Mitigating Timing Side Channels Against Cryptographic
>         Implementations.
>
> Translating from Intel-speak: Intel thinks that DOITM purely a way to
> make the CPU run slower if you haven't already written code specifically
> to mitigate timing side channels.  All pain, no gain.
>
> The kernel as a whole is not written that way.  I'm sure the crypto
> folks that are cc'd can tell us specifically if the kernel crypto code
> is written following those recommendations.
>

Cryptography is often singled out because it deals with confidential
data, and if timing variances leak the data, the confidentiality is
violated.

However, this is not fundamentally different from execution at a
higher privilege level. In this case, the data is shielded from other
observers by the h/w enforced privilege boundary rather than
encryption, but if timing variances leak the data, the result is the
same, i.e., data that was assumed to be confidential as far as user
space is concerned is no longer confidential.

All the nospec stuff we added for Spectre v1 serves the same purpose,
essentially, although the timing variances due to cache misses are
likely easier to measure. IOW, some of the kernel is now written that
way in fact, although the author of that doc may have had something
else in mind.

So IMHO, the scope is really not as narrow as you think.

> So, let's call this patch what it is: a potential global slowdown which
> protects a very small amount of crypto code, probably just in userspace.
>  That is probably the code that's generating your RSA keys, so it's
> quite important, but it's also a _very_ small total amount of code.
>
> There's another part here which I think was recently added to the
> documentation:
>
>         Intel expects the performance impact of this mode may be
>         significantly higher on future processors.
>
> That's _meant_ to be really scary and keep folks from turning this on by
> default, aka. what this patch does.  Your new CPU will be really slow if
> you turn this on!  Boo!
>

What is the penalty for switching it on and off? On arm64, it is now
on by default in the kernel, and off by default in user space, and
user space can opt into it using an unprivileged instruction.

> All that said, and given the information that Intel has released, I
> think this patch is generally the right thing to do.  I don't think
> people are wrong for looking at "DODT" as being a new vulnerability.
> Intel obviously doesn't see it that way, which is why "DODT" has (as far
> as I can tell) not been treated with the same security pomp and
> circumstance as other stuff.
>
> Last, if you're going to propose that this be turned on, I expect to see
> at least _some_ performance data.  DOITM=1 isn't free, even on Ice Lake.
