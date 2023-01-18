Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5667F672A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjARVeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjARVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:33:58 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932362D13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:33:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 20so411900plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PV2LLjcXwxGB4uAP0cXtlo+9pb6/lAlmJvlfTFPpKO0=;
        b=jClde1svtNxzd4S5YpqLYxhB5hDETtoHp4f98weH3OKDzKvrFMdPXPDW7GNYj7KzP6
         IAOODq4osxaWdKQIztfYn6p2PEETi9Y1foDc5Ho2m99IAPDykVHkiV9eYhri8cSRdTEv
         DTK03VrwpCnS5yMQMMdo1V+JcDVvnecZFy89o5zutgd2dl7qtn61gSYxGYCee3FLvM3S
         fjQUJoP0iuKFTPBXimR1s1PnYwovsVdbLYRXH7Ajxn3nqSIkvOEVj1vb5nTCH3f9l6kn
         v8htsXGKXcijvhSlD1M+mnlUEbO/WCI2btqI+QRP4Li157TCJGwuDw38TzYaJwNng0F5
         6Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV2LLjcXwxGB4uAP0cXtlo+9pb6/lAlmJvlfTFPpKO0=;
        b=Ixgmxj08BhT9xHom0DXfj/XO8EmY2pOkJl2ykSr3prGqIGJ6aAVv4zDzBm3np+ka3d
         4xIhN9zADTd39hlamfhAgFsi7e/4qgzabYCZh3Gb2Pj6ROtLmLq3mqgoJNX9HVnCQ0F8
         fY+OafRre+tLRj50l7GZP0PJSA81Km3InFYm0KZbfRwhNi3lp/HJdnFYO12MiWXX6or3
         EJX0lc91npqEbiqZ4/vYlkqzKLfHWEWinij/Se42lUVpy+JxRat1W2aeBZdfCeGcKiAg
         P6uqpvFW0hbO+yEfiD/75Ts+YZrV0rLxR4xqjvAQgmT/qj2/Hk29iN1u2jq85sMRW5k8
         XE+w==
X-Gm-Message-State: AFqh2kryjHIqHS2wUwD61jnTnQ19vaDWe17bjAoFuFKCPQl6muj6k00R
        5bHNZH0sgGAFtKnGzOcO6XdJNQ==
X-Google-Smtp-Source: AMrXdXtmY68VQO8PeJqA2jW7tlmH+eNNquVAK7kXYpjOhcdoxIkG+SuufwVgmp4Q8YuAFk9vvmEUBQ==
X-Received: by 2002:a17:90a:fd12:b0:226:5758:a57f with SMTP id cv18-20020a17090afd1200b002265758a57fmr3340532pjb.2.1674077636822;
        Wed, 18 Jan 2023 13:33:56 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 8-20020a631448000000b004b25a51d6f4sm16484941pgu.36.2023.01.18.13.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:33:56 -0800 (PST)
Date:   Wed, 18 Jan 2023 21:33:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tobin@ibm.com" <tobin@ibm.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "slp@redhat.com" <slp@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "alpergun@google.com" <alpergun@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "harald@profian.com" <harald@profian.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcorr@google.com" <marcorr@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "nikunj@amd.com" <nikunj@amd.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "Rodel, Jorg" <jroedel@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH RFC v7 03/64] KVM: SVM: Advertise private memory support
 to KVM
Message-ID: <Y8hlwId/NlniGTe3@google.com>
References: <20221214194056.161492-1-michael.roth@amd.com>
 <20221214194056.161492-4-michael.roth@amd.com>
 <4e75a1a0b67e7b3ccaf6b140b08a5f2080aedbdb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e75a1a0b67e7b3ccaf6b140b08a5f2080aedbdb.camel@intel.com>
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

On Wed, Jan 18, 2023, Huang, Kai wrote:
> On Wed, 2022-12-14 at 13:39 -0600, Michael Roth wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 91352d692845..7f3e4d91c0c6 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -4694,6 +4694,14 @@ static int svm_vm_init(struct kvm *kvm)
> >  	return 0;
> >  }
> >  
> > +static int svm_private_mem_enabled(struct kvm *kvm)
> > +{
> > +	if (sev_guest(kvm))
> > +		return kvm->arch.upm_mode ? 1 : 0;
> > +
> > +	return IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING) ? 1 : 0;
> > +}
> > +
> 
> Is this new callback really needed?

Probably not.  For anything in this series that gets within spitting distance of
CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING, my recommendation is to make a mental note
but otherwise ignore things like this for now.  I suspect it will be much, much
more efficient to sort all of this out when I smush UPM+SNP+TDX together in a few
weeks.
