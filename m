Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C408B73FCDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjF0N30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF0N3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E43173C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687872515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1F41av8+wMhP4CJ1H0298QHpYv8u0abzMXHMFh7Es0=;
        b=J1eGt9vsxQfpRlDo39mHGATV3GFY3TboA9fpFhV72OXxr7IOONeFjpbNNPSG6RW1I37nI8
        dObur1dDws5hWT6U+V3dU7hW4Qta15iymt1mSNC2D8RSfx2k2Y9wc3heMoLeRU0Z3n500R
        aqlUS3PsqezlcucJX3HfMyMctZifMzk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-hAsKPPtON86oNMrJz9gPOg-1; Tue, 27 Jun 2023 09:28:32 -0400
X-MC-Unique: hAsKPPtON86oNMrJz9gPOg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso2758234f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872511; x=1690464511;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1F41av8+wMhP4CJ1H0298QHpYv8u0abzMXHMFh7Es0=;
        b=KFRBXQqXVUtk99JFRV5LVVb22Ksk0fuhxz9KflbGYADE9WFqp2sa55V4Vv3xaGFjZU
         dOvGj7q9ogA1xBX2JG68fZE5brKRyJHkmg63oJs2DLOhC/9P4Qp6kiAi/H9bYJlV/T+i
         2inq2olwHKzHT1t+pQLJ2ZQzJDesV++vkYSRQrgIy2oZbWc0kC6BF0coTclTCkuvpKR9
         tdJsfa02KjMa3QkOphTe4ld/XTPEn8pOsLmQPoBkaQhzUSXNaca9oPEbzeUSx60nlnwn
         f5FVq3btV8POyYyJQsv5mYIE0JNEpOguBQXeKptDJoD1tO41S9JCDYiOGqG4zGlLtFB8
         GPtg==
X-Gm-Message-State: AC+VfDzhqmWI21ewfsk2KHH+36yE6BQZgN3bH8AFaEDFJqI9k3GSRkIh
        EkF84DCgyfUx4fGXOwtEpE/O9yZ90gLOClnEusyJDO5lOqnyWk591bNn78XVHnN8DqQxSjuCkam
        yIA0apsGCseA5XNq5+pCl/efR
X-Received: by 2002:a5d:6506:0:b0:313:e953:65d0 with SMTP id x6-20020a5d6506000000b00313e95365d0mr6912947wru.28.1687872511318;
        Tue, 27 Jun 2023 06:28:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rGglwsM0YLmdqMWWa4kXaIrL7nG7zLUTkixpcS0gxe239QLF5miJkniLyx0Nc3/UTwb99bQ==
X-Received: by 2002:a5d:6506:0:b0:313:e953:65d0 with SMTP id x6-20020a5d6506000000b00313e95365d0mr6912926wru.28.1687872510925;
        Tue, 27 Jun 2023 06:28:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b? (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de. [2003:cb:c737:4900:68b3:e93b:e07a:558b])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6e85000000b003063a92bbf5sm10524234wrz.70.2023.06.27.06.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:28:30 -0700 (PDT)
Message-ID: <d44b7a42-f89d-5bd5-9f29-e8643f6ee17d@redhat.com>
Date:   Tue, 27 Jun 2023 15:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-2-david@redhat.com> <ZJrXcaGE6gCrmLqg@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/5] mm/memory_hotplug: check for fatal signals only in
 offline_pages()
In-Reply-To: <ZJrXcaGE6gCrmLqg@dhcp22.suse.cz>
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

On 27.06.23 14:34, Michal Hocko wrote:
> On Tue 27-06-23 13:22:16, David Hildenbrand wrote:
>> Let's check for fatal signals only. That looks cleaner and still keeps
>> the documented use case for manual user-space triggered memory offlining
>> working. From Documentation/admin-guide/mm/memory-hotplug.rst:
>>
>> 	% timeout $TIMEOUT offline_block | failure_handling
>>
>> In fact, we even document there: "the offlining context can be terminated
>> by sending a fatal signal".
> 
> We should be fixing documentation instead. This could break users who do
> have a SIGALRM signal hander installed.

You mean because timeout will send a SIGALRM, which is not considered 
fatal in case a signal handler is installed?

At least the "traditional" tools I am aware of don't set a timeout at 
all (crossing fingers that they never end up stuck):
* chmem
* QEMU guest agent
* powerpc-utils

libdaxctl also doesn't seem to implement an easy-to-spot timeout for 
memory offlining, but it also doesn't configure SIGALRM.


Of course, that doesn't mean that there isn't somewhere a program that 
does that; I merely assume that it would be pretty unlikely to find such 
a program.

But no strong opinion: we can also keep it like that, update the doc and 
add a comment why this one here is different than most other signal 
backoff checks.


Thanks!

-- 
Cheers,

David / dhildenb

