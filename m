Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40322622F82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKIP6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKIP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:58:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397F01EEE1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:58:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso3982797pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EE7uQNjTE6zucK4ofu1/6DS7FBdn9juGzQ+5NRdklFc=;
        b=nptEhugydo8hGUpto+nF6AtDTul+QCP3BL2ny6QEWxVIKvKfL7hlFHzkxHNmHQxpnU
         8ihg2okVaXej8hUwnOrA9o4HAlVT9vR+05AbqJ2DuqCkKN6McDI6ThdrFlOjOpMZ8LKF
         PnAKt7YFA7l92XoxNqR0GmbV6m6VuP9kaJkg5ebzQv63Lim2asJ1b7qLMcI7/OphH4+o
         WDF9qZEpoBIeepvyy4J3BR8xFe0ovMMzc7lWOJirVYG+lrXnhn+fDxkwGx0TXEXjn138
         zkezlMKik+bi1UhaBcQpeI74VIpy/Te/2/atpDS6TLmC3pshRIJ5OyZZDAZ69m1KO47s
         LcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE7uQNjTE6zucK4ofu1/6DS7FBdn9juGzQ+5NRdklFc=;
        b=qzUdGMfsWcLePjTPNY0xx54ZqRgvs1hrLsCrrCkkYvor3FOvv9nP+lwsbXgoGnJOlq
         VlgqTjhVBJOPTUSw1MPce6SlQc59naYvkw6tbBVLzGVm9fdRg5s0YhCujwL62BZlpl5i
         lMhF//RdeIftgTN9Ynk8Nz+D+MunAx79t7NTIAaDO75m4k6SL46bG0tz351cnj/eroqy
         /BzSt3aeLERYUse1IM3vt2Ur5M7cUkrbT2B0gSGOwwYfkt7VwPjVb4X789LYmYyu9xZr
         m2YMpxTji3NjP6qkgoPc/IwzaqbNceJn8A4Y6kpb/I3jo+m/1pfILoZm01wMyNVHDL49
         Lk/Q==
X-Gm-Message-State: ACrzQf3eU/cbzOXaYTRYT1tz88p2nUCQGPHUx47mDg1uSQbQ+lRuQbrL
        HqSj0ICurflY6XF89CtZmmgudA==
X-Google-Smtp-Source: AMsMyM4Vyg1BlGHawK452palqcEInloJqkDitJZlVhbNt0Rk60TZUsE+I9fXHxg6l7jJvv19xZq0XA==
X-Received: by 2002:a17:903:244a:b0:187:10f1:9f91 with SMTP id l10-20020a170903244a00b0018710f19f91mr58798771pls.37.1668009494686;
        Wed, 09 Nov 2022 07:58:14 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id nm13-20020a17090b19cd00b0020087d7e778sm1384968pjb.37.2022.11.09.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:58:14 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:58:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, jmattson@google.com
Subject: Re: [PATCH 07/11] KVM: SVM: do not allocate struct svm_cpu_data
 dynamically
Message-ID: <Y2vOEkJDwlmJ2hv9@google.com>
References: <20221109145156.84714-1-pbonzini@redhat.com>
 <20221109145156.84714-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109145156.84714-8-pbonzini@redhat.com>
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

On Wed, Nov 09, 2022, Paolo Bonzini wrote:
> The svm_data percpu variable is a pointer, but it is allocated when
> KVM is loaded (via svm_hardware_setup), not at hardware_enable time.

Parantheses.

> Just allocate room for it statically, that is more efficient and
> does not waste any memory compared to the status quo.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Sean Christopherson <seanjc@google.com>

> @@ -3442,7 +3431,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  
>  static void reload_tss(struct kvm_vcpu *vcpu)
>  {
> -	struct svm_cpu_data *sd = per_cpu(svm_data, vcpu->cpu);
> +	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
>  
>  	sd->tss_desc->type = 9; /* available 32/64-bit TSS */
>  	load_TR_desc();
> @@ -3450,7 +3439,7 @@ static void reload_tss(struct kvm_vcpu *vcpu)
>  
>  static void pre_svm_run(struct kvm_vcpu *vcpu)
>  {
> -	struct svm_cpu_data *sd = per_cpu(svm_data, vcpu->cpu);
> +	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  
>  	/*
> @@ -3919,7 +3908,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu)
>  	if (sev_es_guest(vcpu->kvm)) {
>  		__svm_sev_es_vcpu_run(svm);
>  	} else {
> -		struct svm_cpu_data *sd = per_cpu(svm_data, vcpu->cpu);
> +		struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);

At some point we should replace the vcpu->cpu usage with this_cpu_ptr().  All of
the code that does per_cpu_ptr(&svm_data, vcpu->cpu) is doomed if vcpu->cpu isn't
the current CPU.
