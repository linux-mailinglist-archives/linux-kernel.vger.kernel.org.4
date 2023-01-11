Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84EA665E10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjAKOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjAKOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9031C907
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673447407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dsSTrNIRFbZiv8kfvwsD4ZTbADoW+ucjY/egJOCNNtQ=;
        b=f7XrxLlMrDycia6W8Shr7hnH3AYmn6oJsfr4jbHDO/JgAbV9w/TN9w5kuG5fD6sawmLkG/
        6qZFQlGNu9RsnUu5/LVQ2yDfFGsqrtBZSVZX9HG7F90GYGWePDVaVhW9Mvteq+SKaSc8Oc
        pe9J1/bKG4FqmEVB9li8sFVNTaioJbM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-PutwZHYaOcuDUslJqzVNIQ-1; Wed, 11 Jan 2023 09:29:58 -0500
X-MC-Unique: PutwZHYaOcuDUslJqzVNIQ-1
Received: by mail-pg1-f199.google.com with SMTP id e5-20020a63f545000000b0049b36d5a272so6739824pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsSTrNIRFbZiv8kfvwsD4ZTbADoW+ucjY/egJOCNNtQ=;
        b=q4hFpgO/TMvAuZSzGnp+BlqwPUtqT3AcuOLvFE67QkaWYQsqEKcaUPW+rRA023zG/K
         Wh24DxGwFrI5IdSiXdQKaLI4MX21l9yVs2QV32H3lGwMqU1J09BLn0kHptq5DkHpp8ob
         /KApU//LrGk5QgXDg52bhYk4mgUYF+zQgX2V86Oi5Nxvb0cyIDfBs8vGLAXzD3vp/3a3
         LzhT9f6mEltMRMxhupju1TsXWof3CY/NSElSVQMumXxUOWLXBEsT6mVkc4qQ12RR6bly
         y4OewFr1DGEhjSbB4R5LXtJPoRa1dcdBrWZQ2qY2xSOdozCQjV/oPbZEGetxVci6a8qF
         7C7w==
X-Gm-Message-State: AFqh2kpOIB95+ODtEnxYfAV8Rz1DwOH3YQWivURm6xmr+ORDtovc9ofJ
        aFyXTF92JnWPb2AeaRu2RIuMCtYebxwO+61Fp38dharr6ROC13ad3aLytrTw4i6rqAGaNvW4bRr
        M4Je+2QqLcuOT62/xMxn9ZXTy
X-Received: by 2002:a17:90a:5791:b0:227:1c85:f5f4 with SMTP id g17-20020a17090a579100b002271c85f5f4mr9128899pji.5.1673447396925;
        Wed, 11 Jan 2023 06:29:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuzxWKbwqGBpXQocCXlLeRIi2BkJQlAdtwtg8OMzT49+l1gAOPM2skXKEppTEx/Xozm+TfCYg==
X-Received: by 2002:a17:90a:5791:b0:227:1c85:f5f4 with SMTP id g17-20020a17090a579100b002271c85f5f4mr9128879pji.5.1673447396616;
        Wed, 11 Jan 2023 06:29:56 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r60-20020a17090a43c200b002271b43e528sm5105448pjg.33.2023.01.11.06.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:29:56 -0800 (PST)
Subject: Re: [PATCH] net: ena: initialize dim_sample
To:     Shay Agroskin <shayagr@amazon.com>
Cc:     Eric Dumazet <edumazet@google.com>, akiyano@amazon.com,
        darinzon@amazon.com, ndagan@amazon.com, saeedb@amazon.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com, khalasa@piap.pl,
        wsa+renesas@sang-engineering.com, yuancan@huawei.com,
        tglx@linutronix.de, 42.hyeyoo@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230108143843.2987732-1-trix@redhat.com>
 <CANn89iLFtrQm-E5BRwgKFw4xRZiOOdWg-WTFi5eZsg7ycq2szg@mail.gmail.com>
 <pj41zlpmbmba16.fsf@u570694869fb251.ant.amazon.com>
 <db824c89-13f2-3349-9dd0-0fb7559c6273@redhat.com>
 <pj41zllem9bglr.fsf@u570694869fb251.ant.amazon.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <010f0cef-0f6e-1d4e-47ec-29a3c667b97a@redhat.com>
Date:   Wed, 11 Jan 2023 06:29:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pj41zllem9bglr.fsf@u570694869fb251.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/11/23 12:46 AM, Shay Agroskin wrote:
>
> Tom Rix <trix@redhat.com> writes:
>
>> On 1/10/23 8:58 AM, Shay Agroskin wrote:
>>>
>>> Eric Dumazet <edumazet@google.com> writes:
>>>
>>>> On Sun, Jan 8, 2023 at 3:38 PM Tom Rix <trix@redhat.com> wrote:
>>>>>
>>>>> clang static analysis reports this problem
>>>>> drivers/net/ethernet/amazon/ena/ena_netdev.c:1821:2: warning:
>>>>> Passed-by-value struct
>>>>>   argument contains uninitialized data (e.g., field: 'comp_ctr')
>>>>> [core.CallAndMessage]
>>>>>         net_dim(&ena_napi->dim, dim_sample);
>>>>>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> net_dim can call dim_calc_stats() which uses the comp_ctr element,
>>>>> so it must be initialized.
>>>>
>>>> This seems to be a dim_update_sample() problem really, when comp_ctr
>>>> has been added...
>>>>
>>>> Your patch works, but we could avoid pre-initializing dim_sample in
>>>> all callers,
>>>> then re-writing all but one field...
>>>>
>>>> diff --git a/include/linux/dim.h b/include/linux/dim.h
>>>> index
>>>> 6c5733981563eadf5f06c59c5dc97df961692b02..4604ced4517268ef8912cd8053ac8f4d2630f977 
>>>>
>>>> 100644
>>>> --- a/include/linux/dim.h
>>>> +++ b/include/linux/dim.h
>>>> @@ -254,6 +254,7 @@ dim_update_sample(u16 event_ctr, u64 packets, u64
>>>> bytes, struct dim_sample *s)
>>>>         s->pkt_ctr   = packets;
>>>>         s->byte_ctr  = bytes;
>>>>         s->event_ctr = event_ctr;
>>>> +       s->comp_ctr  = 0;
>>>>  }
>>>>
>>>>  /**
>>>
>>> Hi,
>>>
>>> I'd rather go with Eric's solution to this issue than zero the whole
>>> struct in ENA
>>
>> Please look at the other callers of dim_update_sample.  The common
>> pattern is to initialize the struct.
>>
>> This alternative will work, but the pattern of initializing the struct
>> the other (~20) callers should be refactored.
>>
>> Tom
>>
>
> While Eric's patch might be bigger if you also remove the 
> pre-initialization in the other drivers, the Linux code itself would 
> be smaller (granted not significantly) and
> it make less room for pitfalls in adding DIM support in other drivers.
>
> Is there a good argument against using Eric's patch other than 'the 
> other patch would be bigger' ?

No, I think it a better approach and if Eric can take it forward that 
would be great.

However when you start refactoring, it may grow larger than the single fix.

For instance, passing the structure by value could be changed to passing 
by reference.

Tom

>
> Shay
>
>>>
>>> Thanks,
>>> Shay
>>>
>

