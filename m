Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64462616B73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKBSEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKBSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE492EF40
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667412172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZLin+6zqvHrZ8CgUW/yAEyIB1rKlX4aLd8xn0BEv8I=;
        b=X0hIgcY5RqWjrj0JRxnpwQP/5qpG7x7ZxjnpchbNYSvqnccO2zi9IJbSvDroJgTznESFc/
        r+nYUB8bCdt3A/ZKf0l40x66A3bQVDDim5GRYJVwpaLUB8shA/7ZcELeXrif0PGX21BgHI
        VoMgUD+TWWCClF6/Dbb0UcOs/f7OClg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-BF5FEs1WOfW0Y5hOs_gr2A-1; Wed, 02 Nov 2022 14:02:50 -0400
X-MC-Unique: BF5FEs1WOfW0Y5hOs_gr2A-1
Received: by mail-ej1-f69.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso10294158ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZLin+6zqvHrZ8CgUW/yAEyIB1rKlX4aLd8xn0BEv8I=;
        b=guIiPK68+ZwwZfE5P1ub2QdX9cNV8uyNFlyCPGG+TpEX+5yOwSyYuNJH8ViyNwnV8Y
         UaT7NuwMNWssJ9nn8l3Dnd7TSfibOvrYW9jCbwhftQE5Ulican/cGEUUMFdZyckFw9xQ
         0+Myuq2fM5++gYSvlh0Th5EVzsssIqiLkZgALvEfdOKIlv/Dvc5ixcZ3aGWzAZ1Vb25m
         +4jv+R5pbz5HopZFEtL7zuNnStKZIgG0If6OBKrrlxaU/53x9FCdbe4JYGsInCcGHO0D
         SDpez5eWRjfRCnnhXgxDr9+LwHA0m+HIFWlX2TiOpqxTAoVboHWw1iPMTwzlNY6c8Vlo
         6bTA==
X-Gm-Message-State: ACrzQf36WvlG9N6SHuAE5sqlS6K9A6iKgkGaJXuR9gazbn5kxAhOJq4j
        pWMZmsbFODbIesu4yZBWnIVh9pq+EQ7thvbkZE/7+zqt1vngTZb5liR5bRayfXA/zlq0/x/+f62
        ZUK98wBluVibJ8YNcAsCcy+hk
X-Received: by 2002:aa7:ce16:0:b0:461:865a:ae44 with SMTP id d22-20020aa7ce16000000b00461865aae44mr25199884edv.280.1667412169506;
        Wed, 02 Nov 2022 11:02:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6+SJ0UecwX1iXUNicuo/mSZfpxvh7ZRMd8iK2S+u8qcHUUNE8onOdOMEtThQSHuuW4HbnGLQ==
X-Received: by 2002:aa7:ce16:0:b0:461:865a:ae44 with SMTP id d22-20020aa7ce16000000b00461865aae44mr25199833edv.280.1667412169305;
        Wed, 02 Nov 2022 11:02:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id m23-20020a170906849700b0079e11b8e891sm5592338ejx.125.2022.11.02.11.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:02:48 -0700 (PDT)
Message-ID: <38d7f8af-3cf0-0d5b-3fda-a2a3326f7b28@redhat.com>
Date:   Wed, 2 Nov 2022 19:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 00/30] KVM: hardware enable/disable reorganize
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>, isaku.yamahata@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        isaku.yamahata@gmail.com, Kai Huang <kai.huang@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Huang Ying <ying.huang@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <cover.1663869838.git.isaku.yamahata@intel.com>
 <Y0da+Sj3BjYnMoh3@google.com> <Y0jfwi5yo0oMQ5lv@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y0jfwi5yo0oMQ5lv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 06:04, Sean Christopherson wrote:
> Good news (from a certain point of view):
> The reason that the "generic h/w enabling" doesn't help much is because after sorting
> out the myriad issues in KVM initialization, which is even more of a bug-ridden mess
> than I initially thought, kvm_init() no longer has_any_  arch hooks.  All the compat
> checks and whatnot are handled in x86, so tweaking those for TDX should be easier,
> or at the very least, we should have more options.
> 
> Sorting everything out is proving to be a nightmare, but I think I have the initial
> coding done.  Testing will be fun.  It'll likely be next week before I can post
> anything.

Hi Sean,

is this the same series that you mentioned a couple hours ago in reply 
to Isaku?

Thanks,

Paolo

