Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF606CCB75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC1UY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjC1UYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:24:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269410E9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:24:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o12so5911289iow.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680035091; x=1682627091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pa11kLX/XMUG8mACrXjghwtc0ZRwtUKbWbbdL1CJg/Y=;
        b=Uzt6tHKrfSWNGVTcUUQ7Uo6DC/6tFkO4JZUPezHEMFJEuZPgy7pL2MWkrd2IDk4kfz
         bxIuYK5QhLQ1Ev1cczdWKeCNGUN/vC1WrCLoQqPKCqbkhh/94g4QjNkos4gK69I30xiv
         /2XIuSGs1bGFK8v70IPcnNZGZr3S+cBqSHBVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680035091; x=1682627091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pa11kLX/XMUG8mACrXjghwtc0ZRwtUKbWbbdL1CJg/Y=;
        b=wfFg9Za8GhHZ/Krf1h9mEBOJABw/wG9oKG23FwkluunjOvwIro1g5p8G0Vxrcdq290
         gLN22R98tBcbaUx0kCnPmy1nNm+4AI5VGY6N6CBLJlG9Ww8ELdx7MEUfqmwGKm+tUgdx
         SW5rCzp0fIR/MCoucWnBXkOLE/TcrG+iagY2xAxwyRabjWgTBYExkiuWioi1R8tWUT+y
         llgdnSuW7Odan+ihNRUWA/rxi5SU1b3z3sTUnogrGChF+Q6hJWk4o+kO3TA4az5l/crK
         wMdbXoOJVpYrhjZz8kmowhY4wchHRInt/WVpGi62WiOUrKcWa7qG5uAl/EnXcJr+TeIA
         ciIA==
X-Gm-Message-State: AO0yUKVuCXWwNa/QnnfDoryNSZCm2Wnm4fTToilwCG6cM+WWG9oiImOq
        JX/dpKDoasIWRERnk3OU1rPHLg==
X-Google-Smtp-Source: AK7set/gWITrUODmm6VsfVSCOafAKEc2tu/fUrfTV4GFzBukMNx3P2Ke8w8dYiZW6umPfwO9+CV9iQ==
X-Received: by 2002:a05:6602:2f04:b0:758:9dcb:5d1a with SMTP id q4-20020a0566022f0400b007589dcb5d1amr12096430iow.2.1680035091396;
        Tue, 28 Mar 2023 13:24:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 71-20020a020a4a000000b004040f9898ebsm10241449jaw.148.2023.03.28.13.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 13:24:51 -0700 (PDT)
Message-ID: <03922180-a9af-7411-9a41-48163860cc46@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 14:24:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230326062039.341479-4-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230326062039.341479-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 00:20, Kuppuswamy Sathyanarayanan wrote:
> In TDX guest, the second stage of the attestation process is Quote
> generation. This process is required to convert the locally generated
> TDREPORT into a remotely verifiable Quote. It involves sending the
> TDREPORT data to a Quoting Enclave (QE) which will verify the
> integerity of the TDREPORT and sign it with an attestation key.
> 
> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> allow user agent get the TD Quote.
> 
> Add a kernel selftest module to verify the Quote generation feature.
> 
> TD Quote generation involves following steps:
> 
> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> * Embed the TDREPORT data in quote buffer and request for quote
>    generation via TDX_CMD_GET_QUOTE IOCTL request.
> * Upon completion of the GetQuote request, check for non zero value
>    in the status field of Quote header to make sure the generated
>    quote is valid.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   tools/testing/selftests/tdx/tdx_guest_test.c | 68 ++++++++++++++++++--
>   1 file changed, 62 insertions(+), 6 deletions(-)
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah




