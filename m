Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2372677D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjFGReP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFGReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:34:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E72133
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:33:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56991d8e2b0so84457497b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686159217; x=1688751217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrvlFX4oFue6cKXeKvjlbAUr31FSZk7nZtVzLKuSdGs=;
        b=AMGvMwjeJtuuRzucjjELaO2Iy8FKyMVka0NqPPO1oa0hkc7TfZAC1DkWxQjJQKvbJz
         77NvTR892gMBX/qGXiSFU+Any6ZIvSOanPxAxC8VSIgMxCk3MMuYHLVhot4wq9Re0FpM
         Mn0OyrYQbnG06uGgry9TH61k9EvB0KeDXARqrwybTz9cleTsIHQBKyLVacRJN+wzjIC2
         RhqWmGikxMKdrFP3AyNgyTbkUh8JeSlAMFHbNNvl6Dk/p2sk8bS6mvudcGEWNcAEN1lC
         9ia1f6uyjXLtufM0OwuLGNdR/M5DQl+XNNRaMgMl2RZ6093YCMhnBA0zbZMxSVSeM7Hj
         9nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159217; x=1688751217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrvlFX4oFue6cKXeKvjlbAUr31FSZk7nZtVzLKuSdGs=;
        b=fkTReathB++mSgbogj4TRHhIzFHIAt2Mh8vk2VM7K9UO4sh/BOkpa78iAuM+9YLo7U
         h9D8CFLudIRNL10cEv8I30e8JM81sUBDndSV5fFWTOQSVhJuNW7teW8guPsxvtMzQP/b
         thBKgxHYryhq6sZdfn5rb6VvwrrjBj+F9VDtpq1KTcn18jspL+fp0Yww1XlCTKGJq3fF
         kKYxtU04Cdovhlux9DHHWA0PU2wn2rd/2jfZJTxY9QiQOu7N1togGU/P8qxy23p1dW5E
         J04sxjPyDZgr4B14qSFkzpg5YrIwmbI6xnnqOwlVSdUPja2BLxxdYM1mctEIEWYOSnde
         szOg==
X-Gm-Message-State: AC+VfDwwIJZLTjTkjP+CixHdIpMRrE/Xdny749yseROZlGokHwABqorY
        ATxFRgRJVSg+F98SHQOXb+Dhs6AVunk=
X-Google-Smtp-Source: ACHHUZ49ZslS3YzqF16cnmA6CXqQPwE2ESsktnTBpep3WLADMzB5f2yBhT2zmjLGyD7xP/QK2vPWu0ytXQU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a7c3:0:b0:568:ee83:d87d with SMTP id
 e186-20020a81a7c3000000b00568ee83d87dmr3039340ywh.5.1686159217286; Wed, 07
 Jun 2023 10:33:37 -0700 (PDT)
Date:   Wed, 7 Jun 2023 10:33:35 -0700
In-Reply-To: <ZICuhZHCqSYvR4IO@araj-dh-work>
Mime-Version: 1.0
References: <20230603193439.502645149@linutronix.de> <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx> <ZICuhZHCqSYvR4IO@araj-dh-work>
Message-ID: <ZIC/b+AwvH2wIz/o@google.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
From:   Sean Christopherson <seanjc@google.com>
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
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

On Wed, Jun 07, 2023, Ashok Raj wrote:
> On Tue, Jun 06, 2023 at 12:41:43AM +0200, Thomas Gleixner wrote:
> > On Mon, Jun 05 2023 at 10:41, Sean Christopherson wrote:
> > > On Sat, Jun 03, 2023, Thomas Gleixner wrote:
> > >> This is only half safe because HLT can resume execution due to NMI, SMI and
> > >> MCE. Unfortunately there is no real safe mechanism to "park" a CPU reliably,
> > >
> > > On Intel.  On AMD, enabling EFER.SVME and doing CLGI will block everything except
> > > single-step #DB (lol) and RESET.  #MC handling is implementation-dependent and
> > > *might* cause shutdown, but at least there's a chance it will work.  And presumably
> > > modern CPUs do pend the #MC until GIF=1.
> > 
> > Abusing SVME for that is definitely in the realm of creative bonus
> > points, but not necessarily a general purpose solution.
> > 
> > >> So parking them via INIT is not completely solving the problem, but it
> > >> takes at least NMI and SMI out of the picture.
> > >
> > > Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs indefinitely
> > > potentially cause problems too?
> > 
> > Not that I'm aware of. If so then this would be a hideous firmware bug
> > as firmware must be aware of CPUs which hang around in INIT independent
> > of this.
> 
> SMM does do the rendezvous of all CPUs, but also has a way to detect the
> blocked ones, in WFS via some package scoped ubox register. So it knows to
> skip those. I can find this in internal sources, but they aren't available
> in the edk2 open reference code. They happen to be documented only in the
> BWG, which isn't available freely.

Ah, so putting CPUs into WFS shouldn't result in odd delays.  At least not on
bare metal.  Hmm, and AFAIK the primary use case for SMM in VMs is for secure
boot, so taking SMIs after booting and putting CPUs back into WFS should be ok-ish.

Finding a victim to test this in a QEMU VM w/ Secure Boot would be nice to have.
