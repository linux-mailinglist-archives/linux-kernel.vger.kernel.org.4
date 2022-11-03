Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6589617E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiKCNkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiKCNk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ECBE57
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667482766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7Jfz/F/6Y5sBizojKqCLhfDWCKyK0PcIAb1Yu8ed1g=;
        b=AtdEbDZKpHAGdv0mEjNp43gscxZzXowjlMbAy3frtAFF5oxry9GIEW+XCJ+0IuBKuaC4J/
        NxlBiwr0vZz4dwYUR9Ot5QqBMDOH8bt4DWMOCv/VLmif2lThvncOtOFEPZCDneVJuglm+/
        E34F3nDMCzrpbxGH3ZWy3J3z4oKtWZ0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-gxHclcNsPFCQdRneplwN8A-1; Thu, 03 Nov 2022 09:39:25 -0400
X-MC-Unique: gxHclcNsPFCQdRneplwN8A-1
Received: by mail-ej1-f72.google.com with SMTP id qf25-20020a1709077f1900b0078c02a23da3so1295712ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7Jfz/F/6Y5sBizojKqCLhfDWCKyK0PcIAb1Yu8ed1g=;
        b=CTaA/ta0nUz4n3CYtn7P1FKSz47DFQaQKCNQgcYEpYkOfwfnRhvASc4vNu+X8waxxt
         QCGPtUZQ6RUihrRkVeH3EejjmcfmejZ0IuuHT4HC10WjS3Lgu65jm3zUhHkukg1WPEZz
         Y+DgfUbpO7xnN08dUkFejmlZi/Ud92RZURdAj5sRVye+1GzW3W8pgTZcZLt3yzwrpbsg
         KCLBbYL0n80cbB1B9XKDAFiDCALTFixVq1/h1J9uz8kz/nIHkh8ih4CNfDOotmR55IbQ
         k/N5tUNcgIirZQ1TLhstev38JnS5jGRLr1Ik/nbvvHzmlw3yes2jsWuip5Nddp1iy7D0
         IjCQ==
X-Gm-Message-State: ACrzQf0+LfjDkxxbdCW9y+w6WMwOLD4G7s5uCiZouYalz986Ne1/DTwZ
        Om1BoF6Nc+pwIvipeUa2ekRhVJ+5ghIHY36k5QGa+CQcOjX0sqMTEZ9asgRKY4PrS7pmDJPXZHu
        dTBtjbDeBJP3PmcURAVKT34DJ
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e1 with SMTP id xc10-20020a170907074a00b0077e9455b4e1mr28955296ejb.462.1667482763222;
        Thu, 03 Nov 2022 06:39:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42qH/DeqlviMC5JnBlEig6wTRXuvyniHiTtzvoXqf66RRHr9aDzIoWq9jMNl4pZiDlE3EnhQ==
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e1 with SMTP id xc10-20020a170907074a00b0077e9455b4e1mr28955268ejb.462.1667482762994;
        Thu, 03 Nov 2022 06:39:22 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id 1-20020a170906210100b007317f017e64sm499755ejt.134.2022.11.03.06.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 06:39:22 -0700 (PDT)
Message-ID: <5374345c-7973-6a3c-d559-73bf4ac15079@redhat.com>
Date:   Thu, 3 Nov 2022 14:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] KVM: x86: Fix a typo about the usage of kvcalloc()
Content-Language: en-US
To:     Liao Chang <liaochang1@huawei.com>, seanjc@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <20221103011749.139262-1-liaochang1@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221103011749.139262-1-liaochang1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 02:17, Liao Chang wrote:
> Swap the 1st and 2nd arguments to be consistent with the usage of
> kvcalloc().
> 
> Fixes: c9b8fecddb5b ("KVM: use kvcalloc for array allocations")
> Signed-off-by: Liao Chang<liaochang1@huawei.com>
> ---
>   arch/x86/kvm/cpuid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7065462378e2..b33c18b142c2 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1331,7 +1331,7 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>   	if (sanity_check_entries(entries, cpuid->nent, type))
>   		return -EINVAL;
>   
> -	array.entries = kvcalloc(sizeof(struct kvm_cpuid_entry2), cpuid->nent, GFP_KERNEL);
> +	array.entries = kvcalloc(cpuid->nent, sizeof(struct kvm_cpuid_entry2), GFP_KERNEL);
>   	if (!array.entries)
>   		return -ENOMEM;
>   

It doesn't make any difference, but scripts/checkpatch.pl checks it so
let's fix the sole occurrence in KVM.

However, please send a patch to scripts/checkpatch.pl to include calloc(),
kvmalloc_array and kvcalloc() in the matched functions:

# check for alloc argument mismatch
                 if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
                         WARN("ALLOC_ARRAY_ARGS",
                              "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
                 }


Paolo

