Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3985B7C39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIMUcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIMUcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:32:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A00246DAF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:32:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o5so6186675wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=W/kNFX+UVsRhlfnnY6LZ31QHfXkEmRJPKTrlmwQLsJs=;
        b=kziS82AbXi/57DWxCf8M6fB5OPjfu63b3vSVvnVq6N1kz2Hfv7c+GOY0ZTXSfDn7YX
         U+3iYdEACy7SvfY3aLRDadKRGacO5GfMKJ53jsBNEYVoQvCf2OQeapm8tlXPz/BtCyEv
         rhpUWjI5ZO327bppN/ti0OzJLvdyuGIJvFfQOkZaSn+ILUObT6bNIiBUlNSOhc/5HY5D
         T6Utr72Y6EEY9imTyQ8XxfvpqOvVr2kaeOcX0wmx5aykW0MMjQZx0Y+LHpX5Er2syPaw
         TqAudyV5rBl6sOaebOLGhlOpq7h065e8lO6tBLpw0+oUpyjM6fIkdeKUw4ElrBFLu7bq
         6ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W/kNFX+UVsRhlfnnY6LZ31QHfXkEmRJPKTrlmwQLsJs=;
        b=m8CpXiitTL4gUXDvYoXJI9Mt2xfLJWBPdSVUHA2KjJpUOqPKCFeFFZnKSi+7cAs4un
         uqMEtcED2olwhwtf/jEgjWqGgoBhWUylQt7tnkqSf6mGwjfU9mUjfYauF2eO1GK5Ahkp
         pwikg5kveNgETdDK6nQtZv1MCV9FJM5CbTS3X/qsAF4xnOX9q3hEc+Xm6LjTCfJ37YIB
         aojAC5WBu2QQkOIVlO0+LPQrO0esU3Npc7BxQc6TRpdDyMYmNmoKmKUq+qRsXKdTtdBp
         sAdRHOR2K0euA4USFtMx5b4hBJQGqGKgirrtVqLvNttJ1X1IXlCIJqomiwOBxyqx8Bhr
         WKBw==
X-Gm-Message-State: ACgBeo1HnfP9z9WazXPs4bSxpfrrVdGTmqsTBy9zSHCc3WrXJ5UCfq/U
        uDes9Jqj7zJKlHHGhndC1y4+iNLckLtAgDVuqPs8iTz9aiveuw==
X-Google-Smtp-Source: AA6agR7Y4yGI+hyJHUTfBkzK9VwzQ4shU8Zx9Y9evja4YN+GdEZJYsRJHnAv25itPUGrA53PzzFYe0BNgWBsby9kRQw=
X-Received: by 2002:a05:600c:4f0e:b0:3a6:3395:ec12 with SMTP id
 l14-20020a05600c4f0e00b003a63395ec12mr693351wmq.181.1663101138470; Tue, 13
 Sep 2022 13:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220907003630.1115439-1-eugenis@google.com> <CAMn1gO4X93khAqOOvCJjWmm410rv8S5847GfsPckJwqtLSzc-Q@mail.gmail.com>
 <Yx+QutrpakTEyRjW@arm.com>
In-Reply-To: <Yx+QutrpakTEyRjW@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 13 Sep 2022 13:32:07 -0700
Message-ID: <CAMn1gO7vf7EKvdo-w_ez5aBDWaNRm=X_qRfReVtUkA5LOF127A@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: mte: move register initialization to C
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kenny Root <kroot@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 1:04 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Sep 09, 2022 at 05:54:13PM -0700, Peter Collingbourne wrote:
> > On Tue, Sep 6, 2022 at 5:36 PM Evgenii Stepanov <eugenis@google.com> wrote:
> > > If FEAT_MTE2 is disabled via the arm64.nomte command line argument on a
> > > CPU that claims to support FEAT_MTE2, the kernel will use Tagged Normal
> > > in the MAIR. If we interpret arm64.nomte to mean that the CPU does not
> > > in fact implement FEAT_MTE2, setting the system register like this may
> > > lead to UNSPECIFIED behavior. Fix it by arranging for MAIR to be set
> > > in the C function cpu_enable_mte which is called based on the sanitized
> > > version of the system register.
> > >
> > > There is no need for the rest of the MTE-related system register
> > > initialization to happen from assembly, with the exception of TCR_EL1,
> > > which must be set to include at least TBI1 because the secondary CPUs
> > > access KASan-allocated data structures early. Therefore, make the TCR_EL1
> > > initialization unconditional and move the rest of the initialization to
> > > cpu_enable_mte so that we no longer have a dependency on the unsanitized
> > > ID register value.
> >
> > Moving the register initialization to C also fixes a bug where the
> > kernel's zeroing of TFSR_EL1 has no practical effect when the kernel
> > is started in VHE mode because the register is currently being zeroed
> > prior to the kernel enabling the redirect of TFSR_EL2 to TFSR_EL1 when
> > it enables VHE. As a result, without this patch it is possible to get
> > a spurious KASAN error report if TFSR_EL2 is non-zero out of reset.
>
> Oh, I think this is a side-effect of the nVHE patches. We added MTE in
> 5.10 and __cpu_setup() was called at EL2 if the kernel was entered at
> EL2 - 3b714d24ef17 ("arm64: mte: CPU feature detection and initial
> sysreg configuration"). When nVHE turned up in 5.12, this was changed to
> to run __cpu_setup at EL1 and this only initialises TFSR_EL1.
> __finalise_el2 should have transferred TFSR_EL12.
>
> I don't think there other registers we missed in __cpu_setup() but I
> haven't looked in detail.
>
> So for this, we either move the reg initialisation to C or we fix
> __finalise_el2. I'm tempted to go with the former as long as the kernel
> doesn't read that register up to that point and complain of a spurious
> asynchronous fault.

Yes, I don't think we can generally expect the kernel to read the
register up to that point. The register is generally only read in
response to an exception, and the early kernel initialization code
runs with interrupts disabled and only enables them well after the
call to smp_prepare_boot_cpu() for the primary CPU (see the calls to
local_irq_disable() and local_irq_enable() in start_kernel()) and
check_local_cpu_capabilities() for the secondaries (see the call to
local_daif_restore() in secondary_start_kernel()), so unless something
has gone seriously wrong that would cause us to get a synchronous
exception that early (in which case the spurious async fault report is
the least of our worries) I don't think we should expect to see one of
these reports as a result of moving the initialization code to C.

Peter
