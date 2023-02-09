Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8490690B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBIN5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBIN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:57:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB095D1D1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675951000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Y1joeNdYJ7b/1/klwyqyf65Bv+i6Ox7LCf5OuDMUyY=;
        b=hgniEHRKk9ES10UPgdcEWoSXsZ9i7DzDc9FIoeWVF55xdjwiSnRU6zktcA7ytC3eo8D8QH
        FYhoeWPiDi/DebTSfmV/J9+5Z/yLI9Ut4pELjL16NBT2y/wSlJLvVwYG8maa49ZS03j1A2
        ldZEle7lBnfaRKtNdnchJVsSj+cQze0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-aVSrhNHpPVqRxs-G3piDRg-1; Thu, 09 Feb 2023 08:56:33 -0500
X-MC-Unique: aVSrhNHpPVqRxs-G3piDRg-1
Received: by mail-ed1-f72.google.com with SMTP id w6-20020aa7d286000000b004aaa832ef36so1503335edq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y1joeNdYJ7b/1/klwyqyf65Bv+i6Ox7LCf5OuDMUyY=;
        b=kF0tHX0yJuHjbICYmYK6WPOBYb6AIWgkLyzuSM7NqJ87FAsL4mD6olsZrQDnJNogMb
         F2MzU/jyIDkzBj4uvGeuRXSTzJ2bl1gkuM9JKvYnOXUUzqe6vNPT4PN+pAAk/ZPAXved
         uVh+NpsEuwc9D1/nWi8oADK9VbFx7kUdkLb2fa9e/FLCvWI7DTTKYSe0T2JZyewI1tqM
         WuESbhLQTEjX8fteOFrcTQz+5410VFxpwE+YG40YUcKh7POPsrdavvA5n2O+tQlFhRYF
         L7R+vRKgUWnwDUQUMeXkmkRPYFF9Rkb00ILj9m+GBMxUGZGW3o6E4MPeXuGFG2KlVtyM
         CsBQ==
X-Gm-Message-State: AO0yUKWr0HARbXmqJBgWDq0GQuvOqrA8d9TNj+2ra2aF6OG2htbASQje
        qNo94xym72yvw9UWL3pf9QwEo7pzrxdeDZEiGltSs27cm9axwGw5YTOZ5sktLDDbmUqzA/Bl2p4
        +dMqdfPtFJU6q3PIH5e0E94Fe
X-Received: by 2002:a05:6402:194d:b0:4ab:1715:2858 with SMTP id f13-20020a056402194d00b004ab17152858mr4109690edz.11.1675950991946;
        Thu, 09 Feb 2023 05:56:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/rRi6gsWVma21TmnsOmaUPrCABx15ptYtiwRoMF39J6s62FtDltEJsH0rjNZMggaFe7tZSYA==
X-Received: by 2002:a05:6402:194d:b0:4ab:1715:2858 with SMTP id f13-20020a056402194d00b004ab17152858mr4109677edz.11.1675950991787;
        Thu, 09 Feb 2023 05:56:31 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id k8-20020aa7c388000000b004a2067d6ba4sm786081edq.52.2023.02.09.05.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 05:56:31 -0800 (PST)
Message-ID: <1433ea0c-5072-b9d9-a533-401bb58f9a80@redhat.com>
Date:   Thu, 9 Feb 2023 14:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] KVM: VMX: Stub out enable_evmcs static key for
 CONFIG_HYPERV=n
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230208205430.1424667-1-seanjc@google.com>
 <20230208205430.1424667-3-seanjc@google.com> <87mt5n6kx6.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87mt5n6kx6.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 14:13, Vitaly Kuznetsov wrote:
>> +static __always_inline bool is_evmcs_enabled(void)
>> +{
>> +	return static_branch_unlikely(&enable_evmcs);
>> +}
> I have a suggestion. While 'is_evmcs_enabled' name is certainly not
> worse than 'enable_evmcs', it may still be confusing as it's not clear
> which eVMCS is meant: are we running a guest using eVMCS or using eVMCS
> ourselves? So what if we rename this to a very explicit 'is_kvm_on_hyperv()'
> and hide the implementation details (i.e. 'evmcs') inside?

I prefer keeping eVMCS in the name, but I agree a better name could be 
something like kvm_uses_evmcs()?

Paolo

