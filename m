Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236296BD60E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCPQla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjCPQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CEF19A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678984773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIjjbwXvUyx1yHV3Ag65tOZVBiQaT5p/l+soILdmUMg=;
        b=Xm4kpi/76buBmGMAlxQXlw6GD782FMA8PwJJbUrMnt+g4w7/Nh9+40Hk8PfMl7r/8CSwUd
        8occudbF1DAGVlYjHOzdSk481KPPwpj+KERSbi030aJcpU+XmQAXiA0hhynVHsb+OGm3L0
        aym/bDnMYVLnc/NsywbB9Ej/OYUDnho=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-xDUvMbmAOESrYhK3dpGE4Q-1; Thu, 16 Mar 2023 12:39:32 -0400
X-MC-Unique: xDUvMbmAOESrYhK3dpGE4Q-1
Received: by mail-ed1-f69.google.com with SMTP id b7-20020a056402350700b004d2a3d5cd3fso3834041edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678984771;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIjjbwXvUyx1yHV3Ag65tOZVBiQaT5p/l+soILdmUMg=;
        b=atUB36qRAPu3E/EU+ySbIR2fObH4Xyt5emolHX3I2RJf5HW26SNkWPLari+YvWyCFk
         zdYy7c2jMEpFJQlpqWtDWjhLzq0hqpa5UaMwOaDsVqFw0mBPv+PaLfVpwXo2Hnld0J2n
         4YpEIW/CvC0v1D8pAplIlBjBT/2K6BMpt9ss4ly0+1eo95DrhHAJWGfiYu3aJebnYg+a
         EeRCGCXHZVkNcw5tTaPh4Jpm5l6D6bAd1+0kGC04fuXZgEvOitAAXxNubQJ7jR/Fmxot
         9FPj2vwj6aPXiHbB9grX5S2eIhAH48m6quftmGgWRxczOoeQqUZ886PscanNajGIbJ2N
         RUHQ==
X-Gm-Message-State: AO0yUKWjAtrlFt5J8T10K9iGzKmee9+Lln7OVZszrhemYXmRAvXrVVPM
        EQ/aWIhI1ENFHfPGX/y1gPj5cEJJVpa2g64Amiak4+Hmpf8LL6fahENPKaeLSAyA688H6HX0RWz
        wRcjDddSekD82pPQWbkLXsy3n
X-Received: by 2002:a05:6402:4c5:b0:500:2cc6:36da with SMTP id n5-20020a05640204c500b005002cc636damr203734edw.19.1678984771326;
        Thu, 16 Mar 2023 09:39:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set9V8TDcXbJOgnOBxH6ODTR6VjYhQ4kSbUdWqsuVHaamhdMw5sSOqawbmI1THONqUSv/FiH8Xg==
X-Received: by 2002:a05:6402:4c5:b0:500:2cc6:36da with SMTP id n5-20020a05640204c500b005002cc636damr203714edw.19.1678984771069;
        Thu, 16 Mar 2023 09:39:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id v3-20020a50d083000000b004c3e3a6136dsm4068725edd.21.2023.03.16.09.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 09:39:30 -0700 (PDT)
Message-ID: <038fbef3-1f05-7d94-89b0-0bb681481885@redhat.com>
Date:   Thu, 16 Mar 2023 17:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH drm-next 00/14] [RFC] DRM GPUVA Manager & Nouveau VM_BIND
 UAPI
Content-Language: en-US
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     jason@jlekstrand.net, corbet@lwn.net,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bskeggs@redhat.com, tzimmermann@suse.de, airlied@redhat.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Brost <matthew.brost@intel.com>
References: <db4fa0fc-c9a6-9a48-c45f-1d655b30aff9@amd.com>
 <02b0bcb8-f69f-93cf-1f56-ec883cb33965@redhat.com>
 <3602500f-05f5-10b8-5ec6-0a6246e2bb6b@amd.com>
 <bcbef353-f579-4e90-1c77-be36bbe61c0f@redhat.com>
 <CADnq5_PGaXFW-z3gt+R+W+vBVdeuL4wMuMOQh4muxU13Bemy3A@mail.gmail.com>
 <0f2d6e1a-a3b5-f323-a29d-caade427292c@redhat.com>
 <CADnq5_Nh-1esiHzvTG+qFBCfMjy21efX-YN2jfGG=WC+-4LwLQ@mail.gmail.com>
 <CAPM=9txMZO1uYj+kVdTfmCwV2Fq8uu_b3i4eq4xhqPEPKBW8Eg@mail.gmail.com>
 <7839c47e-6692-b93b-69a8-9584193cb07d@amd.com>
 <6566870d-6256-8eef-5879-cb13711e4bed@redhat.com>
 <Y8jT1TazLddqZjG4@DUT025-TGLU.fm.intel.com>
 <CAFCwf10BAfg+_JGzyV0Rgx3WHaOR4vv9hvRXm0b0wW9U6tHSOA@mail.gmail.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CAFCwf10BAfg+_JGzyV0Rgx3WHaOR4vv9hvRXm0b0wW9U6tHSOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oded,

sorry for the late response, somehow this mail slipped through.

On 2/6/23 15:48, Oded Gabbay wrote:
> On Thu, Jan 19, 2023 at 7:24 AM Matthew Brost <matthew.brost@intel.com> wrote:
>> Is this not an application issue? Millions of mappings seems a bit
>> absurd to me.
> If I look at the most extreme case for AI, assuming 256GB of HBM
> memory and page mapping of 2MB, we get to 128K of mappings. But that's
> really the extreme case imo. I assume most mappings will be much
> larger. In fact, in the most realistic scenario of large-scale
> training, a single user will probably map the entire HBM memory using
> 1GB pages.
> 
> I have also a question, could this GPUVA code manage VA ranges
> mappings for userptr mappings, assuming we work without svm/uva/usm
> (pointer-is-a-pointer) ? Because then we are talking about possible
> 4KB mappings of 1 - 1.5 TB host server RAM (Implied in my question is
> the assumption this can be used also for non-VK use-cases. Please tell
> me if I'm totally wrong here).

In V2 I switched from drm_mm to maple tree, which should improve 
handling of lots of entries. I also dropped the requirement for GPUVA 
entries to be backed by a valid GEM object.

I think it can be used for non-VK use-cases. It basically just keeps 
track of mappings (not allocating them in the sense of finding a hole 
and providing a base address for a given size). There are basic 
functions to insert and remove entries. For those basic functions it is 
ensured that colliding entries can't be inserted and only a specific 
given entry can be removed, rather than e.g. an arbitrary range.

There are also more advanced functions where users of the GPUVA manager 
can request to "force map" a new mapping and to unmap a given range. The 
GPUVA manager will figure out the (sub-)operations to make this happen 
(.e.g. remove mappings in the way, split up mappings, etc.) and either 
provide these operations (or steps) through callbacks or though a list 
of operations to the caller to process them.

Are there any other use-cases or features you could think of that would 
be beneficial for accelerators?

- Danilo

> 
> Thanks,
> Oded
> 

