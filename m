Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D656C33EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCUOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCUOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D241E9FB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679408363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfF4q7w/qUi23bHADegaGOCt7dfjqjwQEqjxl6FkQCg=;
        b=Na8jJwYL7x/NRNPCV23Abs5zET15SxDXo4JGwCl7ce7ZN5XFlRFY/IUyv1W1VWGjjLp5JP
        UjydKbYr2GOwYIS+hgulqssfrKOaR3HyVchtk5DDoPu2dbolu8ANOJSA4VFVSZTZwWf2wI
        xjhw5ZXun1K5/8CqUPUpAaDdVUNkK4s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-vxc3hPAQPoKG6wni0r8v0A-1; Tue, 21 Mar 2023 10:19:21 -0400
X-MC-Unique: vxc3hPAQPoKG6wni0r8v0A-1
Received: by mail-wm1-f70.google.com with SMTP id bi7-20020a05600c3d8700b003edecc610abso3393148wmb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408360;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfF4q7w/qUi23bHADegaGOCt7dfjqjwQEqjxl6FkQCg=;
        b=m8u+YPvfatG/+YMWfb3a2qDDufxtTc1hqlLyIUosr3ZZJZZxnjUUTK13IjLe4IEm0+
         fjGeqEk4Yluq3vuqtjgMDPXccJsnqzMHQ3df+RIDXq6PfSxynOHv0vSXtaDKEI3P+v9O
         BAhzqehWBNcMRofneu8U6RAULZ+uJKMGayMXQDU2E+gd3cSeNk9MA+yvV+jXspyG7ALU
         SOGq8GrWR6x2er7iQa2qwpAGilD4X2AnbNNWpGGL05hGcHBazGRBpa0YBiPDPMkg6Krw
         0mi6t2foMf7bhQa1Jc+9TV3jKmiyQWBOQZ1jWGk38z7+Q4BvtoMXh109Q7GHlWMELIBa
         bqQQ==
X-Gm-Message-State: AO0yUKXlzVdCoaefhXM8lKuIf429RqBKyHmpRMROPHucQdtbfc/k+0Bn
        3ntvX1ux5tHUyoFrPdhExAF0FhszZQIphRCL/W45uxQIN+QR5dq9Trg10ZCxjVr4CbpVvPQqH/q
        ArkNDKyFYVH/HmBP6lvVOU7Up
X-Received: by 2002:adf:ef8c:0:b0:2cf:ef5d:4ee7 with SMTP id d12-20020adfef8c000000b002cfef5d4ee7mr2284164wro.69.1679408360347;
        Tue, 21 Mar 2023 07:19:20 -0700 (PDT)
X-Google-Smtp-Source: AK7set8r+wjArG2eiSUDSwdivLHTtwScJEk6/GrYHLxiYkOPw4OOFqg1RnVEDt4CmfyN70KsX2Jgsg==
X-Received: by 2002:adf:ef8c:0:b0:2cf:ef5d:4ee7 with SMTP id d12-20020adfef8c000000b002cfef5d4ee7mr2284148wro.69.1679408360051;
        Tue, 21 Mar 2023 07:19:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7f00:8245:d031:7f8b:e004? (p200300cbc7057f008245d0317f8be004.dip0.t-ipconnect.de. [2003:cb:c705:7f00:8245:d031:7f8b:e004])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b002c5598c14acsm11597587wri.6.2023.03.21.07.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:19:19 -0700 (PDT)
Message-ID: <6dd844f7-d43b-c744-f295-9f14c68d3928@redhat.com>
Date:   Tue, 21 Mar 2023 15:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230320024739.224850-1-mawupeng1@huawei.com>
 <20230320024739.224850-2-mawupeng1@huawei.com>
 <27b9cb5b-0118-f989-80c2-6a143a4232af@redhat.com>
 <3ef9520c-6713-527a-0214-ac7a8bb2d49c@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3ef9520c-6713-527a-0214-ac7a8bb2d49c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 08:44, mawupeng wrote:
> 
> 
> On 2023/3/20 18:54, David Hildenbrand wrote:
>> On 20.03.23 03:47, Wupeng Ma wrote:
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>>> The return value of mlock is zero. But nothing will be locked since the
>>> len in do_mlock overflows to zero due to the following code in mlock:
>>>
>>>     len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>
>>> The same problem happens in munlock.
>>>
>>> Add new check and return -EINVAL to fix this overflowing scenarios since
>>> they are absolutely wrong.
>>
>> Thinking again, wouldn't we reject mlock(0, ULONG_MAX) now as well?
> 
> mlock will return 0 if len is zero which is the same w/o this patchset.
> Here is the calltrace if len is zero.
> 
> mlock(len == 0)
> 	do_mlock(len == 0)
> 		if (!len)
> 			return 0
>

I was asking about addr=0, len=ULONG_MAX.

IIUC, that used to work but could now fail? I haven't played with it, 
though.

-- 
Thanks,

David / dhildenb

