Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71E173E858
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjFZSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjFZSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED2226A4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687803714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7d5o216+gZzb7LjG6wT7FRl5pgwrzpiiCyEaun3wVWg=;
        b=a6DLOOL9wBC24YLbS6y/hPmpO8nnr/BAcFhDiThZiNhRO/ELlB1Cz83R6gNqSBN4kcpj0O
        OpNONGKAkK7hjF96U11v7Fg2EE91jrehDeAFtZCkbo7X3jwqCGcabq/Sv/5PLucvfS8vsr
        01siXjeNaNU5W0JfRDavQ6LNjc1r4zc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-04MHv5G2NnalS_Z2WVBLng-1; Mon, 26 Jun 2023 14:21:53 -0400
X-MC-Unique: 04MHv5G2NnalS_Z2WVBLng-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f2981b8364so2035425f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803711; x=1690395711;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7d5o216+gZzb7LjG6wT7FRl5pgwrzpiiCyEaun3wVWg=;
        b=kbErjwRuDNdm7X5NuIVP6GUeLr1OoOIuwWjqbZMByQbLsKhcZv/v3/t4aDThgnj29R
         L4F/m6sp7RlNBNbP4AfhiAOD41WG83wgmVg+RRGdTcEWvfxHUW3zToqyGT553e+8jFra
         OSNr2S/1Yb7W4BfDq23rg1Hz6T4EXJ8FtV5sS45E61pKeaPDuZqv4CCbhpqxIlUiQogh
         HtI35oTR4MqkJcbIBSFzxOpP0VYNbb7l3D0kPErcXw1omnrX2p61cYwt6PXH/BlPQNFk
         gkl3gd6dqPLBwfDe5lidCdgz4x3fBe4Hz21aSCXIrPCotNXZ0ru7ITfLTpl07/DUIUn5
         mkzQ==
X-Gm-Message-State: AC+VfDyEdmlc+ulwBY8rJtKoVpEIHHqZLxh/epYBYoBxjl0HIL1fZk5L
        rKB0sVh91zdHphJTWFcYhC9uownsPy8G9pQqsetrjjsNgXoldE/ybPUQcKsTE5y9K0fU6yg+zS0
        1SOtWC90ooI44DUqrhRa8/19B
X-Received: by 2002:adf:f887:0:b0:313:e08e:5599 with SMTP id u7-20020adff887000000b00313e08e5599mr6341889wrp.67.1687803711738;
        Mon, 26 Jun 2023 11:21:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5n+Lk6EWcxrnDxX3B3uow6vJnKDCug7Zp3C4LwW+oyKCc4uz4GdaK6qErbD8yunrefffBgxg==
X-Received: by 2002:adf:f887:0:b0:313:e08e:5599 with SMTP id u7-20020adff887000000b00313e08e5599mr6341876wrp.67.1687803711451;
        Mon, 26 Jun 2023 11:21:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d58ee000000b00313f1c5b56dsm3387316wrd.79.2023.06.26.11.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 11:21:51 -0700 (PDT)
Message-ID: <362330be-1ff1-d2cb-de6a-6ad42cbb9d58@redhat.com>
Date:   Mon, 26 Jun 2023 20:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
Content-Language: en-US
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
 <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
 <ZJmQVeiLtkFAGfW0@casper.infradead.org>
 <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
 <ba821a60-06f9-7bc5-2362-b1b3c44b0088@bytedance.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <ba821a60-06f9-7bc5-2362-b1b3c44b0088@bytedance.com>
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

On 6/26/23 16:49, Peng Zhang wrote:
> 
> 
> 在 2023/6/26 22:27, Danilo Krummrich 写道:
>> On 6/26/23 15:19, Matthew Wilcox wrote:
>>> On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
>>>> On the other hand, unless I miss something (and if so, please let me 
>>>> know),
>>>> something is bogus with the API then.
>>>>
>>>> While the documentation of the Advanced API of the maple tree 
>>>> explicitly
>>>> claims that the user of the API is responsible for locking, this 
>>>> should be
>>>> limited to the bounds set by the maple tree implementation. Which 
>>>> means, the
>>>> user must decide for either the internal (spin-) lock or an external 
>>>> lock
>>>> (which possibly goes away in the future) and acquire and release it
>>>> according to the rules maple tree enforces through lockdep checks.
>>>>
>>>> Let's say one picks the internal lock. How is one supposed to ensure 
>>>> the
>>>> tree isn't modified using the internal lock with mas_preallocate()?
>>>>
>>>> Besides that, I think the documentation should definitely mention this
>>>> limitation and give some guidance for the locking.
>>>>
>>>> Currently, from an API perspective, I can't see how anyone not 
>>>> familiar with
>>>> the implementation details would be able to recognize this limitation.
>>>>
>>>> In terms of the GPUVA manager, unfortunately, it seems like I need 
>>>> to drop
>>>> the maple tree and go back to using a rb-tree, since it seems there 
>>>> is no
>>>> sane way doing a worst-case pre-allocation that does not suffer from 
>>>> this
>>>> limitation.
>>>
>>> I haven't been paying much attention here (too many other things going
>>> on), but something's wrong.
>>>
>>> First, you shouldn't need to preallocate.  Preallocation is only there
>>
>> Unfortunately, I think we really have a case where we have to. 
>> Typically GPU mappings are created in a dma-fence signalling critical 
>> path and that is where such mappings need to be added to the maple 
>> tree. Hence, we can't do any sleeping allocations there.
>>
>>> for really gnarly cases.  The way this is *supposed* to work is that
>>> the store walks down to the leaf, attempts to insert into that leaf
>>> and tries to allocate new nodes with __GFP_NOWAIT.  If that fails,
>>> it drops the spinlock, allocates with the gfp flags you've specified,
>>> then rewalks the tree to retry the store, this time with allocated
>>> nodes in its back pocket so that the store will succeed.
>>
>> You are talking about mas_store_gfp() here, right? And I guess, if the 
>> tree has changed while the spinlock was dropped and even more nodes 
>> are needed it just retries until it succeeds?
>>
>> But what about mas_preallocate()? What happens if the tree changed in 
>> between mas_preallocate() and mas_store_prealloc()? Does the latter 
>> one fall back to __GFP_NOWAIT in such a case? I guess not, since 
>> mas_store_prealloc() has a void return type, and __GFP_NOWAIT could 
>> fail as well.
> mas_store_prealloc() will fallback to __GFP_NOWAIT and issue a warning.
> If __GFP_NOWAIT allocation fails, BUG_ON() in mas_store_prealloc() will
> be triggered.

Ok, so this is an absolute last resort and surely should not be relied on.

I think the maple tree should either strictly enforce (through locking 
policy) that this can never happen or if API wise it is OK not to lock 
these two is legit, return an error code rather then issue a warning and 
even worse call BUG_ON() in case it can't fix things up.

- Danilo

> 
>>
>> So, how to use the internal spinlock for mas_preallocate() and 
>> mas_store_prealloc() to ensure the tree can't change?
>>
> 

