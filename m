Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFA6EB081
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjDURXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjDURWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B230FB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5BUIZCZG7tWuEnNiXnezg1wpCr6XGmaYZLZ1JJftNg=;
        b=aVxfAhIzrWMhRJdQ1VTgCvGDg170bNeTigAFY2AJin4yZic4o5CkNaQ8gqN6Sg9vTZxQhi
        S1sXize2V/8GjJVd4IdeYoupOCnse30q0F+8G4FI8jCvvhRUJ1/kmRA7l6VvMRQCWO3kmL
        etrVq7nXNkMWjmyaQa4LM/TXFtOHJxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-HyJcUf92O-qYIE-g8ck6Pw-1; Fri, 21 Apr 2023 13:21:41 -0400
X-MC-Unique: HyJcUf92O-qYIE-g8ck6Pw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f1763fac8bso13102235e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097699; x=1684689699;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5BUIZCZG7tWuEnNiXnezg1wpCr6XGmaYZLZ1JJftNg=;
        b=iGzfwRwGojfopmqXXjS1TS14HiC6Ousr7RzEtJKcmzkj7XoY8jAi0QRiGPoplRt/TX
         qJCg6weOT4IxwIDu30tTkWC7sTCsU2THHQnqbPftZp13L493R86M6xhoMn6DAWDugbuJ
         aBjGHpoSzoWguQH23+f5+THmQD+SB5d5a5ED9vIF7mz5Fbhk3SpEiAeqdgnoPA9t8KzC
         RwBHWdtnRpuIa7uZurFEIPo2LTqCmaiOdPgWfRbf7as+3q/60PwGd5p6LviD8SK4djVk
         GuFeg58vJJcpcen3wFSYbKFtzoU44nShpCDBwkI+pA6yvvd/vaWlvr0cjIxRgpG+hp8k
         Tkpw==
X-Gm-Message-State: AAQBX9cNc562slVJdbA/V5np1reYIU0AhpRmbcAyeDbnK5VFScjdMgJb
        2e8xR1AtbZI0LYps/nLFvzLeduhfT5V4h0fXMOM9m71JikbctL0UqdoeZpM9Ngqy3PqnUIqENl/
        wjjQlleKxj7Shl+NGz/ENJwbv
X-Received: by 2002:a05:600c:2306:b0:3f1:72ec:4016 with SMTP id 6-20020a05600c230600b003f172ec4016mr2580970wmo.0.1682097699584;
        Fri, 21 Apr 2023 10:21:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350aFn+YAjtfSjCVKeXGhCWAiZWMdwsuDncB3Nwm1fVnTmqMnOAjnMKFGp80Ll5DTm/pP7pP0nA==
X-Received: by 2002:a05:600c:2306:b0:3f1:72ec:4016 with SMTP id 6-20020a05600c230600b003f172ec4016mr2580947wmo.0.1682097699200;
        Fri, 21 Apr 2023 10:21:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6a00:e38f:c852:dc11:9146? (p200300cbc7176a00e38fc852dc119146.dip0.t-ipconnect.de. [2003:cb:c717:6a00:e38f:c852:dc11:9146])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003f171234a08sm5302275wmk.20.2023.04.21.10.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:21:38 -0700 (PDT)
Message-ID: <f809162e-4adc-cf9b-35f4-0f1b098ad283@redhat.com>
Date:   Fri, 21 Apr 2023 19:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/3] mm/ksm: unmerge and clear VM_MERGEABLE when
 setting PR_SET_MEMORY_MERGE=0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-2-david@redhat.com>
 <qvqwr0sei6sl.fsf@devbig1114.prn1.facebook.com>
 <d476d75d-74a8-9cad-a60e-4b5ecb149719@redhat.com>
Organization: Red Hat
In-Reply-To: <d476d75d-74a8-9cad-a60e-4b5ecb149719@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I understand we want to keep the name "symmetric" with
>> ksm_enable_merge_any, but it also unmerges the ksm pages. Do we want to
>> reflect that in the function name?
> 
> ksm_disable_merge_any_umerge() is suboptimal.
> 
> As ksm_disable_merge_any() now reverts what ksm_enable_merge_any() ended
> up doing, I think it's just fine.
> 
> (it would be a different story if we'd be using "set" / "clear"
> terminology instead of "enable" / "disable").
> 
> We can describe that in the comment.
> 
>>
>> Can we add a comment for the function?
> 
> Can do for symmetry with ksm_enable_merge_any().
> 

+/**
+ * ksm_disable_merge_any - Disable merging on all compatible VMA's of the mm,
+ *                        previously enabled via ksm_enable_merge_any().
+ *
+ * Disabling merging implies unmerging any merged pages, like setting
+ * MADV_UNMERGEABLE would. If unmerging fails, the whole operation fails and
+ * merging on all compatible VMA's remains enabled.
+ *
+ * @mm: Pointer to mm
+ *
+ * Returns 0 on success, otherwise error code
+ */


-- 
Thanks,

David / dhildenb

