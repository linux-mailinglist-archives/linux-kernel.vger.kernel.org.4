Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA6B6D076C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjC3N5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjC3N5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:57:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C91F27EED
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC2632F4;
        Thu, 30 Mar 2023 06:57:38 -0700 (PDT)
Received: from [10.1.35.23] (e122027.cambridge.arm.com [10.1.35.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F77F3F663;
        Thu, 30 Mar 2023 06:56:52 -0700 (PDT)
Message-ID: <f468f934-40b6-3547-d3ea-88a0aac5bd6a@arm.com>
Date:   Thu, 30 Mar 2023 14:56:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] Usersapce MTE error with allocation tag 0 when low on
 memory
To:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com>
 <ZCRtVW9Q0WOKEQVX@arm.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <ZCRtVW9Q0WOKEQVX@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 17:54, Catalin Marinas wrote:
> + Steven Price who added the MTE swap support.
> 
> On Wed, Mar 29, 2023 at 02:55:49AM +0000, Qun-wei Lin (林群崴) wrote:

<snip>

>>
>> Having compared the differences between Kernel-5.15 and Kernel-6.1,
>> We found the order of swap_free() and set_pte_at() is changed in
>> do_swap_page().
>>
>> When fault in, do_swap_page() will call swap_free() first:
>> do_swap_page() -> swap_free() -> __swap_entry_free() ->
>> free_swap_slot() -> swapcache_free_entries() -> swap_entry_free() ->
>> swap_range_free() -> arch_swap_invalidate_page() ->
>> mte_invalidate_tags_area() ->  mte_invalidate_tags() -> xa_erase()
>>
>> and then call set_pte_at():
>> do_swap_page() -> set_pte_at() -> __set_pte_at() -> mte_sync_tags() ->
>> mte_sync_page_tags() -> mte_restore_tags() -> xa_load()
>>
>> This means that the swap slot is invalidated before pte mapping, and
>> this will cause the mte tag in XArray to be released before tag
>> restore.

This analysis looks correct to me. The MTE swap code works on the
assumption that the set_pte_at() will restore the tags to the page
before the swap entry is removed. The reordering which has happened
since has broken this assumption and as you observed can cause the tags
to be unavailable by the time set_pte_at() is called.

>> After I moved swap_free() to the next line of set_pte_at(), the problem
>> is disappeared.
>>
>> We suspect that the following patches, which have changed the order, do
>> not consider the mte tag restoring in page fault flow:
>> https://lore.kernel.org/all/20220131162940.210846-5-david@redhat.com/

I'm not sure I entirely follow the reasoning in this patch, so I'm not
sure whether it's safe to just move swap_free() down to below
set_pte_at() or if that reintroduces the information leak.

I also wonder if sparc has a similar issue as the arch_do_swap()
callback is located next to set_pte_at().

>> Any suggestion is appreciated.

The other possibility is to add a(nother) callback for MTE in
arch_do_swap() that calls mte_restore_tags() on the page before the
swap_free() call rather than depending on the hook in set_pte_at().

Steve

