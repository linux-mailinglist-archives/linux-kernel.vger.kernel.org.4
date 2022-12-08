Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C46646AD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLHInT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiLHImw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFBA61BA5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670488908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUElgt1lp4nGY3sTMyIIkCMUOHZcBXcdQIFg7HKHvUg=;
        b=PKGipOrdf+rNTCIOexfLtTijuzkjKyYLamJ/TGGrbRHWSwti2c0XaNaPTYc76IWJgtEQvn
        YaRYyyUPtqxxofJvnzbx24VL0wM7BtYyyvCC2qgIpAAu0svR0rTNTRRCcL7rx8s/pBVdB2
        e6qE2i71KVc0bVzh81zvQ1sQbR33vco=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-OeUmAbX2PDiYytQsHX3VZA-1; Thu, 08 Dec 2022 03:41:46 -0500
X-MC-Unique: OeUmAbX2PDiYytQsHX3VZA-1
Received: by mail-wm1-f69.google.com with SMTP id c187-20020a1c35c4000000b003cfee3c91cdso488180wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUElgt1lp4nGY3sTMyIIkCMUOHZcBXcdQIFg7HKHvUg=;
        b=ZB1ltSVht3jKb1iIt+XP89ECD4Glqp31zOcIIugURRg4k51QvrixHn/X1GnNGf1lvf
         xNxR5c4rIhC0LMpXyJG0Yi7axTUyRB2AOTkINWg3YUDeXCUbwb3Mr8M+XKlUGuMMaUSh
         2yKHMpLctAgTuNU2iVfYCJHKbDhavOCjaceilO+UWZzhSKJcVN+/NdgnszlK1uFGyCzD
         tC3LbwhT2ZN41JyQN/FHa8fkmY5bX/QVvTHpLAh2LgI7tjYckS12PvLB71KKbFrT/qu8
         Waaf0EmpJZuV1QSoXRSse/Rrsds77j+GHwXC4WWdBWK5uYuNwHfnNIV39qI+VkziXlpq
         IAnQ==
X-Gm-Message-State: ANoB5pkKO22auaSAoAUIB5VVkLYMBg5yYKnv3Q8vkOxo/XhLaupYBJxo
        s+mrEOtPXUtzyepwes/DwLWmhM14OqpFF48cn9aNVYOZxZD2rSfoLFdgkU/n7x/iOaJoZA0DrUG
        NiB1Z1G1gfftCy7FL4h9TqqDg
X-Received: by 2002:adf:dbcd:0:b0:242:1294:5174 with SMTP id e13-20020adfdbcd000000b0024212945174mr30087114wrj.249.1670488905414;
        Thu, 08 Dec 2022 00:41:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6AXinO8jvwIeLd86MpEyy2fCHsv8sw9X6QpQm+7NAbamPG02zau6AYIEprMxYwXnYwE+cF8g==
X-Received: by 2002:adf:dbcd:0:b0:242:1294:5174 with SMTP id e13-20020adfdbcd000000b0024212945174mr30087105wrj.249.1670488905092;
        Thu, 08 Dec 2022 00:41:45 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id e14-20020adff34e000000b0024228b0b932sm26387172wrp.27.2022.12.08.00.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:41:44 -0800 (PST)
Message-ID: <bc50265a-d657-c23b-9cfd-3928f3324906@redhat.com>
Date:   Thu, 8 Dec 2022 09:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] mm/swap: fix SWP_PFN_BITS with
 CONFIG_PHYS_ADDR_T_64BIT on 32bit
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221206105737.69478-1-david@redhat.com>
 <CAHbLzkra0mjn4utzYPNp+-e77W3tb6yJiJMhkK9Kg=Ra_3rQnQ@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzkra0mjn4utzYPNp+-e77W3tb6yJiJMhkK9Kg=Ra_3rQnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.22 23:40, Yang Shi wrote:
> On Tue, Dec 6, 2022 at 2:57 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> We use "unsigned long" to store a PFN in the kernel and phys_addr_t to
>> store a physical address.
>>
>> On a 64bit system, both are 64bit wide. However, on a 32bit system, the
>> latter might be 64bit wide. This is, for example, the case on x86 with
>> PAE: phys_addr_t and PTEs are 64bit wide, while "unsigned long" only
>> spans 32bit.
>>
>> The current definition of SWP_PFN_BITS without MAX_PHYSMEM_BITS misses
>> that case, and assumes that the maximum PFN is limited by an 32bit
>> phys_addr_t. This implies, that SWP_PFN_BITS will currently only be able to
>> cover 4 GiB - 1 on any 32bit system with 4k page size, which is wrong.
> 
> Thanks for debugging this. IIUC this means even swap is actually
> broken on x86_32 + PAE?

I saw all different kinds of issues while testing debugging without this 
patch, but they might just be a fallout from previous page migration/THP 
splitting issues.

I think swap should be fine, because SWP_PFN_BITS only affects 
swp_offset_pfn(): only used when is_pfn_swap_entry()==true.

Thanks!

-- 
Thanks,

David / dhildenb

