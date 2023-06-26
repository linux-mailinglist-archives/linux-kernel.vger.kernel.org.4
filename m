Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A966F73E26E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFZOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFZOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:49:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D056112E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:49:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso2907025a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687790970; x=1690382970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQb0qOt7za3JfyuW5vz4QFCethrcqJk2saWua6HMAXU=;
        b=jZXsSwFUnSSRaPAEYACr0E/2WajdCjyhOaJxs0Mv22a/FivBQTyxlWgeUoo055b7SK
         KhIzjME2oTmSjsPl9uP4sty9sDJAflnRE0syYDXb/aNJtdQjTZNg6vDnUdXdCtz6q8ZX
         l7TOz+YUv4+kMhLv2gZfNkPxwsxfRMKEbz5vQHDblVC9QD5eYQ3/PUASCMnxpxpnBl+9
         qZRgTciQudVmLfp5y6yM31C8R93erE2nsnbi3xsJRzg7ZTm9AUNIAklzymRw/QmOO+1Z
         PEMxPIPPbTA+zsbOavFCwxeQnXzDo/C8WCx4lv3OkwpdGffxyvH7DtwumyiIMc6r39t4
         rC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687790970; x=1690382970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pQb0qOt7za3JfyuW5vz4QFCethrcqJk2saWua6HMAXU=;
        b=YIxPPJIG+gxsftfHo5xht2Y/XeJCF2dDe5GWsN4YfPS+aBZ1KFQcQmWSAS1KFBb81p
         DykmatCjeWSi4thBzvTnbPwTrsofdIqrC2wO72o98e8zYKOTCq0/IkJkoD+HffvrViWH
         kZCz+2fGPmtICXr0N6/VkPahHpALYwxZRCFpfGWbSL9OShbQ1rZuw98eTzi5xbqpjuTd
         BbrB6lSnzFCReI4tMWVqhjVftbeutQh3kueUJsFp6WNTH8G09D9MxuTNJjJuzbo1KDgr
         t9FFEJL0H+oQCcWQV5mDaj5EV/+ek5VhcV/uRbgy1p9n6lGCadokIhwPmn54cg9Iwof8
         BdkQ==
X-Gm-Message-State: AC+VfDyqQfLae9cWJlmZMnsL9U2xalQBjEmnoCkqR9VninZYaaJ/zsNZ
        uAKor/a4RDol7lPdQkGQbenq8A==
X-Google-Smtp-Source: ACHHUZ5GGmQmZK6Pdk/0WOE4p0jN9ts4cyRWDEezIQMn0sNMLYw4rloFGLp7ys1IgYmzAuUjLFF+nQ==
X-Received: by 2002:a17:90a:17ec:b0:262:ba8a:f7ef with SMTP id q99-20020a17090a17ec00b00262ba8af7efmr9419568pja.23.1687790970330;
        Mon, 26 Jun 2023 07:49:30 -0700 (PDT)
Received: from [10.255.209.141] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a199200b00262f59ce2edsm1900239pji.10.2023.06.26.07.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:49:30 -0700 (PDT)
Message-ID: <ba821a60-06f9-7bc5-2362-b1b3c44b0088@bytedance.com>
Date:   Mon, 26 Jun 2023 22:49:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/26 22:27, Danilo Krummrich 写道:
> On 6/26/23 15:19, Matthew Wilcox wrote:
>> On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
>>> On the other hand, unless I miss something (and if so, please let me 
>>> know),
>>> something is bogus with the API then.
>>>
>>> While the documentation of the Advanced API of the maple tree explicitly
>>> claims that the user of the API is responsible for locking, this 
>>> should be
>>> limited to the bounds set by the maple tree implementation. Which 
>>> means, the
>>> user must decide for either the internal (spin-) lock or an external 
>>> lock
>>> (which possibly goes away in the future) and acquire and release it
>>> according to the rules maple tree enforces through lockdep checks.
>>>
>>> Let's say one picks the internal lock. How is one supposed to ensure the
>>> tree isn't modified using the internal lock with mas_preallocate()?
>>>
>>> Besides that, I think the documentation should definitely mention this
>>> limitation and give some guidance for the locking.
>>>
>>> Currently, from an API perspective, I can't see how anyone not 
>>> familiar with
>>> the implementation details would be able to recognize this limitation.
>>>
>>> In terms of the GPUVA manager, unfortunately, it seems like I need to 
>>> drop
>>> the maple tree and go back to using a rb-tree, since it seems there 
>>> is no
>>> sane way doing a worst-case pre-allocation that does not suffer from 
>>> this
>>> limitation.
>>
>> I haven't been paying much attention here (too many other things going
>> on), but something's wrong.
>>
>> First, you shouldn't need to preallocate.  Preallocation is only there
> 
> Unfortunately, I think we really have a case where we have to. Typically 
> GPU mappings are created in a dma-fence signalling critical path and 
> that is where such mappings need to be added to the maple tree. Hence, 
> we can't do any sleeping allocations there.
> 
>> for really gnarly cases.  The way this is *supposed* to work is that
>> the store walks down to the leaf, attempts to insert into that leaf
>> and tries to allocate new nodes with __GFP_NOWAIT.  If that fails,
>> it drops the spinlock, allocates with the gfp flags you've specified,
>> then rewalks the tree to retry the store, this time with allocated
>> nodes in its back pocket so that the store will succeed.
> 
> You are talking about mas_store_gfp() here, right? And I guess, if the 
> tree has changed while the spinlock was dropped and even more nodes are 
> needed it just retries until it succeeds?
> 
> But what about mas_preallocate()? What happens if the tree changed in 
> between mas_preallocate() and mas_store_prealloc()? Does the latter one 
> fall back to __GFP_NOWAIT in such a case? I guess not, since 
> mas_store_prealloc() has a void return type, and __GFP_NOWAIT could fail 
> as well.
mas_store_prealloc() will fallback to __GFP_NOWAIT and issue a warning.
If __GFP_NOWAIT allocation fails, BUG_ON() in mas_store_prealloc() will
be triggered.

> 
> So, how to use the internal spinlock for mas_preallocate() and 
> mas_store_prealloc() to ensure the tree can't change?
> 
