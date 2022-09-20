Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1C5BE6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiITNWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiITNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB7C4D822
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663680163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAagr+5D/SDR0OvGsWzOAQR3yF3tO/raRhnWXj9RfQU=;
        b=Zi5tZqe0g9eHXPkjp0Bz9SBo84Cs39hiNRiQZe0adHFnVlUylTvIa9XXjc2wOdskGsr+yM
        38qB9Ioad01mMG/6+gcsYupk0EXambJQ9+nfEzho7U5t8NhTLdZO248zbpDMFOuKbomhky
        KOEb0cciFzURQ8GLUUNccrZ3p39SrzU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-G12eMV4rMYuF4AptX_XEgA-1; Tue, 20 Sep 2022 09:22:42 -0400
X-MC-Unique: G12eMV4rMYuF4AptX_XEgA-1
Received: by mail-wr1-f72.google.com with SMTP id d25-20020adf9b99000000b0022adb03aee6so1147861wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=HAagr+5D/SDR0OvGsWzOAQR3yF3tO/raRhnWXj9RfQU=;
        b=QurJ3GdapQTJhjWj2sfOYlWwyy0n5WRAnkGW/+QiFJZ8EghIVtL/PUsWDAL04Hr5cS
         XY95S6UKRpBYiK++Dv4TTzbvRkdEJjj4GvNRrK3a1wmU6UjVzqx9IlPPXXqdY2V343sd
         HIIfgjKjm7+YqlHBAWQJXUKLAw5If1qelDg7LUM118QosbtJ3TDpdbtsmNngFHu8RIFz
         JYVxePepTLU+rsu4K2McGBFDeW+95T7dy22y+YmgpZHsho/zuh4F8WU8s97VVUnmxwYI
         dpm5D49p4zI0NXeGnTa1nxUXqaAPXRaeXUSzPeyofoHKCMzbtDZsnYwxctRjciYrfCyM
         +WEQ==
X-Gm-Message-State: ACrzQf0glJwMdF953iOnGLLqbdcu6DdGkcNifadNrfBnJYHdHNJAOTjs
        YYH0BHJcQkXs+HMMTVJgTW9oCbDM5z0M8S9+70MBckIgDPF1/VaHjuliZj37TakALGWZDwrPVTp
        +XzD6jI0rKzbc8i8thLlPh3nv
X-Received: by 2002:a05:600c:4f56:b0:3b4:b6b0:42d4 with SMTP id m22-20020a05600c4f5600b003b4b6b042d4mr2395178wmq.143.1663680160829;
        Tue, 20 Sep 2022 06:22:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4uNmTszB+WUAb11KH7RULfuLObx/dVn5U7CXVqKDMewoWn5osuTwcZ84XnG0Qq7JUZG3l1Dw==
X-Received: by 2002:a05:600c:4f56:b0:3b4:b6b0:42d4 with SMTP id m22-20020a05600c4f5600b003b4b6b042d4mr2395155wmq.143.1663680160558;
        Tue, 20 Sep 2022 06:22:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:2300:e82d:5a58:4fd8:c1e6? (p200300cbc7122300e82d5a584fd8c1e6.dip0.t-ipconnect.de. [2003:cb:c712:2300:e82d:5a58:4fd8:c1e6])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4a91000000b00228dff8d975sm1606351wrq.109.2022.09.20.06.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:22:39 -0700 (PDT)
Message-ID: <7f1cfee4-c6de-ea59-0aa9-9bd55054fb22@redhat.com>
Date:   Tue, 20 Sep 2022 15:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/secretmem: remove reduntant return value
Content-Language: en-US
To:     xiujianfeng <xiujianfeng@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Binyi Han <dantengknight@gmail.com>
References: <20220920012205.246217-1-xiujianfeng@huawei.com>
 <3196b824-bcee-0c44-bfd3-f6cd8a1e6719@redhat.com>
 <c4e99ea3-302d-b173-27f1-92c38ddaca8c@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c4e99ea3-302d-b173-27f1-92c38ddaca8c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.22 14:35, xiujianfeng wrote:
> Hi,
> 
> 在 2022/9/20 20:10, David Hildenbrand 写道:
>> On 20.09.22 03:22, Xiu Jianfeng wrote:
>>> The return value @ret is always 0, so remove it and return 0 directly.
>>>
>>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>> ---
>>>    mm/secretmem.c | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/secretmem.c b/mm/secretmem.c
>>> index 6a44efb673b2..04c3ac9448a1 100644
>>> --- a/mm/secretmem.c
>>> +++ b/mm/secretmem.c
>>> @@ -278,10 +278,8 @@ static struct file_system_type secretmem_fs = {
>>>    static int __init secretmem_init(void)
>>>    {
>>> -    int ret = 0;
>>> -
>>>        if (!secretmem_enable)
>>> -        return ret;
>>> +        return 0;
>>>        secretmem_mnt = kern_mount(&secretmem_fs);
>>>        if (IS_ERR(secretmem_mnt))
>>
>> On top of which tree is that?
>>
>> 6.0-rc6 has here:
>>
>> if (IS_ERR(secretmem_mnt))
>>       ret = PTR_ERR(secretmem_mnt);
>>
> Sorry, it's on linux-next tree, I should have used [PATCH -next]:)
> 

Maybe this change should be squashed into the patch from Binyi directly:


commit 4eb5bbde3ccb710d3b85bfb13466612e56393369 (mm/mm-hotfixes-stable)
Author: Binyi Han <dantengknight@gmail.com>
Date:   Sun Sep 4 00:46:47 2022 -0700

     mm: fix dereferencing possible ERR_PTR
     
     Smatch checker complains that 'secretmem_mnt' dereferencing possible
     ERR_PTR().  Let the function return if 'secretmem_mnt' is ERR_PTR, to
     avoid deferencing it.
     
     Link: https://lkml.kernel.org/r/20220904074647.GA64291@cloud-MacBookPro
     Fixes: 1507f51255c9f ("mm: introduce memfd_secret system call to create "secret" memory areas")
     Signed-off-by: Binyi Han <dantengknight@gmail.com>
     Reviewed-by: Andrew Morton <akpm@linux-foudation.org>
     Cc: Mike Rapoport <rppt@kernel.org>
     Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
     Cc: Hagen Paul Pfeifer <hagen@jauu.net>
     Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
     Cc: <stable@vger.kernel.org>
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>


-- 
Thanks,

David / dhildenb

