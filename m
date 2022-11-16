Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB862B0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiKPB4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKPB4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:56:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753682529B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:56:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p12so15099860plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KVMI/nFFiiWGPsODZP4uTO9+eDXKExXBhUQy4MPYB78=;
        b=ZkhmtpyvuQjtpiKcSTwV4FQaNI1BndPmVfYwRbI4kyGyIBWLGYAK9adsViZh/yHJ7x
         GuxgtogV7PtxaPytplYxo+Klt0B/2ry2vtbUojn3VI5CZqcW98TXvlxs8G1FSU2NCLPG
         osV9xc1d2y7cg0+wNaz5Nf0N26qzO6pIP5sDWfotE89nSnvse7sYp7t8PQ00S927CjrN
         Mt9iItQr7ceVWaHS8qhCiI1BYymChnkKt5hyJqGOY0FEweE8dtCPm+eSBErPLu7yhTm8
         o9dFADTr9ZdWsubEfckpwD5DI+8OZmAD6JfaYPF77XPfSWF6ATOhEkaqdt7s4F4xOEiQ
         xj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVMI/nFFiiWGPsODZP4uTO9+eDXKExXBhUQy4MPYB78=;
        b=dFglmOnrVTuWQQD6jv9QsB5qpjun5qwzlV7kqUc7mvtytOzULIB320zuCjQrjyVyWD
         r1X1nivsuMFv6T/tcww4sj0iaTk4zf+ljK7C78wvhP3b9vhX+T7RTg+DbjjTZ8dkLTEG
         gF9I+kC9LfPGqV29TrfNPXKcJwtfwhspMBtepEUKEkCx3TMxb7uXqdbAiB+wlDyqW22F
         SgxjtTT6aPfL+64vkrLdUIvhtop/e5nwGROOQGTPQ7CxhkmHSn0ZdO5jD5fZImPXyPbI
         mRQQhRbec1QGEaAkyPLJh45x+9VeI0qin8bVH92/4NJy1kSTwZQ99SBDh5tpNaitkg4A
         fIVw==
X-Gm-Message-State: ANoB5pl0RYtJM1Ehdi6RFNB5/hLazY5e4qLZE2MfL6thl+V+D4ZJZWzT
        7+tqNlxLgGuZRlhZi8mM1I/mSg==
X-Google-Smtp-Source: AA0mqf6H0QJ9u7lmf5OzgdM3vacJIFtJ+zbl369j6MJCYNSFKT6kmzTaZY88ji+zMgthkUAHrSJWdg==
X-Received: by 2002:a17:90a:5883:b0:218:f84:3f98 with SMTP id j3-20020a17090a588300b002180f843f98mr1206419pji.238.1668563776878;
        Tue, 15 Nov 2022 17:56:16 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79499000000b0056ca3569a66sm9483483pfk.129.2022.11.15.17.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:56:16 -0800 (PST)
Date:   Wed, 16 Nov 2022 01:56:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yao, Yuan" <yuan.yao@intel.com>,
        "farosas@linux.ibm.com" <farosas@linux.ibm.com>,
        "david@redhat.com" <david@redhat.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "Gao, Chao" <chao.gao@intel.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 33/44] KVM: x86: Do VMX/SVM support checks directly in
 vendor code
Message-ID: <Y3RDPOerOIf6SwI0@google.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-34-seanjc@google.com>
 <95c3cce88560024566f3b4b0061ca7e62a8a4286.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95c3cce88560024566f3b4b0061ca7e62a8a4286.camel@intel.com>
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

On Tue, Nov 15, 2022, Huang, Kai wrote:
> On Wed, 2022-11-02 at 23:19 +0000, Sean Christopherson wrote:
> > +static bool __init kvm_is_vmx_supported(void)
> > +{
> > +	if (!cpu_has_vmx()) {
> > +		pr_err("CPU doesn't support VMX\n");
> > +		return false;
> > +	}
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
> > +	    !boot_cpu_has(X86_FEATURE_VMX)) {
> > +		pr_err("VMX not enabled in MSR_IA32_FEAT_CTL\n");
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  static int __init vmx_check_processor_compat(void)
> >  {
> >  	struct vmcs_config vmcs_conf;
> >  	struct vmx_capability vmx_cap;
> >  
> > -	if (!this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
> > -	    !this_cpu_has(X86_FEATURE_VMX)) {
> > -		pr_err("VMX is disabled on CPU %d\n", smp_processor_id());
> > +	if (!kvm_is_vmx_supported())
> >  		return -EIO;
> > -	}
> >  
> 
> Looks there's a functional change here -- the old code checks local cpu's
> feature bits but the new code always checks bsp's feature bits.  Should have no
> problem I think, though.

Ouch.  The bad check will defeat the purpose of doing compat checks.  Nice catch!
