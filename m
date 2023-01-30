Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFF6681797
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjA3RaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjA3RaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:30:10 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88E8DBF7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:30:09 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s67so8146364pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imRm0TVuDKih98UcdXW54yhAjaoqdG3K0rU9kjpphsc=;
        b=O3gLaZXsdfV7ARtUwCACtnBHsR9itq1M49AtpODcFKp/feHQHnE0hM4KWRENrv29Zs
         Zfxtqmjvj9rpoc2l/bWpjAClb4ONgAx702FLmnwzPeAGr9xq5TQTh/6N/CANbciLPfeD
         OnASZd7VUbY+aTpuswCn0cCPsA3XGy4e4yxpJ7bwMKotXRcjPPLVsnzDfmumMiqHupVX
         SnNmZ57ofRvQTqqkeYamnpVMY3jseFlhWzHIRMESpx3rt1ZdKXsoS7mdWTeRnoDlGvET
         bVjOHJclESlld/2hVY/UFW7BA9NL7t3U2FYS9M7hAjwFVJ5ZZJNhxR5tXWrjuGKVw9vk
         P0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imRm0TVuDKih98UcdXW54yhAjaoqdG3K0rU9kjpphsc=;
        b=Qp0aIp+Q5nGf/DtjUptG65jFIw+caWcyNkQmJlX/0AU4MF4bI/zZTQIFT6XPiEs1eQ
         cNj46tuR+H7doy0NtsKESuKVeHDmo1cNbhs22m9RXKBRc+haMp1zAeNkokW4c6vl8Wts
         RhRZh8Ngvv9cOdYe2s6kzbgobmKPTTr+H+jBiq1TaFHFwcoWgkUi1oszYhqRoNefdHcA
         7frR/izsv2TCCDxZcyCc5l8oIrKyLPbx+I7YOPByzq1qrsyhcANTf3PEl0rgDpakamyt
         /UlzJPAXqHxsUa8nvO2kcumJdQu80IH64UJxKi91YR7a+iI2ZhBKIjcSmBHRopZqqTzN
         wMwg==
X-Gm-Message-State: AO0yUKVKE4AgWRg2PrWk6i91Sfqu47hEf+EwSG+LMuYI09jllICCKuQl
        6UtcmMHmNw/VbtPbt0gdreXVnQ==
X-Google-Smtp-Source: AK7set/8CfdP1rTJBE3H9DH63ASq2elSW9p108f5E3o4NvYlMI4uNwEFa/NRPTjk+P0SrCEs61nQ+A==
X-Received: by 2002:aa7:858a:0:b0:590:7627:91b with SMTP id w10-20020aa7858a000000b005907627091bmr863050pfn.0.1675099809149;
        Mon, 30 Jan 2023 09:30:09 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79f82000000b00593c679d405sm2210624pfr.78.2023.01.30.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:30:07 -0800 (PST)
Date:   Mon, 30 Jan 2023 17:30:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, like.xu.linux@gmail.com,
        kan.liang@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH v2 14/15] KVM: x86: Add Arch LBR data MSR access interface
Message-ID: <Y9f+nDdnk8fHXRZe@google.com>
References: <20221125040604.5051-1-weijiang.yang@intel.com>
 <20221125040604.5051-15-weijiang.yang@intel.com>
 <Y9RMbq1FgygCPRrZ@google.com>
 <f70ea782-c7d4-0997-88e0-c24768fd02a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70ea782-c7d4-0997-88e0-c24768fd02a9@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023, Yang, Weijiang wrote:
> 
> On 1/28/2023 6:13 AM, Sean Christopherson wrote:
> > On Thu, Nov 24, 2022, Yang Weijiang wrote:
> > > Arch LBR MSRs are xsave-supported, but they're operated as "independent"
> > > xsave feature by PMU code, i.e., during thread/process context switch,
> > > the MSRs are saved/restored with perf_event_task_sched_{in|out} instead
> > > of generic kernel fpu switch code, i.e.,save_fpregs_to_fpstate() and
> > > restore_fpregs_from_fpstate(). When vcpu guest/host fpu state swap happens,
> > > Arch LBR MSRs are retained so they can be accessed directly.
> > > 
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > >   arch/x86/kvm/vmx/pmu_intel.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> > > index b57944d5e7d8..241128972776 100644
> > > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > > @@ -410,6 +410,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > >   			msr_info->data = vmcs_read64(GUEST_IA32_LBR_CTL);
> > >   		}
> > >   		return 0;
> > > +	case MSR_ARCH_LBR_FROM_0 ... MSR_ARCH_LBR_FROM_0 + 31:
> > > +	case MSR_ARCH_LBR_TO_0 ... MSR_ARCH_LBR_TO_0 + 31:
> > > +	case MSR_ARCH_LBR_INFO_0 ... MSR_ARCH_LBR_INFO_0 + 31:
> > > +		rdmsrl(msr_info->index, msr_info->data);
> > I don't see how this is correct.  As called out in patch 5:
> > 
> >   : If for some magical reason it's safe to access arch LBR MSRs without disabling
> >   : IRQs and confirming perf event ownership, I want to see a very detailed changelog
> >   : explaining exactly how that magic works.
> 
> The MSR lists here are just for live migration. When arch-lbr is active,
> these MSRs are passed through to guest.

None of that explains how the guest's MSR values are guaranteed to be resident
in hardware.
