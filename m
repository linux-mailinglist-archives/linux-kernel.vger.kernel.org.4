Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE575EBF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiI0KM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiI0KMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5AD01FD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664273526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQd8FYCDQy3HQURocCej6OC1RjFJIa51YDrjxzf/0AM=;
        b=U3vvgK875JIM9z9kWf5FjyLm5AnzuAqNKknVpvMAT6+oIWN5CyksLOqIhqJ60WT344YdML
        vVLE5Mw1bggsDvzt15W7JlVDkBm1N6DZk5sHJzo50pys1jAdChpkiJdyx5hdmNr/e1AjEj
        54pcZ/V5K5pw9C6rRNnO0atbXsVE4Ro=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-qh24kdziOP28_dRX_oTLzg-1; Tue, 27 Sep 2022 06:11:59 -0400
X-MC-Unique: qh24kdziOP28_dRX_oTLzg-1
Received: by mail-ej1-f70.google.com with SMTP id gv43-20020a1709072beb00b0077c3f58a03eso3542812ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=OQd8FYCDQy3HQURocCej6OC1RjFJIa51YDrjxzf/0AM=;
        b=aMWXwSmH7cWmEQYyMT/QridPHfIHFV8pyQBjIXCro589//QI1WpU3t/pMkjaj8qMVf
         lF09Q067FK4uOpH5CM8FTkUCJD0GhzfchirlWh2oYNm2IObrv1xsFCcBI91phK8ppY8r
         gYNjEClk1JFZPgafY7rRfrxyE9PB67iM9eDTEbqGGbDgLOPHMixI9MrjMX5fT0EukdUo
         nvDmpiM7pWVI/ZnkKBD4xpo1ZVgI/hCPhAEmt5GqrEuUwX26LMoLQSHNrqB08k79hJ1Z
         ahqLyrYn3LhnMwYUqxA/wSP8TNZZxcY/Z5AEHndZ3p3dUReVeDUxFKbie3J3EeITwjOl
         hhJQ==
X-Gm-Message-State: ACrzQf23NjSSrDch84ryUXn+qkonpeAwNUQx06OgtaLtO/x7dfxVDEf+
        ROopWYYPHZ3t8OFb0Llh0t2rGnhd0cWBGSVIH5InOUB8nlkgvm9Xil1fyux6XjaxvnYv5QysPXt
        AQBRArYS5P/+OCom0NDJ6NrOlpBPgknFBDZaEYPYp144mZMaeicnki5moiYkeMzhOUpyiXLuwcr
        UF
X-Received: by 2002:a17:907:2d09:b0:781:d793:f51e with SMTP id gs9-20020a1709072d0900b00781d793f51emr4056435ejc.628.1664273518639;
        Tue, 27 Sep 2022 03:11:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5a/uFARed6CYSDEjLBgEocSIoC2LGZ4xrTfoHJ7Pq7WGxYRuIWKX+ve0FETVLwQS3Do7XTlg==
X-Received: by 2002:a17:907:2d09:b0:781:d793:f51e with SMTP id gs9-20020a1709072d0900b00781d793f51emr4056405ejc.628.1664273518308;
        Tue, 27 Sep 2022 03:11:58 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d41-20020a056402402900b0045703d699b9sm931101eda.78.2022.09.27.03.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:11:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86/hyperv: Move VMCB enlightenment definitions to
 hyperv-tlfs.h
In-Reply-To: <YyzgD0xp/Ki9a3jK@google.com>
References: <20220921201607.3156750-1-seanjc@google.com>
 <20220921201607.3156750-2-seanjc@google.com>
 <BYAPR21MB1688D04068DBA520366DA205D74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <YyzgD0xp/Ki9a3jK@google.com>
Date:   Tue, 27 Sep 2022 12:11:56 +0200
Message-ID: <87tu4tktxv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Sep 22, 2022, Michael Kelley (LINUX) wrote:
>> From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, September 21, 2022 1:16 PM
>> > 
>> > Move Hyper-V's VMCB enlightenment definitions to the TLFS header; the
>> > definitions come directly from the TLFS[*], not from KVM.
>> > 
>> > No functional change intended.
>> > 
>> > [*] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_svm_enlightened_vmcb_fields> 
>> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>> > ---
>> >  arch/x86/include/asm/hyperv-tlfs.h | 22 +++++++++++++++++++
>> >  arch/x86/kvm/svm/hyperv.h          | 35 ------------------------------
>> >  arch/x86/kvm/svm/svm_onhyperv.h    |  3 ++-
>> >  3 files changed, 24 insertions(+), 36 deletions(-)
>> >  delete mode 100644 arch/x86/kvm/svm/hyperv.h
>> > 
>> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> > index 0a9407dc0859..4c4f81daf5a2 100644
>> > --- a/arch/x86/include/asm/hyperv-tlfs.h
>> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> > @@ -584,6 +584,28 @@ struct hv_enlightened_vmcs {
>> > 
>> >  #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL			0xFFFF
>> > 
>> > +/*
>> > + * Hyper-V uses the software reserved 32 bytes in VMCB control area to expose
>> > + * SVM enlightenments to guests.
>> > + */
>> > +struct hv_enlightenments {
>> > +	struct __packed hv_enlightenments_control {
>> > +		u32 nested_flush_hypercall:1;
>> > +		u32 msr_bitmap:1;
>> > +		u32 enlightened_npt_tlb: 1;
>> > +		u32 reserved:29;
>> > +	} __packed hv_enlightenments_control;
>> > +	u32 hv_vp_id;
>> > +	u64 hv_vm_id;
>> > +	u64 partition_assist_page;
>> > +	u64 reserved;
>> > +} __packed;
>> > +
>> > +/*
>> > + * Hyper-V uses the software reserved clean bit in VMCB.
>> > + */
>> > +#define VMCB_HV_NESTED_ENLIGHTENMENTS		31
>> 
>> Is it feasible to change this identifier so it starts with HV_ like
>> everything else in this source code file, such as
>> HV_VMCB_NESTED_ENLIGHTENMENTS?  It doesn't look like it is
>> used in very many places.  
>
> Most definitely, IIRC it's used in only one spot.
>

I'll take these 4 patches to the next iteration of my "KVM: x86:
hyper-v: Fine-grained TLB flush + L2 TLB flush features" series and I'll
change VMCB_HV_NESTED_ENLIGHTENMENTS to HV_VMCB_NESTED_ENLIGHTENMENTS.

-- 
Vitaly

