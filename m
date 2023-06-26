Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382373E9A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjFZSiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjFZSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DDCC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687804637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8jWJNO7puMQ1CYq+CDB5AikytZhom+Q/Z7QO9yT5ME=;
        b=LRf9h05J+qP0a0jQQJnj8xpOGWdH9+EBURRSMDh+UsooMSfYMrIKpXpmC8Ej17qsUnpwrW
        9nUdwqUwnc4oWl3YflzQo0CMnuCwbEZVNu4rLsakZebjRMc2uAOGt6VHusYSc382mgm/d1
        B1RZ33+HLLVX+kaiqKetZe49uTD5K64=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-hN3U_UC_PViSGV0NYbY1cA-1; Mon, 26 Jun 2023 14:37:14 -0400
X-MC-Unique: hN3U_UC_PViSGV0NYbY1cA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f863fcc56aso2574122e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687804628; x=1690396628;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8jWJNO7puMQ1CYq+CDB5AikytZhom+Q/Z7QO9yT5ME=;
        b=EcXYoNopLZv4VC3f1z1zHHlgKWoEoO13DZjrsyCFdPOaONCEh6ergXseWkTEPCgMPr
         1YvVIZuqDrmRXQ9wjLfsrJxq5/QAYGwD/ezoZchd8HW71hnrkWStFlEWlUkf0BiSk6bi
         g5UZc1rYvCMOliB+OBZxCuS7o5BJyhG9SmPEhJJmE1+5Ak1kbdEKrI5zV5P8lT698TJa
         OhN5IPEy9wS3HoS+fP2DEZDQFwmkJ6C1y//3fNo9OUGrdSD0jwzqjGpfN9gn5yo1qv6h
         6UXlSOmh2RbqS7jaQXnuNZFc0PF/jH8nLrVEXyggloKiOUHb2AwZ9MNk93aaf3ipqEQy
         R2bQ==
X-Gm-Message-State: AC+VfDzIlTo9ggdn+AYCiokj4yNzYiHepXBQCl441i8rtMBLnB5kDUYC
        PaimooNNgNZNZyB/1n2+VW6PZHbi1GuIAjnadMxysnhRWvxbRptRk0y5N6BrBcqRBBAG1S1Fvlg
        M5uJZBmFsTWUUgC7pY5X1FclM/cDOKIbj
X-Received: by 2002:a05:6512:3601:b0:4f9:5196:5ed0 with SMTP id f1-20020a056512360100b004f951965ed0mr12258703lfs.7.1687804628112;
        Mon, 26 Jun 2023 11:37:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ499UzKbjHgoMsuKPDNCvDuM8qCGFh8Am+tR1VVLJPoTSAsTMW75uFdUKKapdp+Ph1gk0dhtA==
X-Received: by 2002:a05:6512:3601:b0:4f9:5196:5ed0 with SMTP id f1-20020a056512360100b004f951965ed0mr12258695lfs.7.1687804627767;
        Mon, 26 Jun 2023 11:37:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d4d03000000b0030aec5e020fsm8070670wrt.86.2023.06.26.11.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 11:37:07 -0700 (PDT)
Message-ID: <8cc06224-8243-e08e-d0ea-4db71ddc7745@redhat.com>
Date:   Mon, 26 Jun 2023 20:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peng Zhang <perlyzhang@gmail.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
 <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
 <ZJmQVeiLtkFAGfW0@casper.infradead.org>
 <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
 <ZJmmFF1Hz5ajRhy3@casper.infradead.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <ZJmmFF1Hz5ajRhy3@casper.infradead.org>
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

On 6/26/23 16:52, Matthew Wilcox wrote:
> On Mon, Jun 26, 2023 at 04:27:54PM +0200, Danilo Krummrich wrote:
>> On 6/26/23 15:19, Matthew Wilcox wrote:
>>> On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
>>>> On the other hand, unless I miss something (and if so, please let me know),
>>>> something is bogus with the API then.
>>>>
>>>> While the documentation of the Advanced API of the maple tree explicitly
>>>> claims that the user of the API is responsible for locking, this should be
>>>> limited to the bounds set by the maple tree implementation. Which means, the
>>>> user must decide for either the internal (spin-) lock or an external lock
>>>> (which possibly goes away in the future) and acquire and release it
>>>> according to the rules maple tree enforces through lockdep checks.
>>>>
>>>> Let's say one picks the internal lock. How is one supposed to ensure the
>>>> tree isn't modified using the internal lock with mas_preallocate()?
>>>>
>>>> Besides that, I think the documentation should definitely mention this
>>>> limitation and give some guidance for the locking.
>>>>
>>>> Currently, from an API perspective, I can't see how anyone not familiar with
>>>> the implementation details would be able to recognize this limitation.
>>>>
>>>> In terms of the GPUVA manager, unfortunately, it seems like I need to drop
>>>> the maple tree and go back to using a rb-tree, since it seems there is no
>>>> sane way doing a worst-case pre-allocation that does not suffer from this
>>>> limitation.
>>>
>>> I haven't been paying much attention here (too many other things going
>>> on), but something's wrong.
>>>
>>> First, you shouldn't need to preallocate.  Preallocation is only there
>>
>> Unfortunately, I think we really have a case where we have to. Typically GPU
>> mappings are created in a dma-fence signalling critical path and that is
>> where such mappings need to be added to the maple tree. Hence, we can't do
>> any sleeping allocations there.
> 
> OK, so there are various ways to hadle this, depending on what's
> appropriate for your case.
> 
> The simplest is to use GFP_ATOMIC.  Essentially, you're saying to the MM
> layer "This is too hard, let me tap into the emergency reserves".  It's
> mildly frowned upon, so let's see if we can do better.
> 
> If you know where the allocation needs to be stored, but want it to act as
> NULL until the time is right, you can store a ZERO entry.  That will read
> as NULL until you store to it.  A pure overwriting store will not cause
> any memory allocation since all the implementation has to do is change
> a pointer.  The XArray wraps this up nicely behind an xa_reserve() API.
> As you're discovering, the Maple Tree API isn't fully baked yet.
> 

Unfortunately, GFP_ATOMIC seems the be the only option. I think storing 
entries in advance would not work. Typically userspace submits a job to 
the kernel issuing one or multiple requests to map and unmap memory in 
an ioctl. Such a job is then put into a queue and processed 
asynchronously in a dma-fence signalling critical section. Hence, at the 
we'd store entries in advance we could have an arbitrary amount of 
pending jobs potentially still messing with the same address space region.

So, the only way to go seems to be to use mas_store_gfp() with 
GFP_ATOMIC directly in the fence signalling critical path. I guess 
mas_store_gfp() does not BUG_ON() if it can't get atomic pages?

Also, I just saw that the tree is limited in it's height 
(MAPLE_HEIGHT_MAX). Do you think it could be a sane alternative to 
pre-allocate with MAPLE_HEIGHT_MAX rather than to rely on atomic pages? 
Or maybe a compromise of pre-allocating just a couple of nodes and then 
rely on atomic pages for the rest?

FYI, we're talking about a magnitude of hundreds of thousands of entries 
to be stored in the tree.

- Danilo

