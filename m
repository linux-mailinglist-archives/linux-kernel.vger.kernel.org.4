Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA338706313
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjEQIjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjEQIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45940CF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684312647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WdsMZLBHDWxr+KE0TdL6QcbjY/uUPjF0RV3EGhnsZw=;
        b=g8h+buq4ycapyIo6TDbyMgIGK0MxFUWjlSvn3GVR6z7qXvz8x0LAfm5yQ5OEFzRqtsULpg
        XknOZPB+dUAzX3cuUTFYzvP2TmITFAWdhdcH7bKVp+cXlXEzz5dNz5WFQO0+V2dHFBRTr7
        iFiRQnvdJeopIFincMLig3krI2b+lAM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-7EsEw6InNZOlB52aPk7U8g-1; Wed, 17 May 2023 04:37:25 -0400
X-MC-Unique: 7EsEw6InNZOlB52aPk7U8g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f422dc5fafso3182025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312644; x=1686904644;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WdsMZLBHDWxr+KE0TdL6QcbjY/uUPjF0RV3EGhnsZw=;
        b=ZmfK9mWeVC1m26pLdE00XbmH5lXs38SJeyr72RNlJ1NbqrUyOLrpjR33rnBXhfFl6Q
         QvGMxLTsFDrgIw0KvReAhLkYFzAnlxIXjcBfV56aeJPTE0b7KbMltjS7CH+J6Xf6K3+8
         x3Tq3cIWPWkA3kqZWwjx0FWlxFu733KmQj59ldRcaxkvw0qNh70raIBQZA4SwSLOdGRF
         2kbFJs6YtI7Q6JajqVvtW9uH8QTFYyGQgAUQFZN1vZvICwmhXrreLUST2WciC9k2inLB
         Uxb/ud12IfD0xpFcE4o0AyT7+/e8qskFdgVULWu/SoV3rhqE0AHDePC0PTWb4G8QN59f
         afKg==
X-Gm-Message-State: AC+VfDy/slJz533EcAtl/oJaWY9gCs50dRW1qfvHYXbEA/zNdsxoAHyj
        qtBTyaPfIsjVd3gw6q/Ym0/ueLcYs94XjOVuidgPX75JDakoXFbU6KlRAjRka+c2NV15y61QbGs
        Gn1tiz+D738oN8I0wVf73v68I
X-Received: by 2002:a1c:c917:0:b0:3f5:e88:3c47 with SMTP id f23-20020a1cc917000000b003f50e883c47mr4936713wmb.16.1684312644149;
        Wed, 17 May 2023 01:37:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5seF8sdv4aMaOlfOfXp3k6cNnu+uya6/Hj+LErqDQsaKaN6SKX7/RsdZpo0rj3XBuvVgPmIg==
X-Received: by 2002:a1c:c917:0:b0:3f5:e88:3c47 with SMTP id f23-20020a1cc917000000b003f50e883c47mr4936689wmb.16.1684312643761;
        Wed, 17 May 2023 01:37:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d6983000000b0030795b2be15sm1962333wru.103.2023.05.17.01.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:37:23 -0700 (PDT)
Message-ID: <12704c8f-6727-62ec-d48b-31246755dbdd@redhat.com>
Date:   Wed, 17 May 2023 10:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/3] mm: Call arch_swap_restore() from do_swap_page()
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
References: <20230517022115.3033604-1-pcc@google.com>
 <20230517022115.3033604-2-pcc@google.com>
 <87353v7hh1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87353v7hh1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.23 05:40, Huang, Ying wrote:
> Peter Collingbourne <pcc@google.com> writes:
> 
>> Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
>> the call to swap_free() before the call to set_pte_at(), which meant that
>> the MTE tags could end up being freed before set_pte_at() had a chance
>> to restore them. Fix it by adding a call to the arch_swap_restore() hook
>> before the call to swap_free().
>>
>> Signed-off-by: Peter Collingbourne <pcc@google.com>
>> Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
>> Cc: <stable@vger.kernel.org> # 6.1
>> Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
>> Reported-by: Qun-wei Lin (林群崴) <Qun-wei.Lin@mediatek.com>
>> Closes: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/
>> ---
>> v2:
>> - Call arch_swap_restore() directly instead of via arch_do_swap_page()
>>
>>   mm/memory.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index f69fbc251198..fc25764016b3 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3932,6 +3932,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Some architectures may have to restore extra metadata to the page
>> +	 * when reading from swap. This metadata may be indexed by swap entry
>> +	 * so this must be called before swap_free().
>> +	 */
>> +	arch_swap_restore(entry, folio);
>> +
>>   	/*
>>   	 * Remove the swap entry and conditionally try to free up the swapcache.
>>   	 * We're already holding a reference on the page but haven't mapped it
> 
> Should you add
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> 
> for 1/3 and 2/3.

For 1/3, I think I rather only explained the problem in the first patch 
and didn't really suggest this.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

