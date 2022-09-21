Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44F5C045F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIUQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiIUQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:38:22 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D896FC1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:23:52 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11eab59db71so9776342fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=c0RkeYzaVmPEsrZ5EMX9GaWUzmBrwnO4Ngp7mcr6270=;
        b=mclHjr/Fs7SL8F+F1lWzX0r9UcdRoDguRRxPSp+ho6sqozHcX+AjvJ5xpr0V3e1/Q/
         +c+WVecvKeIFAn8SIlKHOt/eEiV+zHBPoLKh+fwlCmVx7Lm4QtY1uOW1czzBfhvybyUF
         +HoxJk/yRuTrdb2Ot8vLIw2Pyv+VmyEMNe8x8ORYb9gPlZaqR4i3mw7IBvtsQiUQ5qMl
         zD2bNR3+acOJOi+D7XFMIEwwKFdUTK/G4gViPhJ9xLHg8rpDx8UZlaI+HyckwibnSeSh
         r05ZMc6qgdf1jRIPWKNygBlVDuBxocBMoye/PC88Kpau/Z6Pe2cbvkw+8QITUJ9Chgt/
         GZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c0RkeYzaVmPEsrZ5EMX9GaWUzmBrwnO4Ngp7mcr6270=;
        b=m/oMQ9XGywYsYnyPmstKV4xe5PMCyoAfeo178dHgVlApuL3Fc558Jdtgh+d25N5vBS
         RJidEtnoZZZGpSAjQaVqNIUMXG75VcVqlgT4A6XRxCnpu9YZ0gdY77LbdyxpSupCTzTY
         Dn+7cT/n2bWjTRVd37xfXLIr2cfLeoYOanHh3CdNTWvlblgIEU/pGAvB2fqp3zh911RV
         2chI0yEBxqlwk+JY61z4+VGT86p4sXFI2/sirrI/+lpyfu7HYrqmXlm3k29HcEE4MvS5
         n0jnb6KLuGLS1EG8OOg0Lc2cdoM1jDwQdFmIwjbtu+R+4hNWRL6ZBRKiJbe7DugLRphg
         Xrbw==
X-Gm-Message-State: ACrzQf2adrls1KLl4wdnU7gbEU/HNjZcAI9NnLB23swKwLYorRACpAdX
        H+HzQkWCSht/yx+PsGY8DfWewihMEUPYHVG8ay9Tlw==
X-Google-Smtp-Source: AMsMyM6udKO0mM416CuGNqHAwIob8j7/AVRQHFn1HV+/sWmesQmURFFmLUYUAP/MZg19xYHGWdzVHZOYi3AOvF4Mwuc=
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id
 r12-20020a056870580c00b0012af136a8f5mr5412294oap.269.1663777431692; Wed, 21
 Sep 2022 09:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220920205922.1564814-1-jmattson@google.com> <Yyot34LGkFR2/j5f@zn.tnic>
 <CALMp9eQijCKS-E_OWJkxdqAur3BthciOWEtEPH5YKd0-HJiQQA@mail.gmail.com>
 <YyrZOLq8z+lIORvP@zn.tnic> <CALMp9eRG6g-95zCxTD1NnxpZ+Vm6VMTA0_uaHV=b-hDkeOYSuA@mail.gmail.com>
 <YysXeXKY36yXj68q@zn.tnic> <CALMp9eTuO79+NfHxLi8FnqdOpzXO7eQUntvN23EfR+shg+wg2Q@mail.gmail.com>
 <Yys2ikzV73upzlEj@zn.tnic>
In-Reply-To: <Yys2ikzV73upzlEj@zn.tnic>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Sep 2022 09:23:40 -0700
Message-ID: <CALMp9eQ-qkjBm8qPhOaMzZLWeHJcrwksV+XLQ9DfOQ_i1aykqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] KVM: EFER.LMSLE cleanup
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 9:06 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 21, 2022 at 08:11:29AM -0700, Jim Mattson wrote:
> > Yes, after the revert, KVM will treat the bit as reserved, and it will
> > synthesize a #GP, *in violation of the architectural specification.*
>
> Architectural, schmarchitectural... Intel hasn't implemented it so meh.
>
> > KVM can't just decide willy nilly to reserve arbitrary bits. If it is
> > in violation of AMD's architectural specification, the virtual CPU is
> > defective.
>
> Grrr, after your revert that this bit was *only* reserved and nothing
> else to KVM. Like every other reserved bit in EFER. Yeah, yeah, AMD
> specified it as architectural but Intel didn't implement it so there's
> this thing on paper and there's reality...

AMD defined the 64-bit x86 extensions while Intel was distracted with
their VLIW science fair project. In this space, Intel produces AMD64
compatible CPUs. The definitive specification comes from AMD (which is
sad, because AMD's documentation is abysmal).
