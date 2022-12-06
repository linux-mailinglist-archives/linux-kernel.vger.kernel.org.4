Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C038644300
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiLFMPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiLFMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:15:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9935E28E0F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670328879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfnsQkTVGKGVH3LJ5S/qrXgpnSxPTQM3pc2F7/mu5Uo=;
        b=RMRi2dVDNgzUSa7NABrJEIPt3YeSkTnLXX++S4viPO+wMv7aTaKeRjKwkT+YEeHiRMeYKk
        RXawCT3YGmSlFetClRQkVWM9wRu+xILB8T6QuTVX82YVn1SQjvVC9BfYcUheXmSmYKjzPR
        GkBl231+FkXBdx+dlfc4QkYrs/R7EvM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-hbLXKov_MiOgF2jE2sm9KA-1; Tue, 06 Dec 2022 07:14:29 -0500
X-MC-Unique: hbLXKov_MiOgF2jE2sm9KA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCBC385A588;
        Tue,  6 Dec 2022 12:14:27 +0000 (UTC)
Received: from starship (unknown [10.35.206.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F29C94EA61;
        Tue,  6 Dec 2022 12:14:23 +0000 (UTC)
Message-ID: <181f437164296e19683f086c11bf64c11a3f380e.camel@redhat.com>
Subject: Re: [PATCH v2 06/11] KVM: SVM: add wrappers to enable/disable IRET
 interception
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Santosh Shukla <santosh.shukla@amd.com>, kvm@vger.kernel.org
Cc:     Sandipan Das <sandipan.das@amd.com>,
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>
Date:   Tue, 06 Dec 2022 14:14:23 +0200
In-Reply-To: <41abb37b-c74a-f2cf-c0ce-74d5d6487e92@amd.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
         <20221129193717.513824-7-mlevitsk@redhat.com>
         <41abb37b-c74a-f2cf-c0ce-74d5d6487e92@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-05 at 21:11 +0530, Santosh Shukla wrote:
> On 11/30/2022 1:07 AM, Maxim Levitsky wrote:
> > SEV-ES guests don't use IRET interception for the detection of
> > an end of a NMI.
> > 
> > Therefore it makes sense to create a wrapper to avoid repeating
> > the check for the SEV-ES.
> > 
> > No functional change is intended.
> > 
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  arch/x86/kvm/svm/svm.c | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 512b2aa21137e2..cfed6ab29c839a 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -2468,16 +2468,29 @@ static int task_switch_interception(struct kvm_vcpu *vcpu)
> >  			       has_error_code, error_code);
> >  }
> >  
> > +static void svm_disable_iret_interception(struct vcpu_svm *svm)
> > +{
> > +	if (!sev_es_guest(svm->vcpu.kvm))
> > +		svm_clr_intercept(svm, INTERCEPT_IRET);
> > +}
> > +
> > +static void svm_enable_iret_interception(struct vcpu_svm *svm)
> > +{
> > +	if (!sev_es_guest(svm->vcpu.kvm))
> > +		svm_set_intercept(svm, INTERCEPT_IRET);
> > +}
> > +
> 
> nits:
> s/_iret_interception / _iret_intercept
> does that make sense?

Makes sense. I can also move this to svm.h near the svm_set_intercept(), I think
it better a better place for this function there if no objections.

Best regards,
	Maxim Levitsky
> 
> Thanks,
> Santosh
> 
> >  static int iret_interception(struct kvm_vcpu *vcpu)
> >  {
> >  	struct vcpu_svm *svm = to_svm(vcpu);
> >  
> >  	++vcpu->stat.nmi_window_exits;
> >  	svm->awaiting_iret_completion = true;
> > -	if (!sev_es_guest(vcpu->kvm)) {
> > -		svm_clr_intercept(svm, INTERCEPT_IRET);
> > +
> > +	svm_disable_iret_interception(svm);
> > +	if (!sev_es_guest(vcpu->kvm))
> >  		svm->nmi_iret_rip = kvm_rip_read(vcpu);
> > -	}
> > +
> >  	kvm_make_request(KVM_REQ_EVENT, vcpu);
> >  	return 1;
> >  }
> > @@ -3470,8 +3483,7 @@ static void svm_inject_nmi(struct kvm_vcpu *vcpu)
> >  		return;
> >  
> >  	svm->nmi_masked = true;
> > -	if (!sev_es_guest(vcpu->kvm))
> > -		svm_set_intercept(svm, INTERCEPT_IRET);
> > +	svm_enable_iret_interception(svm);
> >  	++vcpu->stat.nmi_injections;
> >  }
> >  
> > @@ -3614,12 +3626,10 @@ static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
> >  
> >  	if (masked) {
> >  		svm->nmi_masked = true;
> > -		if (!sev_es_guest(vcpu->kvm))
> > -			svm_set_intercept(svm, INTERCEPT_IRET);
> > +		svm_enable_iret_interception(svm);
> >  	} else {
> >  		svm->nmi_masked = false;
> > -		if (!sev_es_guest(vcpu->kvm))
> > -			svm_clr_intercept(svm, INTERCEPT_IRET);
> > +		svm_disable_iret_interception(svm);
> >  	}
> >  }
> >  


