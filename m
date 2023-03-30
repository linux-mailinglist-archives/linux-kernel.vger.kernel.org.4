Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8E6D0CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjC3RgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjC3RgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27C6A47
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7658662150
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D232BC433EF;
        Thu, 30 Mar 2023 17:36:10 +0000 (UTC)
Date:   Thu, 30 Mar 2023 18:36:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Usersapce MTE error with allocation tag 0 when low on
 memory
Message-ID: <ZCXIiCtjFt19wBAM@arm.com>
References: <5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com>
 <ZCRtVW9Q0WOKEQVX@arm.com>
 <f468f934-40b6-3547-d3ea-88a0aac5bd6a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f468f934-40b6-3547-d3ea-88a0aac5bd6a@arm.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 02:56:50PM +0100, Steven Price wrote:
> > On Wed, Mar 29, 2023 at 02:55:49AM +0000, Qun-wei Lin (林群崴) wrote:
> >> Having compared the differences between Kernel-5.15 and Kernel-6.1,
> >> We found the order of swap_free() and set_pte_at() is changed in
> >> do_swap_page().
> >>
> >> When fault in, do_swap_page() will call swap_free() first:
> >> do_swap_page() -> swap_free() -> __swap_entry_free() ->
> >> free_swap_slot() -> swapcache_free_entries() -> swap_entry_free() ->
> >> swap_range_free() -> arch_swap_invalidate_page() ->
> >> mte_invalidate_tags_area() ->  mte_invalidate_tags() -> xa_erase()
> >>
> >> and then call set_pte_at():
> >> do_swap_page() -> set_pte_at() -> __set_pte_at() -> mte_sync_tags() ->
> >> mte_sync_page_tags() -> mte_restore_tags() -> xa_load()
> >>
> >> This means that the swap slot is invalidated before pte mapping, and
> >> this will cause the mte tag in XArray to be released before tag
> >> restore.
> 
> This analysis looks correct to me. The MTE swap code works on the
> assumption that the set_pte_at() will restore the tags to the page
> before the swap entry is removed. The reordering which has happened
> since has broken this assumption and as you observed can cause the tags
> to be unavailable by the time set_pte_at() is called.
> 
> >> After I moved swap_free() to the next line of set_pte_at(), the problem
> >> is disappeared.
> >>
> >> We suspect that the following patches, which have changed the order, do
> >> not consider the mte tag restoring in page fault flow:
> >> https://lore.kernel.org/all/20220131162940.210846-5-david@redhat.com/
> 
> I'm not sure I entirely follow the reasoning in this patch, so I'm not
> sure whether it's safe to just move swap_free() down to below
> set_pte_at() or if that reintroduces the information leak.
> 
> I also wonder if sparc has a similar issue as the arch_do_swap()
> callback is located next to set_pte_at().

SPARC has a potential race here since the page is made visible to the
user but the tags are not restored yet (I raised this before). But even
ignoring this small window, arch_do_swap() needs to have the metadata
available.

> >> Any suggestion is appreciated.
> 
> The other possibility is to add a(nother) callback for MTE in
> arch_do_swap() that calls mte_restore_tags() on the page before the
> swap_free() call rather than depending on the hook in set_pte_at().

I think we should move arch_do_swap_page() earlier before swap_free()
and in arm64 we copy the tags to pte_page(pte). I don't think SPARC
would have any issues with this change (and it also fixes their race).

-- 
Catalin
