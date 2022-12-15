Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2963A64D53C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 03:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLOCJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 21:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOCJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 21:09:21 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE536C42
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:09:20 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id s9so4122453qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4eDacVPeRCxSHKdGOkoS+IOwT3PA0un8lmYN5+fjPhw=;
        b=y7057BeXP8Mk6u2/+Eoxa5be8UoreoDppdS/r/OZICVloTQdOTwaMkQbq3qcq3ZOgS
         IhIc9GjFqKsHtXrK4K+zhdOUbdCmlIs+s6lLZk5zd5HuGWlS8c8mWM9f1vas+tE16DtT
         7gnd9H/ihmf30zvyBXYUU7O8mhs2tfby4PkfVK09y+fXpJ2w0RiehMNk3voHmeYDDuab
         eyVpNKXt7TLSUFjaJs15VZer4Pb1tfWqaCPejg1d9QHfE5XhXKm0d0k2OkKOvPLzyR3T
         rCXCe84Bc23wJ1L+Q1kJTjNYjKuCRAodJb38tiQQ5ec3uWE0uk/HCZo0Z0xPeZ/Cl4Ag
         3GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eDacVPeRCxSHKdGOkoS+IOwT3PA0un8lmYN5+fjPhw=;
        b=2g2pkbvo5Kb7LtInK5P6Ae3r21OMpPiuuNKJGtFqhUY7PwOUPxHN3kg0+/Au8h8mAa
         20NOPOZTknx/XekDrMRqdGObIFIqYhMpWlFvExoY6ad5cjH7pLSy0mNLT2a9c5AHI6Pk
         gye+HswJvGIg96afOGRxYhkxu5uXNEZ6oY9tsP7bxhYKnVSTjnmA56J/CVVaSHJiuJFT
         oDOU5e3UUg6zm+rvcwbWBax7UQDHnwUKuTluFE/Yy44DCU9W4HGFxQrg8f9fUyuwmBmn
         pM351ZmQYud/aawsB9fcgV8FvNjxE20d3v8tqt2ASMMw6Ct6fT0tdiGxDGPbBN1qnA3T
         hJNA==
X-Gm-Message-State: ANoB5pnMYYnqFQnjtHeYIhe6pRc3bB85sQgi4dgFLxnkQRqdoJSLSbsU
        FhOwGiUDfo5m6zK0Epjs1u/h
X-Google-Smtp-Source: AA0mqf5I2BrheF1m6gxgerTJOGj7W6D5Syqpq0MvS6v7R0LmC1jB9uD9VC1LFaYtkT4QXreRi+4OLA==
X-Received: by 2002:a05:622a:1a21:b0:3a7:e7e7:566 with SMTP id f33-20020a05622a1a2100b003a7e7e70566mr45474629qtb.66.1671070159263;
        Wed, 14 Dec 2022 18:09:19 -0800 (PST)
Received: from bruce.bluespec.com ([38.70.11.124])
        by smtp.gmail.com with ESMTPSA id h22-20020ac85496000000b0035cd6a4ba3csm2658868qtq.39.2022.12.14.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 18:09:18 -0800 (PST)
Date:   Wed, 14 Dec 2022 21:09:13 -0500
From:   Darius Rad <darius@bluespec.com>
To:     Vineet Gupta <vineetg@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, fweimer@redhat.com,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
Message-ID: <Y5qByfCtpV0uNID3@bruce.bluespec.com>
Mail-Followup-To: Vineet Gupta <vineetg@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, fweimer@redhat.com,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, greentime.hu@sifive.com,
        vincent.chen@sifive.com, andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
 <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
 <Y5irn63DQkwumfvW@bruce.bluespec.com>
 <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:07:03PM -0800, Vineet Gupta wrote:
> On 12/13/22 08:43, Darius Rad wrote:
> > On Fri, Dec 09, 2022 at 11:42:19AM -0800, Vineet Gupta wrote:
> > > But keeping the V unit disabled by default and using prctl as a gatekeeper
> > > to enable it feels unnecessary and tedious.
> > > Here's my reasoning below (I'm collating comments from prior msgs as well).
> > Please reference the previous discussion [1] which has covered topics that
> > have not been discussed recently.
> > 
> > [1] https://lists.infradead.org/pipermail/linux-riscv/2021-September/thread.html#8361
> 
> I sure read thru that thread, and many more :-) to get context.
> The highlight is we should something because AVX/AMX do so (or failed to do
> so).
> But on the flip side ARM SVE is not disabling this by default.
> Your other concerns seems to be potential power implications for leaving it
> on and sharing of V unit across harts (see more on that below)
> Maybe leaving it on all the time will be motivation for hw designers to be
> more considerate of the idle power draw.
> 

That is not quite the same take away I had from the AMX discussion.  I
would also disagree that ARM SVE is not disabling things by default,
although the behavior is somewhat different.

The significant point that I see from that discussion, which also applies
to SVE, and also applies to RISC-V vector, is that the extension is
necessarily dependant upon a functional unit that is reasonably large with
respect to the size of the processor and has a significant amount of
additional architectural state.  The argument there is that AMX/SVE/RVV is
a significant system resource and should be treated as such: by having the
kernel track usage of it and by having a process specifically request
access to it.

For any of AMX/SVE/RVV, use of the extension operates as follows:

  1. A process requests access to the extension,

  2. The kernel allocates memory for the additional state for this process,

  3. The kernel enables the extension for the process, and finally

  4. The process is able to use the instructions.

I don't recall the exact details, but my understanding is that AMX is going
to use an x86 specific mechanism and require and explict request from user
space to request access to AMX.

For SVE, it is in fact disabled by default in the kernel.  When a thread
executes the first SVE instruction, it will cause an exception, the kernel
will allocate memory for SVE state and enable TIF_SVE.  Further use of SVE
instructions will proceed without exceptions.  Although SVE is disabled by
default, it is enabled automatically.  Since this is done automatically
during an exception handler, there is no opportunity for memory allocation
errors to be reported, as there are in the AMX case.

For RVV, I do not recall ever seeing Linux patches that automatically enable
vector.  I have seen it enabled unconditionally, or with a manual enable
(i.e., prctl).

It is possible to write a program that does not ever use AMX, and when that
program is run, the process will not incur the power or memory overhead of
AMX.  It is also possible to do that with SVE.  This is simply not possible
if RISC-V will, by default for every process, enable and allocate state
memory for vector.

So my thought would be what is the motivation for being even less flexible
than SVE, if you feel that the AMX mechanism is too onerous?

> > 
> > > 2. People want the prctl gatekeeping for ability to gracefully handle memory
> > > allocation failure for the extra V-state within kernel. But that is only
> > > additional 4K (for typical 128 wide V regs) per task.
> > But vector state scales up to as much as 256k.  Are you suggesting that
> > there is no possibility that future systems would support more than
> > VLEN=128?
> 
> I mentioned "typical". And below also said that memory allocation concerns
> are moot, since fork/execve failures due to failing to allocate would take
> care of those anyways.
> 

But again, what if one were using such an admittedly atypical system?  Why
should such a user be compelled to take a memory hit for every process,
even if they specifically go out of their way to avoid using vector
instructions?

> > > If that is failing,
> > > the system is not doing well anyways. Besides it is not an issue at all
> > > since ENOMEM in clone/execve for the additional space should handle the
> > > failure anyways. Only very sophisticated apps would downgrade from executing
> > > V to Scalar code if the prctl failed.
> > This seems unlikely.  As vector support does not exist in any present
> > hardware, and the vector extension is only optional in the RISC-V profiles
> > that include it, I would think that it is almost certain that any
> > application that supports V would have a fallback path for when the V
> > extension is not available.
> 
> For specialized cases sure we would expect fat binaries with IFUNC based
> dispatches (glibc mem*/str* are obvious examples). But with newer compilers
> autovec is increasing becoming default even at medium optimization levels
> such as -O2. So V code littered all over is just a matter of time for the
> profiles/variants which allow V. For less capable systems w/o V this is all
> but moot discussion since kernel itself need not be built with V enabled.
> 

To me, that seems like a lot of speculation, and certainly not worth
relying on to limit functionality.

> 
> > Another motivation for requiring that user space request use of the vector
> > extension is that the vector unit may be shared between multiple harts
> > and/or have power or performance implications in the system.  By requiring
> > that user space request access, it allows the system to decline that
> > access, and user space can handle this gracefully.
> 
> But in this specific example won't the prctl cause more pain. So 2
> concurrent processes on 2 different harts with shared V unit. One sends
> prctl to enable and other wants to disable, what would the kernel do. Will
> it just be whoever ends up running later wins. Granted I'm not too familiar
> with how such a cross-hart sharing would work in a Vector instructions being
> part of ISA  (vs. Vector accelerator with job push/pull approach)
> 

I think you are misunderstanding both the mechanism and the potential
implementation.

The mechanism is not a switch per hart, it is a switch per process (or
thread).  It indicates to the kernel that this process (or thread) is using
the resource, and the kernel will allocate memory, enable instructions,
etc., as needed when that processes is scheduled on a hart.

The theoretical implementation is something like what was done with
floating point in the AMD Bulldozer architecture.  All the sharing of
resources is done automatically in hardware, but obviously performance
measurements could demonstrate that each thread/hart does not have its own
execution unit.  I would imagine that in such an implementation, the vector
unit would not be able to, for example, enter a low power mode unless both
harts that depend on it are not using it.  I would also imagine that single
thread performance for vector would be optimized if only one thread were
using the vector unit at a time.  If the vector unit is enabled
unconditionally by default for all processes, this is not possible.

// darius

