Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BCB69F765
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjBVPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjBVPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C52069B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677078486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRCEb4SvpDKPjZLK4vn9/q7q7Y3I8z1o20cZm/AYJwk=;
        b=R3ipXUAD2Lh3jlz6hMCBhg9Tud2qHjmVinomvuzmYnnyB/PZ+i0LmHtKPuNH4PZZhpTSuA
        qs0+YfK1/++g5WwzuMCgRIE2uDgr38nTDFFKr5aPs/tPH64IzAydJoab7MMfH1J6ONub/U
        ALZ+2VZ5wbsJX8rtrS7MXCzKu7cU7B0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-ONdC25wjNpW2MqmmV5YZQQ-1; Wed, 22 Feb 2023 10:07:57 -0500
X-MC-Unique: ONdC25wjNpW2MqmmV5YZQQ-1
Received: by mail-ed1-f72.google.com with SMTP id b1-20020aa7dc01000000b004ad062fee5eso11045524edu.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRCEb4SvpDKPjZLK4vn9/q7q7Y3I8z1o20cZm/AYJwk=;
        b=M7uBfhLFVxWMWZMdNrxZOf5Uo5Gl0TRwfbOB5/UzMO++6D5HmR/244dxFBFuhdnHMI
         rckVPHFKFBaVwms8xH3jGI1zkZxJg4MjJLRS6TtN/MeQBSll7Bih4L/0t8FIR8EoOLb3
         DkvfMDoKLGdLXKxCJirw0tsJSojoP4i7J9LGN69Q6UnR2wpyOW2yIMVajXbaYKnffdL8
         VNTMMOsTq39mqFQ+DWRbiC8hhFA202GK/S6+O61pmdOc2B9cHbgYXKXFoGK+ftGu3dim
         W+goperhBPWtHi3SU/9H73PrMqGyFX85BLk2Sn36xKXicyPKE4cZeBVX98In5HcpuDVh
         CZQQ==
X-Gm-Message-State: AO0yUKVOICEH2G3tP0mcrFJtHjyp5viHsDQiyZARApN2s5vpeNy0iFd5
        ppwDGWiqUHXfHocZN1SSA3sTKfgdpEmdgjZ9jyaDuPhjgnmpMF2dchXtvCcp6COmQC+FdJPGT+L
        ivqgIGFmPhKnXerH95Ot8jWHH
X-Received: by 2002:a17:907:1623:b0:8b1:76dd:f5f6 with SMTP id hb35-20020a170907162300b008b176ddf5f6mr29151562ejc.50.1677078475601;
        Wed, 22 Feb 2023 07:07:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8V2KGVMm3Rh6GnmJnl329zmNElexUMuVrYhLPpVZhOY6NIjF1ZDTeKB87CfdRbYWnWGPbc0Q==
X-Received: by 2002:a17:907:1623:b0:8b1:76dd:f5f6 with SMTP id hb35-20020a170907162300b008b176ddf5f6mr29151515ejc.50.1677078475224;
        Wed, 22 Feb 2023 07:07:55 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906771400b008e57b5e0ce9sm1160273ejm.108.2023.02.22.07.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:07:54 -0800 (PST)
Message-ID: <cc8eeaf4-31e7-98e4-a712-012fc604e985@redhat.com>
Date:   Wed, 22 Feb 2023 16:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH drm-next v2 05/16] drm: manager to keep track of GPUs VA
 mappings
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net, linux-doc@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Dave Airlie <airlied@redhat.com>
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-6-dakr@redhat.com>
 <70ba382f-1559-289a-4922-ca9c371aaf59@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <70ba382f-1559-289a-4922-ca9c371aaf59@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 11:25, Christian König wrote:
> Am 17.02.23 um 14:44 schrieb Danilo Krummrich:

<snip>

>> +/**
>> + * DOC: Overview
>> + *
>> + * The DRM GPU VA Manager, represented by struct drm_gpuva_manager 
>> keeps track
>> + * of a GPU's virtual address (VA) space and manages the 
>> corresponding virtual
>> + * mappings represented by &drm_gpuva objects. It also keeps track of 
>> the
>> + * mapping's backing &drm_gem_object buffers.
>> + *
>> + * &drm_gem_object buffers maintain a list (and a corresponding list 
>> lock) of
>> + * &drm_gpuva objects representing all existent GPU VA mappings using 
>> this
>> + * &drm_gem_object as backing buffer.
>> + *
>> + * If the &DRM_GPUVA_MANAGER_REGIONS feature is enabled, a GPU VA 
>> mapping can
>> + * only be created within a previously allocated &drm_gpuva_region, 
>> which
>> + * represents a reserved portion of the GPU VA space. GPU VA mappings 
>> are not
>> + * allowed to span over a &drm_gpuva_region's boundary.
>> + *
>> + * GPU VA regions can also be flagged as sparse, which allows drivers 
>> to create
>> + * sparse mappings for a whole GPU VA region in order to support Vulkan
>> + * 'Sparse Resources'.
> 
> Well since we have now found that there is absolutely no technical 
> reason for having those regions could we please drop them?

I disagree this was the outcome of our previous discussion.

In nouveau I still need them to track the separate sparse page tables 
and, as you confirmed previously, Nvidia cards are not the only cards 
supporting this feature.

The second reason is that with regions we can avoid merging between 
buffers, which saves some effort. However, I agree that this argument by 
itself probably doesn't hold too much, since you've pointed out in a 
previous mail that:

<cite>
1) If we merge and decide to only do that inside certain boundaries then 
those boundaries needs to be provided and checked against. This burns 
quite some CPU cycles

2) If we just merge what we can we might have extra page table updates 
which cost time and could result in undesired side effects.

3) If we don't merge at all we have additional housekeeping for the 
mappings and maybe hw restrictions.
</cite>

However, if a driver uses regions to track its separate sparse page 
tables anyway it gets 1) for free, which is a nice synergy.

I totally agree that regions aren't for everyone though. Hence, I made 
them an optional feature and by default regions are disabled. In order 
to use them drm_gpuva_manager_init() must be called with the 
DRM_GPUVA_MANAGER_REGIONS feature flag.

I really would not want to open code regions or have two GPUVA manager 
instances in nouveau to track sparse page tables. That would be really 
messy, hence I hope we can agree on this to be an optional feature.

> 
> I don't really see a need for them any more.
> 
> Regards,
> Christian.
>  

