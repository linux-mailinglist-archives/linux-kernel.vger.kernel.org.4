Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5435EE323
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiI1R34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiI1R3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6B112A8D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664386181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YM6qjwCkh2H9OE1aBHkRCrRvD9Zqt2YLUCUgTTQKZuY=;
        b=HgQOB++eTkoJINC1GwGJ8WRLJ1dg1tyt6BJ+uu7Ba58a8FVtL188q6g248EgdHGeyjf59L
        2KynrsS0/ScgTXWXumMlbLfpylHWuqBDgz0yQVzjqB6EVdMHJvrysDZtvJreciAYWqODDO
        09GV4ztnVWMPAvQRqy0RzlDkPy2g9Ns=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-31-uz8F-JbcPeiolwT3-XBlVw-1; Wed, 28 Sep 2022 13:29:25 -0400
X-MC-Unique: uz8F-JbcPeiolwT3-XBlVw-1
Received: by mail-ed1-f70.google.com with SMTP id f10-20020a0564021e8a00b00451be6582d5so10857036edf.15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YM6qjwCkh2H9OE1aBHkRCrRvD9Zqt2YLUCUgTTQKZuY=;
        b=MM1fm+xnnzxL+VDwqThN4up+tBV8EHrepg4FQ67boSXTfUaD0Tu0y02mr+yl0Palut
         KBhonnT654XD4xD4/rRCHcvcYjRPEr7QB2e326tXeU5Q4+KJzVdQimjvnOGwhek+Rn4V
         9miaElKtsrLrVcWCdTE6Hpsjzz24UGpR0UY3doAXkvndUvVZKhMghW0p1Smz/iHEo7pX
         xmi6QJMgtyB3S+rSGva1OfEYXYK81Tu6pk+7Vu5SyCbla3Aq/TN8Wf4vUjffwJ8Tiq7b
         MTFgzHqQJ1TDpbLgRL2aFft0XU+1KgQMe6dOI//sA0Dp1NieSyxH5SKHSqGrUkPDDHuj
         3xsA==
X-Gm-Message-State: ACrzQf2Al2Flss2olPOtwS35EEnbrtw19nCapoAshtGYUs6o3PG5Ug7F
        zDqdwkL0dDIu4FskYZDOM+vW8UZ7m8PwrbaAtLUUwGmLuhSNza/uExZn2Xd5OkQfllIyKht3PPY
        GA32R8twBaogpaOtMOBGkeweo
X-Received: by 2002:a17:907:2cd8:b0:776:64a8:1adf with SMTP id hg24-20020a1709072cd800b0077664a81adfmr28547526ejc.151.1664386164492;
        Wed, 28 Sep 2022 10:29:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM49Zx192F3WqwwKeOxNbNV66Dczc1omWuvvjN/XHk+9G7wC0Jx1Zlri9Wj3NR9gRtpD4a/4Vg==
X-Received: by 2002:a17:907:2cd8:b0:776:64a8:1adf with SMTP id hg24-20020a1709072cd800b0077664a81adfmr28547509ejc.151.1664386164248;
        Wed, 28 Sep 2022 10:29:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id g5-20020a170906868500b0073c74bee6eesm2673719ejx.201.2022.09.28.10.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:29:23 -0700 (PDT)
Message-ID: <2f80a561-a338-cdb3-e641-d8803b859ce0@redhat.com>
Date:   Wed, 28 Sep 2022 19:29:22 +0200
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
 <20220909104506.738478-10-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 9/9] kvm_main.c: handle atomic memslot update
In-Reply-To: <20220909104506.738478-10-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 12:45, Emanuele Giuseppe Esposito wrote:
> @@ -1782,7 +1782,8 @@ static void kvm_update_flags_memslot(struct kvm *kvm,
>   
>   /*
>    * Takes kvm->slots_arch_lock, and releases it only if
> - * invalid_slot allocation or kvm_prepare_memory_region failed.
> + * invalid_slot allocation, kvm_prepare_memory_region failed
> + * or batch->is_move_delete is true.
>    */

This _is_ getting out of hand, though. :)  It is not clear to me why you 
need to do multiple swaps.  If you did a single swap, you could do all 
the allocations of invalid slots in a separate loop, called with 
slots_arch_lock taken and not released until the final swap.  In other 
words, something like

	mutex_lock(&kvm->slots_arch_lock);
	r = create_invalid_slots();
	if (r < 0)
		return r;

	replace_old_slots();

	// also handles abort on failure
	prepare_memory_regions();
	if (r < 0)
		return r;
	swap();
	finish_memslots();

where each function is little more than a loop over the corresponding 
function called by KVM_SET_MEMORY_REGION.

Paolo

