Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264AC70DED7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbjEWOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbjEWOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C01BDA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684851017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1C8usowa2pgKunQ7Y0kEci+NwOJdReFKzh3ExUrheY=;
        b=UIdI3n7VjSU8U7N1VIbMpeR9HwwfxqL9rNkNVH4OduHKQb/tx8O53P2KVOeFh9n5ip+X2O
        ClxecUIm/tAln9pRaNODYLHcvW9nE74kMGxq3Rp/RY4vaOiYrkSka8U4KyxXnVKGSHaXxp
        Z7zp7MaZlkU66D8fqE0N7DklmoG37FU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-rmEtxuW9O6mGZJYZGMEtUg-1; Tue, 23 May 2023 10:10:15 -0400
X-MC-Unique: rmEtxuW9O6mGZJYZGMEtUg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f4f2f5098bso42821975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851014; x=1687443014;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1C8usowa2pgKunQ7Y0kEci+NwOJdReFKzh3ExUrheY=;
        b=B+kiXP7KCNaLwb4r35EukxZKHySvVhYUJpNripaEF5opIRDqDEtJz1rhPLr83LXYJJ
         EChYBQ50OV+KYiygQExvO2HGlpEck011r6LNlgjpg1UHUSOM6j3l0mz23cDLJrEeNPci
         xscLOCvHxkaQ8nk2+xp7a0T8c8f3rrBNhqCQwgcnGj5GGUgQ1rT57mWpjUI7mwguocmQ
         S3iCLFwij9yPNld9Rs+T1zCRF5i0f7RsRya+OLEUJNgO+oW02fyKRZ0C4bpFdJxP3bpk
         1pCZkg8Nq395Uv2Ebn7ONuS3IIcvyt2FmakQVAmgUDJ1h804amyzYeHRxwVpjt/TzQNf
         BxYQ==
X-Gm-Message-State: AC+VfDzVc2eIhbTUhQ4GkQ/R1yG4piE0bTfTqyuYM/Qr/fhANir0ttkp
        +utsTkBeyPnQfLYsQeufgt3+Cc+U6UfvTp53wbBt6j8sDGXoYJJ8WX2JKxKEsobctMl9E9V8mv1
        VyhOZsvGxwh84/4+5F13xHDVn
X-Received: by 2002:adf:e60a:0:b0:2f9:61b5:7796 with SMTP id p10-20020adfe60a000000b002f961b57796mr10943783wrm.29.1684851014400;
        Tue, 23 May 2023 07:10:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6NSL8riuboTPFlh9jPmS1Q+b3+kyv16SjRb+BhFJwza6MlsDIn0PSByLRqUU0fiMIlxmhoyw==
X-Received: by 2002:adf:e60a:0:b0:2f9:61b5:7796 with SMTP id p10-20020adfe60a000000b002f961b57796mr10943759wrm.29.1684851014003;
        Tue, 23 May 2023 07:10:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id y9-20020a05600c364900b003f4266965fbsm15162163wmq.5.2023.05.23.07.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:10:13 -0700 (PDT)
Message-ID: <c3530ffb-c004-98cd-2651-280c391aca92@redhat.com>
Date:   Tue, 23 May 2023 16:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
 <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
 <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
 <c63053b0-5797-504d-7896-c86271b64162@redhat.com>
 <7c572622c0d8e283fc880fe3f4ffac27@ispras.ru>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
In-Reply-To: <7c572622c0d8e283fc880fe3f4ffac27@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Wouldn't that also suffer from the same issue, or how is this
>> different?
>>
> Yes, it is the same issue, so e.g. prctl(PR_SET_DUMPABLE,
> SUID_DUMP_DISABLE ) may wrongly fail with EINVAL on 64-bit targets.
> 
>> Also, how is passing "0"s to e.g., PR_GET_THP_DISABLE reliable? We
>> need arg2 -> arg5 to be 0. But wouldn't the following also just pass a
>> 0 "int" ?
>>
>> prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0)
>>
> Yes, this is not reliable on 64-bit targets too. The simplest fix is to
> use "0L", as done in MDWE self-tests (but many other tests get this
> wrong).

Oh, it's even worse than I thought, then. :)

Even in our selftest most of
	$ git grep prctl tools/testing/selftests/ | grep "0"

gets it wrong.

> 
> Florent also expressed surprise[1] that we don't see a lot of failures
> due to such issues, and I tried to provide some reasons. To elaborate on

Yes, I'm also surprised!

> the x86-64 thing, for prctl(PR_SET_DUMPABLE, 0) the compiler will likely
> generate "xorl %esi, %esi" to pass zero, but this instruction will also
> clear the upper 32 bits of %rsi, so the problem is masked (and I believe
> CPU vendors are motivated to do such zeroing to reduce false
> dependencies). But this zeroing is not required by the ABI, so in a more
> complex situation junk might get through.

:/

> 
> Real-world examples of very similar breakage in variadic functions
> involving NULL sentinels are mentioned in [2] (the musl bug report is
> [3]). In short, musl defined NULL as plain 0 for C++, so when people do
> e.g. execl("/bin/true", "true", NULL), junk might prevent detection of
> the sentinel in execl() impl. (Though if the sentinel is passed via
> stack because there are a lot of preceding arguments, the breakage
> becomes more apparent because auto-zeroing of registers doesn't come
> into play anymore.)

Yes, I heard about the "fun" with NULL already. Thanks for the musl 
pointer. And thanks for the confirmation/explanation.

> 
>>
>> I'm easily confused by such (va_args) things, so sorry for the dummy
>> questions.
> 
> This stuff *is* confusing, and note that Linux man pages don't even tell
> that prctl() is actually declared as a variadic function (and for
> ptrace() this is mentioned only in the notes, but not in its signature).

Agreed, that's easy to miss (and probably many people missed it).


Anyhow, for this patch as is (although it feels like drops in the ocean 
after our discussion)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

