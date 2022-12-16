Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3264E7B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLPH3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLPH3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:29:00 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5681128704
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:28:59 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 36so1193766pgp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk0u/fsK//K35bE+fJDRok4VI4cGX4B4sl0r4z8VDaE=;
        b=OiZdvo74yyMj5/p+qzZgj3Tp0fBmxhvS1lowJ+DUyKYoXeAJjZ4FdYFP+Fx0z6bQdC
         c9asdLRTYXcvhciX5jOAhoe5HbQR78qNqOcaddCYDb9waECuNoFRQQdDjzbUcyql35PU
         Ynffjdta9Swo44sB9GANXSaOi7MhNdXWMb8xDXiBvRbE9LLTE+EK7d6tsn4q9sKI/qog
         FarxZ3WyJ3cMT1buEs9dmqwrQfxhgIYY990/H1UGSzeDkfqlkeXqv6yDU1K3O3uCXZhE
         h4jXIEwTC2vrdlpWp5kzuXmGAvRiyE3tXdH6c+QYFiiqucpRp5GIuBByZitIVHQEGabe
         3Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xk0u/fsK//K35bE+fJDRok4VI4cGX4B4sl0r4z8VDaE=;
        b=JL44hjy6ic6QzOkTwufEuDYzrjiP1b2f2kVlqdD6kN3VzMY0gfD1xUPMrvq+EgRafa
         9PSvAP+2XOF/B/0dwn5NFXjrlO9iPTdW4Vea+btengdqYnGQQKv7FkrpW4XoSWwNfPwd
         Cm1LGHHoaJIS0wGHUuwBChZLlgtLqTEBUB84GvPOeUPb+ajbfi9VxpQ//FxqBBdImyY0
         yI35WzaxaeLxF9m/URq9NROVCRX4QdjTLLfj4NoRk2Y+aqXEjx7fbpU6f7XbqMcKkyCP
         pscMs/TaxklmZqMxEbEllz/IWN4eW8becTQyHreSBkmLDA2MFvOHsrUfBjPfeM4KFbwc
         7fKA==
X-Gm-Message-State: ANoB5pnN/CAU2luimvykG/QXKIQvQWYwnbcw58zYNVF50LRj/73QvAOS
        Gv/uSdAv/HSbzsi4KD2YP3/o1w==
X-Google-Smtp-Source: AA0mqf7womHwruX+p5ZggubQKq4gsXElIqAdSFAChs5yASYITGqYogrKU6vzzzwmXGnLuxcqz0OFKQ==
X-Received: by 2002:a05:6a00:188b:b0:576:9eed:61de with SMTP id x11-20020a056a00188b00b005769eed61demr42376468pfh.4.1671175738671;
        Thu, 15 Dec 2022 23:28:58 -0800 (PST)
Received: from [10.54.29.146] ([143.92.118.2])
        by smtp.gmail.com with ESMTPSA id e14-20020aa7980e000000b00575fbe1cf2esm786845pfl.109.2022.12.15.23.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 23:28:58 -0800 (PST)
Message-ID: <13c73151-4b28-4324-afd5-8b84b82bc25d@shopee.com>
Date:   Fri, 16 Dec 2022 15:28:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/memcontrol: Skip root memcg in memcg_memory_event_mm
To:     Shakeel Butt <shakeelb@google.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, hannes@cmpxchg.org, vbabka@suse.cz,
        willy@infradead.org, vasily.averin@linux.dev,
        linux-kernel@vger.kernel.org
References: <20221215091907.763801-1-haifeng.xu@shopee.com>
 <20221215181803.ome46pkh6g7qu3t4@google.com>
 <abec13da-c74a-0fd8-74e0-3cdc547e4e08@shopee.com>
 <20221216064210.krxtxebuwc7dijzu@google.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20221216064210.krxtxebuwc7dijzu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/16 14:42, Shakeel Butt wrote:
> On Fri, Dec 16, 2022 at 09:43:02AM +0800, Haifeng Xu wrote:
>>
>>
>> On 2022/12/16 02:18, Shakeel Butt wrote:
>>> On Thu, Dec 15, 2022 at 09:19:07AM +0000, Haifeng Xu wrote:
>>>> The memory events aren't supported on root cgroup, so there is no need
>>>> to account MEMCG_OOM_KILL on root memcg.
>>>>
>>>
>>> Can you explain the scenario where this is happening and causing issue
>>> for you?
>>>
>> If the victim selected by oom killer belongs to root memcg, memcg_memory_event_mm
>> still counts the MEMCG_OOM_KILL event. This behavior is meaningless because the
>> flag of events/events.local in memory_files is CFTYPE_NOT_ON_ROOT. The root memcg
>> does not count any memory event.
>>
> 
> What about v1's memory.oom_control?
>
 
The memory.oom_control doesn't set the CFTYPE_NOT_ON_ROOT flag. But oom_kill_disable or
under_oom actually only support non-root memcg, so the memory_events should be consistent
with them.
