Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698BE70F0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbjEXI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjEXI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197269E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684916872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCUhbhPUddxH1BlYMFRizRq/b/BxS31k/TQkz/sL1sw=;
        b=PUY/kadhqSawLXIlE6fML+UDtcWA7keEPkJzLfOBRQv0sQPTou8VPJRtLqJlh+eg25RGxT
        CXmy6nwd32A/0/jI1XIKsvg3XOVkvT7sfmtyR5TwPQNEKRgTb2bWPNBcyuKua8a70QG/NS
        y5fHV1owAtvsOqNIpFAkQtLvjMBKMjk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-vGPqXYVnPZKuHRXQsIki-w-1; Wed, 24 May 2023 04:27:50 -0400
X-MC-Unique: vGPqXYVnPZKuHRXQsIki-w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f42b226871so3034775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916869; x=1687508869;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCUhbhPUddxH1BlYMFRizRq/b/BxS31k/TQkz/sL1sw=;
        b=SxHlenJXyWLnezqkv1Ma7X1DU6saIqp0l+sFE0Wq6shXpJgBjiSoPwnYbvMXIXbTmq
         +zMR+jFJ+3dR4Mv2AOKZeRxhdpwe3RnHr0NoZlgJ2BPxBpDQDggUZ+4CSxm9PvDRvJij
         qyui2UEBX9b7P5tPw6+1+Rj1DcHgvnvFyc5FD/WSzJ093pasrI/MMLiYZpvwpbltq+Wp
         uBX0Ffq5WC8pMv8a46f8tLvSEOnTJNlCrD1X5Ka7GwMkIV3lr/1Ex6zC0/E7nk4vsQS9
         2oz7W8kWJ41QqCqpJtiCwxwp/cYXCnWvKkICKjUHCwPD1n4WdfIUd39c2mzC0CPG5/kX
         7Umw==
X-Gm-Message-State: AC+VfDwKH8PKZquXN2VGb0wpt95rlUfmCRbx/4Ysfe5thPd0LU+wLnwy
        no3Z/mDrS3MEHmU0FVCkdjI6oZiu5cLqxoUcwswvPmZWo9xbSSZLELrTj1klShgprRO6XzySREV
        ZCmPjEwsm9BFmDmvyiV01a4YM
X-Received: by 2002:a05:600c:3784:b0:3f6:69f:75e0 with SMTP id o4-20020a05600c378400b003f6069f75e0mr6620909wmr.25.1684916869359;
        Wed, 24 May 2023 01:27:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JFA+fH2aWyXjI6Gs6rgwh5oSGz4/rU3bsQD2lOaBmsNolDtwJUhRU4/5+OKCrVu5XZ/Cddg==
X-Received: by 2002:a05:600c:3784:b0:3f6:69f:75e0 with SMTP id o4-20020a05600c378400b003f6069f75e0mr6620897wmr.25.1684916869005;
        Wed, 24 May 2023 01:27:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003f50876905dsm1544885wme.6.2023.05.24.01.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:27:48 -0700 (PDT)
Message-ID: <fdd99465-c4e3-7294-075f-46a9f1c3e63d@redhat.com>
Date:   Wed, 24 May 2023 10:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 2/5] ksm: count all zero pages placed by KSM
Content-Language: en-US
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn,
        yang.yang29@zte.com.cn
References: <52bfd744-3086-a22a-e2e7-8b64d5fccfcc@redhat.com>
 <20230524075539.20844-1-xu.xin16@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230524075539.20844-1-xu.xin16@zte.com.cn>
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

On 24.05.23 09:55, xu xin wrote:
>>> +extern unsigned long ksm_zero_pages;
>>> +
>>> +static inline void ksm_notify_unmap_zero_page(pte_t pte)
>>> +{
>>> +	if (is_ksm_zero_pte(pte))
>>> +		ksm_zero_pages--;
>>> +}
>>> +
>>>    static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>>>    {
>>>    	int ret;
>>> @@ -103,6 +111,10 @@ static inline void ksm_exit(struct mm_struct *mm)
>>>    
>>>    #define is_ksm_zero_pte(pte)	0
>>>    
>>> +static inline void ksm_notify_unmap_zero_page(pte_t pte)
>>> +{
>>> +}
>>> +
>>
>> Having proposed that name ... I realize that we call this function
>> whenever there might be a zeropage mapped (when we have !page after
>> vm_normal_page()) -- but it could also not be the zeropage.
>>
>> Not really able to come up with a better name :)
>>
>> ksm_notify_maybe_unmap_zero_page ?
>>
>> ksm_maybe_unmap_zero_page ?
>>
> 
> Analogous to the existing name of ksm_might_need_to_copy, so maybe we can use
> 'ksm_might_unmap_zero_page',

Yes, that should work :)

-- 
Thanks,

David / dhildenb

