Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF78F5FD6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJMJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJMJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA920BDB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665652586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1PougXwFNeOBx9Qjbr5s56x+6pgJ2sjuaM5Urh09Fk=;
        b=hi7Sxs3NUN5tw74/8sYvvgVIUK8SB5X2/LwQmwLLi28U1NhOwQUi8ykWVXfSUFBrXEJ/l8
        xpxmpjd81gFK/6a/KiWWrDNc2mYmjUssfVDk3Lcclll7R6olcLfPAofB6bNHhb/ThLJOyS
        LleJ1zdyp3vTSwPWCjpFeNXr+s6JT08=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-pkM7bIR4P-apPcPF99o78g-1; Thu, 13 Oct 2022 05:16:25 -0400
X-MC-Unique: pkM7bIR4P-apPcPF99o78g-1
Received: by mail-wm1-f70.google.com with SMTP id g8-20020a05600c4ec800b003b4bcbdb63cso835422wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1PougXwFNeOBx9Qjbr5s56x+6pgJ2sjuaM5Urh09Fk=;
        b=CYkXur2LydasAXtrtU8O1UkAKsctC7pi8ertSY8/FAAXH2gNpIR+A+CwHcajvEf+Mm
         W0n7IJv14W475pGuVDb3Q/kXJrQl55karw2VXuVw8Ny9XSGpTKrkaOKEFz08eAwOjIbM
         Q7XZtQDad5LDtXbLqzwEkcuwC3zY/rEpbtAb8FGVQjvnFOR+XhAmPBxRA67kp4o/LT/q
         JQm/wQjCqymHI0C+ZJ/++j8C9OLE0Az2MIzyUK4PGP0N7lPHeT/fIhET/k9D1wWUi1gN
         fuSOTr7M5xXwaFS+9n1QkObeDwLhbMKPFKzdbhkGlEYx6iz6ZX3N8flxLOf6EDaWIwEI
         Nl9A==
X-Gm-Message-State: ACrzQf1eZi6mbdOT3ZHNxEiLfA8KwpZP3qMahEyy3A9MQdIfEoTbMXc7
        OnWXipTVDd6HQCKFonXzOO1ebuD6za1ySL0wf1NGcjy5hJDN/c3BaYCI3vWHsRr0W4OdHNNSAQG
        63AalumwaYQ2FXafNgCg9WIn475yxXKL03X+LQ0FoLtpnYC2OsWgBF4yhxx3l3l2jTopfVbuZgO
        CQ
X-Received: by 2002:a05:600c:1e88:b0:3c3:ecf:ce3e with SMTP id be8-20020a05600c1e8800b003c30ecfce3emr5656953wmb.15.1665652584207;
        Thu, 13 Oct 2022 02:16:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7lz0WlApvKFq530rS3Ksn4hAAN1MoaF0PVyZiyi2JurSmUe0qN78jbTg3xrD4n6KsUR0fbjQ==
X-Received: by 2002:a05:600c:1e88:b0:3c3:ecf:ce3e with SMTP id be8-20020a05600c1e8800b003c30ecfce3emr5656930wmb.15.1665652583965;
        Thu, 13 Oct 2022 02:16:23 -0700 (PDT)
Received: from ovpn-194-196.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b003b4ac05a8a4sm5313583wmq.27.2022.10.13.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 02:16:23 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] KVM: selftests: Test Hyper-V invariant TSC control
In-Reply-To: <Y0bwwfuO/iubQDPH@google.com>
References: <20220922143655.3721218-1-vkuznets@redhat.com>
 <20220922143655.3721218-7-vkuznets@redhat.com>
 <Y0XGuk4vwJBTU9oN@google.com> <87v8op6wq3.fsf@ovpn-194-196.brq.redhat.com>
 <Y0bwwfuO/iubQDPH@google.com>
Date:   Thu, 13 Oct 2022 11:16:22 +0200
Message-ID: <87pmew6q3d.fsf@ovpn-194-196.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 12, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 

...

>> > Aha!  Idea.  Assuming none of the MSRs are write-only, what about adding a prep
>> > patch to rework this code so that it verifies RDMSR returns what was written when
>> > a fault didn't occur.
>> >
>> 
>> There is at least one read-only MSR which comes to mind:
>> HV_X64_MSR_EOI.
>
> I assume s/read-only/write-only since it's EOI?
>

Yes, of course)

>> Also, some of the MSRs don't preserve the written value,
>> e.g. HV_X64_MSR_RESET which always reads as '0'.
>
> Hrm, that's annoying.

'Slightly annoying'. In fact, the test never writes anything besides '0'
to the MSR as the code is not ready to handle real vCPU reset. I'll
leave a TODO note about that.

...

> static bool is_write_only_msr(uint32_t msr)
> {
> 	return msr == HV_X64_MSR_EOI;
> }

This is all we need, basically. I'll go with that.

-- 
Vitaly

