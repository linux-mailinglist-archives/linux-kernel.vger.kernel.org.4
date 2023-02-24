Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8136A1F75
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBXQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBXQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:16:43 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E170ED1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:16:42 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m10-20020a17090a668a00b002371fb8da57so1321392pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByVfkV4Kg0xQl/QzeZ3aF7bFQg5cuRP9o4M+2l+1QKc=;
        b=BM1FfHzgxMewIj4HhgkSYt7dJqL5ULeJ3s2CoLIwqCVFDifrPnhDqkOOH11czafGGK
         ARL+JhFq9fSe3mz+aU2JB0t9CgUr+svs6Cys35y8+8njln7xNQw3jErFO3vWBmY9MNrX
         NRjnHBx6yUKvR6VfOOmBGKDHp7obW4h7Y8+g6U3DSCnW2T/Z4wY7tQTQJcslBAI7ZXgO
         h2+7s15oG6kPxKz02nZGnNj6KooDb7xJ1iykcSqk3p0hYEZeu3fCW6Ir4nbQANOCvXzQ
         btcT+4igkGE4x2WTIOx/Kd1KDyfm98OXp53vdYvw04c2F2nJq6cjdOs/RWtHdtr/qunk
         NLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByVfkV4Kg0xQl/QzeZ3aF7bFQg5cuRP9o4M+2l+1QKc=;
        b=2X5ojnIcA4h1NmWnZCF7lcmJvQysxAxVSdCFy6Z/paiMdz1YulBW06gZfgph1uFOzo
         E1HPyo05c3vNpjS7TZ36ajIVVvVOIGhtVuaBT2XIuYlaXmojQw/j8zozpTO7QPZ9uEP0
         /UxmG3oSaXhe1WPip5dPd7apFqSdiNJkK2r47jNBStvl0cAduLHSt02XG6gMMCbCIpdp
         vUAFesCS/StcxGTJiE0uaXbSU8nqE5+nVSaenz4eXijVgTxP3eHmmMbHwkRT5OtW1xNi
         Rtsu8pdJqR4Jl0Y14SCp887L9YVEW8ozu/geSeC+oPJFs1jbaRR65Dopw9jKDyOqkK5k
         nMNQ==
X-Gm-Message-State: AO0yUKXGWJSutjkm40vJu63NWfdc7D1FCybnE4luOGAoUMG62Oj0Kjdg
        Aowj5oVGILD24a6UUcrPkhMPzl9flZE=
X-Google-Smtp-Source: AK7set8E8rFcUHRVLDwqW0KCkEYyhSC7jIe9uIMQnKtZswJN8MvAro10BiCqXLSIuqmxAnT+kYSxOG5JAHg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:8602:0:b0:5df:9809:6220 with SMTP id
 x2-20020a628602000000b005df98096220mr1517427pfd.3.1677255401689; Fri, 24 Feb
 2023 08:16:41 -0800 (PST)
Date:   Fri, 24 Feb 2023 08:16:40 -0800
In-Reply-To: <20230224092552.6olrcx2ryo4sexxm@linux.intel.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com> <20230217231022.816138-9-seanjc@google.com>
 <20230221152349.ulcjtbnvziair7ff@linux.intel.com> <20230221153306.qubx7tfmasnvodeu@linux.intel.com>
 <Y/VYN3n/lHePiDxM@google.com> <20230222064931.ppz6berhfr4edewf@linux.intel.com>
 <Y/ZFJfspU6L2RmQS@google.com> <20230224092552.6olrcx2ryo4sexxm@linux.intel.com>
Message-ID: <Y/ji6MAlEmbNfZzf@google.com>
Subject: Re: [PATCH 08/12] KVM: nSVM: Use KVM-governed feature framework to
 track "vVM{SAVE,LOAD} enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023, Yu Zhang wrote:
> On Wed, Feb 22, 2023 at 08:39:01AM -0800, Sean Christopherson wrote:
> > +Maxim
> > 
> > On Wed, Feb 22, 2023, Yu Zhang wrote:
> > > On Tue, Feb 21, 2023 at 03:48:07PM -0800, Sean Christopherson wrote:
> > Nope, my interpretation is wrong.  vmload_vmsave_interception() clears the upper
> > bits of SYSENTER_{EIP,ESP}
> > 
> > 	if (vmload) {
> > 		svm_copy_vmloadsave_state(svm->vmcb, vmcb12);
> > 		svm->sysenter_eip_hi = 0;
> > 		svm->sysenter_esp_hi = 0;
> > 	} else {
> > 		svm_copy_vmloadsave_state(vmcb12, svm->vmcb);
> > 	}
> > 
> > From commit adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD"):
> >     
> >     3. Disable vmload/vmsave virtualization if vendor=GenuineIntel.
> >        (It is somewhat insane to set vendor=GenuineIntel and still enable
> >        SVM for the guest but well whatever).
> >        Then zero the high 32 bit parts when kvm intercepts and emulates vmload.
> > 
> > Presumably AMD hardware loads only the lower 32 bits, which would leave garbage
> > in the upper bits and even leak state from L1 to L2 (again ignoring the fact that
> > exposing SVM to an Intel vCPU is bonkers).
> Is it because L1 is a VM migrated from Intel platform to AMD's?

I believe so.

> So w/o commit adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD"):
> 1> L1 could be a "GenuineIntel" with SVM capability (bizarre as it is), running
> in 64-bit mode.
> 2> With no interception of MSR writes to the SYSENTER_EIP/ESP, L1 may set its
> SYSENTER_EIP/ESP to a 64-bit value successfully (though sysenter/sysexit may
> fail).

Yes, though the MSRs don't need to be passed through, KVM emulates the full 64 bits
if the guest CPUID model is Intel.

> 3> L2 could be in 32-bit mode. And if virtual vmload/vmsave is enabled for L1,
> only lower 32 bits of those MSRs will be loaded, leaking the higher 32 bits.
> 
> Is above scenario the reason of Maxim's fix?

Yes, that's my understanding.

> But why it is related to nested migration? 

I understand why it's related, but I don't understand why we bothered to add "support"
for this.

In theory, if L1 is migrated by L0 while L1 is running an L2 that uses SYSENTER,
problems will occur.  I'm a bit lost as to how this matters in practice, as KVM
doesn't support cross-vendor nested virtualization, and if L1 can be enlightened
to the point where it can switch from VMX=>SVM during migration, what's the point
of doing a migration?
