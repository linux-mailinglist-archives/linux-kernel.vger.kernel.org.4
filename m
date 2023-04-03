Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A06D3E6B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjDCHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDCHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2F14496
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjW3+Ysmamg9knSlqi+igsm5XB/oTir+s+7kEVE5SVw=;
        b=PJQLIShV1OkqjTM78Q5udtemIVhgmrJVyEacaS3uHGaIsPUUljzeUFroVbJYrGE8uggAPD
        NiagUbCZ0kjFI4xdncUR1ag1285wfNTOktSrJGqMlSvtBXfjBWvkAgIIWkspmyY8a4XXaG
        Da/xRPgzLw8x2Ebzt6+ptQn35sL9TPU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-4BF85hYKNMuxLUiHcr3HXA-1; Mon, 03 Apr 2023 03:49:37 -0400
X-MC-Unique: 4BF85hYKNMuxLUiHcr3HXA-1
Received: by mail-wm1-f71.google.com with SMTP id o7-20020a05600c4fc700b003edf85f6bb1so15768427wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508176;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjW3+Ysmamg9knSlqi+igsm5XB/oTir+s+7kEVE5SVw=;
        b=3PJrk2yI7CjLLjyrqHcP9rrCI0XOQlIxpUPM1s8xQ3E98MrT01NodxbYd22TVGXL0U
         +4Vv86telOf4GzpuLMWkuqlwTwF8S5b/56Ih98hgO/R1fvTVg/aV/MFkv0RzCBeUJKgG
         Hhftb7n5Hmwdcn4VfrsajQxWC/Q7bANuZGYhEY2CBG5ienH8UgK7w6A0p5AM10FaPbc+
         CZ9KwXiz698Q7gaA3s6HhN7R8feh/JqyNThVsP8TpY5kqJlxfs4u7mtI8kOye443Qnwm
         SF+lMLkIPJlj6+8JWkYBaexYBAX/T46HSmKVzlTOfnyb2wsUfmV/RX3optB7KO4PdJzh
         aGtg==
X-Gm-Message-State: AAQBX9c9rMrLIPfqgoM1KzZ4hX1TdtOSe/8I77g2EzuEzly74N7KcDg7
        kolho972BDn4vIf3tQ0qhAF8krp5i4YuhX9v1vj4NSZtLTfDmzeQvmFBRpecHa7xBAeASZ2tFUs
        Rla8Lrj5rsv9tRtV2KCY+rvrOdrqxWyBU
X-Received: by 2002:adf:e852:0:b0:2c5:3ccf:e99a with SMTP id d18-20020adfe852000000b002c53ccfe99amr24238297wrn.6.1680508176455;
        Mon, 03 Apr 2023 00:49:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZnCEBfH/ofvOkEZtKbNH3snyGXtIuWExjv90T1NxL5qT/FRv/QUNsnfB3kxrSTPpIqPuwqFQ==
X-Received: by 2002:adf:e852:0:b0:2c5:3ccf:e99a with SMTP id d18-20020adfe852000000b002c53ccfe99amr24238280wrn.6.1680508176157;
        Mon, 03 Apr 2023 00:49:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d48c2000000b002e61923575csm8307835wrs.74.2023.04.03.00.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:49:35 -0700 (PDT)
Message-ID: <1303d6f3-bc9a-ea17-3cd3-3e44891291dc@redhat.com>
Date:   Mon, 3 Apr 2023 09:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 03/29] selftests/mm: Dump a summary in run_vmtests.sh
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160646.3106903-1-peterx@redhat.com>
 <CAJHvVciUGEfdgTLHUxAxCpKxXbMt202nsPhArsckHm7bDOdqFg@mail.gmail.com>
 <ZCYM94ifcsZYCkJq@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZCYM94ifcsZYCkJq@x1n>
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

On 31.03.23 00:28, Peter Xu wrote:
> On Thu, Mar 30, 2023 at 12:07:24PM -0700, Axel Rasmussen wrote:
>> On Thu, Mar 30, 2023 at 9:06 AM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> Dump a summary after running whatever test specified.  Useful for human
>>> runners to identify any kind of failures (besides exit code).
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>>> index c0f93b668c0c..9cc33984aa9f 100644
>>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>>> @@ -5,6 +5,9 @@
>>>   # Kselftest framework requirement - SKIP code is 4.
>>>   ksft_skip=4
>>>
>>> +count_pass=0
>>> +count_fail=0
>>> +count_skip=0
>>>   exitcode=0
>>>
>>>   usage() {
>>> @@ -149,11 +152,14 @@ run_test() {
>>>                  "$@"
>>>                  local ret=$?
>>>                  if [ $ret -eq 0 ]; then
>>> +                       count_pass=$(( $count_pass + 1 ))
>>
>> Actually, inside $(( )) there's no need to prefix variable names with
>> $ too. Running "shellcheck" over the script written this way will
>> generate a warning.
>>
>> Same applies below.
> 
> Sure, I'll fix.

With that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

