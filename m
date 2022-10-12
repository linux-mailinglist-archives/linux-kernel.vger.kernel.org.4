Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ADF5FCC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJLUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJLUrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:47:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE5FE55
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:47:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 204so70209pfx.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Op7us6H5yItQICnmAUV8XPAHd83VgMkaR2DiXRf8kqE=;
        b=o9RR79ZvqOkXUcbnu1Ob0Luu/qScgjQ78WzOu9Vu/jnLCPUcSObdibkhGkdZYgI5x0
         Zs4EP82PHdloiT1A+rLYOADt+LVJG9e9f9d1TAizmyPXcPFQ2iCZGxrxtJd538M8au/W
         retr3+5+3KJGF1bcKl1zRWE9ZI5zUHhMIfaKsz34Nh1yJn8ujoWMHDKW+gnNnoEfCjlL
         VEAMb4qoSvd+Zb52d1O1I5K9OFp0WOBQdYFhnOrLWiL0tAEtmZ+tiC9IsPw5YMACn1jN
         kyFGqHNhlClAfD70noTA5folzgbxxWQnnpVsqH/vrb3/nc1iZi6Pca5yEM6x6oOr881H
         8o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op7us6H5yItQICnmAUV8XPAHd83VgMkaR2DiXRf8kqE=;
        b=piQTM2V8178q/q2TxliQYyi6oY3T3G8D59u7+lhu/X+6wsCnVtAcHoLM7wPBlUgj4v
         Wc8kZsTAK/usM6NsgxVPi/Q/ijA2YQn2w1yFIhcXUcXc0KaLXqSba/v9K02U12uHBzRV
         2J3y0Ukar4NohfD1yf5NR/kvOKx27MmpOYJHQ+LkOa+0/Fl8zXQk//AZO4ktukiagaEo
         yafdi5wh1EPwvXeqpvxSb4hT6+qT0ETXks2E2eC00Jv6OvEvmZlLf2HajHFCISm48r3/
         LWG0SaGchv0VNxemmj/P3Qi0UBMHLoTo6pI84m7RtpDY69qkMakMTyhofkpqrYbD++l9
         2OMQ==
X-Gm-Message-State: ACrzQf3Sy1H/31oGM0TDzd5Pf2xLfSNAWVM0n3OpFmKG/9Qdww31Bq65
        oCNyrNRIiyj9Q5UYFzR1TOERzw==
X-Google-Smtp-Source: AMsMyM4W1QDG+k5mU/kt4rluoQMd1AM2z+5cytQUIClFMfeYaiP/l85RnMynLrtgzCCCCATIWyK/og==
X-Received: by 2002:a63:3155:0:b0:45a:553a:3479 with SMTP id x82-20020a633155000000b0045a553a3479mr27047800pgx.408.1665607639028;
        Wed, 12 Oct 2022 13:47:19 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l26-20020a635b5a000000b00460c67afbd5sm7265926pgm.7.2022.10.12.13.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:47:18 -0700 (PDT)
Date:   Wed, 12 Oct 2022 20:47:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        isaku.yamahata@gmail.com, Kai Huang <kai.huang@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Huang Ying <ying.huang@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 11/30] KVM: Add arch hook for reboot event
Message-ID: <Y0cn0nnDV/8SrWQn@google.com>
References: <cover.1663869838.git.isaku.yamahata@intel.com>
 <61dcd6722743bf221f6c612e120a9e2350d5a72f.1663869838.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61dcd6722743bf221f6c612e120a9e2350d5a72f.1663869838.git.isaku.yamahata@intel.com>
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

On Thu, Sep 22, 2022, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Factor out the logic on reboot event as arch hook.  Later kvm/x86 overrides
> it.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---

...

> @@ -5135,6 +5141,8 @@ static void kvm_del_vm(void)
>  static int kvm_reboot(struct notifier_block *notifier, unsigned long val,
>  		      void *v)
>  {
> +	int r;
> +
>  	/*
>  	 * Some (well, at least mine) BIOSes hang on reboot if
>  	 * in vmx root mode.
> @@ -5143,8 +5151,14 @@ static int kvm_reboot(struct notifier_block *notifier, unsigned long val,
>  	 */
>  	pr_info("kvm: exiting hardware virtualization\n");
>  	kvm_rebooting = true;
> -	on_each_cpu(hardware_disable_nolock, NULL, 1);
> -	return NOTIFY_OK;
> +
> +	/* This hook is called without cpuhotplug disabled.  */
> +	cpus_read_lock();
> +	mutex_lock(&kvm_lock);
> +	r = kvm_arch_reboot(val);

Unless there's a valid use case for rejecting/stopping reboot, which I'm pretty
sure there isn't, don't allow arch code to return a value.  I.e. return NOTIFY_OK
unconditionally from kvm_reboot() and drop the return from kvm_arch_reboot().

> +	mutex_unlock(&kvm_lock);
> +	cpus_read_unlock();
> +	return r;
>  }
>  
>  static struct notifier_block kvm_reboot_notifier = {
> -- 
> 2.25.1
> 
