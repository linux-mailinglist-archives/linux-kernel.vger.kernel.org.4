Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925C5EF13B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiI2JEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiI2JEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968463B6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664442271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaVCDSxgfFbbhpN7t2ZlL2MHraJNJaYgGTscSpeG8bI=;
        b=US4nReiV1pPxXhkJ58Cyl9ogbWYhGeHqHGDHYJS8XueIdDgSpTqYgTqXgA+dH6Xpz4cPM4
        r/N+PoL6z7mfaaQFysO6ue4oXlXBuvdf4tdxnrEa+OflRcWQoyGfkVnXWtR0Hogt9dEuA3
        OJeIARdmlc81trDJcCI5dXkOY7PlRCs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-rJghX7pKMzyF_yCPwTLEGg-1; Thu, 29 Sep 2022 05:04:29 -0400
X-MC-Unique: rJghX7pKMzyF_yCPwTLEGg-1
Received: by mail-wr1-f69.google.com with SMTP id k30-20020adfb35e000000b0022cc5ecd872so268580wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ZaVCDSxgfFbbhpN7t2ZlL2MHraJNJaYgGTscSpeG8bI=;
        b=YluM1JDp3dTpB9MKTXAWJMfIGUQcU5HCN2MCHgcVgKJZOpcA6S+WN/VmGfq/Yy/W0K
         UeejnTjhmPIB0CZLU9TfHxhxs6EPQYvEhZdqQhIvsGPeqs5FL4y8IKE/V58JOHpU3edK
         eby3lr9ujnSBxbc6wzKzUBQZ4fFTuvo72EJYDg8+bHPazEosZKuZ3S3e9abf8vA7CVFf
         Zh8D99K9lmpazKHTBwLv47q8wmo5C+lNzk9LGIHHhAmHd9IKQ6AL8MfY6FZw5MmMJ/7p
         3Fl3byO2xwR0DryXl1cLvW6tSK6vmsFDDb4zc6L8MsLZ60Yj+6etVo7oQklyn7sPIH2g
         TJhA==
X-Gm-Message-State: ACrzQf1TVoKZk4ms+8gD2615uzR0WIwdSiUyUYZ3AaucLeDmV6F8BkZ7
        m6S+YKkLcqGiDfpTugmT5uasFlvQq9vSKHVlD5/xamBlnzjuPgVZH+/EQAUeHlPlWWu7GO+0ziT
        HkZd5h0qmVG+/pj8Se+T/yuRt
X-Received: by 2002:a5d:64c7:0:b0:22a:6a2e:c4f1 with SMTP id f7-20020a5d64c7000000b0022a6a2ec4f1mr1355208wri.269.1664442268808;
        Thu, 29 Sep 2022 02:04:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7j7YGY9YexIU4PweeHwyH1XB9hyrfcXMb0si62fL6a+YKhLNI6oZjfmmbQ55PFKBuyPXRTBw==
X-Received: by 2002:a5d:64c7:0:b0:22a:6a2e:c4f1 with SMTP id f7-20020a5d64c7000000b0022a6a2ec4f1mr1355187wri.269.1664442268525;
        Thu, 29 Sep 2022 02:04:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4ec2000000b00228d67db06esm6063780wrv.21.2022.09.29.02.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:04:28 -0700 (PDT)
Message-ID: <975cd79d-b211-c10b-4e25-d7b7203c0109@redhat.com>
Date:   Thu, 29 Sep 2022 11:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next v4 1/3] selftests/memory-hotplug: Add checking after
 online or offline
Content-Language: en-US
To:     zhaogongyi <zhaogongyi@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "shuah@kernel.org" <shuah@kernel.org>
References: <f16e94ec925747f3954d34aa4bd0c355@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f16e94ec925747f3954d34aa4bd0c355@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 09:39, zhaogongyi wrote:
> Hi,
> 
> We can not get the EBUSY from " echo 0 > /sys/devices/system/memory/memoryxxx/online", maybe, redirect the error ouput to /dev/null is suitable when calling offline_memory_expect_success():
> 
> # sh mem-on-off-test.sh -a
> mem-on-off-test.sh: illegal option -- a
> Test scope: 2% hotplug memory
>           online all hot-pluggable memory in offline state:
>                   SKIPPED - no hot-pluggable memory in offline state
>           offline 2% hot-pluggable memory in online state
>           trying to offline 4 out of 192 memory block(s):
> online->offline memory0
> online->offline memory10
> online->offline memory100
> online->offline memory101
> online->offline memory102
> online->offline memory103
> online->offline memory104
> online->offline memory105
> online->offline memory106
> online->offline memory107
> online->offline memory108
> online->offline memory109
> online->offline memory11
> online->offline memory110
> online->offline memory111
> online->offline memory112
> online->offline memory113
> online->offline memory114
> online->offline memory115
> online->offline memory116
> online->offline memory117
> online->offline memory118
> online->offline memory119
> online->offline memory12
> online->offline memory120
> online->offline memory121
> online->offline memory122
> online->offline memory123
> online->offline memory124

Can we have here an output like

online->offline memory0
-> Failure
online->offline memory10
-> Success

That would make much more sense for debugging purposes and understanding 
what is happening here. I was primarily concerned about the misleading 
error message, that indicated that something is "unexpected" -- it's 
perfectly reasonable here to *expect* that offlining a random memory 
blocks just fails.

-- 
Thanks,

David / dhildenb

