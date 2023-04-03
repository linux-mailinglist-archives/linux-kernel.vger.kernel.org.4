Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1386B6D3E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjDCH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDCH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E62D51
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sVQLi5QSZyMPwG4jud4CiER62DN4sgoj+A/Lhx1bVMM=;
        b=iXecCvT9rIwgvbDvcdBiH2aAK9YqZLr/k7RiBWqkHGStjD1iRWiPKTVCY+LYw3reLFB+rO
        3jXbCFuGXGJrKu6LOQAsOgKNLBtjatWXq1wv/cEuuY9fxrnSaPKt/L+8z9FWT/ECZWOlQz
        mFmIdpGPoti4L2F7Vai6cJkHTdkMV+w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-dfZv0orrMwqGav64h0K4XA-1; Mon, 03 Apr 2023 03:55:44 -0400
X-MC-Unique: dfZv0orrMwqGav64h0K4XA-1
Received: by mail-wr1-f70.google.com with SMTP id i19-20020adfa513000000b002dc1cdac53fso2973757wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508543;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVQLi5QSZyMPwG4jud4CiER62DN4sgoj+A/Lhx1bVMM=;
        b=6HqqAAw8x7SO/+z5oB91KJfs7eeP66QqyzmKw7HfIkk5Nl5tNx9Zc+Oz1kRqMtzsXK
         4qqCr3HYNF6xSNnwbFjYoPpgSL4qt2N28XJ4y3pBZCJEJcLJmorhGE/s+IQrV5tQTei6
         EcskZK57gsKxvL051ARL1RIHf0GYiC5m8wH7VxcXroMmtYoVmE1YYOJFrF1ZvCkMNdAV
         MYbaQmSkrrpFDUnD03+IICdFcdJFnFu9PLGEfohnmVuP7jnNCiveJQZmfGM01qs47CDK
         /0k8OpRNBMUnyYGL1mrtJ1ekubpUObPy1FXxfSRMEvfveGKGNMXusz38i9YLN4NKs1mt
         KxrA==
X-Gm-Message-State: AAQBX9dHkXDwEvZPxfJQSMTwrlp8nMl6h2jRlnbEysXWSNNLvpghbCPj
        PRdlOfp/Aauc+BUIZ/J2f3TMpVVbhlTyhu0pT/cychyr+f2V49hTl174sga49mYwmKNFcud2Ztg
        eWOm94IIgqEluZrhycKxTfvTz
X-Received: by 2002:a5d:414c:0:b0:2d6:4e98:5f32 with SMTP id c12-20020a5d414c000000b002d64e985f32mr24902091wrq.23.1680508543496;
        Mon, 03 Apr 2023 00:55:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350biYQRdaJzXlwNnzia2dMdfasRhuzALSoeVME3YQUzTMjBhElnTS15MLjaTNBVgoLfB5ualLQ==
X-Received: by 2002:a5d:414c:0:b0:2d6:4e98:5f32 with SMTP id c12-20020a5d414c000000b002d64e985f32mr24902068wrq.23.1680508543183;
        Mon, 03 Apr 2023 00:55:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b002d1e49cff35sm9038705wri.40.2023.04.03.00.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:55:42 -0700 (PDT)
Message-ID: <cfc0d7c8-edb5-ae5d-8edf-d4f7ee18b877@redhat.com>
Date:   Mon, 3 Apr 2023 09:55:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 10/29] selftests/mm: Test UFFDIO_ZEROPAGE only when
 !hugetlb
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160714.3106999-1-peterx@redhat.com> <20230331183726.GD12460@monkey>
 <CAJHvVcjOqShPeu3mYk2Xu1ZyMfFLuPCUp8+8nQ+CUyCj4nZVqA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJHvVcjOqShPeu3mYk2Xu1ZyMfFLuPCUp8+8nQ+CUyCj4nZVqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.23 03:57, Axel Rasmussen wrote:
> On Fri, Mar 31, 2023 at 11:37 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 03/30/23 12:07, Peter Xu wrote:
>>> Make the check as simple as "test_type == TEST_HUGETLB" because that's the
>>> only mem that doesn't support ZEROPAGE.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   tools/testing/selftests/mm/userfaultfd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
>>> index 795fbc4d84f8..d724f1c78847 100644
>>> --- a/tools/testing/selftests/mm/userfaultfd.c
>>> +++ b/tools/testing/selftests/mm/userfaultfd.c
>>> @@ -1118,7 +1118,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
>>>   {
>>>        struct uffdio_zeropage uffdio_zeropage;
>>>        int ret;
>>> -     bool has_zeropage = get_expected_ioctls(0) & (1 << _UFFDIO_ZEROPAGE);
>>> +     bool has_zeropage = !(test_type == TEST_HUGETLB);
>>
>> It is true that hugetlb is the only mem type that does not support zeropage.
>> So, the change is correct.
>>
>> However, I actually prefer the explicit check that is there today.  It seems
>> more like a test of the API.  And, is more future proof is code changes.
>>
>> Just my opinion/thoughts, not a strong objection.
> 
> I agree. The existing code is more robust to future changes where we
> might support or stop supporting this ioctl in some cases. It also
> proves that the ioctl works, any time the API reports that it is
> supported / ought to work, independent of when the *test* thinks it
> should be supported.
> 
> Then again, I think this is unlikely to change in the future, so I
> also agree with Mike that it's not the biggest deal.

As there were already discussions on eventually supporting 
UFFDIO_ZEROPAGE that doesn't place the shared zeropage but ... a fresh 
zeropage, it might make sense to keep it as is.

-- 
Thanks,

David / dhildenb

