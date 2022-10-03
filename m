Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6728B5F34AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJCRkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJCRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:39:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807DF165B7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BE6CB811E1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253D0C433C1;
        Mon,  3 Oct 2022 17:39:46 +0000 (UTC)
Date:   Mon, 3 Oct 2022 18:39:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YzseX7suH3t5nlT6@arm.com>
References: <YtHo3Xu33jovwpFt@google.com>
 <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com>
 <YypfJQqj8PeOp8A4@google.com>
 <Yzc2UrX7ndWw1vKI@arm.com>
 <CAHk-=wgPqauyKD9CoQg2AAtV=ygpS_fAahhgzPAe99k5Kush6A@mail.gmail.com>
 <Yzi/X12rQTuT9Uqk@arm.com>
 <CAHk-=wgNkCSQ4d6KG0Spv13rNkoF+VxaGkqLxgG3ft6j=jpA+A@mail.gmail.com>
 <CAMj1kXHQH_Z+_HKOOd8LkzwPpbMahihT89qCDkB=ofCkicoYdA@mail.gmail.com>
 <CAHk-=wjSYF=qCbzO25U+7NzysW94655FdMq9OBgY+91a60hjgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSYF=qCbzO25U+7NzysW94655FdMq9OBgY+91a60hjgg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 03:24:57PM -0700, Linus Torvalds wrote:
> On Sun, Oct 2, 2022 at 3:09 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > Non-coherent DMA for networking is going to be fun, though.
> 
> I agree that networking is likely the main performance issue, but I
> suspect 99% of the cases would come from __alloc_skb().

The problem is not the allocation but rather having a generic enough
dma_needs_bounce() check. It won't be able to tell whether some 1500
byte range is for network or for crypto code that uses a small
ARCH_KMALLOC_MINALIGN. Getting the actual object size (e.g. with
ksize()) doesn't tell the full story on how safe the DMA is.

> Similarly, that code already has magic stuff to try to be
> cacheline-aligned for accesses, but it's not really for DMA coherency
> reasons, just purely for performance reasons (trying to make sure that
> the header accesses stay in one cacheline etc).

Yeah, __skb_alloc() ends up using SMP_CACHE_BYTES for data alignment
(via SKB_DATA_ALIGN). I have a suspicion this may break on SoCs with a
128-byte cache line but I haven't seen any report yet (there aren't many
such systems).

-- 
Catalin
