Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B236A6A1D93
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBXOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBXOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:39:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BDA671D5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677249526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2Gy4jFQ+zLSzSW8KrNNW+axZfls8gC7MpzkteIHstE=;
        b=ISiHdA/+l8nnb2ZNj/qbuR0m+fCexDGXjFC/hlXP8e/P0QDHra4QkuoNkLDkH7aVxSy1cD
        k47M+kr6gS6M2Ij8OdZQJQs1H0vAAdPgJF4P/wfGNL+pBESmaY1UTobT80zwbwHISWOBsR
        8F0AbadFQEejK7N+670UfCwTKQS7hok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-hX4stdQMNL-i8pQYLIc0jA-1; Fri, 24 Feb 2023 09:38:44 -0500
X-MC-Unique: hX4stdQMNL-i8pQYLIc0jA-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so1307531wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2Gy4jFQ+zLSzSW8KrNNW+axZfls8gC7MpzkteIHstE=;
        b=laIQDHZ1mymwAKCUUtjbfvnJ0N9H3Q6gt31qmhH3CTJ9OpFAQ87UXPnUS30VEI3ya5
         pV0bEyhZgzbcBO3Zfx2Qwcq2s9juKx7IQIENEReHzb699KqnbC0PFfArdfzMsmYbF40X
         /6Eu4WkHp31b4kIp4ztnzWEgdGZqtpv/2gcIBZvcnmRzllwyYRpVJpu4tkyycMYjO10i
         bsA8qxgWpZDJXAXo6c+0g1/A+wON9Fg+odD2ZfglBGdMWa4D4lxv9IXBPGuCjmz4ovZW
         Vg9MaRUe+EO7Kv1533KheomKvVNMWx4W27t4rb5/f2BfxIIL1UyJPQSC+IEHirodEdTD
         y5hw==
X-Gm-Message-State: AO0yUKXRhfZ45cI9JGObIuQmxpCBxkXYGNlTQX8hmCqaDptHwfoBdeNc
        tCGCngGJ0RDGgJCrKfjrffP2g+m9VMa9IN6Q9EkJVm81Q7TDpfEp2GvTL+0lvukUyXrj4X6ZbDc
        PwbsQLQOEHVxWwewqPrSn6suc
X-Received: by 2002:a1c:7709:0:b0:3ea:fc95:7bf with SMTP id t9-20020a1c7709000000b003eafc9507bfmr2549596wmi.30.1677249523662;
        Fri, 24 Feb 2023 06:38:43 -0800 (PST)
X-Google-Smtp-Source: AK7set9tLVciTVQHdrXjudS/wXkv9w4eH0viCfjQ59ETlgYApLfO7oWjZ7S1UtLnq/jiiyKjNB6iAg==
X-Received: by 2002:a1c:7709:0:b0:3ea:fc95:7bf with SMTP id t9-20020a1c7709000000b003eafc9507bfmr2549588wmi.30.1677249523503;
        Fri, 24 Feb 2023 06:38:43 -0800 (PST)
Received: from starship ([89.237.96.70])
        by smtp.gmail.com with ESMTPSA id ja20-20020a05600c557400b003dfefe115b9sm3062964wmb.0.2023.02.24.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:38:43 -0800 (PST)
Message-ID: <818358bee687c999d715a90f594eb02207c74e82.camel@redhat.com>
Subject: Re: [PATCH v2 05/11] KVM: x86: emulator: stop using raw host flags
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Date:   Fri, 24 Feb 2023 16:38:40 +0200
In-Reply-To: <Y9RzSJuGmIQf1kxA@google.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
         <20221129193717.513824-6-mlevitsk@redhat.com> <Y9RzSJuGmIQf1kxA@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-01-28 at 00:58 +0000, Sean Christopherson wrote:
> On Tue, Nov 29, 2022, Maxim Levitsky wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index f18f579ebde81c..85d2a12c214dda 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -8138,9 +8138,14 @@ static void emulator_set_nmi_mask(struct x86_emulate_ctxt *ctxt, bool masked)
> >  	static_call(kvm_x86_set_nmi_mask)(emul_to_vcpu(ctxt), masked);
> >  }
> >  
> > -static unsigned emulator_get_hflags(struct x86_emulate_ctxt *ctxt)
> > +static bool emulator_in_smm(struct x86_emulate_ctxt *ctxt)
> >  {
> > -	return emul_to_vcpu(ctxt)->arch.hflags;
> > +	return emul_to_vcpu(ctxt)->arch.hflags & HF_SMM_MASK;
> 
> This needs to be is_smm() as HF_SMM_MASK is undefined if CONFIG_KVM_SMM=n.
> 
> > +}
> > +
> > +static bool emulator_in_guest_mode(struct x86_emulate_ctxt *ctxt)
> > +{
> > +	return emul_to_vcpu(ctxt)->arch.hflags & HF_GUEST_MASK;
> 
> And just use is_guest_mode() here.
> 

Makes sense.

