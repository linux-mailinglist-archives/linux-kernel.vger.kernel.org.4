Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357A066E3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjAQQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjAQQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:41:03 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950533449
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:40:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g23so18519531plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=irxkDiWsgsAkQraKpHAy3FezkTWc4VGbQfrpFess5dk=;
        b=dVR1vS237CQ6fCANi/KMAsjNONLjHgvT1LOU/w6ZtQMxQizjSeunk8CmqQPk5DZA7H
         3NVI7tC+XsYK2dKreFABPpEfZwDDbMlOeTUb53Y/786BXRXTCV4JhmDwLHGNlsPGaIIi
         XoAs96nSmGvK/jd0nfzgfCJHQUvlJ3kvAbKj6KhbYTRdMuawCmabzpvP9k2pg7enecGg
         WjEGBEfLt6hrkQ81DyUkRL4PGmMbbiCwCokbvIOKWg84J7phuIiizEDkZm2daz1RDEKv
         DEDIgY86twz9HMiKWKpi2hYmHGJqofjBBW91CSkGCHYlTug78PqXAH+LhHw4zxFp5sa1
         kMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irxkDiWsgsAkQraKpHAy3FezkTWc4VGbQfrpFess5dk=;
        b=W9J/tHvHdjcYui3UvBke7x/Y+DAd+5LzfS2ZK47kKYt/xKzL4Z3J9qJonvfFUIJUJL
         usW2aWTO22kTmcVE/yKuIEgyee7AV0Dk6zH21bWlxyEY+d/kL2qe8ZPIzau6q5nCqRLy
         1cDYjwm5vBCPnmIkrp5GVJffzCaqOr2h9e9fN1fKkwgPquEcGz4K9v4eDYUrORq6PiVl
         X2r8cry8xMWYIgHJ7wrqeb6sQgN4Y9Psc2BFaBhCZ+40S0sPORQb+2N2Ex90dkPLgqFC
         JQotU2PMvihSJR55ndSg2z4zaIGPjREaxxxB4Jlp3AHWLLcnr+rv8stkW/jv6XZpCBfl
         +eNA==
X-Gm-Message-State: AFqh2kogRsaSEZ1q63XVt4Zs5IjPJ/BcMqZ0pBslxeO5kQlBUVLbnD+Z
        9k5ZqjygzthmtcAn6ngO+GXBXg==
X-Google-Smtp-Source: AMrXdXvPwz2MuaiP1Euf+cgYDEvPU/yYbL3k78WmQNLZNYzU9oSVx5lLJj3ijzHSeWgefTRb7xXwLA==
X-Received: by 2002:a17:902:e808:b0:189:b910:c6d2 with SMTP id u8-20020a170902e80800b00189b910c6d2mr2832664plg.1.1673973658886;
        Tue, 17 Jan 2023 08:40:58 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0017ec1b1bf9fsm21303359plp.217.2023.01.17.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:40:58 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:40:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Shahar, Sagi" <sagis@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "dmatlack@google.com" <dmatlack@google.com>
Subject: Re: [PATCH v11 025/113] KVM: TDX: Use private memory for TDX
Message-ID: <Y8bPljsAF+lSnWtC@google.com>
References: <cover.1673539699.git.isaku.yamahata@intel.com>
 <4c3f5462852af9fd0957bb7db0b04a6f2d5639ee.1673539699.git.isaku.yamahata@intel.com>
 <b8f88a7b9b2ab00379e6b1afd6a7fdb409d35492.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f88a7b9b2ab00379e6b1afd6a7fdb409d35492.camel@intel.com>
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

On Mon, Jan 16, 2023, Huang, Kai wrote:
> On Thu, 2023-01-12 at 08:31 -0800, isaku.yamahata@intel.com wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> > 
> > Override kvm_arch_has_private_mem() to use fd-based private memory.
> > Return true when a VM has a type of KVM_X86_TDX_VM.
> > 
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > ---
> >  arch/x86/kvm/x86.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index d548d3af6428..a8b555935fd8 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -13498,6 +13498,11 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_sev_es_string_io);
> >  
> > +bool kvm_arch_has_private_mem(struct kvm *kvm)
> > +{
> > +	return kvm->arch.vm_type == KVM_X86_TDX_VM;
> > +}
> > +
> 
> AMD's series has a different solution:
> 
> https://lore.kernel.org/lkml/20221214194056.161492-3-michael.roth@amd.com/
> 
> I think somehow this needs to get aligned.

Ya.  My thought is

 bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
	return kvm->arch.vm_type != KVM_X86_DEFAULT_VM;
 }

where the VM types end up being:

 #define KVM_X86_DEFAULT_VM	0
 #define KVM_X86_PROTECTED_VM	1
 #define KVM_X86_TDX_VM		2
 #define KVM_X86_SNP_VM		3

Don't spend too much time reworking the TDX series at this point, I'm going to do
a trial run of combining UPM+TDX+SNP sometime in the next few weeks to see how all
the pieces fit together, this is one of the common touchpoints that I'll make sure
to look at.  Though if you have ideas on, by all means post them.
