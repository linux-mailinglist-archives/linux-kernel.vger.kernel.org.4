Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2893A73BB19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjFWPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjFWPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B951AC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687532861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PIj9TpY/vUG69vHRfBGHuyDPvaqSQMBDxHTno+lgUQ=;
        b=TZ6qciNJzo51CQ71TakoJWVpb3GnBGfDRxnqzXr+WvHicS4JllsOl+LY4EKSnhkSZwyoax
        8q3CFAhaddxD6wx+Yh8Aq4ukQpcrQ4aAC30Vbq0Tkaw0d8GDxwB6N9xA/4VQY/WgtGFu5O
        ZLt5ugjSuLabzsDGhqe9f2fQ92elvsI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-V4diGRfDNxuwOgiBhYIBMQ-1; Fri, 23 Jun 2023 11:07:40 -0400
X-MC-Unique: V4diGRfDNxuwOgiBhYIBMQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa7b245a75so4292765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532859; x=1690124859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PIj9TpY/vUG69vHRfBGHuyDPvaqSQMBDxHTno+lgUQ=;
        b=NLUdKC1Puc/0A4zWWwaYduRquACXKsziN/YowHuaxBMYf01cvHZ7ASK0Wm6XPhkdK6
         VugHH1kYSVQkhQXhqeTvSFF7j5uuKuSYbxIEy6owlD3BVRpUngT1dgumogg+wCWw0PFw
         XQSMZ+45c4hyx6A7MYpYf6GklT5/0oYMiQzfd4jJVp0809lNlcLuRZic0Rc/y6qqajNY
         aqOzs67p8F5s3ypModJldFcWgczeuIkXnFYx7iG/ZbF2HNfeSvj48vciFsLZ0LxvIayD
         TRKMjYLXhjwMO/Xh80oKKQFC7o+r7v9A06/uweiTPjaVKKa0fg9E+Ph+UmqGOHMrNcQ2
         25Hg==
X-Gm-Message-State: AC+VfDyyNdJa0Jc7gjFeDUlp1fh71zcBZAV9XRbJSvl3NVyx7Oor1QeH
        twsaZLpowX5v5A7/Noq7LJa5baoNT+gGJYIY77HkFOTfWO0V2iV9qpWn5ANVd5moOnFJksqwEWg
        VptrU+hXQquCH00ktkY/siz9L
X-Received: by 2002:a05:600c:d8:b0:3f9:c9f4:acf1 with SMTP id u24-20020a05600c00d800b003f9c9f4acf1mr6588436wmm.7.1687532859076;
        Fri, 23 Jun 2023 08:07:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6WXIbrUL9JSjkw/UFxJT6YFthXdXUKVwIUcrfrH+yxajncKJhmhAgmQRL80+Hfyqowot7zFQ==
X-Received: by 2002:a05:600c:d8:b0:3f9:c9f4:acf1 with SMTP id u24-20020a05600c00d800b003f9c9f4acf1mr6588413wmm.7.1687532858781;
        Fri, 23 Jun 2023 08:07:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id l19-20020a1c7913000000b003f8d0308616sm2570438wme.32.2023.06.23.08.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 08:07:38 -0700 (PDT)
Message-ID: <4b0f4def-e2bd-b7b2-7c70-1df741780e1c@redhat.com>
Date:   Fri, 23 Jun 2023 17:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] vfio/nvgpu: Add vfio pci variant module for grace
 hopper
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, alex.williamson@redhat.com, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622030720.19652-1-ankita@nvidia.com>
 <46a79333-12f6-229f-86f9-1e79bdba7d11@redhat.com>
 <ZJWGbsaMzHvqqewi@nvidia.com>
 <62dcff6b-852d-4a85-dfd4-0ce1f324602e@redhat.com>
 <ZJWZA8ogUlGegx2C@nvidia.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <ZJWZA8ogUlGegx2C@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 15:07, Jason Gunthorpe wrote:
> On Fri, Jun 23, 2023 at 03:04:17PM +0200, Cédric Le Goater wrote:
>> On 6/23/23 13:47, Jason Gunthorpe wrote:
>>> On Fri, Jun 23, 2023 at 08:27:17AM +0200, Cédric Le Goater wrote:
>>>>> +	req_len = vma->vm_end - vma->vm_start;
>>>>> +	pgoff = vma->vm_pgoff &
>>>>> +		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
>>>>> +	if (pgoff >= (nvdev->mem_prop.mem_length >> PAGE_SHIFT))
>>>>> +		return -EINVAL;
>>>>
>>>> you cound introduce accessor macros for nvdev->mem_prop.mem_length and
>>>> nvdev->mem_prop.hpa
>>>
>>> Accessors are not the usual style..
>>
>> I meant something like
>>
>>    #define nvgpu_mem_size(nvdev) (nvdev)->mem_prop.mem_length
>>    #define nvgpu_mem_pa_base(nvdev) (nvdev)->mem_prop.hpa
>>
>> This is minor.
> 
> Yeah, this is what I thought you ment, I'm against this kind of
> obfuscation in the kernel without a very strong purpose, and if you do
> something like this it should be a static inline function.

OK. We could drop the intermediate struct attribute instead then.

Thanks,

C.

