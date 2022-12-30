Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFD1657632
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiL1MAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiL1L7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:59:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AEB11152
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672228721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYdiyUW7v3jDVb1QwzZWNab9jTsMpMxmysun3BoXT8E=;
        b=BUmrbtzLHXKgoS2cqq0PXGvKWAC5e997bHYtEwEZOPPY6zk7DsT/+SPsXE6A6fPtiiXYhA
        uyHReXcNu9XqL42bARoWjCMgaenQqa8jNDHYzG9cijSu0VK/eSeq7ZmFHbXk8Cha1R6yly
        zEs0Zs6zSvzH6xkrIgVz+EL76A54CIw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-dwne7f2zMYm91zpK6IEBdA-1; Wed, 28 Dec 2022 06:58:39 -0500
X-MC-Unique: dwne7f2zMYm91zpK6IEBdA-1
Received: by mail-ej1-f72.google.com with SMTP id qw20-20020a1709066a1400b007c1727f7c55so10599558ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYdiyUW7v3jDVb1QwzZWNab9jTsMpMxmysun3BoXT8E=;
        b=tZSoKhDDiC/T/RKfMx44kqnA9dl7M+7G6gLTL8z4i6WFCnrgJWRQnZipnjzB5W6HLb
         8ynTPgkVJpkviuIyEfmpy4UUvPW49lYR4P81QBeVkQNIHYFishxkv/v8BE8/7AC9Ulvu
         SkGkvmkXQNJqsLuQ13npw9f5gcGJ6lmYyPOwsKwuuFbd98HwMmnheFAXOPrfAwZGPFZS
         wBNLcCsUbWeXZ4rxIkM+xjey4oviEFwpNE5J9G7OuXohrQJhYJzwu4rwFZGjDI6OD2dY
         zyOXVIpPbao3Xa95UJLCL8S95f/FuDmTYLQpQ+yyc5nVVJgfDsPItlWXDfqE8ATvD2Jt
         biug==
X-Gm-Message-State: AFqh2krHFQJZhyYsDIvZotNFL00MauN7f+0rku6hU4zM/hytklRqjegh
        Zv3WM+SLnn2t5rorucMr1L14Wxe+nTkARkgc7o4EwiVL2wzBVeY73blwxJm3Ec+3n5dvIoDstDL
        ZaI7qDO/O812aIIJcsvQY5ugO
X-Received: by 2002:aa7:de15:0:b0:483:30d7:f9ac with SMTP id h21-20020aa7de15000000b0048330d7f9acmr12028247edv.19.1672228718682;
        Wed, 28 Dec 2022 03:58:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtrIO5srJBbY8oizuyf5Q39Hr1tveD2PqIx/4KuqYlJNhV9zI7izo96N6ps5dxKil3bsWjXNA==
X-Received: by 2002:aa7:de15:0:b0:483:30d7:f9ac with SMTP id h21-20020aa7de15000000b0048330d7f9acmr12028204edv.19.1672228718422;
        Wed, 28 Dec 2022 03:58:38 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id h25-20020aa7de19000000b00463b9d47e1fsm7031261edv.71.2022.12.28.03.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 03:58:37 -0800 (PST)
Message-ID: <55a31d67-b9d0-1a62-1c60-f86b48a34a8b@redhat.com>
Date:   Wed, 28 Dec 2022 12:58:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 00/50] KVM: Rework kvm_init() and hardware enabling
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221227130249.1650197-1-pbonzini@redhat.com>
 <9acea262dec3511e9cf63081506f0bd7@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <9acea262dec3511e9cf63081506f0bd7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 12:22, Marc Zyngier wrote:
> 
>> Queued, thanks.  I will leave this in kvm/queue after testing everything
>> else and moving it to kvm/next; this way, we can wait for test results
>> on other architectures.
> 
> Can you please make this a topic branch, and if possible based
> on a released -rc? It would make it a lot easier for everyone.

Yes, I will (it will be based on 6.2-rc1 + pull request for rc2 that I'm 
preparing + x86 changes that this conflicts with).

Paolo

