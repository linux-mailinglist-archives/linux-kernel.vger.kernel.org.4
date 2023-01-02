Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1698765B29A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjABNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjABNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B9634E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672665750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5JT1kd37IuRGEL37nkEW4w2qEUZx756Pop0OedkJgo=;
        b=AMkFOpSv6jDdI0TFSZ7XpRcRTaKPc1WvXwkfH61CR1WvVQQ8ucFBk1rM2RCVdS7+B4Z0jQ
        r8EQvZ4XybjJSZ9lgfw6nosbTUzRZvVVHaOb/8tD2qqU2HD/gzAaU2/rpfg9sBPh+dR8Sj
        8dd4GrVI1UkWRY3J1XxTIcP/WAU++9w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-lLlG-KwyO7WNKUm-7wN3ZQ-1; Mon, 02 Jan 2023 08:22:29 -0500
X-MC-Unique: lLlG-KwyO7WNKUm-7wN3ZQ-1
Received: by mail-wm1-f72.google.com with SMTP id l17-20020a05600c1d1100b003d9a145366cso4943599wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 05:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5JT1kd37IuRGEL37nkEW4w2qEUZx756Pop0OedkJgo=;
        b=zveQM29+OwSISaV0gZERPCZOcED6VK67vTqkP5+wDF6kwnlV943zZZG4bctWDzkjLi
         ywEWWNqlGOHhGebZM1XzgWtBBudcxq/ZHHsFHbu8lCgOLZA1QpPetKpzkcnxZOBdl5pC
         cm986Su6vOqoFa9qW+ocggTm99ldIfXjtJh5qaXyB4EPSXW9XmKmvc2DKYKEJ/gjIIRL
         6BX+oVMcQ5kMDp+Hp/IAYzJxcMU11NJ4VyMYJjqUWvFa1nWM0Ij/Rum/yFA/HDPIegkv
         gpnZh13yC9Kg+bo/Ab/t34Zfpuupwq6VCBzdfmV7F8FEavOViyRu24SDHpsPR62ZFuda
         31zA==
X-Gm-Message-State: AFqh2krvlMcJQoSfpNLpODtw/jlmNMVXOZ+6azo90nbyzTlrHTFsaLrx
        3Q3nG2M09i0In5XaZ4FUVRhJLfEOBgXt27CYKHbBUjkSTa9LKqlFMMeKkZHnDpVqeAaXL0A8Mgh
        2sNx63MHYwQmidjxIUUzCh4uQ
X-Received: by 2002:a05:600c:3b29:b0:3cf:d18e:528b with SMTP id m41-20020a05600c3b2900b003cfd18e528bmr29332208wms.39.1672665747832;
        Mon, 02 Jan 2023 05:22:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt1MMvvBh79Ous21PvG7yDllmYOOsPELrmqqGxs09MXsS8a6IvY3cauQUjOIhzB4QrCR3A1cg==
X-Received: by 2002:a05:600c:3b29:b0:3cf:d18e:528b with SMTP id m41-20020a05600c3b2900b003cfd18e528bmr29332197wms.39.1672665747575;
        Mon, 02 Jan 2023 05:22:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c5453000000b003d2157627a8sm42233921wmi.47.2023.01.02.05.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 05:22:27 -0800 (PST)
Message-ID: <d13ea810-e9a8-2741-11ce-5e20f1ba0334@redhat.com>
Date:   Mon, 2 Jan 2023 14:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/4] return EINVAL for illegal user memory range
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com,
        clameter@sgi.com
References: <20221205034108.3365182-1-mawupeng1@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221205034108.3365182-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.22 04:41, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
> The return value of mlock is zero. But nothing will be locked since the
> len in do_mlock overflows to zero due to the following code in mlock:
> 
>    len = PAGE_ALIGN(len + (offset_in_page(start)));
> 
> However this problem appear in multiple syscalls.
> 
> Since TASK_SIZE is the maximum user space address. The start or len of
> mlock shouldn't be bigger than this. Function access_ok can be used to
> check this issue, so return -EINVAL if bigger.

I assume this makes sure that what we document holds:

EINVAL (mlock(),  mlock2(),  and  munlock()) The result of the addition
	addr+len was less than addr (e.g., the addition may have
	resulted in an overflow).

So instead of adding access_ok() checks, wouldn't be the right think to 
do checking for overflows?


-- 
Thanks,

David / dhildenb

