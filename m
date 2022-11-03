Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD896182D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKCP3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiKCP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A21ADA5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667489275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCSLioTknXwq+ek9x4fiuIn1LdVr/LliQOq4IIs2CLE=;
        b=NZ3fF7TxqELuNFxzBWYoUexywm/lT8kIbKbKohyUpTBbq3FCShWRW+6COii9KwpFnmptp9
        hyvToGLdDDbpcM40ZbarMvN5EzStTHRyJ/kBOeg87+AcCd8ScXR40xQppiwcelGgDxPyNA
        xH6d6+ycZSRf4OF5jyYVNyAKI8uRHu4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-l3WKcMlzOr6GOUtYXUmStQ-1; Thu, 03 Nov 2022 11:27:52 -0400
X-MC-Unique: l3WKcMlzOr6GOUtYXUmStQ-1
Received: by mail-ed1-f72.google.com with SMTP id m7-20020a056402430700b0045daff6ee5dso1622485edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCSLioTknXwq+ek9x4fiuIn1LdVr/LliQOq4IIs2CLE=;
        b=7eKSrZHBXibDZnX9gKa5l/634rdAypCk9kwqaHZRzHfLjeJTlOSOt/y2suiKcjPAx9
         pl4pMibEvrWW5hNBiXA8EJ4A7F0nNh7eDBT9uaMEMAGA++ycTXZXIZPaNbBOqwbc4v70
         DZZRkvHqa1EGFYbjlsrUiZ/ePRww9hwLLLDPPX6IndFP9MYXcL+CuEhyYmG6x57nloWv
         7f8/7epZK90Kjcvb8k9obVfEE+6uecPohZ5OxhjLvadCB9Zwrklh5Xit7Ao5TNmL/7d3
         DtCo4P72JDAdeY5XSYw9pEnljHD8ILEUCb/pgwl8hjEOcT6SXDnJyzxSnG+/CZM8JIM+
         4DRQ==
X-Gm-Message-State: ACrzQf0zUMrpik/ZFlqMysbjel5J5XZteLbzc946s774400cpT+07ooN
        al4jbzrHTE+R7LpwjQ6NK6dqIsuxdIOOYHuhGi5ObKwZIulfgZUl6PKljv30SflHYn4eFwOLnTS
        +SF+u+rcOwqq9FanL99gONhsh
X-Received: by 2002:a17:907:2dab:b0:78d:fc4b:7e31 with SMTP id gt43-20020a1709072dab00b0078dfc4b7e31mr28147777ejc.531.1667489270832;
        Thu, 03 Nov 2022 08:27:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7u9a9PiI+1WXKEKW1T9dxImTSTFhIKArq6MPRri6hHxMVLdP9Ji+9iwit/AYCn6duMyFkDdg==
X-Received: by 2002:a17:907:2dab:b0:78d:fc4b:7e31 with SMTP id gt43-20020a1709072dab00b0078dfc4b7e31mr28147732ejc.531.1667489270591;
        Thu, 03 Nov 2022 08:27:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id 15-20020a508e4f000000b00463bc1ddc76sm657729edx.28.2022.11.03.08.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 08:27:49 -0700 (PDT)
Message-ID: <82df23f2-b049-8bee-8bb8-608645b918d8@redhat.com>
Date:   Thu, 3 Nov 2022 16:27:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 00/44] KVM: Rework kvm_init() and hardware enabling
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <b37267a9-c0b4-9841-71af-d8eab9baeb60@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <b37267a9-c0b4-9841-71af-d8eab9baeb60@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 13:08, Christian Borntraeger wrote:
>> There are bug fixes throughout this series.  They are more scattered than
>> I would usually prefer, but getting the sequencing correct was a gigantic
>> pain for many of the x86 fixes due to needing to fix common code in order
>> for the x86 fix to have any meaning.  And while the bugs are often fatal,
>> they aren't all that interesting for most users as they either require a
>> malicious admin or broken hardware, i.e. aren't likely to be encountered
>> by the vast majority of KVM users.  So unless someone _really_ wants a
>> particular fix isolated for backporting, I'm not planning on shuffling
>> patches.
>>
>> Tested on x86.  Lightly tested on arm64.  Compile tested only on all 
>> other architectures.
> 
> Some sniff tests seem to work ok on s390.

Thanks.  There are just a couple nits, and MIPS/PPC/RISC-V have very 
small changes.  Feel free to send me a pull request once Marc acks.

Paolo

