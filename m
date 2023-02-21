Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00F69DAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjBUGu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjBUGuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21724CB1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676962196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdGXGjyDjWDQeQBBtOyLZqj5HnH8aK5CO5+LaSjE4fA=;
        b=Bs4Lhn/q9jCRG0s4Pv+u7HLcreLMo6U35lN73COvLyVtdhajDnyCblNZhyP9T3alS8XF0N
        +k6w5ZxBl2YSOC2jiPanrdAxpfMyVg5uJLPRmk+/rGf7WlztDMXJL9BW9FuGS5L7KvobaX
        4n2IT1TeBWi+gBcfIV3969dMojrv8n8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-Q1J9yeVaPxKgmczpE421Cg-1; Tue, 21 Feb 2023 01:49:52 -0500
X-MC-Unique: Q1J9yeVaPxKgmczpE421Cg-1
Received: by mail-ed1-f71.google.com with SMTP id da15-20020a056402176f00b004ace822b750so4720210edb.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdGXGjyDjWDQeQBBtOyLZqj5HnH8aK5CO5+LaSjE4fA=;
        b=pWeT7wOd+6pc7XxaIEnbbIBtUlu5ML1zcp6Raueo9FYJpSLFiNIV8tTtobHjsZkZla
         ts7exIv9s9oBGEweIfdN1zb0YUGBxobskP4MoBcx5myF5xNk5XUcgfSIEnlyBV+xa3Qx
         kV9k9J1j/PhZkqp6Z2Khe3we9u/+3J13CbFqq7gZtHlsBS1yRxFUxC2IpbeIGC1w3My/
         BoVr1W1Q1X//qANmCZW187gvsTKMxsofpg2gFPsZhG/YW0D6ZSDd/9T4C06LzSU3obZf
         AYrYhkNscQCw25ylqnHag48AX5mQdi8EP1qOk9AurhqHndwR1eegQ9rYkwE1NXFSgPHL
         O0jw==
X-Gm-Message-State: AO0yUKXAWOJ6xAXTe2XBMxBM0+hOBhxIvCHW2uC4tEZiK7bNRbKx7nWW
        PtAxy3Y/WPBfTNKjUoNqLlMOAs2i4nM2Nfn7YyPPXJClGQx6O6YaUeRd99MrdruQ4AF32G45yfy
        guTEDv9YJ+/NZolGuJ1WQ/M9X
X-Received: by 2002:a17:907:2141:b0:8b1:264d:6187 with SMTP id rk1-20020a170907214100b008b1264d6187mr11442076ejb.46.1676962191317;
        Mon, 20 Feb 2023 22:49:51 -0800 (PST)
X-Google-Smtp-Source: AK7set/ANd+6fZun4U0ZKRNIdNMLK+fkVCSMqAKCf5G8i3f2jg6at5qAA1YS1LeNyQ9x9mWYKIHDHQ==
X-Received: by 2002:a17:907:2141:b0:8b1:264d:6187 with SMTP id rk1-20020a170907214100b008b1264d6187mr11442065ejb.46.1676962191043;
        Mon, 20 Feb 2023 22:49:51 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id gc20-20020a1709072b1400b008d85435f914sm1680469ejc.98.2023.02.20.22.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 22:49:50 -0800 (PST)
Message-ID: <d6e794c7-4741-a656-07ae-1cad4c26d93e@redhat.com>
Date:   Tue, 21 Feb 2023 07:49:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 01/29] LoongArch: KVM: Add kvm related header files
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn
References: <20230220065735.1282809-1-zhaotianrui@loongson.cn>
 <20230220065735.1282809-2-zhaotianrui@loongson.cn>
 <2b047b75-7397-0cce-e7af-ebba67ae2561@redhat.com>
 <c9dada46-829c-d3cd-c3b6-68a570552e84@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <c9dada46-829c-d3cd-c3b6-68a570552e84@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 03:56, Tianrui Zhao wrote:
>>
>> In _kvm_check_vmid(), you already have
>>
>> +    if (migrated || (ver != old)) {
>> +        _kvm_update_vpid(vcpu, cpu);
>> +        trace_kvm_vpid_change(vcpu, vcpu->arch.vpid[cpu]);
>> +    }
>>
>> so a vpid will never be recycled if a vCPU migrates from physical CPU 
>> A to B and back to A.
>>
>> So please keep the current VPID in the per-cpu struct vmcs, and you 
>> can just copy it from there in _kvm_check_vmid().
> 
> Thanks,  that is to say we should remove the vpid[NR_CPUS] array and it 
> is enough to use only one vpid variable?

Yes, you need a vpid variable here and one in struct kvm_context.

Paolo

