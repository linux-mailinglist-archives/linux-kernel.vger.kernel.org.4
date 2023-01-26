Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F79667CCD4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjAZNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjAZNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:53:20 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B54543935
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:52:59 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id h10so779448ilq.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqTUVgcDFqgmuPJcaaLIwvX9dO9nsd2mP5P4UmvWTho=;
        b=J0st/oZXubF7DyEMWEeTRbY+I1MUcRZ5PUjHbSVTAZirHwo25K/Mq2pdxzxrt9yzJQ
         KNEO31wBqIngUh0Ly5yOS74Y1dY3FxDYCD3efdU+5U0hHzRZDxloipK6IayvU1abWy/6
         JngkkpZaGzJy8Q2x0KcVraFdKpiH38+uHPrB0jTAlgmWOiatPyC2loSlW+zUZMMTA93A
         p8IuCV62II8oseVXchM85xx07CfCxPlZIrqW6cSzZwnh0V0NtdqR0w2Jc9ZpbM8T1Gfw
         qmh/O6Xmix7sTAwYbc3/jC+ZY15AwIPaOC7Txi0MnIaKKRRQmttMr1n4q8KZQT5k16Z0
         8AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqTUVgcDFqgmuPJcaaLIwvX9dO9nsd2mP5P4UmvWTho=;
        b=TlubuUuiUxnr0aLNxjtBSZaY2QucmyC0Vb+GTApeGLOAvqaRXRj/78lqXWBF0Z08KP
         /t7YGmQyw2a8nEulOFWeh3ScXGVgaFSM9IJtIMW7dQ/yBFNGUYh6XexUEJhxF2c35gyz
         6rjKacoHuPu2wSHinNsh7Je1bYfbjHvpasYyNValTrZyCsPMfnyE9jugSRfQP353C8xC
         W3MAB+61QKGd/oUzEAimtxB9b8U28j6AlvoXLs8lpgpau8V9zRfoiRAQmBz1imJ0lCPa
         HdQ0UKNwqNILXtUYF0k4AeciSZ+UfB2njuKq2P6cJXpOatY/2d/1NTPzJqaWQFqSLM4r
         iRhA==
X-Gm-Message-State: AO0yUKWe1gHXuFhQrmCu5RUS/6Cjbx4+N6wzMqwinE9bLe4DyFLk2Lk+
        ISxVWEfeuuWbv32l15MCjirFaMWbbC3KhzabbPhmzA==
X-Google-Smtp-Source: AK7set8RUMV3L+iyC5AX/q8lHI2SYXMKriTm/G+slHUUKKu1q61ZQnRMWRlifyq14Ug/kpcZ4bQHM5aWcDBHiOJ+4VA=
X-Received: by 2002:a92:ca8d:0:b0:310:98bd:dbf0 with SMTP id
 t13-20020a92ca8d000000b0031098bddbf0mr1239903ilo.128.1674741177112; Thu, 26
 Jan 2023 05:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20230125012801.362496-1-ebiggers@kernel.org> <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
In-Reply-To: <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 26 Jan 2023 14:52:20 +0100
Message-ID: <CAG48ez1NaWarARJj5SBdKKTYFO2MbX7xO75Rk0Q2iK8LX4BwFA@mail.gmail.com>
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
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 4:30 PM Dave Hansen <dave.hansen@intel.com> wrote:
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
> The kernel as a whole is not written that way.

The kernel as a whole also doesn't really use the FPU registers for
anything other than checksumming and cryptography and stuff like that
(it's disabled in the compiler flags because the FPU registers
normally contain userspace state that must not be clobbered). The
instructions listed on that Intel help page are all weird PM* and VP*
arithmetic instructions that can't be generated from C code in the
kernel (except for weird subsystems in which every function is only
callable in kernel-FPU-enabled mode and the compiler is set to enable
FPU instruction generation, by which I mean amdgpu).

So with the current generations of CPUs, based on that Intel help
page, "the kernel as a whole" should not be affected by this setting,
it's mostly just cryptographic helpers written in assembly. From a
quick-and-dirty grep:

$ find arch/x86/ -name '*.S' | xargs egrep -li
'(PMADDUBSW|PMULUDQ|VPMULHRSW|PMADDWD|VPLZCNTD|VPMULHUW|PMULDQ|VPLZCNTQ|VPMULHW|PMULHRSW|VPMADD52HUQ|VPMULLD|PMULHUW|VPMADD52LUQ|VPMULLQ|PMULHW|VPMADDUBSW|VPMULLW|PMULLD|VPMADDWD|VPMULUDQ|PMULLW|VPMULDQ)'
arch/x86/crypto/nh-avx2-x86_64.S
arch/x86/crypto/nh-sse2-x86_64.S
arch/x86/crypto/poly1305-x86_64-cryptogams.S

That's NHPoly1305 and Poly1305, two crypto functions. Poly1305 is used
for the authentication part of AEAD schemes (in particular WireGuard
uses Poly1305 for all its authentication), NHPoly1305 is for Adiantum
(weird Android disk encryption stuff AFAIK).

> I'm sure the crypto
> folks that are cc'd can tell us specifically if the kernel crypto code
> is written following those recommendations.

Note that all the memory-management and block layer code that copies
page contents around and swaps them to disk and so on should (ideally)
be cryptographically timing-safe (yes I know that's very much not true
with zram swap), because it operates on basically all userspace
memory, including userspace memory used by cryptographic code.

On top of that, some cryptographic secrets (including SSH
authentication keys) need to be persisted somewhere - some
cryptographic key material is stored in filesystems. And of course
there are also secrets that are not quite cryptographic, and can be
similarly important and small as cryptographic keys, such as cookies
and OAuth tokens stored in the various databases of something like a
browser.

I think part of the reason why KSM is nowadays disabled in most cloud
environments is that it introduced timing differences in the MM
subsystem (between taking a write fault on a private page and taking a
write fault on a KSM-shared page), and those timing differences could
be used to leak information between VMs. (See, for example,
<https://gruss.cc/files/remote_dedup.pdf>.)

So I think there is quite a bit more kernel code that *handles
cryptographic intermediate states and cryptographic secrets* (and
non-cryptographic secrets that have similar properties) than kernel
code that *performs cryptography*.

Do we have a guarantee that things like page copying (for example as
part of migration or forking), usercopy (for example for filesystem
access), and whatever checksumming and other things might reasonably
be happening in the block layer (including for swap) and in
filesystems are going to be data-timing-independent on future
processors?

> So, let's call this patch what it is: a potential global slowdown which
> protects a very small amount of crypto code, probably just in userspace.

And a bunch of data paths that this crypto code's secrets might go
through, in particular in the kernel.

Also note that the kernel can do a bunch of important cryptography on
its own, like for disk encryption, filesystem encryption, SSL/TLS
sockets (yes you can have the kernel do the easy parts of TLS for
you), IPSec, WireGuard, and probably a bunch of other things.

>  That is probably the code that's generating your RSA keys, so it's
> quite important, but it's also a _very_ small total amount of code.

Yeah but all the code that handles storage of your RSA keys really
also needs a similar level of protection when touching them.
See https://arxiv.org/pdf/2108.04600.pdf for an example:
"We analyze the exploitability of base64 decoding functions across
several widely used cryptographic libraries. Base64 decoding is used
when loading keys stored in PEM format. We show that these functions
by themselves leak sufficient information even if libraries are
executed in trusted execution environments. In fact, we show that
recent countermeasures to transient execution attacks such as LVI ease
the exploitability of the observed faint leakages, allowing us to
robustly infer sufficient information about RSA private keys with a
single trace. We present a complete attack, including a broad library
analysis, a high-resolution last level cache attack on SGX enclaves,
and a fully parallelized implementation of the extend-and-prune
approach that allows a complete key recovery at medium costs."

> There's another part here which I think was recently added to the
> documentation:
>
>         Intel expects the performance impact of this mode may be
>         significantly higher on future processors.
>
> That's _meant_ to be really scary and keep folks from turning this on by
> default, aka. what this patch does.  Your new CPU will be really slow if
> you turn this on!  Boo!

It does sound really scary, because it sounds like that list of
instructions Intel published might be useless for trying to reason
about the security impact of turning this optimization on for future
hardware?

If the performance impact is going to be higher on newer CPUs then I
would *definitely* want DOITM to be on by default, and then when Intel
can say what instructions are actually affected on a new CPU, we can
figure out whether it's safe to turn it off as a per-cpu-generation
thing?

> All that said, and given the information that Intel has released, I
> think this patch is generally the right thing to do.  I don't think
> people are wrong for looking at "DODT" as being a new vulnerability.
> Intel obviously doesn't see it that way, which is why "DODT" has (as far
> as I can tell) not been treated with the same security pomp and
> circumstance as other stuff.
>
> Last, if you're going to propose that this be turned on, I expect to see
> at least _some_ performance data.  DOITM=1 isn't free, even on Ice Lake.

So all in all, it sounds to me like this should only affect the
performance of crypto code in current CPUs (where we really want
data-independent timing), so it should definitely be enabled on
current CPUs. And on future CPUs it's a surprise package of potential
security problems, so for those we should be turning it on even more?
