Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8325664748
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjAJRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjAJRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA2A1CB2B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673371083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSRn+zq7cMv1vgKgsf1PXv9JTi1nqzkgBPx3inNDfGg=;
        b=hYl3CNjqnfQ47Gi46/zutp1ozHJAcNI+GOXIJ1Qwe+R8RnV6tChN36GJ4I9welHDptK4bk
        /UwWTzwlYSLWcIxsracBTQRHkRA2d+tl9QU9CU4KuS6zvzbV7DEUjIFtf5iG1DVXPKB8ku
        g9Ty+YySbpfSuLd6JtT7oCzsklBlmNU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-142-MZ08JcCFOOeP40Hf13upeQ-1; Tue, 10 Jan 2023 12:18:01 -0500
X-MC-Unique: MZ08JcCFOOeP40Hf13upeQ-1
Received: by mail-pj1-f72.google.com with SMTP id v17-20020a17090abb9100b002239a73bc6eso9601110pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSRn+zq7cMv1vgKgsf1PXv9JTi1nqzkgBPx3inNDfGg=;
        b=hpfCMXEeoGJ3TQU6Y4awY/Ru6BqybuYqo1g0RDJ7AvKrEwFsqjnDQh8cVJWup3ZeX0
         WHE5uqtvBE39xrOA3RWu6LMgOVjmQLiquhgCjWvb+4t4KkvlSisamFn5zHurvOoY451c
         Cx0Gd5HXh0Uze4RBY9W6ybHXiNYXNn4j7ZCmNoblmc3q4WpIaQA+3PQUDmpzwbCBPT0W
         ShKdMU7g4Gz2cB9L7cGSJSFYEWfFDmE8lop+2f/r8wv0WfNEkyeqDsKfEZ7VfJTTs9km
         mFVsF5ziLMOIvdn/a7B8O73yb8JQN+ps23+nz93r4nZy97IOYF2YEPwinHZEEA2LPX8k
         lBhg==
X-Gm-Message-State: AFqh2kok8WP0akeqPnn5bj0p7yXLGNCj5ZskpoRx3xA1aOFL4vshxvJ4
        o8VkK/fa9rYRaVf30LXYpyKdtcEBlVisx6SHi8X1uf5msZUFDxc+G3WJjMulQj3f5Bm2eLKGyru
        B/YQ1y1hTqYtm7EImA/OEBb0h
X-Received: by 2002:a17:902:c10a:b0:188:bc62:276f with SMTP id 10-20020a170902c10a00b00188bc62276fmr69676419pli.3.1673371080588;
        Tue, 10 Jan 2023 09:18:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsU3vBw1ZUxXjKxBkeKXtV0X28zeBa2/Q5nyixIXc9QFNRqR7eJuvi/vXCcUYzbwQ29Ruev+Q==
X-Received: by 2002:a17:902:c10a:b0:188:bc62:276f with SMTP id 10-20020a170902c10a00b00188bc62276fmr69676397pli.3.1673371080304;
        Tue, 10 Jan 2023 09:18:00 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0018911ae9dfasm8355221plb.232.2023.01.10.09.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 09:17:59 -0800 (PST)
Subject: Re: [PATCH] net: ena: initialize dim_sample
To:     Shay Agroskin <shayagr@amazon.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     akiyano@amazon.com, darinzon@amazon.com, ndagan@amazon.com,
        saeedb@amazon.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        khalasa@piap.pl, wsa+renesas@sang-engineering.com,
        yuancan@huawei.com, tglx@linutronix.de, 42.hyeyoo@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230108143843.2987732-1-trix@redhat.com>
 <CANn89iLFtrQm-E5BRwgKFw4xRZiOOdWg-WTFi5eZsg7ycq2szg@mail.gmail.com>
 <pj41zlpmbmba16.fsf@u570694869fb251.ant.amazon.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <db824c89-13f2-3349-9dd0-0fb7559c6273@redhat.com>
Date:   Tue, 10 Jan 2023 09:17:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pj41zlpmbmba16.fsf@u570694869fb251.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/23 8:58 AM, Shay Agroskin wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
>> On Sun, Jan 8, 2023 at 3:38 PM Tom Rix <trix@redhat.com> wrote:
>>>
>>> clang static analysis reports this problem
>>> drivers/net/ethernet/amazon/ena/ena_netdev.c:1821:2: warning: 
>>> Passed-by-value struct
>>>   argument contains uninitialized data (e.g., field: 'comp_ctr') 
>>> [core.CallAndMessage]
>>>         net_dim(&ena_napi->dim, dim_sample);
>>>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> net_dim can call dim_calc_stats() which uses the comp_ctr element,
>>> so it must be initialized.
>>
>> This seems to be a dim_update_sample() problem really, when comp_ctr
>> has been added...
>>
>> Your patch works, but we could avoid pre-initializing dim_sample in 
>> all callers,
>> then re-writing all but one field...
>>
>> diff --git a/include/linux/dim.h b/include/linux/dim.h
>> index 
>> 6c5733981563eadf5f06c59c5dc97df961692b02..4604ced4517268ef8912cd8053ac8f4d2630f977
>> 100644
>> --- a/include/linux/dim.h
>> +++ b/include/linux/dim.h
>> @@ -254,6 +254,7 @@ dim_update_sample(u16 event_ctr, u64 packets, u64
>> bytes, struct dim_sample *s)
>>         s->pkt_ctr   = packets;
>>         s->byte_ctr  = bytes;
>>         s->event_ctr = event_ctr;
>> +       s->comp_ctr  = 0;
>>  }
>>
>>  /**
>
> Hi,
>
> I'd rather go with Eric's solution to this issue than zero the whole 
> struct in ENA

Please look at the other callers of dim_update_sample.  The common 
pattern is to initialize the struct.

This alternative will work, but the pattern of initializing the struct 
the other (~20) callers should be refactored.

Tom

>
> Thanks,
> Shay
>

