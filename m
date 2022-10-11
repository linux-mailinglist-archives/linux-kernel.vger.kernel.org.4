Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C325FBAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJKSv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKSvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:51:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16CC7D1E5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:51:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 3so12807252pfw.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKZTcqhNfH6XEVr/io5w7ZWWmBBV8QD/bwvnyWmu+g0=;
        b=mGVfRbWvuSjpb+0blFVwritqEKYvtR52XGW3xkRTNmJz+SBDqG1SCiBZAVEQx7Eyyk
         0isWp+d2DATDH3WYqoKoIjbI6L7cJ7l9UQTc1MZXw0mareCpXzWUwi+xsrJA2ifwHB2m
         wiD4PbdJubOQylrDFQ7gW+ViCmbDhSsHnS2LbI5gDuvWGcytw2CtrcOwfXgD9RrUMKwR
         K1FeSuAH9MdrvjtjEXLEN0g2egFCPT3LLl75EP42NuADU/vxQVPax62oBw28owcw/VvA
         IeKnI+uK67QoXoXoTBMBQbWmfKEXfI1XgILWUPWUQZ0+Nprp6xUhUEkbNaVuBJkwHWhz
         OgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKZTcqhNfH6XEVr/io5w7ZWWmBBV8QD/bwvnyWmu+g0=;
        b=nIWSlc/sOXjCDqXSRtAfq7xmzk02XqZqWbZvVVSEom+kHQ2UznfVxljWh6WF1gxtdS
         Rs3b91N2/5JBt86a5g6uR07wtHFuIKRzpDfxZHWihpIN2NtBiRL/wB0y6TIVs20B6mOF
         hAQR9AffbeVSX2gukJAeLsHg7yxPw1te00O6Efpa/C35MZyG5bx/+FrM30uKjKOgcJwb
         bi7nViNnWWUKDf+UcuVbyidefeuemoY10tkMvrlnO0Pc7YIY9wNxz56tFewot4IjvmPW
         PQ6vrj6PLFn8wYnKR+WK7ircxiVi3+RxzAyOsDhHt3ifvsIyOWefJ0udOcZOMbTBUW9s
         U+2Q==
X-Gm-Message-State: ACrzQf1DlYD1ZsaD+OLqTKrZH8rcwdxsVX4tMCVtwu5OXL5NtJc2P7YS
        kJuoWcuBeeT5lDITK2mfyKixbQ==
X-Google-Smtp-Source: AMsMyM6HUuRERGX7sUjc7sux75wTMI5F+DBqNQx5P9N3m+LZp6R8a1/F0+T/fLWd98Ejoqq+zK/0dg==
X-Received: by 2002:a63:ff5c:0:b0:434:dc60:73d with SMTP id s28-20020a63ff5c000000b00434dc60073dmr23060827pgk.136.1665514283177;
        Tue, 11 Oct 2022 11:51:23 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m11-20020a1709026bcb00b001811a197797sm6848431plt.194.2022.10.11.11.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:51:22 -0700 (PDT)
Date:   Tue, 11 Oct 2022 18:51:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] KVM: SEV: Fix a few small typos
Message-ID: <Y0W7J9+2P2u83EaD@google.com>
References: <20220928173142.2935674-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928173142.2935674-1-carlos.bilbao@amd.com>
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

On Wed, Sep 28, 2022, Carlos Bilbao wrote:
> @@ -3510,7 +3510,7 @@ bool sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  
>  	ret = __sev_snp_update_protected_guest_state(vcpu);
>  	if (ret)
> -		vcpu_unimpl(vcpu, "snp: AP state update on init failed\n");
> +		vcpu_unimpl(vcpu, "SNP: AP state update on init failed\n");
>  
>  unlock:
>  	mutex_unlock(&svm->snp_vmsa_mutex);
> @@ -4170,7 +4170,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
>  	/* PKRU is restored on VMEXIT, save the current host value */
>  	hostsa->pkru = read_pkru();
>  
> -	/* MSR_IA32_XSS is restored on VMEXIT, save the currnet host value */
> +	/* MSR_IA32_XSS is restored on VMEXIT, save the current host value */
>  	hostsa->xss = host_xss;
>  }
>  
> @@ -4223,7 +4223,7 @@ struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
>  	 * Allocate an SNP safe page to workaround the SNP erratum where
>  	 * the CPU will incorrectly signal an RMP violation  #PF if a
>  	 * hugepage (2mb or 1gb) collides with the RMP entry of VMCB, VMSA
> -	 * or AVIC backing page. The recommeded workaround is to not use the
> +	 * or AVIC backing page. The recommended workaround is to not use the
>  	 * hugepage.
>  	 *
>  	 * Allocate one extra page, use a page which is not 2mb aligned

SNP support doesn't exist upstream, looks like this was generated against an SNP
branch.
