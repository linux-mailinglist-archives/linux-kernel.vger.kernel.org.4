Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706486455C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLGIw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiLGIwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:52:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40733E08E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:49:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jl24so16407006plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl9k/tZmp2M3o9vWoGulbXjLnLmB2CSaqWgooXVeYYU=;
        b=tS2oNFlGx3C9xWFvpfeDWnftFCAWWLKgbr873HqhSro9BiCPD60udKR9UZPKNu5BmF
         wxgal9hkNwdvLGlCaWURux1nPfYpfkkWQY77B0nevM1n8Vyqlw99ObdNrgmFt7aFnOId
         IesF4ChxLOecr2GdWMtehTpdPG0JOKGtIiaR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl9k/tZmp2M3o9vWoGulbXjLnLmB2CSaqWgooXVeYYU=;
        b=THhfNatLM4AqTuZT2hcVBZrWhAQVdvTE8INJ7lelpXLIVnUDoVKcVk0FDw5WnpFpi4
         4HwSCs7vPQJ6kns1sFtQlf4SOoQpIvrqbJHz4H/bt0if7FGvaoBSSuZ4kp9+1lKlQlUe
         RjkBvmhTb7AATZpjUrEBBL+1e8GZKbMW+wrdsGJtS8MPkqRU9yXBKwg7UkuG4vBCYCqh
         MQB5+LIu3d/8Z9QLdWjrHWW1l8sAUxshd4ZON7nYVSb8oEEInECDfYaVpvQjyGDUOQq1
         hqhVc2kzL0x0BZzyAOsw0jHzdzO2EH5r3uamUiLpPUGF5qDLXwRDmiDuZRYYkB3dRzmR
         5GFQ==
X-Gm-Message-State: ANoB5pmYAn8thFVFmkToyDq00LtDko7/fBa6fiD0vXLQGcpgiom5GF8S
        RF9RClV33USzTQMhDKwknihEiy1vPT7XJ4wZUNpA
X-Google-Smtp-Source: AA0mqf5h6+Kn6yPACpEkecizghlMvEO4Hy7piJ4SZ6qUbMT3xofyJmjyHj356aso6Re5g/af83ZCSQykzu7oCurn1Ec=
X-Received: by 2002:a17:902:f095:b0:189:b352:a236 with SMTP id
 p21-20020a170902f09500b00189b352a236mr29549866pla.75.1670402961343; Wed, 07
 Dec 2022 00:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20220718170205.2972215-1-atishp@rivosinc.com> <20220718170205.2972215-9-atishp@rivosinc.com>
 <20221101153112.hpst2bohsdvqours@kamzik> <CAOnJCU++M5jd6toy1J8T+FPGJWSUaw8s9X7sxZY25naPoZeJJw@mail.gmail.com>
 <20221123142254.2mc3j27kgw37jblv@kamzik> <CAOnJCULCHZXLG18BNw=Fn8UaNb8hSMuvLAsA+j_4mX+_B27MYg@mail.gmail.com>
 <20221202113708.5sxbpnayj75xg6jp@kamzik>
In-Reply-To: <20221202113708.5sxbpnayj75xg6jp@kamzik>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 7 Dec 2022 00:49:09 -0800
Message-ID: <CAOnJCULeEupPNkttCxf5VRoKkff_pdXkZU8SfN-QSu9w-wz4Lw@mail.gmail.com>
Subject: Re: [RFC 8/9] RISC-V: KVM: Implement perf support
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 3:37 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Fri, Dec 02, 2022 at 01:08:47AM -0800, Atish Patra wrote:
> > On Wed, Nov 23, 2022 at 6:22 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > On Tue, Nov 22, 2022 at 04:45:16PM -0800, Atish Patra wrote:
> > > ...
> > > > This brings up another generic error returning problem in KVM SBI
> > > > land. Usually, SBI error code numbers do not
> > > > align with Linux error codes to accommodate other operating systems.
> > > > However, most of the SBI error codes
> > > > have 1-1 relationship with the Linux error code.
> > > > Thus, kvm internal code returns a Linux specific error code and
> > > > vcpu_sbi will map those to SBI error code using
> > > > kvm_linux_err_map_sbi.
> > > >
> > > > However, this will not work for SBI_ERR_ALREADY_STARTED/STOPPED as
> > > > there are no corresponding
> > > > Linux specific error codes. We can directly return the SBI error codes
> > > > from vcpu_pmu.c and modify the
> > > > kvm_linux_err_map_sbi to pass through those. In that case, we can't
> > > > map any linux error code that
> > > > collides with SBI error code. Any other ideas to handle this case ?
> > > >
> > >
> > > It seems like we should drop kvm_linux_err_map_sbi() and add another
> > > parameter to kvm_vcpu_sbi_extension.handler for the SBI error. Another
> >
> > That will just move the problem from the generic SBI layer to
> > extension specific layer.
> > The root problem remains the same as we can't expect the individual
> > extension to return
> > a valid linux specific error code.
>
> I'm saying we return both from the extension specific layer, particularly
> because only the extension specific layer knows what it should return.
> KVM's SBI handlers currently have a return value and *out_val. *out_val
> maps directly to SBI's sbiret.value, but the return value does not map to
> SBI's sbiret.error. But, all we have to do is add *error_val to the
> parameters for the extension handler to get it. Then, cp->a0 should be set
> to that, not the return value.
>

Ahh. Yes. That will solve this issue.

> >
> > Maybe we can relax that requirement. Thus, any extension that has
> > additional SBI error codes
> > may opt to return SBI error codes directly. For example, PMU extension
> > implementation will
> > directly SBI specific error codes from arch/riscv/kvm/vcpu_pmu.c. In
> > future, there will be other
> > extensions (e.g TEE) will have many more error codes that can leverage
> > this as well.
> >
> > Does that sound reasonable ?
>
> I think we need both the Linux return and sbiret.error. The return value
> indicates a problem *with* the emulation, while the new parameter I'm
> proposing (*error_val) is the return value *of* the emulation. Normally
> the Linux return value will be zero (a successful Linux call) even when
> emulating a failure (*error_val != SBI_SUCCESS). When the return value
> is not zero, then there's something wrong in KVM and the return value
> should be propagated to userspace. We could also set the exit_reason to
> KVM_EXIT_INTERNAL_ERROR, but KVM_EXIT_UNKNOWN is probably fine too.
>

Agreed. I revise the series accordingly. Thanks!

> >
> > > option is to continue mapping SBI errors to Linux errors, e.g.
> > > SBI_ERR_ALREADY_STARTED == EBUSY, but that may not be too easy in
> > > all cases and the errors become ambiguous, as we can't tell if the
> > > Linux implementation generated the error or if the SBI call did.
> > >
> >
> > We can't distinguish between SBI_ERR_ALREADY_STARTED/STOPPED in that case.
>
> That's why I only suggested using EBUSY for STARTED. Mapping STOPPED
> was left as an exercise for the reader :-)
>
> Thanks,
> drew



-- 
Regards,
Atish
