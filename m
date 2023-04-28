Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB056F1C86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjD1QXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD1QXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB572D7E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682698974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5K4ARAhOOiRTcUnbwJ8VJPbjQz5YAKb5+trHL5nUKd0=;
        b=ObuRqObgXgOVFlL7A/kSZufHAopure874C1PfSs38eVS++LAf+6B6tnIwzseC88cG8aD3/
        fkwJl9UvG5oz4T1kTuzpWSv05pai3uAKbMsYx5LpaHcxaxZSTVU/zyajBGlDWSUwOXMEj3
        0nWu3bN2Qyp/wTnq7+wKRN3oE7cBrAA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-1yLslAZoNEumBKAD-fTPtw-1; Fri, 28 Apr 2023 12:22:49 -0400
X-MC-Unique: 1yLslAZoNEumBKAD-fTPtw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2ff4bc7a770so5702856f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682698961; x=1685290961;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5K4ARAhOOiRTcUnbwJ8VJPbjQz5YAKb5+trHL5nUKd0=;
        b=VHzHOlcAXr4q+WXcX4r0BKgSDxQJmjuml1I7oZkwl6cDLklHF5y41k0UXZ4QllS05Q
         pO3TLPz9Nc+U/UqyhgO6PnV207hIYh8w7D7rqEiYZgvfMyBAOVmx8Yqv6wZ1lwublOuI
         dqEbql+MKhdNlI+yiwSRRhkWYlqzez7ABHNvZxxFyABCsNv92eELEJ1XdTPhdltSQ8GN
         Ccl1tBYXmSayyoKp3rQKZN3n1wE2v/6TAEIr/ZViQTlV0UPWqbsOwbOQHGTqaWvpL6pn
         MjXZ2eIybC4xhIh/haVzPe53W6x+Em5leMzkcygx6gOk5RRW6Qax1rHbFGi3EiofvqMX
         80uw==
X-Gm-Message-State: AC+VfDyEHukK+pEgcsGOTvzn1m7ASVE2jraEgViNio1JDuz/ct2ZTaUi
        DhzfkYK+lpnX7kEFwwCyyLEmDklS93hzmF7BVxxeAiS8kxdlWhc44d8I33+PlSpbWjgV2+yoKAY
        b9Qmo36GHcX2haf9h2OQdO9Ib0KLTOss5LWc=
X-Received: by 2002:adf:ef4b:0:b0:2f8:67ee:5ca9 with SMTP id c11-20020adfef4b000000b002f867ee5ca9mr4208781wrp.65.1682698961000;
        Fri, 28 Apr 2023 09:22:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43Rl4tXvzBBvpqgo4Fb/PVe0WSmiiHiCpX2MaTeQhfCE6El86qMQCH/mKfK2B9bSwCdYDLTA==
X-Received: by 2002:adf:ef4b:0:b0:2f8:67ee:5ca9 with SMTP id c11-20020adfef4b000000b002f867ee5ca9mr4208757wrp.65.1682698960622;
        Fri, 28 Apr 2023 09:22:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:9300:1711:356:6550:7502? (p200300cbc72693001711035665507502.dip0.t-ipconnect.de. [2003:cb:c726:9300:1711:356:6550:7502])
        by smtp.gmail.com with ESMTPSA id b1-20020adfee81000000b002ca864b807csm21720280wro.0.2023.04.28.09.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 09:22:39 -0700 (PDT)
Message-ID: <ae2e301d-21ae-bf25-57b5-b9be9777bfe2@redhat.com>
Date:   Fri, 28 Apr 2023 18:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/memory_hotplug: fix dead loop in offline_pages()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Yajun Deng <yajun.deng@linux.dev>
Cc:     osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230428100846.95535-1-yajun.deng@linux.dev>
 <ZEuo8PiA3EzVnrEi@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZEuo8PiA3EzVnrEi@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.23 13:07, Michal Hocko wrote:
> On Fri 28-04-23 18:08:46, Yajun Deng wrote:
>> When migration failure in do_migrate_range() and then the
>> scan_movable_pages() will most likely return the same movable pfn.
>> In this case, there is no condition to bail out, they will
>> always run like this:
>>
>> ...
>> [878020.623959] migrating pfn 1727813 failed ret:1
>> [878020.623960] page:00000000faa9673c refcount:3 mapcount:0 mapping:00000000144ccd79 index:0x14280025 pfn:0x1727813
>> [878020.623962] memcg:ffffa0ff82d5a000
>> [878020.623962] aops:def_blk_aops ino:fd00001
>> [878020.623964] flags: 0x17ffffc000206a(referenced|dirty|active|workingset|private|node=0|zone=2|lastcpupid=0x1fffff)
>> [878020.623966] raw: 0017ffffc000206a ffffb0d14f50fbd8 ffffb0d14f50fbd8 ffffa0ff9c155018
>> [878020.623967] raw: 0000000014280025 ffffa10327d702d8 00000003ffffffff ffffa0ff82d5a000
>> [878020.623968] page dumped because: migration failure
>> [878020.626196] migrating pfn 1727813 failed ret:1
>> [878020.626198] page:00000000faa9673c refcount:3 mapcount:0 mapping:00000000144ccd79 index:0x14280025 pfn:0x1727813
>> [878020.626200] memcg:ffffa0ff82d5a000
>> [878020.626200] aops:def_blk_aops ino:fd00001
>> [878020.626202] flags: 0x17ffffc000206a(referenced|dirty|active|workingset|private|node=0|zone=2|lastcpupid=0x1fffff)
>> [878020.626204] raw: 0017ffffc000206a ffffb0d14f50fbd8 ffffb0d14f50fbd8 ffffa0ff9c155018
>> [878020.626205] raw: 0000000014280025 ffffa10327d702d8 00000003ffffffff ffffa0ff82d5a000
>> [878020.626206] page dumped because: migration failure
>> ...
>>
>> Bail out when migration failures reach 3 times.
>>
>> Fixes: bb8965bd82fd ("mm, memory_hotplug: deobfuscate migration part of offlining")
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> 
> Any hard coded failure retry limit will lead to premature failures. Have
> a look at 72b39cfc4d75 ("mm, memory_hotplug: do not fail offlining too
> early"). A proper way to deal with this is to implement termination from
> the userspace (e.g. timeout $TIMEOUT /bin/echo 0 > $PATH_TO_MEM/online)
> Nacked-by: Michal Hocko <mhocko@suse.com>

Agreed; it's a bit more complicated when offlining is triggered by ACPI 
code :(

-- 
Thanks,

David / dhildenb

