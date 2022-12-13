Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9505364BA01
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiLMQnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiLMQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:43:18 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7EC21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:43:17 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id r15so10781846qvm.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OwYkkGOZrIudiCQIBSUvcv40gkAuqrBjpEeTE4vLA8=;
        b=dMTrfA2yVrybtIk5Dhf1PFQXlNiXZTTYzkF1Ot7tljDpRTmKBANsrcLl+EcUFuhpWe
         EaENf/vhiy9pN4IH9Gyil6kpOWjUw2I0aPTkzE5oj4SmROXik+8NH6Mp6JbimIDTr7Zh
         /7dY/EleRNS5+06Fn/EXE1xipXNG2uTnkU2iSxyKDUmN2k6x77NyvXy5F3qfcmf+KXNj
         kxia+3jFrxvlRNYM2/MX9/jF9PY39AiUTLkIUsAP3k4q3sFo36MrGvWNsyhlGsf5MMnY
         Op4y95xX/grlIbDOgFGVKSD4BtDPG+CoGOh84yXvuh0m1ThTWJSOg2TA4dI+DrcjkiTV
         XIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OwYkkGOZrIudiCQIBSUvcv40gkAuqrBjpEeTE4vLA8=;
        b=G/6WAQbUPdO7ZxRaBYEd/xajYjSdgmuxvDf5IxfVdyfjVm3E1Xzod6F8TPV+hUHWtY
         VJM/1M3MVIz/vk7YApTMMsONS0LByHXx68Rm/CDnLHVzBIAv13+qZiGgULF+6KaAj565
         Vk8SjpFLrC5FCMDBzxEJfjv9Sy/8zxu+wlzvAxnk7ypbiADHlWv+xst4yOvf1+IFosqX
         XV4ik0QLd88BDVf3O4hFFEykXwFDK1f3O8Go/q1pgKUFotWXSFe1M/43oqokN4N3yXhE
         p9FBtOBfsqhM5j5mYYrfMAhPkBUY74jjRIJDnK0/2xmEX2b+cWfFkOFqsd3/ibw77jco
         U0/g==
X-Gm-Message-State: ANoB5pkvgzQvoyMuDjUXncAfAQL75z4iuzFHPkoqiIcZjjmrvYg5DMV3
        l58FVJ/5bnfUm9W6UiTnntBF
X-Google-Smtp-Source: AA0mqf603YEue3EXF8qlyILlT/0qEnn/IPhWuaayQS3EcmXydtBkWYQgQAYWkPwL22oID/nc4+O1Mw==
X-Received: by 2002:a0c:fc0f:0:b0:4c7:1d69:5533 with SMTP id z15-20020a0cfc0f000000b004c71d695533mr24885733qvo.34.1670949796382;
        Tue, 13 Dec 2022 08:43:16 -0800 (PST)
Received: from bruce.bluespec.com ([38.70.11.69])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a240600b006fcb4e01345sm8365089qkn.24.2022.12.13.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:43:15 -0800 (PST)
Date:   Tue, 13 Dec 2022 11:43:11 -0500
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
Message-ID: <Y5irn63DQkwumfvW@bruce.bluespec.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 11:42:19AM -0800, Vineet Gupta wrote:
> 
> But keeping the V unit disabled by default and using prctl as a gatekeeper
> to enable it feels unnecessary and tedious.
> Here's my reasoning below (I'm collating comments from prior msgs as well).

Please reference the previous discussion [1] which has covered topics that
have not been discussed recently.

[1] https://lists.infradead.org/pipermail/linux-riscv/2021-September/thread.html#8361

> 
> 1. Doesn't it add another userspace ABI which is already a headache for this
> feature. And that needs to be built into not just libc but potentially other
> runtimes too. Even after implemention there will be an interim pain as the
> new prctl takes time to trickle down into tooling and headers. Besides the
> new stuff will never be compatible with older kernel but that is a minor
> point since older kernel not supporting V is a deal breaker anyways.
> 

None of this is relevant because there is no existing user space ABI for
vector.  It is being invented now.  If this is done poorly, for example, by
missing this opportunity to add a mechanism for user space to request use
of the vector extension, it will be much more painful to add later.

> 2. People want the prctl gatekeeping for ability to gracefully handle memory
> allocation failure for the extra V-state within kernel. But that is only
> additional 4K (for typical 128 wide V regs) per task. 

But vector state scales up to as much as 256k.  Are you suggesting that
there is no possibility that future systems would support more than
VLEN=128?

> If that is failing,
> the system is not doing well anyways. Besides it is not an issue at all
> since ENOMEM in clone/execve for the additional space should handle the
> failure anyways. Only very sophisticated apps would downgrade from executing
> V to Scalar code if the prctl failed.  

This seems unlikely.  As vector support does not exist in any present
hardware, and the vector extension is only optional in the RISC-V profiles
that include it, I would think that it is almost certain that any
application that supports V would have a fallback path for when the V
extension is not available.


Another motivation for requiring that user space request use of the vector
extension is that the vector unit may be shared between multiple harts
and/or have power or performance implications in the system.  By requiring
that user space request access, it allows the system to decline that
access, and user space can handle this gracefully.

If we add a mechanism for user space to request access to the vector
extension, and it turns out that it was unnecessary, the worst that has
happened is a slight inconvenience.

If we do not add such a mechanism, and later determine that it is
necessary, we have a much greater problem.  There would be backward
compatibility issues with the ABI, and such a mechanism could probably not
be fully implemented at all due to the desire to support potential future
legacy vector code.

This is a similar problem on x86.  According to some, it was handled poorly
with AVX-512 by missing this type of mechanism, and improved with AMX [2].
There is opportunity to learn from that experience and do things better on
RISC-V.

[2] https://lore.kernel.org/lkml/87k0ntazyn.ffs@nanos.tec.linutronix.de/


// darius

