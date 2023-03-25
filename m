Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10786C8BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCYGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEA14EBB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EBF060A51
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A743C433D2;
        Sat, 25 Mar 2023 06:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679726539;
        bh=ZSKNjtrK9Vf8IKEQOlIlEf2lZ5+KbHask3b4ybdxt2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaSo5cqgUt7L5RFDX4Q/ntp75zHOUp2cAwwCYA+CzEc4JY+oPnZjRY/mdPYrn8l6D
         kuk33rPdK1yq7QKmO39axfUBszPjpGqmEzSwWPc4QPkl2FP6lxYY2JDaEIvcmSShRG
         kcW8rhb6vtCSwkNxCzWOHuw2d8kKzA9nm1GQrfLBizAubSa/SDH0eW1xzAoPW4FkLx
         yn2uGjkcajAjn611jS3J1z+NbOFjYEq9f3NgpDJYYKOpIxikx+dsADu4OU9aw+hRry
         URdV4koMdn6B2PZiglxyt+g3G8t3zopGpQ2O/n+UIKflUCcvRe/heHjDMaZoSZlVsD
         PDeOLbKcRp8jQ==
Date:   Sat, 25 Mar 2023 09:42:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Hongbin Ji <jihongbin999@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Make memblock memblock_dbg info handle
 overflowing range @base + @size
Message-ID: <ZB6XvqqnGa446s5o@kernel.org>
References: <CAGeo-3e1emyUvqoQBz-v0CQQQasytb15SyhVVhiPwdheYgN=ow@mail.gmail.com>
 <ZB6O5awTbmcmqFI5@kernel.org>
 <CAGeo-3cMGSpG413=gA3NtcDyN5oTFLuZfNf8dVdVi3xQmGSWgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGeo-3cMGSpG413=gA3NtcDyN5oTFLuZfNf8dVdVi3xQmGSWgQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 02:25:58PM +0800, Hongbin Ji wrote:
> It is just to correct the information displayed by the debugging.
> The wrong information display is also a problem, but it is not a
> problem that affects the function

Please don't top post.

Wrong debugging info will be the least of the problems if memblock_add() or
membloc_remove() are called with wrong parameters.

Please work on cleanups based on code inspection outside of mm/
 
> Mike Rapoport <rppt@kernel.org> 于2023年3月25日周六 14:04写道：
> >
> > On Fri, Mar 24, 2023 at 04:15:13PM +0800, 纪宏宾 wrote:
> > > Allow memblock users to specify range where @base + @size overflows,
> > > This will cause the address range information in the debug output to
> > > be displayed incorrectly.
> >
> > Is there a real problem you are trying to solve?
> >
> > > For example, calling memblock_remove(1ULL << PHYS_MASK_SHIFT,
> > > ULLONG_MAX) in arch/arm64/mm/init.c,
> > > would be displayed as:
> > > [ 0.000000] memblock_remove: [0x0001000000000000-0x0000fffffffffffe]
> > > arm64_memblock_init+0x24/0x270
> > > but we expect the output:
> > > [ 0.000000] memblock_remove: [0x0001000000000000-0xffffffffffffffff]
> > > arm64_memblock_init+0x24/0x270
> > >
> > > Signed-off-by: Hongbin Ji <jhb_ee@163.com>
> > > ---
> > >  mm/memblock.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 25fd0626a9e7..567b99e4355d 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -700,7 +700,7 @@ static int __init_memblock
> > > memblock_add_range(struct memblock_type *type,
> > >  int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
> > >         int nid, enum memblock_flags flags)
> > >  {
> > > - phys_addr_t end = base + size - 1;
> > > + phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > >
> > >   memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
> > >        &base, &end, nid, flags, (void *)_RET_IP_);
> > > @@ -721,7 +721,7 @@ int __init_memblock memblock_add_node(phys_addr_t
> > > base, phys_addr_t size,
> > >   */
> > >  int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
> > >  {
> > > - phys_addr_t end = base + size - 1;
> > > + phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > >
> > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > >        &base, &end, (void *)_RET_IP_);
> > > @@ -822,7 +822,7 @@ static int __init_memblock
> > > memblock_remove_range(struct memblock_type *type,
> > >
> > >  int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
> > >  {
> > > - phys_addr_t end = base + size - 1;
> > > + phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > >
> > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > >        &base, &end, (void *)_RET_IP_);
> > > @@ -854,7 +854,7 @@ void __init_memblock memblock_free(void *ptr, size_t size)
> > >   */
> > >  int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
> > >  {
> > > - phys_addr_t end = base + size - 1;
> > > + phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > >
> > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > >        &base, &end, (void *)_RET_IP_);
> > > @@ -865,7 +865,7 @@ int __init_memblock memblock_phys_free(phys_addr_t
> > > base, phys_addr_t size)
> > >
> > >  int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
> > >  {
> > > - phys_addr_t end = base + size - 1;
> > > + phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > >
> > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > >        &base, &end, (void *)_RET_IP_);
> > > @@ -876,7 +876,7 @@ int __init_memblock memblock_reserve(phys_addr_t
> > > base, phys_addr_t size)
> > >  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> > >  int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
> > >  {
> > > - phys_addr_t end = base + size - 1;
> > > + phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > >
> > >   memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> > >        &base, &end, (void *)_RET_IP_);
> > > @@ -1645,7 +1645,7 @@ void __init memblock_free_late(phys_addr_t base,
> > > phys_addr_t size)
> > >  {
> > >   phys_addr_t cursor, end;
> > >
> > > - end = base + size - 1;
> > > + end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
> > >   memblock_dbg("%s: [%pa-%pa] %pS\n",
> > >        __func__, &base, &end, (void *)_RET_IP_);
> > >   kmemleak_free_part_phys(base, size);
> > > --
> > > 2.34.1
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
