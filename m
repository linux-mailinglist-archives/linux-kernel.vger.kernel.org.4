Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3901F730F30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbjFOGVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjFOGU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583281FC2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E87AC61828
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CEEC433C8;
        Thu, 15 Jun 2023 06:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686810056;
        bh=/xe5fXDbmZSA8RTDGVuJ8oboo42pBGKbqRuzSjdPzrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrTBDU5g2Y8d6nsdUviSygWgM5bR7b0ZT48EWFiHCuLL4sQdJhw315HWh9L1etYCF
         yEffsKatan84SMW9biQKRqE5Z1IoFj4p4RJwxFAABS2RdP/t9lt4IcOihgBOou15Yn
         F7DWPSUVE1D0NrwzWXk9+mdyg7ziSTkq1TIeuPiE4c8gc2q7z4g1sKolR8JZ6C688z
         29804wP2OVKhMQtFlYiBsBVKf1AR+4Mi9FJRtP2G4CNjtm+YJQIXFHEmge1AGSiMKY
         naOY7N4RXv0w3wQ29Aa/OWDJCOMRzarj/nBvJy5BtympJiqYZNTT37xmbuizAicET+
         wPZX+TV+V5diw==
Date:   Thu, 15 Jun 2023 09:20:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/mm_init.c: remove spinlock in early_pfn_to_nid()
Message-ID: <20230615062021.GI52412@kernel.org>
References: <20230614115339.GX52412@kernel.org>
 <2023061431-litigate-upchuck-7ed1@gregkh>
 <20230614110324.3839354-1-yajun.deng@linux.dev>
 <ab067588892217b6ee6ce759bd569b12@linux.dev>
 <a96c998f9d73f03c85463d7314f6ea8a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a96c998f9d73f03c85463d7314f6ea8a@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 03:02:58AM +0000, Yajun Deng wrote:
> June 14, 2023 7:53 PM, "Mike Rapoport" <rppt@kernel.org> wrote:
> 
> > Hi,
> > 
> > On Wed, Jun 14, 2023 at 11:28:32AM +0000, Yajun Deng wrote:
> > 
> >> June 14, 2023 7:09 PM, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >> 
> >> On Wed, Jun 14, 2023 at 07:03:24PM +0800, Yajun Deng wrote:
> >> 
> >> When the system boots, only one cpu is enabled before smp_init().
> >> So the spinlock is not needed in most cases, remove it.
> >> 
> >> Add spinlock in get_nid_for_pfn() because it is after smp_init().
> >> 
> >> So this is two different things at once in the same patch?
> >> 
> >> Or are they the same problem and both need to go in to solve it?
> >> 
> >> And if a spinlock is not needed at early boot, is it really causing any
> >> problems?
> >> 
> >> They are the same problem.
> >> I added pr_info in early_pfn_to_nid(), found get_nid_for_pfn() is the only
> >> case need to add spinlock.
> >> This patch tested on my x86 system.
> > 
> > Are you sure it'll work on !x86?
> >
> 
> I'm probably sure of that, although I don't have a !x86 machine.
> 
> early_pfn_to_nid() is called in smp_init() and kasan_init() on 
> different architectures. If it works well on x86, it'll work on
> !x86.

This is often not true. Please verify that other architectures do not call
early_pfn_to_nid() after smp_init(). The explanation why it is safe should
be a part of the changelog.

> >> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >> ---
> >> drivers/base/node.c | 11 +++++++++--
> >> mm/mm_init.c | 18 +++---------------
> >> 2 files changed, 12 insertions(+), 17 deletions(-)
> >> 
> >> diff --git a/drivers/base/node.c b/drivers/base/node.c
> >> index 9de524e56307..844102570ff2 100644
> >> --- a/drivers/base/node.c
> >> +++ b/drivers/base/node.c
> >> @@ -748,8 +748,15 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
> >> static int __ref get_nid_for_pfn(unsigned long pfn)
> >> {
> >> #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >> - if (system_state < SYSTEM_RUNNING)
> >> - return early_pfn_to_nid(pfn);
> >> + static DEFINE_SPINLOCK(early_pfn_lock);
> >> + int nid;
> >> +
> >> + if (system_state < SYSTEM_RUNNING) {
> >> + spin_lock(&early_pfn_lock);
> >> + nid = early_pfn_to_nid(pfn);
> >> + spin_unlock(&early_pfn_lock);
> >> 
> >> Adding an external lock for when you call a function is VERY dangerous
> >> as you did not document this anywhere, and there's no way to enforce it
> >> properly at all.
> >> 
> >> I should add a comment before early_pfn_to_nid().
> >> 
> >> Does your change actually result in any boot time changes? How was this
> >> tested?
> >> 
> >> Just a bit.
> > 
> > Just a bit tested? Or just a bit of boot time changes?
> > For the latter, do you have numbers?
> > 
> 
> For the latter, the most beneficial function is memmap_init_reserved_pages(),
> the boot time changes depending on whether DEFERRED_STRUCT_PAGE_INIT
> is defined or not. 
> 
> -->memmap_init_reserved_pages()
>    -->for_each_reserved_mem_range()
>       reserve_bootmem_region()
>       -->for()
>          init_reserved_page()
>          --> early_pfn_to_nid()
 
A better solution would be to pass nid to reserve_bootmem_range() and drop
the call to early_pfn_to_nid() in init_reserved_page(). 

Then there won't be lock contention and no need for fragile changes in the
locking.

> If define CONFIG_DEFERRED_STRUCT_PAGE_INIT:
> 
> before:
> memmap_init_reserved_pages()   1.87 seconds
> after:
> memmap_init_reserved_pages()   1.27 seconds
> 
> 32% time reduction.

These measurements should be part of the changelog. 
 
> If not define CONFIG_DEFERRED_STRUCT_PAGE_INIT:
> 
> early_pfn_to_nid() is called by few, 
> boot time didn't change.
> 
> 
> By the way, this machine has 190GB RAM.
> 
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
