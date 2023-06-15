Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5259731DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjFOQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjFOQc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A62B171C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686846726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8prCxNwHYsAASYpnEixZIiXJnat1jStC3yPASEgEOY=;
        b=CyPrGwGGwH3lme3x4GFFynLOYjYyxKyWdxu0qpXSsAORMlqqE28vCOvPP02Eq90iznno2y
        nOrrfjwf1Dt8X0hmSPkMggHIknqhbZnRbFD9u83q2XwuV/E72U1tdSxiRDYTlK0lnh0u3U
        Qz+XXNI5cIQhMwD4VjdPMbgcuyxjwUg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-xy54yRDRMaS1mg9SlQkkHw-1; Thu, 15 Jun 2023 12:32:02 -0400
X-MC-Unique: xy54yRDRMaS1mg9SlQkkHw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355c9028so177522066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686846719; x=1689438719;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8prCxNwHYsAASYpnEixZIiXJnat1jStC3yPASEgEOY=;
        b=b2CkMtQohMImcVNN3uirsTZic5tzpG1gv+gfrnwAcIcWYlqvj+/BSnMHjQ/A8+4R8Q
         6O6pj/r1GegNtxlnqTfutJECzdgLp3LWmpJxbovjGfvdDQTHreCZJo9Amv6O2or8pAko
         Dry+1FQCHFYlwYGdDiYeX3ngR5Bk3BDUCBME/VxHz9X/vk+l+tFbnc7WAqMo7wKTT9q9
         JZgjjrb+EmA+sTrm4LZD2diEpwhjHmKHc2Tci7DQtQtAbS0X6fDwole7R7KPvQhmRr77
         QE2xl9HsVaF/U64LcModMtvs3B6BzRVKCZofrwV5+4J8Eq0UrBnq/QkqCqvJTE9sK41G
         7RXg==
X-Gm-Message-State: AC+VfDxPg8SX0LPeaG9/ANRuGm9mtLvAM03ilhM/+fpEK9A5z3xYcq+S
        GuGkRzWRXy+jEwe7e7oKSYx+9aornaz3OEy9zolqjrdHU5RVYAFFaB2QddTD8QLL1HUUTTjqxek
        EGaCG6gkI7F8MSSvQieSlQdx5aGXqWFRF
X-Received: by 2002:a17:907:36c3:b0:973:9f60:c57e with SMTP id bj3-20020a17090736c300b009739f60c57emr19336021ejc.2.1686846719000;
        Thu, 15 Jun 2023 09:31:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+R8RzzvJRBN02oNH7VD/7mlr9HZ1UXhQY/4JOFMYjuMwKKZwmGEwfZjYH1RFjjAHfmir7Fw==
X-Received: by 2002:a17:907:36c3:b0:973:9f60:c57e with SMTP id bj3-20020a17090736c300b009739f60c57emr19335996ejc.2.1686846718666;
        Thu, 15 Jun 2023 09:31:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090612cd00b0096f7cf96525sm9642613ejb.146.2023.06.15.09.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 09:31:58 -0700 (PDT)
Message-ID: <27b46c9e-0ebb-74d2-c22e-3f7fc7addbdc@redhat.com>
Date:   Thu, 15 Jun 2023 18:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH drm-next v4 00/14] [RFC] DRM GPUVA Manager & Nouveau
 VM_BIND UAPI
Content-Language: en-US
To:     Donald Robson <Donald.Robson@imgtec.com>
Cc:     "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "jason@jlekstrand.net" <jason@jlekstrand.net>,
        "bskeggs@redhat.com" <bskeggs@redhat.com>
References: <20230606223130.6132-1-dakr@redhat.com>
 <f5723444623b41d58f93c3f0ab662e9b37105765.camel@imgtec.com>
 <67ffef18-fae4-cb84-ff75-c4eed92a8755@redhat.com>
 <1cee380fb31e1a2f499e50e6b8771d86a68c1b16.camel@imgtec.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <1cee380fb31e1a2f499e50e6b8771d86a68c1b16.camel@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/14/23 09:58, Donald Robson wrote:
> On Tue, 2023-06-13 at 16:20 +0200, Danilo Krummrich wrote:
> 
>> I'm definitely up improving the existing documentation. Anything in
>> particular you think should be described in more detail?
>>
>> - Danilo
> 
> Hi Danilo,
> 
> As I said, with inexperience it's possible I missed what I was
> looking for in the existing documentation, which is highly detailed
> in regard to how it deals with operations, but usage was where I fell
> down.
> 
> If I understand there are three ways to use this, which are:
> 1) Using drm_gpuva_insert() and drm_gpuva_remove() directly using
>     stack va objects.

What do you mean with stack va objects?

> 2) Using drm_gpuva_insert() and drm_gpuva_remove() in a callback
>     context, after having created ops lists using
>     drm_gpuva_sm_[un]map_ops_create().
> 3) Using drm_gpuva_[un]map() in callback context after having
>     prealloced a node and va objects for map/remap function use,
>     which must be forwarded in as the 'priv' argument to
>     drm_gpuva_sm_[un]map().

Right, and I think it might be worth concretely mentioning this in the 
documentation.

> 
> The first of these is pretty self-explanatory.  The second was also
> fairly easy to understand, it has an example in your own driver, and
> since it takes care of allocs in drm_gpuva_sm_map_ops_create() it
> leads to pretty clean code too.
> 
> The third case, which I am using in the new PowerVR driver did not
> have an example of usage and the approach is quite different to 2)
> in that you have to prealloc everything explicitly.  I didn't realise
> this, so it led to a fair amount of frustration.

Yeah, I think this is not entirely obvious why this is the case. I 
should maybe add a comment on how the callback way of using this 
interface is motivated.

The requirement of pre-allocation arises out of two circumstances.
First, having a single callback for every drm_gpuva_op on the GPUVA 
space implies that we're not allowed to fail the operation, because 
processing the drm_gpuva_ops directly implies that we can't unwind them 
on failure.

I know that the API functions the documentation guides you to use in 
this case actually can return error codes, but those are just range 
checks. If they fail, it's clearly a bug. However, I did not use WARN() 
for those cases, since the driver could still decide to use the 
callbacks to keep track of the operations in a driver specific way, 
although I would not recommend doing this and rather like to try to 
cover the drivers use case within the regular way of creating a list of 
operations.

Second, most (other) drivers when using the callback way of this 
interface would need to execute the GPUVA space updates asynchronously 
in a dma_fence signalling critical path, where no memory allocations are 
permitted.

> 
> I think if you're willing, it would help inexperienced implementers a
> lot if there were some brief 'how to' snippets for each of the three
> use cases.

Yes, I can definitely add some.

> 
> Thanks,
> Donald

