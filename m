Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7796402EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiLBJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiLBJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:09:01 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6C9D81F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:08:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so4607645pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uKuDlheAQlnav8x6wCebRhCDj6K0PqB5VyLpGNot6uQ=;
        b=eFwIUrE3URGqzTcbT11JFGw5DbAFWjIjzCgyRMl0GxK7ZXbtVyfPH0OAB3TkwmySWk
         P0BSDycSCFzmhA/x4pSDiB43sdeXm6W2om7k1lPF398sOj5HuuzvtmZLI37LzY7WMFHa
         kTrQWMX1D3uDeVgjyOolV4R5aCpMR0HTr+xrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKuDlheAQlnav8x6wCebRhCDj6K0PqB5VyLpGNot6uQ=;
        b=yZZ2cDouCE7pxd3M+uJzQ75fLfa3bIynjw979VEKZbLqCMtEBVs4PlH8cyojps4S85
         7KlfHOWh2OiVqq8JwGYrn1zuOBB56LkN3k9EynnwGnpM41eFeNDxKohr680DNr1sn9v7
         FdTqpsT+n+DitOV16vPLNDVuVQVEb7bzXKw5vJ+kW+cVeM3Dr0jcMDsJCytrOmGg5ExO
         Mkdcq6Jhwqapc3sRK1h+LijQOfb1mvMUGqrm5f1zy9ujuFZ6icULQ1JYY5L8Tbug3zXf
         uU070SK44rznyIdqj5cerog2ZWVrDiVY8hExxxQWSYE4t47brgH9MmjnAsrovlV8Nwpo
         Ol9w==
X-Gm-Message-State: ANoB5plJ+FxrDeNJ8WLfmBripTp6zlk+Dd69R59k8ehhKEfHQMX3vyC6
        aTRcoOMwymfvSulkeGanEeZ8Ygv3mL+TyLu/t6Q35yPSYBeRf+4=
X-Google-Smtp-Source: AA0mqf5lRB9PRRAJMtQEDr+mr8TWCBn4M2WVdZNdbbxOIDDfHUKFDXZnwg7nqSUeKoYfsoVMfdSLiL6t+V+z6jscN0A=
X-Received: by 2002:a17:902:f095:b0:189:b352:a236 with SMTP id
 p21-20020a170902f09500b00189b352a236mr7016505pla.75.1669972139006; Fri, 02
 Dec 2022 01:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20220718170205.2972215-1-atishp@rivosinc.com> <20220718170205.2972215-9-atishp@rivosinc.com>
 <20221101153112.hpst2bohsdvqours@kamzik> <CAOnJCU++M5jd6toy1J8T+FPGJWSUaw8s9X7sxZY25naPoZeJJw@mail.gmail.com>
 <20221123142254.2mc3j27kgw37jblv@kamzik>
In-Reply-To: <20221123142254.2mc3j27kgw37jblv@kamzik>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 2 Dec 2022 01:08:47 -0800
Message-ID: <CAOnJCULCHZXLG18BNw=Fn8UaNb8hSMuvLAsA+j_4mX+_B27MYg@mail.gmail.com>
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

On Wed, Nov 23, 2022 at 6:22 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Tue, Nov 22, 2022 at 04:45:16PM -0800, Atish Patra wrote:
> ...
> > This brings up another generic error returning problem in KVM SBI
> > land. Usually, SBI error code numbers do not
> > align with Linux error codes to accommodate other operating systems.
> > However, most of the SBI error codes
> > have 1-1 relationship with the Linux error code.
> > Thus, kvm internal code returns a Linux specific error code and
> > vcpu_sbi will map those to SBI error code using
> > kvm_linux_err_map_sbi.
> >
> > However, this will not work for SBI_ERR_ALREADY_STARTED/STOPPED as
> > there are no corresponding
> > Linux specific error codes. We can directly return the SBI error codes
> > from vcpu_pmu.c and modify the
> > kvm_linux_err_map_sbi to pass through those. In that case, we can't
> > map any linux error code that
> > collides with SBI error code. Any other ideas to handle this case ?
> >
>
> It seems like we should drop kvm_linux_err_map_sbi() and add another
> parameter to kvm_vcpu_sbi_extension.handler for the SBI error. Another

That will just move the problem from the generic SBI layer to
extension specific layer.
The root problem remains the same as we can't expect the individual
extension to return
a valid linux specific error code.

Maybe we can relax that requirement. Thus, any extension that has
additional SBI error codes
may opt to return SBI error codes directly. For example, PMU extension
implementation will
directly SBI specific error codes from arch/riscv/kvm/vcpu_pmu.c. In
future, there will be other
extensions (e.g TEE) will have many more error codes that can leverage
this as well.

Does that sound reasonable ?

> option is to continue mapping SBI errors to Linux errors, e.g.
> SBI_ERR_ALREADY_STARTED == EBUSY, but that may not be too easy in
> all cases and the errors become ambiguous, as we can't tell if the
> Linux implementation generated the error or if the SBI call did.
>

We can't distinguish between SBI_ERR_ALREADY_STARTED/STOPPED in that case.

> Thanks,
> drew



-- 
Regards,
Atish
