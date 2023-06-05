Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3519722DC3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjFERlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFERlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:41:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D498
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:41:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba82ed6e450so7117326276.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685986870; x=1688578870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWTiUkWgT2qU83kXQ2ewLzslNcjX1ssEmdNIsgr4sA0=;
        b=qpfk0eHSttkkydjxY6Zkx5agZl/36ovxBUokVw9VhFCzQ9IO7mRwq0W6jvp/amkFWT
         QmYkAKtQ02VqC5XYMzvzosc2bqGzAKMeM/rk7e8pETzBQKr0A2v6PbQkBsuSgCynOCeQ
         Db9j0l7Qz0BPEeDREe6/veZL7ugur2qIuTob5Y5fAOrT8XFLKYcGgL/V8N6lb6nMz1F7
         usS3CgUTIlt4+2B5bUmmOQq8mafRhG1BVZTv64MYV3Fwu4i/G4mMt66qb24YFUAD643I
         JC7yEvXszi90c3y3lP/N+ZtV6xex4QuLwGVyamBQ5Ukz0ZguiyoGVcCpM0pytUWUhJnt
         ySsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685986870; x=1688578870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWTiUkWgT2qU83kXQ2ewLzslNcjX1ssEmdNIsgr4sA0=;
        b=inOR2RSeb4Ks7182EK7T8bFpdotvpeNEC9OLNwOeDdQzj1iwa4desEhJKesWVR70pD
         elhGf+Qe5JcISxQugwxe7CYnRRiqrfu4p3doTYQcC9dQvFJ+LSYA1Eq1Q9Qwi2vn1MTS
         HwNW4xT0GQvgSFtvEgKMX7Z3HSFdSNWTnqPmKAw2bshp7buL+hxiPcixX5qrCpE577d3
         7S9VtMcvRmF/AseCdP5hrLEgFCLggf+kavl+qXPSTxv6pmal3+vqkH/rJMxGYyT0C9xT
         Or+UC1RyE0NR/it6JVnf9ywxAztXMYG/D8CmEjxuXXCLggzh0eTxbwTCmkztV5oQipUV
         yI9w==
X-Gm-Message-State: AC+VfDwOJf4qn7uEhOTR1dPQznJcCEa5klh/qhm2XopS7koNrHNMznE4
        Zltqhci8jWM3Bv4E1JI2WFbLgwQ/LLQ=
X-Google-Smtp-Source: ACHHUZ5U3k9ojb/QXZMYBXXrpXN6+1GeoO4KsRexA2OMLDuTlKT7BB+V+ZRaor0/FTR7Ir74xoqCVSny2GA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2402:0:b0:b9a:6508:1b5f with SMTP id
 k2-20020a252402000000b00b9a65081b5fmr3761188ybk.11.1685986870190; Mon, 05 Jun
 2023 10:41:10 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:41:08 -0700
In-Reply-To: <20230603193439.502645149@linutronix.de>
Mime-Version: 1.0
References: <20230603193439.502645149@linutronix.de>
Message-ID: <ZH4eNL4Bf7yPItee@google.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023, Thomas Gleixner wrote:
> Hi!
> 
> Ashok observed triple faults when executing kexec() on a kernel which has
> 'nosmt' on the kernel commandline and HT enabled in the BIOS.
> 
> 'nosmt' brings up the HT siblings to the point where they initiliazed the
> CPU and then rolls the bringup back which parks them in mwait_play_dead().
> The reason is that all CPUs should have CR4.MCE set. Otherwise a broadcast
> MCE will immediately shut down the machine.

...

> This is only half safe because HLT can resume execution due to NMI, SMI and
> MCE. Unfortunately there is no real safe mechanism to "park" a CPU reliably,

On Intel.  On AMD, enabling EFER.SVME and doing CLGI will block everything except
single-step #DB (lol) and RESET.  #MC handling is implementation-dependent and
*might* cause shutdown, but at least there's a chance it will work.  And presumably
modern CPUs do pend the #MC until GIF=1.

> but there is at least one which prevents the NMI and SMI cause: INIT.
> 
>   3) If the system uses the regular INIT/STARTUP sequence to wake up
>      secondary CPUS, then "park" all CPUs including the "offline" ones
>      by sending them INIT IPIs.
> 
> The INIT IPI brings the CPU into a wait for wakeup state which is not
> affected by NMI and SMI, but INIT also clears CR4.MCE, so the broadcast MCE
> problem comes back.
> 
> But that's not really any different from a CPU sitting in the HLT loop on
> the previous kernel. If a broadcast MCE arrives, HLT resumes execution and
> the CPU tries to handle the MCE on overwritten text, pagetables etc.
> 
> So parking them via INIT is not completely solving the problem, but it
> takes at least NMI and SMI out of the picture.

Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs indefinitely
potentially cause problems too?

Why not carve out a page that's hidden across kexec() to hold whatever code+data
is needed to safely execute a HLT loop indefinitely?  E.g. doesn't the original
kernel provide the e820 tables for the post-kexec() kernel?  To avoid OOM after
many kexec(), reserving a page could be done iff the current kernel wasn't itself
kexec()'d.
