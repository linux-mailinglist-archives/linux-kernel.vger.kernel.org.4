Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2875B37AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiIIMVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiIIMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59297330A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662725921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1UePzLOz1wZO53Q7qIAQAN+1mLe/XFxJBDYGz76QS8=;
        b=F6ZTWvHAekDdVLBwbZre/TVWwSHle09Cya5bgGFG+7fcSLe4QMUBU2nKJxlL7mj2mUikir
        OQnK0SAvN7nBP3vtTIaXv0SVIq6BsWSI2BBuW+1e4ktA5T+L2u1ooBtbWJ5vLhraciTTqA
        rAa4Z+J2PBCrJ4R2oeg8Q8qv/UMjKNM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-7s3GVRWgPBWcgy3KcjPX1g-1; Fri, 09 Sep 2022 08:18:40 -0400
X-MC-Unique: 7s3GVRWgPBWcgy3KcjPX1g-1
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1c6a07000000b003a60ede816cso460809wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=C1UePzLOz1wZO53Q7qIAQAN+1mLe/XFxJBDYGz76QS8=;
        b=kAbBmD66YIurY8R5R3Soo+6tODFSFd+GvVB2g6m3QT5e9vdFy4BnQxurPt/8UlBhQ/
         fKxRg/9Pu69vcKb3fjKwZ8HUfTUKewg2RUuk80hZqU3HTbypl0UIEANURUbDwktPwNFW
         3hIIeX6Tki2EqytDtPg54fV8N8kceGqfguyNsqqYCzkYrFbbqb+y+xWGyx0dfUz9NDgY
         AvYwIuRaSUZ85lBJrc4qyD9ML9I7RZmCsHfdAa8yhKBUQJJOdRSFCqfgdthZ7t1z+/8D
         ty6vQbRxYnSbds1Z0w3r6kvHjbn2F7kcL5o0qy17YeFa3ruF5ce66t7hI7XUKPvB0WYw
         xVXg==
X-Gm-Message-State: ACgBeo1C+K3Q1rHbXC13LGaQeiJKFQ+xXVHHvCcNrGn6nB9i3a9vKD/P
        JhjxoYpVmOtoMkqu5E/ks5TeEHNK1tG42lq/afrUrr8L4Rd0B1sy+TBKRULgW0iztgsr9GabwNg
        vT7NACnJQNkxQGFw8yg5Zf5I/
X-Received: by 2002:adf:aad8:0:b0:228:da00:72ed with SMTP id i24-20020adfaad8000000b00228da0072edmr7790408wrc.483.1662725919599;
        Fri, 09 Sep 2022 05:18:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5tMHThzhDM9UmbRu652GEnmckUCr5U/s1IUwwqCuZv5g0XbC/1Nbh7KIdE4A7S+yBwuQn5xQ==
X-Received: by 2002:adf:aad8:0:b0:228:da00:72ed with SMTP id i24-20020adfaad8000000b00228da0072edmr7790394wrc.483.1662725919361;
        Fri, 09 Sep 2022 05:18:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id bg35-20020a05600c3ca300b003a5c1e916c8sm1711870wmb.1.2022.09.09.05.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 05:18:38 -0700 (PDT)
Message-ID: <8b36d6dd-5973-e9c3-0a5d-2521753d04bd@redhat.com>
Date:   Fri, 9 Sep 2022 14:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 5/5] docs: notifier-error-inject: Correct test's
 name
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220909075200.198363-1-zhaogongyi@huawei.com>
 <20220909075200.198363-6-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909075200.198363-6-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 09:52, Zhao Gongyi wrote:
> Correct test's name for mem-on-off-test.sh/cpu-on-off-test.sh.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   Documentation/fault-injection/notifier-error-inject.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fault-injection/notifier-error-inject.rst b/Documentation/fault-injection/notifier-error-inject.rst
> index 0e2790122166..170c583eb5bc 100644
> --- a/Documentation/fault-injection/notifier-error-inject.rst
> +++ b/Documentation/fault-injection/notifier-error-inject.rst
> @@ -95,8 +95,8 @@ For more usage examples
>   There are tools/testing/selftests using the notifier error injection features
>   for CPU and memory notifiers.
> 
> - * tools/testing/selftests/cpu-hotplug/on-off-test.sh
> - * tools/testing/selftests/memory-hotplug/on-off-test.sh
> + * tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> + * tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> 
>   These scripts first do simple online and offline tests and then do fault
>   injection tests if notifier error injection module is available.
> --
> 2.17.1
> 
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

