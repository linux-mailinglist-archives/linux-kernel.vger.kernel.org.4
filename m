Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D299643FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiLFJTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiLFJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:17:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8323220F6F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670318172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMRy72lNTyTvf37gL8dnH7NCNPDUhgTIYeO671gopCE=;
        b=g2bX5Z86Q2StLxCSZegcanoooaT5KLQPTn5r/MGzwtL1QB9KZZFc8E1kidl5a15tDEPNY2
        JBmsdVZaImwppiT8ERvhuP4nAZlbCvum3rgBfuUCva6jpWo64YnUsANhdj9/2dnBTchU+X
        9ISU5S7vOuziqs54vrtDRIR5gXAwk4c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-212-lBZWevLxMjKM7BNqBol_QA-1; Tue, 06 Dec 2022 04:16:11 -0500
X-MC-Unique: lBZWevLxMjKM7BNqBol_QA-1
Received: by mail-wr1-f69.google.com with SMTP id h15-20020adfa4cf000000b0024276cca31cso272781wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMRy72lNTyTvf37gL8dnH7NCNPDUhgTIYeO671gopCE=;
        b=aT2Eo7ZSbdht/AjrdWylZ18xP9lKAIENKcIrpQinS+axH1ulXUxdeHLW5zOKRmF2/t
         7rM5Mj4ijZN9Y5yECJl7JlPhar/Jf5l9YggLa3KyJN2igg2RTp1JO3Mjon+pLC+dUzPd
         S3YcR0BBlrghoyFU6PPZdeGWx7Zmhgn+412V+KqW22xFDmkPzqEswuiPqGnsQy0r+wq4
         HjpiMOlKWPb5innq4LDlRr/ZB9I25RpGeY5AI0V9eMtzG07otpxIUzhcj2mILkgyu3wP
         aCq9cQI8leWbXgPgUwB7Su5RCaQH4t2c6PvCKuPlQ27wmB1MTKvcykInbVgzX475Pe/3
         HZuQ==
X-Gm-Message-State: ANoB5pnhK2uCZ9dehWUjfMl2fOj3bko65slZYGwSAs7SFvVB+s28IBGc
        SR9gDYYiYwz4Pv1ctz95YXe6bF/HXTi1qO5AkNvx1Zlxfgr/TKNGLAVBZS05PSIccWLsdtPtEhq
        Hcgc82QsNax4kEfRc6HYhzraf
X-Received: by 2002:a05:6000:192:b0:242:4d66:d10 with SMTP id p18-20020a056000019200b002424d660d10mr7898447wrx.504.1670318170283;
        Tue, 06 Dec 2022 01:16:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6lMBFp4LDO+TjiQzgMfKj1b8zuPe3WXQz7UTJO1PSntr02Vc7xM+ehsJ+ySDXUAffMfkhIbw==
X-Received: by 2002:a05:6000:192:b0:242:4d66:d10 with SMTP id p18-20020a056000019200b002424d660d10mr7898430wrx.504.1670318169962;
        Tue, 06 Dec 2022 01:16:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4f00:41f1:185d:4f9f:d1c2? (p200300cbc7054f0041f1185d4f9fd1c2.dip0.t-ipconnect.de. [2003:cb:c705:4f00:41f1:185d:4f9f:d1c2])
        by smtp.gmail.com with ESMTPSA id i12-20020adffc0c000000b00241d21d4652sm16031066wrr.21.2022.12.06.01.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 01:16:09 -0800 (PST)
Message-ID: <0b122e73-22c3-e3a3-3aaf-d2b8361c196d@redhat.com>
Date:   Tue, 6 Dec 2022 10:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221205150857.167583-1-david@redhat.com> <Y45u+0c4Hu2snEO2@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/swap: fix SWP_PFN_BITS with
 CONFIG_PHYS_ADDR_T_64BIT on 32bit
In-Reply-To: <Y45u+0c4Hu2snEO2@x1n>
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

> 
> Thanks for debugging this one.

Sure!

> 
>> ---
>>
>> This makes my x86 PAE case work as expected again. Only cross compiled
>> on other architectures.
> 
> IIUC it's not about PAE but !SPARSEMEM, as PAE actually has it defined when
> with sparsemem:
> 
> #ifdef CONFIG_X86_32
> # ifdef CONFIG_X86_PAE
> #  define SECTION_SIZE_BITS	29
> #  define MAX_PHYSMEM_BITS	36
> # else
> #  define SECTION_SIZE_BITS	26
> #  define MAX_PHYSMEM_BITS	32
> # endif
> #else /* CONFIG_X86_32 */
> # define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
> # define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
> #endif

Indeed, I'll extend the description accordingly.

> 
> One trivial comment below.
> 
>>
>> ---
>>   include/linux/swapops.h | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>> index 86b95ccb81bb..4bb7a20f3fa5 100644
>> --- a/include/linux/swapops.h
>> +++ b/include/linux/swapops.h
>> @@ -32,11 +32,13 @@
>>    * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
>>    * can use the extra bits to store other information besides PFN.
>>    */
>> -#ifdef MAX_PHYSMEM_BITS
>> +#if defined(MAX_PHYSMEM_BITS)
>>   #define SWP_PFN_BITS			(MAX_PHYSMEM_BITS - PAGE_SHIFT)
>> -#else  /* MAX_PHYSMEM_BITS */
>> +#elif !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
>> +#define SWP_PFN_BITS			SWP_TYPE_SHIFT
> 
> Can we add a comment showing where SWP_TYPE_SHIFT comes from?  It should be
> a min value comes from either the limitation of phys address width, or from
> definition of swp_entry_t (which is unsigned long).
> 
> Or I'd rather make this then the code explains better on itself, and the
> change should be smaller too:
> 
>   #ifdef MAX_PHYSMEM_BITS
>   #define SWP_PFN_BITS                   (MAX_PHYSMEM_BITS - PAGE_SHIFT)
>   #else  /* MAX_PHYSMEM_BITS */
> -#define SWP_PFN_BITS                   (BITS_PER_LONG - PAGE_SHIFT)
> +#define SWP_PFN_BITS                   MIN((sizeof(phys_addr_t) * 8) - \
> +                                           PAGE_SHIFT, SWP_TYPE_SHIFT)
>   #endif /* MAX_PHYSMEM_BITS */
>   #define SWP_PFN_MASK                   (BIT(SWP_PFN_BITS) - 1)
>                                   
> What do you think?

Sure, if we can make the compiler happy:

./include/linux/swapops.h: In function 'swp_offset_pfn':
./include/linux/swapops.h:38:41: error: implicit declaration of function 
'MIN' [-Werror=implicit-function-declaration]
    38 | #define SWP_PFN_BITS 
MIN((sizeof(phys_addr_t) * 8) - \
       |                                         ^~~
./include/vdso/bits.h:7:44: note: in definition of macro 'BIT'
     7 | #define BIT(nr)                 (UL(1) << (nr))
       |                                            ^~
./include/linux/swapops.h:41:46: note: in expansion of macro 'SWP_PFN_BITS'
    41 | #define SWP_PFN_MASK                    (BIT(SWP_PFN_BITS) - 1)
       |                                              ^~~~~~~~~~~~
./include/linux/swapops.h:119:36: note: in expansion of macro 'SWP_PFN_MASK'
   119 |         return swp_offset(entry) & SWP_PFN_MASK;
       |                                    ^~~~~~~~~~~~


using "min" instead gives plenty of warnings. min_t() seems to work:

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 27ade4f22abb..088f25aa0e98 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -34,8 +34,10 @@
   */
  #ifdef MAX_PHYSMEM_BITS
  #define SWP_PFN_BITS                   (MAX_PHYSMEM_BITS - PAGE_SHIFT)
-#else  /* MAX_PHYSMEM_BITS */
-#define SWP_PFN_BITS                   (BITS_PER_LONG - PAGE_SHIFT)
+#else /* MAX_PHYSMEM_BITS */
+#define SWP_PFN_BITS                   min_t(phys_addr_t, \
+                                             (sizeof(phys_addr_t) * 8) - \
+                                             PAGE_SHIFT, SWP_TYPE_SHIFT)
  #endif /* MAX_PHYSMEM_BITS */
  #define SWP_PFN_MASK                   (BIT(SWP_PFN_BITS) - 1)



I'm currently cross-compiling that and will give it a churn.

Thanks!

-- 
Thanks,

David / dhildenb

