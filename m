Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A587567F362
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjA1A4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjA1A4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:56:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881027C716
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:56:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x5so3169530plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rI2c99rcSfo6XNONmsHvFbfDglWETie8DloTdHfivvk=;
        b=p8go5RAKjk+0e+oaFqXN0FR2I7+FTTYJEnAPgt6hFL+lY0R6cp2EFioBSzJF+6Lu0u
         oUmHkfzMFGfYHb+CpRX3ITsRXEPmTifnvf73ftA6CRqy9RJMCVNLaKmj7OSYR47H2MXB
         2ulmKjdrS8wRLf586AD0fqBtxIbNfEkpnHFvJBvsaYPsozlf7BHD97Ifh6JW6SWeKOQI
         Nkbv+n5vwSF8JAhQHLBeeREs2Y/o2lfnR1hwx69SYzwXZ1ilM6n26IUGpqilwe7piEXt
         QvEoPOWtUxcVT4TrDDchhiAK8mqwNk5ToSEpZJltF3+Hm5pDLTHGomtbwjrMs6u+ssrg
         Uw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI2c99rcSfo6XNONmsHvFbfDglWETie8DloTdHfivvk=;
        b=DAKAb96P/bazMFj86nypf23Lx/vcN1/pBe50z3QJvvsZM5EOVITISEiBjfyFgbt4XF
         MP3XUGwK6d9upMmR+RpKKtDI0Lq6QA0gJaTgLDFdokrzUAYGjOknHf2YeZgrY3iZaqh1
         1JySYHxLj4bNtLhbhjshyhZfujX/NofVoatzLuhuRMNaHQL//mfpwr4bLlXk8tRUhgSB
         n53eiRRGNKcovRG6tpUVhGSaKvd+ZTqvhCM5PS5A23AjPdMmA0rc49myp81WZawTb4K8
         7eFgxY/6pkc81YkxO+YKnUyy10IMDD9SH0nE7rcjQPUB5Nq7MRWHPR+m/hcJQ0/LRnXk
         wjNA==
X-Gm-Message-State: AO0yUKU4SLidjD6oZwzmmUyksHLtvobRCRY0eixvFs7I5MBiM5uSTq3E
        ePwZ2ErP/VWppF6lnU3nh5M4BQ==
X-Google-Smtp-Source: AK7set8krNpzRJzicYHFKi93jEMrwpbzoRjimX3jZk+2Qog5M44S0ZJLGQeBdajigna7YUvZLYX77A==
X-Received: by 2002:a05:6a20:6d15:b0:a4:efde:2ed8 with SMTP id fv21-20020a056a206d1500b000a4efde2ed8mr263956pzb.0.1674867405931;
        Fri, 27 Jan 2023 16:56:45 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c9-20020a6566c9000000b0046ff3634a78sm2908265pgw.71.2023.01.27.16.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:56:45 -0800 (PST)
Date:   Sat, 28 Jan 2023 00:56:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
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
Subject: Re: [PATCH v2 04/11] KVM: SVM: drop the SVM specific H_FLAGS
Message-ID: <Y9RyyvqKDqX3ZNY9@google.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
 <20221129193717.513824-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193717.513824-5-mlevitsk@redhat.com>
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

On Tue, Nov 29, 2022, Maxim Levitsky wrote:
> @@ -3580,7 +3583,7 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
>  		return false;
>  
>  	ret = (vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK) ||
> -	      (vcpu->arch.hflags & HF_NMI_MASK);
> +	      (svm->nmi_masked);

Unnecessary parantheses.

>  
>  	return ret;
>  }
