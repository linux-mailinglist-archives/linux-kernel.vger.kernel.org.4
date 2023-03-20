Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ACE6C0EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCTKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCTKbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B86193D5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BgE1X4ekUlT0hc9XsprdaHvSq6/U0b4NczzgHQA4c5o=;
        b=HBH+LEJu5nKP2hQ5j/lmGhDU2oeg3EJx0Zl2minj/jmJrQAK2ZeeV5NsmMk0wcy5vZAAou
        /RLk7NiEE4gZtKXWVV8FqC+lBBRn5/0dsAJn2/gKrvrwpCA9EALMTJ22C88j2QFmHWkQjU
        jbd5Tz0MGWPQwCIhSgfOmKE3NYDvTDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-anFEHsY8M0OPGzaA2pwMFw-1; Mon, 20 Mar 2023 06:30:24 -0400
X-MC-Unique: anFEHsY8M0OPGzaA2pwMFw-1
Received: by mail-wr1-f71.google.com with SMTP id i25-20020adfaad9000000b002cff37de14fso1379702wrc.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308223;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgE1X4ekUlT0hc9XsprdaHvSq6/U0b4NczzgHQA4c5o=;
        b=F5oUio8H2MQavZvWUOQPFU6HhS2Rfvro1w1mZz/4roSOKD/rkuoqhTnu6wwXpTPenS
         bZSP1tQCy6j4IGOvh9ZkbMQRNLppkIcxQw6XzWH5shZue5SltZBDy2U+Jok2b3qNvxAk
         u/+V0wDztxe63KTSSWtmAN3n0AplrFilpGsNBpVhD3mSpgYbQ5Y0knsXBIgaUw5FlkNg
         i+k5SOSptjeYRdRkKNOMvrKLBP3xBKx9NRyPJaUPnm322k87O8u8+aro5TwYPf8WZDlC
         Yj/ekfjhGuSZ5RepDw5DNQBHTs/oVU5yLu5t07iPtz9Py7ZHpAdsB6p7YFQcdPSyA8e7
         5D8A==
X-Gm-Message-State: AO0yUKULHMV3W70gEux+ZvV8hKU6RUhX84zQZFBXUcn7aZtTjUp7/w+t
        hSFRzoVEPezEVI13VXuWfYAphiQKOmL6pJJeM8V16jGGkscVmYb+pF17JAbLEi4uoDRylOvptIi
        bWh+qESZz+NHuk3YdZ8rW8cGb
X-Received: by 2002:a5d:504c:0:b0:2cd:f2c6:5d37 with SMTP id h12-20020a5d504c000000b002cdf2c65d37mr12507923wrt.5.1679308223078;
        Mon, 20 Mar 2023 03:30:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set/fN142O0jmW4iqCLPXtEiyw9GviYWHg1q3pkSYIopaetrIf+KQV8h0TcW9SYuysz31BfdDJw==
X-Received: by 2002:a5d:504c:0:b0:2cd:f2c6:5d37 with SMTP id h12-20020a5d504c000000b002cdf2c65d37mr12507909wrt.5.1679308222659;
        Mon, 20 Mar 2023 03:30:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b002cfe0ab1246sm8565121wrt.20.2023.03.20.03.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:30:21 -0700 (PDT)
Message-ID: <8a461e44-7d24-5b5d-db04-e7fa85beeaa7@redhat.com>
Date:   Mon, 20 Mar 2023 11:30:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/15] mm/cma: move init_cma_reserved_pages() to cma.c and
 make it static
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 22:59, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> init_cma_reserved_pages() only used in cma.c, no point of having it in
> page_alloc.c.
> 
> Move init_cma_reserved_pages() to cma.c and make it static.

I guess the motivation is to avoid letting too many subsystems mess with 
pageblock migratetypes, managed pages, PG_reserved ...

So it kind of makes sense to have these low-level details out of common 
CMA code, no?

-- 
Thanks,

David / dhildenb

