Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B825EF956
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiI2Pny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiI2PnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F5128A29
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664466124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOs9j6EKBWVbeXkdg2VQcpSwEuz7CVtI8gZySG/+hp4=;
        b=M+Fw2qRG4cZC8Ov+dNvz12/Iyzr+cMDVdIqLumsgKFa8oqTd+7OTweFVEHgyQukPIlTFkc
        sjEkN+IgN4h3TgZ0edCfuriRLhCcGxiClLtQaA1J/1+HCTyNWjGO1xU36APWMHZPb8WK2y
        zS2NSgGbn57VmljgnzoRInAGHKyDr+w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-tmJme51MPg6BNx_6JDpG9g-1; Thu, 29 Sep 2022 11:42:03 -0400
X-MC-Unique: tmJme51MPg6BNx_6JDpG9g-1
Received: by mail-ej1-f70.google.com with SMTP id xc12-20020a170907074c00b007416699ea14so897182ejb.19
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AOs9j6EKBWVbeXkdg2VQcpSwEuz7CVtI8gZySG/+hp4=;
        b=5cRcv8dHLNoxF/3iC061i7Ptfk8EKqF6zHQYPhr7o88MyqdNPvjgpWkicOnRz69+6y
         CRkihUEklc1T4I+GYWYlYuaLLoeGqmYw1Gds4z8E33SJsYHzUJ7IYhxjmOoL7HbRqul9
         kSxH/z3zOXouAD6dzrpw4aLEWBcN8Qhsr87WG6u+7ApsQJ7II5Nminym2tpn1ygRci9t
         iqOkJIBH6Yxsuvfop6dEK8/Let3Ez3IgWxfZxS7AjT3dKlYdQ1Llk0Mgy0AKBsmxHYro
         Q+k0flYrN7FtU2zC/07+wzZf35huu+feyl8iQnB3PmL/qFzONOZh06QfUSuA5wkihE9z
         Svgg==
X-Gm-Message-State: ACrzQf1oLOv8XMlp1+x9PE/OpDm3Ucri4aKdyYzqii2Xb8pFx+gpzTYK
        HKQrSVYTt5edICdCpEaydTUxNyr3UdCZ1+6mj/TV3ZXCfoQ4PYDCoxilmb3QNCGjByTbqJv7/zw
        OSkZ23HpP/dCSwxoL2DDfKNhT
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id wt6-20020a170906ee8600b0074189bc27a1mr3298325ejb.725.1664466122055;
        Thu, 29 Sep 2022 08:42:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ZN9if01aUOq3bhS/GofCuFW4G12pkPcLFKXn1n96bCMOjelB6Gu6laZwmcmKakTUeYZixOA==
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id wt6-20020a170906ee8600b0074189bc27a1mr3298314ejb.725.1664466121822;
        Thu, 29 Sep 2022 08:42:01 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id x2-20020a1709060ee200b0073dde62713asm4159050eji.89.2022.09.29.08.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:42:00 -0700 (PDT)
Message-ID: <5a352ff5-5d37-e92d-3d4b-c70a5d11c41b@redhat.com>
Date:   Thu, 29 Sep 2022 17:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
References: <111a46c1-7082-62e3-4f3a-860a95cd560a@redhat.com>
 <14d5b8f2-7cb6-ce24-c7a7-32aa9117c953@redhat.com>
 <YzIZhn47brWBfQah@google.com>
 <3b04db9d-0177-7e6e-a54c-a28ada8b1d36@redhat.com>
 <YzMdjSkKaJ8HyWXh@google.com>
 <dd6db8c9-80b1-b6c5-29b8-5eced48f1303@redhat.com>
 <YzRvMZDoukMbeaxR@google.com>
 <8534dfe4-bc71-2c14-b268-e610a3111d14@redhat.com>
 <YzSxhHzgNKHL3Cvm@google.com>
 <637e7ef3-e204-52fc-a4ff-1f0df5227a3e@redhat.com>
 <YzW3VxqZTb2hnXCy@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/9] kvm: implement atomic memslot updates
In-Reply-To: <YzW3VxqZTb2hnXCy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 17:18, Sean Christopherson wrote:
> IMO, KVM_MEM_DISABLED or similar is the way to go.  I.e. formalize the "restart
> page faults" semantics without taking on the complexity of batched updates.

If userspace has to collaborate, KVM_MEM_DISABLED (or KVM_MEM_USER_EXIT 
would be a better name) is not needed either except as an optimization; 
you can just kick all CPUs unconditionally.

And in fact KVM_MEM_DISABLED is not particularly easy to implement 
either; in order to allow split/merge it should be possible for a new 
memslot to replace multiple disabled memslots, in order to allow 
merging, and to be only partially overlap the first/last disabled 
memslot it replaces.

None of this is allowed for other memslots, so exactly the same metadata 
complications exist as for other options such as wholesale replacement 
or batched updates.  The only semantics with a sane implementation would 
be to destroy the dirty bitmap of disabled memslots when they are 
replaced.  At least it would be possible for userspace to set 
KVM_MEM_DISABLED, issue KVM_GET_DIRTY_LOG and then finally create the 
new memslot.  That would be _correct_, but still not very appealing.

I don't exclude suffering from tunnel vision, but batched updates to me 
still seem to be the least bad option.

Paolo

