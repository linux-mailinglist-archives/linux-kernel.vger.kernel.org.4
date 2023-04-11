Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B0B6DD07D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDKDuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDKDuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:50:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE61BFC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:50:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso5150189pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681185002; x=1683777002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjEAid20/hS5TioSfuhZ2hRVRcGGbWFkXT5AztmUYLU=;
        b=LYKP57CzAcxQ5gab4YwR9v6vaxhR/4P+GionA8yCWLZ/9hlqmF6jK2Rc7Hkr+pYJ4k
         VXiDq5ZX5hi4on79vEZq0YxeTPOC7e3+GHpqMEQGRRqjd/zSf+X9k2tX9OYO0Nnc7Uqu
         1RusCPGRGIRm768m7eDnzYpfYH4RFQ1dLFZa//rUISjWoXkzVJWR/E6DmSvq+jgunVk0
         GlgTAFS9vuG8ltgVdj6Uplw53WEfZZRY9R6/w0AJoTurl+/cvfqFcOH7MZoaiSEGKgsQ
         unrBv6AgheR1VbEjJIccmEaHodDAELANBNqlpkS6ySpkAEfP43TmwlinKsO/rKzEUpYo
         a03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681185002; x=1683777002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CjEAid20/hS5TioSfuhZ2hRVRcGGbWFkXT5AztmUYLU=;
        b=Kb2ARKeq4d/Mpvok80rV183e9LVQhT0imjJa89TX+SMch6WFtsIglqBNPQOxeqU+OS
         D7SDZ+Z+nU7u6938AQpsz9LiVOMII8+a0tC78yMENpm2Lvg1M/XwuDQC6EI6WWEbeJ5e
         scEDODBfjfnCAaBE7RUyjYYcAeW6cTREOOCQ+C9EX6n32dDUEp0vTfk6KSEgU2w+zHf4
         39Bc584XNUvYp+mHYD7xpXGP+y+d5baJrlZqfRJMSJ9ztgVVXsGwBBTLSe4yMRqGcdZK
         2U5TNqJP6au4u1pOgML8Fz4hEiu1oiDV9cZL+2/gbwN89WqhOs8mBbLrqMFGQJnPfIUc
         PrSw==
X-Gm-Message-State: AAQBX9eHNsDuDZE+JzgogBldx2Am2YSTVt4viTPTWCZ9cbuOJaiL2vGC
        wnWhDorsFxwIXd7P4dxoWP59qQ==
X-Google-Smtp-Source: AKy350YTCKN8pXK1GPOoitNCP80wKJNKIMZKz3O+cK/gOeA1J9898z6qCW9KcqZVIWDDqcWSHJd/hg==
X-Received: by 2002:a17:90b:1644:b0:23f:7ff6:eb8 with SMTP id il4-20020a17090b164400b0023f7ff60eb8mr1994829pjb.31.1681185002391;
        Mon, 10 Apr 2023 20:50:02 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id t7-20020a6549c7000000b005136b93f8e9sm7579138pgs.14.2023.04.10.20.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 20:50:02 -0700 (PDT)
Message-ID: <f132db6d-5b5f-cf18-3e4e-2f3053c93033@bytedance.com>
Date:   Tue, 11 Apr 2023 11:49:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v2] maple_tree: Use correct variable type in sizeof
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, Liam.Howlett@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        David Binderman <dcb314@hotmail.com>, stable@vger.kernel.org
References: <20230411023513.15227-1-zhangpeng.00@bytedance.com>
 <20230410202935.d1abf62f386eefb1efa36ce4@linux-foundation.org>
 <ZDTXE8jKMz802jqR@casper.infradead.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZDTXE8jKMz802jqR@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/11 11:42, Matthew Wilcox 写道:
> On Mon, Apr 10, 2023 at 08:29:35PM -0700, Andrew Morton wrote:
>> On Tue, 11 Apr 2023 10:35:13 +0800 Peng Zhang <zhangpeng.00@bytedance.com> wrote:
>>
>>> The type of variable pointed to by pivs is unsigned long, but the type
>>> used in sizeof is a pointer type. Change it to unsigned long.
>> Thanks, but there's nothing in this changelog which explains why a
>> -stable backport is being proposed.  When fixing a bug, please always
>> describe the user-visible effects of that bug.
> There is no user-visible effect of this bug as the assembly code
> generated will be identical.

Therefore, if this has always been the case, cc stable
is also unnecessary.

>
>>> --- a/lib/maple_tree.c
>>> +++ b/lib/maple_tree.c
>>> @@ -3255,7 +3255,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
>>>   
>>>   		if (tmp < max_p)
>>>   			memset(pivs + tmp, 0,
>>> -			       sizeof(unsigned long *) * (max_p - tmp));
>>> +			       sizeof(unsigned long) * (max_p - tmp));
>>>   
>>>   		if (tmp < mt_slots[mt])
>>>   			memset(slots + tmp, 0, sizeof(void *) * (max_s - tmp));
>> Is there any situation in which
>> sizeof(unsigned long *) != sizeof(unsigned long)?
> Windows 64-bit (pointer 64-bit, unsigned long is 32 bit) is the only
> one I know.  Linux is all ILP32 or LP64.  There may be some embedded
> environments which are different, but I have no idea what they might be.
>
