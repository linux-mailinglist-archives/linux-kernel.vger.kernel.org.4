Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357215E5673
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiIUW7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIUW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:59:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA0A8977
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:59:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id rt12so5510777pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gT7v+Iphr5H7tbmIRZ4mb0BW+PQRNn3bGFIrWMufP+Y=;
        b=AnZtDAdv0bZ0a4j3wmHXs2IGZ2XGolBmvh/uAryz0wb0qyg0YKv05CwUHlOIJmSy81
         JEAFibFTRKJSyAD++DWRxrnN40ZiOtmQr912AeYe7tnxIhVbIFcSGz3/tc8Tdqeqf7gu
         DodA7UsbwIyRsIJWoTaGk4/hBJAIdRMPoBZboj7cjulmHO5XMZr4v0WtEOxrJ6ju+Sc5
         hiyjmCK8Old/VWOe8FAEYzD95Pri41i3lZyvL63R6QwrM2yRJxH0jq9pQajlec5juX8S
         3cMfmVYrjiZibrH1RR/Fd8WdEMQ1r0MxzykqTuTzX+PsOhp2XLOYBhAn1rwFgf5P392R
         grxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gT7v+Iphr5H7tbmIRZ4mb0BW+PQRNn3bGFIrWMufP+Y=;
        b=ZsIW8bFGQ0M1/pBlOs7cDDpk1b4X2ZtJb2Q6ty/S9/AvBe24J0Fq3Epw7dhHCEeezj
         glLJlHOgNasMI1tgRlJVYdeyqmCZWWWvzXKvIIFW7A7I/LWcZlAo8LfOFvBEKBOIz92w
         NdN0kfJTJpO5u+r8espRUjPQZeEbCdPJ5j2Jnzl0B9QHAN8tnh+3jr4bQy9U2NH1KJVG
         1nLSnUbYz9vdqneMZUid/sJY5yJ5+8KYSniIfr/QP0Or7j2uaIuBQ21LlEOdkIbSYsx7
         0mUcZ5YMPQ9nipVcGQ94xoYOKh3gOEBJnsKoo8nJpJtMCOHINQHLnYmYySCXzu4TG3/z
         AYJw==
X-Gm-Message-State: ACrzQf0u8EFIMv7LHavYyTUK2BFPt40BpEfni3b2BB8V8FQWQLGja1mi
        9CZ7vsycVcd70EwA3HX45dVBig==
X-Google-Smtp-Source: AMsMyM5O5t8wkIhl0mIR0WGZL4bf4gqSGyRSuEMHDKG4ZBSyueW3VtJOj0qT+ruNSQUIhUGAOr9Ewg==
X-Received: by 2002:a17:90b:3883:b0:203:214d:4272 with SMTP id mu3-20020a17090b388300b00203214d4272mr11888667pjb.101.1663801166762;
        Wed, 21 Sep 2022 15:59:26 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a7f8100b002008ba3a74csm2356714pjl.52.2022.09.21.15.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:59:26 -0700 (PDT)
Date:   Wed, 21 Sep 2022 22:59:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 35/39] KVM: selftests: Create a vendor independent
 helper to allocate Hyper-V specific test pages
Message-ID: <YyuXSrF743wgFCgE@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-36-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921152436.3673454-36-vkuznets@redhat.com>
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

On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
> diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> index 42213f5de17f..e00ce9e122f4 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> @@ -265,4 +265,19 @@ extern struct hv_vp_assist_page *current_vp_assist;
>  
>  int enable_vp_assist(uint64_t vp_assist_pa, void *vp_assist);
>  
> +struct hyperv_test_pages {
> +	/* VP assist page */
> +	void *vp_assist_hva;
> +	uint64_t vp_assist_gpa;
> +	void *vp_assist;
> +
> +	/* Enlightened VMCS */
> +	void *enlightened_vmcs_hva;
> +	uint64_t enlightened_vmcs_gpa;
> +	void *enlightened_vmcs;

FYI (in case you or someone else is tempted to do further cleanup), at some point
there will be a patch to wrap these triplets[*] to cut down on the copy+paste.

[*] https://lore.kernel.org/all/YwznLAqRb2i4lHiH@google.com
 
> +};
> +
> +struct hyperv_test_pages *
> +vcpu_alloc_hyperv_test_pages(struct kvm_vm *vm, vm_vaddr_t *p_hv_pages_gva);

Please don't wrap before the function name.

