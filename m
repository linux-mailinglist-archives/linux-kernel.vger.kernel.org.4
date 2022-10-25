Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A7D60C9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiJYKNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiJYKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4C714FD0F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666692314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkMY2q7k/FRScATXzFjfEIt8wnjgYfKsZeIIXZ3g4lg=;
        b=Hb0BkHQ9GI+AMUEa2uZeqFKA6oGI4JX9MJ62mNiJsc6zkSJ9l8+NtF2apaZaOdAQ/713OV
        0bOYBahz0z6YWYGYo9ZPVXZxWLJfrK/6v8sNkbAZcdbfFc+v0NAB0M+/Il1OShCJRNbCoX
        beJl9z+5w65N2vwYQMmCDI0brlGWQlE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-tCvdeM3wMFC7ORiw4fbwvA-1; Tue, 25 Oct 2022 06:05:05 -0400
X-MC-Unique: tCvdeM3wMFC7ORiw4fbwvA-1
Received: by mail-qk1-f200.google.com with SMTP id u6-20020a05620a430600b006e47fa02576so11156694qko.22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkMY2q7k/FRScATXzFjfEIt8wnjgYfKsZeIIXZ3g4lg=;
        b=nYwcum8x5LNd2mtPDbiDnEQatmN/7sX6gUXrT7EdHWIY9Uw6ftt7/uL5a833PO28Pj
         mo29t9baMRnggYLPnPgb+hzdU6PNo29aB1UCKajP+wVSEspaqJO0FId9lz0qRAr9R1bz
         G/gp8ZrgFUh0loMMkJ5MXFDq+XpTDozFm3tfPlw2qVRWWbgEt2bsrvKjTHLOfWi/FqU7
         uYRGLtmtnRjAp6BEcHzi2UhlLhbNjpbtp847EzFROZSb7R6Ug4H6SLjrSm9KsWLqoMdW
         knGNniRYUpp0qWZ4++zvizCTeA28Ax+RVXbjJBGjrbvBCjzHKe7XblL9l1iSSVc/n20t
         DfvA==
X-Gm-Message-State: ACrzQf25z2GPUR2J9xdHJUAj5bMPk92lMH32l61sQrbdLepytJxTFQzb
        im/hlpy150XUZ/kVNzFXs2Mw6EMKVzuxMf3vZ6E3xUj5Hfz4hF0aiP9/1n8Ytya9GrzOoi65bAM
        Dqfqiyk2NrioTCQn3S7ew6LJi
X-Received: by 2002:a05:6214:21e5:b0:4b3:f3e0:5432 with SMTP id p5-20020a05621421e500b004b3f3e05432mr30997935qvj.19.1666692305295;
        Tue, 25 Oct 2022 03:05:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM693U09GZt8c3TCu0FJo9qI1g4ScuhxN9DXfAJplWl/vGo09zLnXBtWBBG2qZwZQgoHuj3OGw==
X-Received: by 2002:a05:6214:21e5:b0:4b3:f3e0:5432 with SMTP id p5-20020a05621421e500b004b3f3e05432mr30997911qvj.19.1666692305082;
        Tue, 25 Oct 2022 03:05:05 -0700 (PDT)
Received: from [10.201.49.36] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.googlemail.com with ESMTPSA id d13-20020a05620a240d00b006bc192d277csm1807519qkn.10.2022.10.25.03.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:05:04 -0700 (PDT)
Message-ID: <6812bb87-f355-eddb-c484-b3bb089dd630@redhat.com>
Date:   Tue, 25 Oct 2022 12:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 4/4] KVM: use signals to abort enter_guest/blocking and
 retry
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022154819.1823133-1-eesposit@redhat.com>
 <20221022154819.1823133-5-eesposit@redhat.com>
 <5ee4eeb8-4d61-06fc-f80d-06efeeffe902@redhat.com>
 <4ef882c2-1535-d7df-d474-e5fab2975f53@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <4ef882c2-1535-d7df-d474-e5fab2975f53@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 09:43, Emanuele Giuseppe Esposito wrote:
>> Since the userspace should anyway avoid going into this effectively-busy
>> wait, what about clearing the request after the first exit?  The
>> cancellation ioctl can be kept for vCPUs that are never entered after
>> KVM_KICK_ALL_RUNNING_VCPUS.  Alternatively, kvm_clear_all_cpus_request
>> could be done right before up_write().
>
> Clearing makes sense, but should we "trust" the userspace not to go into
> busy wait?

I think so, there are many other ways for userspace to screw up.

> What's the typical "contract" between KVM and the userspace? Meaning,
> should we cover the basic usage mistakes like forgetting to busy wait on
> KVM_RUN?

Being able to remove the second ioctl if you do (sort-of pseudocode 
based on this v1)

	kvm_make_all_cpus_request(kvm, KVM_REQ_USERSPACE_KICK);
	down_write(&kvm->memory_transaction);
	up_write(&kvm->memory_transaction);
	kvm_clear_all_cpus_request(kvm, KVM_REQ_USERSPACE_KICK);

would be worth it, I think.

Paolo

