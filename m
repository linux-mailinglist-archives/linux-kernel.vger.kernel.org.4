Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44763402C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiKVP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKVP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:28:32 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3985FD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:28:30 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id v28so14653642pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1U2CqE50WAQsFkSkTubSHuBImMZomnV4Wn5r6ui87s=;
        b=P+a+dsTfzyD9J7a4fuxFYguFmjAQmFtqoDjheP0peYnbxT6rqPDPWPImtTivXUhCrB
         y/r/1kApcFVMlWtwXxTVeZAz9B6sRHPSP3inPx9jqsGzaipodBXHf+kbFZm2ZJWjhCAy
         mzNhGCvC947bZYncxVfihx6vqFvOe9IAn+eG4/e4eotggiZuYSrw+j4EyY5Vqp47kqhz
         Yn6dIQWZSKGIRwKrDFnyg7K+G1Yi4SsLm1t7lnoP5lC9AnEcWAIf3Bqsd6EKgAfHVF5w
         hJlSJVfR8TuCd78pfFdPGTDE/yI5okXRrm/VXCR/hVnEAM235A9AyspNeTYUTKDwc1YL
         T7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1U2CqE50WAQsFkSkTubSHuBImMZomnV4Wn5r6ui87s=;
        b=tDws7eX/RtllzZgBSMVdkC9ilMMFwGs74dyr8SLd92kDUVli4yRVqQ5Nx+RoDRxsri
         /rZJvR4fOftXQ6Oxef9g3Q4edXKcyBRwVRn5dqxt/oQKJsK6SZl+0ogsutK8IMP3sHMv
         vHiXP6S0FgnuDTJtqeKzKbA1BnonmbE/esZ7EGdKddDnneJb3T6/gm3g2PB6KKgl+cbj
         HcDVwCZU30x87V8XGUE1/vSl14KB+gRTKWmyQ7kcwg44KCtcx01f0FgGKiPe6O3a87Gy
         k9O2y3NWndSp3FgWXYp64T/Ub+V/dlP0MolWFixzwHUbvZpxbjyanZaVSIvcTUvAsgwq
         KdWw==
X-Gm-Message-State: ANoB5pkq4oyWD9nBtRsMMeKTgCt9/HbGrtfeJazMh4M8Jfsjk5WEHxWG
        g10yUo31YH1Hh2yokwTSkFFk0w==
X-Google-Smtp-Source: AA0mqf73esOF9a222BcHdbepaYPJ6aBWIcF1NZukBX7VgD2TPHtufGyqiHUGxzVJjZk6gKlatopnqA==
X-Received: by 2002:a63:4755:0:b0:477:1bf6:8b1c with SMTP id w21-20020a634755000000b004771bf68b1cmr4099745pgk.25.1669130910041;
        Tue, 22 Nov 2022 07:28:30 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id z11-20020aa79e4b000000b0056bd95259d6sm10794582pfq.189.2022.11.22.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:28:29 -0800 (PST)
Date:   Tue, 22 Nov 2022 07:28:29 -0800 (PST)
X-Google-Original-Date: Tue, 22 Nov 2022 07:28:27 PST (-0800)
Subject:     Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
In-Reply-To: <Y3ywTzv3vbgRXQGG@wendy>
CC:     apatel@ventanamicro.com, anup@brainfault.org,
        Conor Dooley <conor@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     conor.dooley@microchip.com
Message-ID: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 03:19:43 PST (-0800), conor.dooley@microchip.com wrote:
> On Tue, Nov 22, 2022 at 11:06:15AM +0530, Anup Patel wrote:
>> On Tue, Nov 22, 2022 at 10:46 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>> >
>> > On Mon, 21 Nov 2022 19:45:07 PST (-0800), anup@brainfault.org wrote:
>> > > On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>> > >>
>> > >> From: Palmer Dabbelt <palmer@rivosinc.com>
>> > >>
>> > >> As per [1], whether or not the core can wake up from non-retentive
>> > >> suspend is a platform-specific detail.  We don't have any way to encode
>> > >> that, so just stop using them until we've sorted that out.
>> > >>
>> > >> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
>> > >> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
>> > >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> > >
>> > > This is just unnecessary maintenance churn and it's not the
>> > > right way to go. Better to fix this the right way instead of having
>> > > a temporary fix.
>> > >
>> > > I had already sent-out a patch series 5 months back to describe
>> > > this in DT:
>> > > https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/
>> > >
>> > > No one has commented/suggested anything (except Samuel
>> > > Holland and Sudeep Holla).
>> >
>> > I see some comments from Krzysztof here
>> > <https://lore.kernel.org/lkml/7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org/>
>> > as well.  Looks like everyone is pointing out that having our CPU nodes
>> > encode timers is a bad idea, my guess is that they're probably right.
>>
>> Adding a separate timer DT node, creates a new set of compatibility
>> issues for existing platforms. I am fine updating my series to have
>> separate timer DT node but do we want to go in this direction ?
>
> I don't really follow. How is there a compatibility issue created by
> adding a new node that is not added for a new property? Both will
> require changes to the device tree. (You need not reply here, I am going
> to review the other thread, it's been on my todo list for too long. Been
> caught up with non-coherent stuff & our sw release cycle..)
>
>> Even if ARM has a separate timer DT node, the timers are still part
>> of the CPU. It depends on how we see the DT bindings aligning with
>> actual HW.
>>
>> >
>> > > Please review this series. I can quickly address comments to
>> > > make this available for Linux-6.2. Until this series is merged,
>> > > the affected platforms can simply remove non-retentive suspend
>> > > states from their DT.
>> >
>> > That leaves us with a dependency between kernel versions and DT
>> > bindings: kernels with the current driver will result in broken systems
>> > with the non-retentive suspend states in the DT they boot with when
>> > those states can't wake up the CPU.
>
> Can someone point me at a (non D1 or virt) system that has suspend
> states in the DT that would need fixing?
>
>> This is not a new problem we are facing. Even in the ARM world,
>> the DT bindings grew organically over time based on newer platform
>> requirements.
>>
>> Now that we have a platform which does not want the time
>> C3STOP feature, we need to first come-up with DT bindings
>> to support this platform instead of temporarily disabling
>> features which don't work on this platform.
>
> It's the opposite surely? It should be "now that we have a platform that
> *does want* the C3STOP feature", right?

IMO we just shouldn't be turning on C3STOP at all.  Sure it's making the 
problem here go away, but it's trying to emulate a bunch of Intel timer 
features we don't have on RISC-V and ending up in a bunch of fallback 
paths.

If we need some workaround in the timer subsystem to sort out the 
non-retentive states then we can sort that out, but my guess is that 
vendors are just going to 3

>> > > With all due respect, NACK to this patch from my side.
>
> As Samuel pointed out that the D1 doesn't actually use the timer in
> question, I think we are okay here?

IIUC it just should use the sunxi timer driver, but that requires some 
priority changes (and presumably breaks 

That said, I guess I'm confused about what's actually broken here.  My 
understanding of the problem is: The D1's firmware disables some 
interrupts during non-retentive suspend, which results in SBI timers 
failing to wake up the core.  The patch to add C3STOP makes the core 
come back from sleep, but that results in a bunch of other timer-related 
issues.

So IMO we should revert the C3STOP patch as it's causing regressions 
(ie, old workloads break in order to make new ones work).  Seems like 
folks mostly agree on that one?

I also think we should stop entering non-retentive suspend until we can 
sort out how reliably wake up from it, as the SBI makes that a 
platform-specific detail.  If the answer there is "non-retentive suspend 
is fine on the D1 as long as we don't use the SBI timers" then that 
seems fine, we just need some way to describe that in Linux -- that 
doesn't fix other platforms and other interrupts, but at least it's a 
start.

Sorry if I've just misunderstood something here?

>
>> > >>
>> > >> ---
>> > >>
>> > >> This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
>> > >> Events are stopped during CPU suspend"), which fixes suspend on the D1
>> > >> but breaks timers everywhere.
>> > >> ---
>> > >>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
>> > >>  1 file changed, 11 insertions(+)
>> > >>
>> > >> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> > >> index 05fe2902df9a..9d1063a54495 100644
>> > >> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
>> > >> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> > >> @@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
>> > >>         if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
>> > >>             state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
>> > >>                 return false;
>> > >> +
>> > >> +       /*
>> > >> +        * Whether or not RISC-V systems deliver interrupts to harts in a
>> > >> +        * non-retentive suspend state is a platform-specific detail.  This can
>> > >> +        * leave the hart unable to wake up, so just mark these states as
>> > >> +        * unsupported until we have a mechanism to expose these
>> > >> +        * platform-specific details to Linux.
>> > >> +        */
>> > >> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
>> > >> +               return false;
>> > >> +
>> > >>         return true;
>> > >>  }
>> > >>
>> > >> --
>> > >> 2.38.1
>> > >>
