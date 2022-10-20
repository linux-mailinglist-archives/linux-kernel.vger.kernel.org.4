Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581AB60599D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiJTIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJTIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716BA183E0C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666254144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXxC5THgAjtEYfgbLwABUhO1u5EsuU0JRYrQfyg0GwE=;
        b=R1Pdy+BjhwRCyyXekrFJbbHc1VsEK9rMt6hsSg5QjxzMtluaCqITfmO7RVtWxDkiRT1Myn
        3f4lCfCr//zPBn6eIaLxY76QhSibnN2QvsvuA/Vw0xPo9U2gBbAdCAFh2cSj0R8eY5L/f+
        4TcQ7yzx/l+n5KoteVRVRV2buVBeJZI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-v6C8G18dMSCqGyaZ7YwHRQ-1; Thu, 20 Oct 2022 04:22:22 -0400
X-MC-Unique: v6C8G18dMSCqGyaZ7YwHRQ-1
Received: by mail-ej1-f69.google.com with SMTP id sb13-20020a1709076d8d00b0078d8e1f6f7aso9173820ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXxC5THgAjtEYfgbLwABUhO1u5EsuU0JRYrQfyg0GwE=;
        b=EJY3gNUI1ONTcMhdRPIR05ADKPvQvanoyI6tcUT7O/7soX3AhneBUwaeW1EbAHWgis
         4omhds69H9YQ4ilNy1iTpkHSDsf1VidBRbO2inuKS+G8Kk9mujxFbavfZoTNgpEh9+WH
         1OhbSZLpsAIyA+gkwZ8uXtS3oNNOerdvDbwnfO0IgO5dDmcMqqULwvWH5KXzTqQIWqQL
         PmU9hufUYFKZVtzS2rmVgt/0daR9i8xbx8WFcxVwj36uVibYEZ/DXpn9QjqGTsndFSZY
         7ng0b2g49Jt8+MGH9HTGzvePwxHFmT9MB1CGzIsQjQTr0pi8pgk+rhqhUMco+t+0/Zg6
         Q20Q==
X-Gm-Message-State: ACrzQf0w52P+SG79yRo10oKOCDw/KtSSeFrTUSn/7x2fHRbCwc35K9S9
        vvvpoVSmhUyYarTbeI8aoE7YHEQfxsQWE04WIw8kizfLkfNSKUF7MHPyf6I4PHSy4fkOcWp7y/B
        t2pNYu073nBQ4DEt1YotN6tzOHQ49TzbngwCWAV6OlGfVSkj4HIqHAz14gXqvdDqasat6vr4Vxm
        AQ
X-Received: by 2002:a17:907:971c:b0:78e:63f:c766 with SMTP id jg28-20020a170907971c00b0078e063fc766mr9957399ejc.330.1666254141416;
        Thu, 20 Oct 2022 01:22:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM77hNuYpdTNzaBxaGl4qanwjEest2MmHQgxj9LIOEFNPTGkaoTFS2OSELTfyljEa7SX2DQbRw==
X-Received: by 2002:a17:907:971c:b0:78e:63f:c766 with SMTP id jg28-20020a170907971c00b0078e063fc766mr9957379ejc.330.1666254141175;
        Thu, 20 Oct 2022 01:22:21 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t14-20020a05640203ce00b00459e3a3f3ddsm11633580edw.79.2022.10.20.01.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:22:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/46] KVM: x86: hyper-v: Fine-grained TLB flush +
 L2 TLB flush features
In-Reply-To: <Y1B4kAIsc8Z0b2P9@google.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <Y1B4kAIsc8Z0b2P9@google.com>
Date:   Thu, 20 Oct 2022 10:22:19 +0200
Message-ID: <87v8oedhvo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
>> Changes since v10 (Sean):
>> - New patches added:
>>   - "x86/hyperv: Move VMCB enlightenment definitions to hyperv-tlfs.h"
>>   - "KVM: selftests: Move "struct hv_enlightenments" to x86_64/svm.h"
>>   - "KVM: SVM: Add a proper field for Hyper-V VMCB enlightenments"
>>   - 'x86/hyperv: KVM: Rename "hv_enlightenments" to "hv_vmcb_enlightenments"'
>>   - 'KVM: VMX: Rename "vmx/evmcs.{ch}" to "vmx/hyperv.{ch}"'
>>   - "KVM: x86: Move clearing of TLB_FLUSH_CURRENT to kvm_vcpu_flush_tlb_all()"
>>   - "KVM: selftests: Drop helpers to read/write page table entries"
>>   - "KVM: x86: Make kvm_hv_get_assist_page() return 0/-errno"
>> - Removed patches:
>>   - "KVM: selftests: Export _vm_get_page_table_entry()"
>> - Main differences:
>>   - Move Hyper-V TLB flushing out of kvm_service_local_tlb_flush_requests().
>>     On SVM, Hyper-V TLB flush FIFO is emptied from svm_flush_tlb_current()
>>   - Don't disable IRQs in hv_tlb_flush_enqueue().
>>   - Don't call kvm_vcpu_flush_tlb_guest() from kvm_hv_vcpu_flush_tlb() but
>>     return -errno instead.
>>   - Avoid unneded flushes in !EPT/!NPT cases.
>>   - Optimize hv_is_vp_in_sparse_set().
>>   - Move TLFS definitions to asm/hyperv-tlfs.h.
>>   - Use u64 vals in Hyper-V PV TLB flush selftest + multiple smaler changes
>>   - Typos, indentation, renames, ...
>
> Some nits throughout, but nothing major.  Everything could be fixed up when
> applying, but if it's not too much trouble I'd prefer a v11, the potential changes
> to kvm_hv_hypercall_complete() aren't completely trivial.

Thanks for the review! Let me do v12 to address your comments, I plan to
do it tomorrow.

-- 
Vitaly

