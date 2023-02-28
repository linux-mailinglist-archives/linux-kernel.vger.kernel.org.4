Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA296A60ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjB1VGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1VGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639220551
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677618331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/5hmQVwpzcKmo7ZySLNvsyz1qAPMMBkqrZKd0ciXbk=;
        b=Jy+1YGaoBGTEjXW1VWcUjBRb0QGaueW1g9Tl6FeCXLl1AMtwrb0j36EJZJnXkI10ESJAgx
        fTNduwbLZnRS0x9TvuwPrFaJOsiLsZBklZMs24yLGlVzGSIV9aS7QU7Tw8u63ftBk+IN1m
        BS6OK1Ej9i6YRwkpHmkUWvEPFJv9vXU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-Z0ocw5I0NSejBwl4j0gVig-1; Tue, 28 Feb 2023 16:05:29 -0500
X-MC-Unique: Z0ocw5I0NSejBwl4j0gVig-1
Received: by mail-wr1-f71.google.com with SMTP id a7-20020a056000188700b002c53d342406so1854413wri.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/5hmQVwpzcKmo7ZySLNvsyz1qAPMMBkqrZKd0ciXbk=;
        b=TReajs6f/iFFaiip62X36Ej90htAW5q5PJ71h4Ig26LqWhFeXFseL1dlMJTBl6xeq7
         jEIy7T2Dhvg0FRTLD3BcBc5gDJ8d9MDIV/j2SonEwHRB9LEwh6V8hP/lPL09orRWO73i
         pMcmnKrw6lBFguJfMA2PEY5Gyo9Ri0S1ocy0qifGP4Ik7GlO3Bu7B+qdIciXGTRKGcfb
         /YEa9pSoV+1TXSLuikjr9j7HApaTWV938Fp/oH1tUQJQje/NrDeEqsmsst5v18KPbr9z
         Zp0S7QdcwoF9eQBwy/8bXh3ongexLoRWcv237nzb3DJyDQzfvEK9IytBu/h5PAkRgII7
         av5g==
X-Gm-Message-State: AO0yUKWJYiBo17v5O7BT+S2/ohvetG6mWSlncyyrfmqLc55DmpyGps0H
        hMjRX1LMrvCPIT7Jq7JXg4CNXfFfFtl1sFN5Xvuas4JBZLnNFbdTq1m+JNZ/vnGciu3F0XnBllt
        9EKURgkTckNgqKkmvNnHQ8W9C
X-Received: by 2002:a05:600c:1d28:b0:3e2:147f:ac1a with SMTP id l40-20020a05600c1d2800b003e2147fac1amr3385142wms.21.1677618328376;
        Tue, 28 Feb 2023 13:05:28 -0800 (PST)
X-Google-Smtp-Source: AK7set9zrY1Ob9BThSVmM8VM9t39M7li3rs0M0P+LAVMOqBxDLKVC6qz7tgEwMKRPuRCd+1G8HlP3w==
X-Received: by 2002:a05:600c:1d28:b0:3e2:147f:ac1a with SMTP id l40-20020a05600c1d2800b003e2147fac1amr3385132wms.21.1677618328092;
        Tue, 28 Feb 2023 13:05:28 -0800 (PST)
Received: from [192.168.8.100] (tmo-112-221.customers.d1-online.com. [80.187.112.221])
        by smtp.gmail.com with ESMTPSA id bh22-20020a05600c3d1600b003e01493b136sm17087499wmb.43.2023.02.28.13.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 13:05:27 -0800 (PST)
Message-ID: <04213fad-909f-e86d-caaa-c559917b2e4d@redhat.com>
Date:   Tue, 28 Feb 2023 22:05:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 6/6] KVM: Change return type of kvm_arch_vm_ioctl() to
 "int"
Content-Language: en-US
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Gavin Shan <gshan@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <20230208140105.655814-1-thuth@redhat.com>
 <20230208140105.655814-7-thuth@redhat.com>
In-Reply-To: <20230208140105.655814-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 15.01, Thomas Huth wrote:
> All kvm_arch_vm_ioctl() implementations now only deal with "int"
> types as return values, so we can change the return type of these
> functions to use "int" instead of "long".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/arm64/kvm/arm.c       | 3 +--
>   arch/mips/kvm/mips.c       | 4 ++--
>   arch/powerpc/kvm/powerpc.c | 5 ++---
>   arch/riscv/kvm/vm.c        | 3 +--
>   arch/s390/kvm/kvm-s390.c   | 3 +--
>   arch/x86/kvm/x86.c         | 3 +--
>   include/linux/kvm_host.h   | 3 +--
>   7 files changed, 9 insertions(+), 15 deletions(-)

Ping!

Unless I missed something, I think this series had enough review ... Paolo, 
could you maybe queue the whole series, since it's mostly an 
architecture-wide clean up?

  Thanks,
   Thomas

