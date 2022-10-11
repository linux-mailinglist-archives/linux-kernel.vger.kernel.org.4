Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E425FAF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiJKJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJKJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4822F5A825
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665480189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7I7VQ6hVchBULwDy9Ro8vnqtPorb7QB9wWs0IPouq+c=;
        b=WMZ4JKOCQHRYY3Od1kbz48SYIsQTvtaZItTcw0JTp5Yjp6W1rfMn0WD6J6jQokkbpEjDG0
        582P6h2SsgqmOlX2YXaoLZ+MKISU0ZhtDS0wDtE7P5ZxrIdy+R7Y7PnRDF2a3j0gIbNjUB
        2wuoav5WL5modBFF4OfstuM9XpaWwAI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-sns6aqcXNjGim0151BMJ4w-1; Tue, 11 Oct 2022 05:23:08 -0400
X-MC-Unique: sns6aqcXNjGim0151BMJ4w-1
Received: by mail-wr1-f69.google.com with SMTP id s30-20020adfa29e000000b002302b9671feso1630957wra.20
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7I7VQ6hVchBULwDy9Ro8vnqtPorb7QB9wWs0IPouq+c=;
        b=WlKMvi6NU2HTfnq4cYj3sUqU+zmh8I4WVV8nSK8Or0jXqurj4FNAV6HM2aYovFfmzD
         LKe7ur1ativ2syAUly4z5Hn40rswAe8HzPMIsl9wghZKBB80LmshuMJzR9yG5pwclY9c
         /xGGS6oCa5IZ4D37rh99WbEddR0KoKpucYP6Evwpt6ALCqFzZsTztYy4gjX97HKZ7WyI
         8WP1gjSSb38GXcO8+qBAV8cwb9OxhqXpqxk0XrdvHjlY4zhVnJMDS/YNEYq5n6O/3JKq
         P4WKCmU7s3QhuzmkEuiP9i6QOf/nJdqSfrssE7jUZJ5AyOKWFxn+0IIgeXGwa5cras7+
         d2DQ==
X-Gm-Message-State: ACrzQf0afPcWXStPDCoUO8WfqdwcuuHFjUcYYpIdGnfXYxEmJ56kSJ7R
        ueb3tu5oLqwxgGGo2+V7klwfqoXSWyZwSENsc/LdN22qi/KqDAcREvY+nKFXFgG0M5nbAtWfJyY
        ngWwzVIxjwokhGBJyClqPEoMK
X-Received: by 2002:a05:6000:1d94:b0:22e:34ef:b07f with SMTP id bk20-20020a0560001d9400b0022e34efb07fmr14488959wrb.272.1665480187118;
        Tue, 11 Oct 2022 02:23:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/v0oDIPLg4t3JtaZmER6DstrkRy6lzlCDSJhQvysmjbbliEW55qmefKyCt2f67xZNCfvhGA==
X-Received: by 2002:a05:6000:1d94:b0:22e:34ef:b07f with SMTP id bk20-20020a0560001d9400b0022e34efb07fmr14488943wrb.272.1665480186841;
        Tue, 11 Oct 2022 02:23:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6900:f110:6527:aa46:a922? (p200300cbc7096900f1106527aa46a922.dip0.t-ipconnect.de. [2003:cb:c709:6900:f110:6527:aa46:a922])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b003b7b36dcb8dsm17149070wmf.31.2022.10.11.02.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 02:23:06 -0700 (PDT)
Message-ID: <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
Date:   Tue, 11 Oct 2022 11:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
 <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
 <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
 <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
 <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Sounds to me that all you want is some notifier to be called from
>>>> adjust_managed_page_count(). What am I missing?
>>>
>>> Notifier will act as an accumulator to report size of change and it will make things easier for the drivers and users wrt locking.
>>> Notifier is similar to the memory hotplug notifier.
>>
>> Overall, I am not convinced that there is any value of separating the value
>> and the notifier. You can batch both or not batch both. In addition, as I
>> mentioned, having two values seems racy.
> 
> I have identified two users so far above - may be more to come.
> One type needs the value to adjust. Also having the value is necessary
> to report it to users and oom. There are options with callbacks and so
> on but it will complicate things with no real gain. You are right about
> the atomicity but i guess if that's a problem for some user it could
> find a way to ensure it. i am yet to find such place.
> 

I haven't followed the whole discussion, but I just wanted to raise that 
having a generic mechanism to notify on such changes could be valuable.

For example, virtio-mem also uses adjust_managed_page_count() and might 
sometimes not trigger memory hotplug notifiers when adding more memory 
(essentially, when it fake-adds memory part of an already added Linux 
memory block).

What might make sense is schedule some kind of deferred notification on 
adjust_managed_page_count() changes. This way, we could notify without 
caring about locking and would naturally batch notifications.

adjust_managed_page_count() users would not require changes.

-- 
Thanks,

David / dhildenb

