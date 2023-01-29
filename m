Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4537568015D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 21:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjA2UuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 15:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2UuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 15:50:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C11BAC9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 12:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F371FB80DBD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D0BC433D2;
        Sun, 29 Jan 2023 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675025415;
        bh=q2/HBKoBXD27IsM9BwIx6UYtt4IZ81bwAZpNuwPW1mI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eq4biyfZVG2QI1zTo6yR+B4/q9iceaRN8JW4pzEX1aWvzA9v0v93OX7XiXRPwHIch
         7UnnHGIio06rN1J1vtBXb2atgLTMw8bmHBR5gKOjOOZ12vyB5QelI/0NH+RKPkfJQi
         cEyu9qHj1+CFd0zft2mv0CvFKXIbOYoJx+H6MNPk=
Date:   Sun, 29 Jan 2023 12:50:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Subject: Re: Failure during Stack Depot allocating hash table of 1048576
 entries with kvcalloc
Message-Id: <20230129125014.fcd459335c9b8eae71067c1a@linux-foundation.org>
In-Reply-To: <Y9UweHxSfPiAqgZx@zn.tnic>
References: <Y8Fq5m0CLfcFLCOY@zn.tnic>
        <07e42002-e78d-7947-19a7-0dd035466f50@alu.unizg.hr>
        <Y9UBFNwBeuePPsk3@zn.tnic>
        <d4871e70-c7c9-e638-d7c0-304ec8aea77b@leemhuis.info>
        <Y9UweHxSfPiAqgZx@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2023 15:26:00 +0100 Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Jan 28, 2023 at 02:55:58PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> > On 28.01.23 12:03, Borislav Petkov wrote:
> > > On Sat, Jan 28, 2023 at 03:41:50AM +0100, Mirsad Goran Todorovac wrote:
> > >> This appears to be a duplicate of the report:
> > >> https://lore.kernel.org/linux-mm/2c677d85-820c-d41a-fc98-7d3974b49e42@alu.unizg.hr/raw
> > > 
> > > Yah, looks like
> > > 
> > > 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
> > > 
> > > needs to be reverted.
> > 
> > Unless I'm missing something (which might easily be the case) there is a
> > patch for that issue in -mm already:
> > 
> > https://lore.kernel.org/all/20230119224022.80752C433F0@smtp.kernel.org/
> > 
> > Or where two different issues discussed in the thread Mirsad mentioned
> > above?
> 
> Probably the same issue. This one fixes the issue on my machine - thanks!
> 
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
> 

OK, thanks, I didn't realize this issue was so serious.

I reordered Zhaoyang Huang's series so that "mm: use
stack_depot_early_init for kmemleak" comes ahead of "mm: move
KMEMLEAK's Kconfig items from lib to mm" and I've staged "mm: use
stack_depot_early_init for kmemleak" in the mm-hotfixes branch for
upstream merging in this -rc cycle.

