Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1FC6052E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiJSWTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiJSWT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:19:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F41011
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:19:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l4so18565013plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4YnSEPLti5++1d+/gxvsHMlivYPnWvSShn2YRgOKDQ=;
        b=bgXvbpNck6JaVV+ruo1CFDxdJ7YsYPAD1ymB7Tqr6h2QPBc718SyOrorombXW5IUsH
         xIBydOXVYYgCtN/o1DfwN57WsmDx0gZ1BvrhW4SJos9tl7O8oXf8d+Lf+JMT5GyLaAwP
         T4q3oGEHY8d7kLecabPsnIElNYkRuBgap+u49+zBR05R3jz15Ed5iY3Nu2xs66s4NzDi
         3I1KAhOTc80G0XAW2e8Xnst0JhBRHvwk7rHv32QCpP5x+YCK2u9CuURcW9b1jaiVGh3/
         Esbo1Ta/Fcy6HG1MYPY3J+UD6eviKmmLvF2luSbWaUqD4dehRlrmMUYnDQz3WbbUWe6f
         W11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4YnSEPLti5++1d+/gxvsHMlivYPnWvSShn2YRgOKDQ=;
        b=6rrXBp2p60MEiUJBlMmdHdkesjV9xiOIoD8njse3wIfzrrIyGazbHbgaikhEbBhC+c
         aiUKTIsLnP47j+uhRKo0j2qRFEZB6lnHrTVL/hgLPC4Q2T1bTXoeO532B3CC/aHDAPF5
         iAqVhHl7W1wjJfgWjJYVzApBYtLMOGd1kYtDuPr/HNsxAeGIOxg1aUldYNexZafCojKm
         UYWlGlQ5FqQoPBSnVPgTdCG+KwdZCzf+mh5Sw+mhl/L+s2OGKpau9kJg3x69XH4amZsZ
         SZF0OxhUPLUipSWSXHiuea/UuYzDzP4WK/esqlgA0jLaxA52wxWfUqytwm+DzxM9Gv0Q
         C8sQ==
X-Gm-Message-State: ACrzQf0nC5748Gz/tw/ZGV0+yLSdj3c4APYhBkP0ztO8WCHs4vAOjVNz
        TeblRslxZD+1onZpYVf1aTdhZA==
X-Google-Smtp-Source: AMsMyM4wOGZ6Mzbvx+vtNxRRKJcvtr2w2MQf3Xv/TVwQqz9YK42hyOCsSWd9A7ktbshogZ+wXWYy/Q==
X-Received: by 2002:a17:90b:4c42:b0:20d:7820:2e4e with SMTP id np2-20020a17090b4c4200b0020d78202e4emr47808393pjb.40.1666217961925;
        Wed, 19 Oct 2022 15:19:21 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0017e93c158d7sm11141360pla.214.2022.10.19.15.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:19:21 -0700 (PDT)
Date:   Wed, 19 Oct 2022 22:19:18 +0000
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
Subject: Re: [PATCH v11 44/46] KVM: selftests: evmcs_test: Introduce L2 TLB
 flush test
Message-ID: <Y1B35gupSqXAvAOZ@google.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-45-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004123956.188909-45-vkuznets@redhat.com>
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

On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
> @@ -64,15 +67,33 @@ void l2_guest_code(void)
>  	vmcall();
>  	rdmsr_gs_base(); /* intercepted */
>  
> +	/* L2 TLB flush tests */
> +	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT, 0x0,
> +			   HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PROCESSORS);

Alignment is funky.

> +	rdmsr_fs_base();
> +	/*
> +	 * Note: hypercall status (RAX) is not preserved correctly by L1 after
> +	 * synthetic vmexit, use unchecked version.

Nice...

> +	 */
> +	__hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT, 0x0,
> +			   HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PROCESSORS,
> +			   &unused);
> +	/* Make sure we're no issuing Hyper-V TLB flush call again */
> +	__asm__ __volatile__ ("mov $0xdeadbeef, %rcx");
> +
>  	/* Done, exit to L1 and never come back.  */
>  	vmcall();
>  }
>  
> -void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages)
> +void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
> +		vm_vaddr_t hv_hcall_page_gpa)
>  {
>  #define L2_GUEST_STACK_SIZE 64
>  	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
>  
> +	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
> +	wrmsr(HV_X64_MSR_HYPERCALL, hv_hcall_page_gpa);
> +
>  	x2apic_enable();
>  
>  	GUEST_SYNC(1);
> @@ -102,6 +123,14 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages)
>  	vmwrite(PIN_BASED_VM_EXEC_CONTROL, vmreadz(PIN_BASED_VM_EXEC_CONTROL) |
>  		PIN_BASED_NMI_EXITING);
>  
> +	/* L2 TLB flush setup */
> +	current_evmcs->partition_assist_page = hv_pages->partition_assist_gpa;
> +	current_evmcs->hv_enlightenments_control.nested_flush_hypercall = 1;
> +	current_evmcs->hv_vm_id = 1;
> +	current_evmcs->hv_vp_id = 1;
> +	current_vp_assist->nested_control.features.directhypercall = 1;
> +	*(u32 *)(hv_pages->partition_assist) = 0;
> +
>  	GUEST_ASSERT(!vmlaunch());

Pre-existing code, but would it make sense to add an assert here to verify L2
exited due to an NMI?  Feel free to ignore this for now if it's not straightforward,
this series is plenty big :-)
