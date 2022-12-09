Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74CE647EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLIH7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiLIH7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:59:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1654773
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 23:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670572720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZ8hUe+wDVfcXZFasPofq++d5JzIKUkQA0LPKASkWts=;
        b=UD4mCOnYTsuIbWY0Sx/u0pBlvmoU0XerfU56k2xyNZz8fms1HkgyQ8PrRSr7r3axVRzIyP
        tHiGDqE75Qhfl2FABg8xAW8SP1zOLtSnDtfK5Qy09Vq0lHqw1fQOcld1EpmAU2Y54GECus
        02HG8iJGOyLajUYmn6iXpA13lUSqiKw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-4xw6paxzMZ-r-gFOxKDfEA-1; Fri, 09 Dec 2022 02:58:38 -0500
X-MC-Unique: 4xw6paxzMZ-r-gFOxKDfEA-1
Received: by mail-ej1-f70.google.com with SMTP id gn36-20020a1709070d2400b007ba3374574dso2598317ejc.23
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 23:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ8hUe+wDVfcXZFasPofq++d5JzIKUkQA0LPKASkWts=;
        b=dG/4CS6raxzlWNQEzVzmHrF5iy0Mg1m7KqblDqvCiQ9K9Zs1zvPF5oIzWcqldsf32/
         sISABKGXL6bcK3i2h26X6e63lnbgimtNBauC5VZABCeIPtKfOcoVcKo7C32SB+htQ8hO
         bRrobN+urcynZAujhjuY0s8T+IP/JJ+d3ozaW+ASmFdoMoAL7QPMxFvYPqbGf5xAG/hO
         lDFMIU7NnZ9hBgt/802R/kxjbHwI50cNFJ4D8SqsqBv2C+XZLoF+AqMVD75HMgRSg8SR
         mfCaD5Z9ve3eoN9C4mWvhzV8CnM0kHdSMxQ1NrX+pTWjhWmHXWj7v3Xyzh6JnLh1uhrt
         wG+Q==
X-Gm-Message-State: ANoB5pmsprP7Vya2nSl2go0JFU/gTP5VCY11osRHS/NTym6o5A/3bF25
        wQ0nvDjw9dgseHWE+rSNvXJlhYJfq4QZPvYd1X2+dxxm20ACpTo7CITAKUGM290PJ/qY/bVyfZp
        Unebq+3wletVBy23FdBp0QvYn
X-Received: by 2002:a17:907:9a09:b0:78d:f456:1eb4 with SMTP id kr9-20020a1709079a0900b0078df4561eb4mr4267461ejc.5.1670572717484;
        Thu, 08 Dec 2022 23:58:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6/SRWES9HuWyfYLXZID4ApanvhIB5IAoRnfjhiVRc++E65v/jXuw62NmM58N6WgfuxktObYA==
X-Received: by 2002:a17:907:9a09:b0:78d:f456:1eb4 with SMTP id kr9-20020a1709079a0900b0078df4561eb4mr4267448ejc.5.1670572717233;
        Thu, 08 Dec 2022 23:58:37 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:e3ec:5559:7c5c:1928? ([2001:b07:6468:f312:e3ec:5559:7c5c:1928])
        by smtp.googlemail.com with ESMTPSA id sg43-20020a170907a42b00b007be3aa82543sm270823ejc.35.2022.12.08.23.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 23:58:36 -0800 (PST)
Message-ID: <372a8ea3-6a87-5eb4-0712-ce48e85ba58e@redhat.com>
Date:   Fri, 9 Dec 2022 08:58:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] kvm: x86/mmu: Remove duplicated "be split" in spte.h
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
References: <20221207120505.9175-1-jiangshanlai@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221207120505.9175-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 13:05, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> "be split be split" -> "be split"
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>   arch/x86/kvm/mmu/spte.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 1f03701b943a..6f54dc9409c9 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -363,7 +363,7 @@ static __always_inline bool is_rsvd_spte(struct rsvd_bits_validate *rsvd_check,
>    * A shadow-present leaf SPTE may be non-writable for 4 possible reasons:
>    *
>    *  1. To intercept writes for dirty logging. KVM write-protects huge pages
> - *     so that they can be split be split down into the dirty logging
> + *     so that they can be split down into the dirty logging
>    *     granularity (4KiB) whenever the guest writes to them. KVM also
>    *     write-protects 4KiB pages so that writes can be recorded in the dirty log
>    *     (e.g. if not using PML). SPTEs are write-protected for dirty logging

Queued, thanks.

Paolo

