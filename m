Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009FB5EE23A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiI1Qs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiI1QsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B1672FDD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664383702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5bl17BdmyDYyPUE/8jt72C/fktO9MW/fTZWFGHBrao=;
        b=iXe4VjT87fBuwnU6Lupe7bRvuvUhYnuQKqpDdDsW9El/suM0MBO5Y53+UkxpCD1BU3bx1r
        Krj+NhMm68DMb4J6JJa9BpQZRsWB15BA5hqZWNgWjX+Hkwjh3WvCxMI5jmM9KKPO5s0Kqn
        z4vQiwxlqgl8qhwvKJhZBOj5rSVIaHk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-480-yx0FZ-goPMeKohA1bbC2fA-1; Wed, 28 Sep 2022 12:48:20 -0400
X-MC-Unique: yx0FZ-goPMeKohA1bbC2fA-1
Received: by mail-ed1-f72.google.com with SMTP id c6-20020a05640227c600b004521382116dso10923983ede.22
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=X5bl17BdmyDYyPUE/8jt72C/fktO9MW/fTZWFGHBrao=;
        b=MFvTAKBI45Vr5fjrAKsFu9I04jKGHu573pY/8q9qpLv8+uTmUIRUn9gAWCsmN8j+Hx
         /nG+7ideQ91C6Ho00NX8RgwWvxDf1ISGj0YDj0S3iWOeP1HOYx38Vph/QVnIGjrWpIW5
         8rwEZggZSs4js3liyserZBF7AsKkZ72ZEqxiUWH8+yKRiLHSXPdvMX+Dnpannqrhf7Zz
         dLoOHUU7nMffhDYIJCgNfzrrkxi4T/w57rWBZzGV6dBvkJ+akS1SeQLKH7UG3dJFlPcG
         ONtF51Z342u9FXGSzGQ0KU54ikRtsR3aWZJxNQ5NUwV/61m2Uvi4G8oXRrRiHcSCSxvk
         MHvg==
X-Gm-Message-State: ACrzQf2Jpc7pnDW51qmJXiG2GEN9PHaAVjLQnlb5UcPj5NGuLkXg/FsL
        6GKNJMcRcUaJAXilzGH3iNk3ilT7v1cvJJ4IEiR6cSy0rc8eeFj6FT+E5m8ZYWCKrDjfZS5X1Rx
        9jA4Y6jBh1zj4JA5BB+NJL/Qq
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr28680280ejb.438.1664383699574;
        Wed, 28 Sep 2022 09:48:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5fPF3wKkf0lsaEPNIQzhxlJkV/0dZuDzUJG0rJDL+7nhengYesZYeExDDLbx6Q+0UVcLHlbA==
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr28680258ejb.438.1664383699375;
        Wed, 28 Sep 2022 09:48:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id e24-20020a170906375800b0077077b59085sm2603687ejc.184.2022.09.28.09.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:48:18 -0700 (PDT)
Message-ID: <6dac022d-3ac1-bc47-a6ac-89a1f24f3bb8@redhat.com>
Date:   Wed, 28 Sep 2022 18:48:17 +0200
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
 <20220909104506.738478-4-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 3/9] kvm_main.c: introduce
 kvm_internal_memory_region_list
In-Reply-To: <20220909104506.738478-4-eesposit@redhat.com>
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
> +struct kvm_internal_memory_region_list {
> +	/* Fields initialized in __kvm_set_memory_region() */
> +	struct kvm_memory_slot *old;
> +	struct kvm_memory_slot *new;
> +	struct kvm_memory_slot *invalid;
> +	enum kvm_mr_change change;
> +};
> +

Alternative name: kvm_memslot_change

>  int __kvm_set_memory_region(struct kvm *kvm,
> -			    const struct kvm_userspace_memory_region *mem);
> +			    const struct kvm_userspace_memory_region *mem,
> +			    struct kvm_internal_memory_region_list *batch);

A bit weird to have this passed by the caller.  I'd rather have 
__kvm_set_memory_region with the *batch argument (which I'd call instead 
*change), and design kvm_set_memory_region so that, at the end of the 
series, it is something like:

int kvm_set_memory_region(struct kvm *kvm,
			  const struct kvm_userspace_memory_region *mem)
{
	struct kvm_memslot_change change = {};
	r = __kvm_set_memory_region(kvm, mem, &change);
	if (r < 0)
		return r;
	r = invalidate_memslot_for_change(kvm, &change);
	if (r < 0)
		return r;
	return commit_memslot_change(kvm, &change);
}

Paolo

