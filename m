Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0870DE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjEWOBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEWOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5AF198
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684850444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/Nf0TavLbEChUWmWGM/CuAX+Plidrx/xwsde+Gi6m0=;
        b=RozitKxoqbgSsHlFmGve1t9uoorYVFEtuSu/t2WahQEUofDYu1ped3sw6g3iK5USWA+bNu
        MPEeCLS/zEEyi9hQVnzIa0gjhrQaHQ1I+pNTMQV9DAvjThkzPc7taTYx0p6VFfSCeqahT/
        Xn+rBMDxVLtMn+1yqymvY8fBtT92O0I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-DXwhFf2uNqadwI33wfjivA-1; Tue, 23 May 2023 10:00:42 -0400
X-MC-Unique: DXwhFf2uNqadwI33wfjivA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f604687a23so10047625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850441; x=1687442441;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/Nf0TavLbEChUWmWGM/CuAX+Plidrx/xwsde+Gi6m0=;
        b=CbAgskN6BfNU6mc3zIxeh/V3HRZlqY1NvKUCMzpVtjo9pwi9tGm6fi1Y7fBfmm4nqm
         /dEbGf3n4hrDOaVvBHNOWa9N54SPNrwPlu9DxO6DlH+yEXS3klSZEag23/3tHbIgxpIX
         cFaV9IQCVvbD/1PseX1E3e8THmP+WW/86XJnCsDHf/DusSCgEM14XhKgyVFP6KWdPOGi
         460tNONrifi32Qqx1l05C3v28y1xhdo75oi7JMPmxfNRCuvPaQOVDsMjpvwshgcRUlO4
         N36M3V7Ar7bWOAYYXVVLpHL+tyr3eMPl7in45YkLQsYbZAYlT9FkwK5OwM6aehdk5jMG
         f9kg==
X-Gm-Message-State: AC+VfDy4ATsFuOennMS0tqK+DnekO+RwoARcrSdj/ThiusxIf/4tRXYn
        zMHkDrk/DH//FaHhAi3aILAkTRxAaFVzFTDYkd45OJZpiBq2ElwemfjexHoT98bdTVV3ckPLYaX
        uRvy9Y9SZnNzHrzgX+k9+gfCx
X-Received: by 2002:a5d:4d4b:0:b0:309:4289:91c9 with SMTP id a11-20020a5d4d4b000000b00309428991c9mr11771030wru.17.1684850441406;
        Tue, 23 May 2023 07:00:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5tAvOtRXffvj1RZ0LbID8208d/vIh6WNXAn638Wa4VSjKA9mSnvfnq5oThGvWGfLVVCZMYhQ==
X-Received: by 2002:a5d:4d4b:0:b0:309:4289:91c9 with SMTP id a11-20020a5d4d4b000000b00309428991c9mr11770997wru.17.1684850441041;
        Tue, 23 May 2023 07:00:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id z4-20020a056000110400b00307972e46fasm8983024wrw.107.2023.05.23.07.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:00:40 -0700 (PDT)
Message-ID: <4b7e4d48-f0f9-c0b0-e8e1-2678d0306252@redhat.com>
Date:   Tue, 23 May 2023 16:00:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 1/6] ksm: support unsharing KSM-placed zero pages
Content-Language: en-US
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn,
        yang.yang29@zte.com.cn
References: <1925d301-462d-6b33-8867-4e1646b2dbd6@redhat.com>
 <20230523135709.6902-1-xu.xin16@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230523135709.6902-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.23 15:57, xu xin wrote:
>>> ---
>>>    include/linux/ksm.h | 6 ++++++
>>>    mm/ksm.c            | 5 +++--
>>>    2 files changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>>> index 899a314bc487..7989200cdbb7 100644
>>> --- a/include/linux/ksm.h
>>> +++ b/include/linux/ksm.h
>>> @@ -26,6 +26,9 @@ int ksm_disable(struct mm_struct *mm);
>>>    
>>>    int __ksm_enter(struct mm_struct *mm);
>>>    void __ksm_exit(struct mm_struct *mm);
>>> +/* use pte_mkdirty to track a KSM-placed zero page */
>>> +#define set_pte_ksm_zero(pte)	pte_mkdirty(pte_mkspecial(pte))
>>
>> If there is only a single user (which I assume), please inline it instead.
> 
> Excuse me, I'm wondering why using inline here instead of macro is better.
> Thanks! :)

Just to clarify: not an inline function but removing the macro 
completely and just place that code directly into the single caller.

Single user, no need to put that into ksm.h -- and I'm not super happy 
about the set_pte_ksm_zero() name ;) because we get the zero-pte already 
passed in from the caller ...

-- 
Thanks,

David / dhildenb

