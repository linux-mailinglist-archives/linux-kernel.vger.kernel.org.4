Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246B970C48D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjEVRn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjEVRn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:43:56 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6311F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:43:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5355657cf13so1604994a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684777431; x=1687369431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iC3M/RVEiAsEvRwykjn0mpnilLBCs5c/vIl/8zacyfg=;
        b=KNOCWK4K1+8gamK8MURP2nRppShxkwO7KtAR6Snf0KDCtWZ3XsPoj+saNuen2kNrkT
         bqz07VQXZAPVpDYse+bdRasvs5feMkYvrCjuK2tZhGPyyEpmWxmYQTyFUGxRU9y+kmWx
         5xreYW1c+VhACq8Y8YZ4F2RSnkd8yY7XsQSpkhi/r5FOmKX63zWeMYBT8Hc5EufDG473
         oBlDT7WXTH1wtHavax3SvrKzhmI/TKDCDr1eeAQpSYzagWkanSEphjcjPa60+bhjcBIn
         cKnXog8Y9wGSbX+wUPactdnBAbG+ukyZG3oVkDBSk4hRE2kGnBw1zJR5nDVH4W8x9Nev
         H0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777431; x=1687369431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iC3M/RVEiAsEvRwykjn0mpnilLBCs5c/vIl/8zacyfg=;
        b=Hm7nx4/6e9orJmMWcHrrqg9IkNpEuuRO1tAZojl0CVqmUfIEEe/594jx9cV0z/RrLl
         2qj9jIbqxXNJummN5wdyCBramBE7VXautECm2ZlmFzZGHEj2Mw5urARdJNacSToH4VTu
         whzqmGBGaQA82m9gZaSDPv/duZmErIbDFVeG6AYdNby0Uyq70XlveX5ob4ZMNw7N2x3y
         Fehd5fWfFhG6oyD6tZ39LCvPWL7XrE6zm21DIc2CuadAXQVonQgLQeNiva8hU1runhIa
         SdDxdZNQLMCw59ysdPAZlrJBc7shZWfVmqiDPhPbmmWA/ZQ3apy3usLVfPLuEb84BEsj
         E6nw==
X-Gm-Message-State: AC+VfDxrNIjAsFIb9mOg248jY1TrQCOKR+jxK2WOmyxVnb/KV7eHiR0C
        rd4hxnl8cay/v/Vm7zC7iB3nuv4Pok8=
X-Google-Smtp-Source: ACHHUZ5tdYQpYrbpDVARXGV8NJ1f7fpCU5P0i5Io/HQvjwIM2pcFQKzlONCgHkbWeM4ZF4OqIOvF0Yrp3HU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:68f:b0:1a8:16d2:a86b with SMTP id
 ki15-20020a170903068f00b001a816d2a86bmr2580886plb.8.1684777431487; Mon, 22
 May 2023 10:43:51 -0700 (PDT)
Date:   Mon, 22 May 2023 10:43:49 -0700
In-Reply-To: <20230520010237.3tepk3q44j52leuk@desk>
Mime-Version: 1.0
References: <20230506030435.80262-1-chao.gao@intel.com> <b472b58d-0469-8a55-985c-1d966ce66419@intel.com>
 <ZGZhW/x5OWPmx1qD@google.com> <20230520010237.3tepk3q44j52leuk@desk>
Message-ID: <ZGup1TjeqBF7bgWG@google.com>
Subject: Re: [PATCH] KVM: x86: Track supported ARCH_CAPABILITIES in kvm_caps
From:   Sean Christopherson <seanjc@google.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, Chao Gao <chao.gao@intel.com>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023, Pawan Gupta wrote:
> On Thu, May 18, 2023 at 10:33:15AM -0700, Sean Christopherson wrote:
> > I made the mistake of digging into why KVM doesn't advertise ARCH_CAP_FB_CLEAR_CTRL...
> > 
> >   1. I see *nothing* in commit 027bbb884be0 ("KVM: x86/speculation: Disable Fill
> >      buffer clear within guests") that justifies 1x RDMSR and 2x WRMSR on every
> >      entry+exit.
> 
> Unnecessary VERWs in guest will have much higher impact than due to MSR
> read/write at vmentry/exit.

Can you provide numbers for something closeish to a real world workload?

> On an Icelake system it is pointless for a guest to incur VERW penalty when
> the system is not affected by MDS/TAA and guests don't need mitigation for
> MMIO Stale Data. MSR writes are only done when the guest is likely to execute
> unnecessary VERWs(e.g. when the guest thinks its running on an older gen
> CPU).
>
> >      KVM just needs to context switch the MSR between guests since the value that's
> >      loaded while running in the host is irrelevant.  E.g. use a percpu cache to
> 
> I will be happy to avoid the MSR read/write, but its worth considering
> that this MSR can receive more bits that host may want to toggle, then
> percpu cache implementation would likely change.

Change in and of itself isn't problematic, so long as whatever code we write won't
fall over if/when new bits are added, i.e. doesn't clobber unknown bits.

> >   5. MSR_IA32_MCU_OPT_CTRL is not modified by the host after a CPU is brought up,
> >      i.e. the host's desired value is effectively static post-boot, and barring
> >      a buggy configuration (running KVM as a guest), the boot CPU's value will be
> >      the same as every other CPU.
> 
> Would the MSR value be same on every CPU, if only some guests have
> enumerated FB_CLEAR and others haven't?

Ignore the guest, I'm talking purely about the host.  Specifically, there's no
reason to do a RDMSR to get the host value on every VM-Enter since the host's
value is effectively static post-boot.

> MSR writes (to disable FB_CLEAR) are not done when a guest enumerates
> FB_CLEAR. Enumeration of FB_CLEAR in guest will depend on its configuration.
> 
> >   6. Performance aside, KVM should not be speculating (ha!) on what the guest
> >      will and will not do, and should instead honor whatever behavior is presented
> >      to the guest.  If the guest CPU model indicates that VERW flushes buffers,
> >      then KVM damn well needs to let VERW flush buffers.
> 
> The current implementation allows guests to have VERW flush buffers when
> they enumerate FB_CLEAR. It only restricts the flush behavior when the
> guest is trying to mitigate against a vulnerability(like MDS) on a
> hardware that is not affected. I guess its common for guests to be
> running with older gen configuration on a newer hardware.

Right, I'm saying that that behavior is wrong.  KVM shouldn't assume the guest
the guest will do things a certain way and should instead honor the "architectural"
definition, in quotes because I realize there probably is no architectural
definition for any of this.

It might be that the code does (unintentionally?) honor the "architecture", i.e.
this code might actually be accurrate with respect to when the guest can expect
VERW to flush buffers.  But the comment is so, so wrong.

	/*
	 * If guest will not execute VERW, there is no need to set FB_CLEAR_DIS
	 * at VMEntry. Skip the MSR read/write when a guest has no use case to
	 * execute VERW.
	 */
	if ((vcpu->arch.arch_capabilities & ARCH_CAP_FB_CLEAR) ||
	   ((vcpu->arch.arch_capabilities & ARCH_CAP_MDS_NO) &&
	    (vcpu->arch.arch_capabilities & ARCH_CAP_TAA_NO) &&
	    (vcpu->arch.arch_capabilities & ARCH_CAP_PSDP_NO) &&
	    (vcpu->arch.arch_capabilities & ARCH_CAP_FBSDP_NO) &&
	    (vcpu->arch.arch_capabilities & ARCH_CAP_SBDR_SSDP_NO)))
		vmx->disable_fb_clear = false;
