Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE0C5F42F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJDMc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJDMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC578580B1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664886769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARqzLCUGK9oxipjgV/TP0dhqnyFoncnYQ36iiV2KnPc=;
        b=Bj3j42Z1UFJxAf6YnYiq7NJ3NO9F4UlDsMIq/7WYaWkpoVrynneqQ4mr6cmd8P35wooo+5
        YZikVsJClDnsIlB4/Pq/SufLkKeAPtSRu2ZnjjVHRF5aQOrXEaeBt1id4GngKaVoV67Uyk
        y+uh0YZd8vEipXD3A8r7trk4I9m0sI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-1jxZrTzxNr6fwaHv_9FWPA-1; Tue, 04 Oct 2022 08:32:48 -0400
X-MC-Unique: 1jxZrTzxNr6fwaHv_9FWPA-1
Received: by mail-wr1-f70.google.com with SMTP id d22-20020adfa356000000b0022e224b21c0so2421393wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ARqzLCUGK9oxipjgV/TP0dhqnyFoncnYQ36iiV2KnPc=;
        b=7d0oDiOw837yZLRObYHTd0p9UMhSRtwVPnct9Heq2RUlKhA+G6embjRdyKgun79Lhq
         +C6aify7gsFFHCEmD/qVstYTX2tTGjOXuPdFtUM1ug2DBk4jAJzyZ7/rNqndEgGkO/hW
         l0krOoV7kCJfCkx9dCJwz+1ix9Jftk8oRewfotIAeGJNsGmZ+YVC2RBKUeS7+ETfBlKi
         /9zKdMl9J+hSDffHk/5KORimIy9toj8P2RIu72BG3u7K8dudeviuXS6/5RfSO5qkvQ5g
         zSskP84G4C8a7AIiuB1W+RX2AwkWPZeM62CEJ8PrcChSU0NTIfsu2BSFc6JRqdNyY0qf
         jyxg==
X-Gm-Message-State: ACrzQf0598Bn08fOg8j60ORkrSMZrU+SuXzNIWXgUjx4ET7usHPE0sku
        HGUKWvEpZRlgQI7/EXXd6pMJk0snlsuiOIhORdoT0RDxkeDgTPIbKplumfnD4oEIfj6Y2HD0Wzg
        KQRWu88mmvJVTlXbF6wlDe58P
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr15777348wrr.2.1664886767406;
        Tue, 04 Oct 2022 05:32:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4xqePutEPB3BXlHEVeHUD3E+8ExIhv/azDcUvIYjAckd2CXwfmrDfdmGjPdpAJS/YBJHMgGg==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr15777319wrr.2.1664886767130;
        Tue, 04 Oct 2022 05:32:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5000:4fff:1dd6:7868:a36? (p200300cbc70650004fff1dd678680a36.dip0.t-ipconnect.de. [2003:cb:c706:5000:4fff:1dd6:7868:a36])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b0022afbd02c69sm10360655wrp.56.2022.10.04.05.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 05:32:46 -0700 (PDT)
Message-ID: <31f20ddf-cd41-69b5-2875-2d738b166ae2@redhat.com>
Date:   Tue, 4 Oct 2022 14:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 1/3] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220920122302.99195-1-david@redhat.com>
 <20220920122302.99195-2-david@redhat.com> <87pmfp8hnj.fsf@kernel.org>
 <d1ceedca-b28e-c47e-aa0d-aa1cb36d12b9@redhat.com> <87leq64m20.fsf@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87leq64m20.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.22 09:44, Kalle Valo wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>>>> +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
>>>> +**************************************************
>>>> +
>>>> +WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it
>>>> +is common for a given warning condition, if it occurs at all, to occur
>>>> +multiple times. This can fill up and wrap the kernel log, and can even slow
>>>> +the system enough that the excessive logging turns into its own, additional
>>>> +problem.
>>>
>>> FWIW I have had cases where WARN() messages caused a reboot, maybe
>>> mention that here? In my case the logging was so excessive that the
>>> watchdog wasn't updated and in the end the device was forcefully
>>> rebooted.
>>>
>>
>> That should be covered by the last part, no? What would be your suggestion?
> 
> I was just thinking that maybe make it more obvious that even WARN_ON()
> can crash the system, something along these lines:
> 
> "..., additional problem like stalling the system so much that it causes
> a reboot."

Hi Kalle,

sorry for the late reply. Jonathan already queued v2 and sent it upstream.

I think that's it is already covered by the statement and that the 
additional example isn't required -- most of us learned the hard way 
that "excessive logging turns into its own problem" includes all weird 
kinds of kernel crashes. A panic/reboot due to a watchdog not firing is 
one such possible outcome.

Thanks!

-- 
Thanks,

David / dhildenb

