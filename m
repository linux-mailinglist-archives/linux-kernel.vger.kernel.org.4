Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0065A5EE284
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiI1REt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiI1REn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280ABBF7B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664384681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4d6KuZOsMOU7NFpnx9W10QIiBigRqBCL2YFQkOodRVs=;
        b=GNMv3bP1h/ABObSPbvs9cWvsi8PF1DtDbyxSPYNMjPJf0D33af4s8G99aib7YRVuOxFcNT
        GslubkPH7a3H6X3doeW6R8WvrYVK3XzaT9pGQTsuQJ5yrjfuNAWQ6j/b1j0g5ZNKn/lumQ
        BgwGPTWUimb4dD4kp+kGcRQMZfonDMk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-dvXjC3Y8OFCe8wShxuP_0w-1; Wed, 28 Sep 2022 13:04:39 -0400
X-MC-Unique: dvXjC3Y8OFCe8wShxuP_0w-1
Received: by mail-ej1-f70.google.com with SMTP id ga36-20020a1709070c2400b007837e12cd7bso4729368ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4d6KuZOsMOU7NFpnx9W10QIiBigRqBCL2YFQkOodRVs=;
        b=bv9NzcGTm9hXDgZP82xLRvBNIrTnoQrvL1pxOZKxj14jiarG8wptJ8q7n6ss+un563
         vbH2EWTck/G4+NniNLsnJ/Cwng/MGNEtuLwPMhiA/U0Q0bcbBmMeOFWV5lYPt7pICKaK
         axClP+tEFmMXK83FIdlvyq+clyuiJsw1ZS6wdYFmtS3rzK1ZQ6F19OIZ8QVgv+co3aJg
         xjrhbouJLd7VIerG5dGZukyW0GKVX3FvxoubBQA5KJp+mYABDYAfDdvbxCZvU5nD+wUC
         C9ebjo30SwDzJfZ2bWrpdL/Y9K95R2Z2CcK8aIxSxzxqtCvHSynFtnwbhzAoSPu1hQFR
         eEoQ==
X-Gm-Message-State: ACrzQf0M78wYDb9iyK+gVrGT08aCgSQgtyNuRAHHzbmzAh/zMJJJE8U7
        o+BijRpfaWo9Zl+Ldrs8AcVZUkDMlDXJ72n1oIoS+WceN3QkuIVzlUay9uKpXCRKKUXeCW+KoyG
        QuWjVmO6BlnVz9baX7V70TW1k
X-Received: by 2002:a05:6402:5249:b0:451:67ff:f02 with SMTP id t9-20020a056402524900b0045167ff0f02mr34874654edd.227.1664384678746;
        Wed, 28 Sep 2022 10:04:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4NDBS4umH69PMxzkco1fnOsqDzXTVFR/sVWEUDPz84ef+a4uvJEdWWjAYqykdEftyj9fvvUw==
X-Received: by 2002:a05:6402:5249:b0:451:67ff:f02 with SMTP id t9-20020a056402524900b0045167ff0f02mr34874609edd.227.1664384678433;
        Wed, 28 Sep 2022 10:04:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id kl14-20020a170907994e00b007813968e154sm2610479ejc.86.2022.09.28.10.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:04:37 -0700 (PDT)
Message-ID: <fd8fab58-2871-c2d4-f620-e454c7ac653e@redhat.com>
Date:   Wed, 28 Sep 2022 19:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220909104506.738478-1-eesposit@redhat.com>
 <20220909104506.738478-5-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 4/9] kvm_main.c: split logic in kvm_set_memslots
In-Reply-To: <20220909104506.738478-5-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 12:45, Emanuele Giuseppe Esposito wrote:
> +/*
> + * Takes kvm->slots_arch_lock, and releases it only if
> + * invalid_slot allocation or kvm_prepare_memory_region failed.
> +*/

Much simpler: "kvm->slots_arch_lock is taken on a successful return."

This is a small change in phrasing, but it makes a lot more sense: on 
success you are preparing for the final commit operation, otherwise you 
just want the caller to return your errno value.

[...]

> +/* Must be called with kvm->slots_arch_lock held, but releases it. */
s/but/and/.  Even better, "and releases it before returning".  "But" 
tells the reader that something strange is going on, "and" tells it that 
something simple is going on.

I would also rename the functions along the lines of my review to patch 
3, to highlight that these function prepare/commit a *change* to a memslot.

> +static void kvm_finish_memslot(struct kvm *kvm,
> +			       struct kvm_internal_memory_region_list *batch)
> +{
> +	struct kvm_memory_slot *invalid_slot = batch->invalid;
> +	struct kvm_memory_slot *old = batch->old;
> +	struct kvm_memory_slot *new = batch->new;
> +	enum kvm_mr_change change = batch->change;

lockdep_assert_held(&kvm->slots_arch_lock);

>   
>   	/*
>   	 * For DELETE and MOVE, the working slot is now active as the INVALID
> @@ -1883,6 +1898,18 @@ static int kvm_set_memslot(struct kvm *kvm,
>   	 * responsible for knowing that new->arch may be stale.
>   	 */
>   	kvm_commit_memory_region(kvm, batch);
> +}
> +
> +static int kvm_set_memslot(struct kvm *kvm,
> +			   struct kvm_internal_memory_region_list *batch)
> +{
> +	int r;
> +
> +	r = kvm_prepare_memslot(kvm, batch);
> +	if (r)
> +		return r;
> +
> +	kvm_finish_memslot(kvm, batch);
>   
>   	return 0;

Ok, these are the functions I hinted at in the review of the previous 
patch, so we're not far away.  You should be able to move the 
kvm_set_memslot call to kvm_set_memory_region in patch 3, and then 
replace it with the two calls here directly in kvm_set_memory_region.

Paolo

