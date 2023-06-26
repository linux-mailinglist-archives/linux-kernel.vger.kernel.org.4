Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8900F73E224
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFZO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFZO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F898
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687789680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoyWyxXX7ShezkxwEtGhHhAWKCuXh2pj0Y+G9zY6kLU=;
        b=AJYbtuQyhCyJ2YVpTdMFI8Vw+3L2J3rrgPPFRD8e2jW6QEqjTLeXLYen8R9wJJVMLwy6zZ
        RJ8xlpHLx3lO8eaO5MLOHSX+YGOJ5m43tXWXQlMmS4I8bd84/nbpJT8HnvLDAAqPDEWNpS
        kkmoVWGGUpy1SnOyQ25znafch5nwU8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-i1_C2gIiMZK_pqSVfLmWAw-1; Mon, 26 Jun 2023 10:27:58 -0400
X-MC-Unique: i1_C2gIiMZK_pqSVfLmWAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa96b67ac1so22254955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687789676; x=1690381676;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoyWyxXX7ShezkxwEtGhHhAWKCuXh2pj0Y+G9zY6kLU=;
        b=F/MkuAemBhuvSwDTb+GAvknSrVp+QUhHmtXSVoZvFkd0QMt6bUywgsTYpIs1kgCa+p
         Fbi1gJLgyh/ZweZfdBlNfD+rcsPBW74rX0jtz0pLyRv5KpVEI43JJCBx5TYxtMqZ6yY3
         Wgh2H611+08W0uwmXX+nPATXezNloSF5RjzvuuuQafZCVTyAfog2OS9WbgmlcFv8Iiny
         92PcpEzP6jUtxpjB8bb4g/M6ELskC/ARfMIJc4A8dzBAGvuNpU7R53MU2aS5G2EOT/mI
         oAU2K044W+iPytgtAnbI4hh0AWUS8NDwWWT6kvhbF7HSnqgfbGJpir5FYx+oFeC8W9aP
         htHw==
X-Gm-Message-State: AC+VfDyANAEPusvCzPmDd1hBhxFiXqBo4v/FKb/A2HD0VHiSc6Y1iM6l
        wezI8aYwoUiyOQmlpdq9QT5har+/qn5yFK8eUDajIy4PNv6Hvn+fK8wKQ3Wn6DLoC/PsVyp+jdV
        /f2Z8QMdSGDjzw4Vt07zz3yWl
X-Received: by 2002:a05:600c:2284:b0:3fa:8219:9163 with SMTP id 4-20020a05600c228400b003fa82199163mr10267674wmf.21.1687789676707;
        Mon, 26 Jun 2023 07:27:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7K552SJ/lZjinu84fOMgSD+Rx2qEd1aQy6B7PJIPCKHf1jhpcjAX6S6KSzOQjPctTzvRro+w==
X-Received: by 2002:a05:600c:2284:b0:3fa:8219:9163 with SMTP id 4-20020a05600c228400b003fa82199163mr10267658wmf.21.1687789676389;
        Mon, 26 Jun 2023 07:27:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c00c300b003faa6ce54b2sm1933871wmm.2.2023.06.26.07.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:27:56 -0700 (PDT)
Message-ID: <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
Date:   Mon, 26 Jun 2023 16:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
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
Content-Language: en-US
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <ZJmQVeiLtkFAGfW0@casper.infradead.org>
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

On 6/26/23 15:19, Matthew Wilcox wrote:
> On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
>> On the other hand, unless I miss something (and if so, please let me know),
>> something is bogus with the API then.
>>
>> While the documentation of the Advanced API of the maple tree explicitly
>> claims that the user of the API is responsible for locking, this should be
>> limited to the bounds set by the maple tree implementation. Which means, the
>> user must decide for either the internal (spin-) lock or an external lock
>> (which possibly goes away in the future) and acquire and release it
>> according to the rules maple tree enforces through lockdep checks.
>>
>> Let's say one picks the internal lock. How is one supposed to ensure the
>> tree isn't modified using the internal lock with mas_preallocate()?
>>
>> Besides that, I think the documentation should definitely mention this
>> limitation and give some guidance for the locking.
>>
>> Currently, from an API perspective, I can't see how anyone not familiar with
>> the implementation details would be able to recognize this limitation.
>>
>> In terms of the GPUVA manager, unfortunately, it seems like I need to drop
>> the maple tree and go back to using a rb-tree, since it seems there is no
>> sane way doing a worst-case pre-allocation that does not suffer from this
>> limitation.
> 
> I haven't been paying much attention here (too many other things going
> on), but something's wrong.
> 
> First, you shouldn't need to preallocate.  Preallocation is only there

Unfortunately, I think we really have a case where we have to. Typically 
GPU mappings are created in a dma-fence signalling critical path and 
that is where such mappings need to be added to the maple tree. Hence, 
we can't do any sleeping allocations there.

> for really gnarly cases.  The way this is *supposed* to work is that
> the store walks down to the leaf, attempts to insert into that leaf
> and tries to allocate new nodes with __GFP_NOWAIT.  If that fails,
> it drops the spinlock, allocates with the gfp flags you've specified,
> then rewalks the tree to retry the store, this time with allocated
> nodes in its back pocket so that the store will succeed.

You are talking about mas_store_gfp() here, right? And I guess, if the 
tree has changed while the spinlock was dropped and even more nodes are 
needed it just retries until it succeeds?

But what about mas_preallocate()? What happens if the tree changed in 
between mas_preallocate() and mas_store_prealloc()? Does the latter one 
fall back to __GFP_NOWAIT in such a case? I guess not, since 
mas_store_prealloc() has a void return type, and __GFP_NOWAIT could fail 
as well.

So, how to use the internal spinlock for mas_preallocate() and 
mas_store_prealloc() to ensure the tree can't change?

