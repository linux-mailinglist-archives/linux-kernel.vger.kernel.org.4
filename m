Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B76063ADA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiK1Q2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiK1Q2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:28:13 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B481C220F7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:28:12 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id t17so10000616pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z490q3+4OBgGpP4ghV2GyQxr+yapVjAEH0weCGz/rew=;
        b=g4/JV+5AWieJycDXis2BS4N3wmKNQsJ/KNpv5tNUJ7bYf7rIi5c6ZaaBKkHz/bt2ds
         NVz1nDCNfg0Gvfj59pCRuZnyo34rIXD5ZSqLXCEY3KRO6/0+gAckzIMtyN+jGGEHc1LZ
         fc8V8VVQPLEKTbb0k2l/Y0nzsa1NvtgKYzNydgnY35ub6CZbpuUKfzyDWtzTNa8u2S43
         Rc6+U9WQb1R1XNDtXj2X0abf3a3VLUTgErJgNOb0NQ1HdQE+GVbcZntRU5XLuQL7Nyr3
         En9IRHHNEXJ5km/umpqJRqRfuuhN8VUXjEz6i9JeMmMlZtCvtN8lVb4xVk2+abtzmgCe
         +FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z490q3+4OBgGpP4ghV2GyQxr+yapVjAEH0weCGz/rew=;
        b=2YYK3/3shEqi3l3AzZD33GlRZN/0QpMTfg3ruN0YZdRhLeCvxPGdslYcTJppegPSYF
         dmtAJWZrA8PGN3doYzE94cdQtGEm2iqCmiyIc+d4OPpGZ3EI0armdTFXG1DTeVRBhDuT
         sfSRM83EY/ekPeUQr58wSw8V1IyMVFnYxK0ck+cNNI0eOZMar2A1fxPHPUY+1GDhjTro
         7wSyXApNbeJPgFybPc9sva5TjmAjCkO31b77P/T3oqJZlwnAOR27v1uQVw/FRJ7XbDSG
         NwiFnU8wDGahTddpXc9hRH1v8O5ZacsenQHgyVxTq7uJDXw015pfSKGHp4sQ7s8mfWfU
         oNVA==
X-Gm-Message-State: ANoB5pn4NULJyIayvdE1NUfG/TAJIAz3FvOIuUSgilNnJEsgzR8/n3nz
        FhXeQKR1FbgInZxY29LjDPU1KA==
X-Google-Smtp-Source: AA0mqf6UA3M1F5X0CTUJ+Mhdl/2KTcvWkRaZ4HMfCTo8WNM0NYUMyetHeVBhXTbruSHZQhCtQ4C/tA==
X-Received: by 2002:a17:902:7793:b0:189:24b3:c86 with SMTP id o19-20020a170902779300b0018924b30c86mr33048176pll.84.1669652765355;
        Mon, 28 Nov 2022 08:26:05 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b00186b1bfbe79sm8546264plh.66.2022.11.28.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:26:04 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:26:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RESEND PATCH 5/6] KVM: x86/VMX: add kvm_vmx_reinject_nmi_irq()
 for NMI/IRQ reinjection
Message-ID: <Y4ThGWP4qNuCDPgh@google.com>
References: <BN6PR1101MB2161299749E12D484DE9302BA8049@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y3NZQBJugRt07udw@hirez.programming.kicks-ass.net>
 <DM5PR1101MB2172D7D7BC49255DB3752802A8069@DM5PR1101MB2172.namprd11.prod.outlook.com>
 <Y3ZYiKbJacmejY3K@google.com>
 <BN6PR1101MB21611347D37CF40403B974EDA8099@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <BN6PR1101MB2161FCA1989E3C6499192028A80D9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y302kxLEhcp20d65@google.com>
 <BN6PR1101MB216162F44664713802201FAFA80C9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y36Fy/OYO5u0AzEG@google.com>
 <BN6PR1101MB2161E9BB4D4F05DF9F244CF7A80F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR1101MB2161E9BB4D4F05DF9F244CF7A80F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
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

On Thu, Nov 24, 2022, Li, Xin3 wrote:
> > > > thouh we'd like want a fair bit of refactoring so that all of
> > > > vmx_vcpu_run() and
> > > > svm_vcpu_run() don't need to be noinstr.
> > 
> > For the record, svm_vcpu_run() is fine, at least as far as NMIs are concerned.
> > 
> > > This sounds reasonable to me, however from
> > > Documentation/core-api/entry.rst, we do need it.
> > 
> > Why do you say that?
> >
> 
> Copy/Paste from Documentation/core-api/entry.rst:

I'm very confused.  What do you mean by "we do need it".  What is "it"?  And what
does "it" have to do with the below documentation?  The documentation does nothing
more than explain how KVM handles task work.
 
> KVM
> ---
> 
> Entering or exiting guest mode is very similar to syscalls. From the host
> kernel point of view the CPU goes off into user space when entering the
> guest and returns to the kernel on exit.
> 
> kvm_guest_enter_irqoff() is a KVM-specific variant of exit_to_user_mode()
> and kvm_guest_exit_irqoff() is the KVM variant of enter_from_user_mode().
> The state operations have the same ordering.
> 
> Task work handling is done separately for guest at the boundary of the
> vcpu_run() loop via xfer_to_guest_mode_handle_work() which is a subset of
> the work handled on return to user space.
> 
> Do not nest KVM entry/exit transitions because doing so is nonsensical.
