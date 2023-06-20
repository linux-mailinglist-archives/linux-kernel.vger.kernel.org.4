Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB5736E26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjFTN76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjFTN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055D1B0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687269548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTLnyrCbOY1xAfP5SqHK9oZhSTIFzQoN+FT5nbHO/xo=;
        b=Po6iXdT5DTxUsegb02fk1lJpyzT1Th8RVgzw/+ozWbpkpa8/EeGXPot8x1Hvi7hgKMzAzI
        Izmp0fZklzU2tho1fJoVUHP3fxmV11Xb6vPxqbBBUWT2ZxebNUgIBlN5+XIAvgATRuDQeL
        haYcD+WoFpNVVqpWrc/hF54MrpcHQNw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-NncwLYzgNjibUpxFWFIyQw-1; Tue, 20 Jun 2023 09:59:05 -0400
X-MC-Unique: NncwLYzgNjibUpxFWFIyQw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51a1f0f93e2so3112103a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687269544; x=1689861544;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTLnyrCbOY1xAfP5SqHK9oZhSTIFzQoN+FT5nbHO/xo=;
        b=COCufIisg9YCMDH+9lE/LHX4Lw/K5S62C7aKFN5LF3yq3URCP2vh5zw8Sz/WozYHk5
         V9N5vkgsOjvysvj0CXfnNxaIbaSmyS1tFuXLFDW7oIR4yhX4Ge8UFHUG/IB4Qit3kw/B
         8KkX2O+U+KBWcdkNRVgiMHXWvKZGKH72jUsYUT8Y5CryiP7zbLXc0GfKXi757IeeNvEK
         g+yOdrfrnciyObXfsiduBvj2Oe64WZlFjXzm3ENYyCsZKqc21KzeNHXj4w4Xy8ZNQOdV
         0RXqz1p6K/ZF6fkhChEtx2O0uIJJ0+/TLmAJAQnuPqbAYKcsbbidPBNjwwFj6RywkKQS
         NX9g==
X-Gm-Message-State: AC+VfDzADEvM6aWHwBLkDStxh6nLPuSx7I8w/F4rcsY4JmPxEtpEGdAJ
        GUY1iDtso5GMmWzi/Mxkq8RYmWACGhQ0ZLPxtuTKqVaP98i4iNoqHcpUWjkPe0fRazYT4MOt7Is
        PY2lJhHtZAOTR+IU0Ws/GJxVR
X-Received: by 2002:aa7:d888:0:b0:51a:23fb:355c with SMTP id u8-20020aa7d888000000b0051a23fb355cmr8076349edq.10.1687269543796;
        Tue, 20 Jun 2023 06:59:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6b5AT6QAAjfNGSFqHnSqiPb5mv+npztwci67WB0CYLQf6lJNAROx+U2HhYdxy7fYnS0gvCQg==
X-Received: by 2002:aa7:d888:0:b0:51a:23fb:355c with SMTP id u8-20020aa7d888000000b0051a23fb355cmr8076320edq.10.1687269543440;
        Tue, 20 Jun 2023 06:59:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x22-20020aa7dad6000000b0050d83a39e6fsm1278687eds.4.2023.06.20.06.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:59:02 -0700 (PDT)
Message-ID: <a8edf75b-e0f7-a6c7-7d29-f0d39923549b@redhat.com>
Date:   Tue, 20 Jun 2023 14:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH drm-next v5 03/14] drm: manager to keep track of GPUs VA
 mappings
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>,
        Dave Airlie <airlied@redhat.com>
References: <20230620004217.4700-1-dakr@redhat.com>
 <20230620004217.4700-4-dakr@redhat.com>
 <cf6846ea-5bd0-0b41-b7e6-901c70701751@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <cf6846ea-5bd0-0b41-b7e6-901c70701751@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 6/20/23 08:45, Christian König wrote:
> Hi Danilo,
> 
> sorry for the delayed reply. I've trying to dig myself out of a hole at 
> the moment.

No worries, thank you for taking a look anyway!

> 
> Am 20.06.23 um 02:42 schrieb Danilo Krummrich:
>> [SNIP]
>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>> index bbc721870c13..5ec8148a30ee 100644
>> --- a/include/drm/drm_gem.h
>> +++ b/include/drm/drm_gem.h
>> @@ -36,6 +36,8 @@
>>   #include <linux/kref.h>
>>   #include <linux/dma-resv.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>>   #include <drm/drm_vma_manager.h>
>> @@ -379,6 +381,18 @@ struct drm_gem_object {
>>        */
>>       struct dma_resv _resv;
>> +    /**
>> +     * @gpuva:
>> +     *
>> +     * Provides the list of GPU VAs attached to this GEM object.
>> +     *
>> +     * Drivers should lock list accesses with the GEMs &dma_resv lock
>> +     * (&drm_gem_object.resv).
>> +     */
>> +    struct {
>> +        struct list_head list;
>> +    } gpuva;
>> +
>>       /**
>>        * @funcs:
>>        *
> 
> I'm pretty sure that it's not a good idea to attach this directly to the 
> GEM object.

Why do you think so? IMHO having a common way to connect mappings to 
their backing buffers is a good thing, since every driver needs this 
connection anyway.

E.g. when a BO gets evicted, drivers can just iterate the list of 
mappings and, as the circumstances require, invalidate the corresponding 
mappings or to unmap all existing mappings of a given buffer.

What would be the advantage to let every driver implement a driver 
specific way of keeping this connection? Do you see cases where this 
kind of connection between mappings and backing buffers wouldn't be good 
enough? If so, which cases do you have in mind? Maybe we can cover them 
in a common way as well?

> 
> As you wrote in the commit message it's highly driver specific what to 
> map and where to map it.

In the end the common case should be that in a VA space at least every 
mapping being backed by a BO is represented by a struct drm_gpuva.

> 
> Instead I suggest to have a separate structure for mappings in a VA 
> space which driver can then add to their GEM objects or whatever they 
> want to map into their VMs.

Which kind of separate structure for mappings? Another one analogous to 
struct drm_gpuva?

- Danilo

> 
> Regards,
> Christian.
> 
> 

