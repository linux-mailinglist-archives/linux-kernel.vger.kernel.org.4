Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9843D6E2671
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDNPIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDNPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:08:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4572AB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:07:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE28F21998;
        Fri, 14 Apr 2023 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681484874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Lw5y1Ohxl8cFOKOdx2RWPNSRtZicRkZCTHDZWK77uU=;
        b=o8vMFzsEPCV7DCQt5MNgSxAAUXr71RTdqNu/MeD37uT/vT3olPz52ihUC4exsz5KBaRfns
        qRJA4LrZBCZ05OdOpeDHRGNHszrTF84/Mct+aswdSFPHlAyV/Q4JFZEIzbw1u8RkilA/8o
        eHXnei60MwV6BGV8H5m15L7CgZJoZTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681484874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Lw5y1Ohxl8cFOKOdx2RWPNSRtZicRkZCTHDZWK77uU=;
        b=of02Ek1JjsWzbfTiGtOaWzLZm8ptdB760P+Cy5XudoZmaZKv4l8fWZl6PffmCg3Bmv530s
        vDfHfvbVewu0lgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDADA13498;
        Fri, 14 Apr 2023 15:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q7eMLUpsOWS9OgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Apr 2023 15:07:54 +0000
Message-ID: <e9ac9692-c126-f78f-a6a2-a88eb986ccb7@suse.cz>
Date:   Fri, 14 Apr 2023 17:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
 <94bfa3cc-674e-25b0-e7e2-d74c970acef7@redhat.com>
 <ac8bb4e9-e7f5-f9da-bca0-ac7ef6d68c23@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ac8bb4e9-e7f5-f9da-bca0-ac7ef6d68c23@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 14:16, Baolin Wang wrote:
> 
> 
> On 4/12/2023 7:25 PM, David Hildenbrand wrote:
>> On 12.04.23 12:45, Baolin Wang wrote:
>>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
>>> which checks whether the given zone contains holes, and uses pfn_valid()
>>> to check if the end pfn is valid. However pfn_valid() can not make sure
>>> the end pfn is not a hole if the size of a pageblock is larger than the
>>> size of a sub-mem_section, since the struct page getting by pfn_to_page()
>>> may represent a hole or an unusable page frame, which may cause incorrect
>>> zone contiguous is set.
>>>
>>> Though another user of pageblock_pfn_to_page() in compaction seems work
>>> well now, it is better to avoid scanning or touching these offline pfns.
>>> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
>>> populated to have holes"), we should also use pfn_to_online_page() for
>>> the end pfn to make sure it is a valid pfn with usable page frame.
>>> Meanwhile the pfn_valid() for end pfn can be dropped now.
>>>
>>> Moreover we've already used pfn_to_online_page() for start pfn to make
>>> sure it is online and valid, so the pfn_valid() for the start pfn is
>>> unnecessary, drop it.
>> 
>> pageblocks are supposed to fall into a single memory section, so in mos > cases, if the start is online, so is the end.
> 
> Yes, the granularity of memory hotplug is a mem_section.
> 
> However, suppose the pageblock order is MAX_ORDER-1, and the size of a 
> sub-section is 2M, that means a pageblock will fall into 2 sub 
> mem-section, and if there is a hole in the zone, that means the 2nd sub 
> mem-section can be invalid without setting subsection_map bitmap.

Can that really happen? I think the buddy merging in __free_one_page() would
trip on that?


