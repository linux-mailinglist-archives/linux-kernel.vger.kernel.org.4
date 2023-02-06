Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461E168C42D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBFRFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBFRFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00ED1B557
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675703106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RRuABWwbPuY7o8ID2NLGTa56ZHzYzGcHYdmRVwotXpo=;
        b=eRJ+z2+xzuEWohaLKragMTwUTliaOCze+dyDRYV/qklCIscfTXAbAloejjQcUZCIFWYM4Y
        G8zmGM4WOaIIMzPQkCQ3sxFqHYWiIK/4bofKrBj+pQd79kxq6twsWD648Qg58+FuhGE/ox
        a+1la2nIUqVrGETl4lCnkQOQUcpaxNg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-mI9eA5jdP0uTicCFJem3tg-1; Mon, 06 Feb 2023 12:05:04 -0500
X-MC-Unique: mI9eA5jdP0uTicCFJem3tg-1
Received: by mail-wm1-f72.google.com with SMTP id k9-20020a05600c1c8900b003dc5dec2ac6so9246761wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 09:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRuABWwbPuY7o8ID2NLGTa56ZHzYzGcHYdmRVwotXpo=;
        b=1z8wSVez3yePEIjiaUPTEo+GK+swRu5IZnuEqPeXt3DkiKOTCb30W5rVFiVgDwoef8
         hxJ8WAHXFRDDhxgL8/O3WSxznX2Orcy76BOiA7Nq7t1AO3fr2uvo9f6diJ/oqMAjsQaA
         b7W8UwfIyWHQCKYgMRQpTGaVEXk3kug7oixGH8KpQzvQd4CccvzEg0GdkRQecofe187N
         2fv+ouvQZ7bpJqTM+LZnmTdwVELn6jNaKlE4lCtAcfSdzA56PwAIND6R1WWK0Bic1j/y
         zmeAor96Eiy6nGFbzqNcX7vCAGs0dPtyoFCxqYkgKV38cNvo0zEMvbRxqHQQ2I4HSo61
         dkEg==
X-Gm-Message-State: AO0yUKUgyfXmCyzfduBZuUrC2PRvX3zSYAVZD7waG69X/1Ny6fBzQJQE
        R3QUcKikFK3S9Scc60fF++Ns01sh/NAwxcQMZQsQY8eGtshIJRCtna5arQ/yIX4Zckpy/6U5vdu
        DhlCxS4NfmZKZSA/cWSxlUw2B
X-Received: by 2002:adf:e789:0:b0:2c3:e899:1b85 with SMTP id n9-20020adfe789000000b002c3e8991b85mr5020497wrm.15.1675703103614;
        Mon, 06 Feb 2023 09:05:03 -0800 (PST)
X-Google-Smtp-Source: AK7set/97j9/fTK+ajoxpMOBwgtFwLcRSLa7e7zHErAKww1OfTxXfUilcAtjtds5pUfMGNUX4P/6fQ==
X-Received: by 2002:adf:e789:0:b0:2c3:e899:1b85 with SMTP id n9-20020adfe789000000b002c3e8991b85mr5020480wrm.15.1675703103388;
        Mon, 06 Feb 2023 09:05:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:6200:8129:46d3:fa82:23f8? (p200300cbc7046200812946d3fa8223f8.dip0.t-ipconnect.de. [2003:cb:c704:6200:8129:46d3:fa82:23f8])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b00241fab5a296sm9152844wrs.40.2023.02.06.09.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 09:05:02 -0800 (PST)
Message-ID: <10a3929a-7109-169f-6e42-e51c83305567@redhat.com>
Date:   Mon, 6 Feb 2023 18:05:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230128063229.989058-1-mawupeng1@huawei.com>
 <20230128063229.989058-2-mawupeng1@huawei.com>
 <753c53d3-84a6-da73-4121-0db4a71e4fde@redhat.com>
 <a5ae7d0c-61dc-3071-434d-5152c46c05e8@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a5ae7d0c-61dc-3071-434d-5152c46c05e8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.23 01:48, mawupeng wrote:
> 
> 
> On 2023/2/4 1:14, David Hildenbrand wrote:
>> On 28.01.23 07:32, Wupeng Ma wrote:
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>>> The return value of mlock is zero. But nothing will be locked since the
>>> len in do_mlock overflows to zero due to the following code in mlock:
>>>
>>>     len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>
>>> The same problem happens in munlock.
>>>
>>> Add new check and return -EINVAL to fix this overflowing scenarios since
>>> they are absolutely wrong.
>>>
>>> Return 0 early to avoid burn a bunch of cpu cycles if len == 0.
>>>
>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>> ---
>>>    mm/mlock.c | 14 ++++++++++++--
>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>> index 7032f6dd0ce1..eb09968ba27f 100644
>>> --- a/mm/mlock.c
>>> +++ b/mm/mlock.c
>>> @@ -478,8 +478,6 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>>>        end = start + len;
>>>        if (end < start)
>>>            return -EINVAL;
>>> -    if (end == start)
>>> -        return 0;
>>>        vma = mas_walk(&mas);
>>>        if (!vma)
>>>            return -ENOMEM;
>>> @@ -575,7 +573,13 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>>>        if (!can_do_mlock())
>>>            return -EPERM;
>>>    +    if (!len)
>>> +        return 0;
>>> +
>>>        len = PAGE_ALIGN(len + (offset_in_page(start)));
>>> +    if (!len)
>>> +        return -EINVAL;
>>> +
>>>        start &= PAGE_MASK;
>>
>> The "ordinary" overflows are detected in apply_vma_lock_flags(), correct?
> 
> Overflow is not checked anywhere however the ordinary return early if len == 0 is detected in apply_vma_lock_flags().
> 

I meant the

end = start + len;
if (end < start)
	return -EINVAL;

Essentially, what I wanted to double-check is that with your changes, we 
catch all kinds of overflows as documented in the man page, correct?

-- 
Thanks,

David / dhildenb

