Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9B5FEE4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJNNBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJNNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5661BE1CC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665752473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaldHj1fWL0JB8uDShPZGUz9Hou91o0Rg4EAQ11LSaw=;
        b=gJDgn0OqF0/I9/ibpHSHmJLiL6bnnR4s8yU3HAZ3cPocchRukfIOzMnkt1ZJ94F2AhEa8z
        TMUpsOAhAKOnXfWZ2JMtihxrtdn1ZnB8K1tiz4HbvV1esbTH9IIx7QS/CyJxafJ+o8DIsi
        TS7cEKXpCvLClidg5cxTBwGtC8DGKbQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-_mLT8bZ4NLWJYHGcw7TIhg-1; Fri, 14 Oct 2022 09:01:12 -0400
X-MC-Unique: _mLT8bZ4NLWJYHGcw7TIhg-1
Received: by mail-wr1-f70.google.com with SMTP id o13-20020adfa10d000000b00232c00377a0so921440wro.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaldHj1fWL0JB8uDShPZGUz9Hou91o0Rg4EAQ11LSaw=;
        b=mX7tWQZhIBlqW+Q1/nWLY8m/a0gbhzcF6xbY4wWCzwKyXd8UYF5vkY50TPayO3fi04
         Re8RiXycMyj+zILs585JNwXBeU2Frctz51/bkIsN79SotLCHlbAH4sYUiMKFyBA5Blm3
         1vN4Tknn0zsiRzMA0cMcDmx0KNkRAo+pKS358WD2xOptR8YnpWEjQNWrDwmyyNv+/n6X
         wFKHly7LAf90FyGm02fJYXwZ3gdJibZI5gxKYxi2OJwa+pbBxyGqQydFkwnpgmEXFmSQ
         hFMeegGLjt15vuLrmWU5MAWW2FD61l5RNVjVdyHtfrHGU9btZ8oaKreXvWybyT+Ia2Zw
         6L3A==
X-Gm-Message-State: ACrzQf2UR3Top88nRW0IFZwFYiX8Gd9S0Dm1WfFoV/UJwtK8PcqPlN4X
        nzY5fOa8fN4W8tRPUy/NNxAGhAWz5TMwEIpfXsIdgS0yfb+WFf73eVvgRCY+aLECgMXEYhGmWO+
        CCQHqrJfUoyuGwcsITW/tDP79
X-Received: by 2002:a5d:47c5:0:b0:22e:6941:81eb with SMTP id o5-20020a5d47c5000000b0022e694181ebmr3293008wrc.408.1665752470731;
        Fri, 14 Oct 2022 06:01:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM64LAt/bXBlG7HpFfz2D7sSRGhelA92JwzG3QdzpfXGbbOKe2ptF7MkqUTL6DhtBxrsuST3Eg==
X-Received: by 2002:a5d:47c5:0:b0:22e:6941:81eb with SMTP id o5-20020a5d47c5000000b0022e694181ebmr3292947wrc.408.1665752470102;
        Fri, 14 Oct 2022 06:01:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8f00:9219:ab4c:826e:9646? (p200300cbc7048f009219ab4c826e9646.dip0.t-ipconnect.de. [2003:cb:c704:8f00:9219:ab4c:826e:9646])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003c6cc57566fsm6123016wmq.14.2022.10.14.06.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 06:01:09 -0700 (PDT)
Message-ID: <72e535ce-80eb-a02f-970c-6a9c80da0a24@redhat.com>
Date:   Fri, 14 Oct 2022 15:01:08 +0200
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
 <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
 <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
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

On 14.10.22 14:50, Alexander Atanasov wrote:
> Hello,
> 
> On 11.10.22 12:23, David Hildenbrand wrote:
>>>>>> Sounds to me that all you want is some notifier to be called from
>>>>>> adjust_managed_page_count(). What am I missing?
>>>>>
>>>>> Notifier will act as an accumulator to report size of change and it
>>>>> will make things easier for the drivers and users wrt locking.
>>>>> Notifier is similar to the memory hotplug notifier.
>>>>
>>>> Overall, I am not convinced that there is any value of separating the
>>>> value
>>>> and the notifier. You can batch both or not batch both. In addition,
>>>> as I
>>>> mentioned, having two values seems racy.
>>>
>>> I have identified two users so far above - may be more to come.
>>> One type needs the value to adjust. Also having the value is necessary
>>> to report it to users and oom. There are options with callbacks and so
>>> on but it will complicate things with no real gain. You are right about
>>> the atomicity but i guess if that's a problem for some user it could
>>> find a way to ensure it. i am yet to find such place.
>>>
>>
>> I haven't followed the whole discussion, but I just wanted to raise that
>> having a generic mechanism to notify on such changes could be valuable.
>>
>> For example, virtio-mem also uses adjust_managed_page_count() and might
>> sometimes not trigger memory hotplug notifiers when adding more memory
>> (essentially, when it fake-adds memory part of an already added Linux
>> memory block).
>>
>> What might make sense is schedule some kind of deferred notification on
>> adjust_managed_page_count() changes. This way, we could notify without
>> caring about locking and would naturally batch notifications.
>>
>> adjust_managed_page_count() users would not require changes.
> 
> Making it deferred will bring issues for both the users of the
> adjust_managed_page_count and the receivers of the notification -
> locking as first. And it is hard to know when the adjustment will
> finish, some of the drivers wait and retry in blocks. It will bring
> complexity and it will not be possible to convert users in small steps.

What exactly is the issue about handling that deferred? Who needs an 
immediate, 100% precise notification?

Locking from a separate workqueue shouldn't be too hard, or what am i 
missing?

> 
> Other problem is that there are drivers that do not use
> adjust_managed_page_count().

Which ones? Do we care?

-- 
Thanks,

David / dhildenb

