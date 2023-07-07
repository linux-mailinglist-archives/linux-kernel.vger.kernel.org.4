Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09F874AFD1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGGLaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGGL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F421FFF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688729346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWacR69Uz+QfEDSGYVxHfDaVc9q9XWEvvJ77b0V+Ztw=;
        b=adrjJcAud9uNYthKWg3ALQN6PU5ONSIH2LX79vWSRDJXUW5M/N/4UZ5GuMXRNTuJ9BFbFY
        0k6eyo4nch5gS/LdCGUodEotG7ERwzT26MD3B9pYefAClzJ8BjDRbm9himwgeHMpOP5uuc
        Mwfq5FReDCA9V4LpA/aT05geujHBIF0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-7hGt964MN7edU5muF223AA-1; Fri, 07 Jul 2023 07:29:05 -0400
X-MC-Unique: 7hGt964MN7edU5muF223AA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313ec030acbso1446562f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 04:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688729344; x=1691321344;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWacR69Uz+QfEDSGYVxHfDaVc9q9XWEvvJ77b0V+Ztw=;
        b=YCh/iXhkjpq77iY5J/tB1JG+UYI32lSPF+ABlYZKtTNs+J2iPzLdHn5bZ2iQOp63aD
         uf/yGPy86oHbHCdFbAIrVmIQNXfr4ELXAeOtjZQuOwtYY0QzXjb0+vZtUgey5LoF6Xvr
         58ipKxQLFbKSnpL1F5BoRnugfgZtey6zY3Tk39hgmesZO2LAMfNUHMCgAxct0o5ovQI6
         w1oEp+KDl6ZRoigCqllcZNKOLIjr54gOme4FAz+Z+YkFT+f6wQ0ZF1lAF1qjQf8Vzh7G
         VSXfLxFMxukzEIo9QAanwIaIRCnL8mknOn47vNtwd20/mDsUSLIoghfpTZg/o6hDZvXj
         2Rrw==
X-Gm-Message-State: ABy/qLao1P9z9IwUygdQhFzt6+QZ6SiU1NxepM7QT+zzv9/J/yJiOPyO
        /axGBTeePL+vc0mNwg9whufaB3aHk3Cn2maRYtiOY69Uj87lmP5NvNAxttWRGqacCCQiccK9qg3
        no5gNBNKrX7a51ivR7SOICzXq
X-Received: by 2002:adf:e74b:0:b0:313:f3c0:62d8 with SMTP id c11-20020adfe74b000000b00313f3c062d8mr4764578wrn.21.1688729344272;
        Fri, 07 Jul 2023 04:29:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZpSY+2TfflZCKH26SgLqxtv0gTGR1lzGzm3LG1jIiHadGGqSAzJJRU7HiFrNDxrQGxIG+ag==
X-Received: by 2002:adf:e74b:0:b0:313:f3c0:62d8 with SMTP id c11-20020adfe74b000000b00313f3c062d8mr4764551wrn.21.1688729343861;
        Fri, 07 Jul 2023 04:29:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id f14-20020adff44e000000b003142ea7a661sm4246965wrp.21.2023.07.07.04.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 04:29:03 -0700 (PDT)
Message-ID: <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
Date:   Fri, 7 Jul 2023 13:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
In-Reply-To: <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 11:52, Ryan Roberts wrote:
> On 07/07/2023 09:01, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>>> allocated in large folios of a specified order. All pages of the large
>>> folio are pte-mapped during the same page fault, significantly reducing
>>> the number of page faults. The number of per-page operations (e.g. ref
>>> counting, rmap management lru list management) are also significantly
>>> reduced since those ops now become per-folio.
>>
>> I likes the idea to share as much code as possible between large
>> (anonymous) folio and THP.  Finally, THP becomes just a special kind of
>> large folio.
>>
>> Although we can use smaller page order for FLEXIBLE_THP, it's hard to
>> avoid internal fragmentation completely.  So, I think that finally we
>> will need to provide a mechanism for the users to opt out, e.g.,
>> something like "always madvise never" via
>> /sys/kernel/mm/transparent_hugepage/enabled.  I'm not sure whether it's
>> a good idea to reuse the existing interface of THP.
> 
> I wouldn't want to tie this to the existing interface, simply because that
> implies that we would want to follow the "always" and "madvise" advice too; That
> means that on a thp=madvise system (which is certainly the case for android and
> other client systems) we would have to disable large anon folios for VMAs that
> haven't explicitly opted in. That breaks the intention that this should be an
> invisible performance boost. I think it's important to set the policy for use of

It will never ever be a completely invisible performance boost, just 
like ordinary THP.

Using the exact same existing toggle is the right thing to do. If 
someone specify "never" or "madvise", then do exactly that.

It might make sense to have more modes or additional toggles, but 
"madvise=never" means no memory waste.


I remember I raised it already in the past, but you *absolutely* have to 
respect the MADV_NOHUGEPAGE flag. There is user space out there (for 
example, userfaultfd) that doesn't want the kernel to populate any 
additional page tables. So if you have to respect that already, then 
also respect MADV_HUGEPAGE, simple.

> THP separately to use of large anon folios.
> 
> I could be persuaded on the merrits of a new runtime enable/disable interface if
> there is concensus.

There would have to be very good reason for a completely separate 
control. Bypassing MADV_NOHUGEPAGE or "madvise=never" simply because we 
add a "flexible" before the THP sounds broken.

-- 
Cheers,

David / dhildenb

