Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2956591D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiL2UxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiL2UxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1B5BC0D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672347148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DeG05ASAQvY/FceYSGJdKCGQ3OFwx25lz4jlpRPWbnU=;
        b=CyydvGwzPP3fLVYWpVliXmXQqCrkO5vFWqD2G/eF6WnvrzLE9bE4odPOFEByCJPXx1zK7N
        3CW4NLlm4xL0AqHnTqMhsk9cWBJ6Uuhsic1loBCpqEVeOVsFEOTwngBg+tn14ERoLM33Ac
        yUygSuFg7+aLVxGsIqRVpizKmEoGM14=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-2y7CwD2ZPyOBvwHcz4jBAQ-1; Thu, 29 Dec 2022 15:52:27 -0500
X-MC-Unique: 2y7CwD2ZPyOBvwHcz4jBAQ-1
Received: by mail-ed1-f71.google.com with SMTP id v4-20020a056402348400b0046cbbc786bdso13344857edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeG05ASAQvY/FceYSGJdKCGQ3OFwx25lz4jlpRPWbnU=;
        b=4EjAXDL73j/jeJw9NA67qZJUul3mq/sWzsgW/7k4bO8Aws3/KCutzu27+mKNObo1dT
         xVorQXwZgy4lbbESIXwPj+XLzw6v7FgIehEB6+qkBQ75dcg9cjK0cbNu9MuXKKdOuJw4
         SSUkTOsLrvpNXWW1pdrxoCa+45ZJBsHhXwivZUOpTNe5FpTIoBB4ptg65TDtpVWnhWLm
         9Xjpbx0LwmOF2LiUUt5JJHPmZB1iV0PmC80KTH6i4/aGFkWV/IZqPhbLCMNXmDoyKE9l
         RGZJtuNuOGzTJvMtt0fagvefxndG7zUb0xy72ZmkGqOa27Zfspscrf0Sr7oaCpLcDEmo
         CRMg==
X-Gm-Message-State: AFqh2koZulaclAz05orz71ONbuWmTMQZUfTFIQmJTK79qPocPO5Fkyju
        bzpMOq1sbi0Qgm1QKP5VZs5kICxPxCqIFfUHnrSU0u4sNlDZhyVYIyKuSVvcvVxu59xkaaoeYVy
        29fsxu1tBfsphiAzWz8HZBN69
X-Received: by 2002:a17:907:6f09:b0:7c1:37:6d5e with SMTP id sy9-20020a1709076f0900b007c100376d5emr4872268ejc.2.1672347146329;
        Thu, 29 Dec 2022 12:52:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuAZx8SHyajJmJ++QT23AGJAvs5IxosEfN11APvih7Pbj5KPIpkonmPHiwyMLfqMEbO8Dqn3Q==
X-Received: by 2002:a17:907:6f09:b0:7c1:37:6d5e with SMTP id sy9-20020a1709076f0900b007c100376d5emr4872244ejc.2.1672347146101;
        Thu, 29 Dec 2022 12:52:26 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::529? ([2001:b07:6468:f312::529])
        by smtp.googlemail.com with ESMTPSA id 23-20020a170906301700b0084c90164a56sm1096571ejz.29.2022.12.29.12.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:52:25 -0800 (PST)
Message-ID: <4d73d1b9-2c28-ab6a-2963-579bcc7a9e67@redhat.com>
Date:   Thu, 29 Dec 2022 21:52:21 +0100
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

This is now refs/heads/kvm-hw-enable-refactor in 
https://git.kernel.org/pub/scm/virt/kvm/kvm.git.

The commits for this series start at hash fc471e831016.

Paolo

