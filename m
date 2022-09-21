Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785025BFE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIUNEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiIUNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36496FDC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663765435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdHnV3VWEqsU153bSqOynZpQmdwwjdT8tHpP+AqIewQ=;
        b=AVXrwVvAEW/c/GQ3621xvpVfq2gEnFNmBFNvS1X+kxTaYS4lX9hEWL1NLNzXqkSJPoHGav
        tH8KUmretoT0fuL/fGE5Klm+yYpoMkxYzF/XR0NmhdLRJ32uFFt3ETM0kl8vVimJbJJPlW
        VL4NQoB5wnANynreLzznZkR0g4Mm2Jg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-JGoMYXEePFystkk_Gx9ukg-1; Wed, 21 Sep 2022 09:03:54 -0400
X-MC-Unique: JGoMYXEePFystkk_Gx9ukg-1
Received: by mail-wr1-f71.google.com with SMTP id h20-20020adfaa94000000b0022af8c26b72so2354083wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=gdHnV3VWEqsU153bSqOynZpQmdwwjdT8tHpP+AqIewQ=;
        b=pbvQppTgi42THmXH/Vbo3dwhgEJSXI4+bpxZKrZRPJSHYQhCafnBnn7lfbrIojwmRk
         2O+ukOpOmFJm7mjcWJ2V3clNWn9nXnSG0mEUx6t8oIWj8rql3lE95FiDIrRkhwJkrhkJ
         /BKVyeAkXkafAJ37Uk0mL/ENHQGR3TUlui7MdXNPxUU4n+G1t081hUo3QgN4cPmc2Gz0
         lcCm8xPNFx7mOsIbrVIPrMaN5eVe8YsSwjtD3c8q/1ZgBWSSpdmEM8GOJWgL6ug6+Z5k
         FYQweEPWSy5IuaZC4WOW6PBG40i6TIchQiJYjJKOePo9WiieIeqXyUjqRzjrQqx0JVAP
         ivuA==
X-Gm-Message-State: ACrzQf2wZNfQIFGMWXIg9V1l7supPn6VldTgnMeO1OeVdhGZ+zSuO1Y1
        wIQUXWFYcguJ6j5bSPg2uGSLry15B/9utQhRZbqfFLQuflhoZ1HSJS5Wq8HIRHh8GIsewOJFQkc
        WUdsJqyQA202cW7vZEJGWE05G
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr17774990wrz.371.1663765432922;
        Wed, 21 Sep 2022 06:03:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4lMc4LT+3VySvRgJ/Fc31nBF9lBFT9H6ehTnnnf0ivjSkxi9SR6r+BJZ3x5kMq2M7Gjhw1UQ==
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr17774956wrz.371.1663765432534;
        Wed, 21 Sep 2022 06:03:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:6900:26b8:85a4:a645:4128? (p200300cbc703690026b885a4a6454128.dip0.t-ipconnect.de. [2003:cb:c703:6900:26b8:85a4:a645:4128])
        by smtp.gmail.com with ESMTPSA id p25-20020a7bcc99000000b003b476bb2624sm2812131wma.6.2022.09.21.06.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 06:03:51 -0700 (PDT)
Message-ID: <9f649899-d227-6dff-2ada-aaac81b50879@redhat.com>
Date:   Wed, 21 Sep 2022 15:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v1 2/3] powerpc/prom_init: drop PROM_BUG()
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220920122302.99195-1-david@redhat.com>
 <20220920122302.99195-3-david@redhat.com> <877d1w2844.fsf@mpe.ellerman.id.au>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <877d1w2844.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.22 15:02, Michael Ellerman wrote:
> David Hildenbrand <david@redhat.com> writes:
>> Unused, let's drop it.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/powerpc/kernel/prom_init.c | 6 ------
>>   1 file changed, 6 deletions(-)
> 
> Thanks. I'll take this one via the powerpc tree, and the others can go
> via wherever?

Makes sense; I'll drop this patch in case I have to resend, assuming 
it's in your tree.

Thanks!

-- 
Thanks,

David / dhildenb

